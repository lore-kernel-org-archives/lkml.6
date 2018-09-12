Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40AA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFdlo845"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40AA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeILOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:36:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeILOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:36:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so1585673wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfhrvaTDjnE7OZRw0qpn0jNHqJkyc2VRrJaJ38IMeXc=;
        b=AFdlo845GS0s+aDz3quSGRjghml9CqyOeA+vjfzB9MU+EdAOXOJdfiTe/1ogfPCfxO
         5Jj8BCD///TJmhq4bn7lPu9GcXQtp1tkVnGpfagPsKrKphsDnWvgasURpHi2Z68u6yAo
         tauBcYClNbZxaWd6DQTO7F9E/Gx/lNjKfGNYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfhrvaTDjnE7OZRw0qpn0jNHqJkyc2VRrJaJ38IMeXc=;
        b=arz+8Ux5KdKQXGUHLVWk+mdTHEX35l0aJIMhBTpzaNOQkAbYExUcBHrkv8EyCcC0eg
         NSenHr2p5zdhrgabuMEeXR/pPh0b8g2owq+zW6abiOlNvV+x+GSj8elB0+r6mblmaEUD
         XGc8f4mVY28KBpaQNuxnwzpv/Rt3tjWOUhQ8/fnwIAmxD7JEmLoRdcspOxAjAK4n3iXb
         x9ep92inGo818rZYicddYvYRLYh8orl+xYmyFlwyrDGR5Zbuuv3mE6ESssIqzMj+xIl7
         kMkfBog0BMtF9fCD0BxXoshe2+Z2YAzGbbr8mJglMcVeDIr72iA8s/AbXs3DB+7SjOLB
         R/oA==
X-Gm-Message-State: APzg51BoVZKY94Jm1OABQjLhAYcPl2AI8FVgT8iCaCZHpNEXQJgFLWHK
        5Pa6IVJ03BANwnjX5lMda0obSA==
X-Google-Smtp-Source: ANB0VdZ1hPKhKE6XrRT97PxUsbbK1qb2Yfzz2DcOUSMkjK4HQgBY4RpY3BkmGE5kny3Nt+00SaCLag==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr1046178wmg.123.1536744779628;
        Wed, 12 Sep 2018 02:32:59 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id y205-v6sm12693195wmc.3.2018.09.12.02.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 02:32:59 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
Date:   Wed, 12 Sep 2018 10:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180912085848.GP4185@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 09:58, Lee Jones wrote:
>>>> +static const struct mfd_cell wcd9335_devices[] = {
>>>> +	{ .name = "wcd9335-codec", },
>>>> +};
>>> Are there more devices to come?
>>>
>> Yes, that is the plan, we are kind of limited in hardware setup to test few
>> things like soundwire controller. We are exploring other ways to test these.
> I normally don't accept MFDs with just one device enabled.  Since it's
> not really an MFD (M == Multi) until it has more than one function.
> 

WCD9335 Codec hw itself has multiple hw blocks.

If the issue is about adding more entries to mfd cells then we should be 
able to add below entry:

	{ .name = "wcd9335-soundwire-controller", },

Actual driver for soundwire controller is not something We can test with 
regular dragon boards, it needs special hw for smart speakers. Once we 
have that we can test and post the drivers for that.

Otherwise

Are you suggesting that I move everything to  sound/soc/codecs and then 
back to mfd once soundwire controller driver is added?



> [...]
> 
>>>> +	struct device_node *ifc_dev_np;
>>> ifc isn't very forthcoming.  Any way you can improve the name?
>> ifc was suggested in dt bindings by Rob,  I can proably rename to
>> interface_node.
> ifc is a horrible variable name - just sayin'.
> 
> [...]
> 
>>>> +	ret = wcd9335_bring_up(wcd);
>>> So the device_status call-back brings up the hardware?
>>>
>> device status reports the device status at runtime. We can not communicate
>> with the device until it is up, enumerated by slimbus and a logical address
>> is assigned to it. So the best place to initialize it is in status callback
>> where all the above are expected to be done.
> Right, I understand what's happening.  I just think the semantics are
> wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
> status and it ends up initiating a start-up sequence.  Just from a
> purist's point of view (I understand that it "works"), it's not good
> practice.
> 
>> Probe is expected to setup the external configurations like regulators/pins
>> and so on which gets the device out of reset and ready to be enumerated by
>> the slimbus controller.
> I suggest fully starting the device in probe() is a better approach.
> 
Its catch-22 situation, without device being powered up and reset 
correctly there is no way to enumerate it.


> [...]
> 
>>>> +struct wcd9335 {
>>>> +	int version;
>>>> +	int intr1;
>>> What's this?  If I have to ask, it's probably not a good name.
>>>
>> This is a hardware pin name for interrupt line 1.
> I don't see how this is used, so it's difficult for me to advise
> fully, but I find this confusing.  Pin name/number?  Shouldn't this be
> handed by Pinctrl?
> 
This is represented as proper irq line in dt via  pintrl irq controller.


> intr1 could be quite ambiguous.  Especually as the '1' could easily be
> read as an 'l'.  Suggest that 'irq1' or 'irq_1' or 'irq_one'.

I can change this to something more readable in next version or may be I 
can even remove it may be just use a local variable.


thanks,
srini
> 
> -- Lee Jones [李琼斯] Linaro Services Technical Lead Linaro.org │ Open 
> source software for ARM SoCs Follow Linaro: Facebook | Twitter | Blog
