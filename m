Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1424C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658B6214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aDleOKAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658B6214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeIZJxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34442 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so7724828lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fZfylE7F3bNR7i0Rffff5BaBK31cf0Cs+F0ng1xVDA=;
        b=aDleOKAvULwvH78HUwClTmnSvRfroK0X3LclLraTO9JnzpF52qQNalV6J9Ek1ZRnLP
         ByckZhS7VTQrbyzGTxfux3DMNqRq07DjzvquyjlZzVFvtIgBlcN53uQbWI554de3VLAU
         aocPSZ6rrYzzzpmF5dy0uec/aCG9hsiEyno4FIINW7RTxoXOrb6UakKsdv4g6rvdpbIV
         C+PsMeTVOt5vT+9tG33tLC3K24REkzA58jlj60CPRXUZb3yvq87CqTxgJwB6hmlMsxqb
         xrI9nw2LPYiawfMnIs2T77KMmIGbndaX9Qyf/pPQb4j6HES/yHPOPiIQ/6u7dVcZNQR+
         s2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fZfylE7F3bNR7i0Rffff5BaBK31cf0Cs+F0ng1xVDA=;
        b=uY02AT2Yn1WO2D43mKDaJbQQZTMt8GLPl/5ap0KzScHT2HccwLcf4s9JY1y7B+J2Wh
         yn0vb9O68HmGyiyoiv8bK6cDPN5p6PUPM3RFupPZvuFPim0VqpcFRKETVm+0kokY6OSx
         Z5R1IyKUKgPtHxCi+VjYBXBPx2g4Ej6XWqaYvj1BQS9JZCXZct1g/WKhoA83DWz3szc+
         JazM3Q5FqC5H9acjOjFCifi7tAC4CHB1/IZzKaYKKA0yTx9zmZdTNJR52X14rsXdXxAI
         xzi8PUyh3UJ9usyJJpG50By9eXkCjBzGzBgpcap+8SjyJJySUEVg9oXJBX1LINz19Y/z
         IAGg==
X-Gm-Message-State: ABuFfoioH46AxkelZ4mWq2Uhcws8Wlo8KCqmNe0KkdS2koiLOS/ZRaLx
        KSOfoRpSMzDCZ+mQj+XLCxXRSg==
X-Google-Smtp-Source: ACcGV61xxraGFqQeuM6+TX9wnV1F1hq9v/x6uqsP+m1P6Kyg8qMPsL/3EptdxVYOI+m2Xf/5wuj28g==
X-Received: by 2002:a19:9a0e:: with SMTP id c14-v6mr2630878lfe.11.1537933341769;
        Tue, 25 Sep 2018 20:42:21 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d1-v6sm741321lfb.90.2018.09.25.20.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:20 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:38:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: SoC for 4.20
Message-ID: <20180925203812.z7jo32d5aebwh7e2@localhost>
References: <20180925103735.GA31525@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925103735.GA31525@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:37:35PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Most changes are shuffling around the maintainers entries. There are
> also two PM non urgent fixes.
> 
> This one as a trivial conflict with the staging tree solved in linux-next.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-soc
> 
> for you to fetch changes up to 34d2a7db77ad837cfb88bd01b33fd1f3855ce9c0:
> 
>   MAINTAINERS: sdhci: move the Microchip entry to proper location (2018-09-25 12:26:31 +0200)
> 
> ----------------------------------------------------------------
> AT91 SoC for 4.20
> 
>  - rename MAINTAINERS entries and change maintainers
>  - two pm cleanups

Merged, thanks.  Welcome aboard as maintainer, Ludovic!


-Olof
