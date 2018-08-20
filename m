Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FCBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7801B21536
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QYt+QLGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7801B21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeHTMHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:07:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48027 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:07:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180820085244euoutp029e8e06d4856a3c5b52039144c8f5150d~Mi7DVDG5w0981509815euoutp02K
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 08:52:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180820085244euoutp029e8e06d4856a3c5b52039144c8f5150d~Mi7DVDG5w0981509815euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534755164;
        bh=MKfMg87Fj3etpJMWc8Sbh593webe/msY8JiQyCJwmrU=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=QYt+QLGzPrdGfhY77EBUEJFy17bIm1OUQf1WoLLkTj/IDVnrs2BDn1ePlesVknash
         udaePCEGTs2d5gRSBKbE2Xc9t6wE6/6CftfXxnHYkBJtbxYzRs2y260PKXh9FjnX+v
         j2ICEoK5/zu1H0AsQxJ3rTIzijIFmM5fzutXvSeQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180820085243eucas1p222f8857864867f0f80a95ed7472ebeb0~Mi7Cs9qRD1035710357eucas1p2g;
        Mon, 20 Aug 2018 08:52:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.ED.04441.B518A7B5; Mon, 20
        Aug 2018 09:52:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180820085242eucas1p23f693665452400f3a57676393ce08939~Mi7BqhC1Y0964309643eucas1p2V;
        Mon, 20 Aug 2018 08:52:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180820085242eusmtrp1231d3c30bd59b3cb375683165d520334~Mi7Bb_s4n1030310303eusmtrp1y;
        Mon, 20 Aug 2018 08:52:42 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c4-5b7a815bbd67
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.B4.04128.A518A7B5; Mon, 20
        Aug 2018 09:52:42 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180820085242eusmtip22fda597dafc966afeb6ea64c686f4ae6~Mi7BCLzPH0393703937eusmtip2a;
        Mon, 20 Aug 2018 08:52:42 +0000 (GMT)
