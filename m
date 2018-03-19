Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AG47ELuzgWdrIceOwF/75pFRdVQxtzBqsCKPBhNtwQfp0OodUdSWWlK06qH8cACA4NxLvAXhuI6l
ARC-Seal: i=1; a=rsa-sha256; t=1521487407; cv=none;
        d=google.com; s=arc-20160816;
        b=VMIORyO3DO5/pySoSB/FazqM3H8cDi6rWiRO9HYhTgzEj/1g5S1JuFw5vt3f3h1qj7
         rR5PuHOVv6gYNDPvdUQ4SlS+Z7uy0dyZ+D9hHfzWs96dIrhVe04UR43NQgNck2gDDxsU
         tpPn8zYxC6vrpKi8VJtfXdrP//+ILIRiBsHBWbYc7TuGw35+Ea6UW9BgaODqjugoQYjc
         dAU89+OrBt6owigHVYkrRrUn2X2FJfMhSA+3xg0+VZXb7j3QQP93RaR3jm+e5SuYFBcL
         OgK5kGoC1A/pNTo+NkVIo57fTs9Fg7ccJhaRMinAU2xLF/S+nKHNTJ+X4Wk7ejzuAVlJ
         n63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=bldArHm1qmQNPqBV02MHM+AUi6MeD/MsBKCB2oYj74E=;
        b=uf5bnkwo4PnGujZoJJQrshS/6+P+2qwGK4uxvWJ1xcev41U4dJMegamDdfKs1eAsgC
         yWvb4m/VISjnMY33P5q9MNsPoSNT0RqnIorvIjm8YwNfp4rmonOx3kknJGN9TlK6UDTf
         Wzz54oaXHFIbvctGtXBgTaRB7kLHa9X0LhbFPKOvDKtuXobpj1JDImsN2asf5mZJkIzH
         XRxLG8x7uT7Q9eOeZPVWY4td+ilZU/pXmieVy7z7BdQb6Uj/g/q1yWCeh0PwV+jRZzJi
         /DSnS8hww9Su8vAVzjPvhtZGKMo88eZqcuh38Y42qQF0P1F7++b3GlSywHxp6WL8TVau
         ArlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2993420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 19 Mar 2018 14:23:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] MCB Update for v4.17
Message-ID: <20180319192325.GH77194@bhelgaas-glaptop.roam.corp.google.com>
References: <20180312094119.5298-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094119.5298-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594724385482004141?=
X-GMAIL-MSGID: =?utf-8?q?1595395180087464583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:41:17AM +0100, Johannes Thumshirn wrote:
> Hi Greg or Bjorn,
> 
> here's a small mcb update for the 4.17 window. The first patch makes
> the PCI Vendor ID of Altera generally available in pci_ids.h and
> removes it from the two private implementations before I would have to
> add a 3rd one.
> 
> The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
> which enables at least one carrier board. This was reported and tested
> by Ben Turner.
> 
> Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
> to merge these two patches. I'm fine either way.

I applied these to pci/misc for v4.17.  I don't really care which tree
they go through, but it looks like there's no other obvious single
place since they touch more than one driver.

> Changes to v2:
> * Collected ACKs
> * Reworded Subject of 1/2 according to Bjorn
> 
> Changes to v1:
> * Removed redundant pci_ids.h include
> 
> 
> Johannes Thumshirn (2):
>   PCI: Add Altera vendor ID
>   mcb: add Altera PCI ID to mcb-pci
> 
>  drivers/char/xillybus/xillybus_pcie.c | 1 -
>  drivers/fpga/altera-cvp.c             | 2 --
>  drivers/mcb/mcb-pci.c                 | 1 +
>  include/linux/pci_ids.h               | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.13.6
> 
