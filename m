Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A1A2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ru3t1eBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A1A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIZJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39369 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeIZJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id w21-v6so7940983lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/SqmP296l/mUoc4CcD2JDYJhdoIMZCTqbIyUTwlL2vo=;
        b=ru3t1eBwH2Jlqb0Fx688IoNRdVy6bswug2Db4kYL/5Fter+6d07vGWRxgwjkC3Y454
         vA/Anvcmjnka6mD04KKfWii2ap8JSCd2JQBu4AzRWdNQeGjnY59R6BPmGPENR580UeTj
         Qx/pFl+QJ1Nph3XYaltNrN16ecrMsxlUyjBJsJa9o2BwPO2UGwPfPhozS1ef8oKYf6+u
         t6tpFW61Z+l6FbxmzB6Tg4S+pNkfV7fvgMImoJ8BvwXVaszk84QNrTLAGibyVCC5alsL
         5grqtWv9bwjtz6MKJKttwY1IVdGEHe0FqAsJ+tnM7Dw1FNb34t0VeCXeisycZdnGOVLW
         sZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/SqmP296l/mUoc4CcD2JDYJhdoIMZCTqbIyUTwlL2vo=;
        b=A2Bk+uc+MSyxTa0uZQuZomYQgJdhOo+JRaFVmnceFvjAEPa+0hnrpvwWVm6eM3WtOy
         gDxaPDtUPy4aI7gpELU+LhGRNFnEC1dZmTFbITEIqZoPbTzB4SDU2VvwB7MbN+cb+RRy
         7mpA16bkNKIIJpO0h0PtjRhmSjzxfM9f45dpGagep/gMJ856DVgmG1eyoECPIGBO+lzh
         jNwFLk4kUpWwQwK9d2w7leUuMtNIyt0F8/crocjKtziMdtAlJzj7yxLmG+lfbQi8RXOE
         3LPBKUa+0J0nOctFO+gLItAbKIRAw3JBpllkZRNxCuHqHlkKhfMEFugjg6TQPhmJfelm
         Vqjw==
X-Gm-Message-State: ABuFfoiYhL0WrVpQ1KOq/sw4tbnfPoB2+k0cMab02KyivRrD5YsqQ6QG
        4wqeAuUTag1YnHjzDyN9e99OeQ==
X-Google-Smtp-Source: ACcGV6122PpTZWF8BvOy1lQ2vU/yzO2wfeZc/pvoQ9k5W+UGlN3bGfkftofeCmha9kjVPeJsrAW36A==
X-Received: by 2002:a19:5a8f:: with SMTP id y15-v6mr2895078lfk.15.1537933356419;
        Tue, 25 Sep 2018 20:42:36 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f18-v6sm717613lja.85.2018.09.25.20.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:34 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:53:38 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: defconfig for 4.20
Message-ID: <20180925205338.ljchudvxe4jo6chh@localhost>
References: <20180925105344.GA32532@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925105344.GA32532@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:53:44PM +0200, Alexandre Belloni wrote:
> Arnd, Olof
> 
> The addition of the generic ADC touchscreen driver can probably benefit
> other architectures. Also add the sama5 I2S driver.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-defconfig
> 
> for you to fetch changes up to 4eb2534057b1b01014a2b2bb6898d9934d2ba831:
> 
>   ARM: multi_v7_defconfig: add Atmel I2S driver (2018-08-30 22:19:32 +0200)
> 

Merged, thanks!


-Olof
