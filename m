Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525037972; cv=none;
        d=google.com; s=arc-20160816;
        b=qhwgFHt2m+QDClWqdEfov8/vbrkThbkKPDlOLlvlA9oslA+VErSoTTJ6mR1TrJnYtt
         IsZTRPuTjNLS2My/gp2yuxfox3Y9ag5gDSeONopm4YBjzrkXT+EEo5fkKXPnRhsWjU4I
         myqq4XQ2fRxrRQIeUN40+advnz78wyZ5OZoesS13vRWH8IyB6eZK5nVStKAdA1/9BUHc
         ZQ1IR9cV8ihlmPZelVmHu5yK2sFtIJVeCtEbaU9NllVqDwJKlVb9368D5LR75mk98iHr
         +e6hEwFWUv6VfduWQsoTHVEXanPG+RYgxVaa1sIwcs+6zsmEl0H09zIrQBooO9si8mOb
         6ZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wOJyIR4wAdJubuaw7k0uagrkUmo1D4+zNDk5LAVtb2o=;
        b=QwUI+tuKe+5Ng2FNDozdJI9dUD/7RCWd53oZsHNvq07ykc65RcZgNTTvjwtgOCyVVf
         Z0q64dKr3U8NoTc1JrO5oMq2wzKDOh6CIFHFjDYV4u/p3UgCYciw6WJl7YFkV3mWwzT1
         ftt1CBeG7YSI6QzSjltSCt9D30QTVW9lPB4oTPpEZClJ/soveQle3tdY0strJoJvUg/q
         yvF/xmO5Bxom2HHUSAEubgyP7P+Tesj+QigaLIWX7oR4sn/pbxa4PCOt4wN3BIVi74N7
         OF8d3CNHaOrh1paj8MrzJw6BicTV1l2UyDTPyrwU3IZ4BpGwiRD7RISXCeCati6osOiy
         rxVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Dwg+Ceb0;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Dwg+Ceb0;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZpSDfdb7n/slx35ypkPXKErioRuNL4tK/pIQsB3qlA8jL9ivbjRkfwEyk2KXF84iq/CGjArRzXsJPoyr+YnjkU=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-3-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-3-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:39:21 +0000
Message-ID: <CAGS+omCN5Xk71FQMJztzi6orNLShr9E4g61atYpbqtcOtcHLjg@mail.gmail.com>
Subject: Re: [PATCH 03/11] ASoC: amd: added byte count register offset
 variables to rtd
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com, jclinton@chromium.org,
	Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, kstewart@linuxfoundation.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807124963001399?=
X-GMAIL-MSGID: =?utf-8?q?1599118217521450258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijendar,


On Thu, Apr 26, 2018 at 5:14 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Added byte count register offset variables to audio_substream_data
> structure. Modified dma pointer callback.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Please fix the small indentation nits, otherwise this one is:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
>   sound/soc/amd/acp.h         |  2 ++
>   2 files changed, 17 insertions(+), 21 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index f18ed9a..019f696 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>                  rtd->destination = TO_ACP_I2S_1;
>                  rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>                  rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
> +               rtd->byte_cnt_high_reg_offset =
> +               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;

Indent relative to line above with 2 tabs.

> +               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>          } else {
>                  rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>                  rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>                  rtd->destination = FROM_ACP_I2S_1;
>                  rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>                  rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
> +               rtd->byte_cnt_high_reg_offset =
> +               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;

here too.

> +               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>          }

>          size = params_buffer_bytes(params);
> @@ -834,26 +840,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream
*substream)
>          return snd_pcm_lib_free_pages(substream);
>   }

> -static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
> +static u64 acp_get_byte_count(struct audio_substream_data *rtd)
>   {
> -       union acp_dma_count playback_dma_count;
> -       union acp_dma_count capture_dma_count;
> -       u64 bytescount = 0;
> +       union acp_dma_count byte_count;

> -       if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
> -               playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
> -               bytescount = playback_dma_count.bytescount;
> -       } else {
> -               capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
> -               capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
> -               bytescount = capture_dma_count.bytescount;
> -       }
> -       return bytescount;
> +       byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
> +
rtd->byte_cnt_high_reg_offset);
> +       byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
> +
rtd->byte_cnt_low_reg_offset);
> +       return byte_count.bytescount;
>   }

>   static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream
*substream)
> @@ -869,7 +864,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
snd_pcm_substream *substream)
>                  return -EINVAL;

>          buffersize = frames_to_bytes(runtime, runtime->buffer_size);
> -       bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
> +       bytescount = acp_get_byte_count(rtd);

>          if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                  if (bytescount > rtd->i2ssp_renderbytescount)
> @@ -925,8 +920,7 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>          case SNDRV_PCM_TRIGGER_START:
>          case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>          case SNDRV_PCM_TRIGGER_RESUME:
> -               bytescount = acp_get_byte_count(rtd->acp_mmio,
> -                                               substream->stream);
> +               bytescount = acp_get_byte_count(rtd);
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                          if (rtd->i2ssp_renderbytescount == 0)
>                                  rtd->i2ssp_renderbytescount = bytescount;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 5e25428..3b076c6 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -90,6 +90,8 @@ struct audio_substream_data {
>          u16 destination;
>          u16 dma_dscr_idx_1;
>          u16 dma_dscr_idx_2;
> +       u32 byte_cnt_high_reg_offset;
> +       u32 byte_cnt_low_reg_offset;
>          uint64_t size;
>          u64 i2ssp_renderbytescount;
>          u64 i2ssp_capturebytescount;
> --
> 2.7.4
