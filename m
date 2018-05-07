Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525675456; cv=none;
        d=google.com; s=arc-20160816;
        b=tndwmAVQFxeKRI25aRy7d61+5n+5fpd1pUL2kIhng936PusFWw0YTGFNQbK9tlyisw
         Nm4PBxScz/1YmUDyLzR8KbUukllFqBVqRcUIIcJTy6Ly00ZdBhPT3tJyx8A0bleQ6Gos
         AsHeWheHiNcvFjuj44lujNCq4V8fPmADmQEQo31Non0du566svjMAPygog+/kmjbDGsr
         wJHwBrly76NoAgeyerVhW6T6yQ45IglCY5WF/sOpP0U0Y/QiNOnOuihDf+UiCf2itjSd
         W9PRM8H3pmdkcAHDFK2wSpptamN7dWCfyRR4ri/PxSxX+CJ6pz5J6lR1yNCFWWSst85p
         93JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yENRgf99UdpGlgCNldl+D5wfgK9BHBwi4lQqTSyepFM=;
        b=fbc502empctvLBoiqFvw2Lcq1ohjt0IQ7RhUz2+DlB/URMHQmZxR6sspDc+Ch8YACp
         MSJ7C2KZRKu557CQ0uPzFruAPUWLG6fslhofqrakIGGgNCV6By/ld3H5W3pElSEYawhw
         qMSa5xrKDo4jS39qygmxP2A97DHiVU2B3+X9odjOn0WIp5yycU2ovFyQPqcggrxW8gZ5
         QUL0lt5LVVI46e8pANFpKmcvDn3rQCb1LDBioWdEt6T2q45JZ6cY0YOS4StpvaOINGB6
         EbufTSeJVYdhUipmjhZpv21XkGvyViqAXsdsfZomAavWXuY0UzkMYH7kYszWAGoBmPYm
         LbJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kfhw7lR1;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kfhw7lR1;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZpvqZMwqhNVRq62e5C+nV/nU/KLiocD0HV0/Br290leKGjo1hrTPz5v/CiSj66rKfnJD0F9CqsX+mjRc8pVN88=
MIME-Version: 1.0
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com>
 <06a8f6f4-3bc0-656e-9c55-84f88727d6fb@amd.com> <CAGS+omDKpPwyUMYwm-ai5cr+m=JLh+yjYq_oDfyRBppqc8DPDg@mail.gmail.com>
 <78cec135-3ae1-4d4b-4b19-b7fe1577294d@amd.com>
In-Reply-To: <78cec135-3ae1-4d4b-4b19-b7fe1577294d@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 07 May 2018 06:44:04 +0000
Message-ID: <CAGS+omAhYrBAH1pgtGif=AZavXz=Ft-OWG16ooNZk5CqNihttQ@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s instance
To: Akshu Agrawal <Akshu.Agrawal@amd.com>
Cc: vijendar.mukunda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alexander.deucher@amd.com,
	weiyongjun1@huawei.com, jclinton@chromium.org,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599786667279599448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 10:35 PM Agrawal, Akshu <Akshu.Agrawal@amd.com>
wrote:



