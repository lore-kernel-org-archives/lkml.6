Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C7E208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C7E208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeGJVs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:48:59 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:60740 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbeGJVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:48:59 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fd0UE-000071-26; Tue, 10 Jul 2018 23:47:54 +0200
Subject: Re: [PATCH v7 3/6] cx25840: add pin to pad mapping and output format
 configuration
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1530565770.git.mail@maciej.szmigiero.name>
 <984fbf6359a896f156ddf64b1fb8211c3cca54e3.1530565770.git.mail@maciej.szmigiero.name>
 <3421f58a-3a60-28f1-830c-66f5d1bf5517@xs4all.nl>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9ab4947-b306-3f9e-1951-a4fd62987f8f@maciej.szmigiero.name>
Date:   Tue, 10 Jul 2018 23:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <3421f58a-3a60-28f1-830c-66f5d1bf5517@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 04.07.2018 11:05, Hans Verkuil wrote:
> On 02/07/18 23:23, Maciej S. Szmigiero wrote:
(..)
>> @@ -316,6 +319,260 @@ static int cx23885_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
>>  	return 0;
>>  }
>>  
>> +static u8 cx25840_function_to_pad(struct i2c_client *client, u8 function)
>> +{
>> +	switch (function) {
>> +	case CX25840_PAD_ACTIVE:
>> +		return 1;
>> +
>> +	case CX25840_PAD_VACTIVE:
>> +		return 2;
>> +
>> +	case CX25840_PAD_CBFLAG:
>> +		return 3;
>> +
>> +	case CX25840_PAD_VID_DATA_EXT0:
>> +		return 4;
>> +
>> +	case CX25840_PAD_VID_DATA_EXT1:
>> +		return 5;
>> +
>> +	case CX25840_PAD_GPO0:
>> +		return 6;
>> +
>> +	case CX25840_PAD_GPO1:
>> +		return 7;
>> +
>> +	case CX25840_PAD_GPO2:
>> +		return 8;
>> +
>> +	case CX25840_PAD_GPO3:
>> +		return 9;
>> +
>> +	case CX25840_PAD_IRQ_N:
>> +		return 10;
>> +
>> +	case CX25840_PAD_AC_SYNC:
>> +		return 11;
>> +
>> +	case CX25840_PAD_AC_SDOUT:
>> +		return 12;
>> +
>> +	case CX25840_PAD_PLL_CLK:
>> +		return 13;
>> +
>> +	case CX25840_PAD_VRESET:
>> +		return 14;
>> +
>> +	default:
>> +		if (function != CX25840_PAD_DEFAULT)
>> +			v4l_err(client,
>> +				"invalid function %u, assuming default\n",
>> +				(unsigned int)function);
>> +		return 0;
>> +	}
> 
> Unless I am mistaken this function boils down to:
> 
> static u8 cx25840_function_to_pad(struct i2c_client *client, u8 function)
> {
> 	return function > CX25840_PAD_VRESET ? 0 : function;
> }

Yes, you are right these functions are equivalent (sans a warning when
a caller passes an invalid function).

However, these values (CX25840_PAD_*) were meant to be driver-internal.
If we use them also as register value constants (which is what
cx25840_function_to_pad() is supposed to return) then we'll need to add
a comment to their enum cx25840_io_pad so nobody shuffles them or changes
their values by mistake.

>> @@ -1647,6 +1924,119 @@ static void log_audio_status(struct i2c_client *client)
>>  	}
>>  }
>>  
>> +#define CX25840_VCONFIG_OPTION(state, cfg_in, opt_msk)			\
>> +	do {								\
>> +		if ((cfg_in) & (opt_msk)) {				\
>> +			(state)->vid_config &= ~(opt_msk);		\
>> +			(state)->vid_config |= (cfg_in) & (opt_msk);	\
>> +		}							\
>> +	} while (0)
>> +
>> +#define CX25840_VCONFIG_SET_BIT(state, opt_msk, voc, idx, bit, oneval)	\
>> +	do {								\
>> +		if ((state)->vid_config & (opt_msk)) {			\
>> +			if (((state)->vid_config & (opt_msk)) ==	\
>> +			    (oneval))					\
>> +				(voc)[idx] |= BIT(bit);		\
>> +			else						\
>> +				(voc)[idx] &= ~BIT(bit);		\
>> +		}							\
>> +	} while (0)
>> +
>> +int cx25840_vconfig(struct i2c_client *client, u32 cfg_in)
>> +{
>> +	struct cx25840_state *state = to_state(i2c_get_clientdata(client));
>> +	u8 voutctrl[3];
>> +	unsigned int i;
>> +
>> +	/* apply incoming options to the current state */
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_FMT_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_RES_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VBIRAW_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_ANCDATA_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_TASKBIT_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_ACTIVE_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VALID_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_HRESETW_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_CLKGATE_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_DCMODE_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_IDID0S_MASK);
>> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VIPCLAMP_MASK);
> 
> This appears to be a very complex way of saying:
> 
> 	state->vid_config = cfg_in;

This is supposed to change in vid_config only these options that are set
in the incoming cfg_in, leaving the rest as-is.

