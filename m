Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525038484; cv=none;
        d=google.com; s=arc-20160816;
        b=Zgxceb9lYmJtKAEOe/HSi3qQZdnq9bmy6q6WUu2/Vsx9Nk1zzdhN47uRmxJwNUVkMQ
         yzrz2C8nN39tejVGYeWGRXWDSCjJXCZ2CS0F4ES2BTBq68ngNrD6bXvMF17tPpRRusWN
         cvoho1yAieCWpKgKixdWL1zd+iQqCVE3sFWLa85ixguO6hwVRxUynP1XW/qQ98s2HTs7
         xca98zpA9x8X969CYAhiULnxPIEPLAVihOlZ9BeXywzdbDfemfLVQDzBonFDCRZFPcYK
         01B0BVzBaMTZ8NPeoqGngkQaWaQeXp6KtQtLfgKYabsrDucK9vgUBCVLQdZULAxfrwIO
         chCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DRC8wa1XcwZuFqk2ee1axBcew0SGKPA0elV9KpCKzUA=;
        b=jGfLltvszAit3DQGgRR6TDJXJKcUOG9XPaNWyQIWCr+Zu+bAOfT84VpNh256lBbDse
         Q/4QfdsedJzYv3lNgpvoko11VMzmoHFMNxr+tW7HgH2hMab3YskPPUPXFVdW41Aa+gK1
         HasHo6zeqenpLbkZNctlMR7nUJPmxu0AA3j7lLPF30Zr1McaF+yG8/YFIUnPlaphiv15
         /ynmDvkpmPeG2/gVa553LFx5x5Etln4DqTm0P8B3rrEHxKVDPLCETaxTzk98ipcapjiA
         4e7XTaSG8lVG9BCZ51KCDGTIEN91RkfuQqKPKj2X6gV3+EwBpaLwAboLu+ML9iJ0A6j/
         W/eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VtKNNoFg;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VtKNNoFg;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZrV3ASgCLB2hzG8CNt0L7AROL4E/w6FWmIwPCNyhIgnOeuRJL3lI39KC868F7a31lt7KhuTLkpBbSGiov6rw48=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-6-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-6-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:47:53 +0000
Message-ID: <CAGS+omCG+=UL-ZFA6STjnDrnG2L5jqwUGjcE+Db2P+VYyzFL9A@mail.gmail.com>
Subject: Re: [PATCH 06/11] ASoC: amd: sram bank update changes
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com,
	Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
	Guenter Roeck <linux@roeck-us.net>, kstewart@linuxfoundation.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807235933868204?=
X-GMAIL-MSGID: =?utf-8?q?1599118754013489849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 5:16 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Added sram bank variable to audio_substream_data structure.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Move initialization to acp_dma_open(), otherwise this is:
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
>   sound/soc/amd/acp.h         | 20 ++++++++++++++------
>   2 files changed, 19 insertions(+), 21 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index cb22653..b7bffc7 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -320,29 +320,16 @@ static void config_acp_dma(void __iomem *acp_mmio,
>                             struct audio_substream_data *rtd,
>                             u32 asic_type)
>   {
> -       u32 sram_bank;
> -
> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -               sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
> -       else {
> -               switch (asic_type) {
> -               case CHIP_STONEY:
> -                       sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
> -                       break;
> -               default:
> -                       sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
> -               }
> -       }
>          acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>                         rtd->pte_offset);
>          /* Configure System memory <-> ACP SRAM DMA descriptors */
>          set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>                                         rtd->direction, rtd->pte_offset,
> -                                      rtd->ch1, sram_bank,
> +                                      rtd->ch1, rtd->sram_bank,
>                                         rtd->dma_dscr_idx_1, asic_type);
>          /* Configure ACP SRAM <-> I2S DMA descriptors */
>          set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
> -                                      rtd->direction, sram_bank,
> +                                      rtd->direction, rtd->sram_bank,
>                                         rtd->destination, rtd->ch2,
>                                         rtd->dma_dscr_idx_2, asic_type);
>   }
> @@ -795,6 +782,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream
*substream,
>                  }
>                  rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>                  rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
>                  rtd->destination = TO_ACP_I2S_1;
>                  rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>                  rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
> @@ -805,9 +793,11 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>                  switch (adata->asic_type) {
>                  case CHIP_STONEY:
>                          rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
> +                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
>                          break;
>                  default:
>                          rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
>                  }
>                  rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>                  rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 2f48d1d..62695ed 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -19,12 +19,19 @@

>   #define ACP_PHYSICAL_BASE                      0x14000

> -/* Playback SRAM address (as a destination in dma descriptor) */
> -#define ACP_SHARED_RAM_BANK_1_ADDRESS          0x4002000
> -
> -/* Capture SRAM address (as a source in dma descriptor) */
> -#define ACP_SHARED_RAM_BANK_5_ADDRESS          0x400A000
> -#define ACP_SHARED_RAM_BANK_3_ADDRESS          0x4006000
> +/*
> + * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
> + * playback and SRAM Bank 2 for capture where as in case of BT I2S
> + * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
> + * be used for capture. Carrizo uses I2S SP controller instance. SRAM
Banks
> + * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be
used
> + * for capture scenario.
> + */
> +#define ACP_SRAM_BANK_1_ADDRESS                0x4002000
> +#define ACP_SRAM_BANK_2_ADDRESS                0x4004000
> +#define ACP_SRAM_BANK_3_ADDRESS                0x4006000
> +#define ACP_SRAM_BANK_4_ADDRESS                0x4008000
> +#define ACP_SRAM_BANK_5_ADDRESS                0x400A000

>   #define ACP_DMA_RESET_TIME                     10000
>   #define ACP_CLOCK_EN_TIME_OUT_VALUE            0x000000FF
> @@ -95,6 +102,7 @@ struct audio_substream_data {
>          u16 dma_dscr_idx_1;
>          u16 dma_dscr_idx_2;
>          u32 pte_offset;
> +       u32 sram_bank;
>          u32 byte_cnt_high_reg_offset;
>          u32 byte_cnt_low_reg_offset;
>          uint64_t size;
> --
> 2.7.4
