Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A594C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D2A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GCVUxMlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D2A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJIUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:47:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36848 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeJIUrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:47:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009133037euoutp01cf6743db2d19388611c3fc91aa9602c0~b8985MEXb2359123591euoutp01g
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 13:30:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009133037euoutp01cf6743db2d19388611c3fc91aa9602c0~b8985MEXb2359123591euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539091837;
        bh=qKwsDcz2AB0zvQP8c8XBhvTr3lSNlhhDWZPqFQ80/us=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GCVUxMlHCJxCTdabXBsndU87N6tEWv5OaJiLFNHXCfZ87FlgWeinLK2IPm0TyvIpI
         X2gIczvb88VrTEME4djAd6+/TmZcATP0kQsKBxyFCY7vRkETzL3l6Ry60YyflDXD0p
         LxooekTTYRGqGgCUQmrnzvjCABBK4Ti/DlxJMaIw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181009133037eucas1p2af221b5277564be1b99a8066fea6fda5~b898RZGGt1959119591eucas1p2E;
        Tue,  9 Oct 2018 13:30:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 43.DF.04806.C7DACBB5; Tue,  9
        Oct 2018 14:30:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009133036eucas1p1d83ef6809a5696d6e2de1f3406afeeba~b897iNlSV1315713157eucas1p1e;
        Tue,  9 Oct 2018 13:30:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009133035eusmtrp1f63b93631a1e8d7cf16eceb36473d011~b897RbDM_0062100621eusmtrp1z;
        Tue,  9 Oct 2018 13:30:35 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d8-5bbcad7cf80f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.B3.04128.B7DACBB5; Tue,  9
        Oct 2018 14:30:35 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009133035eusmtip14f8eb000d3c3012e453861508103f51a~b8962msVB1546215462eusmtip1X;
        Tue,  9 Oct 2018 13:30:35 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Tue, 9 Oct 2018 15:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <221a185c-19fc-cc89-49b1-aa77fb1f0e41@ysoft.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRjve++Pe92cvY6bx4+pblarDRnLO8XSWrtpSf3Vuj90eEPcsXsR
        zZrNKCYK5beUQsZwHXH5sc5FfqasTZo/NDU/Y6kNHeX1Zvnv8/k8n+fzPM/2UJjsMeFERWsT
        WJ1WHasgJXhb3/qoe2pjp+rYZKMn88g8SjAtLz7jzPTHC8zb3BWCGTeWk8yf1RmCyegyi5lZ
        g8MpStlROiVW6uuzSGXL93aRclXvqpzbXMFCiCuSkxFsbHQSq/MMuCqJ2lz6SsbXyZMra2aw
        NGSwzUZWFNA+UJQ/RmYjCSWj6xDMfZvEBPITQebgECGQVQQfxnuI3Zat3nxcKNQiuFthEAlk
        GYG+00TyLjtaDeUDcxiP7Wl/6M4pRrwJo6dE8Mn8QMwXSNoP7t+uRzzGaTcwPn2znURRcvoy
        5A0f5mUpbQsDJTM4L1tt5wyMu/MyRu+H9NaynVWBbhND3fyIWPAnwcNqPcH7gT4D5SU+wtJ2
        MN9vEAvYBYYKcnChtwjB4sazf6QJQcNwn0hwnYDe/vc7QRh9BJqMnoIcCAXpS2Ih3wYmlmyF
        fWwgv60IE2Qp3MmUCe5D0FzTTO6Oze54jglYCWvT8+geOli658jSPZeV/p9bhbB65MAmcppI
        lvPWsjc8OLWGS9RGeoTHafRo+3GGtvp/taNuS5gJ0RRSWEuLta9UMkKdxKVoTAgoTGEvlb80
        qmTSCHXKTVYXF6pLjGU5E3KmcIWDtKayRSWjI9UJbAzLxrO63aqIsnJKQ97j8mukn6O3ZcHL
        rXj44nE8w2WxUc96zExYmxz3DdX6KiffBU5fz7BUVJ+2bCyYNGNmaZm/b27PF2XYJUN21VTo
        VCrzu9DLzXkgLaQh+EdrzNpizXRQ6vkn/nWagIiRxnXXLs5FcXb2VvJgXrBc71SoskS4hB/I
        CnptTi9ePqfAuSi111FMx6n/AqujQ0E0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rVa/dEG/Qvt7SYf+Qcq8XGzbdZ
        LB5e9bc40feB1eLyrjlsFv8/P2G1aN17hN3ixRZxBw6PnbPusntsWtXJ5rHx3Q4mj8+b5Dxe
        /v3AHMAapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJfx9+1TtoIVohXzlj1hbmDcItjFyMkhIWAi8e/wJJYuRi4OIYGljBJ7OrewdjFyACVkJI6v
        L4OoEZb4c62LDaLmLaPEkgPrGEESwgKJEnNOvmQGsUUEbCX29cxghCg6yiLx+8kPZhCHWeAu
        k8Sx/5/ZQarYBKwkJravYgTZwCtgJ9Fzwg0kzCKgIrFryVEmEFtUIELi1sMOFhCbV0BQ4uTM
        Jywg5ZxAC05e1gUJMwuoS/yZd4kZwpaXaN46m3kCo+AsJB2zkJTNQlK2gJF5FaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmAkbTv2c8sOxq53wYcYBTgYlXh4Z+TtjhZiTSwrrsw9xCjBwawk
        wiu6fVe0EG9KYmVValF+fFFpTmrxIUZToB8mMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZz3
        vEFllJBAemJJanZqakFqEUwfEwenVAPjtpslf/fM/nOtfotZxGp5bzn5r3W+D9Zd/bZxS7KL
        7C+ffrPdf4Ll3hUv33rtnsQmz9AFTHc/lq2YYm95x6c/bynfb3/dSf+3xL8pPfCd597fT1vn
        HjRV2iU4NVGi4uvf3TMmSs1pvGGw14n9PIfL43t/dwq8vNhjeD4uJ2RzyeIrHfPvPBPuiFJi
        Kc5INNRiLipOBADeFKs1ugIAAA==
