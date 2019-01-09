Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313492070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXeEZKEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfAIH0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:26:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35061 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfAIH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:26:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so6561219wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xqjed7hXM+5e2GySa0I08BXUx5TQAYPnYxVQ7A9IPIU=;
        b=iXeEZKEUSwsi6US6Yoanpx0/nsZXnd5nj+0R5YQZOoozhak+5sc2BQJ0d6vUVQczVF
         8SffWwqRJSnRdeftG+TNhDyLaYUPpL4webjZ34qPeaMhnTjwdIOriYuHbF8ZHlTYSSlB
         rHmTxUhu3m1/rYcolJf9vDv1tVOqXbl6VuUYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xqjed7hXM+5e2GySa0I08BXUx5TQAYPnYxVQ7A9IPIU=;
        b=r/MUOa7+t82teimjUFZfYO8zFTmesAM2oRAYrR0g0cL2t0gAJ3RwIMwdPGIiaDfmMk
         ohzFVJgv3ikTQcAbfFY4agCRMpNMx/VeM6beUQ3lZlt0lcorM4nOhtIxQe2HOXawea7E
         3LwPX7rqsXWgWFBfmcidwKduRg2gDYx/tst9dzeMsDsUril5McrrsPsZqVcVG/3gDB4u
         5RrWMWDXKVT5OffC0Qg9s170b5y66BNc3dcH1KbyV27TjnCqlIw3qtGXLbHvbnl4DXfg
         2AYTnavmPvKdw3TR2GXZbMj9UxYVBqhv1YabtcIKl4OzSP3bH3mqon950SlGtwrD8aV/
         5+pg==
X-Gm-Message-State: AJcUukfMQWi2YkhORFOb9VZzN6d6zuXQK9dQTs25TvC6NEupnrSo+lUi
        +H9AGkRkGwApwYEpvEpeUc64Kg==
X-Google-Smtp-Source: ALg8bN6l9a6I5KD05eS5kQBuGRcPJAFWALbcRfUyqUWlUkOzn6AoJeWkIxrH+PX9qOh8/FvypXQL9w==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr4021763wrj.118.1547018758131;
        Tue, 08 Jan 2019 23:25:58 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id y138sm16398031wmc.16.2019.01.08.23.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:25:57 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:25:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
Message-ID: <20190109072556.GD27286@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20181221091001.GA13248@dell>
 <CAFqH_51mrsb=cBOeBL0avyYGogZ-MtMUpKUS7avXGT9Q2JmWHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51mrsb=cBOeBL0avyYGogZ-MtMUpKUS7avXGT9Q2JmWHw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2019, Enric Balletbo Serra wrote:
> Missatge de Lee Jones <lee.jones@linaro.org> del dia dv., 21 de des.
> 2018 a les 16:39:
> >
> > On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:
> >
> > > Hi,
> > >
> > > This is another patchset to try to cleanup a bit more the crossed
> > > references for cros-ec driver between the MFD and the platform/chrome
> > > subsystems.
> > >
> > > The purpose of these patches is get rid of the different cros-ec attributes
> > > from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
> > > continues instantiating the sub-devices but the sysfs attributes are owned
> > > by the platform driver.E.g. The lightbar driver should own his sysfs
> > > attributes and be instantiated only if the Embedded Controller has a
> > > lightbar.
> > >
> > > The patchset also adds the documentation of the sysfs attributes.
> > >
> > > Most of the patches touches mfd subsystem and platform/chrome so I'd
> > > suggest go all using and inmutable branch.
> >
> > That's fine.
> >
> > What else needs to happen with this set?
> 
> I think the patchset is ready to be queued. Note that to apply cleanly
> it depends on [1] which is already merged in your for-next branch.
> What do you prefer, go through your repo or go through the
> chrome-platform repo? Do you want Benson or I create an immutable
> branch? I'm fine with whenever you decide.

Probably best if this goes through the MFD tree.

I have a PR pending upstream at the moment.  Once I know what is
happening with that, I'll start taking patches/sets again.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=18e294ddafaeb80a1e2e10c9bd750a6cb8388d5b
> 
> > Any more Acks required?
> >
> 
> I think that you, Guenter, Benson and I are fine with it, so not more
> acks needed.

Thanks for the clarification.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
