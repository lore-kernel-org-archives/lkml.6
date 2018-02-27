Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELtUIMfqAoKkjh9QnmhI4AnAkGjZnCct9jcCMsFZ9GNed9CrkpNH8qOy27DfgORlWWXDvvgT
ARC-Seal: i=1; a=rsa-sha256; t=1519763129; cv=none;
        d=google.com; s=arc-20160816;
        b=pa4Hel6JOnq9bj5Xb1wua78BXhaU/yYDzFqlLNL6kD3Laz6Us5BQ+1b9OItoNxtoC8
         5ulJcsTnFyA77C9iYjzNrNHgmzJUF5XjfwvFV/LI/StQFCRTkBWGoq12JGCpYeVkU0q6
         Xa88EGVgBveBQbIfnvbktsIKsYaSiJbyfQSCUk1L9oD53DZbYJFvH4YlEi7EjavVJcOK
         Vj3z+j3MUWlaWjauj2L2O5233E+Sj4qXiw7X0vhX0l5QYSybavIJwmW0jyxuue4oIHLd
         5lbOKvJ78SOA4tp1jQOJmviC5bYN3yLmkbFIwx99Eg62LsMurCv6PHG6AH5GMcVw6Wz1
         UbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=d0y8RrxXX9cBJ3gVuRLSbPySinMrYMnL7qQaA8Z19aU=;
        b=vnAwhx4CRwEmesxfePkYWOx4EnqzvkKOf3PHiuqY0CBp6iZZbzrmbEQxTWjhQaB3O8
         p3fsLCrjcKTkrHCO+G4fX+Ggk/YJi/QLYsaTYAv1X2QB+vSl5xBv//EN6E6X0CWCu+uO
         TTWNbp/6if9ASES87v65aYQxsTQbB5dJDhPv9rV3TNyyDo2SGoMFC+GIwB1FExu3KBHA
         EA5/a6tLdIR+lF1TXudqaVItba38L1moT/dhO/wQozPdvjr2uPFqggL9+zM2JyyIHGAk
         vRMx4bxol2BEuIeHJ1yKFI3Xh0duxk30iNqqvX2A2ltQ+tGYvxnDkhu7jHNA0njbOorP
         Rpjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 27 Feb 2018 21:25:15 +0100
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
Message-ID: <20180227212515.3a22524a@bbrezillon>
In-Reply-To: <MWHPR07MB2783B91A8600A18014178EB2CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
	<MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
	<MWHPR07MB2783B91A8600A18014178EB2CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593587143405156875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Przemek,

On Tue, 27 Feb 2018 17:06:37 +0000
Przemyslaw Sroka <psroka@cadence.com> wrote:

> > > >
> > > > Could you tell me why you think SETDASA is required?  
> > >
> > > Yes, you are right... But in my opinion it is required as it does part
> > > of DAA process.  
> > 
> > SETDASA is simply faster than ENTDAA, but only if there is no need to
> > collect BCR/DCR/PID of such devices. I think most applications would like to
> > have them as an status information so  after all ENTDAA can be regarded as
> > an generic approach (unless I'm mistaken).  
> 
> Below are 2 examples on how DAA can be executed:
> 1st:
> A1) SETDASA to devices with SA

I'm not even sure all devices with a static address needs to be
assigned a dynamic address with SETDASA (actually, I'm almost sure
it's not the case, since, according to section "5.1.9.3 CCC Command
Definitions" of the spec, all I3C slaves have to support ENTDAA). To me,
it looks like you'd want to do that only is you really need to reserve
a specific dynamic address and prevent the DAA step from assigning it
to another device.

> B1) DAA to remaining devices
> C1) GET BCR/DCR/PID to devices that initially had SA
> NOTES: C1 is optional and order of B1 and C1 can be changed

While that's true in principle, in Linux we'll always retrieve
BCR/DCR/PID (and more, like MAXDS), no matter how the device obtained
its dynamic address.

> 
> 2nd:
> A2) DAA to all devices
> NOTES: no need for any follow up steps as all information is collected during DAA

As said above, that's not exactly how the Linux implementation works.
Right now I'm ignoring the information retrieved during DAA and forcing
a GETPID/GETBCR/GETDCR for every discovered device. This approach is
generating a bit more traffic on the bus, but it also makes the
implementation more generic, because we have a single function to add
an I3C device, no matter how it's been assigned a dynamic address.

> 
> As we can see 2nd approach is more generic and do not see any reason to add special handling for SETDASA unless there is any reasonable reason to do otherwise.

I agree on one thing: as long as you don't have to reserve a specific
dynamic address, SETDASA is not required. At least, that's my
understanding.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
