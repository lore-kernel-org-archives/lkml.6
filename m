Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424035AbeCBNNm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:13:42 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55852 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423737AbeCBNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:13:23 -0500
X-Google-Smtp-Source: AG47ELvVuRQPAjKuMVIE54t1TZTEtAX048v5js1yelOHFKtpcE3ibMAGBkCtNrzx3S9Mq9+TY3oFWA==
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
 <20180301203413.GN12864@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2608d36a-cf4e-5b06-a26a-8d4ee0bb41ad@linaro.org>
Date: Fri, 2 Mar 2018 13:13:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180301203413.GN12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 01/03/18 20:34, Mark Brown wrote:
> On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
>> On 22/02/18 00:14, Rob Herring wrote:
> 
>>> Am I saying a single DT node for this? Yes, perhaps.
>> Yes, I will give that a go.
>>
>> So we will endup having something like this in DT for one frontend and
>> backend dailink:
> 
> Let's not start encoding DPCM into DT, DPCM is very much an
> implemntation detail of the current stack which we're gradually pushing
> towards replacing with something better.  What we want to be doing is
> just treating components inside the SoC the same as components in a
> CODEC, the routing within a SoC being the same as in a CODEC and
> similarly for externally connected devices.
> 
>> 		fe@1 {
>>                  	is-fe;
>>                          link-name = "MultiMedia1";
> 
> In particular having the concept of "front end" in the DT is *very*
> implementation specific.  We should just be describing the connections
> that exist in the system.
Yep, it makes sense. is-fe flag will be removed in next version, we can 
determine this based on codec dai, so from DT side FE or BE should not 
be any different.

Thanks,
srini

> 
