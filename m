Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELvtED3IQbJgpFSdXqpERYzKIXH+5NLOfNhQKoTuTM05ksKGLPUZdliriOWZfe4l6Skmw4fB
ARC-Seal: i=1; a=rsa-sha256; t=1520494875; cv=none;
        d=google.com; s=arc-20160816;
        b=kz9O4CZeeloWkosDF/b+yAxyfB5ddh68vmJzhAuc39x42bKUWJZNdW7vHwZCSvdMEJ
         Lsf+bYOEFRmYeX9k+gXtFPF8qyB933OqU6A2DgYQU2jlS7eyT47afOKUXptw1gJetw+u
         HlszBTSKgvswH1hKT5ijRDjaEPcj1kESEJAfZmHd7Jp/gisu9LyIOWME7pZ+hOH/YJLW
         rL4QCH+HgKYbvl3bsHR5DWwUkpedmcMfEOgcMX6HpZPLn1ItGS19kRTMALQGVLnJr9cR
         8b1iQXNA3xVHTtfXRp0+Gt14rifDFYcbve+be27Ro0JGkhl45DxYujHepnLYEx4s39CG
         PR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jy+etPI/Jvo0mRrkQatW4H3CeY0/7MnDDyigwYukgRE=;
        b=fr1PnWSNs73rryj0n6SH9Xzw/8zOioC9xS4awjh7VO6eMoRgCLWJTA64K8AkcaANUW
         j8xaDQl4OnofhfI28h/g9NPwL1CLbTqpXT3eLVbPTx/eSdOBN1/9wdRenw+M1iQvQWwv
         dkSvTyqZOIUhat0pALaAQcZTstKyVJRvaPLSk24oVioCyfl7MReOi8czK49ZMuxkNH2n
         mSpBEGgWGdXnrpqpMzBitlVx0tGAGH9lh0ZpYDHscw720DtuzoP5MVEbGoIBnGQc8oNT
         loXfrI00ILg9+gCtfBeVRWObMTR4Xyv7DVhDjW3bqb4AdIt3NyMnihSvmtxR5BqlV6IC
         bvUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 8 Mar 2018 08:41:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joro@8bytes.org" <joro@8bytes.org>, Leo Li <leoyang.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Message-ID: <20180308074115.GB15748@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com> <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com> <20180305150814.GA15918@lst.de> <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com> <20180305183938.GB20086@lst.de> <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com> <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594354434776994658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
> Sorry for asking a trivial question - looking into dma_configure() I see that
> PCI is used in the start and the end of the API.
> In the end part pci_put_host_bridge_device() is called.
> So are two bus callbacks something like 'dma_config_start' & 'dma_config_end'
> will be required where the former one will return "dma_dev"?

I'd just use dma_configure as the callback.

Currently the of_dma_configure and acpi_dma_configure are only used
for PCI anyway, as no one else sets a non-NULL dma dev.   For fsl-mc
I suspect only of_dma_configure is relevanet, so just call that directly.
If at some point we get enough busses with either OF or ACPI we could
create a helper called from ->dma_configure for that.
