Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF1220880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ae+LtCn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF1220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeGXRZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:25:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40233 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:25:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724161804euoutp01c32a0a0970d4a8fc9e0e83592b06123f~EWlLGulk82849428494euoutp01n;
        Tue, 24 Jul 2018 16:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724161804euoutp01c32a0a0970d4a8fc9e0e83592b06123f~EWlLGulk82849428494euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532449084;
        bh=Fp5n6oDLo1PaVkIWRUaQdMOnIiSaeNydBNzb5U6OBhw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ae+LtCn6rGV4Ie3Xet7NdatJ1T+FoMbQCtKnaRpn0FFTOsVKkARJH0i9SfwUYMTvu
         8hW7kCakNYNFNXiqYXenM+gw/FoVRa1nGJIycHHTJ01ycwSbWsaREPyXiBLMJPN3Um
         P1NQ932sFxP+zyU4QXtxDefKeWKwgJCHNMaEnzdU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724161804eucas1p2ce6123b1c2501483892a58c3cc556536~EWlKjrZmc1785117851eucas1p2p;
        Tue, 24 Jul 2018 16:18:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.B1.05751.B31575B5; Tue, 24
        Jul 2018 17:18:03 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724161803eucas1p1a3e999a91b24eeb04d70807f1304b08e~EWlJygRPD2716327163eucas1p12;
        Tue, 24 Jul 2018 16:18:03 +0000 (GMT)
X-AuditID: cbfec7f4-c47ff70000001677-25-5b57513bad59
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.69.04183.B31575B5; Tue, 24
        Jul 2018 17:18:03 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD003LGPA3NN60@eusync3.samsung.com>; Tue, 24 Jul
        2018 17:18:03 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Date:   Tue, 24 Jul 2018 18:18:02 +0200
Message-id: <2838511.fdTZ0RgijS@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1582481.BL9yPUoula@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7rWgeHRBpf2W1jMWb+GzeL/tonM
        Fle+vmezeHN8OpPFib4PrBaXd80BSjz+ymqxr+MBk8WjCZOYLNZ+fsxuseXNRFYHbo+93xaw
        eOycdZfdo2XfLXaPEzN+s3jc7z7O5PF+31U2j/VbrrJ4bD5d7fF5k1wAZxSXTUpqTmZZapG+
        XQJXxqQr8xgLtnNXtLw4ydTAuICzi5GTQ0LAROLl4u0sILaQwApGiQdtlV2MXED2Z0aJD1Om
        s8MUTTz7jREisYxRYlf/TDaIjt+MEmceZYPYbAJWEhPbVzGC2CICGhItC56DTWUWOMgs0bw2
        E8QWFnCRmH12JiuIzSKgKnH5zk9mEJtXQFPiw/rDTCC2qICXxJZ97WA2p4CWxMKVV5ggagQl
        fky+BzVTXmLf/qmsELaOxNlj68COkxD4zCYx9fQNNoirXSSmfOlggbCFJV4d3wL1jYzE5cnd
        LBAN0xkl3vxaCuWsZ5RYc+YYE0SVtcTh4xehVvBJTNo2HehUDqA4r0RHmxBEiYfEgoZVbJBg
        WcUosen5DcYJjDKzkFw7C8m1s5Bcu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
        ejn97/iXHYy7/iQdYhTgYFTi4f1oFx4txJpYVlyZe4hRgoNZSYR3kShQiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgbE8T6v4nJnX8nsP3v5nVFi8YAfD
        9xePn2xyDjc5fO3Fuk0p8UeS+g4tcQ7zLTqzo9Di22FHw7//w29mvP76ounGHJ7XTyKn9hYx
        hQkeC3fcX2TS7LhC1qCXXfwLj121VW/lr7XTK4I9+ss6xT1bIyR4X5XILFddsnvWEq8Fpz/u
        mPzwVlzjjnNKLMUZiYZazEXFiQBfGIAdKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xq7rWgeHRBgdP81vMWb+GzeL/tonM
        Fle+vmezeHN8OpPFib4PrBaXd80BSjz+ymqxr+MBk8WjCZOYLNZ+fsxuseXNRFYHbo+93xaw
        eOycdZfdo2XfLXaPEzN+s3jc7z7O5PF+31U2j/VbrrJ4bD5d7fF5k1wAZxSXTUpqTmZZapG+
        XQJXxqQr8xgLtnNXtLw4ydTAuICzi5GTQ0LARGLi2W+MXYxcHEICSxglXjReZ4Nw/jJKTPi1
        gg2kik3ASmJi+ypGEFtEQEOiZcFzFpAiZoHDzBL9P7+BJYQFXCRmn53JCmKzCKhKXL7zkxnE
        5hXQlPiw/jATiC0q4CWxZV87mM0poCWxcOUVJohtaxgl9n25xgjRICjxY/I9FhCbWUBeYt/+
        qawQtpbE+p3HmSYw8s9CUjYLSdksJGULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbH
        tmM/t+xg7HoXfIhRgINRiYfXwzE8Wog1say4MvcQowQHs5II7yJRoBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGCzK7fd/3//Cvze5e/cvALKTufqbE
        GruZstUzZgjPbhW+FLYk9UrHdllxG5adNhIsM6ZM69G9YS1szvVG9cB6joVTX9etipSpnuXz
        6kLjjBARva42Ns6FQbNlBF+d5dT9Z3b2O3dMkbtSziXD3T1bJ0xvVgtilzn/0Nda9fmE3rdH
        1nzIvC6jxFKckWioxVxUnAgA2EEVx4sCAAA=
X-CMS-MailID: 20180724161803eucas1p1a3e999a91b24eeb04d70807f1304b08e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180712132944epcas4p3091e1c7a7aa1bd4da95750908012e616
References: <CGME20180712132944epcas4p3091e1c7a7aa1bd4da95750908012e616@epcas4p3.samsung.com>
        <20180712092938.22e33641@gandalf.local.home> <1582481.BL9yPUoula@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 06:13:19 PM Bartlomiej Zolnierkiewicz wrote:
> On Thursday, July 12, 2018 09:29:38 AM Steven Rostedt wrote:
> > 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > There's been discussion on the fb list about the addition of
> > WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> > the fb module is loaded with lockless_register_fb the console lock is
> > not taken for debugging reasons. With the addition of
> > WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> > fill up with warnings when trying to debug the fb driver.
> > 
> > There's also a #if 1 that enables the warning which was added before
> > git history, and we look down on constant #if's in the kernel nowadays
> > anyway.
> > 
> > Remove the #if 1 and add a ignore_console_lock_warning boolean that can
> > be set by drivers to ignore the warning in order to do debugging.
> > 
> > Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Patch queued for 4.19, thanks.

Dequeued, I've just noticed a newer patch from Thomas for this issue
(I plan to apply it later this week).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

