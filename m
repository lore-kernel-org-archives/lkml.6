Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A45C282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061A42084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="C2ThJSJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAUHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:50:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35072 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfAUHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:50:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so22101900wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ND1NftFWyS/tgyoYicMUwFG6MNxVNmzE2sPX5uNe/6Q=;
        b=C2ThJSJ81dbZfpDfsNByFI99nf552Hp5LXkf8DF9hhMOcTGz3PCvYvUtg0IS/RcT2u
         J4gp24ehtOe3X6WWR65v3fbkroWNa+c8vT9+odNTJ2JX0ahmly3cvvgJzHqwk39+tPnR
         r2QXypJCd0//T1QPPBpCZJhnLCIQoVMg7L7G+RD9cGhZzJN61u93L+BYZOVxM56ZvANE
         o2rx/ulwFyjQCv3U1n+aKysaTdBzsYnLe8B13RGF797YS7MWs6oJBXiADeCxi0Mucngy
         YpLlovOIGwO9wYXKG+g54kz3SmM9KzWKJ+NHVeM7ibrlM1FnFriwc+eYsMkoHb9a7riU
         nVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ND1NftFWyS/tgyoYicMUwFG6MNxVNmzE2sPX5uNe/6Q=;
        b=K+vKFIqI2nkzGlt5jxI4EwQFtkg03LSZ55wWA7YbH9VSB4FkS5uJ1t1RvUWyf47SS0
         1dJ2xubd9jXT+mhL7xubQmFoHaWCUGFg46MgF6YGRAHAhtLLuCkLmINOHPf+EWno6bEm
         TWCy2oce2Kfy/4auya6Tnu2h4/XZiQ3vqQGaZWjt2YSJUumWZLouNev3BHUcgujWkIAn
         7HT9hoWXWO5DJi2CMNn8V/aSG0upa5AupSNI2Hnw1YI2pEarmXDd22rgW9/ohF+mkV1q
         d3ogwAo9Xhqe5JCRK/hv3H1jETCL6GJM+F1KKlZKZWgLtgdlFkYNeSecCsSCnsAH2Fwm
         qbVA==
X-Gm-Message-State: AJcUukeGJZmvCEYBFthwWCH/wCSd1J3KOQ2SoOhPEOv6SY1Ettijgo7z
        YBoQfhZGvgDqH8TMxDm2KlQJLUgdSdrmkg==
X-Google-Smtp-Source: ALg8bN7dHLaQBmLcK6XXGIGffyD37cpz259MES2qb4oYe0nWxor+OcxjVthC1jmDAUv3558RFSGbEg==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr26481275wrm.223.1548022902884;
        Sun, 20 Jan 2019 14:21:42 -0800 (PST)
Received: from jaya.lan ([2a01:e34:ef92:b70:7ee9:d3ff:fef0:777c])
        by smtp.gmail.com with ESMTPSA id y13sm51950902wme.2.2019.01.20.14.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 14:21:42 -0800 (PST)
Date:   Sun, 20 Jan 2019 23:21:40 +0100
From:   Anisse Astier <anisse@astier.eu>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq: Fix local event signalling
Message-ID: <20190120222140.GA6626@jaya.lan>
References: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Fri, Jan 11, 2019 at 11:34:53AM +0000, Phil Elwell wrote:
> Prior to the recent event reworking (see Fixes), thread synchronisation
> was implemented using completions, the worker thread being woken with
> a call to complete(). The replacement uses waitqueues, which are more
> like condition variables in that the waiting thread is only woken if
> the condition is true.
> 
> When the VPU signals the ARM, it first sets the event's fired flag to
> indicate which event is being signalled, but the places in the
> ARM-side code where the worker thread is being woken -
> remote_event_signal_local via request_poll - did not do so as it
> wasn't previously necessary, and since the armed flag was being
> cleared this lead to a deadlock.

This fixes an issue I've had on linux 5.0-pre to 5.0-rc2+: the
bcm2835-audio driver would block on close, and then nothing would work
until the process was killed. Sample log:

bcm2835_audio bcm2835_audio: failed to close VCHI service connection (status=1)

> 
> Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Tested-by: Anisse Astier <anisse@astier.eu>


Regards,

Anisse
