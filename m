Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73502C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F53208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pCpQsjU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F53208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeGaMoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:44:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49136 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:44:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180731110428euoutp0234b54e62c736bcadc0b45cdabd816b2e~Gb0XMpoZy0273902739euoutp02S;
        Tue, 31 Jul 2018 11:04:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180731110428euoutp0234b54e62c736bcadc0b45cdabd816b2e~Gb0XMpoZy0273902739euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533035068;
        bh=QdredzsyDKONvTVa90Yp107pZKGw33m6ZKkYDezGiNI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=pCpQsjU/205FtHS5dNJ9rVc4WBMY15SkeQ0GG+vx5/A7FmQsKNqOgEzsNxElbSkj5
         4Hb9sFqs7gu/e4HK6H0q/j818lIKlAsCQtvJk9rmcx7pWIZg+4ka/mFRN38frj91t3
         ZIrV4Hbj0eRx3BFi+7UEXhmoZ0cOLGrB0EspAwfc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110428eucas1p131ebb974523a1294261e6d0369eac9f1~Gb0WzLPyP0887908879eucas1p1D;
        Tue, 31 Jul 2018 11:04:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 36.F1.61560.B32406B5; Tue, 31
        Jul 2018 12:04:27 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110427eucas1p1b82f7acb80e3159fc06652fa49847df6~Gb0V8rnPC0887908879eucas1p1C;
        Tue, 31 Jul 2018 11:04:27 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-77-5b60423b8616
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.29.04178.B32406B5; Tue, 31
        Jul 2018 12:04:27 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCQ0083H9FFH160@eusync3.samsung.com>; Tue, 31 Jul
        2018 12:04:27 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     Mauro Carvalho Chehab <m.chehab@samsung.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] media: omap2: omapfb: fix ifnullfree.cocci warnings
Date:   Tue, 31 Jul 2018 13:04:26 +0200
Message-id: <5347473.CNfWREzxTC@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180725175700.GA83136@lkp-sb05.lkp.intel.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87rWTgnRBod32Fj8nXSM3eLK1/ds
        Fu+fr2e2OHZ9IrNF58Ql7BYn+j6wWlzeNYfNomfDVlaL2Uv6WSwurpO3WD//FpsDt8f9vewe
        v39NYvSY3TGT1WPxnpdMHve7jzN59G1Zxehx/MZ2Jo/Pm+QCOKK4bFJSczLLUov07RK4Mv4v
        uMxecIKtYmPLOpYGxu2sXYycHBICJhIXjp0Csrk4hARWMEqcu/yOCcL5zCgx5fpCFpiqzSee
        sUAkljFKTLq/BKrqN6PEySV7mUGq2ASsJCa2r2IEsUUE9CRWLGxjBCliFrjPJPFn6nSwhLCA
        h8TqfaeYQGwWAVWJX79WgMV5BTQlGrp7wWxRAS+JLfvagWo4ODgFbCS2fxeGKBGU+DH5HthF
        zALyEvv2T2WFsHUkzh5bxwhx6Ws2iZd98hC2i0T75qXsELawxKvjW6BsGYnOjoNgD0gITGeU
        ePNrKQuEs55RYs2ZY0wQVdYSh49fhNrAJzFp23RmkIMkBHglOtqEIEo8JLa/b2WDhMQBRon3
        F5YyT2CUmYXk2FlIjp2F5NgFjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxApPK6X/H
        v+5g3Pcn6RCjAAejEg/vB/X4aCHWxLLiytxDjBIczEoivDYyQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8d/rjooUE0hNLUrNTUwtSi2CyTBycUg2MB28a15p2LTQXKYkTz3KxLed38XCcuC+3
        nXtne2OAXurl7ZkzVnuVZgcoLtA5G9RwuuTInNVOKqXCeinK+utWvtqokbl1o+OaiaKa07kX
        3Qzj9ip5zce0M0S9+6SB6uNXx+ZlTrzbWHlnoiW/y2FLD8Hmm+tz7L/+3FQp4b2yvzz6xluN
        3b5KLMUZiYZazEXFiQBR9qazJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xq7rWTgnRBm9+iVn8nXSM3eLK1/ds
        Fu+fr2e2OHZ9IrNF58Ql7BYn+j6wWlzeNYfNomfDVlaL2Uv6WSwurpO3WD//FpsDt8f9vewe
        v39NYvSY3TGT1WPxnpdMHve7jzN59G1Zxehx/MZ2Jo/Pm+QCOKK4bFJSczLLUov07RK4Mv4v
        uMxecIKtYmPLOpYGxu2sXYycHBICJhKbTzxj6WLk4hASWMIosXr5QXYI5y+jxPd7DYwgVWwC
        VhIT21eB2SICehIrFrYxghQxC9xnkmjYcJ8NJCEs4CGxet8pJhCbRUBV4tevFWANvAKaEg3d
        vWC2qICXxJZ97UA1HBycAjYS278LQyw7wCjR/Ww2E0S9oMSPyfdYQGxmAXmJffunskLYWhLr
        dx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGBHbjv3cvIPx
        0sbgQ4wCHIxKPLweWvHRQqyJZcWVuYcYJTiYlUR4bWSAQrwpiZVVqUX58UWlOanFhxilOViU
        xHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhgrXTaGXDy7Qpvrvc4MraZ6vjOSxR83XLMU1O+6
        uumZ5KOHiwwXZVxserviiae+sdm3XxovDkyW/rXk0keJNax7V9pVz/3G33fm9ikpza9vbiQI
        2FYsOW3O6i6bVWPQ5X37HaPBncYFv5YXLHja113rlNd1peLu6XqmGtPufTP+zujV2JR++tBT
        JZbijERDLeai4kQAmFLTmIQCAAA=
X-CMS-MailID: 20180731110427eucas1p1b82f7acb80e3159fc06652fa49847df6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725175715epcas1p35370d1cf5561b86c0a5af0cc04a64b63
References: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
        <CGME20180725175715epcas1p35370d1cf5561b86c0a5af0cc04a64b63@epcas1p3.samsung.com>
        <20180725175700.GA83136@lkp-sb05.lkp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 01:57:00 AM kbuild test robot wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
> 
> drivers/video/fbdev/omap2/omapfb/dss/core.c:141:2-26: WARNING: NULL check before some freeing functions is not needed.
> 
>  NULL check before some freeing functions is not needed.
> 
>  Based on checkpatch warning
>  "kfree(NULL) is safe this check is probably not required"
>  and kfreeaddr.cocci by Julia Lawall.
> 
> Generated by: scripts/coccinelle/free/ifnullfree.cocci
> 
> Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_TEST")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Patch queued for 4.19 (w/ "media"->"fbdev" fixup in the patch title), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