> On 5/3/2018 10:10 PM, Daniel Kurtz wrote:
> > On Thu, May 3, 2018 at 1:33 AM Mukunda,Vijendar <
vijendar.mukunda@amd.com>
> > wrote:
> >
> >
> >
> >> On Thursday 03 May 2018 11:13 AM, Daniel Kurtz wrote:
> >>> Some checkpatch nits below...
> >>>
> >>> On Tue, May 1, 2018 at 2:53 PM Vijendar Mukunda <
> > Vijendar.Mukunda@amd.com>
> >>> wrote:
> >>>
> >>>> With in ACP, There are three I2S controllers can be
> >>>> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
> >>>> Default enabled I2S controller instance is I2S SP.
> >>>> This patch provides required changes to support I2S BT
> >>>> controller Instance.
> >>>
> >>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> >>>> ---
> >>>> v1->v2: defined i2s instance macros in acp header file
> >>>> v2->v3: sqaushed previous patch series and spilt changes
> >>>>             into multiple patches (acp dma driver code cleanup
> >>>>             patches and bt i2s instance specific changes)
> >>>>      sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
> >>>>      sound/soc/amd/acp-pcm-dma.c          | 256
> >>> +++++++++++++++++++++++++++--------
> >>>>      sound/soc/amd/acp.h                  |  40 ++++++
> >>>>      3 files changed, 262 insertions(+), 57 deletions(-)
> >>>
> >>>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> >>> b/sound/soc/amd/acp-da7219-max98357a.c
> >>>> index 133139d..b3184ab 100644
> >>>> --- a/sound/soc/amd/acp-da7219-max98357a.c
> >>>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> >>>> @@ -36,6 +36,7 @@
> >>>>      #include <linux/input.h>
> >>>>      #include <linux/acpi.h>
> >>>
> >>>> +#include "acp.h"
> >>>>      #include "../codecs/da7219.h"
> >>>>      #include "../codecs/da7219-aad.h"
> >>>
> >>>> @@ -44,6 +45,7 @@
> >>>
> >>>>      static struct snd_soc_jack cz_jack;
> >>>>      static struct clk *da7219_dai_clk;
> >>>> +extern int bt_pad_enable;
> >>>
> >>> WARNING: externs should be avoided in .c files
> >
> >> We don't have .h file for machine driver and It can be ignored for
> >> one variable.
> >>>
> >>>
> >>>>      static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
> >>>>      {
> >>>> @@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list
> >>> constraints_channels = {
> >>>>      static int cz_da7219_startup(struct snd_pcm_substream
*substream)
> >>>>      {
> >>>>             struct snd_pcm_runtime *runtime = substream->runtime;
> >>>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >>>> +       struct snd_soc_card *card = rtd->card;
> >>>> +       struct acp_platform_info *machine =
> >>> snd_soc_card_get_drvdata(card);
> >>>
> >>>>             /*
> >>>>              * On this platform for PCM device we support stereo
> >>>> @@ -143,6 +148,7 @@ static int cz_da7219_startup(struct
> > snd_pcm_substream
> >>> *substream)
> >>>>             snd_pcm_hw_constraint_list(runtime, 0,
> > SNDRV_PCM_HW_PARAM_RATE,
> >>>>                                        &constraints_rates);
> >>>
> >>>> +       machine->i2s_instance = I2S_BT_INSTANCE;
> >>>
> >>> I'm not a big fan of this approach, but I don't know any other way to
> > tell
> >>> a single "platform" driver (acp-pcm-dma) which of two channels (ST/BT)
> > to
> >>> use via the pcm_open() callback.
> >>>
> >>> Mark, can you recommend any other way of doing this?
> >
> >> Hi Dan,
> >
> >> There have been couple of approaches worked upon this earlier.
> >> 1) To compare cpu dai name to get the I2S instance value in
> >> acp_dma_open() call.
> >
> >> But, Mark suggested not to implement this approach as we are comparing
> >> dynamically generated cpu dai names.
> >
> >> 2) We added i2s_instance parameter as platform data to dwc driver.
> >> By querying dwc driver platform data in acp dma driver, current i2s
> >> instance was programmed in acp_dma_open ().
> >
> >> But Mark's latest comment was to implement platform specific changes in
> >> machine driver. Machine driver and Dma driver should exchange the data
> >> regarding this. We accepted this and current approach is based on the
> >> same comment.
> >> Below is the reference.
> >> https://lkml.org/lkml/2018/4/18/597
> >
> > Yes, I saw Mark's previous comment, but what we are trying to implement
> > here is the SoC specific binding between i2s channel and acp-dma
channel.
> > This is a feature of the SoC, not of the i2s controller, but also not a
> > feature of the audio configuration on the board.
> The binding of channel and dma is soc specific but codec to channel is
> board specific.
> These linkages can change from one board to another. Machine driver is
> specific to a board (grunt here) and dma driver being common for various
> boards (but specific to a platform like ST/CZ here). Tomorrow there can
> be some other board with x codec linked to BT and y to SP.
> Hence, machine driver should send this board specific link information
> to dma driver for it to dma on the correct channel as per the board.
>     For these SoCs, the link
> > between DMA registers & I2S-channel is hard-coded.  The machine driver
is
> > already specifying which i2s channel to use when it configures, for
> > example, '.cpu_dai_name = "designware-i2s.2.auto"'.  The i2s channel
> > selection already implies a particular DMA configuration.  It seems
> > redundant to create this separate out-of-band infrastructure to make the
> > machine driver also tell its platform driver '.platform_name =
> > "acp_audio_dma.0.auto"' which i2s channel it is using.
> >

> We could have decided on the basis of "cpu_dai_name" but the decision
> would have been based on dynamically generated name. Though maybe
> redundant in nature, but machine driver is just sending info to dma
> driver that this codec is playing so play on this instance.

> > Perhaps the acp-pcm-dma.c should register two different platform
drivers,
> > and let the machine driver pick the appropriate one (ie,
> > acp_audio_dma.0.auto or acp_audio_dma.1.auto) depending on which i2s
port
> > it needs?  Then each of these would have its own
> > snd_soc_platform_driver->ops->open() that could setup
> > snd_pcm_runtime->private_data appropriately?

> I guess it would be overkill to have 2 platform drivers one for each
> instance but actually for a single platform.

>     Or is there another standard
> > way to have a single snd_soc_platform_driver handle multiple channels?
> >

> Don't know if there is a standard but would be interesting to know how
> other platforms handle multiple instances.


Hmm, there may be another way that we don't see yet, but in any case, I see
no harm in merging this patch set as is.
So, for the series, feel free to add:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>



> Thanks,
> Akshu
> > -Dan
> >
