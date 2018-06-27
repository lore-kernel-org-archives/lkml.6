Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8027DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2795B2657B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UhbyG6jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2795B2657B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbeF0Jr7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:47:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53793 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeF0Jr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:47:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180627094753euoutp02a6176f74543b6398b5d50abd38f67831~7_1yorrM82666426664euoutp021;
        Wed, 27 Jun 2018 09:47:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180627094753euoutp02a6176f74543b6398b5d50abd38f67831~7_1yorrM82666426664euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530092873;
        bh=EzhCh7zc/GY/ew+oVctBqslcC+Z/39YvMxvmQqNrKVc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=UhbyG6jUFcvkwreqNqbe93IQuQXeA5UkEibkZekBm7SCgclilF4py+nepkx+IxgIr
         sPY6uc2KOOFd4zad/hUm75AR07hQlXlHT6Li6fTZHExOEXKd4POhQc9wh4s2x+HXp9
         SMOlKDv9hYAb74JG3xx1xptpdhkxcV/l/W+J5prc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180627094753eucas1p1655334740c0a0f0836cf46a77208ab02~7_1yCHYIL3007530075eucas1p1H;
        Wed, 27 Jun 2018 09:47:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 45.FA.05700.84D533B5; Wed, 27
        Jun 2018 10:47:52 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180627094752eucas1p16800cdbf15d769a70c158c19ed1f8528~7_1xbdVMx0934609346eucas1p1b;
        Wed, 27 Jun 2018 09:47:52 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-2d-5b335d48682f
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.7B.04178.84D533B5; Wed, 27
        Jun 2018 10:47:52 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAZ00H8777SUM70@eusync1.samsung.com>; Wed, 27 Jun
        2018 10:47:52 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console
 takeover
Date:   Wed, 27 Jun 2018 11:47:51 +0200
Message-id: <66532157.tkLS2buF0U@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180627091520.GI13978@phenom.ffwll.local>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzneV2PWONog42nzSz+b5vIbHHl63s2
        izfHpzNZnOj7wGpxedccNov/j7+yWuzreMBksfbzY3YHDo+93xaweOycdZfdo2XfLXaP+93H
        mTze77vK5rF+y1UWj8+b5ALYo7hsUlJzMstSi/TtErgy/k26y1JwUbhi4d121gbGDfxdjJwc
        EgImElfWrWbuYuTiEBJYwSix+sBmNgjnM6PEj5cHWWCqLm+/xAiRWMYosWXOI3YI5zejxL1P
        UxhBqtgErCQmtq8Cs0UElCX6N89hBSliFmhikri4u4EdJCEsECZx+N9XZhCbRUBVYuvTS2AN
        vAJaEn8PdbGC2KICXhJb9rUzgdicAhYSe281MkHUCEr8mHwP7CRmAXmJffunskLYOhJnj60D
        O09C4AybxPndq5gg7naRaH4zH+oHYYlXx7ewQ9gyEp0dB5kgGqYzSrz5tZQFwlnPKLHmzDGo
        bmuJw8cvQq3gk5i0bTrQ2RxAcV6JjjYhCNNDYkuzACQodjBKXLq4h2kCo8wsJMfOQnLsLCTH
        LmBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYMk7/O/5pB+PXS0mHGAU4GJV4eA2c
        jKKFWBPLiitzDzFKcDArifD+lTKOFuJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQnliS
        mp2aWpBaBJNl4uCUamC00Lz7X3rfRn7hfXxfch1jZn08V3z6iEy+its2AaeaUoGr74/KR4Rq
        nD3+8sANqU8XpnaH57rah79SMyyMzZ5+aKlRf9S/1zLse+3v/bb+rpLPK246N/nZSb0zV4si
        Ytv5p7+yXxVY3rxe5L5YcvvtuC1lavWHb+5SMvs/9SCfWn6TbuSXXV+VWIozEg21mIuKEwEW
        QnDVFQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t/xy7oescbRBg//S1j83zaR2eLK1/ds
        Fm+OT2eyONH3gdXi8q45bBb/H39ltdjX8YDJYu3nx+wOHB57vy1g8dg56y67R8u+W+we97uP
        M3m833eVzWP9lqssHp83yQWwR3HZpKTmZJalFunbJXBl/Jt0l6XgonDFwrvtrA2MG/i7GDk5
        JARMJC5vv8TYxcjFISSwhFGiYc0zVpCEkMBfRonGNkMQm03ASmJi+ypGEFtEQFmif/McsBpm
        gSYmiXmT00BsYYEwicP/vjKD2CwCqhJbn14Cq+cV0JL4e6gLrF5UwEtiy752JhCbU8BCYu+t
        RiaIxTsYJd4sOcMK0SAo8WPyPRaIBfIS+/ZPhVqmJbF+53GmCYz8s5CUzUJSNgtJ2QJG5lWM
        IqmlxbnpucWGesWJucWleel6yfm5mxiBob7t2M/NOxgvbQw+xCjAwajEw2vgZBQtxJpYVlyZ
        e4hRgoNZSYT3r5RxtBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZ
        Jg5OqQbGGZr/1RLM1Con8kcrhDGIqkcZOD5Yf9FK1rNo4rySOYeU7nkd6NY1bYy4+L9xfntp
        hTsXL9s+Tu7bP2aVtd3syvntI9dbzPDCdYnmnkLpg/N/lIQzy4d/lzI+VqNXuDX4hd/+LQrp
        D0v/3jycvK3cYWNxlf4i1+Yds3bfu6lwd/b8nyGCLYpKLMUZiYZazEXFiQAXEQbAcQIAAA==
