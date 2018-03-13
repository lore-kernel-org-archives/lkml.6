Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELuOyf+i/yNnmnh77U1bv/J6Ui5xJoJZi7GEMVSboJ1+U/rhFy04mCOkisfe3o0QjoGk5jKr
ARC-Seal: i=1; a=rsa-sha256; t=1520956803; cv=none;
        d=google.com; s=arc-20160816;
        b=wEiOgKn6zPSCs8cDe+O0YUTwM39TxXFASdgudR35Rk8GD+SaOxbpNYK5W+bK3LiF2J
         y832q3P4CaxgjlpImE7yLjW2bZopeuWEhdzrhOi9Flab9xdC0+8trSJ7VkwRCCvbYUsH
         bv3Tu2gQLszcpjQQc4mHo7sNHFSEoBp4ArPdn30girhJTKgrxzxRwkLc81AGWRf/RRGI
         j89NFWtrUTKEfzKWfas2868nWrCVQfmjeNAsfTVmy3Q6aYTJa5b1ds0u2GGJJfPtazOA
         Na/j7Vta+259V88k2QjJtozpNdgQ0GnK7xLppH2IVmv1RbuGEA7nEKXIppEVvDwJA7wL
         e+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Oe4DBT7yidfw/ZaBFlO66nFu3W8W0WmsIqJxD+bBeEg=;
        b=WqUdlcFwpAeSYOFAkyGCZ9zfkLk6d4BKDc1ROQ+GEOzcgszCSkxGf4wioFuz7BQ7vK
         dMfQQBZ5wY7+2+7n0MH3gQAHOGVedgMHWuOwhNHff9IsrZrJsxbqg8pxlIfTwl4/FCju
         XdD9UPKjyQ0so1Tkg8CEzssTnmA3T3m+lvfatR3dLOUKmkshZmVzGl4Vaa7OSWOKw7mi
         1guNttRTq3MQL4kljS/sAN1eb76m1qo94s9DEt8SXZfxO9ig6HIZfw2jYdMxAMx6TJ33
         +mRsXSuLnMaBkTXNl4acEt2AK1nbrc4rKz/NepXYU/0F16iwYiQ1T23HjZiRGH7tEajP
         k3XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=km5NR5eg;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.87 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=km5NR5eg;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.87 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus	infrastructure
Thread-Topic: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Thread-Index: AQHTup3FkFIBngAtkkaazewP28SrhqPOT3wQ
Date: Tue, 13 Mar 2018 15:59:58 +0000
Message-ID: <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <20180313073448.GA32269@lst.de>
In-Reply-To: <20180313073448.GA32269@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [182.68.81.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2425;7:mWbkekwM6tGVCoWPPoGJFIUCItvxOkDKy63tiIu51WdtEZk9W2deUu4i9+MHUc5r7kqLm81pgFytP+JCXCMaPZPBj2/2yaOPCpS0SNxYEpPnL1TNBUciF3jAbLwsL0IYxJSiV/VTBVUj+q5eHk+MR5Ot/64RgDX5LTWjA0clTrFhKokkMOzG8rZbcC6cILku0b15W4SnSwccH0+TdnPdZsFnkq74aszU+o7B6bW7S8yVh2Adu4btzb4W+HbEjA8h
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 116337b7-14e1-429d-694c-08d588fb78b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2425;
x-ms-traffictypediagnostic: HE1PR0401MB2425:
x-microsoft-antispam-prvs: <HE1PR0401MB2425BF0EC291C0E9FC908577E6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(366004)(189003)(13464003)(199004)(54906003)(5250100002)(97736004)(33656002)(66066001)(106356001)(6506007)(25786009)(316002)(6916009)(2950100002)(2900100001)(39060400002)(81166006)(81156014)(4326008)(8936002)(3846002)(6116002)(186003)(7416002)(99286004)(305945005)(7736002)(229853002)(74316002)(14454004)(68736007)(7696005)(105586002)(76176011)(3660700001)(3280700002)(6246003)(102836004)(53936002)(26005)(5660300001)(2906002)(86362001)(6436002)(478600001)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: L/SnN9wrqujCxwXpcWERJ9yUtyv+pbvWKW8t0Mu/LzsKaLfTtUHwHua+i4jEEXIoCUppthCg1HDm5VYwHFE223CDKyCPlAXFdGOMPQuy0BsJb6HZ/pUAOsar3UVlFZeYPZqgtwpWuC1eKovbJYarDG6xvYS0wtei/+hp4YXxBDseLFBABln9EMk3+xLbttEyAvu544QmKMlK2ngIwsgfgx6D3hc6Rf5EFk6e98+1aI5W8FBn+Q5/u61rPNvFFeOqk4165LJzOSFkfd6vRfYDhDOk6VHBP5IRnKp7DAGIyZQd8RZPD3VLWwcm4PwjQrSUXUoH6rHxbBk4mzQfGza/XA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116337b7-14e1-429d-694c-08d588fb78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 15:59:58.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594838800613032703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Tuesday, March 13, 2018 13:05
> > +int amba_dma_configure(struct device *dev)
> > +{
> > +	enum dev_dma_attr attr;
> > +	int ret =3D 0;
> > +
> > +	if (dev->of_node) {
> > +		ret =3D of_dma_configure(dev, dev->of_node);
> > +	} else if (has_acpi_companion(dev)) {
> > +		attr =3D acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> > +		if (attr !=3D DEV_DMA_NOT_SUPPORTED)
> > +			ret =3D acpi_dma_configure(dev, attr);
> > +	}
> > +
> > +	return ret;
>=20
> This code sniplet is duplicated so many times that I think we should
> just have some sort of dma_common_configure() for it that the various
> busses can use.

Agree. There is no good point in duplicating the code.
So this new API will be part of 'drivers/base/dma-mapping.c' file?

>=20
> > +void amba_dma_deconfigure(struct device *dev)
> > +{
> > +	of_dma_deconfigure(dev);
> > +	acpi_dma_deconfigure(dev);
> > +}
>=20
> As mention in my previous reply I think we don't even need a deconfigure
> callback at this point - just remove the ACPI and OF wrappers and
> clear the dma ops.
>=20
> Also in this series we should replace the force_dma flag by use of the
> proper method, e.g. give a force parameter to of_dma_configure and the
> new dma_common_configure helper that the busses that want it can set.

I am more inclined to what Robin states in other mail to keep symmetry.
i.e. to keep dma_configure() and dma_deconfigure() and call
dev->bus->dma_configure from dma_configure(). Is this okay?

Thanks,
Nipun
