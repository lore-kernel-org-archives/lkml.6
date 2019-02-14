Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B750B21934
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOFZtrC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405679AbfBNGLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:11:08 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40521 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:11:07 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so11752023ite.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 22:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hi/QV+SURuABXjVpQ6kWj7ohVbb8Bd7EQiRMott+eZg=;
        b=LOFZtrC+klsSwa93cdOHN6oiVvVwA+J8KKMUOVOjk/5x/tvdKxtZ9TM1EEM2Jtok3d
         4nIDCJq3yFiLRTKyJzNBqY+xuuelIUd93pv5Ybe+aEnCKt3acGy9UYS1YWy/g1OdKbrW
         eEjjplUBRhGHN82kzRRh9hlbNMumRPlGxyfL6Jw+3mpiVZLrkAN8E8NCnoRBSzG2b9yf
         j8l5GL/OW46Dlc60Dqlv9DNDsEIuzswrPmZGzcbIuiQHrEYa6zYqZiUigH1zFgGDjjLN
         BTyHOilRPXiV7bZtUkyXuBZ6nsSmyqNenUYEWn/Oum47chPgl8dutTcqcZbjXOu7JY1D
         bf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hi/QV+SURuABXjVpQ6kWj7ohVbb8Bd7EQiRMott+eZg=;
        b=nBwuEric0jA1Noek3iAFJJ4WF5a01owSyrt7+yPsVTFHdCy5zMjq5dWfu7/N5LqjLx
         oEklLiaop4NsUNoK2Io19lAPmP+mCx3Wyfy6cU5FIWqaZL6KLkAFx6bam+yILuFn8nd8
         XDbEafG1qEHQIYRAeVaiG8rtdVeFK74yhC/2RJtL0x4r/UG9tzeW+bJQo+IHqONX5yeR
         GsnzZvoKbAgTa4AyXXzP+LqqXOM+4FGSyLtwXmUvOYsV4xrzZv9ddCD5/iZLk3SUwpx8
         9RcCrwOWCR5hvQncQN4liOhbk7XYL0r/y1UliuYIzWM/WRy3T+H0A12mVx8OgbeIaO8m
         zKbA==
X-Gm-Message-State: AHQUAuZTnDylzwQR7Gl8V7wiiq4NdP87zdREkN0pIyfpde300mbyHNbN
        /vG+l4/3h+A25pxQIQQi34c=
X-Google-Smtp-Source: AHgI3IZ+FpMSUKpZBYW2C2piIeAEq0paeCppw2Bht0k0ZBeA7Ews3ks9GkukcrElSN9HjW9Uq/K8Cw==
X-Received: by 2002:a02:b4b8:: with SMTP id k53mr1143207jaj.56.1550124666670;
        Wed, 13 Feb 2019 22:11:06 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id z10sm641504ioh.20.2019.02.13.22.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 22:11:05 -0800 (PST)
Date:   Thu, 14 Feb 2019 01:11:03 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <20190214061102.GA22473@ubu-Virtual-Machine>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
 <20190208143148.052c8d9c@hermes.lan>
 <20190211070118.GA2977@ubu-Virtual-Machine>
 <20190211100247.12221570@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211100247.12221570@hermes.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:02:47AM -0800, Stephen Hemminger wrote:
> On Mon, 11 Feb 2019 02:01:18 -0500
> Kimberly Brown <kimbrownkd@gmail.com> wrote:
> 
> > On Fri, Feb 08, 2019 at 02:32:09PM -0800, Stephen Hemminger wrote:
> > > On Fri, 8 Feb 2019 05:01:12 -0500
> > > Kimberly Brown <kimbrownkd@gmail.com> wrote:
> > > 
> > > You are right, the current behavior is broken.
> > > It would be good to add a description of under what conditions
> > > monitor is not used. Is this some part of a project emulating
> > > Hyper-V?
> > >   
> > 
> > I'm not sure which conditions determine whether the monitor mechanism is
> > used. I've searched the Hypervisor TLFS, and I couldn't find any
> > information. If you have any suggestions for where I can find this
> > information, please let me know.
> 
> The monitor page stuff pre-dates my involvement with Hyper-V. KY might know.
> But based on comments it looks like it was added to avoid hypercalls
> for each message. It probably showed up in Windows Server 2012 timeframe.
> 
> To test you might want to dig up Windows Server 2008.
>  

It looks like the monitor mechanism has always been used. It's present in the
earliest commit that I can find: 3e7ee4902fe6 ("add the Hyper-V virtual bus")
from 2009.

I propose that the following sentences be added to the sysfs documentation for
the affected attributes:

"The monitor page mechanism is used for performance critical channels (storage,
network, etc.). Channels that do not use the monitor page mechanism will return
EINVAL."

I think that this provides sufficient information for a user to understand why
opening an affected file can return EINVAL. What do you think?

