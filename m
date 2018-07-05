Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA7C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7324010
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7324010
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGENhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:37:25 -0400
Received: from mail.netline.ch ([148.251.143.178]:55386 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbeGENhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:37:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id E150F2A604A;
        Thu,  5 Jul 2018 15:37:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IV-pLKJkwz0B; Thu,  5 Jul 2018 15:37:15 +0200 (CEST)
Received: from thor (34.7.78.83.dynamic.wline.res.cust.swisscom.ch [83.78.7.34])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 6005B2A6046;
        Thu,  5 Jul 2018 15:37:15 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fb4Re-0006Kv-Ow; Thu, 05 Jul 2018 15:37:14 +0200
Subject: Re: [PATCH] drm/amd/display: Use 2-factor allocator calls
To:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Tony Cheng <Tony.Cheng@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vitaly Prosyak <vitaly.prosyak@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
References: <20180704172730.GA33562@beast>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 xsDiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPM0jTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD7CXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkLOwE0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpcJGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <5a3b3ab7-f5b2-bd66-0587-569411f9af78@daenzer.net>
Date:   Thu, 5 Jul 2018 15:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704172730.GA33562@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-04 07:27 PM, Kees Cook wrote:
> As already done treewide, switch from open-coded multiplication to
> 2-factor allocation helper.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 98edaefa2b47..ee69c949bfbf 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
>  		kvfree(rgb_regamma);
>  	} else if (trans == TRANSFER_FUNCTION_HLG ||
>  		trans == TRANSFER_FUNCTION_HLG12) {
> -		rgb_regamma = kvzalloc(sizeof(*rgb_regamma) *
> -				       (MAX_HW_POINTS + _EXTRA_POINTS),
> +		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
> +				       sizeof(*rgb_regamma),
>  				       GFP_KERNEL);
>  		if (!rgb_regamma)
>  			goto rgb_regamma_alloc_fail;
> @@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
>  		kvfree(rgb_degamma);
>  	} else if (trans == TRANSFER_FUNCTION_HLG ||
>  		trans == TRANSFER_FUNCTION_HLG12) {
> -		rgb_degamma = kvzalloc(sizeof(*rgb_degamma) *
> -				       (MAX_HW_POINTS + _EXTRA_POINTS),
> +		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
> +				       sizeof(*rgb_degamma),
>  				       GFP_KERNEL);
>  		if (!rgb_degamma)
>  			goto rgb_degamma_alloc_fail;
> 

Since the values are constant, kvcalloc incurs the overflow checking
overhead for no gain.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
