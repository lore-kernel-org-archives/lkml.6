Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C321222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfBOXON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:14:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32994 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfBOXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:14:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so9251242edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 15:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NXHd9VOuu2MZZ+AGLVxXZULKuneb0I4E5pAR79HKTMI=;
        b=NuxaSnOEjiyq/1g9xnUY15wdlvTrgNV6aPIuDC3m5591BlOe0vIZ8EiOF8TpIjru5/
         Lf45IEBSIBiwrBl1FkIDeADZ2t2YwXDtcUgXgx8KDzeolglEKDriP5OEbCKkwSMgncaC
         8kJ55P/gkKxDGt7QGJ9Q8KpxoCFC8AeoIY81FszUquL+hZGG7IhbU98TQS8w4tvJ0UNM
         EbUewJdhsmR8S0oYmlb4HuHcZuV1magiiKriv7mesbrvlzDeDs2lWUvP+FPju6b18s9s
         y1/sdwzH70MqdheFf5b8lM7RvrjIldqSwQ1Yr5Rl9zuYu2yTCm4q1t5ZvgSncwAiGsSg
         z0qA==
X-Gm-Message-State: AHQUAuacOi3j/YbGTBCLZ13frfhPiEZ4GIfYLPFsXtjCEZST2Flm6JPI
        dSf14wSyvjwSNzNLpYaGo5JFrQ==
X-Google-Smtp-Source: AHgI3IYzY5NnYSq28kf+TBLm7FH0cocwKtPlEqV/WH+r7qRkjiWHDFgkL3DjZ8Ut47fvF5bm3zOtYw==
X-Received: by 2002:a05:6402:13cd:: with SMTP id a13mr9522782edx.152.1550272451170;
        Fri, 15 Feb 2019 15:14:11 -0800 (PST)
Received: from localhost.localdomain ([2001:678:814:68:8573:4f61:f765:5d7e])
        by smtp.gmail.com with ESMTPSA id r25sm1791301edq.37.2019.02.15.15.14.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 15:14:10 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
Date:   Sat, 16 Feb 2019 00:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/15/19 11:31 PM, Jacek Anaszewski wrote:
> On 2/15/19 11:26 PM, Hans de Goede wrote:

<snip>

>> I think that should work fine, which means that we can use the timer and
>> pattern trigger support for the blinking and breathing modes.
>>
>> That still leaves the switching between user and hw-control modes,
>> as discussed the hw-controlled mode could be modelled as a new "hardware"
>> trigger, but then we cannot choose between on/blink/breathing when
>> in hw-controlled mode. As Pavel mentioned, that would require some
>> sort of composed trigger, where we have both the hardware and
>> timer triggers active for example.
>>
>> I think it might be easier to just allow turning on/off the hardware
>> control mode through a special "hardware_control" sysfs attribute and
>> then use the existing timer and pattern triggers for blinking / breathing.
> 
> Pattern trigger exposes pattern file by default and hw_pattern if
> pattern_set/get ops are provided. Writing them enables software and
> hardware pattern respectively.

This is not about software vs hardware pattern.

There are 2 *orthogonal*, separate problems/challenges with this LED controller:

1) It has hardware blinking and breathing, as discussed this can be
controlled through the timer and pattern triggers, so this problem
is solved.

2) It has 2 operating modes:

a) Automatic/hardware controlled, in this mode the LED is turned
off or on (where on can be continues on, blinking or breathing)
by the hardware itself, when in this mode we / userspace is not
in control of the LED

b) Manual/user controlled mode, in this mode we / userspace can
control of the LED.

Currently there is no API in the ledclass to switch a LED from
automatic controlled to user controlled and back, This is what
the proposed hardware trigger was for, to switch to automatic
mode. A problem with this is that we still want to be able
to chose between continues on, blinking or breathing (when on),
configure the max brightness, etc.

Since there cannot be more then 1 trigger active, with the
hardware trigger solution we cannot say we want automatic
control (hardware trigger) and blinking when the automatic
mode says the LED should be on (timer trigger) as that
would mean having 2 triggers active with the hardware
trigger solution.

As such I think the switch between automatic and manual
control would be best exported through a special "hardware_control"
sysfs attribute and then use the existing timer and pattern
triggers for blinking / breathing.

Regards,

Hans
