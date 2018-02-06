Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBFAaE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:30:04 -0500
Received: from leo.clearchain.com ([199.73.29.74]:15112 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeBFA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:59 -0500
Date: Tue, 6 Feb 2018 10:29:47 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALPS Trackpoint & pressure
Message-ID: <20180206002947.GB27776@jelly>
References: <20180204150839.b5qm4wb26vic35st@pali>
 <20180205224955.GB46524@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180205224955.GB46524@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:49:55PM -0800, Dmitry Torokhov wrote:
> On Sun, Feb 04, 2018 at 04:08:39PM +0100, Pali Rohár wrote:
> > Hi! Now playing again with trackpoint connected to ALPS rushmore
> > touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
> > reports pressure of trackpoint. Parser for it is already implemented in
> > alps.c and value is assigned to variable "z". When I just move
> > trackpoint z is zero, when I push trackpoint while moving, then z is
> > number higher, maximally 32. Variable "z" is set, but unused.
> > 
> > Do we have some input interface which can be used to report this
> > pressure of trackpoint to userspace? I can use this feature e.g. as
> > additional button...
> 
> We could either do the conversion in kernel and emit BTN_LEFT, or
> report ABS_PRESSURE and see if userspace will be able to handle
> REL_X/REL_Y/ABS_PRESSURE device.
> 
> Adding Peter.

judging by trackpoint history, I'd leave the pressure->click conversion to
userspace because every trackpoint may need a different threshold setting.
"easier" to have this in userspace with dmi matches etc. plus, converting to
BTN_LEFT in the kernel means we cannot use it as a separate interaction
anymore.

That aside, I think exporting ABS_PRESSURE is fine, that's what it's there
for. Nothing will use it for now though, tbh not sure yet how that would be
exported from libinput. but worth filing a bug for, please assign it to me.

Cheers,
   Peter
