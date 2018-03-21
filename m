Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELsO4+982B8PD+Hn5DjzgtcAflI0i/CIqJU4mnF+i3qc+IVG9dQUIbMfYnSCx+mQ0am1d/Bj
ARC-Seal: i=1; a=rsa-sha256; t=1521649732; cv=none;
        d=google.com; s=arc-20160816;
        b=RBh1pfKLYqfvVDV1+q0imUaNxnrju94IVzkgL+jqSI3ljItQ1QPK83iKgjTfl2C6YB
         NHdUmQZxhvI7wJl+/B/e8uUvq8U1H/d4S9HoWcZDqxzIFJ12Nw5Pvx4I7/iFPucTNkAf
         rnvMnCdDq5iKt8sxmFlhu7p0bGeRbf9TSleoswqw7zZOesvWpdc9F7imXAIkPgUH36uE
         s4PcaNF12rzqZdGVRskWArTq1vqPAPdDO7d0TIdOftaryE6/eOfEbXBM0MOWOxRKTPIh
         PJ5GMt0RI9UCc80KQP4Dw7A4k6ebrJmSNaP/KT+3lsAycFzjQlI66wUxd/wvwLeD7mlh
         gyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=j3RoYOr0NIz+6WvLquCmWt4ISaZUeU42KRXxiZx5dlI=;
        b=YOg/6N19N9ychZ9tsfQ8+RU+3mOcSIgKaFOcODyKhwrF5Da1/vyPcfFfm6BnzkDfBn
         21DP8FHtMuzYIrUMq0QyMkMQMDdgcSlYJjuS7C1zjmw3eJbdeLE2DCsD9dvGxcMPlpk3
         2JOc4ZUOW8syY6acidBiT8V5829GkTluZJ9mgUIYB3WqM6/8kIcEOdK9JZ9EjtvGRS9E
         ndBApnw5EdVEK18IKBcWiFIMi+mc3lbfFlSLh8qMZ9fTKtCzXRSdC28z8mRyT7YXUHJK
         1sX6LPB5fFHLekIwM8VCJuRP1mZykqs4Ds6e/Q5qta8TAvrzor1pYt2xL2o/xRKroz3I
         2suw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Y/AzOk7U;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.3.68 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Y/AzOk7U;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.3.68 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: RE: [PATCH v2 2/2] drivers: remove force dma flag from buses
Thread-Topic: [PATCH v2 2/2] drivers: remove force dma flag from buses
Thread-Index: AQHTwOG3hQPpJrn9E0mo0AF6KOaafqPabh2AgABvSYA=
Date: Wed, 21 Mar 2018 16:28:46 +0000
Message-ID: <HE1PR0401MB2425644F72A063ED42B79D5FE6AA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
 <20180321093525.GT14085@kroah.com>
