Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525365658; cv=none;
        d=google.com; s=arc-20160816;
        b=LIMEFKg/ijIs6y6TNMQDkmHuUMnnwgxqzrRBwQzU7o2dkdDc7Nn0TdYwbUP2TB+FAF
         7exFI6sTPl9Gj9E0jrNHXrOH1cs4eNI97fV8DJC4Mmz6FMyanWlYjk+Nq6fzbBOW3nPg
         HZy/GQcMJrwYozU8s//HeK3VuT41F6Uvro+dwIusrRqVDwlxggQCN80rfsMRcmRaWFvs
         2tyDlOLbRALZLo3Gc8Qw7y8pbfZbUswbCvmCzQOkXnM8UpjPD3nNY3m4WQwr9bFXmvdZ
         BLBkP448OunJM8fFkbwJt7miEs5AEsLQMsug7hYzN/T7BY9whENcEzAGHxarkLphLzXv
         J4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hmWdl6zgsq31+KFeRbVeCJx3frlm1IBHqYlM+e9IVS8=;
        b=Vtv+UUQRSDsEj/wIVLM+fBS2WNPRITPxyBBKrBdItEk2aG0ROQsPaFeMICtKIwdiQV
         RXr6uPfgpTJDU0U4epVP0/lWZ4wyvRy6d53XLFNXqcdgVHR/qyg6LushrvASsnlrq0Mi
         S4PurTemxG00vLBh6HVOa874VbzEYtNeLpy+WUSrCEINM98GfRgEuoAgR9FtuSN/2EW9
         PTusMq3yX6BDzspRoB+4q9D5p1rOf0t/Z29W37aAWwmu3N5rl8Kh6ItEwsXZy44FyJTa
         3guil/99pueQ4ta7oXFYcXg0x2W4G6QT+UwQdqL7wjy+h52rmpr9XlcicqMgc/b3V5+r
         cshg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DzO69rdr;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DzO69rdr;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoVSlzYaSCZCpScJm9rjvVax7r797Qmr1WAGRmXAmcioS1c273VCgv/hfJZP9RD5st6IoLaMR+0WqCVXN9o3CA=
MIME-Version: 1.0
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com> <06a8f6f4-3bc0-656e-9c55-84f88727d6fb@amd.com>
In-Reply-To: <06a8f6f4-3bc0-656e-9c55-84f88727d6fb@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 03 May 2018 16:40:47 +0000
Message-ID: <CAGS+omDKpPwyUMYwm-ai5cr+m=JLh+yjYq_oDfyRBppqc8DPDg@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s instance
To: vijendar.mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, Akshu Agrawal <Akshu.Agrawal@amd.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alexander.deucher@amd.com,
	weiyongjun1@huawei.com, jclinton@chromium.org,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599461821391364647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 1:33 AM Mukunda,Vijendar <vijendar.mukunda@amd.com>
wrote:



> On Thursday 03 May 2018 11:13 AM, Daniel Kurtz wrote:
> > Some checkpatch nits below...
> >
> > On Tue, May 1, 2018 at 2:53 PM Vijendar Mukunda <
Vijendar.Mukunda@amd.com>
> > wrote:
> >
> >> With in ACP, There are three I2S controllers can be
> >> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
> >> Default enabled I2S controller instance is I2S SP.
> >> This patch provides required changes to support I2S BT
> >> controller Instance.
> >
> >> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> >> ---
> >> v1->v2: defined i2s instance macros in acp header file
> >> v2->v3: sqaushed previous patch series and spilt changes
> >>            into multiple patches (acp dma driver code cleanup
> >>            patches and bt i2s instance specific changes)
> >>     sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
> >>     sound/soc/amd/acp-pcm-dma.c          | 256
> > +++++++++++++++++++++++++++--------
> >>     sound/soc/amd/acp.h                  |  40 ++++++
> >>     3 files changed, 262 insertions(+), 57 deletions(-)
> >
> >> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> > b/sound/soc/amd/acp-da7219-max98357a.c
> >> index 133139d..b3184ab 100644
> >> --- a/sound/soc/amd/acp-da7219-max98357a.c
> >> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> >> @@ -36,6 +36,7 @@
> >>     #include <linux/input.h>
> >>     #include <linux/acpi.h>
> >
> >> +#include "acp.h"
> >>     #include "../codecs/da7219.h"
> >>     #include "../codecs/da7219-aad.h"
> >
> >> @@ -44,6 +45,7 @@
> >
> >>     static struct snd_soc_jack cz_jack;
> >>     static struct clk *da7219_dai_clk;
> >> +extern int bt_pad_enable;
> >
> > WARNING: externs should be avoided in .c files

> We don't have .h file for machine driver and It can be ignored for
> one variable.
> >
> >
> >>     static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
> >>     {
> >> @@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list
> > constraints_channels = {
> >>     static int cz_da7219_startup(struct snd_pcm_substream *substream)
> >>     {
> >>            struct snd_pcm_runtime *runtime = substream->runtime;
> >> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >> +       struct snd_soc_card *card = rtd->card;
> >> +       struct acp_platform_info *machine =
> > snd_soc_card_get_drvdata(card);
> >
> >>            /*
> >>             * On this platform for PCM device we support stereo
> >> @@ -143,6 +148,7 @@ static int cz_da7219_startup(struct
snd_pcm_substream
> > *substream)
> >>            snd_pcm_hw_constraint_list(runtime, 0,
SNDRV_PCM_HW_PARAM_RATE,
> >>                                       &constraints_rates);
> >
> >> +       machine->i2s_instance = I2S_BT_INSTANCE;
> >
> > I'm not a big fan of this approach, but I don't know any other way to
tell
> > a single "platform" driver (acp-pcm-dma) which of two channels (ST/BT)
to
> > use via the pcm_open() callback.
> >
> > Mark, can you recommend any other way of doing this?

> Hi Dan,

> There have been couple of approaches worked upon this earlier.
> 1) To compare cpu dai name to get the I2S instance value in
> acp_dma_open() call.

> But, Mark suggested not to implement this approach as we are comparing
> dynamically generated cpu dai names.

> 2) We added i2s_instance parameter as platform data to dwc driver.
> By querying dwc driver platform data in acp dma driver, current i2s
> instance was programmed in acp_dma_open ().

> But Mark's latest comment was to implement platform specific changes in
> machine driver. Machine driver and Dma driver should exchange the data
> regarding this. We accepted this and current approach is based on the
> same comment.
> Below is the reference.
> https://lkml.org/lkml/2018/4/18/597

Yes, I saw Mark's previous comment, but what we are trying to implement
here is the SoC specific binding between i2s channel and acp-dma channel.
This is a feature of the SoC, not of the i2s controller, but also not a
feature of the audio configuration on the board.  For these SoCs, the link
between DMA registers & I2S-channel is hard-coded.  The machine driver is
already specifying which i2s channel to use when it configures, for
example, '.cpu_dai_name = "designware-i2s.2.auto"'.  The i2s channel
selection already implies a particular DMA configuration.  It seems
redundant to create this separate out-of-band infrastructure to make the
machine driver also tell its platform driver '.platform_name =
"acp_audio_dma.0.auto"' which i2s channel it is using.

Perhaps the acp-pcm-dma.c should register two different platform drivers,
and let the machine driver pick the appropriate one (ie,
acp_audio_dma.0.auto or acp_audio_dma.1.auto) depending on which i2s port
it needs?  Then each of these would have its own
snd_soc_platform_driver->ops->open() that could setup
snd_pcm_runtime->private_data appropriately?  Or is there another standard
way to have a single snd_soc_platform_driver handle multiple channels?

-Dan
