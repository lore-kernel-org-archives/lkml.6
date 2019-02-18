Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7901F2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbXM3A4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfBRPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:07:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38740 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfBRPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:07:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so28777707otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c0+9BRQSaJeGuEI9z7T5ViMw65UbeMYnXvO/DxPCFU8=;
        b=vbXM3A4SoYiRkOFBdH5d20qKUMEoUpcyKEQ47uQJXMKUeK0DLybr5ZDx51AE1z9WuT
         /3keh2d2FFWrQO9y3bzZ1bEJQzpEHkwwYMQOl4oVOI+gMgRRfpmYf4rvxIsqQHbbyl0t
         Qp8HBZ5HsVpki/vN8BrUSMm48zEtle5eXziZWLRyFc+7CpcxwuDQCZHjOclpBQZE6+HT
         BzhqfpJuoinej7qdyN3o+8jZwDAa1a4B9PH4h1rbkTKZhKAoHlscFi9A7dIOHjw9Hfdu
         g1AMNe+fPaNwwyiuuIBHXqkd+9NaUo8IY9MM8hMCPqqHKVvy69VtYEsZ/MAkgxNlTtl1
         BErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c0+9BRQSaJeGuEI9z7T5ViMw65UbeMYnXvO/DxPCFU8=;
        b=ibHd2wIrub0Ej0Be3G06gqSHmqL43gSiJNEY6s+dZ3RAeGqNIgOFt4471TnLx+UHCh
         31aH944B57sOJPC0a7g6Y3/R+iFJzpfTpdrIuWuXAiVEAvtLpENwVvWF+3Kz4hn999tn
         3GQ2bECQEb1Ekzhd7nQQU3GbWaZQ7gyTy1hwbgS1/QJ5lMtvv8HLEDgCUNdY+RbU/6NE
         ob71gnd5f2HEnBccBLH5iR5N5ob4M762fOhiyuGu0eD4valIhiMhRbEOAC5uFwGI0qI3
         2bzDbwlddI1R60xUyYrkjWtyzyAjAFjDimQOfo1r73INYV+WjUlPfetGBlfMh45UKYGp
         xKuw==
X-Gm-Message-State: AHQUAuYk7X6wmxTK8mzz3Gy+RkDr0QMOofupUZk/0RjfH66CslyKzR5L
        1jb7/NLspyZJxqfBgvUZjObl1p4yY5skFT/l1I8=
X-Google-Smtp-Source: AHgI3IYwxZsQkbU5178u2m3CTLOkmYuy7mn0baWhfP4vKRbdxZspt9wD2iwfAt2nuq9JgzDxyzFmt/m53C+w3uO4vkI=
X-Received: by 2002:a9d:5501:: with SMTP id l1mr14448659oth.143.1550502455593;
 Mon, 18 Feb 2019 07:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20190210203649.21691-1-jekhor@gmail.com> <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com> <20190215063250.GB30250@jeknote.loshitsa1.net>
 <20190217215242.GA12656@jeknote.loshitsa1.net> <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
