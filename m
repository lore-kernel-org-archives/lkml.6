Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9586C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DEE2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MZ8WC5Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DEE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJJWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:14:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36854 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJJWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:14:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010145128euoutp01e94177f8ba39d46e447f32edc4b0e2ef~cRt0yC3AO1618816188euoutp01g
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:51:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010145128euoutp01e94177f8ba39d46e447f32edc4b0e2ef~cRt0yC3AO1618816188euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539183088;
        bh=H6vJmVaF7Uxwz8B0TYvxx7Ttm2fsBC5JpLdNz4tSJoM=;
        h=To:Cc:From:Subject:Date:References:From;
        b=MZ8WC5LlQP13rbZjFKkV9Vh5kGHkXYThvhqlwr1YPuxpQ6CinwreEHorG7M9iKnaq
         45U+bUoBftDriMQVP3cLVZvYy9cG0/jBzzIzMb6GpiMOd+wYiTbD5jairVbYSYp/Xc
         6V+/mqDLanWBjVothyOuq7jcAOUIbVcTUQscoL6M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010145128eucas1p2e6ab32d6fc6a22f4269d356ed1103170~cRt0bR8mH2949229492eucas1p2D;
        Wed, 10 Oct 2018 14:51:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0A.7E.04294.FE11EBB5; Wed, 10
        Oct 2018 15:51:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t;
        Wed, 10 Oct 2018 14:51:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181010145126eusmtrp1c6d659a6d5e3cd7c462be2fe2a45fcb2~cRtzSzKHM1841718417eusmtrp1c;
        Wed, 10 Oct 2018 14:51:26 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-7c-5bbe11ef8d63
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.C2.04284.EE11EBB5; Wed, 10
        Oct 2018 15:51:26 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181010145126eusmtip1983b5ae85cb59d49e114506a32db019f~cRtzGDTW11488814888eusmtip1N;
        Wed, 10 Oct 2018 14:51:26 +0000 (GMT)
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] mfd: remove redundant 'default n' from Kconfig
Date:   Wed, 10 Oct 2018 16:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djPc7rvBfdFGyzo1LW4//Uoo8XlXXPY
        HJg87lzbw+bxeZNcAFMUl01Kak5mWWqRvl0CV8ahWRMYC/4IVWy7uIypgXEJXxcjJ4eEgInE
        p96JTF2MXBxCAisYJZZuW8cMkhAS+MIosWyzO0TiM6PE7bln2GA6JjROg+pYzihxZNcTZgjn
        PVDHxUtAVRwcIgIqEufemIM0MAuoS2zbd4UVxGYTsJKY2L6KEcQWFrCX+NV5lwnEZhFQlVh/
        ZxIzSKuoQIRE/xl1kDCvgKDEyZlPWCDGyEtsfzsHbJWEwBk2iXlr17NAFJVJ7JvSzQRxnIvE
        rK4X7BC2sMSr41ugbBmJ05N7WCCapzNKvPm1FMpZzyix5swxqG5ricPHL7KCXMEsoCmxfpc+
        iCkh4ChxrdENwuSTuPFWEOIePolJ26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBC2h8TEBy0s
        kLCNlXg95y3jBEaFWUi+nIXky1kIJyxgZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
        mBZO/zv+ZQfjrj9JhxgFOBiVeHgbLuyJFmJNLCuuzD3EKMHBrCTCyyCwL1qINyWxsiq1KD++
        qDQntfgQozQHi5I477J5G6OFBNITS1KzU1MLUotgskwcnFINjNnx1eUBn/NtF83PSfmqbLnA
        XFO/9oahStmvqmuL7H3lP7EHZxb7F10zLxTqK0qas2bmjVeK9/JzpMRuLMp49SxhoVP+qp2+
        3wuVOF9dV15YuMMoKzIzTKnFXsYtn4sz6r2p6bH81sPS67nfBl7Zr6DmrdU97+KSszd6Q+4Z
        /tGa8Vsq53y0EktxRqKhFnNRcSIASEybSAcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xu7rvBPdFG0w4ZWRx/+tRRovLu+aw
        OTB53Lm2h83j8ya5AKYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU
        1JzMstQifbsEvYxDsyYwFvwRqth2cRlTA+MSvi5GTg4JAROJCY3TmLoYuTiEBJYySnzqXcna
        xcgBlJCROL6+DKJGWOLPtS42iJq3jBJTvq1nB6kREVCROPfGHKSGWUBdYtu+K6wgNpuAlcTE
        9lWMILawgL3Er867TCA2r4CdxKLjL8HiLAKqEuvvTGIGsUUFIiRuPexggagRlDg58wkLzMw/
        8y4xQ9jyEtvfzmGewMg/C0nZLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        wNuO/dy8g/HSxuBDjAIcjEo8vA0X9kQLsSaWFVfmHmKU4GBWEuFlENgXLcSbklhZlVqUH19U
        mpNafIjRFOjwicxSosn5wOjKK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTT
        x8TBKdXAqLz588F79zNt7RY4bkuP/lUXVjubIfnqV6fE1H8//l7bwhh+wZz3tI1p7otT+zb9
        UJC4qN5RfYArZ3fl3rC5fPkHRA7//VaSse6HtTMrx9yovcXLJXgMF2/puS3c+EVuu5Covn3F
        yn/7jk7KYHNdYsLj3LmG3ys+e31LNcP+vc7bX37xvyK9RomlOCPRUIu5qDgRADB02m52AgAA
Message-Id: <20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t@eucas1p2.samsung.com>
X-CMS-MailID: 20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb
References: <CGME20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb@eucas1p2.samsung.com>
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
 drivers/mfd/Kconfig |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/mfd/Kconfig
===================================================================
--- a/drivers/mfd/Kconfig	2018-10-09 15:58:40.547122978 +0200
+++ b/drivers/mfd/Kconfig	2018-10-10 16:49:37.575915230 +0200
@@ -8,7 +8,6 @@ menu "Multifunction device drivers"
 config MFD_CORE
 	tristate
 	select IRQ_DOMAIN
-	default n
 
 config MFD_CS5535
 	tristate "AMD CS5535 and CS5536 southbridge core functions"
@@ -870,7 +869,6 @@ config MFD_VIPERBOARD
         tristate "Nano River Technologies Viperboard"
 	select MFD_CORE
 	depends on USB
-	default n
 	help
 	  Say yes here if you want support for Nano River Technologies
 	  Viperboard.
@@ -1575,7 +1573,6 @@ config MFD_TWL4030_AUDIO
 	bool "TI TWL4030 Audio"
 	depends on TWL4030_CORE
 	select MFD_CORE
-	default n
 
 config TWL6040_CORE
 	bool "TI TWL6040 audio codec"
@@ -1583,7 +1580,6 @@ config TWL6040_CORE
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	default n
 	help
 	  Say yes here if you want support for Texas Instruments TWL6040 audio
 	  codec.
@@ -1605,7 +1601,6 @@ config MFD_WL1273_CORE
 	tristate "TI WL1273 FM radio"
 	depends on I2C
 	select MFD_CORE
-	default n
 	help
 	  This is the core driver for the TI WL1273 FM radio. This MFD
 	  driver connects the radio-wl1273 V4L2 module and the wl1273
@@ -1649,7 +1644,6 @@ config MFD_TC3589X
 
 config MFD_TMIO
 	bool
-	default n
 
 config MFD_T7L66XB
 	bool "Toshiba T7L66XB"
