Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvvngNVwigdw5zyHLTRUl/OnoATtwdpfGzcsyt/C9c6OIxEE/EubKdBJqRQ29AvPmpMTvyI
ARC-Seal: i=1; a=rsa-sha256; t=1520620187; cv=none;
        d=google.com; s=arc-20160816;
        b=YGYx1SDfAcERhsv8QLLvDUPzm5jIyj+ZujMEZMDtp3h2GE5bCvU26vY7jzVXsJAtQe
         ZnY1v8uYxWgeCs6RHV44oPx1x6XyyhqtpqWjPgHnQpCKmjyTLPhGkZDQGlEHQ2FzMpbk
         vngAfT9IimQ3TnsA7K8RQv3cyVF3U+LEVxnqvKfHPzvqilIYUf7MrNfFPiR3XTc+ffbD
         EITuGoNFogjbMi87f4vdGfyXvTo06OMNvwsEJla6rFcGWZ2c3vxVFTCc+DwJfTDsPP3g
         VRLnogompVJ1VwETuvnS2wo3hw+koBWLzyavVtsBr2kc8kvObUGncuJbqh/9UqroVN+p
         6nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=SEASvpwdN4yjUk/AW4v2/2OXccJXz2ML/eUsFOs/Y6k=;
        b=L/nUC6CFO9Dm2DN7wNM6SnEmcBWVlMykaasif7Ho4Ya3M9p3twT3GvLqbHbRgu4AqM
         A2+rasqUpNjyRURc8e21CnHzgZ4xYxJteH8NqRiuqjPkWuJ/qah3u9OqfUfUOrxbFfd6
         vCQN2ox7ACPaRFdYWMLPRiIBTTCtKrO54lazgf5LYRyMYjsLHn0FIJECpW/vVOjsesIT
         9TrIR1wakA1LHDk9EktX3rOaXkyCk7XrU/lVH4Szm/mwgz1MkCZWmvVTH4oc5bccFHht
         ftH0lHOev/6CesjQ4yVVrnobnOAm7LLAjVcnmp5ZyLmWRPj78bZhk9BOF3P1/+4d61Ac
         K42Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Y6v8iPe9;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.60 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Y6v8iPe9;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.60 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>, Leo Li
	<leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 5/6] dma-mapping: support fsl-mc bus
Thread-Topic: [PATCH 5/6] dma-mapping: support fsl-mc bus
Thread-Index: AQHTtI6BgJXbveMvYUyck0ElBntke6PBvnMAgAALQwCAAC/OAIAAA3AAgAChi7CAA1oQgIAAUIqQ
Date: Fri, 9 Mar 2018 18:29:41 +0000
Message-ID: <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
 <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180308074115.GB15748@lst.de>
