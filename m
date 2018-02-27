Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x22429rYEdZieZoWN8CA+ZMGe6O/cxSSeoCsDNGjU43p19wx9NwfrrWrS8U/AWpBoslxZQf+S
ARC-Seal: i=1; a=rsa-sha256; t=1519746128; cv=none;
        d=google.com; s=arc-20160816;
        b=u1PoBuHSucV8YBM266afBukYPrwa/1nBD5hC1zduoFC1jB1/dxtwi0iQLopxUYaf+i
         p3oVJnJgcdx5C0G7lZ+apOSr8/hfIV01f0NIwaXSjWfHpLCCO7ru1WDzbQsEdjssTZZo
         14zJtGzrGTxSK6PBEji55y2caNIsIqGaDlRBz8TcnW+URfVs14ZJvfnSZf2fptvWV5br
         qyzxwjMqrFSorD3NuGl40QPypSmqpo+3gzfUul/w/dODbe6EIfP4PPUqBEY1uAQ/rFge
         tizb1umqLsxjuxDG3/hKaIsLCQh6w/+ckdOk76VsrRxyhSceLGSTCcCNTLac115khvXb
         A4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=6V4GhHXhsrGCzqJL3+lzfLqHyuITmBwDbtyOxwe0WoQ=;
        b=v7jYScRxLh6gwZwBUN8L03+/W77CSmbLtXW3DcmA9BcC0VRpAvDllKpYeFnjf5PYTE
         9OdLj42WmDrg4oQ36EgoKPeZKWxVbvsFdJuk3d3suzgoHX4AAGEeczBwOW/4ZD3S3rS1
         C14uYPl9mbbOnX9FeIyPKVNN+8sshGZYxsw5d7krYb2kXITXhMXLkP8278+thssWCAzn
         DhtLK5DsfcooIkmlKN4PELx1vu9zu5se3xgHpdJ3qOwF0f1xJfY0w3NiR9fI2svBU43s
         9pbCAcHj7eV2I56vaprk6Ljao4pOpBKNp39Jpcz4nr8CbW/VAGOoUwvNhksNkUVht1XV
         PP+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Message-ID: <1519746127.25526.25.camel@suse.de>
Subject: Re: [PATCH 1/2] PCI: add vendor id for Altera
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailinglist
 <linux-kernel@vger.kernel.org>, Michael Moese <mmoese@suse.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Eli Billauer <eli.billauer@gmail.com>,
 Anatolij Gustschin <agust@denx.de>
Date: Tue, 27 Feb 2018 16:42:07 +0100
In-Reply-To: <CAHp75VdwHZxCzppayKaLdGJ++QKTKnZWwfHXOJ_bhMVHOJCu1A@mail.gmail.com>
References: <20180227133018.7732-1-jthumshirn@suse.de>
	 <20180227133018.7732-2-jthumshirn@suse.de>
	 <CAHp75VdwHZxCzppayKaLdGJ++QKTKnZWwfHXOJ_bhMVHOJCu1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031161649636?=
X-GMAIL-MSGID: =?utf-8?q?1593569316456963824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 17:32 +0200, Andy Shevchenko wrote:
> On Tue, Feb 27, 2018 at 3:30 PM, Johannes Thumshirn <jthumshirn@suse.de>
> wrote:
> > 
> > Add the Altera PCI Vendor id to pci_ids.h and remove the private
> > definitions from xillybus_pcie.c and altera-cvp.c.
> 
> > 
> >  #include <linux/pci.h>
> > +#include <linux/pci_ids.h>
> 
> > 
> >  #include <linux/pci.h>
> > +#include <linux/pci_ids.h>
> 
> Isn't pci.h includes pci_ids.h ?

It indeed is, but it won't do any harm and it's not quite clear what the
general policy (regarding pci_ids.h) is, some drivers include it (even in
the drivers/pci/) some don't.

Bjorn, any guidance from your side?

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshi
rn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH,
Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham
Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600
D0D0 0393 969D 2D76 0850
