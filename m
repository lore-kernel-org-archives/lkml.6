Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B347020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GJP6OoX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B347020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbeGXRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:05:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36255 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbeGXRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:05:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724155837euoutp011a2ba7bddd68b9ae79118f4bb9af6fa7~EWUL2nMMa1978719787euoutp01b;
        Tue, 24 Jul 2018 15:58:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724155837euoutp011a2ba7bddd68b9ae79118f4bb9af6fa7~EWUL2nMMa1978719787euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532447917;
        bh=JXY2AP8393pcmweHCT6sw4UgBxuKKX9gLJ8JjaXVyeU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=GJP6OoX7xGNnfglL4xa2UaEqptd9BpKDXxGHwbQI3K+lAicwnJwpB9by6vkB7MTc6
         vkSoeCqfLWP2RBvc/QQWN292z5Y9fuRE0OAsMQEfEzyXcwCdlP0Lb899NIDPjnapL6
         fd5NNPEqQ52fRL/dprNjeYyyzt0kcGXN9iTq2h1A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724155836eucas1p2cc9d46bff499e42776d301e9ab562785~EWULhDa8y1850318503eucas1p25;
        Tue, 24 Jul 2018 15:58:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.D8.61560.CAC475B5; Tue, 24
        Jul 2018 16:58:36 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724155836eucas1p220267599c363d6e0e5a2ef1a2236b57c~EWUK5rRLH2655126551eucas1p2p;
        Tue, 24 Jul 2018 15:58:36 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-66-5b574caccf37
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.18.04183.CAC475B5; Tue, 24
        Jul 2018 16:58:36 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD008OBODNLZ90@eusync1.samsung.com>; Tue, 24 Jul
        2018 16:58:36 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: mark expected switch fall-throughs
Date:   Tue, 24 Jul 2018 17:58:35 +0200
Message-id: <61303804.R82jaX4LRF@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180709224145.GA15004@embeddedor.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7djPc7prfMKjDW6v1rG48vU9m0XnzGuM
        Flv3qFqc6PvAanF51xw2B1aPdQdVPT58jPO4332cyePzJrkAligum5TUnMyy1CJ9uwSujG0v
        PzAV/GOqOPRuHmMD43amLkZODgkBE4l/v96ydjFycQgJrGCUaL4ylQnC+cwoMa/tCytM1f2p
        89ggEssYJRpWzIFyfjNKrH/9ix2kik3ASmJi+ypGEFtEwEhi9oxusLnMAjMYJV68OcMCkhAW
        cJXo/dXLDGKzCKhKLF3YBLaCV0BLYsGSLrBmUQEviS372sEO5ARa/en3BUaIGkGJH5Pvgc1h
        FpCX2Ld/KiuErSNx9tg6RpBlEgJz2CT2ND1hgbjbReLlm4VQtrDEq+Nb2CFsGYnLk7tZIBqm
        M0q8+bUUylnPKLHmzDFo2FhLHD5+EWoFn8SkbdOBzuYAivNKdLQJQZR4SMy+swsafO2MEtdO
        zWWawCgzC8m1s5BcOwvJtQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIExvzpf8e/
        7mDc9yfpEKMAB6MSD+8Hu/BoIdbEsuLK3EOMEhzMSiK8i0SBQrwpiZVVqUX58UWlOanFhxil
        OViUxHnjNOqihATSE0tSs1NTC1KLYLJMHJxSDYzpx9sX7T+cvXZtzt+dBrY1jF3Resx7S/Pa
        Snys46Mt4rIL57LWztmmsCUp+GOmgI9HtJpqqvFVndfx+nsbmY3W8E0r7D1/JIuhfZUok25z
        HUPRnn/aAh8+O8mv2vMrXT6Fh/9jktBDHxum1Sy1Z25ceNjjs+Gxwv8DsuWn96jfZp/hK5HR
        osRSnJFoqMVcVJwIAOdHGd31AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t/xy7prfMKjDf40MVtc+fqezaJz5jVG
        i617VC1O9H1gtbi8aw6bA6vHuoOqHh8+xnnc7z7O5PF5k1wASxSXTUpqTmZZapG+XQJXxraX
        H5gK/jFVHHo3j7GBcTtTFyMnh4SAicT9qfPYuhi5OIQEljBKrJh+lR3C+csoserwfTaQKjYB
        K4mJ7asYQWwRASOJ2TO6WUGKmAVmMEr87d7HApIQFnCV6P3VywxiswioSixd2MQKYvMKaEks
        WNIF1iwq4CWxZV872GpOoNWffl8AiwsJdDJKfP0cA1EvKPFj8j2wmcwC8hL79k9lhbC1JNbv
        PM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwVLcd+7llB2PX
        u+BDjAIcjEo8vB6O4dFCrIllxZW5hxglOJiVRHgXiQKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MIae/TZhXeSRvYlHHCWvuex03rjn+fasz8+NTUvS
        LB36fTb+yxF+Li+f99Isdc3uDnXVJZd2H7kfeGtlYrlPyxPufQ2NNkktzF/3rfz2N+2ZdFXm
        jBQbPUHTf0udj4tV9Feo8WvKhYU0/ZdimT1v3sL+u43X5eU+aTd9SN1ulRV3RDlXUcOyWoml
        OCPRUIu5qDgRAJwhhpZRAgAA
X-CMS-MailID: 20180724155836eucas1p220267599c363d6e0e5a2ef1a2236b57c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709224217epcas1p397f731700d48b9b39d12afb5c41f8f06
References: <CGME20180709224217epcas1p397f731700d48b9b39d12afb5c41f8f06@epcas1p3.samsung.com>
        <20180709224145.GA15004@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 09, 2018 05:41:45 PM Gustavo A. R. Silva wrote:
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

