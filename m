Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E751C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326612186B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326612186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeHMRht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:37:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33292 "EHLO
        slow2.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727367AbeHMRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:37:49 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by slow2.mail.gandi.net (Postfix) with ESMTP id 8A85C3A58FD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:52:45 +0200 (CEST)
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6B696FF805;
        Mon, 13 Aug 2018 14:52:41 +0000 (UTC)
Message-ID: <2923ec52f5f977f9213607b46c3618fd2a4c4a15.camel@hadess.net>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S
 controller
From:   Bastien Nocera <hadess@hadess.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Date:   Mon, 13 Aug 2018 16:52:40 +0200
In-Reply-To: <CAHQ1cqEMJFCD8GU9o194EUPfUV9TTswW-jE2MPhoEzrg3cshYQ@mail.gmail.com>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
         <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
         <CAHQ1cqEMJFCD8GU9o194EUPfUV9TTswW-jE2MPhoEzrg3cshYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 07:37 -0700, Andrey Smirnov wrote:
> On Fri, Aug 10, 2018 at 4:38 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Thu, 2018-08-09 at 17:17 -0700, Andrey Smirnov wrote:
> > > Add HID quirk driver for Xbox One S controller over bluetooth.
> > > 
> > > This driver only adds support for rumble. Standard controller
> > > functionality is exposed by default HID driver.
> > 
> > Did you manage to make the joypad work without hacks in the
> > Bluetooth
> > stack[1]?
> 
> I was not aware this hack actually existed, but now that I see it I
> think it explains why doing
> 
> echo 1 > /sys/module/bluetooth/parameters/disable_ertm
> 
> was necessary to make the controller connect over Bluetooth on my
> machine. It looks like disabling ERTM just happens to have the same
> effect as the hack that you mention. I'd like/plan to look into
> finding a proper solution to replace that hack, but that'd probably
> be
> a separate patch.

I gave it a try a couple of months back, but without much success.
L2CAP is unfortunately a bit too low-level to know anything about the
device which requested this. I think that some level of "STREAMING"
support is needed for the Bluetooth audio portion of the device.

Marcel was also interested in looking into the problem, but didn't get
to it. Let me know if you manage to get anything working without the
big hammer of disabling ERTM support for everything.

Cheers

