Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A83D20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K18A0hV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A83D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJHSDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:03:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35203 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJHSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:03:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105234euoutp0270b07da94e86866cfaca35d85b5044a6~bnKqOt4JJ2733127331euoutp02W
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008105234euoutp0270b07da94e86866cfaca35d85b5044a6~bnKqOt4JJ2733127331euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995954;
        bh=cU66HPwOfzppWLqEXYTeMbRlyP0EJUcM8W9X2QW2glw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K18A0hV0Y1EZoedStlWyKURmTTrgIXU1p2cWtSs3gxyEOCdsJttFpJVdVJpp3TJ+y
         z4BcZNiv4orQA07Ml0yrUlyb5kgxWV2a5d4yD7JDztrTrauB4/P9qc2jgjSt+/A2D7
         TegJ9BH/qTIz5Y2zh8+XDn0IaCueXvnlF9t47dbk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008105232eucas1p21ebecf87d347a48a2d2e5b726e547095~bnKpOzIO_1504515045eucas1p2H;
        Mon,  8 Oct 2018 10:52:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.F9.04294.0F63BBB5; Mon,  8
        Oct 2018 11:52:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008105232eucas1p27b4df429e75fea5c975da532a5511a43~bnKocDvgz1504515045eucas1p2C;
        Mon,  8 Oct 2018 10:52:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008105231eusmtrp17d54bfb76a17460f72b5531fd274487a~bnKoI_tzO2387123871eusmtrp1B;
        Mon,  8 Oct 2018 10:52:31 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-03-5bbb36f0a5e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.48.04284.FE63BBB5; Mon,  8
        Oct 2018 11:52:31 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105231eusmtip1959a49d8cf511373a31de20ce12e479a~bnKnp88ue2906529065eusmtip1s;
        Mon,  8 Oct 2018 10:52:31 +0000 (GMT)
Subject: Re: [PATCH] fbdev: fix broken menu dependencies
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Shiyan <shc_work@mail.ru>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1feb7db2-12b8-77c4-c325-cb4bdc76548e@infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b3brqvJ6/x6sigcYimkJSG3lEqUuuIfSQLTH7nyopJT2VXT
        oBAjsyn5VdnEyrDUpuInOjWldKgxU6SFw1KRgiy1raaVriznVfLfec5zznvOAy9FyLRCDyop
        JZ1VpSiS5SIJ2TG4MnbQEtgTe2hlxpuubGoQ0Y9npwjauGwW0S1zVpIevm0R0m+6K0X04vty
        ki7VeZykmN4fVSTTVufLDN+3kcxMwZCAufNAL2TU+gkRY23dGymOkQTHs8lJmazK/3icJLEr
        r5xMeyfJ+v51AeWgX5QaOVCAj0BjYSNSIwklw3UICpYLxPywhECra0B2lQxbEaytBm05TDdM
        Yp6vRTCvYXiDGcHki+WNhTOmwWioF9qxCz4ANqNRaBcR+KUA7t0yb4hE+BiU3NRuJJDYC/Rl
        JYQaUZQrjoaikf12Woqd4JXmI2nHDjgE6gcKBHZM4H3QuVhJ2N8E3CeG12YbyRsyYfB5Lck3
        DYMPTUViHjvDl6H2TbwHDGWFJG8uR7Cw+nRzaELQMDIo4FVBMDA0LrQ3IrAPNHX783QItFTP
        b9CAHcG06MQXcoTSjnKCp6WQnyfj1d7QXNMs2opVdz3blDCQryGLkWfFtisrtl1W8T+2ChFa
        5M5mcMoElgtIYS/7cQoll5GS4HcxVdmK1n+QYW1oSYe6f1/oR5hC8p3SusjuWJlQkcllK/sR
        UITcRerauU5J4xXZV1hV6nlVRjLL9aPdFCl3l9Y8bImV4QRFOnuJZdNY1dZWQDl45CBnps9x
        diA83jRnMAb+0YUG7Opdi9aPj9VLXM/EnJqYrfb95Dn/12t0mkmyhWeTggZrlM+qJfTbtdwi
        N63/VZ17hNv1R+qwo4bcvsG5qJ6zWTLfuN5m6WTmDHeu/W7vadOO4BOt0ghLMRM3pXmrf/Kz
        DZII/8/TGnG4KHbAe1ROcomKw76EilP8A5CLPKE9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7rvzXZHG2z/o2YxZ/0aNouFD+8y
        W1z5+p7NYuOLzywWJ/o+sFpc3jWHzeLtneksFpN2SDlweOz9toDFY/MKLY8TM36zeNzvPs7k
        MWXuEVaPriPX2Tw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy9jZNp2l4DZXxad3bxgbGH9wdDFyckgImEjcaL3B3sXIxSEksJRR4u/q
        GUAOB1BCRuL4+jKIGmGJP9e62CBq3jJK9G0/xgSSEBawkLhyejUriC0ioCHx+8oVVoiiKYwS
        D24tYgFxmAUOM0kcWryMBaSKTcBKYmL7KkYQm1fATuL2381gk1gEVCSOTJ7IDGKLCkRI3HrY
        wQJRIyhxcuYTMJtTwFFi9eFusHpmAXWJP/MuMUPY8hLb385hnsAoOAtJyywkZbOQlC1gZF7F
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGGHbjv3cvIPx0sbgQ4wCHIxKPLwBfruihVgTy4or
        cw8xSnAwK4nwim4HCvGmJFZWpRblxxeV5qQWH2I0BXpiIrOUaHI+MPrzSuINTQ3NLSwNzY3N
        jc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwuv3m3D1tf8Ex/jazVdfu5h98/uPrjQOn
        T1/5+Hd56MlzMhO7XXsdW+qevnS7EMx87raF+dIShquZH4+IuUzYZzZx/f6Vc5dotZ0z/BDx
        wXOJb9KzBdeWiW7c8bje1SrscKXrguiNim9O6+Zx98rVLpdg+Pnv8GzDnWL6U1/vjuhnabeu
        Vv5Vq6nEUpyRaKjFXFScCADN1y92xgIAAA==
Message-Id: <20181008105232eucas1p27b4df429e75fea5c975da532a5511a43~bnKocDvgz1504515045eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20181008105232eucas1p27b4df429e75fea5c975da532a5511a43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180922224318epcas3p4ee7b0ed26f6776adf2404e71f195dbdf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180922224318epcas3p4ee7b0ed26f6776adf2404e71f195dbdf
References: <CGME20180922224318epcas3p4ee7b0ed26f6776adf2404e71f195dbdf@epcas3p4.samsung.com>
        <1feb7db2-12b8-77c4-c325-cb4bdc76548e@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/23/2018 12:43 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The framebuffer options and devices menu is unintentionally split
> or broken because some items in it do not depend on FB (including
> several under omap and mmp).
> Fix this by moving FB_CMDLINE, FB_NOTIFY, and FB_CLPS711X_OLD to
> just before the FB Kconfig symbol definition and by moving the
> omap, omap2, and mmp menus to last, following FB_SM712.
> 
> Also, the FB_VIA dependencies are duplicated by both being inside
> an "if FB_VIA/endif" block and "depends on FB_VIA", so drop the
> "depends on FB_VIA" lines since they are redundant.
> 
> Fixes: ea6763c104c9 ("video/fbdev: Always built-in video= cmdline parsing")
> Fixes: 5ec9653806ba ("fbdev: Make fb-notify a no-op if CONFIG_FB=n")
> Fixes: ef74d46a4ef3 ("video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
