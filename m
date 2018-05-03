Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525326200; cv=none;
        d=google.com; s=arc-20160816;
        b=o9k+mRfWBZzimt1ItW1EC+NG+1GtyMTElmmCkJsARlK17+Z6ec4Q2+QYjYldt2N3PI
         vkC0EA50NdRKgckKlt8GZL95CkRBxJho3WB+9nkVsaZL16+8etejQs18y3ChgQxh8Fu2
         BnyKHunE/w0XfQLtayNuVkD1cXj1sUWr32BOVY84HUDcGY9bV01K5oA1ujfc7BjSvhc4
         GJ6Pxsk+5pfC9U5AiISM3hN83+zLvgCz4G9Gtno7qMlZrKCkHfbh4Leq82EcRCemp93M
         wHOiKCBOSaRQ8BThaVK+GIExuYLYGVrHzgoyqCjdUEvYkbq5RFKVf0oTjXyDoYspcTMW
         Shgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8DsyxcCxX+p1LnZ4KpJbvX8cAk2GllsgfjqOF5g/KbQ=;
        b=bytX3CQ2nfxtKXD4eylzdUN0CyaOFZCx7RPumwB+lXERd/wmnMb9bkJdA/+nlU/Gj3
         kd9W0q7doNQcNUGCa6gNvylK2XpO2HRLPu6XVxI2nzDCq0AQx7fsaBt40LjaCHZcKUsH
         r8AzSUOYr33b0sFuSc8BKE78ml7HsMEGZ8GDjRU6CBoNA6J4OJMf+fe15nSh1eSIAfRW
         LxQy8ZW4sMiv+nspaWHbkY8eWik3gPaspNgnAGKNBcDDD/ZSC4DE8qxN+IU0cQeET+DU
         iM+QaGMS5Xt0nXP1EOXsO+7fiwakZVmVVbF1ao6GFZpH/v7LLyT2xyzD2wia6Vc9Ev2f
         NH7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=IAOo9Lom;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=IAOo9Lom;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoIrY+28TtH24zaytqHcI6S5mws4Z9dDdYb63LnCBnYFQGyH0ol2SKjiA+jKLWJ5RqRjeiaPwoYIpIqJr6Ti9s=
MIME-Version: 1.0
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com> <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 03 May 2018 05:43:08 +0000
Message-ID: <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s instance
To: Vijendar.Mukunda@amd.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	Akshu.Agrawal@amd.com, kuninori.morimoto.gx@renesas.com,
	alexander.deucher@amd.com, weiyongjun1@huawei.com, jclinton@chromium.org,
	linux@roeck-us.net, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599420445695195018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some checkpatch nits below...

On Tue, May 1, 2018 at 2:53 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> With in ACP, There are three I2S controllers can be
> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
> Default enabled I2S controller instance is I2S SP.
> This patch provides required changes to support I2S BT
> controller Instance.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
> v1->v2: defined i2s instance macros in acp header file
> v2->v3: sqaushed previous patch series and spilt changes
>           into multiple patches (acp dma driver code cleanup
>           patches and bt i2s instance specific changes)
>    sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
>    sound/soc/amd/acp-pcm-dma.c          | 256
+++++++++++++++++++++++++++--------
>    sound/soc/amd/acp.h                  |  40 ++++++
>    3 files changed, 262 insertions(+), 57 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index 133139d..b3184ab 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -36,6 +36,7 @@
>    #include <linux/input.h>
>    #include <linux/acpi.h>

> +#include "acp.h"
>    #include "../codecs/da7219.h"
>    #include "../codecs/da7219-aad.h"

> @@ -44,6 +45,7 @@

>    static struct snd_soc_jack cz_jack;
>    static struct clk *da7219_dai_clk;
> +extern int bt_pad_enable;

WARNING: externs should be avoided in .c files


