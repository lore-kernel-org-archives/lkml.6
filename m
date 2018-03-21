Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELuifQzKOZ+ZB6XxaK5y+a4tD3X7Ran21Uhy+4gIfggYm6Z5+3f1xj8pnpFsmrzKWkORx1jf
ARC-Seal: i=1; a=rsa-sha256; t=1521648825; cv=none;
        d=google.com; s=arc-20160816;
        b=k/ymcBf8X3X+htcz6W0Q1cJtfPL6sI/r6V9RhiHzZI9chBB+rmaa9/CPVsdyMhi4kj
         23lrYrmA8XPMSE/a1YyYqUnw99n9mOGjiS1jQFo5DWaUsudSL63/OiwQII6xXGgKU6iT
         /hxKOW5Pk/dpe3QrNWjDfGEQl7TS7+mwnAQpAKOabxanSX8RSnA0EK9RHzXK5e/hFNsO
         MmWB64CYX356eE+HsCa6tULb794529CBl2YzjNFE8VSAg3ybCz9z8jQrFJqmiwy2ZOgz
         OE937fhIUSpXZRNR0GH2r/16Hj72kumD5RHNy9ZGzfzaqmleg1sIszpTTziBoZ2sbhA1
         +RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=qfTT64eWo/0FZI6hFlRAg1XjBqpp6j8CQAdLFYXrDs8=;
        b=h3vB36RrTlwhJY/A0Y0U3tTfdNELwQGmvK2vlu0qrbdkgGws2lSKmJORyW/WuLSD68
         EI+ykOgw7NDVBcY8m1sKPF1L1bOrbblQegNOSi8WaiwR9796r7lFnfDDLsb55Na16IOp
         QqSZ3nsWz/MIq9fLIEyXM5K+Ilj0wnaI37U7f1Z+pSkEU76iwHjqt/ffMkzxLN01scfH
         13yjgfvgRqeAVuatxjzQTxWnxWNJh/eh+aV70Qf62nMGFid63hBPJ1B5ZruORpYDC4Ro
         4XzoGkA9ggs/xIwjsulRMN2f19TVZq9VRpxRWzXWC84oxvUuG4+eh/flGbzDq96yP8+Y
         pm1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=cuF18SLX;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.53 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=cuF18SLX;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.53 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"zajec5@gmail.com" <zajec5@gmail.com>, "andy.gross@linaro.org"
	<andy.gross@linaro.org>, "david.brown@linaro.org" <david.brown@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "vinod.koul@intel.com"
	<vinod.koul@intel.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bharat Bhushan
	<bharat.bhushan@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Topic: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Index: AQHTwOGuh4ghPV/yzkyrY/8xyV2sSKPabJMAgABv32A=
Date: Wed, 21 Mar 2018 16:13:38 +0000
Message-ID: <HE1PR0401MB242585F3CB211F71AF29791EE6AA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
 <20180321092954.GS14085@kroah.com>
In-Reply-To: <20180321092954.GS14085@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [182.68.80.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2026;7:xck/W8gUuQ2W3stqQRgUXWpAKt0p+KnyHa9XtJO3qUZAZ5nqkq1C85ymN+3bW0wENd2lKB0oHHTldiiH8z9LjXTXyJRJRSYtlEbNDCmlYmeRetOMK/QGDrnzT+nPad1BEtMUMENkE9qcL3KJCjXv0EVZZpTcD66olZ4fwTBOLtqo7Ux2XTaCgEE7+GNOfQhOfZvq4lO+YXOrqSbRjk9JN9ycrbLh/axEa9htyR8SrBYrfL2LjQP8DeNCR/EuJPqn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93658bc6-f32c-4b79-bf8a-08d58f46b4fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2026;
x-ms-traffictypediagnostic: HE1PR0401MB2026:
x-microsoft-antispam-prvs: <HE1PR0401MB202652E57BD6B3B9A7B28A38E6AA0@HE1PR0401MB2026.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501324)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0401MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2026;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(199004)(189003)(13464003)(54906003)(25786009)(14454004)(345774005)(316002)(6506007)(102836004)(229853002)(2950100002)(97736004)(86362001)(186003)(99286004)(4326008)(2900100001)(3660700001)(5250100002)(106356001)(59450400001)(26005)(7696005)(105586002)(6436002)(7416002)(8936002)(9686003)(33656002)(68736007)(53936002)(3846002)(6246003)(55016002)(305945005)(3280700002)(74316002)(66066001)(6916009)(81166006)(81156014)(8676002)(6116002)(76176011)(2906002)(478600001)(5660300001)(39060400002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2026;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Z8uMxBNXWBiY4vHbADOivwEtbsXxKu42ZlFzWknFrEesDujcncfDoP4Q9h3voa+ydTrj9EtALZ0oLgjvsdGn77lv3umQbaL0b5WgIFUnBUf6X4Be9zPY60Dp0T9E1omr7vbnui9geZioEmKoXToq/Xsi7OlGfkq9pwhYEkOuMBaEcsGhGgbeTbR8wLuOcpLy5wBJdozzMp1wxIClYOjGu+hOwcmgiXqOoyxT3VvfYE7y+S16woSFdssIcRrVaRQ0qAU7jgsyAJm3Ch0898a2nZncg4u4p00EmGtM9IXgPB0NRSZ1tMUzqdqCi47CKAFfJzgBLtm3kKiePy5hIPMnXQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93658bc6-f32c-4b79-bf8a-08d58f46b4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 16:13:38.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2026
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595564438596280830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Wednesday, March 21, 2018 15:00

<snip>

> > +int dma_configure(struct device *dev)
> > +{
> > +	if (dev->bus->dma_configure)
> > +		return dev->bus->dma_configure(dev);
> > +
> > +	return 0;
> > +}
> >  void dma_deconfigure(struct device *dev)
>=20
> Empty line after this new function?  Sorry, couldn't help it :)
>=20
> >  {
> >  	of_dma_deconfigure(dev);
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index f1bf7b3..d2d5891 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1130,6 +1130,11 @@ int platform_pm_restore(struct device *dev)
> >
> >  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> >

<snip>

> > +
> >  	const struct dev_pm_ops *pm;
> >
> >  	const struct iommu_ops *iommu_ops;
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index eb9eab4..c15986b 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -761,6 +761,7 @@ void *dma_mark_declared_memory_occupied(struct
> device *dev,
> >  }
> >  #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
> >
> > +int dma_common_configure(struct device *dev);
> >  #ifdef CONFIG_HAS_DMA
>=20
> Blank line after the new function declaration?
>=20
> Other than those very minor things, nice job, this looks good:
>=20
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for the review :). I will fix your comments in next version.

Regards,
Nipun
