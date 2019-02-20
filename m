Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C752086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550660944;
	bh=jt2roqEsMLPOIsDN7kr8GGYqPBdr2wZt8EiCaI2mkEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Q9XF8llaQi6oaiChjEYYV6ReaEG49Vxd92924WoRPj750mlVaLheVytfCDq1ALuR
	 iUrn9t5OAeJ4ODyBVfQkGrcKflsxYT0mQKIBwB9x7yq94zmr55XpCLn8G3o88Aiua7
	 0ylXxedi2D0fIYBXmKS0PrFvSa+k2zxrO7fQIeu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfBTLJC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:09:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46490 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:09:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so17888857otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J6vZdynoXByekuwiZWrZ2EMtGg+SSi482lXCFI69D+I=;
        b=l+gLpX8MHVMdrLnkLiJgrvrCCss27O7TxdfnEqq2xOZJ35SzXBgyqGTtw5u0eMyTW4
         //MIgTl8PSKOCBjetGGNgATJiXFVJqFDbS8Qv2e8MqgETxCah5PkzE4GWzLA6YdoWis0
         4+C2L8/XZYhIB65f8KQryIZHt76V5MfRGugW9BtMB9dBbeTx/BIUkvU55HO2/EQauD1Q
         tuUT3Rb88F/FB4x3WWoe4HdxYi1oAu1ZZ/agtdNsETBRJQawBLMaGApP453pn9S/mLkM
         VeQsYq+4mZVHVz1spORXHz8wom3f+CEw1IKMhV6CsnsCrPlNTGbvFnKtAO0Rxde3t0Bg
         E4yA==
X-Gm-Message-State: AHQUAuYR/1y859LQxQsqgonE8QSRMHhzEtpe82anRL065F6Cgoj1Sn8Z
        mIizO5eIwCekJ7kmWSJxbdfxBDotnekYQ9xa4XQ=
X-Google-Smtp-Source: AHgI3IZl6Yhy3o/RjxPACua/+j7AOHeOnFavnh2Cw1Qk3a5vb7YXleL3RWm0rxIDnUSrJWdSXtwwl5wTD5mYD8ayrTk=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr4614489otl.244.1550660940138;
 Wed, 20 Feb 2019 03:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com> <CAJZ5v0iZHfU=mE3JGcKqbswGGert7CvpKPkVE1s+-X1zXKJiEw@mail.gmail.com>
 <yw1xk1hxxss8.fsf@mansr.com> <CAJZ5v0gG5Rau71YrmUL8V7EpZjHQNOzLpEJHCJjXdgaDm4TrSw@mail.gmail.com>
 <yw1x7eduyc6p.fsf@mansr.com> <CAJZ5v0gMD27Wa3+iuwSoZGpStsVgShWP=SkY69EjrDy2SrftYA@mail.gmail.com>
 <yw1xy36awwm7.fsf@mansr.com>
In-Reply-To: <yw1xy36awwm7.fsf@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 12:08:49 +0100
Message-ID: <CAJZ5v0hvfVgTigfycGmV7u-Rj6i2fyzhrJjdiWEQfq4PxgFzwA@mail.gmail.com>
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

On Wed, Feb 20, 2019 at 12:02 PM Måns Rullgård <mans@mansr.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Feb 20, 2019 at 11:41 AM Måns Rullgård <mans@mansr.com> wrote:
> >>
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>
> >> > On Mon, Feb 18, 2019 at 12:10 PM Måns Rullgård <mans@mansr.com> wrote:
> >> >>
> >> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >> >>
> >> >> > On Sat, Feb 16, 2019 at 5:50 PM Mans Rullgard <mans@mansr.com> wrote:
> >> >> >>
> >> >> >> If the provided fwnode is an OF node, set dev.of_node as well.
> >> >> >>
> >> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> >> >> ---
> >> >> >>  drivers/base/platform.c | 1 +
> >> >> >>  1 file changed, 1 insertion(+)
> >> >> >>
> >> >> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >> >> >> index dff82a3c2caa..853a1d0e5845 100644
> >> >> >> --- a/drivers/base/platform.c
> >> >> >> +++ b/drivers/base/platform.c
> >> >> >> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
> >> >> >>
> >> >> >>         pdev->dev.parent = pdevinfo->parent;
> >> >> >>         pdev->dev.fwnode = pdevinfo->fwnode;
> >> >> >> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
> >> >> >
> >> >> > of_node_get() generally does a kobject_get() on the node's kobject, so
> >> >> > when is that reference dropped?  Or if it doesn't need to be dropped
> >> >> > at all, why is this the case?
> >> >>
> >> >> platform_device_release() calls of_device_node_put().
> >> >
> >> > Yes, it does, but this is the reference that's already acquired for
> >> > devices added while parsing DT, isn't it?
> >> >
> >> > Your change adds an extra reference AFAICS.
> >> >
> >> > Also, why is this patch needed?
> >>
> >> Some drivers are just shims that create extra "glue" devices with the DT
> >> device as parent and have the real driver bind to these.  In other
> >> cases, the same real driver matches the DT node directly.  When a glue
> >> device is used, it needs to get a reference to the original DT node in
> >> order for the main driver to access properties and child nodes.
> >>
> >> Right now, my problem is that the suxi-musb driver creates such a glue
> >> device for the musb core driver to bind to without setting of_node.
> >> This means devices attached to this USB interface don't get associated
> >> with DT nodes, if present, the way they do with EHCI.
> >
> > You really should describe problems that you want to address in patch
> > changelogs.  This helps a lot to understand the motivation for the
> > changes.
>
> Do you want me to send a new patch with the above explanation in the
> commit message?

Yes, please.

> >> The sunxi-musb driver uses platform_device_register_full(), so this
> >> seemed like the easiest way to let it set of_node of the new device.
> >> Since this creates a second reference to the same node, of_node_get()
> >> is required.
> >
> > But what about devices that already have of_node set at this point?
> >
> > Maybe check if of_node is NULL before trying to set it?
>
> It's a brand new device allocated a few lines above.  of_node has to be
> null here.

Right, sorry for the confusion.
