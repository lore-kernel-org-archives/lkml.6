Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbeEaIwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:52:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45065 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeEaIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:52:48 -0400
X-Google-Smtp-Source: ADUXVKLz330afP16/cpNR1LY6E5/3MPQfRHduh1j+zz6Sb686rrwmEGsIJXAFllk2sQ1rQSOc7+9/w==
Date: Thu, 31 May 2018 10:52:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/8] gnss: add new GNSS subsystem
Message-ID: <20180531085242.GE3259@localhost>
References: <20180530103242.20773-1-johan@kernel.org>
 <20180530143822.lvtwjvbqe7gvbvgq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530143822.lvtwjvbqe7gvbvgq@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:38:22AM -0700, Richard Cochran wrote:
> On Wed, May 30, 2018 at 12:32:34PM +0200, Johan Hovold wrote:
> > Another possible extension is to add generic 1PPS support.
> 
> There are two possibilities to consider.
> 
> 1. If the PPS causes an interrupt, then it should hook into the PPS
>    subsystem.

Registering a PPS child device is what I had in mind for this.

> 2. If the PPS is a HW signal routed for example to the input pin of a
>    MAC based PTP Hardware Clock (PHC), then it would make sense to
>    model the GNSS device as a PHC as well.  This PHC would be readable
>    but not writable, and more importantly it would offer an output
>    signal.  Then user space could use the existing interfaces to
>    dial the PPS signal from one device the another.

Ok.

> (Come to think of it, modeling the GNSS as PHC would also give you the
> interface for #1 as well.)

Thanks
Johan