In-Reply-To: <20180321093525.GT14085@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [182.68.80.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2444;7:l+dyK1fiI5UfpvHs1RI2Rbx63EYAEVPHQo5FhlL3WzpJyqrkB4Aj26k9lKxhMCMA0MUlEZ1ScuEQZqR/ncSCBifanxv8444U4DwSw3g+VoF4hDD4fo+byjiBflTyTa1AorKLttdo3BQrFIzxfrvL7NyKZ82kbf848kbVXTw9TGMSUKOR7uCM3tUjWU2d1W8I4kc4Bp2TuFNFP7gWgmnz+ih/sMfH+cpqmsqHp6oPibMEKuhubIF1kDUmEb2078dp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c2454c5-4cf7-4ff4-8e21-08d58f48d1e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2444;
x-ms-traffictypediagnostic: HE1PR0401MB2444:
x-microsoft-antispam-prvs: <HE1PR0401MB24442788B08C0798500BAC30E6AA0@HE1PR0401MB2444.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(244540007438412)(9452136761055)(185117386973197)(85827821059158)(211936372134217)(217544274631240)(7411616537696)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501324)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB2444;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2444;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(13464003)(5250100002)(2906002)(68736007)(3280700002)(76176011)(478600001)(7696005)(102836004)(99286004)(53546011)(6506007)(93886005)(9686003)(5660300001)(186003)(106356001)(26005)(105586002)(33656002)(6436002)(55016002)(54906003)(97736004)(7736002)(81156014)(7416002)(8676002)(39060400002)(305945005)(81166006)(4326008)(8936002)(316002)(25786009)(6246003)(74316002)(66066001)(3846002)(6116002)(53936002)(2900100001)(86362001)(6916009)(2950100002)(3660700001)(14454004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2444;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3l6BUy+Vi/Q4m+XeKTR//5aC2vF2Z+iUEf8UXejkh+lAuejFFVnGhxe+glt9cYjWpsDwZoCEM5+g795+a2yTQlRW15RymgpUVTxi7dZoldtXI5F1SUUwT9g6J/+6b+Gv64pfFeMZrWnccGLWGZJPCN+jrtGh0QBzD6yQJjhevZ58W+EDZO8eTXLd+EbVxJjb0Ce9BTo9TbiD6rK7TQDGMB2QVPmLJhCfebaGvJW1NPtNQ1lSEPB5nexdCZzVVFPu/U5dhSQ9BJG7Nrg+WQvcf6EVOXLIsL6VyLuhBjEZ3nod7B2u7vhBjh+nChov8fcuoO63SLYo1MiUk0IvxLC5qg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2454c5-4cf7-4ff4-8e21-08d58f48d1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 16:28:46.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2444
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1595565389806377062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Wednesday, March 21, 2018 15:05
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; hch@lst.de; linux@armlinux.org.uk;
> m.szyprowski@samsung.com; bhelgaas@google.com; zajec5@gmail.com;
> andy.gross@linaro.org; david.brown@linaro.org; dan.j.williams@intel.com;
> vinod.koul@intel.com; thierry.reding@gmail.com; robh+dt@kernel.org;
> frowand.list@gmail.com; jarkko.sakkinen@linux.intel.com;
> rafael.j.wysocki@intel.com; dmitry.torokhov@gmail.com; johan@kernel.org;
> msuchanek@suse.de; linux-kernel@vger.kernel.org; iommu@lists.linux-
> foundation.org; linux-wireless@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-soc@vger.kernel.org; dmaengine@vger.kernel.org=
;
> dri-devel@lists.freedesktop.org; linux-tegra@vger.kernel.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH v2 2/2] drivers: remove force dma flag from buses
>=20
> On Wed, Mar 21, 2018 at 12:25:23PM +0530, Nipun Gupta wrote:
> > With each bus implementing its own DMA configuration callback,
> > there is no need for bus to explicitly have force_dma in its
> > global structure. This patch modifies of_dma_configure API to
> > accept an input parameter which specifies if implicit DMA
> > configuration is required even when it is not described by the
> > firmware.
>=20
> Having to "remember" what that bool variable means on the end of the
> function call is a royal pain over time, right?
>=20
> Why not just create a new function:
> 	dma_common_configure_force(dma)
> that always does this?  Leave "dma_common_configure()" alone, and then
> wrap the old code with these two helper functions that call the 'core'
> code with the bool set properly?
>=20
> That way you do not have to "know" what that parameter is, the function
> name just documents it automatically, so when you see it in the
> bus-specific code, no need to go and have to hunt for anything.  And if
> you are reading the dma core code, it's obvious what is happening as the
> functions are all right there.

How about we do not pass any flag in 'dma_common_configure()', and inside t=
his
API we pass "true" to 'of_dma_configure()'? I am saying this because curren=
tly
both the busses (platform and AMBA) which uses 'dma_common_configure()' pas=
ses
"true" value. If we create additional 'dma_common_configure_force()', then
'dma_common_configure()' will not be used anytime and will become redundant=
.

If someday new busses come and they needs to use similar functionality whic=
h
'dma_common_configure()' provides, but with passing "false" to 'of_dma_conf=
igure()',
then what you suggests of having two separate such API's will be more reaso=
nable
and can be implemented?

Thanks,
Nipun

>=20
> thanks,
>=20
> greg k-h
