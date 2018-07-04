Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7DBC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5089323E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l+Fat8WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089323E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGDOkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:40:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51697 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeGDOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:40:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180704144041euoutp01522d35499e5aa3321de2a65e4f8f08ea~_MWbmib2h1189811898euoutp01F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 14:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180704144041euoutp01522d35499e5aa3321de2a65e4f8f08ea~_MWbmib2h1189811898euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530715241;
        bh=ViErpBxmkBSAXsDZJHqlMyRS+HgbOHmoCfSfVH5tp8Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l+Fat8WZXvXXDJO4/1zR6dOBsS4yeA2MX6EbgXYLNw6sNwfC99O0H+bmgQq/j6EPc
         lqlh9HnO/XMWCFGb6FR1U3DFKrufqIexAvtennnt0uO3BoTQg0jW9DODVznGcXJbmr
         gTaieyWki94v5YdfjGH8tYbwuo2io17ETBHHhD4s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704144040eucas1p147305bcaf5a5666a92ff9bde6d814410~_MWaf7pj_0568905689eucas1p1o;
        Wed,  4 Jul 2018 14:40:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.34.17380.76CDC3B5; Wed,  4
        Jul 2018 15:40:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180704144039eucas1p1fa0fd905d195acd4f37f3f457c7ab826~_MWZx9wta1767417674eucas1p1x;
        Wed,  4 Jul 2018 14:40:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180704144039eusmtrp106afd8bbdc0a8a895e177c4becf04b62~_MWZjKVFf2015320153eusmtrp1j;
        Wed,  4 Jul 2018 14:40:39 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-e8-5b3cdc6786fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.7B.04178.76CDC3B5; Wed,  4
        Jul 2018 15:40:39 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180704144038eusmtip14f51d719f49a49220392905f333d5786~_MWZMR8qy1857218572eusmtip1i;
        Wed,  4 Jul 2018 14:40:38 +0000 (GMT)
Subject: Re: [PATCH 3/3] drm/bridge/sii8620: Fix link mode selection
To:     Maciej Purski <m.purski@samsung.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Wed, 4 Jul 2018 16:40:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530204243-6370-4-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7rpd2yiDdonWVj0njvJZNHU8ZbV
        YuOM9awWV76+Z7PonLiE3eLyrjlsFgte3mKxWHvkLrsDh8flvl4mj9kdM1k9tn97wOpxv/s4
        k0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl/N08i7HgqGDFiQmeDYwb+boYOTkkBEwkJlzf
        yNbFyMUhJLCCUaK3uZ8JJCEk8IVRYv/VSIjEZ0aJj6tWMncxcoB1dD5Vg4gvZ5SYM3MJVPdb
        RonTk9axg3QLC7hI3J9xhQ2kQUTAU+LkqXKQMLNAB5PE6p91IDabgKbE38032UBsFgEVifYb
        vWC2qECExMYJn5hBbF4BQYmTM5+wgNicQCP3/ZvDBDFHXmL72znMELa4xK0n85lAbpAQOMQu
        0f1tHgtEc5nEkvlrmSDedJG41dIBZQtLvDq+hR3ClpE4PbmHBcKul2iaeYUZYlAHo8SJxcvZ
        IBLWEoePX2QFeYYZ6Or1u/QhAeEocXIuG4TJJ3HjrSDEOXwSk7ZNhwYVr0RHmxDEDEWJ+2e3
        MkPY4hJLL3xlm8CoNAvJk7OQPDYLyWOzENYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpec
        n7uJEZiOTv87/mUH464/SYcYBTgYlXh4Dc7ZRAuxJpYVV+YeYpTgYFYS4a3eDBTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpgXKc/2Wj+RN57PDX/tSPZ
        bgUERT207rfeY2zkfeDeU22WtxKmfFYtuRtY1zb/Z6jI3L6rSWpR/Q1nK8aTrv7xH67eX+di
        d/CouL7PjgUuN46lxyoqydVND2n8cNa+MVTphojuIdE//G+mPJmz8fJ0p6nP1+ku4cv46LHZ
        dGvE3dbf8cwrD7wLVWIpzkg01GIuKk4EAFyT9EtDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rpd2yiDZZc5rToPXeSyaKp4y2r
        xcYZ61ktrnx9z2bROXEJu8XlXXPYLBa8vMVisfbIXXYHDo/Lfb1MHrM7ZrJ6bP/2gNXjfvdx
        Jo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnN
        ySxLLdK3S9DL+Lt5FmPBUcGKExM8Gxg38nUxcnBICJhIdD5V62Lk4hASWMoo8W39E7YuRk6g
        uLjE7vlvmSFsYYk/17rYIIpeM0pMPHEMLCEs4CJxf8YVNpBBIgKeEidPlYPUMAt0MUnsff2O
        HaLhIqPE03+f2UEa2AQ0Jf5uvgm2gVfATuLNlqOsIDaLgIpE+41esLioQIRE07w17BA1ghIn
        Zz5hAbE5gZbt+zeHCcRmFlCX+DPvEjOELS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMw23Hfm7ewXhpY/AhRgEORiUe3hunbaKF
        WBPLiitzDzFKcDArifBWbwYK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wReSVxBuaGppb
        WBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamBU8wiQYD0w43X/h7Xv3Azl2wO3
        hPw9fXhl4uRyoZKv8RJmYmERq44wr5zVl26lLnh1D4ecvrSGzYQAnikfn069YPy68ezv+u/c
        H5hW67Cn8Cq0G/Eurm4pm5940ueF8bb2koIdy7YfONOhU/n7eqtc/GXpm5kBio0hW8wszk07
        sOWxcZXy3tdKLMUZiYZazEXFiQDn0mBF2QIAAA==
