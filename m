Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEF120883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoWm8rxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEF120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGXSsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:48:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38799 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388451AbeGXSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:48:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so1016128pfh.5;
        Tue, 24 Jul 2018 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LYlDSA08wmudPJz7gI0w+jDqqab+dZPvfLtUAFCY4Ls=;
        b=BoWm8rxj20XuslSNFDkjWwnfjjlfoF2AtCpMeZxlUOC6OAOXnmX+fsgdVSJIkmOCZd
         a3ZNOaInVm0KiXHd3ftyYC7GmSM+3dRHFy4aMnD1tvXiYv3iuzTkFpRdc9pYHyaZpwAZ
         pD1BGSWkZdY4LlSCY9/FzbAg4vTORBJdchtX8y91V0/cADbR00jr6EMe7gMHI/gGE2rX
         4eDRBeNgqQQeUa/CZ/Ylz7EsPOsODSwm4V3rMYaWNmmrJC/LlKKPU5/1fJ7p3x0NnevP
         EiFhQgWUGtOr+IFndwiSUWX9Lc6Mj0REDBZgPst/5RNcoWnZoWa/x53+zGDgbMEYBRYa
         h3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LYlDSA08wmudPJz7gI0w+jDqqab+dZPvfLtUAFCY4Ls=;
        b=EPAvzw9stGLu9sypm6qyGdNJcEbqaSp2JRXxgtvYJR4D/BHA8sQY5rMBqzEQPIl2TH
         V3TXQlmnz1JYxlsSuAnwXxIgyqdkMg5CsXYFANYju1+Oi3pxCIrz7RPooTcI2VqEtmZk
         6YJ81SJ9gz7+K1ONVXyBKNZvIGlfmJqdOSeCurMF7cBmrQIEIVpeQwM7LTt3usQ22TO3
         RqnKqjlGD3Btx9v4q0cZ8sYhEBE/0HtfxXIUKKS0DvR+Ry8vvl/hrt3t/x34OLBF0XDp
         NSOd6J91syw6YqMhwxh08jPiwcfFYhz/z8PAPipNjq8KyOCVlqJUQIMlRmBsOqZ6npQN
         TpWA==
X-Gm-Message-State: AOUpUlEcsLaXQc4vwAIM6c3c7EOAZ4a8mAGJE+x+DuZzYs7E5+NrMNIY
        ZunUtP8Zqok5F68/XlW9XMo=
X-Google-Smtp-Source: AAOMgpfOv14hdcX1yqN8lLatwSkBNK9dXSSx3rWA4JWGLMJqcX1Aydj9cEZk2uVXrjZIYPygikee5A==
X-Received: by 2002:aa7:808f:: with SMTP id v15-v6mr18772902pff.38.1532454056470;
        Tue, 24 Jul 2018 10:40:56 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id s73-v6sm21887241pfi.154.2018.07.24.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:40:55 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:40:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Message-ID: <20180724174053.GA61165@dtor-ws>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
 <20180704162158.euiw2v3hyv3hzofn@penguin>
 <20180724150046.7d70786c@dell-desktop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724150046.7d70786c@dell-desktop.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On Tue, Jul 24, 2018 at 03:00:46PM +0200, Mylène Josserand wrote:
> Hello Dmitry,
> 
> On Wed, 4 Jul 2018 16:21:58 +0000
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Mylène,
> > 
> > On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:
> > > Hello,
> > > 
> > > Here is a V6 series to add the driver of the touchscreen Cypress,
> > > TrueTouch Generation 5.
> > > Based on v4.18-rc3.
> > > 
> > > This patch series has already been posted in several iterations:
> > >     - v1: Sent on 2017/05/29
> > >     - v2: Sent on 2017/08/18
> > >     - v3: Sent on 2017/09/27
> > >     - v4: Sent on 2017/12/01
> > >     - v5: Sent on 2017/12/20
> > > 
> > > I did not have any comments the last 4 versions.
> > > And no reviews on my v5 during 6 months. Could I have any updates
> > > or feedback on my series to know why it is not merged (to be able to
> > > correct what is wrong)?  
> > 
> > Sorry, I must have missed the v5, sorry about that.
> > 
> > I probably asked this question before, but just to make sure - I see
> > references to HID in the patch - the device is really not HID
> > compatible? Is there any hope it could be made work with i2c-hid +
> > hid-multitouch?
> > 
> > Thanks.
> > 
> 
> I have checked and, for what I have seen, all the HID descriptor stuff
> is HID compliant. We could definitely use i2c-hid and hid-multitouch
> (there is the "hid-cypress" driver that exists also).
> 
> The only problem is that this touchscreen has two modes: a bootloader
> mode and an application mode (which is the one where we can send
> HID commands). After a power-on-reset, it is always in "bootloader"
> mode so we need to send some commands (called "bootloader commands") to
> switch to application mode.

Is this a documented or observed behavior? In my practice devices (I am
talking in general, not about Cypress) that have proper configuration
loaded and that were brought up with appropriate power up sequence and
timings automatically switch to application mode. They only end up in
bootloader mode when proper power up sequence is not respected and they
are unhappy.

> These commands are not HID-compliant as the
> datasheet indicates:
> 
> "Bootloader commands are not HID-over-I2C compliant."

Any chance you could share the datasheet?

> 
> I think that if the touchscreen would start directly in "application"
> mode, we could directly use i2c-hid and hid-cypress drivers.
> Unfortunately, this is not the case.
> 
> In bootloader mode, the ProductID is 0xc101 and in application mode, it
> is 0xc001 (already available in hid-ids.h:
> USB_DEVICE_ID_CYPRESS_TRUETOUCH but not handled)
> 
> What would be the better approach here?
> Should I add a new product ID to detect the bootloader mode in
> hid-cypress driver and send non-HID commands to switch to
> "application" mode in this driver?
> Anyway, I guess that I will drop this cyttsp5 driver and update the
> existing one, right?

So it still accessible through HID, even when in bootloader mode? OK,
then I guess there are 2 options:

- if device is documented to always start in bootloader mode, you could
  have a small stub driver that switches it into application mode in its
  probe() code. The "bootloader" device will disappear and
  "application" device will appear, and standard driver (hid-multitouch)
  will bind to it.

- if device supposed to come up in application mode unless configuration
  is damaged: I'd recommend doing what we do on Chrome OS and have some
  userspace software that runs on boot (or whenever device is
  discovered) and check if it has the latest firmware/configuration, and
  repair device if needed.

Thanks.

-- 
Dmitry
