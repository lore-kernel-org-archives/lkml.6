Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B51C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB90E2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QzhXh5gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB90E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeICSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:36:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38960 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeICSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:36:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180903141608euoutp01d283d42b821fe91ecd3c3a07ae340634~Q6Xae6ZOR0143701437euoutp01J;
        Mon,  3 Sep 2018 14:16:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180903141608euoutp01d283d42b821fe91ecd3c3a07ae340634~Q6Xae6ZOR0143701437euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535984168;
        bh=9Jy92WbXRaKanTog3V7fcr3RC1LyWEvKb3P9PNkhd8c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=QzhXh5gFGk11HIVTbWG/x1APcC9tbheWDMAp1HHMqcnOfrm4NVfZQiKJbAMIk9XhB
         5BQxKj6QSKbxxqxlhCnsz/PTS0cB7spXwTXGa5etThk9VKvq5gQfS+O++WghqK022X
         OKO+hxYlrnIK1WPT5dycWjhI9gedc7nxVuNh/NZQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180903141608eucas1p2b62ba05562e13df9fae79c5a09aba49d~Q6XaEauyh0407904079eucas1p2Z;
        Mon,  3 Sep 2018 14:16:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.BC.04294.7224D8B5; Mon,  3
        Sep 2018 15:16:07 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180903141607eucas1p1b75f57b29e85d0cea7f33be8fc17d4eb~Q6XZLbYmU3208532085eucas1p11;
        Mon,  3 Sep 2018 14:16:07 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-5c-5b8d42278f3b
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.05.04284.7224D8B5; Mon,  3
        Sep 2018 15:16:07 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PEH009FLGYVEQ70@eusync4.samsung.com>; Mon, 03 Sep
        2018 15:16:07 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     David Herrmann <dh.herrmann@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [REGRESSION] boot-screen override by
 "34db50e55656 efifb: Copy the ACPI BGRT"
Date:   Mon, 03 Sep 2018 16:16:06 +0200
Message-id: <1982440.Fn0LzJ7a3l@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87rqTr3RBhfPGlrMaz3KYnHl63s2
        izfHpzNZtD28xWhxou8Dq8XlXXPYHNg8ds66y+5xv/s4k8f7fVfZPD5vkgtgieKySUnNySxL
        LdK3S+DKeHZiBnvBDL6K7rerWRoYd3N3MXJySAiYSFw+8p+9i5GLQ0hgBaPEk9WLmSCcz4wS
        H6ctZ4SpetWzjhEisYxR4mXXFhYI5zejxL+Hi1lBqtgErCQmtq8C6xAR0JLYOG8+2ChmgY2M
        Eo27FzODJIQFYiSefJsJ1MDBwSKgKnFkKidImFdAU+Lw743sILaogJfEln3tTCA2p0CwxNnJ
        W5ghagQlfky+xwJiMwvIS+zbP5UVwtaROHsM4joJgQ1sEqtvLmCFONtFYs+n58wQtrDEq+Nb
        2CFsGYnOjoNMEA3TGSXe/FrKAuGsZ5RYc+YYE0SVtcTh4xehVvBJTNo2nRnkagkBXomONiEI
        00PiT28qJCSWMEp0rbjANIFRZhaSY2chOXYWkmMXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L
        10vOz93ECIz/0/+Of9nBuOtP0iFGAQ5GJR7eAIPeaCHWxLLiytxDjBIczEoivNzWQCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8fFpp0UIC6YklqdmpqQWpRTBZJg5OqQbGch1v/TL/rar5xxR9
        k7v0zvY1dhoULF3Wk8HZcqvB/4XpNcu9AfaTF7Sny87wynxZecnzjOTuht47k0wMluuUNCzK
        mhzW3bNgo82GjydnqO1evMLkW5/VXY3COcw/AvidJqulHPn8ieFzQOtxUV09mauTz71y9G60
        3LROLuFXVv5RvuITP0OVWIozEg21mIuKEwF0jiJI+wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xa7rqTr3RBu3tPBbzWo+yWFz5+p7N
        4s3x6UwWbQ9vMVqc6PvAanF51xw2BzaPnbPusnvc7z7O5PF+31U2j8+b5AJYorhsUlJzMstS
        i/TtErgynp2YwV4wg6+i++1qlgbG3dxdjJwcEgImEq961jF2MXJxCAksYZQ407OTGcL5yyix
        snsRG0gVm4CVxMT2VYwgtoiAlsTGefOZQIqYBTYySjRvmgOWEBaIkXjybSZrFyMHB4uAqsSR
        qZwgYV4BTYnDvzeyg9iiAl4SW/a1M4HYnALBEqsXXmCFWLaMUaJ1zysmiAZBiR+T77GA2MwC
        8hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93
        EyMwdLcd+7l5B+OljcGHGAU4GJV4eAMMeqOFWBPLiitzDzFKcDArifByWwOFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MIY9L84LZNY8KLCwhPf5gvnK
        My64STC84nbT2hvw4wjT375HqY1XVrvvX3Bgf2xva/DkyyKcP1t8fuzcvWHO+n+pN7YX9hgu
        zZnatl107Y5v2W33Fpw4MDt3SnL6MzZhcxfdcM/vm+5knxWy9Kw0OOH68e6R/VNvT+/nEjl7
        99Ote+cMpj4vdVZSYinOSDTUYi4qTgQAsKzEOVkCAAA=
X-CMS-MailID: 20180903141607eucas1p1b75f57b29e85d0cea7f33be8fc17d4eb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903132353epcas4p373e876f1b52dbed6df7bd3acc73fcdf4
References: <CGME20180903132353epcas4p373e876f1b52dbed6df7bd3acc73fcdf4@epcas4p3.samsung.com>
        <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Monday, September 03, 2018 03:23:38 PM David Herrmann wrote:
> Hey
> 
> Since this commit:
> 
>     34db50e55656 efifb: Copy the ACPI BGRT
> 
> the kernel will override boot-splashs unasked. This breaks the
> graphical boot-process on our setups. In particular, we have a setup
> where an efi-boot-entry draws the early boot-splash on-screen, then
> hands-over to the linux-kernel + initrd. The boot-splash daemon in the
> initrd then takes over control of possible animations.
> 
> With the mentioned commit compiled in, the kernel will redraw the
> firmware logo on screen at a random time without any way to intervene.

You have CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y (the deferred
console takeover support introduced in v4,19-rc1). I assume that this
is intended?

> What is the intention of this commit? Why is the kernel re-drawing the
> firmware logo unasked? If someone during the boot-process draws
> content on the screen, I would prefer if the kernel does not clear
> that on driver load.

+/*
+ * If fbcon deffered console takeover is configured, the intent is for the
+ * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
+ * (error) message to display. But the boot graphics may have been destroyed by
+ * e.g. option ROM output, detect this and restore the boot graphics.
+ */
+#if defined CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER && \
+    defined CONFIG_ACPI_BGRT
...
+static void efifb_show_boot_graphics(struct fb_info *info)
...
+#else
+static inline void efifb_show_boot_graphics(struct fb_info *info) {}
+#endif

> Can we either provide an option to disable this feature, or revert the commit?

Hans?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

