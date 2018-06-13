Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3B15C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61C208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLEHOi+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61C208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935677AbeFMTkL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:40:11 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54610 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935320AbeFMTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:40:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id o13-v6so6629935wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j8xffuvTMzc/YJbqukUKE6C62B3erBMAzfWGDvzC7ug=;
        b=XLEHOi+V5vObllJytnWmRjQ+m/2okdg+WsAHRlr9k9Wx5cWsLhCuZVPVxn4PE/eIQq
         a8yuTMQSUhg8V8ouauBos8Eem+TLFIDsFStVejEtfB25KTWO+Kfq01i2DBrJW6e0dBfa
         XbvO8oZtTrbyRaaPGOAW7pBEnT17ZMTK8Pi94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j8xffuvTMzc/YJbqukUKE6C62B3erBMAzfWGDvzC7ug=;
        b=ePxL0jm0tNJCXQW6JB63KsBPlYd5nBFdAdUy1Ls+37ULOugcWv/3Zzssb7pk4iNRwV
         WEVgyb1cI+WRfdJ3x89j07Y0EFoHtfzb1hHV4Y23k/yujhvNNZQvD7M3gZHT7y74hFxK
         UW60wfNOdbYNHK7qf8jfLCEbhRBwcEbJuxY6CFKERuHLNAloXOtKg4kWYj9bx08lxNWT
         5UwvIxuOqoa9apxTWgD4LybXgOgUrS6usrw4a69Bb1RyUmypFg/HDlrhR60kR0jj9/q3
         hHTrcmpQb14fNfiETpnHq8H4qjKzBgpJ5f1TthA/Q99eIK23S2eUILbmnrtE+R22e7KA
         3J4g==
X-Gm-Message-State: APt69E1xM/WFl5h9Ds2zFk6XqtQzN+p9R3JV5AEzBicZHEieBOUUWFar
        ROjYS/l5CkiTIREvrhFLzSU7Wi/yXYsCeo2TFuk2zA==
X-Google-Smtp-Source: ADUXVKKF6W2SQREJRdBGlcrWhAZDwKbGdvuS4iwnhGlCBP8QiO3vG1wRzoP+PaHlypH461cTAFOzlS+BJdf0E4pt/QM=
X-Received: by 2002:a50:b52a:: with SMTP id y39-v6mr5445821edd.195.1528918807610;
 Wed, 13 Jun 2018 12:40:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:40:07
 -0700 (PDT)
In-Reply-To: <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop> <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com> <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 13 Jun 2018 13:40:07 -0600
Message-ID: <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph bindings
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     Matt Sealey <Matt.Sealey@arm.com>, Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 11:07, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> Hi Matt,
>
> On 13/06/18 16:47, Matt Sealey wrote:
>>
>> Hi Suzuki,
>>
>>>> Why not use =E2=80=9Cunit=E2=80=9D?
>>>>
>>>> I believe we had this discussion years ago about numbering serial port=
s
>>>> and sdhci (i.e. how do you know it=E2=80=99s UART0 or UART1 from just =
the
>>>> address?
>>>> Some SoC=E2=80=99s don=E2=80=99t address sequentially *or* in a forwar=
d direction) - I
>>>> believe it=E2=80=99s not exactly codified in ePAPR, not am I sure wher=
e it may
>>>> be
>>>> otherwise, but it exists.
>>>
>>>
>>> We have different situation here. We need to know *the port number* as
>>> understood by the hardware, so that we can enable *the specific* port f=
or
>>> a given path.
>>
>>
>> For the purposes of abstraction, each port will have the property of
>> having
>> a node which is pointed to by other nodes, and in the case of a true ATB
>> endpoint, no other nodes behind it.
>>
>> It doesn't matter what the HW numbers it as as long as the driver can
>> derive
>> it from whatever you put in the DT. So a funnel (which is ~8 ports muxed
>> into
>> one output):
>>
>>     f1p0: port {
>>        unit =3D <0>;
>>        endpoint =3D <&f1out>;
>>     };
>>     f1p1: port {
>>        unit =3D <4>;
>>        endpoint =3D <&f1out>;
>>     };
>>     f1out: port {
>>        endpoint =3D <&etf1>;
>>     };
>>
>> "unit" here is specific to the driver's understanding of ports within it=
's
>
>
> I may be missing, but is "unit" something that already exists and used by
> DT bindings already ? Or is this something new that we are proposing ?
>
>> own cycle of the graph. For a replicator you can invert the logic - inpu=
t
>> ports don't need a unit, but the two outputs are filtered in CoreSight n=
ot
>
>
> I would prefer to make the new property mandatory for all the ports to av=
oid
> a potential problem in the future.
>
> How do you represent a TMC-ETF which has one input and one output connect=
ion
> ?
> Also what happens if we ever get a component which has m-to-n connections=
 ?
