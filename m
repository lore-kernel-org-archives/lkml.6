Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELupIcMFYUKwKbHcE7hJ9K3PNhtiu5TPk8zmjba3rr9TAam4TkYQQ63NnedcSuVJ7TcXM+Hm
ARC-Seal: i=1; a=rsa-sha256; t=1520275179; cv=none;
        d=google.com; s=arc-20160816;
        b=FjhvsUUmigFTHNVEzGXuIk4MdVK7N662xvevG78Z3xIzOLWJxSpGR8eW8B9ywXZrQh
         4g3d66SYBap+GV3SRLnkkW7W8nN8seeSZwH1FkkMA6MXyBw6fcBgTMcMVrcIN3QojkYX
         nrPNZUkTxXnR4RDxTma7CXTI0HbQcitiInDENTp9JzdYXUHMSWX4fFNMgnzlAR6a3dJ9
         mmefiLp5r8Un7hn197SwWRzE8v/Ly2W6Zg/GascVJOpVR0ZH316pEo4qwFsWowySC9E8
         UlX+6s0U2odm8F9rNeUfoutSIpwaq46Co75YjqQx56ycOjJKb1ERSbRGxmbB5+bulcyG
         N1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=z5NPp+YWU4jMKBUAMKvrsaxARCTdTQ40an47xKUlDpk=;
        b=Ir1liu2sw8cpNzFMEy9ZU7ExO+tdSLj1/s/2HFeq5kaskLRq0oMuoQAdDwllvZ5+Ix
         IcmgHm38/tPB624XtThMq1kiCrPeCHZwrdC0xHG6jlqkE28CBrqWM1y83sZLHCg1hy6h
         YkVi3URV3ZY8q37vJUE+NT5FVgYdqV4NEACa1fwJhbuOCgSKXixBXBc8Q1cE41F35TB1
         m70cLMLKWBtyBm2zkxcSQ21zITQkXoS+eRRMfjLVVS5lduqpF/XlDBEUQF/YStWaSviZ
         GlZE40dVvb6fdLvhYnVqHStpuAM3qKyPdQJ3m+F1b8DVpFCbzEgWco+M/BHdQJvuVMN3
         CzxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Mon, 5 Mar 2018 19:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Nipun Gupta <nipun.gupta@nxp.com>,
	will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	m.szyprowski@samsung.com, gregkh@linuxfoundation.org,
	joro@8bytes.org, leoyang.li@nxp.com, shawnguo@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Message-ID: <20180305183938.GB20086@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com> <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com> <20180305150814.GA15918@lst.de> <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594124066106268064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's 
> software-discoverable and the only thing described in DT is the bus "host", 
> thus we need the same sort of thing as for PCI to map from the child 
> devices back to the bus root in order to find the appropriate firmware 
> node. Worse than PCI, though, we wouldn't even have the option of 
> describing child devices statically in firmware at all, since it's actually 
> one of these runtime-configurable "build your own network accelerator" 
> hardware pools where userspace gets to create and destroy "devices" as it 
> likes.

I really hate the PCI special case just as much.  Maybe we just
need a dma_configure method on the bus, and move PCI as well as fsl-mc
to it.
