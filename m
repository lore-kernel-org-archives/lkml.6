Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524592256; cv=none;
        d=google.com; s=arc-20160816;
        b=O1iMNVaxaoJSLbBj8DRGq0c7tFhOBz/EQytBA2go3XU2fzacJv/DDyxe0wl5uUPe2E
         omMc5XD5R5p8e/+RG9rzIojh7gX4Hzxet1kdPtVpjD0CEb+aQd/9isMiZM379PZUFYfC
         SANVt2Bw9NxjRoRVLkkCyr7tHzwxYbByyNKGtekG8cYPQNZ4jGIrajUquKULhFZbajFb
         InpoaRLA7HJmCEfI9FGd0JPsC9/AaTzQJNPeVpFDPqnSDvUZvJzc6ObGKLSUl+Tj2v3f
         ccx2log7OQyHhL21ZRQDEl25q4BY0CA8N0zWtFhIJ+2rzZnFM4v57ldzNWdzBaeq5Kqh
         lUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=9rdA5RKRe1r30+h/g5ZMu5UQ+SpVsb7QKTlNqWkj1zA=;
        b=oj64yFITusT891RhBkPX0CNp1B4UZYD3Tb0KWiux44mHoPvTt5JxaUWQ6we3Ha6BdI
         Djfy2XuObXbSHwC8WkiCDWs2vu/t6WjsL/g7WugPU0Zfc2CaIyoj2bL3Cb2off7FgclK
         j3CNt4hhhz+Tv4hYYSkks7jluZ0X3zdCiJ+zKRBZ+puH3p5Orsr23eP94NP68g3xVFNo
         FLZuSvLG7v78GtSQgcihdg8UoZdo9kHcRwNk3Gi+hUREK/++FSX8zH8qPTKUZJGbNm1x
         I0FSze7qODkxgwuSn4j+TYO3iF6Me4l1QLvupO1y/KFFPH40DKrDBLVKcGyfvFs/wtMM
         v1/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oiyVr7vA;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oiyVr7vA;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZo67/7nUFWL1iTcHO6QobpegHwHYE6ma8y22/W/OMgCoZf9ov1n5AEobaO6sXwd/WiGT8Aqag==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 24 Apr 2018 19:50:50 +0200
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180424175050.GG4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <31CF06C6-D6ED-4930-8D81-12256A518059@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31CF06C6-D6ED-4930-8D81-12256A518059@goldelico.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598650849700329910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:40:00PM +0200, H. Nikolaus Schaller wrote:
> Hi Johan,
> 
> > Am 24.04.2018 um 18:34 schrieb Johan Hovold <johan@kernel.org>:

> > As proof-of-concept I have implemented drivers for receivers based on
> > two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
> > hardware these have so far only been tested using mockup devices and a
> > USB-serial-based GPS device (using out-of-tree code). [ Let me know if
> > you've got any evalutation kits to spare. ]
> 
> Ok, those drivers look nice on first glance.
> 
> BTW: I have refactored our w2sg00x4 driver into a gps-core (still creating
> a /dev/GPS0) and a driver using a common API.
> 
> With that it should almost fit by coping some lines from your serdev based
> device drivers.

I think it should be done the other way round (if I understand you
correctly), that is, by adding support for configurations were WAKEUP is
left not connected to the sirf driver instead. I had that use-case in
mind when implementing the driver, and some ideas of how it should be
done, but did not get around to actually implement it yet.

Thanks,
Johan