>    static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>    {
> @@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list
constraints_channels = {
>    static int cz_da7219_startup(struct snd_pcm_substream *substream)
>    {
>           struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct acp_platform_info *machine =
snd_soc_card_get_drvdata(card);

>           /*
>            * On this platform for PCM device we support stereo
> @@ -143,6 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream
*substream)
>           snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>                                      &constraints_rates);

> +       machine->i2s_instance = I2S_BT_INSTANCE;

I'm not a big fan of this approach, but I don't know any other way to tell
a single "platform" driver (acp-pcm-dma) which of two channels (ST/BT) to
use via the pcm_open() callback.

Mark, can you recommend any other way of doing this?

>           return da7219_clk_enable(substream);
>    }

> @@ -153,6 +159,11 @@ static void cz_da7219_shutdown(struct
snd_pcm_substream *substream)

>    static int cz_max_startup(struct snd_pcm_substream *substream)
>    {
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct acp_platform_info *machine =
snd_soc_card_get_drvdata(card);
> +
> +       machine->i2s_instance = I2S_SP_INSTANCE;
>           return da7219_clk_enable(substream);
>    }

> @@ -163,6 +174,11 @@ static void cz_max_shutdown(struct snd_pcm_substream
*substream)

>    static int cz_dmic_startup(struct snd_pcm_substream *substream)
>    {
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct acp_platform_info *machine =
snd_soc_card_get_drvdata(card);
> +
> +       machine->i2s_instance = I2S_SP_INSTANCE;
>           return da7219_clk_enable(substream);
>    }

> @@ -266,10 +282,16 @@ static int cz_probe(struct platform_device *pdev)
>    {
>           int ret;
>           struct snd_soc_card *card;
> +       struct acp_platform_info *machine;

> +       machine = devm_kzalloc(&pdev->dev, sizeof(struct
acp_platform_info),
> +                              GFP_KERNEL);
> +       if (!machine)
> +               return -ENOMEM;
>           card = &cz_card;
>           cz_card.dev = &pdev->dev;
>           platform_set_drvdata(pdev, card);
> +       snd_soc_card_set_drvdata(card, machine);
>           ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
>           if (ret) {
>                   dev_err(&pdev->dev,
> @@ -277,6 +299,7 @@ static int cz_probe(struct platform_device *pdev)
>                                   cz_card.name, ret);
>                   return ret;
>           }
> +       bt_pad_enable = device_property_read_bool(&pdev->dev,
"bt-pad-enable");
>           return 0;
>    }

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index ec9cab3..2ea103a 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -37,12 +37,14 @@
>    #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
>    #define MIN_BUFFER MAX_BUFFER

> -#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
> +#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
>    #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
>    #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE *
PLAYBACK_MAX_NUM_PERIODS)
>    #define ST_MIN_BUFFER ST_MAX_BUFFER

>    #define DRV_NAME "acp_audio_dma"
> +bool bt_pad_enable = false;

ERROR: do not initialise globals to false

> +EXPORT_SYMBOL(bt_pad_enable);

>    static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
>           .info = SNDRV_PCM_INFO_INTERLEAVED |
> @@ -357,6 +359,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
>           case ACP_TO_I2S_DMA_CH_NUM:
>           case ACP_TO_SYSRAM_CH_NUM:
>           case I2S_TO_ACP_DMA_CH_NUM:
> +       case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
> +       case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
> +       case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
>                   dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
>                   break;
>           default:
> @@ -519,6 +524,13 @@ static int acp_init(void __iomem *acp_mmio, u32
asic_type)
>           val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
>           acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);

> +       /* For BT instance change pins from UART to BT */
> +       if (bt_pad_enable) {
> +               val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
> +               val |= ACP_BT_UART_PAD_SELECT_MASK;
> +               acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
> +       }
> +
>           /* initiailize Onion control DAGB register */
>           acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
>                         mmACP_AXI2DAGB_ONION_CNTL);
> @@ -637,6 +649,24 @@ static irqreturn_t dma_irq_handler(int irq, void
*arg)
>                                 acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>           }

> +       if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
> +               valid_irq = true;
> +               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
> +                       PLAYBACK_START_DMA_DESCR_CH9)
> +                       dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
> +               else
> +                       dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
> +               config_acp_dma_channel(acp_mmio,
> +                                      SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
> +                                      dscr_idx, 1, 0);
> +               acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
> +                             false);
> +               snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
> +               acp_reg_write((intr_flag &
> +                             BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) <<
16,
> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> +       }
> +
>           if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
>                   valid_irq = true;
>                   if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
> @@ -659,6 +689,31 @@ static irqreturn_t dma_irq_handler(int irq, void
*arg)
>                                 acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>           }