Message-Id: <20180704144039eucas1p1fa0fd905d195acd4f37f3f457c7ab826~_MWZx9wta1767417674eucas1p1x@eucas1p1.samsung.com>
X-CMS-MailID: 20180704144039eucas1p1fa0fd905d195acd4f37f3f457c7ab826
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91
References: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
        <CGME20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91@eucas1p1.samsung.com>
        <1530204243-6370-4-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2018 18:44, Maciej Purski wrote:
> Current link mode values do not allow to enable packed pixel modes.
>
> Select packed pixel clock mode, if needed, every time the link mode
> register gets updated.
>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

Queued all three patches to drm-misc-fixes.

Regards
Andrzej

> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 16fe7ea..a6e8f45 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -1165,8 +1165,14 @@ static void sii8620_start_video(struct sii8620 *ctx)
>  	sii8620_set_format(ctx);
>  
>  	if (!sii8620_is_mhl3(ctx)) {
> -		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
> -			MHL_DST_LM_CLK_MODE_NORMAL | MHL_DST_LM_PATH_ENABLED);
> +		u8 link_mode = MHL_DST_LM_PATH_ENABLED;
> +
> +		if (ctx->use_packed_pixel)
> +			link_mode |= MHL_DST_LM_CLK_MODE_PACKED_PIXEL;
> +		else
> +			link_mode |= MHL_DST_LM_CLK_MODE_NORMAL;
> +
> +		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE), link_mode);
>  		sii8620_set_auto_zone(ctx);
>  	} else {
>  		static const struct {
> @@ -1677,14 +1683,18 @@ static void sii8620_status_dcap_ready(struct sii8620 *ctx)
>  
>  static void sii8620_status_changed_path(struct sii8620 *ctx)
>  {
> -	if (ctx->stat[MHL_DST_LINK_MODE] & MHL_DST_LM_PATH_ENABLED) {
> -		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
> -				      MHL_DST_LM_CLK_MODE_NORMAL
> -				      | MHL_DST_LM_PATH_ENABLED);
> -	} else {
> -		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
> -				      MHL_DST_LM_CLK_MODE_NORMAL);
> -	}
> +	u8 link_mode;
> +
> +	if (ctx->use_packed_pixel)
> +		link_mode = MHL_DST_LM_CLK_MODE_PACKED_PIXEL;
> +	else
> +		link_mode = MHL_DST_LM_CLK_MODE_NORMAL;
> +
> +	if (ctx->stat[MHL_DST_LINK_MODE] & MHL_DST_LM_PATH_ENABLED)
> +		link_mode |= MHL_DST_LM_PATH_ENABLED;
> +
> +	sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
> +			      link_mode);
>  }
>  
>  static void sii8620_msc_mr_write_stat(struct sii8620 *ctx)


