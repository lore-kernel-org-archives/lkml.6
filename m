Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B1C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0C9xjJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B1C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJPT0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:26:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41356 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:25:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so25152103qtl.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFgcHTi3iDuk1hrzjgQiMH2q3iaZ3sEZLEA+ZtLn/RM=;
        b=h0C9xjJdpiTcwldudkkH0ZuDU7tPu1DrB23viOggQnnh50t/ZpV+AkiX5Brd9w9bRT
         OOZYoCHsKm6QfqgoP5K41pguMoN+T5H3K4/t+bCzOfH4CrcpvWLedcTYJR3ghv7TpX1v
         6utfN02Zf21V9KqyB8+5tJ8is6TpJrYifvK60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFgcHTi3iDuk1hrzjgQiMH2q3iaZ3sEZLEA+ZtLn/RM=;
        b=T0CL2nLon3HlsX9URh3MJClDaWd1lhqw2Tnf7+RNEAjguW6sTJqCIZ2wibKsBbjRsv
         bLdveFs+vlMITFmzIQfi69dSl2FFtFaxXLoJya5Z3Gxuw7kZ4tqR3vsP+D++Z8v4ZKaG
         isLhjK1asET8pl6/myUdtbCBDqxiexzvndEDVLlzj85UGUA1zDmkuFXA8dZZ+9/AL9uf
         GyPma3Zshoqh3/iAF9LoIVkWAgGcL7yFrdQWuFtpRh6tXw3hzx5CNudTdsubIGNSKBZE
         GWwu6mk8tH5j6WQcqH5j+qLhw+/Gj+doshdDqCY80QJVsyKDBUiq+9kiDGct1CbMOC+P
         cWnA==
X-Gm-Message-State: ABuFfoisYwdBLlAYG+K/eK2IkyDK39uO3bbhOYBjhT3SN+xnvZ9bB0De
        wQfTvurJ2b6xLaYZIH5tCV2yN+GUnFpM1g/CYMg4/w==
X-Google-Smtp-Source: ACcGV621u80rcTkDhytSB6yhK/Hr1oQAvE3qveoi//p4S6qvnc2NplcM3ksf8bqWUtPAU/BtSR+d0LbYKetDH/AQp3o=
X-Received: by 2002:a0c:eb42:: with SMTP id c2mr21208841qvq.105.1539689757635;
 Tue, 16 Oct 2018 04:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
In-Reply-To: <20181016084416.GF30658@n2100.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 13:35:44 +0200
Message-ID: <CACRpkdavnYDE42GOwsVqnLwqjVmLmkwJ=sQBjUFn=aFbqXqVPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands list
To:     Russell King <linux@armlinux.org.uk>
Cc:     Stefan Agner <stefan@agner.ch>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Nicolas Pitre <nico@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Yeryomin <roman@advem.lv>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:44 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:

> > I am on deep waters with ARM assembly, admittedly. So I wanted to
> > ask: OpenWRT has this cache patch:
> > https://github.com/openwrt/openwrt/blob/master/target/linux/gemini/patches-4.14/0001-cache-patch-from-OpenWRT.patch
> > I do not know why (sorry).
> >
> > Do you think that patch is actually a hack to hide the problem
> > fixed with this patch? (OK maybe stupid question but...)
>
> No, it looks to me like a hack to make DMA cache handling "more
> efficient" by cleaning/invalidating the entire cache when dealing
> with large streaming buffers.

Aha that makes a lot of sense.

I will attempt to drop it from OpenWRT in the next kernel upgrade
unless benchmarks can show that it is worth it.

Thanks Russell!

Linus Walleij
