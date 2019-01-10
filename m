Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F407C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4713A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547083396;
	bh=VX4vU9yrQjpbg71YjbHQSMX4frJcJANIwS364qjSlQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZWI593WBdgEXU5cMSCqpeXV9xvPCiI9hMK/zMssoTCsX6KM9vn/tB1+KxlHbHWvCC
	 zMpQkECZcE77J7TA7CE8DpZBTM61eJLd/w/nrTuHjXAO3mcW20mK8Zn2ICbaPFlim0
	 e7MQn/6/tILVnQdXIN+xLpfEfy4/FDxshkmTwXPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfAJBXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfAJBXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:23:15 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09449214C6;
        Thu, 10 Jan 2019 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547083394;
        bh=VX4vU9yrQjpbg71YjbHQSMX4frJcJANIwS364qjSlQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OUZvey7hz5fTdHSbw2xKpBvoOdWL/UvMF4xqT4aErdenRKfhV2zPQnoCAHCXywdsd
         N2zOnnCVylTorrdFuBmJ83PqkXde9mx/POyuaxe89RBhYiDe40AwZHblsoMk0svm2d
         fqiuWHRuB1OJ6PmYh3aro71q9yaXZFzryFGykRfg=
Received: by mail-qt1-f176.google.com with SMTP id e5so10623522qtr.12;
        Wed, 09 Jan 2019 17:23:13 -0800 (PST)
X-Gm-Message-State: AJcUukeDnkTSXI5YHWdcWGR0c/MpfpU0e6axEpB5MwFJ2ElZ5kOIlSqS
        9DdNoPp2d0fgZxyw2vc6XOIYkDOvq7sg9NzSwA==
X-Google-Smtp-Source: ALg8bN4UdApyeXb3PYZCHjm40Wz0siD5fk78oRNQeePtnOQaUea0JwYD4wURMuyELOplajJCRl6qvKm/yDy/iBOF+yU=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr7618986qtd.257.1547083393247;
 Wed, 09 Jan 2019 17:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20181221011752.25627-1-sre@kernel.org> <20181221011752.25627-13-sre@kernel.org>
 <C85D80C9-2B00-4161-B934-9D70E2B173D0@holtmann.org> <20190109181156.yamhult6bpwkhx74@earth.universe>
 <0C9AD246-B511-4E59-888F-47EAB034D4BF@holtmann.org>
In-Reply-To: <0C9AD246-B511-4E59-888F-47EAB034D4BF@holtmann.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Jan 2019 19:23:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzR_rsDithiUpBUzK3STM+O4xA=z9ihpfYSSf1KswpMw@mail.gmail.com>
Message-ID: <CAL_JsqKzR_rsDithiUpBUzK3STM+O4xA=z9ihpfYSSf1KswpMw@mail.gmail.com>
Subject: Re: [PATCH 12/14] media: wl128x-radio: move from TI_ST to hci_ll driver
To:     Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sebastian,
>
> >>> +static int ll_register_fm(struct ll_device *lldev)
> >>> +{
> >>> +   struct device *dev = &lldev->serdev->dev;
> >>> +   int err;
> >>> +
> >>> +   if (!of_device_is_compatible(dev->of_node, "ti,wl1281-st") &&
> >>> +       !of_device_is_compatible(dev->of_node, "ti,wl1283-st") &&
> >>> +       !of_device_is_compatible(dev->of_node, "ti,wl1285-st"))
> >>> +           return -ENODEV;
> >>
> >> do we really want to hardcode this here? Isn't there some HCI
> >> vendor command or some better DT description that we can use to
> >> decide when to register this platform device.
> >
> > I don't know if there is some way to identify the availability
> > based on some HCI vendor command. The public documentation from
> > the WiLink chips is pretty bad.
>
> can we have some boolean property in the DT file then instead of hardcoding this in the driver.

Implying the feature based on the compatible is how this is normally
done for DT. Though typically we'd put the flag in driver match data
rather than code it like this.

However, I'd assume that FM radio depends on an antenna connection (to
the headphone) which a board may or may not have even though the chip
supports it. For that reason, I'm okay with a boolean here.

Rob
