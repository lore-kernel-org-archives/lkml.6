Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2337C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912112145D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912112145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHQK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:28:01 -0400
Received: from mail.netline.ch ([148.251.143.178]:50323 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeHQK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 7F9472A604B;
        Fri, 17 Aug 2018 09:25:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id z_pZa2-pR9vz; Fri, 17 Aug 2018 09:25:38 +0200 (CEST)
Received: from thor (67.124.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.124.67])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id F26C92A6042;
        Fri, 17 Aug 2018 09:25:36 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fqZ8a-0002BZ-KE; Fri, 17 Aug 2018 09:25:36 +0200
Subject: Re: [PATCH 2/2] drm/amd/display: Don't build DCN1 when kcov is
 enabled
To:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, arnd@arndb.de
Cc:     airlied@linux.ie, Jordan.Lazare@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        harry.wentland@amd.com
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
 <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
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
Message-ID: <f94f6cc2-a743-ce30-9c5f-ac934f3fe61e@daenzer.net>
Date:   Fri, 17 Aug 2018 09:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-16 09:44 PM, sunpeng.li@amd.com wrote:
> From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
> 
> DCN1 contains code that utilizes fp math. When
> CONFIG_KCOV_INSTRUMENT_ALL and CONFIG_KCOV_ENABLE_COMPARISONS are
> enabled, build errors are found. See this earlier patch for details:
> 
> https://lists.freedesktop.org/archives/dri-devel/2018-August/186131.html
> 
> As a short term solution, disable CONFIG_DRM_AMD_DC_DCN1_0 when
> KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS are enabled. In
> addition, make it a fully derived config, taking into account
> CONFIG_X86.
> 
> Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 4c35625..ed654a7 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -4,18 +4,16 @@ menu "Display Engine Configuration"
>  config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
> +	select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and
>  	  Raven ASICs.
>  
>  config DRM_AMD_DC_DCN1_0
> -	bool "DCN 1.0 Raven family"
> -	depends on DRM_AMD_DC && X86
> -	default y
> +	def_bool n
>  	help
> -	  Choose this option if you want to have
> -	  RV family for display engine
> +	  RV family support for display engine
>  
>  config DEBUG_KERNEL_DC
>  	bool "Enable kgdb break in DC"
> 

Thanks Leo, Alex, Arnd et al for taking care of this! Apologies for the
trouble caused by my change, and for not helping much with the solution
(I was on vacation).

This series is

Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
