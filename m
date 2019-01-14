Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59320651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UtaNajKJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d/GHgWB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:32:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:32:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6613B60C87; Mon, 14 Jan 2019 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547472761;
        bh=+yPiNSs6fwfyne2sI22WJhU0Ta7asybjoTkohtRnVPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UtaNajKJTNkiamIHqN8L/P//8h0cQciA9Wjtn4o52oPpn0Yp+lnKw8Smjo4YbAgfi
         g+KDqgMqKOFUj9g23DqFAb4QtNk5KLZNZCeKQIUOuQII1e8igFouKeJpjhwZab/mYn
         lYXzcBeKV1+hq/t3QyKKUi7z/sPbzYr/zDUw+Pt8=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C3CB609CA;
        Mon, 14 Jan 2019 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547472747;
        bh=+yPiNSs6fwfyne2sI22WJhU0Ta7asybjoTkohtRnVPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d/GHgWB2H67CRvhSorxm3H1YjCC9FyD6jkt03EylhAwPPfgm5Ni9tD5pWu4DTrW3p
         Ko2Mgd9RdgMsME0Ng4IcqQSHQt7hY/L4onDp7TWtsu4f0P/B2iVwHhgd1uoI7/Fu0w
         cu6/+/GiGzGO7m/gkrjVrcNuwX2UYthBj+eXkULs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C3CB609CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: next/master boot bisection: next-20190114 on
 sun8i-h2-plus-libretech-all-h3-cc
To:     "kernelci.org bot" <bot@kernelci.org>,
        Ajit Pandey <ajitp@codeaurora.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, Mark Brown <broonie@kernel.org>,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <5c3c8a69.1c69fb81.668ce.4227@mx.google.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3a6a189b-4e58-5977-084d-fb1e82c1d684@codeaurora.org>
Date:   Mon, 14 Jan 2019 19:02:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5c3c8a69.1c69fb81.668ce.4227@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/2019 6:41 PM, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master boot bisection: next-20190114 on sun8i-h2-plus-libretech-all-h3-cc
>
> Summary:
>    Start:      8ce4d582f564 Add linux-next specific files for 20190114
>    Details:    https://kernelci.org/boot/id/5c3c411659b51457a76edd34
>    Plain log:  https://storage.kernelci.org//next/master/next-20190114/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.txt
>    HTML log:   https://storage.kernelci.org//next/master/next-20190114/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.html
>    Result:     8780cf1142a5 ASoC: soc-core: defer card probe until all component is added to list
>
> Checks:
>    revert:     PASS
>    verify:     PASS
>
> Parameters:
>    Tree:       next
>    URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>    Branch:     master
>    Target:     sun8i-h2-plus-libretech-all-h3-cc
>    CPU arch:   arm
>    Lab:        lab-baylibre
>    Config:     sunxi_defconfig
>    Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81
> Author: Ajit Pandey <ajitp@codeaurora.org>
> Date:   Wed Jan 9 14:17:07 2019 +0530
>
>      ASoC: soc-core: defer card probe until all component is added to list
>      
>      DAI component probe is not called if it is not present
>      in component list during sound card registration.
>      Check if component is available in component list for
>      platform and cpu dai before soundcard registration.
>      
>      Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>      Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>      Signed-off-by: Mark Brown <broonie@kernel.org>
The fix is already posted via 
https://lore.kernel.org/patchwork/patch/1031226/.

Mark, Can you pick this up. We will still have to consider intel platform

where there is no soc_component associated with platform_name.

Other solution is to revert this patch and use client specific defer 
probe as

done in v1.

