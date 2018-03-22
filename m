Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvQTiYGitp1SBcITDFhWIOjWOxC1pIIjWRuYF5CZZNESLLuV1HXSQeBMSL9vF+1YzuIkLLy
ARC-Seal: i=1; a=rsa-sha256; t=1521731117; cv=none;
        d=google.com; s=arc-20160816;
        b=baaHOL3nMDNMYBEI1iZ8BPfL2lBcsh71QmUkWNc6h2p44FYt4Wo8VAfnNloPDvnqKi
         0mg9jf0+DcfP+2D99CNG1N102zqdqpmqVwUBZ/nlwGeeJI0Jqanzm8X+ffntLYz3MkHX
         1b5TAF1ve9aaBA1qhJenNEgdw5BAzA5+V7BbIJi0ijYvLB89uliacgBUcL7HEX3ocUG8
         3oBzohaLy1VBM0CSnwsmm13DLpcl20cVSVdWY/tVne4fRSTfB329yw4jss4aY7Jgwfp6
         dXP7Mc+v5YsyK66Bw5IEzftRFYb2kYpooyHvPiZ3lJDbHEP1YcSji80sKvZD8YlDRVWl
         edfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=uyjhL9iDsy9YfZ2UfAS2X0pym+ef41m5nLdyEqr4ySA=;
        b=eA4Yfizj0cYLat19PkOafysMZeA1eTmHJwi33VSZadNqEZDF5jUnW2cP2okec+KxLm
         ZjNX8Whzbng2ZqVMCbjcxEo6nxs34ow+8vPi5H8xsitaKOn4zlf4U+XkSLoSZSTGcEVX
         aWpqMgYNcQHSJnvTSgA4QwCmlGYuuPs+g6JOOYK+b+t7V7OggLKSUdOBc0xPQheSEYLn
         zOXn9sdYVjjrPEsXCsUQC7cPw2nlO00xrN4RmHxmwo/6DE413quSwrxkDlCzWGw+FaEg
         ZBJpYLHUwA7w2mFNbcUQsXBim3g+5yBC1hwwA7ALv/ORkn9JAfQmUliUthxB0WxDbtmk
         OLcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oGO0vBZj;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.2.59 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oGO0vBZj;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.2.59 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
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
Thread-Index: AQHTwbXzZdV/Cb9KwUqMlGqXr72+FKPcVeqg
Date: Thu, 22 Mar 2018 15:05:10 +0000
Message-ID: <HE1PR0401MB242569E833A5D617A8818ADEE6A90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
 <20180322081530.GA29444@lst.de>
In-Reply-To: <20180322081530.GA29444@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1820;6:+cClzV1f6mGw4NZUlVg3ozaX+as6pzyEsGlZ0hkdkRSoinJJvErK5gHbRJcTX8KzD8HNiwxqLbOgHIf5aXrayw2brvVDcLc7RnRw+IOphTHG4sjOzRR6l4H+2EL6W3RnGRvMoZxtiKTkJWUAQ2umQJyGdQHeJtHPFdUmupFNuEFUzyl7ODJgKxCuIuRAEksGZeteHeFo/IJxn5+lmBrMeg58e88/Dvdj6ICtvGNgnavoc+BPLpTobfrsbFVF1gJn+wDMiDPtWOkJM8zPytSK0UbjsDj3gRKyehcjboTJ8YRjT/5fM7BAaNvu+whyHTA3wKUAZC09rD3bdqsGW4XAruENm+i+saw9Us703hL53JoV0Tx9DWBUwORBB45RxkNN;5:SrJzSl22Y1GGb8YFh7VyYc5Cj/Skv2RzulXTs0fXsUw623keKb+IRDXbo1N08SBy8gQ6OgDJkPDyFFRSfSHIq4juvahwnEMUfdkLiJ86Mn42i8jKOgLdsdyOyROz+lpU9pHbd9jFA5fM0eta6jolaPyPB+7l6RuUUzfBc0WwVNQ=;24:pXnRe4wHgjfVR3agkIEN39jbCOpArCSffPpXH1/2Wys1kX2RR1x/rWM0XZtz4ZL98GB2Mu8ODDnmKwDuzG0KHPG+h9AthHUNFrekKNrmIZo=;7:JpzrdsC3KwHDy+bPlArWbaJbq4y4LBAm31wB/Jp5IvkvRAdAr7btaTk/s4BidLWRoog5hI1x9nocUlsSufbXDVec0G+rQ3mfNhrgMc9BmkU38twhuTcPfofstTHr9YsENQ2NONaWaxbyUyQzWGKOzTM5K90aquja4rIngKrlE6vBvg6veRF1T+xTuizDLbX5efS4cEXEI1IbH+QUlS7KziaJa+isWdEfX9H0QknF52cJkLvzqVrk4MAOYn5EE3AO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 204fd770-71be-4a9f-041a-08d590064efd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1820;
x-ms-traffictypediagnostic: HE1PR0401MB1820:
x-microsoft-antispam-prvs: <HE1PR0401MB1820829B7B474FE886FF5A8CE6A90@HE1PR0401MB1820.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB1820;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1820;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(39380400002)(13464003)(189003)(199004)(55016002)(86362001)(68736007)(102836004)(39060400002)(5250100002)(76176011)(99286004)(9686003)(4326008)(55236004)(6506007)(53546011)(316002)(446003)(186003)(97736004)(26005)(5660300001)(6916009)(305945005)(3660700001)(478600001)(7736002)(33656002)(14454004)(6436002)(81156014)(81166006)(54906003)(3846002)(2950100002)(8936002)(229853002)(7416002)(6116002)(106356001)(6246003)(2900100001)(3280700002)(25786009)(74316002)(7696005)(66066001)(53936002)(2906002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1820;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: J7ndpx0nSBlwgqtQUv+qtSko5ldiyr2qkY91ORG/uq3sOq7iVH56acil6ZyEmSdDHa00/5ooyoyvFvXwo32mBBsJjX5Muhq3i9eS55vYzalrm8kqWU9y/G31941mkz8vief+mCpLiDGusSinUFqb6vwGs/2/36tug/9jUw6pm7+ka0HWYzGjNfBIajEGJ2qLcP8gwAKAyZVfsxUM7iaiDu6pdxCpm+u7RDbJcCBtnYUjX/agWz+347eIql+3bei7N4Ycr3J10GWkVEM0ZQVXv3QSPsT1SbGnqHRiFCTXKjvxW7BcbQXqbMenlc+yrYq9XbgnZ0uoQTDpwLlhuZ046A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204fd770-71be-4a9f-041a-08d590064efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 15:05:10.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1820
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595650728247275044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, March 22, 2018 13:46
> To: Nipun Gupta <nipun.gupta@nxp.com>
>=20
> > +static int amba_dma_configure(struct device *dev)
> > +{
> > +	return dma_common_configure(dev);
> > +}
>=20
> So it turns out we only end with two callers of dma_common_configure
> after this series.  Based ont hat I'm tempted with the suggestion
> from Robin to just have amba call platform_dma_configure, and move
> the code from dma_common_configure to platform_dma_configure.

okay, that would be fine, trivial query - will it be okay to include
'linux/platform_device.h' in the AMBA bus? I am reluctant for this change
because of including platform file.

Thanks,
Nipun
