Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x225QtcB9m1ZSYw8IiF3QiETsT0KaaeotkIOFrHMsew+ReHa4q4uV2odw39nREItQ4X77HDst
ARC-Seal: i=1; a=rsa-sha256; t=1519766061; cv=none;
        d=google.com; s=arc-20160816;
        b=M2SCgzr4GfV3cZzmbJOgqEGZtd+CPS3BG2tjO40BmURW2g64FUsR5s2XclCY+pevnE
         iM0XbQVY11QHF5Vk1GWPOTkNJALalThN4y6bjUPv+dFMUscqYuyIP1ySUIDhDIPZD6KE
         X4obaiuZVPEmbx7769Ql/NQXoD6NCmYiHeDNN+iJpMDLezc8C4vA4CWsuk3tRxTsSnbG
         JWhe7l5dm7eH+vGJFsgtkP5fncjLG2pNeVJZtLl9lrk/VfBlnbUcpFt0R9Fdmx6ceXGu
         IGIKbYl3WQmaPDx6L/hkFm/ND4AGCOeDL410BVUh7Iy6JFel525WTUTl+3k4Ns7S6OLU
         FxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/5EEkiYp/JNtvF0KVtm4VwXNFcxMQTZ5m1a94lu0UtU=;
        b=NXi3M9qXMb0ly8ZOgHmDTzSBvGv1S6myEhMm5BDVH/vZ8W46RwM8Xyi1a3PjIc/zv/
         /LJnJPrUL8XrBU+2dhYpYknNWNWPVZsZuIXEOt+XM1+aKeHrpvYf9mB+/aNJuDrXPIuR
         dT8fzb6cr9LzEtA826KLZWWY6cSUTIAz0fuBaMsPH0sDb9jPJaQmAE1EzLAvTm4mpvSI
         5k7PEzTEttNUlnk0J++1AZ2TSlTSZlrL1kigp4FsCtcbIjKJlxeQWM9vg6gICYYHUluz
         jmIjrRizBujXZ+uTiF1DlvowJKt/3h8Dtaop8NG79NifOmHTzx9jbOlIDWIe+Ylb6Yer
         JQOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 27 Feb 2018 22:14:07 +0100
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
Message-ID: <20180227221407.0cd7f8a9@bbrezillon>
In-Reply-To: <MWHPR07MB278357B74A7D7E31EB109DC5CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
	<MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
	<20180227211302.26f76427@bbrezillon>
	<MWHPR07MB278357B74A7D7E31EB109DC5CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593590217389235534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Feb 2018 20:24:43 +0000
Przemyslaw Sroka <psroka@cadence.com> wrote:


> > > SETDASA is simply faster than ENTDAA, but only if there is no
> > > need to collect BCR/DCR/PID of such devices. I think most
> > > applications would like to have them as an status information so
> > > after all ENTDAA can be regarded as an generic approach (unless
> > > I'm mistaken).  
> > 
> > Actually, we could retrieve BCR/DCR/PID (and all other relevant
> > information, like MAXDS) even with the SETDASA approach. We just
> > need to send the according CCC commands after SETDASA.
> >   
> I agree, what I meant by "SETDASA is simply faster than ENTDAA, but
> only if there is no need to collect BCR/DCR/PID of such devices." Is
> that it is faster than DAA but only if not followed by GET CCC
> commands to gather BCR/DCR/PID. I think we are on the same page here.

Yes, but right now it's not the case, see my other reply ;-).

> 
> > But that's also my understanding that ENTDAA should always work, and
> > SETDASA usage is only needed if you want to reserve a dynamic
> > address and assign it to a device before DAA takes place. This way
> > you can enforce the device priority (WRT IBIs). But honestly,
> > that's the only use case I can think of, and to me, it sounds like
> > an advanced feature we may want to support at some point, but don't
> > need in the initial implementation. 
> Still ENTDAA seems to be sufficient for IBI prioritization but I can
> imagine some use cases where people would like to use it for such
> purposes. Note that SETDASA is applicable only for devices with SA so
> it is self-explanatory that it cannot be considered as utility to
> define priorities for all devices before ENTDAA. 

We have SETNEWDA for other use cases: say you want one of your device to
have an higher priority, you can just manually set a new dynamic
address that is lower than any other devices on the bus (I plan to
expose that through sysfs, by making the address file writable).

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
