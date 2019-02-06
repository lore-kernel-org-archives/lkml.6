Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF67920823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l5198oGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfBFKSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:18:14 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44688 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBFKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:18:14 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190206101808epoutp024d80c7583b5ea6592df7c0386fa45951~AvwJF69J60878908789epoutp02C;
        Wed,  6 Feb 2019 10:18:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190206101808epoutp024d80c7583b5ea6592df7c0386fa45951~AvwJF69J60878908789epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549448288;
        bh=+hfuCQ2OkLcOCo4yTkiXbSL8MXk8GzdcQ5bF9jfJYEY=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=l5198oGQI/GfLm5sCpUMuBakoXxdI9Jk4dI3GJP3YlFRQ9wk7H4fJ4pSrjvEVzO3a
         0Bx3LowETuCkBmb/NWZpsWI9wyOMJgTBExa+ozWfNMB5H5P1aFTPlilfoBc5h7vQ66
         7dwBw1ZAtrqiKOa3D2/J0rLR59SAaNkyiyINaA08=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190206101807epcas1p2afc45db986ff5b4e31fe0d7c06f9d883~AvwH-xEVm0332003320epcas1p2s;
        Wed,  6 Feb 2019 10:18:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.AC.04074.F54BA5C5; Wed,  6 Feb 2019 19:18:07 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190206101806epcas1p4788ddeb1e8c89a92b2586d5725b592d1~AvwHQg_CJ1391913919epcas1p4s;
        Wed,  6 Feb 2019 10:18:06 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-1b-5c5ab45f5acd
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 3C.79.04015.E54BA5C5; Wed,  6 Feb
        2019 19:18:06 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMI00M8W1Y1BA90@mmp2.samsung.com>; Wed, 06 Feb 2019 19:18:06 +0900 (KST)
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in
 dapm_update_dai_unlocked
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <a1f95900-caa6-0dbd-3c8e-88a2d802163d@samsung.com>
Date:   Wed, 06 Feb 2019 11:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190206100549.GO3837@imbe.wolfsonmicro.main>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7bCmvm78lqgYgx2rmS2uXDzEZDH14RM2
        iyutmxgtzp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLzl39rBYbvq9ldODy2PC5ic1j56y7
        7B6bVnWyeUyf85/RY9/bZWwefVtWMXqs33KVxePzJrkAjigum5TUnMyy1CJ9uwSujBO7FrEV
        7OCoOHq0qIHxGVsXIyeHhICJxIUDk5m7GLk4hAR2MErcmnSJDcL5zijx4nEnC0zV10/bWCAS
        Gxgl3j9bAlV1n1GifV0TM0iVsECIxOwpS1lBbBEBI4mPx28xgRQxCxxlkli45h9YEZuAoUTv
        0T5GEJtXwE5i0b2dQDYHB4uAqsSa57EgYVGBCInDve+gSgQlfky+B3YFp4C1ROvbI2A2s4Cm
        xIsvk6BscYlj928yQtjyEpvXvAX7R0LgP5tER/s1qEddJM48WccKsktCQFri0lFbiHC1xK7t
        3VD1HYwSLRe2M0MkrCUOH7/ICjGUT+Ld1x6oXl6JjjYhiBIPib7FbdBQec4oMX/bNvYJjDKz
        kNw9C8mts5DcOgvJrQsYWVYxiqUWFOempxYbFhjqFSfmFpfmpesl5+duYgQnGC3THYxTzvkc
        YhTgYFTi4dXojowRYk0sK67MPcQowcGsJMJrPiMqRog3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        egfnGCGB9MSS1OzU1ILUIpgsEwenVAPjfAOBZ8/0d07JaxVSbnVImfvKz/HP3ll6wXxpHuk/
        F3Lf+dK8TyXn8I3ALfrzv62wDuGfy73o0cbMWTsMbx6z2vFik4Qgx+k3GRu1JlnO+MsYWM4z
        8+3DQIPjrqvtJX1TPY7f2+2389wvxjK+2d8vSGspNLn7ydo7KLSr6svmfdu5X03PwKNQiaU4
        I9FQi7moOBEA5SIStywDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e+xoG7clqgYg/e7hCyuXDzEZDH14RM2
        iyutmxgtzp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLzl39rBYbvq9ldODy2PC5ic1j56y7
        7B6bVnWyeUyf85/RY9/bZWwefVtWMXqs33KVxePzJrkAjigum5TUnMyy1CJ9uwSujBO7FrEV
        7OCoOHq0qIHxGVsXIyeHhICJxNdP21i6GLk4hATWMUocmriCCcJ5yCgx5d8zJpAqYYEQidlT
        lrKC2CICRhIfj98CK2IWOMwkcefiW6j2l4wSKy92MIJUsQkYSvQe7QOzeQXsJBbd2wlkc3Cw
        CKhKrHkeCxIWFYiQ+Ph0HxNEiaDEj8n3WEBsTgFrida3R1hAypkF1CWmTMkFCTMLiEscu3+T
        EcKWl9i85i3zBEaBWUi6ZyF0zELSMQtJxwJGllWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ
        +bmbGIHxs+2wVt8OxvtL4g8xCnAwKvHwXuiIjBFiTSwrrsw9xCjBwawkwms+IypGiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsYUL5GqRa/6egwrD6dZ
        LWFbtbaSU/HnDf+frx/s7P+7+Ztbm9Eb29Y//esLlql93VY3W373wZPyL940slnoZET5eb95
        Psf+8PyER1LfDSv2SbHEn5oZodH/wW/bro6yXcZpqqnPNC+GnI1TWz1J06fxrke/WUWytuW9
        RXr/uo5/vdjasL/t7UQlluKMREMt5qLiRAA3j4o6mwIAAA==
X-CMS-MailID: 20190206101806epcas1p4788ddeb1e8c89a92b2586d5725b592d1
CMS-TYPE: 101P
X-CMS-RootMailID: 20190205211638epcas3p409823d4acac8073473153d745151ea5f
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
        <20190205211622.GA5891@kozik-lap>
        <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
        <20190206100549.GO3837@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 11:05, Charles Keepax wrote:
> DAIs linked to the dummy will not have an associated playback/capture
> widget, so we need to skip the update in that case.
> 
> Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> ---
> 
> Ok so that all makes sense, this patch is probably the best fix?

It seems so, everything works well with such change, thank you.
 
>  sound/soc/soc-dapm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 482ddb825fb59..5235d8828758a 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2570,6 +2570,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
>  	else
>  		w = dai->capture_widget;
>  
> +	if (!w)
> +		return 0;
> +
>  	dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
>  		dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
>  