> +       if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
> +               valid_irq = true;
> +               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
> +                       CAPTURE_START_DMA_DESCR_CH11)
> +                       dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
> +               else
> +                       dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
> +               config_acp_dma_channel(acp_mmio,
> +                                      ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
> +                                      dscr_idx, 1, 0);
> +               acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
> +                             false);
> +               acp_reg_write((intr_flag &
> +                             BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) <<
16,
> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> +       }
> +
> +       if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
> +               valid_irq = true;
> +               snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
> +               acp_reg_write((intr_flag &
> +                             BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) <<
16,
> +                             acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> +       }
> +
>           if (valid_irq)
>                   return IRQ_HANDLED;
>           else
> @@ -714,11 +769,11 @@ static int acp_dma_open(struct snd_pcm_substream
*substream)
>            * This enablement is not required for another stream, if current
>            * stream is not closed
>            */
> -       if (!intr_data->play_i2ssp_stream &&
!intr_data->capture_i2ssp_stream)
> +       if (!intr_data->play_i2ssp_stream &&
!intr_data->capture_i2ssp_stream &&
> +           !intr_data->play_i2sbt_stream &&
!intr_data->capture_i2sbt_stream)
>                   acp_reg_write(1, adata->acp_mmio,
mmACP_EXTERNAL_INTR_ENB);