In-Reply-To: <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
From:   Yauhen Kharuzhy <jekhor@gmail.com>
Date:   Mon, 18 Feb 2019 18:07:23 +0300
Message-ID: <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 18 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 12:24, Hans =
de Goede <hdegoede@redhat.com>:
>
> Hi,
>
> On 17-02-19 22:52, Yauhen Kharuzhy wrote:
> > On Fri, Feb 15, 2019 at 09:32:50AM +0300, Yauhen Kharuzhy wrote:
> >> On Thu, Feb 14, 2019 at 05:31:48PM +0100, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> >>>> In some configuration external charge "#charge enable" signal is
> >>>> connected to PMIC. Enable it at device probing to allow charging.
> >>>>
> >>>> Tested at Lenovo Yoga Book (YB1-X91L).
> >>>>
> >>>> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> >>>> ---
> >>>>    drivers/extcon/extcon-intel-cht-wc.c | 33 +++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 33 insertions(+)
> >>>>
> >>>> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/e=
xtcon-intel-cht-wc.c
> >>>> index 4f6ba249bc30..00cb3084955e 100644
> >>>> --- a/drivers/extcon/extcon-intel-cht-wc.c
> >>>> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> >>>> @@ -57,6 +57,11 @@
> >>>>    #define CHT_WC_USBSRC_TYPE_OTHER        8
> >>>>    #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY   9
> >>>> +#define CHT_WC_CHGDISCTRL         0x5e2f
> >>>> +#define CHT_WC_CHGDISCTRL_CCSM_DIS        0x11
> >>>> +#define CHT_WC_CHGDISCTRL_CCSM_EN 0x00
> >>>
> >>> Hmm, the enable mask here does not match the enable mask from:
> >>>
> >>> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-=
m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch
> >>>
> >>> Which has:
> >>>
> >>> #define CHGDISFN_EN_CCSM_VAL           0x50
> >>> #define CHGDISFN_DIS_CCSM_VAL          0x11
> >>> #define CHGDISFN_CCSM_MASK             0x51
> >>>
> >>> Where as on my hardware, the PMIC comes up with 0x50
> >>> in the 0x5e2f register, exactly matching the values
> >>> from that patch.
> >>>
> >>> Why did you change this value ?
> >>
> >> Good question... I found this values in Lenovo's sources and use them
> >> 'as is':
> >> https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab=
794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/intel_pmic_ccsm.h#L255
> >>
> >> I don't remember if charger worked with Intel's value, I need to
> >> re-check this.
> >
> > As we know now, value 0x50 meaning is:
> > - HW mode
> > - regular output type
> > - low level at output
> >
> > 0x00 meaning is:
> > - SW mode
> > - open-drain output
> > - low level at output
> >
> > I don't know what exactly "HW/SW mode" means but I suppose that this pi=
n
> > can be controlled by PMIC internal charge state algorithm (if it is
> > enabled) or by software (extcon driver).
> >
> > So, if we set 0x50 value and disable HW-controlled charging entirely (a=
s
> > extcon driver does), we don't set 'charger enable' signal to low as
> > expected. Its exactly state is unknown, but I checked =E2=80=93 it is H=
IGH.
> > Charger doesn't start charging with this value and starts with 0x00.
> >
> > 0x0b register of 0x6b device on bus 7 =E2=80=93 it is the status regist=
er of BQ25892
> > charger, where bits 3,4 describe charging state, 10b means fast chargin=
g,
> > 00b means not charging.
> >
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x00
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x16
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x01
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x06
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x10
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x16
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x11
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x06
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x50
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x06
> > root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x51
> > root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> > 0x06
> >
> >
> > After reading of Intel's and Lenovo's sources i understood that Intel's
> > meaning of CHGDISFN_EN_CCSM_VAL is 'enable HW control of charging' and
> > Lenovo's is 'enable charging'. Lenovo set this value immediately after
> > probing and after resume, Intel =E2=80=93 only after resume. HW-control=
led
> > charging is disabled entirely at probing, so I don't know how Intel's
> > driver enables charging.
> >
> > So, I propose:
> >
> > 1) save initial value of CHGDIS register for restoring it at driver
> > remove (because the extcon-intel-cht-wc driver restores HW control in
> > cht_wc_extcon_remove()).
> > 2) at driver start, enable SW control of CHGDIS and set its value to 0.
> > 3) at driver removing, restore the saved state.
>
> This sounds good to me, note I believe the extcon code should not touch
> bit 4 (open-drain,vs regular), but since we disable the charger state-mac=
hine
> we should obviously then switch the pin to sw mode and drive the pin low
> so that the charger still works.


Agree.

>
>
> I believe that on the GPD win / GPD pocket the chgdis pin of the PMIC
> is not connected to the charger, since writing different values to reg
> 5e2f has no effect there.
>
> I do wonder how this interacts with inserting an otg-host cable into
> the micro-usb, I mean a cable like this:
>
> https://alexnld.com/wp-content/uploads/2013/11/S-UDC-103.jpg
>
> A cable like this will short the id-pin to ground and at this point
> we should disable the charger and enable a 5V boost converter to
> supply 5V to the device connected to the USB-A connector.
>
> On the GPD win / GPD pocket this is controlled through the Type-C
> framework and the V5 boost converter is actually part of the
> charger-IC, so charging gets disabled automatically when we tell
> the charger-IC to do enable its 5V boost converter.
>
> Do you already have an idea how to deal with this, it might be good
> to have at least an idea how we want to handle 5V boost before we
> merge the patch to control the CHGDIS pin, since we may need to
> disable the charger when the id-pin is connected to GND, so that
> the charger does not try to charge from the output of the 5V boost
> converter, which happens when an external 5v boost converter is used.

 I implemented this in external charger driver by sending extcon
notifications to it.
The BQ25892 charger provides boost converter for OTG and doesn't try to cha=
rge
from its own VBUS output. But additional disabling of charging via CHGDIS p=
in
shouldn't break anything.

> I also wonder if you've considered just disabling the extcon driver
> for the PMIC leaving it in automatic mode. Unlike the GPD win / pocket
> with their Type-C connector, your device seems to actually be using
> the PMIC as it was designed, so the automatic mode might just work
> and not touching the PMIC at all might be best.

Hm. We need to detect charger type (which can be kind of ACA) and set charg=
ing
limit properly, control OTG boost converter of the charger, request
hi-voltage charging etc.
I am not sure that this is possible without of software intervention.
Mixing of software
events handling with hardware charging control will be a source of
errors and instability.
So, no, I didn't think about HW-controlled charging when Linux is
running. But this may
be subject of future investigation.

> > Q: In theory, enabling of 'charge enable' output without of properly
> > configuration of external charger can cause some problems (USB overload=
,
> > battery overcurrent etc.). I think that there are no such stupidly
> > designed devices exist but we cannot be sure. What should we do with th=
is?
>
> This should not be a problem, the input-current-limit of the charger
> will already be setup by the firmware at boot and if a charger gets
> plugged in later then the input-current-limit will reset to 500mA.
>
> Likewise the max charging current for the battery should already
> be configured properly by the firmware (this must be the case since
> the device will also charge while off) and we don't even know what
> the max charging current for the battery is, so we just have to rely
> on the firmware/BIOS here.

In the Lenovo Yoga Book the firmware seems to set safe input current limit
only (500 mA). Fast charging can be enabled by software and exactly value
of limits for this are known from Lenovo's sources only...


--=20
Yauhen Kharuzhy
