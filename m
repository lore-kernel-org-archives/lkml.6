Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525038104; cv=none;
        d=google.com; s=arc-20160816;
        b=K39QqyWjFrxU0trmGmRl/oNFuLTju2/CTqGZfYBx6V+E8jli7n2s8/GNNpxefM2ygE
         drwGlH0IDSD+KNAuD2lK6iaIw5JPKOKoQluyJ90ZZXF1vBvxCm2/MTb5fGqlRT5cdzdM
         IovNJcB6gug6Rl4i2WxqisZtAvRctrttQZwE4ckj/Veplchm31vZaXw7qDyT3l4LAxlt
         DcJPY92tCsBlpEyvTw/iwxmqX1m2vKWw97vhYtTfyMaWm88gGljOzaQoqh9L5IAbo09R
         UBCbscp9F3dRh/wxW4Wke45fsDXip7J3MD0TkLPi2HtRBNLFCTDpuzGA1avcG+YeC0ls
         7Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CVuroqaiFi/nJ+AkLvfittsBicxeaPCduLCJ03ILoPs=;
        b=0f2Y21Wg2ENeV9GAYOF8Xkfv59DVTYapFdIQYxweTpMRReZTdHs5KVA7NvK/xpSVeE
         YqEaFs5Zpa7rS3SvQsgDrRq3OWvKhh451bO4bKRvw4WifwTQpwm4f1G+Lw53AC5aFVW/
         ooKE+9UscAUMemGiJUmReuhYXnMoSaPOmec2CxbgexeBuwrxgUJc+eg8I1T3JVKHSrsH
         srm6ryhYgKbER7cnlKQU6iIrrcikWVVHdxZESpLBvfDF0lVf9Vvh0l/PSEQkG6EdyJbZ
         8opr2cTRFpA53j8eMGDjXYkqvcPAEEzBgaOzmtNgjmMBq/Zw5iqixt/hYddEho6Pen7h
         OJhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OptYQtoN;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OptYQtoN;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoW5cgeUonpnwdnIyBKAg7DCjDWo5uyneTE6pk8MvW2yjU/D6AU13L4H/TCNf71jk0tO4FTLL8T0gN5Zyn4RK8=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-4-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-4-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:41:33 +0000
Message-ID: <CAGS+omA4DNm7HZZUpRBJfhhY-GYGaQRU1KWBb-CTuO7qGwTXCw@mail.gmail.com>
Subject: Re: [PATCH 04/11] ASoC: amd: removed separate byte count variables
 for playback and capture
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com, jclinton@chromium.org,
	Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, pombredanne@nexb.com,
	kstewart@linuxfoundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807163736514743?=
X-GMAIL-MSGID: =?utf-8?q?1599118355739325067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijendar,

On Thu, Apr 26, 2018 at 5:15 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Removed separate byte count variables for playback and capture.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
>   sound/soc/amd/acp.h         |  3 +--
>   2 files changed, 6 insertions(+), 16 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 019f696..5f34be1 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
snd_pcm_substream *substream)
>          buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>          bytescount = acp_get_byte_count(rtd);

> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               if (bytescount > rtd->i2ssp_renderbytescount)
> -                       bytescount = bytescount -
rtd->i2ssp_renderbytescount;
> -       } else {
> -               if (bytescount > rtd->i2ssp_capturebytescount)
> -                       bytescount = bytescount -
rtd->i2ssp_capturebytescount;
> -       }
> +       if (bytescount > rtd->bytescount)
> +               bytescount = bytescount - rtd->bytescount;

nit, this could be:
bytescount -= rtd->bytescount;

>          pos = do_div(bytescount, buffersize);
>          return bytes_to_frames(runtime, pos);
>   }
> @@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>          case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>          case SNDRV_PCM_TRIGGER_RESUME:
>                  bytescount = acp_get_byte_count(rtd);
> +               if (rtd->bytescount == 0)
> +                       rtd->bytescount = bytescount;
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -                       if (rtd->i2ssp_renderbytescount == 0)
> -                               rtd->i2ssp_renderbytescount = bytescount;
>                          acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>                          while (acp_reg_read(rtd->acp_mmio,
mmACP_DMA_CH_STS) &
>                                  BIT(rtd->ch1)) {
> @@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>                                  }
>                                  cpu_relax();
>                          }
> -               } else {
> -                       if (rtd->i2ssp_capturebytescount == 0)
> -                               rtd->i2ssp_capturebytescount = bytescount;
>                  }
>                  acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>                  ret = 0;
> @@ -947,12 +939,11 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                          acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>                          ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
> -                       rtd->i2ssp_renderbytescount = 0;
>                  } else {
>                          acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>                          ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
> -                       rtd->i2ssp_capturebytescount = 0;
>                  }
> +               rtd->bytescount = 0;
>                  break;
>          default:
>                  ret = -EINVAL;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 3b076c6..82470bc 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -93,8 +93,7 @@ struct audio_substream_data {
>          u32 byte_cnt_high_reg_offset;
>          u32 byte_cnt_low_reg_offset;
>          uint64_t size;
> -       u64 i2ssp_renderbytescount;
> -       u64 i2ssp_capturebytescount;
> +       u64 bytescount;
>          void __iomem *acp_mmio;
>   };

> --
> 2.7.4
