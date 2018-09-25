Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD82C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1C2214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gUM9D5Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1C2214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeIZJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35781 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so9418424lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6AN2LMS/QaKEtXkrR1Ktqne9jm7gn1dI/IUUJqTQrAo=;
        b=gUM9D5Qb87iG1Hw8mlyc7Sq278qoN8wQh2cDXDGIAPxRyUUlwq9JNUXqwPcNEVF9kp
         k2fio4HbNMdPWqWq1JfYgfBNJLRuR1oIdsReWfPhwdgyHqa6UB+FrX2M54HAFDNf5nVE
         DacP9fi/XWLzpTpozyUv9B4yiAJ1SrgQusKbkJjNEjAyhgAVoa5S+oCPGj0fGRockYOl
         ogUiumqiCcblIlWJAS/Ceod5LOklObihv3y1zBCbpD3sooQ78aYsJTZZPVzGx0Fga5OL
         tP3kk1thq2V3zneNyFJbf8tnYg2h0ftnqXkLdP681NtWVUMFqgGWWeS9gxkydlx2OeNR
         9GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6AN2LMS/QaKEtXkrR1Ktqne9jm7gn1dI/IUUJqTQrAo=;
        b=QtJhPteklJ3vcA2lg2WiZwRR3HeYofeMogYU9Dp5hmX6uhHTVahlI+BO4gIyqV5Sv4
         xyiiynzdxbIg1YUpMFW7HviP6caM87mnGjxNIqW+465Ly0xsrWneeKr+ygRIYZIYDDwf
         VQIPV5aCwj3aVbgh42Pg5tkjd1EoY/gb70Ema5UUOSElq7XatQjmWC1qrg6Tg+EppfO/
         Xl5ztavP61ktTYo8aniv9K4fbblmiz7hZTvDsHspBcSBtkNbVu1dBQ7SYedVdDZgcVu1
         Z0Wfm2BqtP0g20aD1avTNR3wmMfpVKvrrC4HV93vjnFch14nuYKSIzU2M9cX+egehdky
         ct3w==
X-Gm-Message-State: ABuFfogSvxK+bcv161dTk7Z58SZZUCVhC++WeKXqmjeNNNb5znjCc9C0
        1MSug+oWEWnpR8fgGtYwv90Bhg==
X-Google-Smtp-Source: ACcGV60BPthz3wTaOv/awtel/JEhDRU7uL9j6sFN93ADKI7/9OhYYrejx6Gs891E+P0twfhbYsPLKw==
X-Received: by 2002:a19:1709:: with SMTP id n9-v6mr2865189lfi.74.1537933339284;
        Tue, 25 Sep 2018 20:42:19 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g79-v6sm730104ljf.5.2018.09.25.20.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:17 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:32:08 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: drivers for 4.20
Message-ID: <20180925203208.qbvomx7ng7xffbth@localhost>
References: <20180925102358.GA30243@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925102358.GA30243@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:23:58PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> A single trivial patch for at91 drivers.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-drivers
> 
> for you to fetch changes up to f62df676d7f16580fa5085a8f51a1cbe27f7dd10:
> 
>   memory: atmel-ebi: Use struct_size() in devm_kzalloc() (2018-08-27 23:10:31 +0200)
> 
> ----------------------------------------------------------------
> AT91 drivers for 4.20
> 
>  - use struct_size in atmel-ebi

Merged, thanks!


-Olof
