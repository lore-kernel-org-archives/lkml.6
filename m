Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x2242EE6u0TAG3rk5FEf2VzWahvOII8ksoBifPaIaM+1Oxi/1VT5o/ePxlz0cugtsDq+H3VHL
ARC-Seal: i=1; a=rsa-sha256; t=1519762402; cv=none;
        d=google.com; s=arc-20160816;
        b=TaoXbBjN85mm6vIUquuFEzXxLCGAbvOuKkfdR+7ZE6fMOw6SZ2ArQ94xCKT7y1W33N
         KkWpg5EgGfeA/yvAqC85tubBZd7wvDB+Yv7ndZWNk7lZsQfiUxYHkzCEDVV7bkb1q44i
         DPu7TUC/OKkCmDBDmUAJMWs8FuVCu2IK66BDF5BVSda82JqnWb63lhXt/rh7zGvSglgD
         BeOZ+4puRnDZkRdl75lftma3K+VoF+xd/pemINPgvhl1FKRLWoGn8DnBnmnEa7rsCgbz
         Z7RFxGn5lKjTrArZRaVjpwni7a+pdPaRE6hX63QWbyVmGO3gotoZhIH2YYcyeFj/RfS1
         DJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SgTpscWBMeqXXRjwLcNeuxI6nvAFT/QVNu7hgjiR1kQ=;
        b=WshXVxSCgocJeA1Lws+2Vmtik6ZKxO6+NMAWjUEa8OlryLfKGkG8nzB91UXTtbDwOz
         BBaQTsik58ntZPlU91HwwnkoQq0r24ftnw0p0GnC+G1dTfF47T8qv38RhkoxIhiyEWHQ
         dLqkXbly+ojgPU9dT14Y8gX6FpYhwxde3evpT6hJo9heGjJQSk+JTxMl2uibghV1zp05
         amcS4Hmtw4OkA5cf7dXfOx50ZSm3M0Z7PT1J46ytkI6KF6/ut+oxje9Nbs7ria2mXnOj
         TWsO56vrqsCKW86ykOUghNl8AjpJAxE6qGiFc09BxhZCcdv9/C1T/Z5xtzjwhLO56xo1
         V6Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 27 Feb 2018 21:13:02 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Przemyslaw Sroka <psroka@cadence.com>
Cc: Vitor Soares <Vitor.Soares@synopsys.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Wolfram Sang <wsa@the-dreams.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas
 <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos
 <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian
 Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon
 <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180227211302.26f76427@bbrezillon>
In-Reply-To: <MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
	<MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593586381182871287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Przemek,

On Tue, 27 Feb 2018 16:43:27 +0000
Przemyslaw Sroka <psroka@cadence.com> wrote:

> >   
> > >> Either important is the SETDASA for declared I3C devices. So the DAA
> > >> process should start by send an SETDASA and them ENTDAA CCC  
> > command.  
> > > My understanding was that SETDASA was not mandatory, and was only
> > > useful when one wants to assign a specific dynamic address to a slave
> > > that has a static address (which is again not mandatory).
> > > I've tested it, and even devices with a static address participate to
> > > the DAA procedure if they've not been assigned a dynamic address yet,
> > > so I don't see the need for this SETDASA step if you don't need to
> > > assign a particular dynamic address to the device.
> > >
> > > Could you tell me why you think SETDASA is required?  
> > 
> > Yes, you are right... But in my opinion it is required as it does part of DAA
> > process.  
> 
> SETDASA is simply faster than ENTDAA, but only if there is no need to
> collect BCR/DCR/PID of such devices. I think most applications would
> like to have them as an status information so  after all ENTDAA can 
> be regarded as an generic approach (unless I'm mistaken).

Actually, we could retrieve BCR/DCR/PID (and all other relevant
information, like MAXDS) even with the SETDASA approach. We just
need to send the according CCC commands after SETDASA.

But that's also my understanding that ENTDAA should always work, and
SETDASA usage is only needed if you want to reserve a dynamic address
and assign it to a device before DAA takes place. This way you can
enforce the device priority (WRT IBIs). But honestly, that's the only
use case I can think of, and to me, it sounds like an advanced feature
we may want to support at some point, but don't need in the initial
implementation.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
