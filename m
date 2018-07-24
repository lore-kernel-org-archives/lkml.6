Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241D120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SBvP0bsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241D120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXRCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:02:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53074 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:02:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724155515euoutp0269270eaabc694f0eec912a7e1dcca517~EWRPw2Tue0350503505euoutp02G;
        Tue, 24 Jul 2018 15:55:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724155515euoutp0269270eaabc694f0eec912a7e1dcca517~EWRPw2Tue0350503505euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532447715;
        bh=kU03RIYmpXnp3g2o1HEslE2/0er8cKjsSyLiKsL+fvQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=SBvP0bsvxQV0X+DF36SM5/YvUovTrY5N7orEfzbkHtvB/ixP272TqJQ2TAqhOLRfq
         pYHnQw5+1VYWTLqzG99k9psGtQnl9lYVbGPkya/Knp9TpoccjThjx0Oyw/dU6I/Vlv
         g8wYC+Xmhga9x+FVwtMma3K4ZrDbgZeTNrIiQKVA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724155515eucas1p1d125e5127b2680abeea7666269cd6b15~EWRPbzQZz2238422384eucas1p1I;
        Tue, 24 Jul 2018 15:55:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3C.AA.04627.2EB475B5; Tue, 24
        Jul 2018 16:55:14 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724155514eucas1p1fb588424eb2ca1cb3c061e10292bd09f~EWROx_gFq2489124891eucas1p1H;
        Tue, 24 Jul 2018 15:55:14 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-49-5b574be257f7
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.C7.04183.2EB475B5; Tue, 24
        Jul 2018 16:55:14 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00JQNO82BL50@eusync4.samsung.com>; Tue, 24 Jul
        2018 16:55:14 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: fbmem: mark expected switch fall-through
Date:   Tue, 24 Jul 2018 17:55:13 +0200
Message-id: <11978135.HSW5xz1Y1h@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180709213608.GA7584@embeddedor.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7djP87qPvMOjDZp6dC2ufH3PZrF1j6rF
        ib4PrBaXd81hc2DxWHdQ1eN+93Emj8+b5AKYo7hsUlJzMstSi/TtErgy1u5exlLwj6ni+fUn
        bA2M25m6GDk5JARMJLq29zJ3MXJxCAmsYJSYfuYfG0hCSOAzo8SemZYwRWef32SFKFrGKDHr
        3BJGCOc3o8TfhTfBOtgErCQmtq9iBLFFBIwkZs/oZgWxmQUSJE4vuscCYgsLuEhcebiEvYuR
        g4NFQFVi8/pokDCvgJbExY17wcpFBbwktuxrB7uOU8BYYvWvFUwQNYISPyZDjGEWkJfYt38q
        1HgdibPH1oHdIyEwgU3iR+9tdoirXSS2rYZokBAQlnh1fAtUXEbi8uRuFoiG6YwSb34thXLW
        M0qsOXMMGjDWEoePX4RawScxadt0ZpCrJQR4JTrahCBKPCRePvoGDYk2RokNn1exTmCUmYXk
        2llIrp2F5NoFjMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAmP79L/jn3Ywfr2UdIhR
        gINRiYf3g114tBBrYllxZe4hRgkOZiUR3kWiQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1
        UUIC6YklqdmpqQWpRTBZJg5OqQZGpas903SmPXIRlLv8ztvz2sy1WZeCJXxVOjIv/lywTjXL
        oS7WbdJGltV+DOf1zX6cfiP2d/GadBHtgO8RtUkyzZ9mp5w+ciUnduvkZ9dkCsWMrxXHmM3d
        pCEkKzip8bNRd++iJS8Vf0V3ejPLHP3Dd7NnVnAM45w8BrUZefHdP1TOFv6+0eyvxFKckWio
        xVxUnAgAEuZP+ukCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xa7qPvMOjDRquCVpc+fqezWLrHlWL
        E30fWC0u75rD5sDise6gqsf97uNMHp83yQUwR3HZpKTmZJalFunbJXBlrN29jKXgH1PF8+tP
        2BoYtzN1MXJySAiYSJx9fpMVxBYSWMIo8XZCZRcjF5D9l1Fi5tbj7CAJNgEriYntqxhBbBEB
        I4nZM7qBGjg4mAUSJJ7NSwEJCwu4SFx5uIQdJMwioCqxeX00SJhXQEvi4sa9YONFBbwktuxr
        B1vLKWAssfrXCiaIVR2MEu93r2OBaBCU+DH5HpjNLCAvsW//VFYIW0ti/c7jTBMY+WchKZuF
        pGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAkNy27GfW3Ywdr0LPsQowMGoxMPr
        4RgeLcSaWFZcmXuIUYKDWUmEd5EoUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS
        1OzU1ILUIpgsEwenVAOj+b+NE43+ByjzHXF6d5gztO9I0zeJ2ZV+36vSQ8o//GT+uVlPU/6T
        r+HUy28m7lXXOlEu8e31g6+5c15Oy1hzszr22+L5Sh3JF5/MYfpvInQ+wum2U5Zhl56mVe2s
        G7dn/F90hKHFft6fs5ceXDT9zXGE8eWnkkkTt3e1reRIXv9s1cXSCuWaNiWW4oxEQy3mouJE
        AMhLdEdFAgAA
X-CMS-MailID: 20180724155514eucas1p1fb588424eb2ca1cb3c061e10292bd09f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709213648epcas1p23fcd55af87b2e5ad9a011b335b68873b
References: <CGME20180709213648epcas1p23fcd55af87b2e5ad9a011b335b68873b@epcas1p2.samsung.com>
        <20180709213608.GA7584@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 09, 2018 04:36:08 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

