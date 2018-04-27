Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZqE57Rg+RSwzQTGMNdUo+VThGLhvYYarGLyAalT+Dty8W5fgkat9ol+xoaCDkOZ8kAGb460
ARC-Seal: i=1; a=rsa-sha256; t=1524849054; cv=none;
        d=google.com; s=arc-20160816;
        b=xQEPB8EKFAWtOSW5DouhXde8dmCf/1l6JQyx0V+doHxdOxvgyk5MESadyUL3ywCrxH
         Uuzz8EctXbxi9FImN9K9Oj7kKKvOPPZ3ScYJSzvmLWGwjVcnWxm9vUcmW0JTJuaItUV7
         PHhC2QJ5ouFeC4wl9zY5pNTi97oAKlCMzEhsWnbGIQ8wY+OVbRRst+NtwTU/GmQaduRL
         ADVTY1lSIO3ekqQVYkXd0l8jcE45Nok8gAMzDP/pyWJqpfuVcboa7X7wh6pwFk7leJff
         H9OtMSRN+xa+WeNdSd9DRkd8k9HAaYQ0rqtpsXnI8v7hu8OV3ERgI5VHxkkZqmSouKAp
         LP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=rBpO92y9gBLojHiRXGZnFGQKrw3D+YSi55lGbZfAzns=;
        b=uX6AZmLsO6GxtexDR2K/wqIYbunldu5k0gzQ8WSLxDm538fVQ/iyLu65iIq5ftPAoe
         a2jj4Pte/qIvJsk9C0THvaOX3JFWBX633pGASnVuUn85dY+fzgLU0x8ow/ipP452ChTm
         9hIN01Z0GJiCmgQLILKFK8Xrllb3pzQ8QcgPO31PDuN/LPWi5k6NHwSncIQS417zZ5uL
         FkCQVDeOKrfEJ/YKE48LxPGJAynPHQCTwWVZdEHwUWne/yacJScJfA9pXVOOLih8k1zV
         OhbXRAeQONipv9QJCcEFbnlKe5VGvdbl2v/WPIuRjr6s6iWju2ngZ6+orZj5peMtRHSP
         sOXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=pF7D0/yz;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.71 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=pF7D0/yz;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.71 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: RE: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Thread-Topic: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Thread-Index: AQHT2wJVS7uBRq+xJUe2BeZ3jEYC96QU3yng
Date: Fri, 27 Apr 2018 17:10:48 +0000
Message-ID: <HE1PR0401MB24259708C02B6AD57C11A18EE68D0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
 <20180423125638.GB8824@lst.de>
In-Reply-To: <20180423125638.GB8824@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [182.68.120.223]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2666;7:VpP1qNe5spjieMw+nOR3wtqqTrKx2QJcQ+Z3XYbincxcm0dx1XPcbiYXRk8/uhg4Y70mntH2t155qVPjwPdzVrVHvSK11dmijg4EM62xHyx2vfu02g9OJeAJDgf/abS3y/B4G900QOxYqs0bGvi2ub5rRyWTj3a6OfLICUtlpwu7kpZd3MG4euuvCqEo41RWhgPfqbKVIWcQDikjC59Oy/1boM2FAC0FKRm5xPV9m169K4reMMkQsirfTldSJkSq
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2666;
x-ms-traffictypediagnostic: HE1PR0401MB2666:
x-microsoft-antispam-prvs: <HE1PR0401MB266662432DAC5C87B3B737B9E68D0@HE1PR0401MB2666.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(211936372134217)(217544274631240)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB2666;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2666;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(81156014)(5250100002)(4326008)(6916009)(6116002)(99286004)(3846002)(76176011)(44832011)(476003)(3660700001)(446003)(106356001)(86362001)(105586002)(11346002)(7736002)(486006)(74316002)(102836004)(186003)(33656002)(8936002)(81166006)(39060400002)(54906003)(14454004)(66066001)(55016002)(6246003)(3280700002)(97736004)(2906002)(6506007)(5660300001)(53546011)(7416002)(2900100001)(305945005)(9686003)(229853002)(68736007)(7696005)(26005)(25786009)(478600001)(316002)(53936002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2666;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NHWvVHUYXb2C7I6jef4D4NhG1vi4JhKdwVknSijwlL9t5oDoTjtilollDFgTv8CnXC8XKzxBottM/EXUqfVmnPUAU8+86rNqbHzqErA9pAHoKO8638Q4fx6BvfkoEf8GH+OKrA6yD9mnGk4qoXjU0rzdUkO+QEn3Gg62yq/NZMf85PQIudSKyDEKoH6I0Aoo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9caadde2-1c95-4fd9-ddf0-08d5ac61d2c3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caadde2-1c95-4fd9-ddf0-08d5ac61d2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 17:10:48.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2666
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1598920122268738183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Monday, April 23, 2018 6:27 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; hch@lst.de; linux@armlinux.org.uk;
> gregkh@linuxfoundation.org; m.szyprowski@samsung.com;
> bhelgaas@google.com; zajec5@gmail.com; andy.gross@linaro.org;
> david.brown@linaro.org; dan.j.williams@intel.com; vinod.koul@intel.com;
> thierry.reding@gmail.com; robh+dt@kernel.org; frowand.list@gmail.com;
> jarkko.sakkinen@linux.intel.com; rafael.j.wysocki@intel.com;
> dmitry.torokhov@gmail.com; johan@kernel.org; msuchanek@suse.de; linux-
> kernel@vger.kernel.org; iommu@lists.linux-foundation.org; linux-
> wireless@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> soc@vger.kernel.org; dmaengine@vger.kernel.org; dri-
> devel@lists.freedesktop.org; linux-tegra@vger.kernel.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
> infrastructure
>=20
> Can you resend your changes against Linux 4.17-rc2?  There are a lot
> of conflicts as-is.

Sure.. I will send it soon..

Regards,
Nipun
