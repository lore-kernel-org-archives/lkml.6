Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE6125C70
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dTKkhAA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE6125C70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934591AbeFZKSo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:18:44 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53431 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZKSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:18:41 -0400
Received: by mail-wm0-f48.google.com with SMTP id x6-v6so1233489wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgySBqevSPaKeQNTkALusosVeVXr0rQR0JSlAC0NUqc=;
        b=dTKkhAA26j84zPoCuBQ55bnIqIh0r22WIrxWviXNS04jby9EX9YxRG2jgz4nAOdBWx
         PTZicxWUkPqfdZlqQiZl94OOQALNBKF4G8OS5GvH7w+5bVVCCfEYJxjz8n5fzBrL0DAh
         vHRyVrV5ecPPOISQ8/3rgCDmJPVSDXSNpmedwZmSk985+lDpoEQ8NHoZ6mwPWvpS+17m
         QRrlNAoCBQzs9PTkpoBFiEjCXVHdSrG9ZiYEj6hKTRZVNf+IKgypv1B3I4fL0yfxPutI
         KifxyGs+gTqlRJ7VCr7by1a9JMDTgBA0qPY3eIqCTFYtDtLQprnrcZLqAzeEzE6sDK5M
         /8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgySBqevSPaKeQNTkALusosVeVXr0rQR0JSlAC0NUqc=;
        b=k77f34nrsUikmrc8CuWYl1oVb6COp8VxUz6IOJRDZxtTOAibiMq2WPQo0f8r+cYtzD
         ZGE/CrNr42dyWMSJHNdRiQNPHYGoUnaB3ziARdTd5JPcGrmrFk/cyWZy2bzlz3P5Ggga
         FP3sqGCG9FtN7ZbXRk0947DfIb/iQHFsGvkVT3cE8XFFfCQR0Lg+A7ntFsM9SiwjoB5N
         Aqcuvg8xNd4rUAzqd3JPtqS2L+1r9Fh4d0w6t1Purj8zVX3KZqVPX42TnXW5OuWsz/4n
         PPJ9UiFEgXqRv785WR4CLEWwXzCNScSlw1306QJN8NaF1C/HcGGaLwHOFupvAAOFlhOf
         +P+A==
X-Gm-Message-State: APt69E1Im1NImMyFT1UbYMAb0Aj4jjSDVTN3O8yf8lPS0zBdN5cwNgNC
        hvYYixFrc6OWE2bFCWnn07qgqg==
X-Google-Smtp-Source: AAOMgpfjfqUNHNlsjkYzQn6y6K3giZENS8LfIQfJxNcdOp3P8BdgLZ9ry+/xjEa+5Loaa96bgqktIQ==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr1035911wmc.5.1530008320520;
        Tue, 26 Jun 2018 03:18:40 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14-v6sm2258329wrm.49.2018.06.26.03.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 03:18:39 -0700 (PDT)
Message-ID: <1530008318.2900.44.camel@baylibre.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     jiada_wang@mentor.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 12:18:38 +0200
In-Reply-To: <20180620092520.14101-1-jiada_wang@mentor.com>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 18:25 +0900, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> Current DPCM is caring only FE channel configuration. Sometimes
> it will be trouble if user selects channel which isn't supported
> by BE.
> 
> This patch adds new .dpcm_merged_chan on struct snd_soc_dai_link.
> DPCM will use FE / BE merged channel if struct snd_soc_dai_link
> has it.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  include/sound/soc.h |  2 ++
>  sound/soc/soc-pcm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 1378dcd2128a..f7579f82cc00 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -957,6 +957,8 @@ struct snd_soc_dai_link {
>  
>  	/* DPCM used FE & BE merged format */
>  	unsigned int dpcm_merged_format:1;
> +	/* DPCM used FE & BE merged channel */
> +	unsigned int dpcm_merged_chan:1;

Jiada, Mark,

Do you think we could extend this flag to let the link choose whether the merge
should be performed on the codec dais (as done here) or on the backend cpu dais
?

I have more less the same need as Jiada but since my card uses multicodec links,
merging on the codec dais does not work for me.

Like in soc_pcm_init_runtime_hw(), we can't enforce channels min/max based on
the codec when there is multiple codecs on the link.

Thx
Regards

Jerome

>  
>  	/* pmdown_time is ignored at stop */
>  	unsigned int ignore_pmdown_time:1;
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 45b52f7b9690..19ebfc958b9d 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1715,6 +1715,46 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
>  	return formats;
>  }
>  
> +static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
> +				   unsigned int *channels_min,
> +				   unsigned int *channels_max)
> +{
> +	struct snd_soc_pcm_runtime *fe = substream->private_data;
> +	struct snd_soc_dpcm *dpcm;
> +	int stream = substream->stream;
> +
> +	if (!fe->dai_link->dpcm_merged_chan)
> +		return;
> +
> +	*channels_min = 0;
> +	*channels_max = UINT_MAX;
> +
> +	/*
> +	 * It returns merged BE codec channel;
> +	 * if FE want to use it (= dpcm_merged_chan)
> +	 */
> +
> +	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
> +		struct snd_soc_pcm_runtime *be = dpcm->be;
> +		struct snd_soc_dai_driver *codec_dai_drv;
> +		struct snd_soc_pcm_stream *codec_stream;
> +		int i;
> +
> +		for (i = 0; i < be->num_codecs; i++) {
> +			codec_dai_drv = be->codec_dais[i]->driver;
> +			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +				codec_stream = &codec_dai_drv->playback;
> +			else
> +				codec_stream = &codec_dai_drv->capture;
> +
> +			*channels_min = max(*channels_min,
> +					    codec_stream->channels_min);
> +			*channels_max = min(*channels_max,
> +					    codec_stream->channels_max);
> +		}
> +	}
> +}
> +
>  static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
> @@ -1722,11 +1762,17 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
>  	u64 format = dpcm_runtime_base_format(substream);
> +	unsigned int channels_min = 0, channels_max = UINT_MAX;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback, format);
>  	else
>  		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture, format);
> +
> +	dpcm_runtime_base_chan(substream, &channels_min, &channels_max);
> +
> +	runtime->hw.channels_min = max(channels_min, runtime->hw.channels_min);
> +	runtime->hw.channels_max = min(channels_max, runtime->hw.channels_max);
>  }
>  
>  static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);