>
>> by leg but by transiting ATB ID in groups of 16 IDs. In that case maybe
>> you would want to describe all 8 possible units on each leg with the fir=
st
>> ID it would filter? Or just list tuples of filter IDs <id, first, last>
>
>
> I am failing to follow the ATB ID group description above. As per the TRM=
,
> e.g, replicator filters the "trace stream" based on the "trace ID", which=
 I
> believe can be programmed via IDFILTER<n> register. So why would we need
> that
> to be part of the DT ?
>
>>
>> Who cares, really, as long as the driver knows what it means.
>>
>> You don't need to namespace every property.
>>
>>> As I mentioned above, we need the hardware numbers to enable the
>>> "specific" port.
>>
>>
>> Okay and how is this not able to be prescribed in a binding for
>> "arm,coresight-funnel"
>> that:
>>
>> "input ports are numbered from 0 to N where N is the maximum input port
>> number. This number is identified with the "unit" property, which direct=
ly
>> corresponds to the bit position in the funnel Ctrl_Reg register, and the
>> bit position multiplied by 3 for each 3-bit priority in the funnel
>> Priority_Ctrl_Reg, with N having a maximum of the defined register
>> bitfield
>> DEVID[PORTCOUNT], minus one, for that component"
>
>
> The description looks over complicated to me at least, even after having
> known
> bit of the programming interface of the components. I would prefer stayin=
g
> closer to the terms used in the TRM ("slave/master" interfaces) and make =
it
> easier for people to write the DT.
>
>>
>> Or a replicator:
>>
>> "output ports are numbered per the CoreSight ATB Replicator specificatio=
n,
>> unit corresponding to the IDFILTERn register controlling ID filters for
>> that leg, with a maximum of the defined register bitfield DEVID[PORTNUM]=
,
>> minus one"
>>
>> One could clarify it, even, with labels for readability ("label"
>> definitely
>> is a well defined if also completely arbitrary property).
>>
>> ..
>>
>>> static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>>> {
>>>           u32 functl;
>>>
>>>           CS_UNLOCK(drvdata->base);
>>>
>>>           functl =3D readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>>>           functl &=3D ~FUNNEL_HOLDTIME_MASK;
>>>           functl |=3D FUNNEL_HOLDTIME;
>>>           functl |=3D (1 << port);
>>>           writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
>>>           writel_relaxed(drvdata->priority, drvdata->base +
>>> FUNNEL_PRICTL);
>>>
>>>           CS_LOCK(drvdata->base);
>>> }
>>>
>>> No we don't need to parse it in both ways, up and down. Btw, the trace
>>> paths are not statically created. They are done at runtime, as configur=
ed
>>> by the user.
>>
>>
>> You do realize this isn't how the hardware works, correct?
>
>
> The "trace paths" mentioned above were indeed the software path, which
> was constructed at runtime. The graph connections are indeed a one time
> parsing at probe time and as you said they don't change. And by configuri=
ng,
> I mean selecting the "source" and the "sink".
>
>>
>> Trace paths are fixed, they may diverge with different configurations, b=
ut
>> the full CoreSight topology (all funnels, replicators and intermediary
>> Components) is entirely unchangeable.
>>
>> The DT should provide the information to provide a reference acyclic
>> directed
>> graph of the entire topology (or entirely reasonably programmable topolo=
gy
>> where
>> at all possible) - if a user wants to trace from ETM_0 then they only
>> have particular paths to particular sinks, for instance ETM_0 and ETF_0
>> may be on their own path, so you cannot just "configure as a user"
>> a path from ETM_1 to ETF_0 since there isn't one.
>
>
>>
>> Walking said graphs with the knowledge that CoreSight specifically
>> disallows
>> loopbacks in ATB topology is basic computer science problem - literally =
a
>> matter of topological sorting. But let's build a graph once and traverse
>> it -
>> don't build the graph partially each time or try and build it to
>> cross-check
>> every time. The paths are wires in the design, lets not fake to the user
>> that there is any configurability in that or try and encode that in the
>> DT.
>
>
> Sorry for the confusion, as explained above, it is indeed a one time pass=
.
>
>>
>>> Coming back to your suggestion of "unit", what does it imply ?
>>
>>
>> Whatever the driver likes. For uart and mmc, it was just a spurious numb=
er
>> but it could be applied as the end of, say, ttyS<N> or mmcblk<N>p3 or us=
ed
>> in any other driver-specific manner. The number you put in is up to you,
>> but the valid numbers would be in the binding for that particular device=
.
>>
>>> Its too generic a term for something as concrete as a port number.
>>
>>
>> Is it?
>>
>> Why would you need a whole other property type to encode a u32 that
>> describes an arbitrary number specific to that hardware device?
>
>
> So, if the suggestion is to use an existing property "unit", I am fine
> with it, if people agree to it.

If we're going to have something sharply different than ACPI I prefer
Rob's idea.

Mathieu

>
>
> Thanks for the comments.
>
> Cheers,
> Suzuki
