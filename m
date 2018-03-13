Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELsC855muxMr73Aibk6D1kE2n84RH2VbNwRciiIcerOqicUlIWsHqz//K7pEu6YDgVIpsG0V
ARC-Seal: i=1; a=rsa-sha256; t=1520926048; cv=none;
        d=google.com; s=arc-20160816;
        b=f54m2KatG5AvOuO66+z7OMg9s430oOMGiwvNbGNlli19NVwguw6h6offfs863iWod5
         EC8s+L9Qhg6374piqzZ33N9qC9PQvhALZOMxrjKGL1j5o39Q8lT0RtSfgDTSnCoQTPUO
         wLpr34yCU57xuZwAKV2LUMgJziSdshBFhs9xunXEoQh1OspbcBaTAy8zoCSZWnYg1d0c
         Sgg/oMHRXmZIAT7WDJj8/1Pmt4rTRWPdWjq7nr9ZkqQGdFOzeVTo4Hh6dyUo28EHEdzC
         hujhejK4jVxqJCIG+BDB7ikQDpYqtF6np09XyYzbF9ZpGjl3t0YU8dE+hT1zIucTPSrj
         n/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=3R2hAeVQOlSxLgdFuATQ8cSNflDigwlFv5YYwHsY58I=;
        b=iPnQjdg++Mcmk9M564c27qzoZ+ddSoFL30i96bG86WiTajxj7tmV18N7k5vaM8JB32
         mUe1Zywx5eAZjHGdSSgatQEEBNPXdtZBs5QcD210M1/m2t9mGwaVvoP7An4FwBbjTOqL
         atDvdMMc/eZnj8TREYvN5/plQsjbTju4ZvwFjfIlZuKxLgxQfaMYwZMKxxVUxi8n98Pk
         ooBTNJhT8vbf7hr1SWifs4MKKISJFidZpm6RwJQ/D6UtzAEKpbeQjsLX1iegPbsJlldr
         8txai1bbGSa3cSHiQl5IXm8HhIJLwddKgkhAI07Bkp+crCz0HhEcWk04kDoQRPBNZ23w
         U/3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 13 Mar 2018 08:27:28 +0100
From: "hch@lst.de" <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, "hch@lst.de" <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"johan@kernel.org" <johan@kernel.org>,
	"msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bharat Bhushan <bharat.bhushan@nxp.com>,
	Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180313072727.GA32191@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org> <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594806552985527781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:22:53AM +0000, Nipun Gupta wrote:
> > Isn't this one or the other one but not both?
> > 
> > Something like:
> > 
> > if (dev->of_node)
> > 	of_dma_deconfigure(dev);
> > else
> > 	acpi_dma_deconfigure(dev);
> > 
> > should work.
> 
> I understand your point. Seems reasonable as we should not expect
> the 'of/acpi DMA deconfigure' API to not fail when they are not configured.
> 
> But, here we would also need to get dma_device (just as we get in
> 'pci_dma_configure') and need a check on it as for PCI there 'of_node'
> is present in the dma_dev.

Both of_dma_deconfigure and acpi_dma_deconfigure just end up calling
arch_teardown_dma_ops.  So my preference would be to just remove
of_dma_deconfigure and acpi_dma_deconfigure and call arch_teardown_dma_ops
as a prep patch before this one.
