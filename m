Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469FD2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665133;
	bh=vIwkwx8kIEQPtC5C2a5MhDBoDEEepTpnNNwERrg9D7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SDpg/KGxjjhcObxiAkfvMstLhEM1d5xohYKVpSBIx2pB+eVVbTa8WR/EmJqvG624Y
	 snQT+SsLz6EYitBMKsCe59CNx0w3fcrwIScoFHDxjInYPGq1ZBwu6PXnX+BJtKHSnK
	 0knb73eIyRyMB7BBe5dIfB3PM4ATFztlXlEN3E8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBTMSv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:18:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43699 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:18:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so39730471ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sa/JSEFisTFu1HSh6mXUgmI35uoeZqcAsVq08MXQDzc=;
        b=XrTcrmX1JLaE/GDH+PkPKj3/wCcbsA0yCH+1ynMqv+DiGgBPl8IYmzvvd6+xV9C0TJ
         2zdKnoyLKATi3acU0Vpd/MeYv6ku35U5jimA+jr5eFoMH28G+NNV3rbgSw51azvJHa8e
         qY0C93duIlPHixpC6eDak221VTnc47Y9Pol7gyI1fzr6N0zS0MStB7ZAuPJbJDz89o1k
         SGpZpozeWpPeI9m0znty8kB4M9Eqp/qpIOt+H4WkVeU5gjMHrAdcPffXgwQmVeVsjd0I
         vTDxMxiFhbWXNwFMcf5xWsidnStZ3KwQyF55WsDGYflCnFJmDj3/VFSs85n5rYmShJiI
         1Rbw==
X-Gm-Message-State: AHQUAuaQhqZLT/IFW5K4jv5i5YQRtMaIqCEU4cYOyzQ8XBYFBMNtt3i0
        tm4VSSfOHznfBFaXacPC4gCWSo8K3eQ8ERZpz5E=
X-Google-Smtp-Source: AHgI3IaRd+Lq7ycbv8yex6Hn23z44dprG7qDBR4yRL7l5P0YE9BJXvxuDVZr08Wf++VhQtD3TEffxd1UlpDN4UbONbU=
X-Received: by 2002:aca:6046:: with SMTP id u67mr714767oib.84.1550665130503;
 Wed, 20 Feb 2019 04:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com> <20190220113506.11009-1-mans@mansr.com>
 <20190220115117.GK4072@localhost> <yw1ximxewte5.fsf@mansr.com>
In-Reply-To: <yw1ximxewte5.fsf@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 13:18:39 +0100
Message-ID: <CAJZ5v0jTxeVrDSA8RMVZ+U7-TvPN72ZcF+J4r66-dhngaWpiAw@mail.gmail.com>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:12 PM Måns Rullgård <mans@mansr.com> wrote:
>
> Johan Hovold <johan@kernel.org> writes:
>
> > On Wed, Feb 20, 2019 at 11:35:06AM +0000, Mans Rullgard wrote:
> >> If the provided fwnode is an OF node, set dev.of_node as well.
> >>
> >> Some drivers are just shims that create extra "glue" devices with the
> >> DT device as parent and have the real driver bind to these.  In these
> >> cases, the glue device needs to get a reference to the original DT node
> >> in order for the main driver to access properties and child nodes.
> >>
> >> For example, the sunxi-musb driver creates such a glue device using
> >> platform_device_register_full().  Consequently, devices attached to
> >> this USB interface don't get associated with DT nodes, if present,
> >> the way they do with EHCI.
> >>
> >> This change will allow sunxi-musb and similar driver to easily
> >> propagate the DT node to child devices as required.
> >
> > Just a drive-by comment, didn't look to closely at this patch, but this
> > all sounds familiar.
> >
> > Note that if both platform devices are bound to drivers you may end up
> > with some resources like pinctrl which are handled automatically by
> > driver core at probe time to be requested twice (and failing the second
> > time).
> >
> > Take a look at 4e75e1d7dac9 ("driver core: add helper to reuse a
> > device-tree node"), which provides a means to avoid this, and
> > 49484abd93ab ("USB: musb: dsps: propagate device-tree node").
>
> Thanks, and ugh.  So we should be setting the of_node_reused flag when
> this is the case.  It's easy for the musb-dsps driver since it doesn't
> use platform_device_register_full() and can do this before the
> device_add() call.  How can we convey that this flag needs to be set?

Through pdevinfo I guess?
