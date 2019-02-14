Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291212229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550152870;
	bh=6dtKPkH/uDQESpU6qBBIquRox/r60tN5RWiDWKr0Ogg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ac7LyH51JExDgFvoKmDRas+p1QWva5Z+UjUEHsBuNiBchSrxSsYKLtNZNqJLuACjd
	 qx9E1jyi4kDSmqWiR9uU2bvO0DZM4yTmmPFdR5Qv3FXkW7hQfvursZgyuxW8lb8roe
	 WbNJ7QTVIefiJrNO5voP9ZJ17s65uvkYzfiW2/a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439114AbfBNOBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439061AbfBNOBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:01:07 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D336F222DE;
        Thu, 14 Feb 2019 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550152866;
        bh=6dtKPkH/uDQESpU6qBBIquRox/r60tN5RWiDWKr0Ogg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Svz+Gibv/h5Sr+AabfgVnLWAxlyrKKkIVa++AshGEKKYQ0VuXCZ8+SZnmnMTiPHr/
         BgE/Io/CHxYT4O5mTgdqcT27EMzouU1kAtrpoSEFTpg1iVNr4+YP9b4EidM4d4S/9A
         exT4XYjrP+sGSqsoFLd4+uC3LIbvvJIv+ixAVXls=
Received: by mail-qt1-f180.google.com with SMTP id y4so6874664qtc.10;
        Thu, 14 Feb 2019 06:01:05 -0800 (PST)
X-Gm-Message-State: AHQUAuahuUWUzKxRY8+dg17BilfbhL2tralBch5j8RJ+QY9OkoRN8b3C
        UnZCAs66eZyKWCcgKnbBk/3+ajzaczPABy2idQ==
X-Google-Smtp-Source: AHgI3Iaaqdlrx0Mq7Cgv+sk9GDZOWGzIv0C0Oi0G2BOUbsFvPtS4lHXeytYdityfg26lG2fHtIMm5sEQ+RzXLTkWGX4=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr3215870qtk.26.1550152864928;
 Thu, 14 Feb 2019 06:01:04 -0800 (PST)
MIME-Version: 1.0
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-2-git-send-email-pawell@cadence.com> <20190213224841.GA9319@bogus>
 <BYAPR07MB4709EA63F1374EA24E23C186DD670@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709EA63F1374EA24E23C186DD670@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Feb 2019 08:00:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+wqtY=B1jKKxjFxnBMy_kiN9=MhHdMp=bEPa9wFo1NqQ@mail.gmail.com>
Message-ID: <CAL_Jsq+wqtY=B1jKKxjFxnBMy_kiN9=MhHdMp=bEPa9wFo1NqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:08 AM Pawel Laszczak <pawell@cadence.com> wrote:
>
> Hi Rob,
> >On Thu, Jan 31, 2019 at 11:52:28AM +0000, Pawel Laszczak wrote:
> >> This patch aim at documenting USB related dt-bindings for the
> >> Cadence USBSS-DRD controller.
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  .../devicetree/bindings/usb/cdns-usb3.txt     | 33 +++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> >> new file mode 100644
> >> index 000000000000..6dc38be77f5c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> >> @@ -0,0 +1,33 @@
> >> +Binding for the Cadence USBSS-DRD controller
> >> +
> >> +Required properties:
> >> +  - reg: Physical base address and size of the controller's register areas.
> >> +     Controller has 3 different regions:
> >> +     region 1 - HOST registers area
> >> +     region 2 - DEVICE registers area
> >> +     region 3 - OTG/DRD registers area
> >> +  - reg-names - register memory area names:
> >> +    "xhci" - for HOST registers space
> >> +    "dev" - for DEVICE registers space
> >> +    "otg" - for OTG/DRD registers space
> >> +  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
> >> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> >> +            Driver supports only single interrupt line.
> >
> >Driver supports or h/w only has 1 interrupt?
>
> h/w internally has 3 separate interrupt line, but in my testing board
> they are ored. So physically driver sees only one h/w interrupt line and
> assumes that h/w has single common interrupt line.

If it is possible for others to have 3 separate lines then you should
have 3. Just repeat the connection 3 times. Or the binding can support
1 or 3 interrupts based on the h/w. Either way it's not about what the
driver supports, but what the h/w looks like.

> >> +                This single interrupt is shared between Device,
> >> +            host and OTG/DRD part of driver.
> >> +
> >> +Optional properties:
> >> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> >> +                   "full-speed"; refer to usb/generic.txt
> >> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> >> + - phys: reference to the USB PHY
> >> +
> >> +Example:
> >> +    usb@f3000000 {
> >> +            compatible = "cdns,usb3";
> >
> >Doesn't match above.
> Right, should be:
>                 Compatible = " cdns,usb3-1.0.0", "cdns,usb3-1.0.1";

No, that doesn't match either. Above you said "or".

Rob