In-Reply-To: <20180308074115.GB15748@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.143.35.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2187;6:MJEb5bx9HyfVjccnV7TCXtvh8r2e0jkiyUqMAD+MRdiDCehN/8Hr0WHInm35nSubI399ZBfPwhct+tLRaLYO3FsheNLt8J+0sdHcyQXp6lplYY/TQmZXZXnM9+Axp/XLILS5urric2ZsE++vcpyw9MjC9uAKo4IDE1bXnxJK3qTnTiCqI+Ee1zQqfUyVLA5bIyfUEczC2peMBCAj1Dafyx/gmjm3TIefz6U4xJKEYl0vs34oD7AEqye819O1B9x2Oc/hvfqZbvtIlIHVU4J/1MFXi81CIi55kBMUPvpg8VSPLjFMZTlqeIc3GhKGjKVLUQW7/+aTopGMKCtj2UVBgUhIve/A+ojaEPCzyH52SaFb2qfwTry6quPjEJdtfbYv;5:g+aoswWighBv9o7NTi6KGMqbDKT+UCSC231L69ftl/wRcVu7kjmgRTmpi7Js+hHHhpD2c8o/kPGhD4RNmODsGidHPlHIrz63yu+3QVYCvHomS5u2PTldi8slZ3lnOeiTnj6fHjbyjTX4r/hGb8qZzUwJOAeuWq04pr7Sr43V3R8=;24:htMWR1XGr+42cxa2C853+ITBr8N/zuwVKkXWQEw2TjV4bQwbMNlAM0ndcgP7nXzyxBq6wF+uxMndUdAd1nJLFzdhv7DAXyd7rH1uc6FHy9w=;7:9itmTsdq50JeLVL4KbR+rzABTZcp8cWv70cFQ5eFYhnc1c68KZlb2QZEqwV1byu+5gZv41A065yYhGQgXADOezCTtFCM/gF67VqCxorAmS9eCcn98xYZj41TcByP3gGBzLIrT6aMMOMG+ErY2sRHi75oRBqRuV3V4exxVIg5nDxgokOxtsne5AObDAfBTzub9Zcj8BfrASO4zVMn8snWK5z6Tx/FMDIFFq9RUCLXWNB81Bw3bPLP55SL92HvhtSz
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(52314003)(13464003)(74316002)(186003)(8676002)(8936002)(93886005)(99286004)(5250100002)(7696005)(76176011)(305945005)(81166006)(81156014)(14454004)(316002)(66066001)(26005)(7416002)(478600001)(5660300001)(54906003)(4326008)(3846002)(33656002)(6116002)(3660700001)(2900100001)(25786009)(97736004)(3280700002)(6506007)(229853002)(86362001)(6916009)(2950100002)(55236004)(102836004)(105586002)(6436002)(9686003)(7736002)(106356001)(39060400002)(2906002)(68736007)(53936002)(55016002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2187;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7a50402-f79d-4c01-0d90-08d585ebb9a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2187;
x-ms-traffictypediagnostic: HE1PR0401MB2187:
x-microsoft-antispam-prvs: <HE1PR0401MB21879FA62F7041BDAFA314BCE6DE0@HE1PR0401MB2187.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB2187;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2187;
x-forefront-prvs: 0606BBEB39
x-microsoft-antispam-message-info: TlRCv76ObyX9Un01eO6XeYB02jUeQe7+Q8EX8pMSy2fXi3bgT5X2hFxMR2aP01WwZv7Vcyw+ICjOogOVqETKN+1itNMiR/Y79DuxZH2t/aM4wLYNjiIQcS/7/SThIi7+kjsXDPi4Kp5AC8yB0C2BZIEO0B+Ntz3c8XwS35euck5L8z3m5CBtHwHOVuX/zgdMXrETDs27zoosGiuS9RGIdxeS5onj+8vih1UaU3nQK34gNVwL4nrWnAI3u9ZPZS9tPeJT8OvxlgAUihrdezQXMWLTJf6Alef87UhFJYf8J7bRWTUFHsDgswHEAlJ+tLoiRaYzwswTTiPuOfYcJRo6jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a50402-f79d-4c01-0d90-08d585ebb9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 18:29:41.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2187
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594485834108762030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, March 08, 2018 13:11
>=20
> On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
> > Sorry for asking a trivial question - looking into dma_configure() I se=
e that
> > PCI is used in the start and the end of the API.
> > In the end part pci_put_host_bridge_device() is called.
> > So are two bus callbacks something like 'dma_config_start' &
> 'dma_config_end'
> > will be required where the former one will return "dma_dev"?
>=20
> I'd just use dma_configure as the callback.

This would be a decent stuff.

>=20
> Currently the of_dma_configure and acpi_dma_configure are only used
> for PCI anyway, as no one else sets a non-NULL dma dev.

My understanding is that even the platform bus uses the of_dma_configure
and probably acpi_dma_configure too. So platform bus may also need the
callback implemented. Please correct me if my understanding is wrong.

I will submit the patch with 'dma_configure' callback implemented for
the busses shortly.

> For fsl-mc I suspect only of_dma_configure is relevanet, so just call tha=
t directly.
> If at some point we get enough busses with either OF or ACPI we could
> create a helper called from ->dma_configure for that.

Totally agree with this.

Thanks,
Nipun
