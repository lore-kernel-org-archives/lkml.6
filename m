Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937158AbeE3G60 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:55603 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937118AbeE3G4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:56:47 -0400
Date: Wed, 30 May 2018 08:56:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc: Andrew Duggan <aduggan@synaptics.com>,
        Oscar Morante <spacepluk@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: rmi: use HID_QUIRK_NO_INPUT_SYNC
In-Reply-To: <20180525125106.18008-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1805300855510.27054@cbobk.fhfr.pm>
References: <20180525125106.18008-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Benjamin Tissoires wrote:

> When we receive a RMI4 report, we should not unconditionally send an
> input_sync event. Instead, we should let the rmi4 transport layer do it
> for us.
> 
> This fixes a situation where we might receive X in a report and the rest
> in a subsequent one. And this messes up user space.
> 
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=100436
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> Oscar, do you mind if we add your "Tested-by: Oscar Morante <your@email>"?
> 
> Andrew, can you check for any sides effects please?

I have now added Oscar's Tested-by: line and queued in for-4.18/rmi. In 
case any sideeffects are discovered, I'll either not include for-4.18/rmi 
in the push to Linus, or we'll do incremental fixups on top (depending on 
the nature of the side-effects :) ).

Thanks,

-- 
Jiri Kosina
SUSE Labs
