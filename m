Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8516721924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeSw6/Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbfBOH1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:27:14 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33295 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBOH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:27:14 -0500
Received: by mail-yb1-f194.google.com with SMTP id w2so3456044ybi.0;
        Thu, 14 Feb 2019 23:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+/HJY0CvjgV5qxMAw4VOcOeAjbbA1USZ3ro72VHMvvk=;
        b=jeSw6/MqB9kkIZGtp/sk4TjgSt095asqpTEbAYku05OkdM4mCZSCyBPSonpi+SZux7
         0fru/IhmuBjEM7QSVFnSVXimanlKGxgrCoMt0UDcjHruUjnH7BeaRsssXrI9dukiXeyo
         l5rTEiq1MEHs8GNwnE8QTEiqTq9P+ruWB8LBUOEr0X2lZ1O2cCqPfh8/65bKxTuu5SsE
         E58g+q9kwyY3/15q+jq9OY5XcmQf3sTdWIJKJe8P+6rxPnmRcD2XWyynvTDRTHbOmhXg
         h+aa7OrN+OaqOUZ5zLqgQiZaCG71zdG0ubBaMiVbGeXKIsDc5a36LLUMGGtFezFw4Ioc
         Dp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+/HJY0CvjgV5qxMAw4VOcOeAjbbA1USZ3ro72VHMvvk=;
        b=QIh8goWvL9s5FvEertMrpB+T0slVfu4F0/ZRQ8Zlx8BhrUgHj1DK34cyCyPLKO/jCi
         skY5Re5TSoTRl+gwrrkhXPGMMGylCkqkjCjDClAv5vn2SkMluEFFavNFqMWOb096sSBo
         cZY01V81kDTr5Nx64eIClUCjBw9sXCui2cN/vs717qGwGcu5+5B88AH9deXOGTQxng3s
         a1Q71yThqf6tTxACf5p6t/T+JUSKyHAV5yFcbRlqoMMEOrkhnKfQVHXgPmIK4EgfS0BM
         GdQsvb9+0AB/mGjW9WLPWr7jr8Jl/+HGhK3uawAMe5XV7vOa4+iGOXUyNRpBRod1EGnm
         0ImQ==
X-Gm-Message-State: AHQUAubuhjzL0tWWsXFhWPh1esQ+7ltKmCZcmg0Fv3yFiMO3532IHotg
        27MQ+/940nisEus0HriM6zw=
X-Google-Smtp-Source: AHgI3IZSmB29ag6WgJw/EIYm0KTYaZnbjUIazshS63GLVeMwXYcW28MXJ8xwlI5JieqMN9xQoyU5cg==
X-Received: by 2002:a5b:352:: with SMTP id q18mr6759465ybp.371.1550215633003;
        Thu, 14 Feb 2019 23:27:13 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.99])
        by smtp.gmail.com with ESMTPSA id 207sm3176889ywj.92.2019.02.14.23.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 23:27:12 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guXtt-0002h0-Nk; Fri, 15 Feb 2019 10:27:09 +0300
Date:   Fri, 15 Feb 2019 10:27:09 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190215072709.GD30250@jeknote.loshitsa1.net>
References: <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
 <20190214230307.GA17358@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214230307.GA17358@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:03:07AM +0100, Pavel Machek wrote:
> Hi!
> 
> > >>>I suggest that we deal with this special case by adding 3 custom
> > >>>sysfs attributes:
> > >>>
> > >>>1) "mode" which when read, prints, e.g. :
> > >>>manual [on-when-charging]
> > >>
> > >>While this allows _user on console_ to control everything using echo,
> > >>it is not suitable for applications trying to control LEDs.
> > >>
> > >>As there's nothing special about the case here, I believe we should
> > >>have generic solution here.
> > >>
> > >>My preffered solution would be "hardware" trigger that leaves the LED
> > >>in hardware control.
> > >
> > >As you explained in the parts which I snipped, there are many
> > >devices which have a similar choice for a LED being under hw or
> > >user control. I can see how this looks like a trigger and how we
> > >could use the trigger API for this.
> > >
> > >I believe though, that if we implement a "virtual" (for lack of
> > >a better word) trigger for this, that this should be done in the
> > >LED core. I can envision this working like this:
> > >
> > >1) Add a:
> > >
> > >hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
> > 
> > Please note that we have support for hw patterns in the pattern trigger.
> > (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
> > breathing pattern).
> > We have also support for hw blinking in timer trigger via blink_set op.
> > 
> > In addition to that there is brightness_hw_changed sysfs attribute
> > with led_classdev_notify_brightness_hw_changed() LED API.
> > 
> > Couldn't they be used in concert to support the specific features
> > of the device in question?
> 
> I believe main issue here is this:
> 
> Hardware can automatically control the LED according to the charging
> status, or it can be used as normal software-controlled LED.
> 
> I believe we should use trigger to select if hardware controls it or
> not (and then add driver-specific files to describe the
> details). Other proposal is in the mail thread, too.

But there are two kinds of 'hardware control' here in discussion:
1:
	a) PMIC switching LED off/on/breathing/blinking reflected the charging
	state (charger is controlled by PMIC entirely without of
	software intervention) – 'hw controlled' mode
	b) Software controls when LED is on/off/breathing/blinking but
	patterns are generated by PMIC – 'sw controlled' mode.

2:
	a) parameters of lighting (continuous/blinking/breathing) are
	set in the PMIC and the PMIC generates patterns
	b) blinking/breathing patterns are generated by the software
	entirely.

It seems that we sometimes confuse this two kinds of hw control definitions
in the discussion.


The simple use case question: with this hardware and existing LED class
API, what user/app should to do to make LED breathing with hw-generated
pattern?

As I see, user should activate 'pattern' trigger and write to its hw_pattern attribute...
hm... big pattern which describes every step of breathing? Some
simplified pattern which should be interpreted as 'enable the breathing
an set its frequency' by driver? Which level of simplification will be
suitable? Which criteria of pattern rejection should be?

-- 
Yauhen Kharuzhy
