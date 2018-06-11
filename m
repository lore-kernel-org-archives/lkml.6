Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7BBFC07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692702086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugSZIHyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692702086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbeFKTFw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934324AbeFKTFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:05:50 -0400
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0012087E;
        Mon, 11 Jun 2018 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528743950;
        bh=6Tvf+T1OUSJ9Lt68XpdzTSeeYGPneK16guRRD0XHFOw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ugSZIHyDIlPYIhi8iNY4gRpuWdEkTkqe72Lv+9psdgoo+WckxoDL/1BZtA/SO23xf
         FdvK7KM3iI0RnkKj4AFWobpubQL2wB2uuruB7EYxr+SYwqHtI0Zp2t3nc4aFtlPjj6
         x2N+ux2Op8pAmx+1SW5dLrrINO5KX5JMj7ayNsk4=
Received: by mail-it0-f51.google.com with SMTP id n7-v6so11672864itn.1;
        Mon, 11 Jun 2018 12:05:50 -0700 (PDT)
X-Gm-Message-State: APt69E0ScsqgCuaj+mrmMinZgHs2M/UnqkldbhChohQiZnEfJk6HYLl8
        SHDFNJ5Q5W7kcs3Ex+tVDhyMcc+gn0bTrS6ijw==
X-Google-Smtp-Source: ADUXVKIKlw4GoF8WXXvk9gcBloC9+cW5G87UXGVVd40WDVOqUtJxH6YI670ewYYl6xBC/VIvd0s+sGceo34bkjxLMkw=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr223305itc.19.1528743949677;
 Mon, 11 Jun 2018 12:05:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 12:05:29
 -0700 (PDT)
In-Reply-To: <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
 <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org> <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
 <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Jun 2018 13:05:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKi=GPYGabjrkKx+1Qv9=NnB6j7=YQhQsBwOBWGAY03tw@mail.gmail.com>
Message-ID: <CAL_JsqKi=GPYGabjrkKx+1Qv9=NnB6j7=YQhQsBwOBWGAY03tw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:19 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Rob,
>
>>>>>>> Added support to automatically configure the SCO packet routing at =
the
>>>>>>> device setup. The SCO packets are used with the HSP / HFP profiles,=
 but in
>>>>>>> some devices (ex. CYW43438) they are routed to a PCM output by defa=
ult. This
>>>>>>> change allows sending the vendor specific HCI command to configure =
the SCO
>>>>>>> routing. The parameters of the command are loaded from the device t=
ree.
>>>>>>
>>>>>> Please wrap your commit msg.
>>>>>
>>>>>
>>>>> Sure.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>>>>>>> ---
>>>>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>>>>>
>>>>>> Please split bindings to separate patch.
>>>>>
>>>>>
>>>>> Ok, I will split this in two.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>> drivers/bluetooth/hci_bcm.c                   | 72 ++++++++++++++++=
+++
>>>>>>> 2 files changed, 79 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> index 4194ff7e..aea3a094 100644
>>>>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> @@ -21,6 +21,12 @@ Optional properties:
>>>>>>> - clocks: clock specifier if external clock provided to the control=
ler
>>>>>>> - clock-names: should be "extclk"
>>>>>>>
>>>>>>> + SCO routing parameters:
>>>>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>>>>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>>>>>>> + - pcm-frame-type: 0 (short), 1 (long)
>>>>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
>>>>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
>>>>>>
>>>>>> Are these Broadcom specific? Properties need either vendor prefix or
>>>>>> to be documented in a common location. I think these look like the
>>>>>> latter.
>>>>>
>>>>>
>>>>> These will be used as parameters of a vendor specific (Broadcom/Cypre=
ss)
>>>>> command configuring the SCO packet routing. See the Write_SCO_PCM_Int=
_Param
>>>>> command from: http://www.cypress.com/file/298311/download.
>>>>
>>>> The DT should just describe how the h/w is hooked-up. What the s/w has
>>>> to do based on that is the driver's problem which is certainly
>>>> vendor/chip specific, but that is all irrelevant to the binding.
>>>>
>>>>> What would be the property names with a Broadcom / Cypress vendor pre=
fix?
>>>>>
>>>>>   brcm,sco-routing
>>>>>   brcm,pcm-interface-rate
>>>>>   brcm,pcm-frame-type
>>>>>   brcm,pcm-sync-mode
>>>>>   brcm,pcm-clock-mode
>>>>>
>>>>> ?
>>>>
>>>> Yes.
>>>
>>> we can do this. However all pcm-* are optional if you switch the HCI tr=
ansport. And sco-routing should default to HCI if that is not present. Mean=
ing a driver should actively trying to change this. Nevertheless, it would =
be good if a driver reads the current settings.
>>>
>>> In theory we could make sco-routing generic, but so many vendors have d=
ifferent modes, that we better keep this vendor specific.
>>
>> Even if vendor specific, the properties for not HCI transport case are
>> still incomplete IMO.
>>
>> By modes, you mean PCM vs. I2S and all the flavors of timings you can
>> have within those or something else? For the former, that's often
>> going to be a process of solving what each end support and if that
>> doesn't work, then IIRC we already have properties for setting
>> modes/timing. All the same issues exist with audio codecs and this is
>> really not any different.
>
> this is what Broadcom uses to configure their PCM transport. So I think f=
or now, we make them brcm, specific and see how that goes. We can always ge=
neralize them later if enough chip manufactures provide support for it.

We already have properties doing the same thing defined in
Documentation/devicetree/bindings/sound/simple-card.txt. Use and
extend that. We don't need new properties especially for something
that is not complete. For example If I have 2 host ports (every SoC
has at least 2), how do I indicate which one is connected to BT.

Rob
