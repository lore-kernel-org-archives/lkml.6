Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D69ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E11020685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhvuFAgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E11020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeGXBkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:40:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46918 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbeGXBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:40:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so420754pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 17:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u1RmNiydSYArOPitjW/Ji7fi6pAOg/sQeriFnOlAtwA=;
        b=fhvuFAgc2tjqn7eYqSQicSrWHXb58V5RKhUG9MaBOSr1x8nDAEtQdinwpaW61w/TfL
         DNXO0HdLvX4QwFdnSCfw35PAx35Qs06qWBUpwZivNxVhgiFqbOZsHDu+uwT/ZHsiIAPD
         1Dm02uyTN0Me92i3fMhVVjm0s1jvXEjhRgu6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u1RmNiydSYArOPitjW/Ji7fi6pAOg/sQeriFnOlAtwA=;
        b=GIoOejV8OkM3556L9Ry1TbxTGecq2TrSafwrjYQtN2KS6TnkynlnEHf3gvd2sW1tYW
         0aaluip1RbydXcUa7DH+y1rFq2Ry2jTIRiktFqOd25ODwl+2rrhFrd6ORxBOEMG+kafZ
         xLcYw0t/YwwkjzeGo1lnHqjOXCY0tbzr1I1f8Kl3a2zwtrGQazs71tCW+phDeTRgJ+Wg
         1bB41ggC0W94jcBZOR65IzlXEDcYsmuL0omJDsJjWOKQYZeVGFn8bsO2yki2S/AFMERX
         ygAujZtZ3PxEZOJJvKFSB1hbENB2yK8FilDuUFc4hxNefObc4p1+0Yy+u+3MdiSFtLwr
         pJ9Q==
X-Gm-Message-State: AOUpUlH4Ja+YapHs/n8iN+TjljdbB0+frboObkpCUimhmYKRImFusvwP
        o+2JaGb6d83Ouq1WgYTnmM9NJQ==
X-Google-Smtp-Source: AAOMgpfSehoMpa4fkuzW5BFP244qbOBNjqdG8KY3XJu1kqT+drN8ExhTOsE8yuM8GqBhSq3bh5LHHw==
X-Received: by 2002:a63:cf10:: with SMTP id j16-v6mr14206234pgg.238.1532392616858;
        Mon, 23 Jul 2018 17:36:56 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z123-v6sm13650624pfz.16.2018.07.23.17.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 17:36:56 -0700 (PDT)
Date:   Mon, 23 Jul 2018 17:35:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180724003551.GF30024@minitux>
References: <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180716215616.GB10734@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716215616.GB10734@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Jul 14:56 PDT 2018, Pavel Machek wrote:

> Hi!
> 
> > >>>echo pattern > trigger
> > >>>echo "1 2 3 4 5 6 7 8" > somewhere
> > >>
> > >>s/somewhere/pattern/
> > >>
> > >>pattern trigger should create "pattern" file similarly how ledtrig-timer
> > >>creates delay_{on|off} files.
> > >>
> > >
> > >I don't think this is the best way. For example, if you want more than one
> > >LED to have the same pattern, then the patterns will not be synchronized
> > >between the LEDs. The same things happens now with many of the existing
> > >triggers. For example, if I have two LEDs side-by-side using the heartbeat
> > >trigger, they may blink at the same time or they may not, which is not
> > >very nice. I think we can make something better.
> 
> Yes, synchronization would be nice -- it is really a must for RGB LEDs
> -- but I believe it is too much to ask from Baolin at the moment.
> 

In my work on the Qualcomm LPG (which I should finish up and resend) I
described the RGB as a single LED, with the color configured by Pavel's
suggested HSV interface. This single LED would be given one pattern.

This works fine for the typical use cases we've seen so far, but would
not be enough to describe transitions between colors.

I believe that a reasonable solution to this would be to extend the
pattern to allow each value in the list to contain data for more than
one channel - something that should be reasonable to add on top of this
suggestion.

> > It is virtually impossible to enforce synchronous blinking for the
> > LEDs driven by different hardware due to:
> > 
> > - different hardware means via which brightness is set (MMIO, I2C, SPI,
> >   PWM and other pulsed fashion based protocols),
> > - the need for deferring brightness setting to a workqueue task to
> >   allow for setting LED brightness from atomic context,
> > - contention on locks
> 
> I disagree here. Yes, it would be hard to synchronize blinking down to
> microseconds, but it would be easy to get synchronization right down
> to miliseconds and humans will not be able to tell the difference.
> 

I like the HSV approach for exposing multi color LEDs and we should be
able to provide a "virtual" LED that groups some number of LEDs into
one, to represent this use case when the hardware doesn't do directly.

In such cases it would work quite weel to use the proposed pattern
interface for setting the pattern of this virtual LED and having it
cascade the pattern into the individual LEDs and then start them at
about the same time...

> > For the LEDs driven by the same chip it would make more sense
> > to allow for synchronization, but it can be achieved on driver
> > level, with help of some subsystem level interface to indicate
> > which LEDs should be synchronized.
> > 
> > However, when we start to pretend that we can synchronize the
> > devices, we must answer how accurate we can be. The accuracy
> > will decrease as blink frequency rises. We'd need to define
> > reliability limit.
> 
> We don't need _that_ ammount of overengineering. We just need to
> synchronize them well enough :-).
> 
> > We've had few attempts of approaching the subject of synchronized
> > blinking but none of them proved to be good enough to be merged.
> 
> I'm sure interested person could do something like that in less than
> two weeks fulltime... It is not rocket science, just a lot of work in
> kernel... 
> 

With the Qualcomm LPG driver I expect the hardware description to group
the channels of a RGB and as such the driver will synchronize the
pattern execution when the output is enabled.

> But patterns are few years overdue and I believe we should not delay
> them any further.
> 

Sorry for not prioritizing reworking this patch based on your suggestion
of describing it as a trigger, I still think this sounds reasonable.

Regards,
Bjorn
