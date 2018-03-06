Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeCFPDT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:58457 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753689AbeCFPDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:03:18 -0500
Date: Tue, 6 Mar 2018 16:03:16 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] HID: core: rewrite the hid-generic automatic
 unbind
In-Reply-To: <CAO-hwJJGvaT5_5NW9u0zgJ=d+s0vHF6TOiNN--PzHq5e281Frw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1803061602400.15778@cbobk.fhfr.pm>
References: <20171208142944.15695-1-benjamin.tissoires@redhat.com> <CAO-hwJJGvaT5_5NW9u0zgJ=d+s0vHF6TOiNN--PzHq5e281Frw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018, Benjamin Tissoires wrote:

> > We actually can have the unbind/rebind logic in hid-core.c, leaving
> > only the match function in hid-generic.
> > This makes hid-generic simpler and the whole logic simpler too.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Hi Jiri,
> >
> > while trying to find out a local bug, I figured out we don't really
> > need the bus_add_driver and bus_removed_driver callbacks.
> >
> > This makes the code simpler and also allows other drivers to remove
> > themself if other conditions are met. They just need to implement a smart
> > enough .matchcallback and they are done.
> >
> 
> Looks like you are reviewing HID patches right now :)

Indeed! :)

> I just wanted to dig this one out from your mailbox. I still think
> it's valuable.
> IIRC it should still apply on your tree, but if not, I can quickly
> update the patch.

Ah, thanks for a friendly ping! This really slipped in between cracks. 
Applied now.

-- 
Jiri Kosina
SUSE Labs