>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               intr_data->play_i2ssp_stream = substream;
>                   /*
>                    * For Stoney, Memory gating is disabled,i.e SRAM Banks
>                    * won't be turned off. The default state for SRAM banks
is ON.
> @@ -730,7 +785,6 @@ static int acp_dma_open(struct snd_pcm_substream
*substream)
>                                                           bank, true);
>                   }
>           } else {
> -               intr_data->capture_i2ssp_stream = substream;
>                   if (intr_data->asic_type != CHIP_STONEY) {
>                           for (bank = 5; bank <= 8; bank++)

acp_set_sram_bank_state(intr_data->acp_mmio,
> @@ -754,6 +808,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream
*substream,
>           struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,

DRV_NAME);
>           struct audio_drv_data *adata = dev_get_drvdata(component->dev);
> +       struct snd_soc_card *card = prtd->card;
> +       struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);

>           runtime = substream->runtime;
>           rtd = runtime->private_data;
> @@ -761,52 +817,109 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>           if (WARN_ON(!rtd))
>                   return -EINVAL;

> +       rtd->i2s_instance = pinfo->i2s_instance;
>           if (adata->asic_type == CHIP_STONEY) {
>                   val = acp_reg_read(adata->acp_mmio,
>                                      mmACP_I2S_16BIT_RESOLUTION_EN);
> -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -                       val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
> -               else
> -                       val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +                       switch (rtd->i2s_instance) {
> +                       case I2S_BT_INSTANCE:
> +                               val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
> +                               break;
> +                       case I2S_SP_INSTANCE:
> +                       default:
> +                               val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
> +                       }
> +               } else {
> +                       switch (rtd->i2s_instance) {
> +                       case I2S_BT_INSTANCE:
> +                               val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
> +                               break;
> +                       case I2S_SP_INSTANCE:
> +                       default:
> +                               val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
> +                       }
> +               }
>                   acp_reg_write(val, adata->acp_mmio,
>                                 mmACP_I2S_16BIT_RESOLUTION_EN);
>           }

>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               switch (adata->asic_type) {
> -               case CHIP_STONEY:
> -                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
> +               switch (rtd->i2s_instance) {
> +               case I2S_BT_INSTANCE:
> +                       rtd->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
> +                       rtd->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
> +                       rtd->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
> +                       rtd->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
> +                       rtd->destination = TO_BLUETOOTH;
> +                       rtd->dma_dscr_idx_1 =
PLAYBACK_START_DMA_DESCR_CH8;
> +                       rtd->dma_dscr_idx_2 =
PLAYBACK_START_DMA_DESCR_CH9;
> +                       rtd->byte_cnt_high_reg_offset =
> +
mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
> +                       rtd->byte_cnt_low_reg_offset =
> +
mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
> +                       adata->play_i2sbt_stream = substream;
>                           break;
> +               case I2S_SP_INSTANCE:
>                   default:
> -                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +                       switch (adata->asic_type) {
> +                       case CHIP_STONEY:
> +                               rtd->pte_offset =
ACP_ST_PLAYBACK_PTE_OFFSET;
> +                               break;
> +                       default:
> +                               rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +                       }
> +                       rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> +                       rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +                       rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
> +                       rtd->destination = TO_ACP_I2S_1;
> +                       rtd->dma_dscr_idx_1 =
PLAYBACK_START_DMA_DESCR_CH12;
> +                       rtd->dma_dscr_idx_2 =
PLAYBACK_START_DMA_DESCR_CH13;
> +                       rtd->byte_cnt_high_reg_offset =
> +                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
> +                       rtd->byte_cnt_low_reg_offset =
> +                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
> +                       adata->play_i2ssp_stream = substream;
>                   }
> -               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> -               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> -               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
> -               rtd->destination = TO_ACP_I2S_1;
> -               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
> -               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
> -               rtd->byte_cnt_high_reg_offset =
> -                               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
> -               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>           } else {
> -               switch (adata->asic_type) {
> -               case CHIP_STONEY:
> -                       rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
> -                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
> +               switch (rtd->i2s_instance) {
> +               case I2S_BT_INSTANCE:
> +                       rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
> +                       rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
> +                       rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
> +                       rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
> +                       rtd->destination = FROM_BLUETOOTH;
> +                       rtd->dma_dscr_idx_1 =
CAPTURE_START_DMA_DESCR_CH10;
> +                       rtd->dma_dscr_idx_2 =
CAPTURE_START_DMA_DESCR_CH11;
> +                       rtd->byte_cnt_high_reg_offset =
> +
mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
> +                       rtd->byte_cnt_low_reg_offset =
> +                                       mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
> +                       adata->capture_i2sbt_stream = substream;
>                           break;
> +               case I2S_SP_INSTANCE:
>                   default:
>                           rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> -                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
> +                       rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
> +                       rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
> +                       switch (adata->asic_type) {
> +                       case CHIP_STONEY:
> +                               rtd->pte_offset =
ACP_ST_CAPTURE_PTE_OFFSET;
> +                               rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
> +                               break;
> +                       default:
> +                               rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +                               rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
> +                       }
> +                       rtd->destination = FROM_ACP_I2S_1;
> +                       rtd->dma_dscr_idx_1 =
CAPTURE_START_DMA_DESCR_CH14;
> +                       rtd->dma_dscr_idx_2 =
CAPTURE_START_DMA_DESCR_CH15;
> +                       rtd->byte_cnt_high_reg_offset =
> +                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
> +                       rtd->byte_cnt_low_reg_offset =
> +                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
> +                       adata->capture_i2ssp_stream = substream;
>                   }
> -               rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
> -               rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
> -               rtd->destination = FROM_ACP_I2S_1;
> -               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
> -               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
> -               rtd->byte_cnt_high_reg_offset =
> -                               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
> -               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>           }

>           size = params_buffer_bytes(params);
> @@ -999,24 +1112,39 @@ static int acp_dma_close(struct snd_pcm_substream
*substream)
>           struct audio_drv_data *adata = dev_get_drvdata(component->dev);

>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               adata->play_i2ssp_stream = NULL;
> -               /*
> -                * For Stoney, Memory gating is disabled,i.e SRAM Banks
> -                * won't be turned off. The default state for SRAM banks
is ON.
> -                * Setting SRAM bank state code skipped for STONEY
platform.
> -                * added condition checks for Carrizo platform only
> -                */
> -               if (adata->asic_type != CHIP_STONEY) {
> -                       for (bank = 1; bank <= 4; bank++)
> -                               acp_set_sram_bank_state(adata->acp_mmio,
bank,
> -                                                       false);
> +               switch (rtd->i2s_instance) {
> +               case I2S_BT_INSTANCE:
> +                       adata->play_i2sbt_stream = NULL;
> +                       break;
> +               case I2S_SP_INSTANCE:
> +               default:
> +                       adata->play_i2ssp_stream = NULL;
> +                       /*
> +                        * For Stoney, Memory gating is disabled,i.e SRAM
Banks
> +                        * won't be turned off. The default state for
SRAM banks
> +                        * is ON.Setting SRAM bank state code skipped for
STONEY
> +                        * platform. Added condition checks for Carrizo
platform
> +                        * only.
> +                        */
> +                       if (adata->asic_type != CHIP_STONEY) {
> +                               for (bank = 1; bank <= 4; bank++)
> +
acp_set_sram_bank_state(adata->acp_mmio,
> +                                                               bank,
false);
> +                       }
>                   }
>           } else  {
> -               adata->capture_i2ssp_stream = NULL;
> -               if (adata->asic_type != CHIP_STONEY) {
> -                       for (bank = 5; bank <= 8; bank++)
> -                               acp_set_sram_bank_state(adata->acp_mmio,
bank,
> -                                                       false);
> +               switch (rtd->i2s_instance) {
> +               case I2S_BT_INSTANCE:
> +                       adata->capture_i2sbt_stream = NULL;
> +                       break;
> +               case I2S_SP_INSTANCE:
> +               default:
> +                       adata->capture_i2ssp_stream = NULL;
> +                       if (adata->asic_type != CHIP_STONEY) {
> +                               for (bank = 5; bank <= 8; bank++)
> +
acp_set_sram_bank_state(adata->acp_mmio,
> +                                                               bank,
false);
> +                       }
>                   }
>           }

> @@ -1024,7 +1152,8 @@ static int acp_dma_close(struct snd_pcm_substream
*substream)
>            * Disable ACP irq, when the current stream is being closed and
>            * another stream is also not active.
>            */
> -       if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
> +       if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
> +           !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
>                   acp_reg_write(0, adata->acp_mmio,
mmACP_EXTERNAL_INTR_ENB);
>           kfree(rtd);
>           return 0;
> @@ -1078,6 +1207,8 @@ static int acp_audio_probe(struct platform_device
*pdev)

>           audio_drv_data->play_i2ssp_stream = NULL;
>           audio_drv_data->capture_i2ssp_stream = NULL;
> +       audio_drv_data->play_i2sbt_stream = NULL;
> +       audio_drv_data->capture_i2sbt_stream = NULL;

>           audio_drv_data->asic_type =  *pdata;

> @@ -1134,6 +1265,7 @@ static int acp_pcm_resume(struct device *dev)
>    {
>           u16 bank;
>           int status;
> +       struct audio_substream_data *rtd;
>           struct audio_drv_data *adata = dev_get_drvdata(dev);

>           status = acp_init(adata->acp_mmio, adata->asic_type);
> @@ -1153,9 +1285,8 @@ static int acp_pcm_resume(struct device *dev)
>                                   acp_set_sram_bank_state(adata->acp_mmio,
bank,
>                                                           true);
>                   }
> -               config_acp_dma(adata->acp_mmio,
> -
   adata->play_i2ssp_stream->runtime->private_data,
> -                              adata->asic_type);
> +               rtd = adata->play_i2ssp_stream->runtime->private_data;
> +               config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
>           }
>           if (adata->capture_i2ssp_stream &&
>               adata->capture_i2ssp_stream->runtime) {
> @@ -1164,9 +1295,20 @@ static int acp_pcm_resume(struct device *dev)
>                                   acp_set_sram_bank_state(adata->acp_mmio,
bank,
>                                                           true);
>                   }
> -               config_acp_dma(adata->acp_mmio,
> -
   adata->capture_i2ssp_stream->runtime->private_data,
> -                              adata->asic_type);
> +               rtd =  adata->capture_i2ssp_stream->runtime->private_data;
> +               config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
> +       }
> +       if (adata->asic_type != CHIP_CARRIZO) {
> +               if (adata->play_i2sbt_stream &&
> +                   adata->play_i2sbt_stream->runtime) {
> +                       rtd =
adata->play_i2sbt_stream->runtime->private_data;
> +                       config_acp_dma(adata->acp_mmio, rtd,
adata->asic_type);
> +               }
> +               if (adata->capture_i2sbt_stream &&
> +                   adata->capture_i2sbt_stream->runtime) {
> +                       rtd =
adata->capture_i2sbt_stream->runtime->private_data;

WARNING: line over 80 characters


> +                       config_acp_dma(adata->acp_mmio, rtd,
adata->asic_type);
> +               }
>           }
>           acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
>           return 0;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 62695ed..9cd3e96 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -13,6 +13,8 @@
>    /* Playback and Capture Offset for Stoney */
>    #define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
>    #define ACP_ST_CAPTURE_PTE_OFFSET      0x00
> +#define ACP_ST_BT_PLAYBACK_PTE_OFFSET  0x08
> +#define ACP_ST_BT_CAPTURE_PTE_OFFSET   0x0c

