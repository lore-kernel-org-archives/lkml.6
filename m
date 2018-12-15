Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B7E20645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeLOKMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:12:24 -0500
Received: from jablonecka.jablonka.cz ([91.219.244.36]:49891 "EHLO
        jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeLOKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:12:23 -0500
Received: from twilight.vojtech.kobylisy.czf (unknown [10.32.148.9])
        by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTP id DE0B8603494B;
        Sat, 15 Dec 2018 11:12:21 +0100 (CET)
Received: by twilight.vojtech.kobylisy.czf (Postfix, from userid 1000)
        id C35B71549C37; Sat, 15 Dec 2018 11:12:21 +0100 (CET)
Date:   Sat, 15 Dec 2018 11:12:21 +0100
From:   Vojtech Pavlik <vojtech@suse.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Message-ID: <20181215101221.GA23879@suse.com>
References: <20181214232437.GA8310@amd>
 <20181215085510.GB12930@suse.com>
 <20181215094722.GA5804@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215094722.GA5804@amd>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 10:47:22AM +0100, Pavel Machek wrote:

> > > b) would it be acceptable if done properly? (cmd line option to
> > > enable, avoiding duplicate/wrong events?)
> > 
> > Well, for one, you shouldn't be using a timer, all the debouncing can be
> > done by math on the event timestamps.
> 
> Not... really, right? You need to send an release some time after
> button indicates release if bounce did not happen. It is similar to
> autorepeat needing a timer.

You can send the first release and ignore all presses and releases in a
time window after that.

> Let me gain some experience with the patch. I don't think hardware
> does as heavy debouncing as you describe.

Microswitches vibrate significantly when clicked. Without hardware
debouncing, you'd have many clicks instead of one even on a new mouse.


-- 
Vojtech Pavlik