Subject: Re: Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
To:     RaviChandra Sadineni <ravisadineni@chromium.org>,
        dmitry.torokhov@gmail.com, ravisadineni@google.com,
        dtor@google.com, linux-samsung-soc@vger.kernel.org,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, tfiga@chromium.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 20 Aug 2018 10:52:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817212135.222689-1-ravisadineni@chromium.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7rRjVXRBsubNSwOL3rBaDH/ZSe7
        xc1P31gtLu+aw2Yx4/w+Jot1Ld8YLc6//c1qsej7Q1aLz63/2Bw4PWY3XGTx2DnrLrvHgk2l
        Hp83yQWwRHHZpKTmZJalFunbJXBlrNu/g6ngDF/Fh+YXzA2Mt7i7GDk4JARMJL5/0Opi5OIQ
        EljBKNHdeZEVwvnCKPGlZzoThPOZUWLR4qXMXYycYB2XN61iA7GFBJYzSvSeCYMoes8ocbdr
        AytIQlggQOJC0zJmkISIQBuTxOONHWAJNgFDia63XWDdLAKqEhOaNzKD3CEqECPxe5c1SJhX
        QFDi5MwnLCA2p4CDxNbz18BsZgF5ie1v5zBD2OISt57MB7tOQmAdu8TV9V9YIZrLJFrO7oW6
        1EXiZ9MPdghbWOLV8S1QtozE6ck9LBDNzYwS7TNmsUM4PYwSW+fsYIOospY4fBwUGhxA6zQl
        1u/Shwg7Sux6t5ANEnh8EjfeCkIcxCcxadt0Zogwr0RHmxBEtZrErOPr4NYevHAJ6jQPiYOH
        HzFPYFScheTlWUjenIXkzVkINyxgZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmIpO
        /zv+aQfj10tJhxgFOBiVeHgXXK2MFmJNLCuuzD3EKMHBrCTCe/UHUIg3JbGyKrUoP76oNCe1
        +BCjNAeLkjgvn1ZatJBAemJJanZqakFqEUyWiYNTqoFxwaSTK3njufg52/ydluq796qtuON7
        7bz5Ud/Jhue4J2S037N6k1Ol8v9R8KT+g1UtOp/eq9zofnFTq287l8OxXfcLbq0u15Zc3Kgg
        s9d5OZvh5HK50ji3iE0Xlz2QOv/G1KR82879D/KUtOyWzgvvu3kqKkRkjeG09N1GRvfFbWpN
        ryrw+3srsRRnJBpqMRcVJwIAuW9G5EEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7pRjVXRBmsnKVkcXvSC0WL+y052
        i5ufvrFaXN41h81ixvl9TBbrWr4xWpx/+5vVYtH3h6wWn1v/sTlwesxuuMjisXPWXXaPBZtK
        PT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DLWLd/B1PBGb6KD80vmBsYb3F3MXJySAiYSFzetIqti5GLQ0hgKaPEq+2dbBAJGYmT0xpY
        IWxhiT/XuqCK3jJK7G9+BVYkLOAncejeOVaQhIhAC5PEwY4VLBBVDUwSbx5tYAKpYhMwlOh6
        C9LOwcErYCexoCsOJMwioCoxoXkjM4gtKhAjcXRyC9hQXgFBiZMzn7CA2JwCDhJbz18Ds5kF
        zCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGwVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSK
        E3OLS/PS9ZLzczcxAuNs27GfW3Ywdr0LPsQowMGoxMO74GpltBBrYllxZe4hRgkOZiUR3qs/
        gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wBeSXxhqaG5haWhubG5sZmFkrivOcNKqOE
        BNITS1KzU1MLUotg+pg4OKUaGPc3s+j/ULmz4BLHtrt9Mh0mQbOPtM29+UBwt4hD7DNGZsbV
        tbyW0tPKXmjkM27yzEycdEjerlV/wdM3U/h9bcqDeKbuYT13aIvYg+ybj2wdb2Twndo5MTzc
        Tuz9k01fFz7zF+t+8++FwseD7dMP7V3yfNbPmcF8S3/utNjl5WVauOto8XNODRElluKMREMt
        5qLiRACcQVZMyQIAAA==
Message-Id: <20180820085242eucas1p23f693665452400f3a57676393ce08939~Mi7BqhC1Y0964309643eucas1p2V@eucas1p2.samsung.com>
X-CMS-MailID: 20180820085242eucas1p23f693665452400f3a57676393ce08939
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180817212153epcas2p4aa217751a7d24f1ababc6038d2e4c9b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180817212153epcas2p4aa217751a7d24f1ababc6038d2e4c9b7
References: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
        <CGME20180817212153epcas2p4aa217751a7d24f1ababc6038d2e4c9b7@epcas2p4.samsung.com>
        <20180817212135.222689-1-ravisadineni@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 2018-08-17 23:21, RaviChandra Sadineni wrote:
> From: RaviChandra Sadineni <ravisadineni@google.com>
>
> hi Merek,
>
> Unfortunately I could not get the device to boot even after using the exynos_defconfig.
> Can you please try this patch and see if this fixes the issue. If not can you enable the
> debug logs and send me the logs.
>
>
> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up getting key state of
> the keyboard in a loop and block the resume. Instead check for events only
> if  mkbp is supported.
>
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>

This patch fixes the suspend/resume issue on Snow and Peach-Pit
Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
2018.

Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

A small hint: to merge it please resend with proper subject and put the note
should be after '---' mark, so it will be dropped by the 'git am' command.

> ---
>   drivers/mfd/cros_ec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 65a9757a6d21..fe6f83766144 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -218,7 +218,8 @@ EXPORT_SYMBOL(cros_ec_suspend);
>   
>   static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>   {
> -	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
> +	while (ec_dev->mkbp_event_supported &&
> +	       cros_ec_get_next_event(ec_dev, NULL) > 0)
>   		blocking_notifier_call_chain(&ec_dev->event_notifier,
>   					     1, ec_dev);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