Message-Id: <20181009133036eucas1p1d83ef6809a5696d6e2de1f3406afeeba~b897iNlSV1315713157eucas1p1e@eucas1p1.samsung.com>
X-CMS-MailID: 20181009133036eucas1p1d83ef6809a5696d6e2de1f3406afeeba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009002056epcas5p24207204c9e65e8f34382de6672adb993
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009002056epcas5p24207204c9e65e8f34382de6672adb993
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
        <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
        <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
        <20181009002031.GU3587@dragon>
        <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
        <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
        <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
        <221a185c-19fc-cc89-49b1-aa77fb1f0e41@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/09/2018 03:18 PM, Vokáč Michal wrote:
> On 9.10.2018 14:36, Fabio Estevam wrote:
>> Hi Michal,
>>
>> On Tue, Oct 9, 2018 at 5:30 AM Vokáč Michal <Michal.Vokac@ysoft.com> wrote:
>>
>>> Sorry for the inconvenience :( Lesson learned..
>>>
>>> So in other words (no offense): broken drivers need to stay broken because
>>> users may already get used to the broken behavior?
>>
>> In order to keep the old dtb's working you could introduce a new
>> property (like reset-gpio-active-low, for example).
>>
>> Then the driver behavior can be made untouched for the old dtb's and
>> only new dtb's with this new property would have the correct GPIO
>> reset behavior.
> 
> Thank you very much Fabio!
> I saw these xxx-active-low/high properties in many device tree
> sources wondering why the heck people use them when they could
> use GPIO_ACTIVE_LOW/HIGH. And this is the explanation.
> 
> And I feel like an idiot once again: git grep -l "reset-active-low"
> first hit is:
> 
>   Documentation/devicetree/bindings/display/ssd1307fb.txt
> 
> Oooops.
> The weird thing is that usage of reset-active-low is documented
> in the example but it is not implemented.
> 
> So the patch no.2 should be reverted and patch no.3 not applied at all.

OK, I've applied the patch below to fbdev-for-next tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From 64f83a816b27c7b5e026a74ecb5c61dbabfae997 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 9 Oct 2018 15:18:42 +0200
Subject: [PATCH] Revert "video: ssd1307fb: Do not hard code active-low reset
 sequence"

This reverts commit 9827f26374fb85e1811f2adbcc25c8a3992dbe7f.

On 10/09/2018 02:20 AM, Shawn Guo wrote:

> Well, it means the change breaks the ABI between kernel and device tree,
> e.g. the new kernel will not work with existing/installed DTBs.

Revert the change until DTB compatibility issue is resolved.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3b361bc..4061a20 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -667,10 +667,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value_cansleep(par->reset, 1);
-		udelay(4);
 		gpiod_set_value_cansleep(par->reset, 0);
 		udelay(4);
+		gpiod_set_value_cansleep(par->reset, 1);
+		udelay(4);
 	}
 
 	if (par->vbat_reg) {
-- 
1.9.1

