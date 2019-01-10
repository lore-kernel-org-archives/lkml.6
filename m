Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F73C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4EC214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfAJJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:34:34 -0500
Received: from mail.netline.ch ([148.251.143.178]:34799 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:34:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 4AE732A605C;
        Thu, 10 Jan 2019 10:34:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BNYCLC4Bhzyw; Thu, 10 Jan 2019 10:34:29 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 46A492A6059;
        Thu, 10 Jan 2019 10:34:29 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.92-RC4)
        (envelope-from <michel@daenzer.net>)
        id 1ghWjM-0001mb-Rw; Thu, 10 Jan 2019 10:34:28 +0100
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Carsten.Haitzler@arm.com, David Airlie <airlied@linux.ie>,
        will.deacon@arm.com, dri-devel@lists.freedesktop.org,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        Bernhard.Rosenkranzer@linaro.org
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
Date:   Thu, 10 Jan 2019 10:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-10 8:28 a.m., Ard Biesheuvel wrote:
> ARM systems do not permit the use of anything other than cached
> mappings for system memory, since that memory may be mapped in the
> linear region as well, and the architecture does not permit aliases
> with mismatched attributes.
> 
> So short-circuit the evaluation in ttm_io_prot() if the flags include
> TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
> attributes immediately.
> 
> This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
> Without this change, amdgpu does not start at all, and radeon only
> produces corrupt display output.
> 
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 046a6dda690a..0c1eef5f7ae3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>  	if (caching_flags & TTM_PL_FLAG_CACHED)
>  		return tmp;
>  
> +#if defined(__arm__) || defined(__aarch64__)
> +	/* ARM only permits cached mappings of system memory */
> +	if (caching_flags & TTM_PL_SYSTEM)
> +		return tmp;
> +#endif
>  #if defined(__i386__) || defined(__x86_64__)
>  	if (caching_flags & TTM_PL_FLAG_WC)
>  		tmp = pgprot_writecombine(tmp);
> 

Apart from Christian's concerns, I think this is the wrong place for
this, because other TTM / driver code will still consider the memory
uncacheable. E.g. the amdgpu driver will program the GPU to treat the
memory as uncacheable, so it won't participate in cache coherency
protocol for it, which is unlikely to work as expected in general if the
CPU treats the memory as cacheable.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
