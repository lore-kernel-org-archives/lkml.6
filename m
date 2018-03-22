Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELtLfasnuxFpa/k+Y9NOcfKDc62queu4ldRS8gBwUShaTrZ9GpCcpZMq3WwZN0VPE/42JeIQ
ARC-Seal: i=1; a=rsa-sha256; t=1521706625; cv=none;
        d=google.com; s=arc-20160816;
        b=oimCxszIKoaP7Amfnywwgm7F3h93Xf3LEfWGKtMGTgsvA/+ddwyDea32TiujZZU4iw
         1K0KfnhBiRx6fpnhblkQXYnA2kdHnI8oreBnkRwrLcvG0ZolLM8JNaQWB2cGYjU3z/m3
         7ZPWXTNE9B8cEXd4vqh6cD3EHRvgyXVaqInZncOZq0QxgMfM6uRqNkG+/UXnFaqzf4C8
         mA6mfZxCJ5tADBSO5javYD1rkPZkUs1NJkhpCX7BeQigNFE7ZzW3zJItXN8658etcybq
         HqV0YOYXQtgsjyeCnHZmVZjSUR0hVrmo6/Pk1DLq8fKUHKmTzwvhOT+dL9A0bzL6W3y5
         QIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4GJdulOvPTeJpCVtnq9feKFUwtSvS/B2NAd2/WLAUAk=;
        b=Dv7QHnudX90DyI3P+eFl1LltGR6xOenqKvT6AAqDnm806fa4TqD/9i8ys/kimuB8mv
         wic6GRA9PWOI/KRDOV2frfSrek5IGMvJhLaHqb+YlsMBdD3f2e+bw+c/AS5h765+eOIv
         /Nu7/Fyz3VzyXNTucxJ/6bDRFyKnaptMjudq4LCoD7z25jgz47kY9U6mhc5BAcnSNksl
         iGZlk0Bmn7PlqshdNadSytCb2Up8//3R/hMLmu8Zfmh9SZhT0XEQY6bq4mufWzzrw37Q
         wvbAtqXW2z8pScGcCnnPx6Qh2zN8LnFkru2seElby/V40r3KMFeZP9GAKyd1mDpzUMgi
         wjLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 22 Mar 2018 09:17:05 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bharat Bhushan <bharat.bhushan@nxp.com>
Cc: Nipun Gupta <nipun.gupta@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"zajec5@gmail.com" <zajec5@gmail.com>,
	"andy.gross@linaro.org" <andy.gross@linaro.org>,
	"david.brown@linaro.org" <david.brown@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"vinod.koul@intel.com" <vinod.koul@intel.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"johan@kernel.org" <johan@kernel.org>,
	"msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180322081705.GB29444@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com> <AM5PR0401MB254503027680DE6A23355D909AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0401MB254503027680DE6A23355D909AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595625046785376111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > +int dma_configure(struct device *dev)
> > +{
> > +	if (dev->bus->dma_configure)
> > +		return dev->bus->dma_configure(dev);
> 
> What if dma_common_configure() is called in case "bus->dma_configure" is not defined?

Then we'd still have a dependency of common code on OF and ACPI.

On the other hand we'd get free OF and ACPI dma ranges parsing for
everyone, which might be handy.  And which would really help mitigating
the risk that we missed some bus that gets dma configuration from OF,
so maybe it actually is a good idea.  I'd just rename it to
dma_default_configure or similar in that case.
