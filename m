Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C602C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D972B26CAC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0dy5hTmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D972B26CAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeFZPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeFZPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:03:54 -0400
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 844E226CC6;
        Tue, 26 Jun 2018 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530025433;
        bh=54OLBR43CgMIHqaa1Y5x4+gzttcLVTIx8RD1cZhJ+Pw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0dy5hTmE4PB/CBTppgHNH0Iz8dZoYMACnenjZE0h4iRPeMqtE3X4J+eUo3zDb0HHB
         KHwhl0pRzwT6joX6xQ3aKudKWK2RTt0Dx9bxwwn8vGLWz5J9U4Qor0J3X5rU772uZE
         9A8xonMdOVJwjV6VW488NX1jHeitxhYb1NWWm+UM=
Received: by mail-it0-f54.google.com with SMTP id v83-v6so2787025itc.3;
        Tue, 26 Jun 2018 08:03:53 -0700 (PDT)
X-Gm-Message-State: APt69E1wjnB2jxzjoq6ijXFskw1umTlX9IdCSxeBHBovQrcBCEF+yTG7
        q8y1U+K5KlGYPSz/tGS9OGqgyQTrKJXbkmVOFg==
X-Google-Smtp-Source: AAOMgpemXPgg0ELGMi4ewqhaYtBjUkt7eKP8a9dF2Plh/L9KxxcAGGQeMaas93LBuEQ93fldvXKf025izOlQyYc07uU=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr1653068itc.19.1530025432814;
 Tue, 26 Jun 2018 08:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180624124155.82412-1-tmaimon77@gmail.com> <20180624124155.82412-2-tmaimon77@gmail.com>
 <20180625171417.GA16379@rob-hp-laptop> <CAP6Zq1h-M6YDS67pkgHy-GMmiVk1D-RScLgDyG65JQM+S35rEQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1h-M6YDS67pkgHy-GMmiVk1D-RScLgDyG65JQM+S35rEQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Jun 2018 09:03:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCYPLw+jqx+7Cy=cXFFb-CNp=Ezew7FNT=cfAndqWe5A@mail.gmail.com>
Message-ID: <CAL_JsqJCYPLw+jqx+7Cy=cXFFb-CNp=Ezew7FNT=cfAndqWe5A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-binding: hwmon: Add NPCM7xx PWM and Fan
 controller documentation
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 4:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Rob,
>
>
> On 25 June 2018 at 20:14, Rob Herring <robh@kernel.org> wrote:
>>
>> On Sun, Jun 24, 2018 at 03:41:54PM +0300, Tomer Maimon wrote:
>> > Added device tree binding documentation for Nuvoton BMC
>> > NPCM7xx Pulse Width Modulation (PWM)  and Fan tach controller.
>> > The PWM controller can support upto 8 PWM output ports.
>> > The Fan tach controller can support upto 16 tachometer inputs.
>> >
>> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> > ---
>> >  .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  | 84 ++++++++++++++++++++++
>> >  1 file changed, 84 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
>> > new file mode 100644
>> > index 000000000000..a9eacda34f92
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
>> > @@ -0,0 +1,84 @@
>> > +Nuvoton NPCM7xx PWM and Fan Tacho controller device driver
>>
>> Bindings are for h/w, not drivers.
>>
>> > +
>> > +The NPCM7xx has two identical Pulse-width modulation (PWM) controller modules,
>> > +Each PWM module has four PWM controller outputs, Totally 8 PWM controller outputs.
>> > +
>> > +The NPCM7xx has eight identical Fan tachometer controller modules,
>> > +Each Fan module has two Fan controller inputs, Totally 16 Fan controller inputs.
>>
>> Have you looked at other fan ctrlr bindings?f This looks like similar
>> h/w to ASpeed. Really, I'd like to see a common doc that describes the
>
>
> We do not have the same H/W as Aspeed, I believe in the near future we will need to add
> more DT properties that will used only in the NPCM7xx module.

I didn't say it was the same. Both are multi-channel PWMs with tach
inputs. Presumably, they can attach to the same types of fans as there
are only a limited number of types of fans and none of them are
specific to any fan controller.

>> structure and common properties.
>
>
> what do you mean by common structure and common properties?

When we have multiple bindings for the same class of device/hw, we
define all the common parts in a common binding doc. This often
doesn't happen at first, so we end up with a variety of bindings until
we see some commonality.

In this case, for structure, having sub-nodes for fans. As fans are
not specific to the controllers, their node should not be defined by
the controller binding. It's also how you describe the fan type,
number of fans, the PWM connections, the tach connections, etc.

Rob
