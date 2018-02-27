Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x2250f4lTQz3HJy9CiU+W7ueB1wlCYPVuClpHErNMcnb7t0vCyIbGXjWUgnUSPjnEQ0HCCs4o
ARC-Seal: i=1; a=rsa-sha256; t=1519753170; cv=none;
        d=google.com; s=arc-20160816;
        b=lMgBo2C0W8TH8zkL3duNBaFHvuLZwYB7c/E0ZRhcBlno8xhB1mSPCeyVqXplz6dduf
         d+JYOA+1HZDcigHtCZRDBCNZU8z/BXaj71kVtozO0HV2Y0TvRAXdCLzJ4q9sdAqtJ8Vy
         M8CWk64Ip/tW2FY3lrgwF0HK8aPEAMBgM8uLAXsoqNv/XClghv5xnL/prOsoSOQxhP2W
         UD7ANZsKMXX17H4e/JD1lWK98Pm+xaksrwQSlIZkrWXOhu4Uh8SDBtYm55diOY/oC6+d
         DiSLgfvyH/tC3dK5dlOAbPQFa6ul0Cw5c5YMb6E2InJexWbTmi0MBD/ABC/lrEsnVCa/
         iVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dmarc-filter:arc-authentication-results;
        bh=RT3pwe9cLra3McKYFsUTOJExCfJsN12Vwu6PP8OWsNg=;
        b=wuQN3ZEuylbz5O2OlfU4/uKW/Je7aKHGIZdhfsEjN408VxX+6qf7Q4m4V4MVztafUJ
         fN6ELB1XStPfuCc4D8OhmW4IPiNb6ito4J+v6nDQArzdOWgV7mGjNU9x0qN8lIiu/8V5
         ovQi+iGAe85Iu58+3xP0mOPx6+Pqxv+PWbuBxZWGZ3LoGBrAOwqe18ZdV3tMbXokHQGH
         JjQ0ULsD+h3MBMKEgHZgRgsgSPK/pQ3csR9SrjK6Pl885haYIlH8R5cnzDfE1Dcf36rN
         gehfurGYNDFr5yWfY6FWmi0TxPr1+ZgW8yw12Uw08ONpahETan72Cv0/X7i2a03U7Vvp
         hQeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3D221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 27 Feb 2018 11:39:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Eli Billauer <eli.billauer@gmail.com>,
	Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] PCI: add vendor id for Altera
Message-ID: <20180227173929.GA127842@bhelgaas-glaptop.roam.corp.google.com>
References: <20180227133018.7732-1-jthumshirn@suse.de>
 <20180227133018.7732-2-jthumshirn@suse.de>
 <CAHp75VdwHZxCzppayKaLdGJ++QKTKnZWwfHXOJ_bhMVHOJCu1A@mail.gmail.com>
 <1519746127.25526.25.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519746127.25526.25.camel@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031161649636?=
X-GMAIL-MSGID: =?utf-8?q?1593576700518130958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 04:42:07PM +0100, Johannes Thumshirn wrote:
> On Tue, 2018-02-27 at 17:32 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2018 at 3:30 PM, Johannes Thumshirn <jthumshirn@suse.de>
> > wrote:
> > > 
> > > Add the Altera PCI Vendor id to pci_ids.h and remove the private
> > > definitions from xillybus_pcie.c and altera-cvp.c.
> > 
> > > 
> > >  #include <linux/pci.h>
> > > +#include <linux/pci_ids.h>
> > 
> > > 
> > >  #include <linux/pci.h>
> > > +#include <linux/pci_ids.h>
> > 
> > Isn't pci.h includes pci_ids.h ?
> 
> It indeed is, but it won't do any harm and it's not quite clear what the
> general policy (regarding pci_ids.h) is, some drivers include it (even in
> the drivers/pci/) some don't.
> 
> Bjorn, any guidance from your side?

I don't think it's necessary to add the include.

Please cc: linux-pci@vger.kernel.org in addition, since that feeds the
patchwork I work from.
