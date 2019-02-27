Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0620BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9500C20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UkPG3ec5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfB0MUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:20:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34104 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfB0MUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:20:41 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190227122039euoutp020c39dad668d2b7caa0bc285ceee33e7a~HN_HMqwYJ2274322743euoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:20:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190227122039euoutp020c39dad668d2b7caa0bc285ceee33e7a~HN_HMqwYJ2274322743euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551270039;
        bh=NUwW/AFh0bsfWLietIb0xGpuT9FMUxI5g4DR7/qp2qo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UkPG3ec5QmDLXtKYYGZ0nwue4YuSQrYCTsulnulM8CORWPh/y856b/MGNAWdCJuN4
         dUjUTQihptOgGyJl9oPn1k02x56xuVwrzv8QvGwWw4iUG1O8QuI7InNaXyvRgLI/l0
         y9whAdnIntNGwZaPONNazC8lfURWxjJt1eAKEgVs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190227122038eucas1p1bdc00a0a74e34251ca2fbf3d93db49d4~HN_Get3E_1742517425eucas1p1t;
        Wed, 27 Feb 2019 12:20:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.3B.04441.690867C5; Wed, 27
        Feb 2019 12:20:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190227122037eucas1p266c2d023420b190f3b7dff0f46c7ad9b~HN_Fq89oU0435004350eucas1p2R;
        Wed, 27 Feb 2019 12:20:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190227122037eusmtrp1b8b41e2adec4adce1b4ca250f6be345b~HN_FcuCl82886128861eusmtrp1R;
        Wed, 27 Feb 2019 12:20:37 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-7c-5c7680963588
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.2C.04128.590867C5; Wed, 27
        Feb 2019 12:20:37 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190227122037eusmtip1761df410ef71acf4592618a24bd57fd0~HN_FHTl9Q0457204572eusmtip1M;
        Wed, 27 Feb 2019 12:20:37 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: make const array static
To:     Colin King <colin.king@canonical.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a10c5be3-9223-a1b7-a3d5-22d7ec6542eb@samsung.com>
Date:   Wed, 27 Feb 2019 13:20:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226165932.17528-1-colin.king@canonical.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87rTGspiDCa8UrLoPXeSyeL36l42
        i//bJjJbXPn6ns1i6y1pi86JS9gtLu+aw+bA7jGroZfNY++3BSwesztmsnps//aA1eN+93Em
        j8+b5ALYorhsUlJzMstSi/TtErgyDv5vZSyYw1HRPWcyWwPjR7YuRg4OCQETibYpSV2MnBxC
        AisYJebProKwvzBKrO9w7GLkArI/M0p8//eRFSQBUn//x11WiMRyRokzfw8yQjhvGSW2zpgM
        ViUs4Cbx+cRlRhBbROAYUPv8QhCbWcBRYt38OywgNpuApsTfzTfZQGxeATuJaZOPgtksAqoS
        R37cYAaxRQUiJA73vmOEqBGUODnzCVgvJ1D9473z2SFmyks0b53NDGGLS9x6Mp8J4tJt7BK3
        DtZA2C4ST59+YoawhSVeHd/CDmHLSJye3MMCYddLNM28wgzyjIRAB6PEicXL2SAS1hKHj19k
        BQUXM9DR63fpQ4QdJV5OXswCCUU+iRtvBSFO4JOYtG06M0SYV6KjTQiiWlHi/tmtUBeISyy9
        8JVtAqPSLCSPzULyzCwkz8xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYBI6
        /e/4px2MXy8lHWIU4GBU4uH9YVoaI8SaWFZcmXuIUYKDWUmEt7eoLEaINyWxsiq1KD++qDQn
        tfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDY9efxCKtD8k7zu08/DVAc9YOYffa
        ouByns6vyzi5p3mGmyWwXfvZcdncZYnhZEPXtUvbg76YqBRzBtqv/eEpt3v5qaSt3HJnUvsV
        FqUtD97wNmrvvg+9ForlrRPumq1eac5XuEwyK7e65USS1AElw8b+276cX7hCV2bJtJSJ9iTE
        /3tbZP9EiaU4I9FQi7moOBEAQeYEWj4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7pTG8piDPZ90rToPXeSyeL36l42
        i//bJjJbXPn6ns1i6y1pi86JS9gtLu+aw+bA7jGroZfNY++3BSwesztmsnps//aA1eN+93Em
        j8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQyDv5vZSyYw1HRPWcyWwPjR7YuRk4OCQETifs/7rJ2MXJxCAksZZS49uEoE0RCXGL3/LfM
        ELawxJ9rXWANQgKvGSUO7cgAsYUF3CQ+n7jMCGKLCJxglDi6qRjEZhZwlFg3/w4LxNCJjBLn
        nm8Ea2YT0JT4u/kmmM0rYCcxbfJRMJtFQFXiyI8bYMtEBSIkPj7dxwRRIyhxcuYTFhCbE6j+
        8d757BAL1CX+zLvEDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
        6bnFRnrFibnFpXnpesn5uZsYgdG37djPLTsYu94FH2IU4GBU4uH9YVoaI8SaWFZcmXuIUYKD
        WUmEt7eoLEaINyWxsiq1KD++qDQntfgQoynQcxOZpUST84GJIa8k3tDU0NzC0tDc2NzYzEJJ
        nPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA6OW1t6HXiosMrOSFhedW3b/Zo3UWoP0T28nW8zu
        42ctOXz9yr81Euvvar7ub+KSb+lVM99oku978fjV6qizeh9eNxRErZ1z52qpavri2rvB61nL
        U458cFQs1A1farh6edq71xvmHD4iGrP6jZyCw7dnBm01iiZWLeueqUXfdOPUKvO5cG0J9y4l
        luKMREMt5qLiRAClQeus1AIAAA==
X-CMS-MailID: 20190227122037eucas1p266c2d023420b190f3b7dff0f46c7ad9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190226165938epcas2p2aba05bf0a7b1b992ff2f71c0bfcffb6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190226165938epcas2p2aba05bf0a7b1b992ff2f71c0bfcffb6a
References: <CGME20190226165938epcas2p2aba05bf0a7b1b992ff2f71c0bfcffb6a@epcas2p2.samsung.com>
        <20190226165932.17528-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.2019 17:59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const array ti_sn_bridge_supply_names on the
> stack but instead make it static.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index f72ee137e5f1..4c2ca4e39be5 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -211,7 +211,7 @@ static struct ti_sn_bridge *bridge_to_ti_sn_bridge(struct drm_bridge *bridge)
>  static int ti_sn_bridge_parse_regulators(struct ti_sn_bridge *pdata)
>  {
>  	unsigned int i;
> -	const char * const ti_sn_bridge_supply_names[] = {
> +	static const char * const ti_sn_bridge_supply_names[] = {
>  		"vcca", "vcc", "vccio", "vpll",
>  	};
>  


