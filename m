Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD92C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A586020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eETxv5CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A586020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGXQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:54:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51240 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:54:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724154701euoutp02f280fb5030a9ea90180102d526741401~EWKDcZYWq0090500905euoutp02I;
        Tue, 24 Jul 2018 15:47:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724154701euoutp02f280fb5030a9ea90180102d526741401~EWKDcZYWq0090500905euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532447221;
        bh=TaOrruevSdrJdt113lPcWC+zq3xHpXFVEO04/nvHR38=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=eETxv5CQyQJ7GL47IzTxDdE1OP5DLdeLKAbOFXAqNdgqSHlvda0Pf2jrRaDKJDhVK
         LT7N/i5xr16PJEgl4rwT+WclZX3/ehfvICDUwZg9W7EsJbH56OQTjPTn0g5BrV1aYK
         tqCpWzp5StAqtBRH6ubhOfNcua8W3GFHzZrn1mFk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724154700eucas1p1585a6d00bec482246b10c0d0178e04e3~EWKDJKj_-0750207502eucas1p1V;
        Tue, 24 Jul 2018 15:47:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DD.0A.04627.4F9475B5; Tue, 24
        Jul 2018 16:47:00 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724154659eucas1p220bc1c8a91130a85d9ee27d6cac43e25~EWKCS2tlt2808128081eucas1p23;
        Tue, 24 Jul 2018 15:46:59 +0000 (GMT)
X-AuditID: cbfec7f2-0d3ff70000021213-47-5b5749f40fc7
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.17.04183.3F9475B5; Tue, 24
        Jul 2018 16:46:59 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD002OCNUB4S90@eusync1.samsung.com>; Tue, 24 Jul
        2018 16:46:59 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: samsung: Remove Exynos5440 clock handling
 left-overs
Date:   Tue, 24 Jul 2018 17:46:59 +0200
Message-id: <3064664.tE3uuFXtKN@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180717154617.29913-1-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87pfPMOjDZZ3yVnMv3KN1aL/8Wtm
        i/PnN7BbbHoM5F7eNYfN4nPvEUaLGef3MVk8edjH5sDhsXPWXXaPxXteMnlsWtXJ5rF5Sb3H
        501yAaxRXDYpqTmZZalF+nYJXBkr5p9lLehiqbi05x5jA+Mm5i5GTg4JAROJLd0tTF2MXBxC
        AisYJRa3fYZyPjNKvHy2hx2mau/vT6wQiWWMEj8edzBCOL8ZJeb2LWIFqWITsJKY2L6KEcQW
        EdCUuP73O1gHs8BHRomtjz8xgSSEBUIk5mw9DbacRUBV4tCKBrAVvEANE6cdYQOxRQW8JLbs
        awer5xQwlbh29QAbRI2gxI/J91hAbGYBeYl9+6eyQtg6EmePrQO7SEJgB5vEiY1nWSHudpGY
        dvgUI4QtLPHq+Baof2QkLk/uZoFomM4o8ebXUihnPaPEmjPHmCCqrCUOH78ItYJPYtK26UBn
        cwDFeSU62oQgSjwk9p79AA2YDkaJ+ZvWMk1glJmF5NpZSK6dheTaBYzMqxjFU0uLc9NTiw3z
        Usv1ihNzi0vz0vWS83M3MQLTw+l/xz/tYPx6KekQowAHoxIP7we78Ggh1sSy4srcQ4wSHMxK
        IryLRIFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeM06qKEBNITS1KzU1MLUotgskwcnFINjNuO
        3FNztZCeuPhFkv2KKz8udUvHvlcQYbrOwOP+8diV5T/W/TpdlX+oUvPJH5el7N49xauZ/s0u
        u19kvJaF95p51AnJtzoXD/RaJ948w1R8x/bhZbdFD7o3BvqwHN+3b/dpoUlc/Z3qx3iXb1GI
        2P4jzuEV/4XeOw0Hnjz7bPB2rZ2S4OeF9beUWIozEg21mIuKEwFq2D2yCwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t/xy7qfPcOjDZqeKlnMv3KN1aL/8Wtm
        i/PnN7BbbHoM5F7eNYfN4nPvEUaLGef3MVk8edjH5sDhsXPWXXaPxXteMnlsWtXJ5rF5Sb3H
        501yAaxRXDYpqTmZZalF+nYJXBkr5p9lLehiqbi05x5jA+Mm5i5GTg4JAROJvb8/sXYxcnEI
        CSxhlJi3/TwLhPOXUWLm0o2sIFVsAlYSE9tXMYLYIgKaEtf/fgeLMwt8ZJRo31IPYgsLhEjM
        2XoabCqLgKrEoRUN7CA2L1D9xGlH2EBsUQEviS372plAbE4BU4lrVw+wQSzrYpQ41XqCBaJB
        UOLH5HssEAvkJfbtnwq1TEti/c7jTBMY+WchKZuFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAsN627GfW3Ywdr0LPsQowMGoxMPr4RgeLcSaWFZcmXuIUYKDWUmEd5EoUIg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAPjlrY7nmItku0r
        fRZ2PC70tFzl/dcjlVv6XLjrVqn55st4MiQvXzU9Ep/IXf9rNs/MlfGru3by1zVtt34Rf5zx
        mOlVUSXBDQGyugW89zft8/9qw8QnsOnhxQi7BKWSmGueKT2Kr/SE5eOkP5mt0dr5vtDrRfhC
        Rd6rgr3vTlqvFvRfVHbuy2slluKMREMt5qLiRACsXHP7ZwIAAA==
X-CMS-MailID: 20180724154659eucas1p220bc1c8a91130a85d9ee27d6cac43e25
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180717154647epcas2p4285b46d932fbfd04eab2bdf05de8a5b1
References: <CGME20180717154647epcas2p4285b46d932fbfd04eab2bdf05de8a5b1@epcas2p4.samsung.com>
        <20180717154617.29913-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 17, 2018 05:46:17 PM Krzysztof Kozlowski wrote:
> Commit 8014220d48e7 ("thermal: samsung: Remove support for Exynos5440")
> removed the Exynos5440 specific part of code for accessing TMU interrupt
> registers but the surrounding clock handling was left.
> 
> Clean it up.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

