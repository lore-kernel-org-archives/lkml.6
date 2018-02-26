Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AH8x2269fMviWFkD420/Q9Mh3LQaO7PEqSKCQ3qgQS+0yK6AKO7mSm5YmUJM5RUDx+jD03KwNNek
ARC-Seal: i=1; a=rsa-sha256; t=1519643211; cv=none;
        d=google.com; s=arc-20160816;
        b=q+yeuaKOQgsaOnzRqYUKHVvaeGgpfb3HUROeyYJA/RMohUrXYB5g/eSGm8K7V28ADc
         xaiOOb5DckqUXQlyWU0qNoVu+MiwoB0BZ8/EPPcBh9+JMze69lqyj0odSOeXZxLeVBOe
         hnxOGw4lK/y3ob655IG/sd/XpaHytuXLMcCAwgLzZW6aHrzwK0GrLQlU3sQoJfkvpWBf
         JjjwNQHj3i4nTa9eeNZXTfNkFoULdR0wxr1s599r11rLSnPMP+0nJDZaoMmylbmaJK/t
         Md0STcxn3JrK9O4nmtFOv+RtdRW0C70WetBPSr/1F/J7jkMFTVyUkC0KVR3juGLFed8U
         1rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=HWypjzyaYdKX8NDnmfHlK+hrgSdXohWFzP0eFzM+u1Y=;
        b=B9i+tsjezapHxEosCu2i/UAKsclHaWYmwTdRzI5Ci9i7q3VcR3Y856g16WI9kZYCUi
         OMascG0pbC7lbtpM0d1dzpfGHuMgixs0ieoM7iIbZj6cf60PqTEe6kcbTrRGBInhCaSv
         JKIqgBk8PKtIrAuwdo8ExipriD/gdhJZSYMpCgWH9YQMvyUt1WB+Ppkkrfrq2YTjMlni
         kLvmDya1wBXVFL6dZDTsDOoCQGeG+MJLM3H06ij0/Num3t6hq8rYH0N/TEBAnuA5GSoS
         Ccw3vj/TB8fos5JPwmvBlR4OsTtdQiv5KX9Sn8Me6JVYdOKYIkFT1xG4uNalS1XwOO/m
         ubnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.25 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.25 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH v7 2/2] media: V3s: Add support for Allwinner CSI.
To: Yong <yong.deng@magewell.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Hugues Fruchet <hugues.fruchet@st.com>,
 Yannick Fertre <yannick.fertre@st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Rick Chang <rick.chang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <1517217696-17816-1-git-send-email-yong.deng@magewell.com>
 <c86097d7-dade-01e5-3826-3f22f9ca4b4f@infradead.org>
 <20180130104833.a06e44c558c7ddc6b38e20b3@magewell.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ce3a30b9-f017-61b6-1fe6-f5dcc8bd3ec3@xs4all.nl>
Date: Mon, 26 Feb 2018 12:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180130104833.a06e44c558c7ddc6b38e20b3@magewell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOGnvlmQpjJiP3+Ub8nzoqbYEJx9Q7SNHwW7V0DFim4Md2+6/LSgDXD7MX0965db4fYhTeuGhy7LoaaJfp8roLTD8Fsa1y4hJofDuJidhj4a5vtSL+4O
 Btw4Vp6FETu+8/idUoAoKq21C32ExbStAjv806UodzHrIcnV+QHdsJfIL2wjF6YDJgTtnd+fSKa+fQrdRWJR2fJATuauxqiiYS5M0SkL5qHAmm+Pa2pl0y1X
 wFMIVJQU2kO/6lw/I6ufXfANiYeUeHOGLo7uZ1vspBVZxx6nMhdDuTJBsWkmwmuRVx2tGKHlXxfwvlgYiGqt/aTGo/4LCZwZy6O1p9Z1oKuXf3NpJ5RS75+D
 Gpkj/DYZZ3O9Mk6WwBgzdqPMNeU/a5k6u2DExd+mX5l/pLij+VptcAgva8P1rXDl+cMLwyn9sYyylLDEjpxokx86rhsxIXPO+VpfOP9mjDgO0luMwC3+5SrB
 9/DIE/POr8BsNr3VWIkDe3at9J+QAlzcDhbSBChPquLwxKVyyrVrNyx4tkno2SbKGcsv4n3IY/r/y4PdytV1sn0WK5opg35ZrPs0/oXire95MJ/RoYFrKEkC
 HJknRGZ+lZ49HHysurrC2lcoSJrzawL9FAcy32jl68iCZw54WVv9RH8BwISHKBfaEf8GGnFiZ/++0j/agb9im/GPptSz/1ddf8IV7sVqzhvm0Cxp0vLCaOmz
 pfiwpd4qKyD15wlGLfPHCm84tjJhLnYVfpz50Ge3XEgETqIV4pPwFinavEp7XUa72EuYCO1AKfELVF1AJsB5Wabx7kLeGUtniwaoT+e4lAnziWt1b23P2tgJ
 t6Z5U7M1GsOk1zd585ao54vmIHXWcI8SGFk16PsgFgSAdv/BPmGhickozEWAxUq7rZ6DPGUw04nzPDi3tgDC1XuzkIwLQbhSYMa4rAvs/xkeRLjpvQV7ndNq
 JD2naS1b9k8iV/Wl3kYIoN+/roC7Ws/8jPxS2tFxyk5727gR3Ec0aM2fyXFse9+WqMdF9A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590918123212414894?=
