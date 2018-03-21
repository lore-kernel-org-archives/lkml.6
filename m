Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvjIK5iznFby920juDvdXsev4rduS8tLthVYsN20+TOYIXtThPGchYxiN6aFFvrdbTxOD/0
ARC-Seal: i=1; a=rsa-sha256; t=1521617386; cv=none;
        d=google.com; s=arc-20160816;
        b=OQEZCiUIPwkfkOsGQ+As/GwAYzrgIhQuICNsB0soWKjQft3X6jvA1KmuuU+0LhnQ6y
         f8t3iAgCdn+2JZPzmOTp5MwiB9uEIniWDGoJfWg8ynaH603w/ujpMCkKFucWVOXSRUwO
         uOs6R4Ob2FFfcdasr1DF3oYd4XAqFVYeasw+9VA30WFrNILzZeXZ3l5kwZkxjOcVjSiu
         FYCsSMFuDNlKJFUdfDVXVLj5/sb5k52pHut3XfSQ1tCxBh18Zx3Aalq4Wtil1PuHcmOx
         iZbRXnRmmNFYf0Z+ZEEpukumnLMD2f2Ij80QtjV0sqXXJ1Csc8FrL9bN6BlkNCH7D9JG
         F9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=/3cvl8Dj6CeRBTZfzzzlBHM+JJYAyDXPY73/cCqd9tA=;
        b=EEg8TaDLFOT8sjJnNokJrAmUIzrXwhjClkV9XULG57lG1vMURc97qtkUJGi967lr5i
         MdTpDxp3X99NDfCnqmVKRm5RjrcMKYQzf+S4fbVylW40ln3nEjsZpcsDyahcCXOpKpfF
         ybTLMUrIfzXkbsSpHPVUgV+i82IOQWb8IQulTkYj9P06f4LCHiD23GlRGPvMhrIAnLlv
         bzrT0Hd5lspJyDP/fECAzjSg3iz1HDZ51/eggZ67pMMALdLiKCQLDZ9KaLfjmdB0WZrb
         iiuZ9iay/xo6FOFB3PTjU1f0nv5wZSqbs2kqG4xaGnsPsU9LCWBYRyKX6r0sjxHG2WA6
         nmqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YI8ciR2i;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.72 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YI8ciR2i;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.72 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "zajec5@gmail.com"
	<zajec5@gmail.com>, "andy.gross@linaro.org" <andy.gross@linaro.org>,
	"david.brown@linaro.org" <david.brown@linaro.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
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
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Leo Li
	<leoyang.li@nxp.com>
Subject: RE: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Topic: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Index: AQHTwOGuh4ghPV/yzkyrY/8xyV2sSKPaSBKAgAACAZA=
Date: Wed, 21 Mar 2018 07:29:38 +0000
Message-ID: <HE1PR0401MB24254A28553F17384BC9F785E6AA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
 <AM5PR0401MB254503027680DE6A23355D909AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0401MB254503027680DE6A23355D909AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2459;7:ylF548+7nkmOh0cJ32Do9cpF6TL3/KiscRlfNd5goJLJRBpxolJ4snZKH63Rl3n5BEfzKl3N1IMkQ+l5GT4zunRpXMwi5cThjjai/pY23NK9KUm3A1YqGnWK5UpJgdskyjfeHOSaXGAyAajl48GMQAkaa016mdkXQMHnywxsLDVH3C+XhBhEBdpPmOkL3kdByDSsYCbKDj/urVs1woeiAhXXzXkiejKmqZ57SRfbysaSlKKlJXT99oHK6PiNFC9N
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9eb292a-daf9-46d6-47d9-08d58efd817a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2459;
x-ms-traffictypediagnostic: HE1PR0401MB2459:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-microsoft-antispam-prvs: <HE1PR0401MB2459EEB220C0C9E617875500E6AA0@HE1PR0401MB2459.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501320)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2459;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(346002)(39860400002)(13464003)(189003)(199004)(2201001)(7696005)(33656002)(25786009)(110136005)(3280700002)(6506007)(76176011)(105586002)(66066001)(54906003)(3660700001)(6116002)(99286004)(6246003)(106356001)(102836004)(9686003)(4326008)(26005)(2501003)(2950100002)(3846002)(53936002)(2906002)(14454004)(74316002)(8936002)(39060400002)(5660300001)(7416002)(2900100001)(81156014)(68736007)(7736002)(86362001)(305945005)(6436002)(55016002)(478600001)(316002)(8676002)(5250100002)(81166006)(229853002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2459;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: U9ixWp02lw2wyaDrq937z6N/B9zs4NrK0pcrFWmoj0Qk6Hey1e9OWCnToeDiiUesGfZhfT18QzcUioYOjmbKNzxJm+CGaub676U1y/bWZI59Q/4CSYl5tMpXyaNbziDGSoWMVV7FJypBCzCAdE2O95wRHMNjLLUt7C/f9pWCfJnwnpD9HVudQXKmMetHsrSSoRf6gbdAHPMyvAxKvshqJha8Aw++pVC43hrbB8XwwWtVElU3wnQkZz9Yq6h3K4BFnxvf7iKViln3FxvXvyhcFa4Br3i2UxArrd8eXgcmaHMqp1eAdWILxSz9KPMrRotT7TSrCXTC1RR7F4w/4xnqVg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eb292a-daf9-46d6-47d9-08d58efd817a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 07:29:39.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2459
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595531472723073679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Bharat Bhushan
> Sent: Wednesday, March 21, 2018 12:49

> >
> > +int dma_configure(struct device *dev)
> > +{
> > +	if (dev->bus->dma_configure)
> > +		return dev->bus->dma_configure(dev);
>=20
> What if dma_common_configure() is called in case "bus->dma_configure" is
> not defined?
>=20
> Thanks
> -Bharat

I think it is cleaner for bus to call '/dma_common_configure/' rather
than this been called implicitly, but Robin/Christoph can comment
better on this.

Thanks,
Nipun
