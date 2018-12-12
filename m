Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544622996;
	bh=6+Z3IXLJifrp9V+Lf//a+ixZTStvgvOEv8kjSumdBmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z08U/N47UYff46wyUbXfvgw/+Q6BTVFmBA6pkfWbLRxjU1wajkwyrLLEPXGYfR/6F
	 uWTgFg0CWVMlPGjbEAjS0LY5uiuXCYvXyDiL8Mqbh4RD7wyGCRS33L0WG9w5cVdI7m
	 cMnpFhUHnVAqK/xuwmdjgSocAtGawN1egdpuTfhM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeLLN4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeLLN4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:56:34 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E2D20989;
        Wed, 12 Dec 2018 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544622993;
        bh=6+Z3IXLJifrp9V+Lf//a+ixZTStvgvOEv8kjSumdBmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VK+qGnJ8OPb7Z0OYpepcjrKAFSTYgT2Dt0GdfXVEy2qup6c/GdbjlVK06wKEXICzC
         eEp13nNB2XAQLnVPT+xaZkKNd/uSUhjSgVX7SMfvYlmE5R0omLE4LkJNvjh/ndaDBX
         wM0xKgaPHKEufUc5xeKJOKk6U+egr+hNRzm8gQ2o=
Received: by mail-qt1-f169.google.com with SMTP id z16so20528591qtq.4;
        Wed, 12 Dec 2018 05:56:32 -0800 (PST)
X-Gm-Message-State: AA+aEWb3pxV0gQy5O1WDZ6u6L0HKPG3NNgPc4pwy0lBtZZwCACpdV+xL
        siRIlB8CKh2dzmp/HCC6+eizfxZMv2H0kRr9WQ==
X-Google-Smtp-Source: AFSGD/WJ3qdzkE+1kGy3h+q2rsgUTCqM/a8B4NUYv7VoiRSGwevddbvAwCpQs2B8zG7bE2WCX0iSwE4pPOy2LFIW5mg=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr20337689qtf.26.1544622991925;
 Wed, 12 Dec 2018 05:56:31 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com> <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com> <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181212095929.GA13437@amd>
In-Reply-To: <20181212095929.GA13437@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Dec 2018 07:56:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPMzwU9h2RSXeCfNTO5+zs7xTOb9jYcGivj+v_2RkG2A@mail.gmail.com>
Message-ID: <CAL_JsqJPMzwU9h2RSXeCfNTO5+zs7xTOb9jYcGivj+v_2RkG2A@mail.gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color properties
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:59 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > We would also probably need different DT properties for different
> > > types of devices, since e.g. for network case the network interface
> > > name would fit better for the LED name, than the phy name,
> > > and we would need to know what type of device name we're going
> > > to look for.
> > >
> > > Pavel gave following examples:
> > >
> > > eth0:green:link
> > > adsl0:green:link
> > > adsl0:red:error
> > >
> > > So we would have e.g.:
> > >
> > > associated-vl42-device = <&camera1>;
> > > associated-network-device = <&phy1>;
> > > associated-block-device = <&phy1>;
> >
> > Variable property names are kind of a pain to parse.
> >
> > Perhaps when LEDs are associated with a device, we shouldn't care
> > within the context of the LED subsystem what the name is. The
> > association is more important and if you have that exposed, then you
> > don't really need to care what the name is. You still have to deal
> > with a device with more than 1 LED, but that becomes a problem local
> > to that device.
> >
> > What I'm getting at is following a more standard binding pattern of
> > providers and consumers like we have for gpios, clocks, etc. So we'd
> > have something like this:
> >
> > ethernet {
> >   ...
> >   leds = <&green_led>, <&red_led>;
> >   led-names = "link", "err";
> > };
> >
> > We can still support defining LED names as we've done, but we don't
> > have to come up with some elaborate naming convention that covers
> > every single case.
>
> I see that it would be more consistent with how gpios work, but I'm
> afraid this does not fit LEDs properly.
>
> With power LED, you want to be able to say "this is just on". Some
> poeple like heartbeat, and have LED for that. There may be LED for
> "disk activity", meaning activity on any harddrive. And there may be
> activity LED for specific disk.
>
> Only in the last case it would be suitable to have LED reference as a
> child of an device...

Right. For all the other cases, why do you need any link with a
device? What we have today is sufficient and can continue to be
supported. A link to a device is only used if the led is associated
with a particular device.

Rob
