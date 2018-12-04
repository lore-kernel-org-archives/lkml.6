Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D69C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4696420660
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ijLQd8HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4696420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLDLSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:18:39 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56829 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeLDLEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:42 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wB4B4UMO005160;
        Tue, 4 Dec 2018 20:04:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB4B4UMO005160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543921471;
        bh=eL67Uj5IhKBkjKKZusu33I1zE9zzfzV4DKOJhGN7Jn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ijLQd8HIw1UwNB4zNpZTKzdO9pAZdWMKdC/S8EW7P8NsE5arLrziSX0Z21NVNNkl2
         VUBqZk4vwTWjzkjImYkqLvB6S1QL6G9I/LmWH6DoUt0s7L8jmWtk+JvVcuNNt5LMSk
         7AS6DlZWisdvMC3oVrV6FKDWJiwTIfV0XdYVYlsKAJft/D76cA51JbDquu4ez5fHsz
         WHRCFok/iORpEO2msRVWpXSRojEs2O1NGcuPN2mWtDO2twEaQQhiiDjEqHK4aM9g79
         gCKFYq0kGETpbH/MWeNQOaxRj445ajlsKsY9p53V43UQgUID1Wxo6zlwfTq72TfmZ4
         Bey/ChYlttEkA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id g68so9517306vsd.11;
        Tue, 04 Dec 2018 03:04:31 -0800 (PST)
X-Gm-Message-State: AA+aEWY7IUhHa1ShtPPLP5fVlurJFmRZ0mxHQF/WrznSuiF0W6vIhrd7
        lDU3nUUT1HC6OKalQFEADcxv2lQI3WUzHsxIpSc=
X-Google-Smtp-Source: AFSGD/UTeE/f5hDFkGuKSPNuphdZP4laGDJfXNsMEUGG9EVvN1ZWTAzA01HS2Wy5gKrklcimH/SYXEZKeLh/RnbDJMA=
X-Received: by 2002:a67:485:: with SMTP id 127mr8854607vse.54.1543921469732;
 Tue, 04 Dec 2018 03:04:29 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com> <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 4 Dec 2018 20:03:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Message-ID: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     sugaya.taichi@socionext.com, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > Add Milbeaut M10V clock ( including PLL ) control.
>
> Please give some more details here.
>
> >
> > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > ---
> >  drivers/clk/Makefile   |   1 +
> >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> And this is different from Uniphier? Maybe we need a socionext
> directory under drivers/clk/.



This is always a difficult question,
and I do not have a strong opinion.


I am fine with moving the files to drivers/clk/socionext
although no file would be shared.


FYI

UniPhier and Milbeaut are completely different platforms
developed/maintained by different teams.

They happen to live in the same company now
just because Socionext merged the LSI business from Panasonic and Fujitsu.

UniPhier originates in Panasonic, while Milbeaut in Fujitsu.


Thanks.




--
Best Regards
Masahiro Yamada
