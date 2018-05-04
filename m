Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeEDIMz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:12:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeEDIMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:12:53 -0400
Date: Fri, 4 May 2018 10:12:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?ISO-8859-15?Q?Cl=E9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v9 0/2] hid-steam driver with user mode client dection
In-Reply-To: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
Message-ID: <nycvar.YFH.7.76.1805041008100.27054@cbobk.fhfr.pm>
References: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Rodrigo Rivas Costa wrote:

> Hello! This is reroll v9 of the Steam Controller driver.
> 
> @Pierre-Loup, @Clément, could you please check if this driver is acceptable by
> Valve? I think this could be the one ;-).
> 
> I've rolled back the synthetic LPAD diagonals. It happens that the actual
> coordinates of the pads are rotated about 15 degrees to the center, but the
> marks in the pad are aligned to 0/90 degrees. That, and my poor's man
> trigonometry, makes clicking the diagonals quite unreliable.
> Sorry for the noise, but now I think that we are better limiting ourselves to
> the events emitted by the hardware, as is.
> 
> Other than that, I've doing some torture testing, with and without the Steam
> Client running. I've changed:
>  1. The way EPIPE is handled when sending a report: I've noticed that Steam
>     Client retries up to 50 times, with little or no delay between them, so I do
>     the same.
>  2. I've added a fallback in case this driver is unable to get the serial number
>     of the controller. Failures on any other report can be ignored safely. But
>     failing to get the serial number was preventing the creating of the hidraw
>     node (wired controller only), and that could prevent Steam Client from
>     working. 
>  3. I've received a mail from Valve with a bunch of constants for the
>     protocol. Most are related to the setting of new mappings (that we do not
>     need) and a few of the rest are deprecated. Anyway, I've renamed the
>     constants STEAM_CMD_* to align them with the official names, and added a
>     few more that were unknown to me, just for future reference. Still, commands
>     used for enabling/disabling lizard mode are the same.

If noone has any objections (last chance to raise them), I'll be queuing 
this for 4.18.

Thanks,

-- 
Jiri Kosina
SUSE Labs