>    #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>    #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4
> @@ -46,8 +48,13 @@

>    #define TO_ACP_I2S_1   0x2
>    #define TO_ACP_I2S_2   0x4
> +#define TO_BLUETOOTH   0x3
>    #define FROM_ACP_I2S_1 0xa
>    #define FROM_ACP_I2S_2 0xb
> +#define FROM_BLUETOOTH 0xb
> +
> +#define I2S_SP_INSTANCE                 0x01
> +#define I2S_BT_INSTANCE                 0x02

>    #define ACP_TILE_ON_MASK                0x03
>    #define ACP_TILE_OFF_MASK               0x02
> @@ -68,6 +75,14 @@
>    #define ACP_TO_SYSRAM_CH_NUM 14
>    #define I2S_TO_ACP_DMA_CH_NUM 15

> +/* Playback DMA Channels for I2S BT instance */
> +#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
> +#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
> +
> +/* Capture DMA Channels for I2S BT Instance */
> +#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
> +#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
> +
>    #define NUM_DSCRS_PER_CHANNEL 2

>    #define PLAYBACK_START_DMA_DESCR_CH12 0
> @@ -80,9 +95,23 @@
>    #define CAPTURE_START_DMA_DESCR_CH15 6
>    #define CAPTURE_END_DMA_DESCR_CH15 7

