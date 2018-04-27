Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524849339; cv=none;
        d=google.com; s=arc-20160816;
        b=uM5qIrTBAt0bLiGv+KALUYaDKrfDFrOfeTDREolXSWLl8hk5v1PZgZL0eY8lXBG4o/
         IVtBvmu+6EwjGvMFF4V161qhXnPNzDu2GzoSQ04EYzmM4yMDuSiiKtrLIyXOXZgzUsDB
         LO1ebn4v+PtdqLkGlpQvUTO8K5qeryOpQ87xuZzinnZK8X0AJD6N7ciPQ45kx1rTmi3b
         Jak3nqTuesH5LExGH7kbV4/m7cqEQCEGj/4/ULSiqWGke1DRVuOb7q2GaW58bceUjHXR
         Lhun2TOIl1Jm9XXI3umoiUW3GNdsJjzPnhQvGYvWXJCNYFAnhrmKsO3CQG/9cw4P8RZ9
         jpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=oz2SnfSOVpvzeY65JecOcf4RyHGAVGSw6savU8pPNy8=;
        b=vtGSFiqf1avGml05w2HMnOQiKe6wL1GRLeoXM446fe5DMK7zPshr08+8QkQXH4yQSG
         KYoUt3UUGjvlBbuJ9y9Q3+qwULEpRkGOFxqcoSFQgPNvKvNHc28D3Zrjfxq+ZZiGQFEB
         RaQ7tBU2GpLn7yz7l4dnK+USkP/8KN5Pdz9QkaaEZxuvby11fTPgj8eMp6usTvYlEsCY
         9HB0wfVv+rjYubsuTNtj1MohmAIRqv5cvwJ4XD3iB0CeuYCBvOMYJ3s9yTjdRkbL6GFU
         iTGZO90J0qHMizvyKTFzIiQUAK1v/3eQaxVvZVpRgvwK9oQfd2EM+KqzJKYBwtX9qbgO
         Xy9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZodJpe7UyYW6674RaOrvAJLYZpI3BoxKKPaEMkFL4olPi/J4F8ZHkf14oLKVJuV/OZgEHwP4Q==
Date: Fri, 27 Apr 2018 12:15:37 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, hch@lst.de, gregkh@linuxfoundation.org,
	joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
	frowand.list@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
Message-ID: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894771028861343?=
X-GMAIL-MSGID: =?utf-8?q?1598920421146195323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c   |   6 +--
>  drivers/of/address.c       | 102 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c           |   7 ++--
>  drivers/pci/of.c           | 101 --------------------------------------------
>  include/linux/of_address.h |  11 +++++
>  include/linux/of_pci.h     |  10 -----
>  6 files changed, 120 insertions(+), 117 deletions(-)

of/address.c isn't really the best fit either, though I don't have a 
better suggestion. 

I'm guessing this breaks on Sparc which doesn't build of/address.c. 
I guess move it to base.c and of.h if that is the case.

Rob
