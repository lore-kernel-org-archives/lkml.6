Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C721916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="VykqiQNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439881AbfBNTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:50:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNTuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:50:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so3621867pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRcmb7eavvaVqSXi/lEiGq5CIgT11mtyDTh1QEVcHHQ=;
        b=VykqiQNxuRGS97c+HvlKah4Zm7eRgRhjVcG9SD+h0A4hMzVOlsUxAI2XnN6J56/pao
         07nIPAH+7fq4K4tL51zh6rAiD5Xg0Ye3ux9KmbffV4U+WWy0ZYTNeKsNTVwh3v2PhjTA
         rGzhBD1s6jwzDh5sOIaxeqiw0ggie9uO4WnXo1BxgAkJWTzZibrHqYV3DhkuKSEU2pzU
         FVdK4Ptsd5XDCQf+yJ8UF0eRL6F/KouYCzpBix3T61oppqB1JtYIYCYvfeBloynQeM8C
         lAvqri+XXekCVCLUPZFMYFx1Fh7QJnOUcVLQrSyvgms96Np4Xuq/KGasC9FOyss/BB5A
         F0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRcmb7eavvaVqSXi/lEiGq5CIgT11mtyDTh1QEVcHHQ=;
        b=o/CDp+svxm1ZlAMhLOXjyj0pLkfXkMtouZB1kGP4Q/bSlz6TgCWaO8susoPtNK3Xos
         JaYsJPhI0aUZKArHymtNsHv6s1h7qMeCKaEhgjlYfMnkpm2J3UMQ9TKEQEKOUQZ7d3Nx
         Le6Am+5AGKn0UlVO0mPxDIwfsJ5riV6QysJwNlGJh6CBnpiEO5EbzrqFS6To2t+3fX+V
         u2KvCEBLWWjygzQ10u0MO5GDo7z9qCwv/3OaVmPqpp0Q7ykk8spffDti0lmDsxqm60Nz
         ySFA1qGWK+JxBjBm3ebks1H8DFUdaD833Zem3SUYVN4xvgYGa8EPMrpDqZtbaxH5M/TE
         7Few==
X-Gm-Message-State: AHQUAubV6haG68U10uvNyksJdeRUsZfe11Shg2/+znZmpvGSePJ+cQ5P
        V+wXuV6k6AmKzN5kzIknezwQjA==
X-Google-Smtp-Source: AHgI3IYmo0aVTIMqDporUSJbj3VVRPr6DaTYCvJogDs1f3Z8dm+R4HZD+NBwCzwlnLGrBGLtcU3noA==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr1517416pgp.46.1550173823002;
        Thu, 14 Feb 2019 11:50:23 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id e24sm4320839pfi.153.2019.02.14.11.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:50:22 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:50:19 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <20190214115019.0e914fa5@shemminger-XPS-13-9360>
In-Reply-To: <20190214061102.GA22473@ubu-Virtual-Machine>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
        <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
        <20190208143148.052c8d9c@hermes.lan>
        <20190211070118.GA2977@ubu-Virtual-Machine>
        <20190211100247.12221570@hermes.lan>
        <20190214061102.GA22473@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 01:11:03 -0500
Kimberly Brown <kimbrownkd@gmail.com> wrote:

> On Mon, Feb 11, 2019 at 10:02:47AM -0800, Stephen Hemminger wrote:
> > On Mon, 11 Feb 2019 02:01:18 -0500
> > Kimberly Brown <kimbrownkd@gmail.com> wrote:
> >   
> > > On Fri, Feb 08, 2019 at 02:32:09PM -0800, Stephen Hemminger wrote:  
> > > > On Fri, 8 Feb 2019 05:01:12 -0500
> > > > Kimberly Brown <kimbrownkd@gmail.com> wrote:
> > > > 
> > > > You are right, the current behavior is broken.
> > > > It would be good to add a description of under what conditions
> > > > monitor is not used. Is this some part of a project emulating
> > > > Hyper-V?
> > > >     
> > > 
> > > I'm not sure which conditions determine whether the monitor mechanism is
> > > used. I've searched the Hypervisor TLFS, and I couldn't find any
> > > information. If you have any suggestions for where I can find this
> > > information, please let me know.  
> > 
> > The monitor page stuff pre-dates my involvement with Hyper-V. KY might know.
> > But based on comments it looks like it was added to avoid hypercalls
> > for each message. It probably showed up in Windows Server 2012 timeframe.
> > 
> > To test you might want to dig up Windows Server 2008.
> >    
> 
> It looks like the monitor mechanism has always been used. It's present in the
> earliest commit that I can find: 3e7ee4902fe6 ("add the Hyper-V virtual bus")
> from 2009.
> 
> I propose that the following sentences be added to the sysfs documentation for
> the affected attributes:
> 
> "The monitor page mechanism is used for performance critical channels (storage,
> network, etc.). Channels that do not use the monitor page mechanism will return
> EINVAL."
> 
> I think that this provides sufficient information for a user to understand why
> opening an affected file can return EINVAL. What do you think?

Thanks for following up. I agree with you EINVAL works as a solution.
My understanding is that their are two ways a channel can work. The first one is
for the guest to send a hyper call to the host to indicate when data is available.
The other is for the guest to indicate by setting a bit in shared memory with host.

The shared memory approach reduces host/guest overhead and allows for more opportunities
for batching in the ring. The host checks the shared memory on a polling interval
defined in the latency field.

The hypercall method does not use the monitor page. It has lower latency (no polling).