> +/* I2S BT Instance DMA Descriptors */
> +#define PLAYBACK_START_DMA_DESCR_CH8 8
> +#define PLAYBACK_END_DMA_DESCR_CH8 9
> +#define PLAYBACK_START_DMA_DESCR_CH9 10
> +#define PLAYBACK_END_DMA_DESCR_CH9 11
> +
> +#define CAPTURE_START_DMA_DESCR_CH10 12
> +#define CAPTURE_END_DMA_DESCR_CH10 13
> +#define CAPTURE_START_DMA_DESCR_CH11 14
> +#define CAPTURE_END_DMA_DESCR_CH11 15
> +
>    #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
>    #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
>    #define ACP_I2S_SP_16BIT_RESOLUTION_EN 0x02
> +#define ACP_I2S_BT_16BIT_RESOLUTION_EN 0x04
> +#define ACP_BT_UART_PAD_SELECT_MASK    0x1
> +
>    enum acp_dma_priority_level {
>           /* 0x0 Specifies the DMA channel is given normal priority */
>           ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
> @@ -95,6 +124,7 @@ struct audio_substream_data {
>           struct page *pg;
>           unsigned int order;
>           u16 num_of_pages;
> +       u16 i2s_instance;
>           u16 direction;
>           u16 ch1;
>           u16 ch2;
> @@ -113,10 +143,20 @@ struct audio_substream_data {
>    struct audio_drv_data {
>           struct snd_pcm_substream *play_i2ssp_stream;
>           struct snd_pcm_substream *capture_i2ssp_stream;
> +       struct snd_pcm_substream *play_i2sbt_stream;
> +       struct snd_pcm_substream *capture_i2sbt_stream;
>           void __iomem *acp_mmio;
>           u32 asic_type;
>    };

> +/*
> + * this structure used for platform data transfer between machine driver
> + * and dma driver
> + */
> +struct acp_platform_info {
> +       u16 i2s_instance;
> +};
> +
>    union acp_dma_count {
>           struct {
>           u32 low;
> --
> 2.7.4
