Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0002C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F00F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d3XPKvNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfARHbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:31:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60196 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfARHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:31:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118073123euoutp01e233e5fc8d24491fe83d05c7ce64e638~64OIGqcmu2629026290euoutp018
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:31:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118073123euoutp01e233e5fc8d24491fe83d05c7ce64e638~64OIGqcmu2629026290euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547796683;
        bh=2VMkQd0M3WOPWIOU5I7rclzw4ayR+p5wDA1kAAHtWYE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d3XPKvNmtSoTVLw9yuwWGiEiUeNUYXVvhjr2bHYpOMt3DlrQ/62iVvErXBpfRjdA7
         d5IVkmRzFypGV4instqjHgGVsWgyquI0eH33aGA3dp3OtWue5ii9PDU7vNlrDxevnF
         4xNAym98VJtWLMcSVOpm6/PPVFf3hk5tdbfwYdGM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118073122eucas1p28ab53daec61913b00e42a1f05db870c1~64OHXWCPy3269232692eucas1p2S;
        Fri, 18 Jan 2019 07:31:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.F3.04441.AC0814C5; Fri, 18
        Jan 2019 07:31:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190118073121eucas1p1803ce78729e61fc29b589846b022a668~64OGiFPLC2504925049eucas1p14;
        Fri, 18 Jan 2019 07:31:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190118073121eusmtrp1dbdfdb1ee88e701d9b345991c7d2aa14~64OGSE8AY0557005570eusmtrp1R;
        Fri, 18 Jan 2019 07:31:21 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-09-5c4180ca6c3c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.C2.04284.9C0814C5; Fri, 18
        Jan 2019 07:31:21 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190118073120eusmtip1ad825810ad7e9ffef7cb038efc83e135~64OF4HNn92113921139eusmtip1O;
        Fri, 18 Jan 2019 07:31:20 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] drm/bridge: lvds-encoder: add dev helper
 variable in .probe()
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <dabb3771-05af-8fd3-bb6e-a60402f65a94@samsung.com>
Date:   Fri, 18 Jan 2019 08:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111151843.11114-5-peda@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87qnGhxjDDau5rfoPXeSyaKp4y2r
        xfwj51gtrnx9z2bROXEJu8XlXXPYLJZev8hksffQfEaL1r1H2B04PdbMW8PoMe3AbHaPy329
        TB6zO2ayemxa1cnmsf3bA1aP+93HmTw+b5IL4IjisklJzcksSy3St0vgyvh2toe54BpjxZ8p
        DcwNjOsYuxg5OSQETCSuHPzODmILCaxglJh12rGLkQvI/sIocaf3LCuE85lRYubmnawwHft3
        9jJDJJYzSqxY2QVV9ZZRYsfqJ2CzhAWiJeY8m8oMYosIJEmsvP+ACaSIWeACk8SPnW1sIAk2
        AU2Jv5tvgtm8AnYSu/ZPBmtmEVCV+NU3mwnEFhWIkOi4vxqqRlDi5MwnLCA2p4CpRO+nf2BP
        MAvISzRvnc0MYYtL3HoyH2yZhMA1don1u5cxQdztIvF81ic2CFtY4tXxLewQtozE6ck9LBB2
        vUTTzCvMEM0djBInFi+HarCWOHz8ItCfHEAbNCXW79KHCDtKHH22nBEkLCHAJ3HjrSDEDXwS
        k7ZNZ4YI80p0tAlBVCtK3D+7lRnCFpdYeuEr2wRGpVlIPpuF5JtZSL6ZhbB3ASPLKkbx1NLi
        3PTUYsO81HK94sTc4tK8dL3k/NxNjMC0dfrf8U87GL9eSjrEKMDBqMTD+2KbQ4wQa2JZcWXu
        IUYJDmYlEV6jOscYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJM
        HJxSDYzB3dFVczurP0/Nuv4xTE7xXC5LPiO31twnu58dFtD5s9HrlmpfiA/nw4a7Jxj2rq/Y
        tIP55TP9msnulZeeCj+O9tOyX1vC5ssT1lK5sfrHgttyH2p7bq27/bHm2b4Iubt/554ImxJy
        J6f7il3ciRxeu1vc01eUlBtLL6vNKLJlYGxiYN4jukuJpTgj0VCLuag4EQDmrlCoVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7onGxxjDG6/FbXoPXeSyaKp4y2r
        xfwj51gtrnx9z2bROXEJu8XlXXPYLJZev8hksffQfEaL1r1H2B04PdbMW8PoMe3AbHaPy329
        TB6zO2ayemxa1cnmsf3bA1aP+93HmTw+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDSM7S00DMy
        sdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/h2toe54BpjxZ8pDcwNjOsYuxg5OSQETCT27+xl
        7mLk4hASWMoocWFbJwtEQlxi9/y3zBC2sMSfa11sEEWvGSVWvtoB1i0sEC3x7eFMMFtEIEni
        yOzNYJOYBS4wSZxf18AC0bGZUeLWzFdMIFVsApoSfzffZAOxeQXsJHbtn8wOYrMIqEr86psN
        ViMqECFx9iXEfbwCghInZz4BO4lTwFSi99M/sDizgLrEn3mXmCFseYnmrbOhbHGJW0/mM01g
        FJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBWtx37uXkH46WN
        wYcYBTgYlXh4X2xziBFiTSwrrsw9xCjBwawkwmtU5xgjxJuSWFmVWpQfX1Sak1p8iNEU6LmJ
        zFKiyfnANJJXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFRTqKV
        N2aXx62z+WKJIcYzUpdeTFrMoHhffa2R1lKB97bL7wqEFUlLXRU2Tqw51NR88umc9zp7dBLd
        bqwwsvbNS49baHv2mc3Eh1ujz8hzvmde+ejyzXLhI5vaRMsiTjjppW3PLPe+ydrcH6f8sCCZ
        v9P/E4eKbnqu/If5ykt3paR5LFRL51BiKc5INNRiLipOBAA4/RAO6wIAAA==
X-CMS-MailID: 20190118073121eucas1p1803ce78729e61fc29b589846b022a668
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190111151938epcas1p3d3e2d4d3778729b3035dbce2830d4e46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190111151938epcas1p3d3e2d4d3778729b3035dbce2830d4e46
References: <20190111151843.11114-1-peda@axentia.se>
        <CGME20190111151938epcas1p3d3e2d4d3778729b3035dbce2830d4e46@epcas1p3.samsung.com>
        <20190111151843.11114-5-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2019 16:19, Peter Rosin wrote:
> Make the code easier to read and modify.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

