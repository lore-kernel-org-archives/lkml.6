Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755016AbeE2Hvh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:51:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:42928 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754813AbeE2Hvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:51:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,455,1520924400";
   d="scan'208";a="228147767"
From: "Lin, Mengdong" <mengdong.lin@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: RE: [alsa-devel] [PATCH v2 2/3] ASoC: topology: Move v4 manifest
 header data structures to uapi
Thread-Topic: [alsa-devel] [PATCH v2 2/3] ASoC: topology: Move v4 manifest
 header data structures to uapi
Thread-Index: AQHT85hogWb7c3XjJUSOqT245FM3iqRGWlpQ
Date: Tue, 29 May 2018 07:51:24 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8828095D9@SHSMSX103.ccr.corp.intel.com>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <1527191363-21021-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1527191363-21021-2-git-send-email-linux@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDU3NmQ1NTAtZDQ3NC00OTE5LWFmMzctNjIyOTI4NjIxMzJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJwR2ZJNmxucGJmblJZVDBIZE1yMUhBUUVvTHhPZTBJVWxSZkw3eWIxN2dNNzFaelFPS3cwYWZzRVFIVGJiczF1In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
> project.org] On Behalf Of Guenter Roeck
> Sent: Friday, May 25, 2018 3:49 AM

> From: Guenter Roeck <groeck@chromium.org>
> 
> Topology manifest v4 is still part of the ABI. Move its data structures into the
> uapi header file.
> 
> No functional change.

It looks good. The v4 version of topology ABI should be in uapi header file.

Previously, we hid the v4 ABI in kernel and hoped people stop using it. But the topology files of old ABI were already shipped out and backward compatibility issue has been there. Thanks for fixing this.

Thanks
Mengdong

> 
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> ---
> v2: Added patch to series
> 
>  include/uapi/sound/asoc.h | 57
> +++++++++++++++++++++++++++++++++++++++
>  sound/soc/soc-topology.c  | 56 --------------------------------------
>  2 files changed, 57 insertions(+), 56 deletions(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h index
> 69c37ecbff7e..a9df4900789c 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -552,4 +552,61 @@ struct snd_soc_tplg_dai {
>  	__le32 flags;           /* SND_SOC_TPLG_DAI_FLGBIT_* */
>  	struct snd_soc_tplg_private priv;
>  } __attribute__((packed));
> +
> +/*
> + * Old version of ABI structs, supported for backward compatibility.
> + */
> +
> +/* Manifest v4 */
> +struct snd_soc_tplg_manifest_v4 {
> +	__le32 size;		/* in bytes of this structure */
> +	__le32 control_elems;	/* number of control elements */
> +	__le32 widget_elems;	/* number of widget elements */
> +	__le32 graph_elems;	/* number of graph elements */
> +	__le32 pcm_elems;	/* number of PCM elements */
> +	__le32 dai_link_elems;	/* number of DAI link elements */
> +	struct snd_soc_tplg_private priv;
> +} __packed;
> +
> +/* Stream Capabilities v4 */
> +struct snd_soc_tplg_stream_caps_v4 {
> +	__le32 size;		/* in bytes of this structure */
> +	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
> +	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
> +	__le32 rate_min;	/* min rate */
> +	__le32 rate_max;	/* max rate */
> +	__le32 channels_min;	/* min channels */
> +	__le32 channels_max;	/* max channels */
> +	__le32 periods_min;	/* min number of periods */
> +	__le32 periods_max;	/* max number of periods */
> +	__le32 period_size_min;	/* min period size bytes */
> +	__le32 period_size_max;	/* max period size bytes */
> +	__le32 buffer_size_min;	/* min buffer size bytes */
> +	__le32 buffer_size_max;	/* max buffer size bytes */
> +} __packed;
> +
> +/* PCM v4 */
> +struct snd_soc_tplg_pcm_v4 {
> +	__le32 size;		/* in bytes of this structure */
> +	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	__le32 pcm_id;		/* unique ID - used to match with DAI link */
> +	__le32 dai_id;		/* unique ID - used to match */
> +	__le32 playback;	/* supports playback mode */
> +	__le32 capture;		/* supports capture mode */
> +	__le32 compress;	/* 1 = compressed; 0 = PCM */
> +	struct snd_soc_tplg_stream
> stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
> +	__le32 num_streams;	/* number of streams */
> +	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture
> +for DAI */ } __packed;
> +
> +/* Physical link config v4 */
> +struct snd_soc_tplg_link_config_v4 {
> +	__le32 size;            /* in bytes of this structure */
> +	__le32 id;              /* unique ID - used to match */
> +	struct snd_soc_tplg_stream
> stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback
> and captrure */
> +	__le32 num_streams;     /* number of streams */
> +} __packed;
> +
>  #endif
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c index
> d66b2e5ccd67..40753c6a2554 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -54,62 +54,6 @@
>  #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
>  #define SOC_TPLG_PASS_END	SOC_TPLG_PASS_LINK
> 
> -/*
> - * Old version of ABI structs, supported for backward compatibility.
> - */
> -
> -/* Manifest v4 */
> -struct snd_soc_tplg_manifest_v4 {
> -	__le32 size;		/* in bytes of this structure */
> -	__le32 control_elems;	/* number of control elements */
> -	__le32 widget_elems;	/* number of widget elements */
> -	__le32 graph_elems;	/* number of graph elements */
> -	__le32 pcm_elems;	/* number of PCM elements */
> -	__le32 dai_link_elems;	/* number of DAI link elements */
> -	struct snd_soc_tplg_private priv;
> -} __packed;
> -
> -/* Stream Capabilities v4 */
> -struct snd_soc_tplg_stream_caps_v4 {
> -	__le32 size;		/* in bytes of this structure */
> -	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> -	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
> -	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
> -	__le32 rate_min;	/* min rate */
> -	__le32 rate_max;	/* max rate */
> -	__le32 channels_min;	/* min channels */
> -	__le32 channels_max;	/* max channels */
> -	__le32 periods_min;	/* min number of periods */
> -	__le32 periods_max;	/* max number of periods */
> -	__le32 period_size_min;	/* min period size bytes */
> -	__le32 period_size_max;	/* max period size bytes */
> -	__le32 buffer_size_min;	/* min buffer size bytes */
> -	__le32 buffer_size_max;	/* max buffer size bytes */
> -} __packed;
> -
> -/* PCM v4 */
> -struct snd_soc_tplg_pcm_v4 {
> -	__le32 size;		/* in bytes of this structure */
> -	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> -	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> -	__le32 pcm_id;		/* unique ID - used to match with DAI link */
> -	__le32 dai_id;		/* unique ID - used to match */
> -	__le32 playback;	/* supports playback mode */
> -	__le32 capture;		/* supports capture mode */
> -	__le32 compress;	/* 1 = compressed; 0 = PCM */
> -	struct snd_soc_tplg_stream
> stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
> -	__le32 num_streams;	/* number of streams */
> -	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture
> for DAI */
> -} __packed;
> -
> -/* Physical link config v4 */
> -struct snd_soc_tplg_link_config_v4 {
> -	__le32 size;            /* in bytes of this structure */
> -	__le32 id;              /* unique ID - used to match */
> -	struct snd_soc_tplg_stream
> stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback
> and captrure */
> -	__le32 num_streams;     /* number of streams */
> -} __packed;
> -
>  /* topology context */
>  struct soc_tplg {
>  	const struct firmware *fw;
> --
> 2.17.0.441.gb46fe60e1d-goog
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
