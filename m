Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7921920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G5sNFRV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfBOHRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:17:31 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:18986 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbfBOHRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:17:30 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1F7HQZf025465;
        Fri, 15 Feb 2019 16:17:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1F7HQZf025465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550215047;
        bh=GeopkqQtXzwUJZ3y6qZvd9T4Uw6r5SvlPQNc24Bsa4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5sNFRV3kQ3kFp1cpwQ/p977o6bRCOnlYRwRNZbkuKWgFr31TpOAUskfjCkCnggKQ
         bulUyTGR9xrCN2VpS5d9St1neRX4yw62qWtdsw0HBtyn1j5hbwxlhgcjzB+8LnteAj
         KF5Wc0ZLpE3uIZLcK/f8me4qiCozF3AhqXjaf6N3nAbupH9ncY+2IWXtspUZAi3Xjd
         WTtVbIYCTGpMxC8PDivjPWuAWe4F/PcsOgcBrGN2LV3WR6q6hsQIotn0as3Y6WQIUJ
         WwC7hCUSj3KnoLdRwtoHqyvBsQCyP3o6YHxEC6HvDuoD6dzpE4aZfPU+hVbdNCv7VA
         zQ0DRyIAughAA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id b20so5223817vsl.9;
        Thu, 14 Feb 2019 23:17:26 -0800 (PST)
X-Gm-Message-State: AHQUAuZ01Nx3F/KC6UjnYlohsIK7lPJoCgjo9Lj6g5Hauvqi1R4b4PjE
        RofZlrvkgsCc/XYe0iHzIVOvoMOFEnHiAWxKii4=
X-Google-Smtp-Source: AHgI3IZyIXujDelplfko6wBHrsbS2dq6CNqn7D68TH0m2IT92ENSLenQrLKXfUJMf7PNeCSldoJEBtW7NN6lWFtuNvE=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr4199596vsd.155.1550215045700;
 Thu, 14 Feb 2019 23:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-7-hch@lst.de>
In-Reply-To: <20190213174005.28785-7-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 16:16:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
Message-ID: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Greentime Hu
+CC Vincent Chen


On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig.debug and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


This changes the behavior of nds32.

So please leave a note in the commit description.
(Ideally, we want Ack of a NDS32 maintainer)

Also, please do compile test for NDS32.


-------------------------
This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.

NDS32 selects LOCKEP_SUPPORT, but there was previously
no config entry of LOCKDEP_SUPPORT in nds32.

It is now available in lib/Kconfig.debug,
so this commit enables LOCKDEP_SUPPORT for nds32.
-------------------------






--
Best Regards
Masahiro Yamada
