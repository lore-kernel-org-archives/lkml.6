Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD20C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE432183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659875;
	bh=H3ih4u64p6eeTZse0gp3dV4wWBRVWWWBp2lnFHO4x6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jvOG7qqS/8zzc8reqQdgSiGFgT2bqcRzkitiki8yyZDZ3aNAd5qpS+awLV/MfCcgu
	 x0nJ4u+T7bKiK2RJYuZX2aun3gNdpin3FM+RdsXS8gV9loDg8ZTCwlKDXyaPycYyj9
	 vbD1/cjtzeaA/IRON1S9YpvRQ2THt4ywMH10Zs4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBTKvO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:51:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38655 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:51:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so39417833otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qJs1KPGFFnjF6jdTus+S8DJENlhbz+RYILWqzFDWB2c=;
        b=eREINTYhWlwyoS95ltN8wWSU0h1fobSTM4puYkZgW+9Wqy7heubk0QbPYUqIWgSiXL
         Ex/R5V4viT0uRJ5gNjNMXGATBGjuxrj6wen51o/bYGML00HBCzNndVCIqjr+oebjiblX
         gu2MNIMOraWm0f9zjqh/w1pc/CFNHNWGkKkN8zJeeK/r3K3p9MV0o+ebrZq534h+osAV
         JM9UTDqI7RtYQyXq29sSsb4cP/v4H0cE0jriNPDHdnlERYS2RfTX9fSkxIEbNeu5qlXs
         4ETHIs4BLZKKoZnWAmYabekm60PBtszk5WI7FhCbAgCTKVnJz4BD2S3e832AK+IkeGuc
         08cg==
X-Gm-Message-State: AHQUAuYZVHuZFz/5arxS/V0yS0aBjP35gxxvogWbAn57eOQ2v2s6MPen
        MVxvKFLxRKFmM/n7tSvMrW4rU4z4ft6fwm0j9ab4gQ==
X-Google-Smtp-Source: AHgI3IYQFWDrbeny2NpGi2sR6jrlSXjTGHGuSgww0VD5xXIzMuo3lGROhrBWqy7kx6TNolap7KZ6dmtknKVhInIzUEM=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr7641414otn.139.1550659872950;
 Wed, 20 Feb 2019 02:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com> <CAJZ5v0iZHfU=mE3JGcKqbswGGert7CvpKPkVE1s+-X1zXKJiEw@mail.gmail.com>
 <yw1xk1hxxss8.fsf@mansr.com> <CAJZ5v0gG5Rau71YrmUL8V7EpZjHQNOzLpEJHCJjXdgaDm4TrSw@mail.gmail.com>
 <yw1x7eduyc6p.fsf@mansr.com>
In-Reply-To: <yw1x7eduyc6p.fsf@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 11:51:01 +0100
Message-ID: <CAJZ5v0gMD27Wa3+iuwSoZGpStsVgShWP=SkY69EjrDy2SrftYA@mail.gmail.com>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:41 AM Måns Rullgård <mans@mansr.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Mon, Feb 18, 2019 at 12:10 PM Måns Rullgård <mans@mansr.com> wrote:
> >>
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>
> >> > On Sat, Feb 16, 2019 at 5:50 PM Mans Rullgard <mans@mansr.com> wrote:
> >> >>
> >> >> If the provided fwnode is an OF node, set dev.of_node as well.
> >> >>
> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> >> ---
> >> >>  drivers/base/platform.c | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >>
> >> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >> >> index dff82a3c2caa..853a1d0e5845 100644
> >> >> --- a/drivers/base/platform.c
> >> >> +++ b/drivers/base/platform.c
> >> >> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
> >> >>
> >> >>         pdev->dev.parent = pdevinfo->parent;
> >> >>         pdev->dev.fwnode = pdevinfo->fwnode;
> >> >> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
> >> >
> >> > of_node_get() generally does a kobject_get() on the node's kobject, so
> >> > when is that reference dropped?  Or if it doesn't need to be dropped
> >> > at all, why is this the case?
> >>
> >> platform_device_release() calls of_device_node_put().
> >
> > Yes, it does, but this is the reference that's already acquired for
> > devices added while parsing DT, isn't it?
> >
> > Your change adds an extra reference AFAICS.
> >
> > Also, why is this patch needed?
>
> Some drivers are just shims that create extra "glue" devices with the DT
> device as parent and have the real driver bind to these.  In other
> cases, the same real driver matches the DT node directly.  When a glue
> device is used, it needs to get a reference to the original DT node in
> order for the main driver to access properties and child nodes.
>
> Right now, my problem is that the suxi-musb driver creates such a glue
> device for the musb core driver to bind to without setting of_node.
> This means devices attached to this USB interface don't get associated
> with DT nodes, if present, the way they do with EHCI.

You really should describe problems that you want to address in patch
changelogs.  This helps a lot to understand the motivation for the
changes.

> The sunxi-musb driver uses platform_device_register_full(), so this
> seemed like the easiest way to let it set of_node of the new device.
> Since this creates a second reference to the same node, of_node_get()
> is required.

But what about devices that already have of_node set at this point?

Maybe check if of_node is NULL before trying to set it?
