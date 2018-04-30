Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpkHXS7FtHcyvSXWdrHx1UpBNvKHmLR5+BdDFq/yseHC/9hm1DcFVMbxXv7i5FNSBwXLnBW
ARC-Seal: i=1; a=rsa-sha256; t=1525058840; cv=none;
        d=google.com; s=arc-20160816;
        b=AV2fAMzk3Yj6myurj3tkObeRWyMHKafyLs+uBQXBfqu/LhEKcHkVtGGudCutan5jxc
         6UgUFR5Yf4s64S3NPuE89C0UfAUMFlhFvSf7mohdcV4fHSbk9zBFVPOFXY/08DHgsaPU
         +HiUorOZ/GhQooHuQF2g6eSyOePDO92mrt82ciG7kuBfnWugHRihlhYPpAlNfIy2qc0R
         XHEZkYqa77YMRqQepHm1yHVDlelfjBvlVDRa8VQPKE/j6uGqrR1k9xFdfzWIOp7gzD81
         vG4c+90kwRNdqjQ6/PyudkaZUvVFAMRm3M4/jEiTGA88SEuvFmbeSw9QNQLeHYXJkwEQ
         3KwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=kKzgEyCv80ZPrsJjzNmaHzwG7gKOFiSrY6WZB6jv33A=;
        b=juM18i1/W8DbYYoqpt0kRb2oWVkW1EwayrIbOQ0wDsaCvQiSanPqqhaNvWu6nuFyoQ
         VLl94JDJrCJgQ8A1TY7+YuInmYmr8SO2PmAq8LF+4BZ2FgxGjcZmdZjG9nwLmZ5LmIsb
         fNsFOqp865+wVtSS//bbUFl1Kup8o3uHSLpTlUjyvv7ho5nwoYtllFWMNVgciKqIIcPl
         lB+/XSOv4j/2S09LfeqOg3FCDSfYClEI2PdM9U/+xun9YGvEzHQftFMlG+x6r1zViC97
         S7PwIIwZpz+vhDXLPfOFHh3ocYJg+AX9vpSnkkNc/MuTzZ0x5HZ8/QpqSLZk3iLjVPYX
         HyCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DreMd4QT;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.72 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DreMd4QT;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.72 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "hch@lst.de"
	<hch@lst.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
Thread-Topic: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
Thread-Index: AQHT3hJnNdFmewk/v0GeuiS+c3SIWKQU2pOAgAPPKrA=
Date: Mon, 30 Apr 2018 03:27:16 +0000
Message-ID: <DB6PR0401MB2424DEAB9AE3C3A78ED348C5E6820@DB6PR0401MB2424.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
 <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
In-Reply-To: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2680;7:1Wpz+IsUn3uvB0awTUKo+2kgBx2daC3m5tKyZ1llVncsAWEJ08q7NiDPQZZ1eYkKJbxhPyHJ+VhSXqqNGPNsJyQxAY+nP7OkIZq9D9R0y7CI42UStdvANSBLM2gwc0VNcUhxJ6YqOS14mgDXng41CNdSLQT6z7tZgdgKWitLb4hZie9wyVSJnP6gzjlHmHjxDdCD7s4np0oD4dUscgF2AZtOoL5fDlPDLSuFbfr8MtHZVVyBHgohpnUuaH0joeHF
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2680;
x-ms-traffictypediagnostic: DB6PR0401MB2680:
x-microsoft-antispam-prvs: <DB6PR0401MB268030969332387116CB17A4E6820@DB6PR0401MB2680.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0401MB2680;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2680;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(366004)(376002)(396003)(189003)(199004)(13464003)(97736004)(2900100001)(53936002)(7736002)(105586002)(4326008)(68736007)(66066001)(9686003)(33656002)(55016002)(229853002)(106356001)(55236004)(53546011)(6436002)(6916009)(14454004)(6246003)(345774005)(39060400002)(7416002)(6116002)(7696005)(99286004)(86362001)(102836004)(5250100002)(81156014)(8936002)(186003)(8676002)(6506007)(76176011)(3280700002)(44832011)(476003)(486006)(74316002)(54906003)(446003)(81166006)(11346002)(2906002)(3660700001)(316002)(478600001)(3846002)(25786009)(5660300001)(26005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2680;H:DB6PR0401MB2424.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HwdcZOtO1JMLvFBYbqiFexPNXZvW5QekC9BsQ2Esgs6C0kmwjrIr0cc6hH5A/666Bo+JIfsFFmd3HN09aRv6a34l4FdUWPulAvdYVyhCClPLCSr8MrFe/OFF8EX+TOviKqFAv8p7rEWxK3d6Y5f7YbzP7t1E/NY40QzR/jTpRH+cT+1fhgF/QOnPOkXwJ9Ew
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6d4455de-7abb-405f-a75e-08d5ae4a45ad
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4455de-7abb-405f-a75e-08d5ae4a45ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 03:27:16.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2680
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894771028861343?=
X-GMAIL-MSGID: =?utf-8?q?1599140097758525555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, April 27, 2018 10:46 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; will.deacon@arm.com; mark.rutland@arm.com;
> catalin.marinas@arm.com; hch@lst.de; gregkh@linuxfoundation.org;
> joro@8bytes.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Laurentiu Tudor <laurentiu.tudor@nxp.com>; Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available fo=
r
> other devices too
>=20
> On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> > iommu-map property is also used by devices with fsl-mc. This
> > patch moves the of_pci_map_rid to generic location, so that it
> > can be used by other busses too.
> >
> > 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> > functional change done in the API.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >  drivers/iommu/of_iommu.c   |   6 +--
> >  drivers/of/address.c       | 102
> +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/irq.c           |   7 ++--
> >  drivers/pci/of.c           | 101 -------------------------------------=
-------
> >  include/linux/of_address.h |  11 +++++
> >  include/linux/of_pci.h     |  10 -----
> >  6 files changed, 120 insertions(+), 117 deletions(-)
>=20
> of/address.c isn't really the best fit either, though I don't have a
> better suggestion.
>=20
> I'm guessing this breaks on Sparc which doesn't build of/address.c.
> I guess move it to base.c and of.h if that is the case.

Sure, that makes sense. Thank you for the suggestion !!
I'll spin off new version with this change.

Regards,
Nipun

>=20
> Rob
