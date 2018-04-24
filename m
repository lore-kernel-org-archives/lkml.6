Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AIpwx4+0R4LHfFYn7SrP3e5/5mwbpZyYXTjqw8+xMy7uj3RajiuEqhMKwbA/sXi6XJJveq6vUGvE
ARC-Seal: i=1; a=rsa-sha256; t=1524599061; cv=none;
        d=google.com; s=arc-20160816;
        b=NDDN41U9a84/gbumaQaqHoi3qKiQe3viD8Ovj7iOG9EehGtZ2uxPGm2xlBpbtafAps
         LNFFr/nvxEGAFcxoiuVhQB0lypC59xGd3WGlTxvopkM5Odm1gcnVAoudLhjds/cfSWAr
         02Bp0ZdgWs1fTaS7vdhQ3FvQvJZLa8KTskM5on450JZ9DDPqnMipWYiKk956DyuMgdsg
         Wm6vBb8oQIF5ocX1oZmZYnRhIvLrKQnNoPPztJTCnnCpUahGBF/Jv96zfj2v4xFi20Qf
         Fl79VHDzPFvF4Z0o+pJY2cdFh6fbSdpymvbBGElWUqZPDN/+pHneU1E34BG6Yq5Tzp/v
         iuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=eiX50jg7GVF50Y13JE0BvrkdDETuenub7xGKuYDcu24=;
        b=LS0VvobRid78m6js4KQy6/R2GZbslLBKEOFcAdxG4/zAS6qGBixLR9blyZsR6lYc70
         nIuswnAXvtXCvE9w8z3DpbM0uARmXAkY9EGPN2fEjGvZ2eY7FKbSttfUq8NPFqCZuiMD
         6wPamii5+z5/XYHRcJhAoYSZCemZqhPmAPbGkIjngm2p4wIs6xbgFZiKAvWIZFz9z8C5
         VoVBDHoDmqsCHie4CHe2uLS1OfKKXSDv+FZHZQCGcI3r69RVa82Yi77lOc5v+im9dyxz
         2nrk4qPna8OWz4U440voGadY6GnFEgYF0pz2ec6bu1e5qiVQ3N06w5PDiV7KERgwhwcn
         miTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=q2KsZsFB;
       spf=neutral (google.com: 2a01:238:20a:202:5301::3 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=q2KsZsFB;
       spf=neutral (google.com: 2a01:238:20a:202:5301::3 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiv9N1ED6Y
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180424175050.GG4615@localhost>
Date: Tue, 24 Apr 2018 21:44:08 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Arnd Bergmann <arnd@arndb.de>,
 Pavel Machek <pavel@ucw.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <8F4FAF5B-AAA9-4D46-A022-99B96C74ABFA@goldelico.com>
References: <20180424163458.11947-1-johan@kernel.org> <31CF06C6-D6ED-4930-8D81-12256A518059@goldelico.com> <20180424175050.GG4615@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598657985879524721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Am 24.04.2018 um 19:50 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Tue, Apr 24, 2018 at 07:40:00PM +0200, H. Nikolaus Schaller wrote:
>> Hi Johan,
>> 
>>> Am 24.04.2018 um 18:34 schrieb Johan Hovold <johan@kernel.org>:
> 
>>> As proof-of-concept I have implemented drivers for receivers based on
>>> two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
>>> hardware these have so far only been tested using mockup devices and a
>>> USB-serial-based GPS device (using out-of-tree code). [ Let me know if
>>> you've got any evalutation kits to spare. ]
>> 
>> Ok, those drivers look nice on first glance.
>> 
>> BTW: I have refactored our w2sg00x4 driver into a gps-core (still creating
>> a /dev/GPS0) and a driver using a common API.
>> 
>> With that it should almost fit by coping some lines from your serdev based
>> device drivers.
> 
> I think it should be done the other way round (if I understand you
> correctly), that is, by adding support for configurations were WAKEUP is
> left not connected to the sirf driver instead.

Hm. Yes, the w2sg00x4 is a Sirf based chip.

> I had that use-case in mind when implementing

s/implementing/reinventing/

> the driver, and some ideas of how it should be
> done, but did not get around to actually implement it yet.

What do you need ideas for? We have that function working and
submitted year after year, but it was always rejected for API
reasons.

You could have simply reused what we have proposed [1] and just
adapt it to the new API instead of writing a new driver (which
is missing some features for us).

"proof-of-concept" is misleading if you expect this to become
*the* Sirf driver and we are just invited to add some features
to that. Making our own work and proposals completely obsolete.

What I find really strange and foul play is that we are in the
review process and then comes a hidden counter-proposal by the
reviewer.

Well, this is FOSS...

BR,
Nikolaus

[1]: https://patchwork.ozlabs.org/cover/843392/
