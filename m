Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pm+9TZ5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ED720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeIJR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:29:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6080 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:29:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b96651c0000>; Mon, 10 Sep 2018 05:35:40 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Sep 2018 05:35:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Sep 2018 05:35:37 -0700
Received: from DRHQMAIL101.nvidia.com (10.27.9.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Sep
 2018 12:35:37 +0000
Received: from [10.21.132.133] (10.124.1.5) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Sep
 2018 12:35:35 +0000
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20180711144403.1022829-1-arnd@arndb.de>
 <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
 <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
 <20180907114255.7j7r6wzolnz5qkk7@flea>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <27a7c704-26c9-5b51-68d4-e6b57b30cadf@nvidia.com>
Date:   Mon, 10 Sep 2018 13:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907114255.7j7r6wzolnz5qkk7@flea>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 DRHQMAIL101.nvidia.com (10.27.9.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1536582940; bh=6x52rPnmdS9n4pTWD00BQu/PaMEzJUfYaY/AQsk9N20=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pm+9TZ5RFn4JEUaGjblbjBFK1LhZItccrMRjOXtSmE/anF/PGmhj2l0NeMOdq7obD
         XCVoDgesYYp7pD+2vL63JvDXY6ixXAahmLAz/N54czgpo6KhYBfwDDEaKKJJTPGUdm
         DFab7ke9CCLpXeVEUU7jodU31xFXmGHD4GUiW5NP16mYqY+3xv2fKpX0BzgVhhq/QD
         MTgrv8afgluIqDt3XzASIqpM9M7+lrE5xp66WnX44c2qF3NcSbg/r29SJkZYNpgKwI
         Qe1LaQB3vsYEFMvCmOazeK7Xy/ufgLGbC9aIwOdJOx5RXG0aRt8WWVW/KXFbR5ExDN
         +B5ueHQ9IzEjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/09/18 12:42, Maxime Ripard wrote:
> On Fri, Sep 07, 2018 at 01:26:30PM +0200, Arnd Bergmann wrote:
>> On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>>
>>> On 11/07/18 15:43, Arnd Bergmann wrote:
>>>> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>>>> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>>>>
>>>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>>>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>>>>
>>>> This solves the problem by adding a silent symbol for the tcon_top module,
>>>> building it as a separate module in exactly the cases that we need it,
>>>> but in a way that it is reachable by the other modules.
>>>>
>>>> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
>>>> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> I am seeing the following on today's -next (20180907) as well the last
>>> few -next versions for that matter ...
>>>
>>> ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>>> ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>>>
>>> Seems like this issue has cropped up again as Arnd's fix is present. I
>>> am seeing this on ARM64 builds.
>>
>> I have not started build testing on linux-next since the merge window, but
>> looking at the changes that got queued up, I find commits cf77d79b4e29
>> ("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
>> 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
>> introduced a reference to the tcon_top file from sun4i_tcon.c.
>>
>> More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
>> the caller like I did in my patch would help, or alternatively one could
>> decide to give up and just always include the TCON_TOP.
> 
> Sorry for the breakage.
> 
> Can you test:
> 
> ----8<----
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 4834c90b4912..c78cd35a1294 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -974,7 +974,8 @@ static bool sun4i_tcon_connected_to_tcon_top(struct device_node *node)
>  
>  	remote = of_graph_get_remote_node(node, 0, -1);
>  	if (remote) {
> -		ret = !!of_match_node(sun8i_tcon_top_of_table, remote);
> +		ret = !!(IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> +			 of_match_node(sun8i_tcon_top_of_table, remote));
>  		of_node_put(remote);
>  	}
>  
> @@ -1402,13 +1403,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
>  	if (!pdev)
>  		return -EINVAL;
>  
> -	if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
> +	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> +	    encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
>  		ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
> +	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
> +		ret = sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
> ----8<----

Yes works for me! Thanks, Jon

-- 
nvpublic
