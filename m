Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A0D204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JFxLlIXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJIWCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:02:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40614 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:02:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009144523euoutp02546379200af5441be082f6890ed033a4~b9-Otpr3o1069210692euoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:45:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009144523euoutp02546379200af5441be082f6890ed033a4~b9-Otpr3o1069210692euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539096323;
        bh=nkmb0Gr+IG4u/WQGUQ9yayN8hbb7f51pCFln0hV8mTg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=JFxLlIXGOYud0zB5l2r6wuhV2cdtqSEgVKZhDjXn8sePG//a93VjeI+kAlVSfXhEy
         21iv48dUARaNTygZYtwBOwULXOkUjn1caaaBuNGr68as5i0cdH0Pmaii9cbYQpkGVo
         sNnIjS5EOr/UyEO3GgVEpDQHrqnQD/MboWQ2zjpo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009144523eucas1p1ca884c1a7c6af764fef7496b3b93c75e~b9-OIFLQG2776427764eucas1p15;
        Tue,  9 Oct 2018 14:45:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D5.AC.04441.20FBCBB5; Tue,  9
        Oct 2018 15:45:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t;
        Tue,  9 Oct 2018 14:45:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009144521eusmtrp2181630f1024c751f2247987f1358f6c4~b9-M6IADn2060420604eusmtrp2j;
        Tue,  9 Oct 2018 14:45:21 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-e2-5bbcbf02b6a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.8E.04128.10FBCBB5; Tue,  9
        Oct 2018 15:45:21 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009144521eusmtip2c2f56f81e5324c47d537358fbb363228~b9-MqsOUh3140931409eusmtip2k;
        Tue,  9 Oct 2018 14:45:21 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: remove redundant 'default n' from Kconfig
Date:   Tue, 9 Oct 2018 16:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87pM+/dEG9y+pmax+m4/m8WxHY+Y
        LC7vmsPmwOxx+Wypx+dNcgFMUVw2Kak5mWWpRfp2CVwZGy/+YSq4xlPR0vORvYFxJ2cXIweH
        hICJxJ5rEl2MXBxCAisYJbY3vWWFcL4wStxesYAJwvnMKDHvyXO2LkZOsI6783azQySWM0rs
        md/KCOG8Z5SYev8vK0iViICCRM/vlWAdzALWEltbp7GD2GwCVhIT21cxgtjCAvYSn56cA7NZ
        BFQkFr9eygpyk6hAhET/GXWQMK+AoMTJmU9YIMbIS2x/O4cZZJeEwHU2iUkLlrNBFJVJHLoz
        jRniOheJnS2ToWxhiVfHt7BD2DIS/3fOZ4Jons4o8ebXUhYIZz2jxJozx5ggqqwlDh+/CHYF
        s4CmxPpd+hBhR4lHnz+yQwKMT+LGW0GIg/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK6FK
        PCS+HJYACQsJxEqsOPeZaQKjwiwkX85C8uUshBMWMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L
        10vOz93ECEwQp/8d/7SD8eulpEOMAhyMSjy8M/J2RwuxJpYVV+YeYpTgYFYS4RXdvitaiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+yeRujhQTSE0tSs1NTC1KLYLJMHJxSDYzLc974TuWLeDO3
        uWHa/C/P3X5ZHWTVfn9JI8Xg86YVp0Iv8ZbwuHom1zWcPM68dvePGVtkns1MDH36vPt8lPdE
        ifJQHoNpRaI+hze4BUieZmSzlYvYr3Y15P1mpv9vv67aVejCf9Ehhk/vus22xu8rz51X/Pdv
        8V7WyeL2auFLVxdbHDEtObVaiaU4I9FQi7moOBEAudiUHgwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xe7qM+/dEGxz5p2qx+m4/m8WxHY+Y
        LC7vmsPmwOxx+Wypx+dNcgFMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZGy/+YSq4xlPR0vORvYFxJ2cXIyeHhICJxN15u9m7GLk4hASWMkrc
        f9HN1MXIAZSQkTi+vgyiRljiz7UuNoiat4wSD38dYQVJiAgoSPT8XskGYjMLWEtsbZ3GDmKz
        CVhJTGxfxQhiCwvYS3x6cg7M5hWwk5i1eRZYL4uAisTi10vBbFGBCIlbDztYIGoEJU7OfMIC
        MVNd4s+8S8wQtrzE9rdzmCcw8s9CUjYLSdksJGULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn
        525iBIbytmM/t+xg7HoXfIhRgINRiYd3Rt7uaCHWxLLiytxDjBIczEoivKLbd0UL8aYkVlal
        FuXHF5XmpBYfYjQFOnwis5Rocj4wzvJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqem
        FqQWwfQxcXBKNTD2Pf7qUy1oHf/NQFUwKLR+HePBu0fl+/aFOi8pOej9hzlR7NyURsldNzYo
        PtW3XaMifzoxe8OGlWFZIZL77hw8WPbHd+HFf/oHbxdXeG0KNH6wtNhRj7O5Uertbo+XDjMN
        i7P40/7FL83dyZwoxfb19KOJJ3w0rpoW3HnhMbVPIWnXa1HXORZKLMUZiYZazEXFiQANHRMY
        ewIAAA==
Message-Id: <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
X-CMS-MailID: 20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0
References: <CGME20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-10-09 15:58:37.319122897 +0200
+++ b/drivers/ata/Kconfig	2018-10-09 16:43:07.823190149 +0200
@@ -33,7 +33,6 @@ if ATA
 
 config ATA_NONSTANDARD
        bool
-       default n
 
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
@@ -62,7 +61,6 @@ config ATA_ACPI
 config SATA_ZPODD
 	bool "SATA Zero Power Optical Disc Drive (ZPODD) support"
 	depends on ATA_ACPI && PM
-	default n
 	help
 	  This option adds support for SATA Zero Power Optical Disc
 	  Drive (ZPODD). It requires both the ODD and the platform
