Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeDQIcq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:32:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26511 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751235AbeDQIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:32:44 -0400
From: Olivier MOYSAN <olivier.moysan@st.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
        "jsarha@ti.com" <jsarha@ti.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Thread-Topic: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Thread-Index: AQHTuugk+f/v2G3G5kiIINnSVNO0DaQEtPsA
Date: Tue, 17 Apr 2018 08:29:17 +0000
Message-ID: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2457FA169E377F43A07A71F8D69433AF@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3H8Wu8q029305

Hello,

I guess the blocking patch in this patchset is the patch "add IEC958 
channel status control helper". This patch has been reviewed several 
times, but did not get a ack so far.
If you think these helpers will not be merged, I will reintegrate the 
corresponding code in stm driver.
Please let me know, if I need to prepare a v2 without helpers, or if we 
can go further in the review of iec helpers patch ?

Best regards
olivier


On 03/13/2018 05:27 PM, Olivier Moysan wrote:
> This patchset adds support of iec958 controls to STM32 SAI driver.
> 
> The patch makes use of iec958 control status helpers previously proposed
> and discussed through the following threads:
> https://patchwork.kernel.org/patch/8062601/
> https://patchwork.kernel.org/patch/8091551/ (v2)
> https://patchwork.kernel.org/patch/8462961/ (v3)
> https://patchwork.kernel.org/patch/8533731/ (v4)
> 
> Olivier Moysan (3):
>    ALSA: pcm: add IEC958 channel status control helper
>    ASoC: stm32: sai: add iec958 controls support
>    ASoC: dmaengine_pcm: document process callback
> 
>   include/sound/dmaengine_pcm.h |   2 +
>   include/sound/pcm_iec958.h    |  19 +++++++
>   sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/stm/Kconfig         |   1 +
>   sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
>   5 files changed, 225 insertions(+), 12 deletions(-)
> 