If the code simply assigns cfg_in to vid_config it will also clear all the
existing options.

> 
>> +
>> +	for (i = 0; i < 3; i++)
>> +		voutctrl[i] = cx25840_read(client, 0x404 + i);
>> +
>> +	/* apply state to hardware regs */
>> +	if (state->vid_config & CX25840_VCONFIG_FMT_MASK)
>> +		voutctrl[0] &= ~3;
>> +	switch (state->vid_config & CX25840_VCONFIG_FMT_MASK) {
>> +	case CX25840_VCONFIG_FMT_BT656:
>> +		voutctrl[0] |= 1;
>> +		break;
>> +
>> +	case CX25840_VCONFIG_FMT_VIP11:
>> +		voutctrl[0] |= 2;
>> +		break;
>> +
>> +	case CX25840_VCONFIG_FMT_VIP2:
>> +		voutctrl[0] |= 3;
>> +		break;
>> +
>> +	case CX25840_VCONFIG_FMT_BT601:
>> +		/* zero */
>> +	default:
>> +		break;
>> +	}
>> +
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_RES_MASK, voutctrl,
>> +				0, 2, CX25840_VCONFIG_RES_10BIT);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VBIRAW_MASK, voutctrl,
>> +				0, 3, CX25840_VCONFIG_VBIRAW_ENABLED);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_ANCDATA_MASK, voutctrl,
>> +				0, 4, CX25840_VCONFIG_ANCDATA_ENABLED);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_TASKBIT_MASK, voutctrl,
>> +				0, 5, CX25840_VCONFIG_TASKBIT_ONE);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_ACTIVE_MASK, voutctrl,
>> +				1, 2, CX25840_VCONFIG_ACTIVE_HORIZONTAL);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VALID_MASK, voutctrl,
>> +				1, 3, CX25840_VCONFIG_VALID_ANDACTIVE);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_HRESETW_MASK, voutctrl,
>> +				1, 4, CX25840_VCONFIG_HRESETW_PIXCLK);
>> +
>> +	if (state->vid_config & CX25840_VCONFIG_CLKGATE_MASK)
>> +		voutctrl[1] &= ~(3 << 6);
>> +	switch (state->vid_config & CX25840_VCONFIG_CLKGATE_MASK) {
>> +	case CX25840_VCONFIG_CLKGATE_VALID:
>> +		voutctrl[1] |= 2;
>> +		break;
>> +
>> +	case CX25840_VCONFIG_CLKGATE_VALIDACTIVE:
>> +		voutctrl[1] |= 3;
>> +		break;
>> +
>> +	case CX25840_VCONFIG_CLKGATE_NONE:
>> +		/* zero */
>> +	default:
>> +		break;
>> +	}
>> +
>> +
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_DCMODE_MASK, voutctrl,
>> +				2, 0, CX25840_VCONFIG_DCMODE_BYTES);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_IDID0S_MASK, voutctrl,
>> +				2, 1, CX25840_VCONFIG_IDID0S_LINECNT);
>> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VIPCLAMP_MASK, voutctrl,
>> +				2, 4, CX25840_VCONFIG_VIPCLAMP_ENABLED);
>> +
>> +	for (i = 0; i < 3; i++)
>> +		cx25840_write(client, 0x404 + i, voutctrl[i]);
>> +
>> +	return 0;
>> +}
>> +
>> +#undef CX25840_VCONFIG_SET_BIT
>> +#undef CX25840_VCONFIG_OPTION
> 
> Why #undef? You would normally never do that.

The idea here is to catch (unintended) other users of these macros, other
than cx25840_vconfig() and to not pollute the macro namespace.
But these #undefs can be removed if they are against the coding style.

> 
>> +
>>  /* ----------------------------------------------------------------------- */
>>  
>>  /* This load_fw operation must be called to load the driver's firmware.
>> @@ -1836,6 +2226,9 @@ static int cx25840_s_video_routing(struct v4l2_subdev *sd,
>>  	if (is_cx23888(state))
>>  		cx23888_std_setup(client);
>>  
>> +	if (is_cx2584x(state) && state->generic_mode)
>> +		cx25840_vconfig(client, config);
>> +
> 
> You do the vconfig configuration when the video routing changes. But isn't this
> configuration a one-time thing? E.g. something you do only when initializing the
> board?
> 
> At least in the cxusb code the cfg_in value is constant and not dependent on what
> input is chosen.
> 
> If this is true, then you should add the core init op instead. And as a bonus you
> can turn on generic_mode if the init op is called instead of having to add it
> to the platform data.
> 

The problem here is that the Medion MD95700 has two modes:
digital (DVB-T) and analog.
When it is operating in the digital mode the device analog components
(including the cx25840 chip) have their power cut by the hardware.

This means that the cx25840 has to be fully reinitialized (firmware
loaded, format set, etc.) every time the user opens the Medion's v4l2
video or radio device node if the device has previously operated in the
DVB-T mode.
Mode switching is supported transparently by the driver without needing
to reload the module or reconnect the device.

> 
> Regards,
> 
> 	Hans
> 

Thanks and best regards,
Maciej
