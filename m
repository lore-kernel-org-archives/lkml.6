Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ACC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5B121855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5W/bFhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfAWSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:45:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:45:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1448092pgk.10;
        Wed, 23 Jan 2019 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZEnY1/HSMRptC3WUfVMj0vBoO4FFPZN70BHX8zxRYg=;
        b=E5W/bFhiInrtNM/SJ32SK4eXISxAi5v2ZeBVRBKUejTVghCEGA3dy/kBXLoBYULtz9
         JVEWSGTselhXPFv0BhnIivNpAkWP0j3d9SrdSyy/x1h++gcf6WUIYHOJiTIFrvOtRk9s
         ZR0+hSOPnQkOaFUInGMXc5m+JdwGH7Z1Y+Sr12+H9uP3SIcZWfb4+mn2gzw3NPmbp9tb
         dNx05/WoMiDp8K/O6WvzwNQOspX68HPmPcpvPaNFvbJDdFc9jXqHGo7Twh5fgiA57fkW
         WgeFICE8/6PMznaDA5q4jWhZkV/14s72wMm17tQxfJslBEGbIHLB53gkyXRFQCLCbYOI
         K9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZEnY1/HSMRptC3WUfVMj0vBoO4FFPZN70BHX8zxRYg=;
        b=jVi8qlaz8tJde5oUZrKuN7Seeu6nmLl9y9FkoksApkry5DOqufXoz4tr91h8pqUVly
         aDf87uDQFODSFcd7OIniLXeBMnnQv0dCLrmFwKMwmfhiesz50PqXlxVj/G7WbrKc+SmO
         sUcEhEk9JoF7k1COekr+hKXGzaF8TBFHb2pXmXk9fed7jsM9vAgGma3sWDoqWbAtNI+/
         6KnmtI8Ys4VQQOnGmCa8h+VdkqBa4COYe+C1pRMuPElthOM/t8RC+cMYQK5sbJvvdX++
         VGDt0xlp9GkZ3Vc8+oAk35dSXgt4a66NzXkVIfY6UDgwkz2Gx0B4Np323DkbgXBLJDhS
         qjrg==
X-Gm-Message-State: AJcUukf+TGZ7pxz3OLH6L8tuYVy2Jl/5h7EzLST/xQSY2TK39GlcGJmr
        1kaPSw3lgHQM1VV2BWZvBaad5+VZ
X-Google-Smtp-Source: ALg8bN6ljj1RM4Tvn791VXFlu1a6UUfR1RFFX6Q5hYbNLgCLcJ2W8WegMpy8mA9EhvUKzUkiAbcSmA==
X-Received: by 2002:a62:2702:: with SMTP id n2mr3180173pfn.29.1548269103802;
        Wed, 23 Jan 2019 10:45:03 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u186sm35604319pfu.51.2019.01.23.10.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:45:03 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:45:01 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel@vger.kernel.org, sjg@chromium.org, sre@kernel.org,
        linux-input@vger.kernel.org, groeck@chromium.org,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v4 6/9] platform/chrome: Add event handling
Message-ID: <20190123184501.GA179701@dtor-ws>
References: <20190123183325.92946-1-ncrews@chromium.org>
 <20190123183325.92946-7-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123183325.92946-7-ncrews@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick, Duncan,

On Wed, Jan 23, 2019 at 11:33:22AM -0700, Nick Crews wrote:
> From: Duncan Laurie <dlaurie@google.com>
> 
> The Wilco Embedded Controller can return extended events that
> are not handled by standard ACPI objects.  These events can
> include hotkeys which map to standard functions like brightness
> controls, or information about EC controlled features like the
> charger or battery.
> 
> These events are triggered with an ACPI Notify(0x90) and the
> event data buffer is read through an ACPI method provided by
> the BIOS which reads the event buffer from EC RAM.
> 
> These events are then processed, with hotkey events being sent
> to the input subsystem and other events put into a queue which
> can be read by a userspace daemon via a sysfs attribute.

I thought we agreed that brightness keys will be routed through normal
keyboard interface, not separate input device?

Looking at the driver more, I do not see why it needs to be toed to EC,
this seems to be a straightforward ACPI driver that should bind to and
ACPI device by its HID, since the only thing it does is installing ACPI
notify handler and shuffling the events over to userspace.

I do not think we want to use a binary attribute for this, as it does
not support polling well and in general is not well suitable for
pumping data to userspace. I'd recommend char misc device for that.

What kind of events will be delivered over this interface?

Thanks.

-- 
Dmitry