X-CMS-MailID: 20180627094752eucas1p16800cdbf15d769a70c158c19ed1f8528
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180627091530epcas1p4bcb4d5421da77cd2e262e839dd50e5dc
References: <20180626183612.321-1-hdegoede@redhat.com>
        <CGME20180627091530epcas1p4bcb4d5421da77cd2e262e839dd50e5dc@epcas1p4.samsung.com>
        <20180627091520.GI13978@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 27, 2018 11:15:20 AM Daniel Vetter wrote:
> On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
> > Hi All,
> > 
> > Here is v4 of my patch-set, to delay fbcon taking over the console (and
> > binding to fbdev devices) until there actually is some text output to the
> > console. This is intended for use with the "quiet" cmdline option, in
> > combination with a bootloader which leaves the vendor's logo /
> > EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
> > 
> > The end goal here is a boot where the firmware shows its boot graphics
> > and these stay in place for a couple of seconds until the GUI loads and
> > the GUI then smoothly takes over the framebuffer without any distruptions.
> > 
> > This patch-set spans 2 subsystems.
> > 
> > Petr, the printk subsys change is really trivial (1 line addition) can we
> > get your Acked-by for merging all 3 patches through the fbdev tree?
> > 
> > Changelog:
> > 
> > Changes in v4:
> > -Keep the comments about which fbcon functions need locks in place
> > 
> > Changes in v3:
> > -Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
> > -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
> >  proper locking (requested by Daniel)
> > -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
> > -Document the fbcon=nodefer commandline option (req. by Emil)
> > 
> > Changes in v2:
> > -Check the whole string when checking for erases in putcs, instead of just
> >  the first char
> > -Make dummycon_blank return 1, so that a redraw gets triggered and any text
> >  rendered while blanked gets output so that it can trigger a deferred
> >  takeover if one is pending
> 
> Wrt merging I think it'd be best if we stuff this into drm-misc-next -
> that will increase testing by gpu drivers a lot, instead of a suprise when
> the fbdev pull lands in upstream.
> 
> Bart, is that ok with you?

Not really, since there are efifb changes in the queue which depend
on this series I would really prefer to merge all patches through
fbdev tree.

Also fbdev tree is pulled into -next kernels so testing coverage
should be okay (I assume that everybody are testing -next kernels in
addition to their own branches :-)..

> Hans, if Bart acks this you can directly push this imo.
> -Daniel

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

