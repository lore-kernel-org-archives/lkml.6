Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeCTLWY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:22:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44904 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbeCTLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:22:19 -0400
X-Google-Smtp-Source: AG47ELv2PFbc/TQ9VIg6SvhpZ4S8+vDNIQ9OErQEHHwjQ0VLYQeJz4GzKcs7HMlLM1Red5UDl729AA==
Date: Tue, 20 Mar 2018 19:22:12 +0800
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v3 0/4] backlight: pwm_bl: support linear interpolation
 and brightness to human eye
Message-ID: <20180320112212.2mwthxug3pu7uqgg@holly.lan>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <CAFqH_52bXq76TnQLfnD0mohgr0d5iAcrHBcPefwnRB8gdbaYFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_52bXq76TnQLfnD0mohgr0d5iAcrHBcPefwnRB8gdbaYFQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 05:04:31PM +0100, Enric Balletbo Serra wrote:
> Hi Daniel,
> 
> Gentle ping for this series, there is any possibility you have a
> chance to review it? Let me know if you want I change something.

I haven't got it in my TODO backlog... which means either I mistakenly
deleted it when it went through originally or that I deliberately deleted
it because I thought a v4 was coming along soon.

I could go diving through the archives if I need to but were there other
pending changes for this patchset?


Daniel.


> 
> Thanks,
>   Enric
> 
> 2018-02-08 12:30 GMT+01:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
> > Dear all,
> >
> > This series is a third patchset integrating the requested changes.
> >
> > The first and second patch what tries to solve is the problem of
> > granularity for high resolution PWMs. The idea is simple interpolate
> > between 2 brightness values so we can have a high PWM duty cycle (a
> > 16 bits PWM is up to 65535 possible steps) without having to list
> > out every possible value in the dts. I think that this patch is
> > required to not break backward compability, to be more flexible and
> > also extend the functionality to be able to use high resolution PWM
> > with enough steps to have a good UI experience in userspace.
> >
> > The thirth and fourth patch is a bit more ambicious, the idea is let
> > decide the driver the brightness-levels required in function of the PWM
> > resolution. To do this create a brightness-levels table filled with the
> > CIE 1931 algorithm values to convert brightness to PWM duty cycle.
> >
> > More detailed info is available in the commit message of every patch.
> >
> > Both functionalities were tested on a Samsung Chromebook Plus (that has
> > a 16 bits PWM) and a SL50 device (with a 8 bits PWM)
> >
> > Waiting for your feedback.
> >
> > Best regards,
> >
> > Enric Balletbo i Serra (4):
> >   backlight: pwm_bl: linear interpolation between brightness-levels
> >   dt-bindings: pwm-backlight: add a num-interpolation-steps property.
> >   backlight: pwm_bl: compute brightness of LED linearly to human eye.
> >   dt-bindings: pwm-backlight: move brightness-levels to optional.
> >
> >  .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
> >  drivers/video/backlight/pwm_bl.c                   | 232 +++++++++++++++++++--
> >  2 files changed, 246 insertions(+), 20 deletions(-)
> >
> > --
> > 2.15.1
> >