https://lore.kernel.org/patchwork/patch/1027560/
https://lore.kernel.org/patchwork/patch/1027561/

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 0462b3ec977a..eec92f17dd15 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1027,7 +1027,6 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
>   				 struct snd_soc_dai_link *dai_link)
>   {
>   	struct snd_soc_dai_link_component *platform = dai_link->platform;
> -
>   	/*
>   	 * FIXME
>   	 *
> @@ -1129,6 +1128,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   			link->name);
>   		return -EINVAL;
>   	}
> +
> +	/*
> +	 * Defer card registartion if platform dai component is not added to
> +	 * component list.
> +	 */
> +	if (!soc_find_component(link->platform->of_node, link->platform->name))
> +		return -EPROBE_DEFER;
> +
>   	/*
>   	 * CPU device may be specified by either name or OF node, but
>   	 * can be left unspecified, and will be matched based on DAI
> @@ -1140,6 +1147,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   			link->name);
>   		return -EINVAL;
>   	}
> +
> +	/*
> +	 * Defer card registartion if cpu dai component is not added to
> +	 * component list.
> +	 */
> +	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
> +		return -EPROBE_DEFER;
> +
>   	/*
>   	 * At least one of CPU DAI name or CPU device name/node must be
>   	 * specified
> -------------------------------------------------------------------------------
>
>
> Git bisection log:
>
> -------------------------------------------------------------------------------
> git bisect start
> # good: [6b529fb0a3eabf9c4cc3e94c11477250379ce6d8] Merge tag 'for-5.0-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 6b529fb0a3eabf9c4cc3e94c11477250379ce6d8
> # bad: [8ce4d582f5647052b86f364a070aa26268810d7e] Add linux-next specific files for 20190114
> git bisect bad 8ce4d582f5647052b86f364a070aa26268810d7e
> # bad: [bb937d2e6697b49f6e3fa55ec09951ebbc8717ac] Merge remote-tracking branch 'crypto/master'
> git bisect bad bb937d2e6697b49f6e3fa55ec09951ebbc8717ac
> # bad: [04bab95e799a00ffe1b2980e1c786ac9a94f8026] Merge remote-tracking branch 'renesas/next'
> git bisect bad 04bab95e799a00ffe1b2980e1c786ac9a94f8026
> # bad: [5726796d7b631fe9af2202c1ce66232a79984a19] Merge remote-tracking branch 'devicetree-fixes/dt/linus'
> git bisect bad 5726796d7b631fe9af2202c1ce66232a79984a19
> # good: [34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d] Merge remote-tracking branch 'net/master'
> git bisect good 34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d
> # bad: [e1faf5c97ee3194c3f3e0b5dc86b3e1490c323d9] Merge remote-tracking branch 'usb-serial-fixes/usb-linus'
> git bisect bad e1faf5c97ee3194c3f3e0b5dc86b3e1490c323d9
> # good: [49ff71f99a8826eda5cee76b69f15600d1cbf4b2] Merge remote-tracking branch 'rdma-fixes/for-rc'
> git bisect good 49ff71f99a8826eda5cee76b69f15600d1cbf4b2
> # bad: [04eb1efcd614d6f067b76a355b3a3599667959dc] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()
> git bisect bad 04eb1efcd614d6f067b76a355b3a3599667959dc
> # good: [a41d9dbf5dac5b6a1283ee8001f22807d18352ea] ASoC: qdsp6: q6asm-dai: Fix a small memory leak
> git bisect good a41d9dbf5dac5b6a1283ee8001f22807d18352ea
> # good: [6175471755075d256c1c654151fc1cad183c1e33] ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks
> git bisect good 6175471755075d256c1c654151fc1cad183c1e33
> # good: [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661] ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages
> git bisect good 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661
> # bad: [239b8b34a856777e562373ae0de605536a7ccade] ASoC: Intel: Boards: move the codec PLL configuration to _init
> git bisect bad 239b8b34a856777e562373ae0de605536a7ccade
> # bad: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer card probe until all component is added to list
> git bisect bad 8780cf1142a59568a3aa77959cbd76b2edb6fd81
> # first bad commit: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer card probe until all component is added to list
> -------------------------------------------------------------------------------

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