X-GMAIL-MSGID: =?utf-8?q?1593461400372982202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

On 01/30/2018 03:48 AM, Yong wrote:
> Hi,
> 
> On Mon, 29 Jan 2018 13:49:14 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 01/29/2018 01:21 AM, Yong Deng wrote:
>>> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
>>> interface and CSI1 is used for parallel interface. This is not
>>> documented in datasheet but by test and guess.
>>>
>>> This patch implement a v4l2 framework driver for it.
>>>
>>> Currently, the driver only support the parallel interface. MIPI-CSI2,
>>> ISP's support are not included in this patch.
>>>
>>> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Signed-off-by: Yong Deng <yong.deng@magewell.com>
>>> ---
>>
>>
>> A previous version (I think v6) had a build error with the use of
>> PHYS_OFFSET, so Kconfig was modified to depend on ARM and ARCH_SUNXI
>> (one of which seems to be overkill).  As is here, the COMPILE_TEST piece is
>> meaningless for all arches except ARM.  If you care enough for COMPILE_TEST
>> (and I would), then you could make COMPILE_TEST useful on any arch by
>> removing the "depends on ARM" (the ARCH_SUNXI takes care of that) and by
>> having an alternate value for PHYS_OFFSET, like so:
>>
>> +#if defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)
>> +#define PHYS_OFFSET	0
>> +#endif
>>
>> With those 2 changes, the driver builds for me on x86_64.
> 
> I have considered this method.
> But it's so sick to put these code in dirver (for my own). I mean 
> this is meaningless for the driver itself and make people confused.
> 
> I grepped the driver/ code and I found many drivers writing Kconfig
> like this. For example:
> ARM && COMPILE_TEST
> MIPS && COMPILE_TEST
> PPC64 && COMPILE_TEST
> 
> BTW, for my own, I do not care about COMPILE_TEST.

There was a discussion about this in the v6 patch, but it petered out.

I want to merge this driver, but I would very much prefer that this
compiles with COMPILE_TEST. So unless someone has a better solution, then
adding 'hack' that defines PHYS_OFFSET to 0 for COMPILE_TEST would be required.

Otherwise this driver looks good, so it is just this issue blocking it.

Regards,

	Hans

> 
>>
>>> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
>>> new file mode 100644
>>> index 0000000..f80c965
>>> --- /dev/null
>>> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
>>> @@ -0,0 +1,10 @@
>>> +config VIDEO_SUN6I_CSI
>>> +	tristate "Allwinner V3s Camera Sensor Interface driver"
>>> +	depends on ARM
>>> +	depends on VIDEO_V4L2 && COMMON_CLK && VIDEO_V4L2_SUBDEV_API && HAS_DMA
>>> +	depends on ARCH_SUNXI || COMPILE_TEST
>>> +	select VIDEOBUF2_DMA_CONTIG
>>> +	select REGMAP_MMIO
>>> +	select V4L2_FWNODE
>>> +	---help---
>>> +	   Support for the Allwinner Camera Sensor Interface Controller on V3s.
>>
>> thanks,
>> -- 
>> ~Randy
> 
> 
> Thanks,
> Yong
> 
