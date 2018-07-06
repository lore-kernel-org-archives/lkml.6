Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448324058
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pWT+CTl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3448324058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeGFLTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:19:07 -0400
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:45704
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753598AbeGFLTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A59W8gFRz6z+pTsp9L++TdRG1eewjwD2Z+l3/SR0c9Y=;
 b=pWT+CTl4r1UsdP7nCG9CixL9jeBaAYxVZPUokxhAhSZPNs2aw7i461MFsQIi7q/01tsUWidLJLgCNxPAFArbq1brqYj+FlO2YIwGDtkjyBpp794ml9QznM00/P0zMWnd1cpcjMm/qinrLSmQ0eAG4cWZbupEIcoo3Mgj/l54fz8=
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com (10.168.33.22) by
 HE1PR0401MB2025.eurprd04.prod.outlook.com (10.166.122.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Fri, 6 Jul 2018 11:18:56 +0000
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba]) by HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba%8]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 11:18:56 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Thread-Topic: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Thread-Index: AQHT8EF+4+/DGDZvTkihyZH/OaiobaRqQYVQgBgSsgCAAAExMA==
Date:   Fri, 6 Jul 2018 11:18:55 +0000
Message-ID: <HE1PR0401MB24256CD990DAE3A343EF3A8AE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180706111327.7gkerhkk6udfeirr@8bytes.org>
In-Reply-To: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2025;7:oPpOEEgWHriu2O4bes98+TRgyY0K0x+0HzZMGvtdFq0RaE8mKHqf0FsgLTZtMnLfDHaAWBAbYpOLwN7yaNeLjRDg0fARQIrSG4FOTFwRjWIW2bUPhAm46o8H+VRGuIO+LK9Ptl+CRe9W3F2zuAJQ40xsfE3SFm300SyIJ1NrQjjn4q50/R+XH/kdWno2hsIzgl5cAcs/Mkjg5xpUYar55NjvcoXS49VFLaQow+WGlyvxjSUM+BzGtzo8rWyjG74/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 701dfa4b-7bca-4167-a5f4-08d5e332435b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2025;
x-ms-traffictypediagnostic: HE1PR0401MB2025:
x-microsoft-antispam-prvs: <HE1PR0401MB20250743C7839A98BA5C0D6AE6470@HE1PR0401MB2025.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2025;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(13464003)(189003)(199004)(8936002)(55236004)(9686003)(486006)(7696005)(5250100002)(4326008)(2501003)(2900100001)(25786009)(53546011)(6246003)(39060400002)(44832011)(102836004)(6506007)(5640700003)(6436002)(55016002)(53936002)(99286004)(476003)(54906003)(446003)(106356001)(86362001)(11346002)(105586002)(2906002)(76176011)(256004)(26005)(186003)(229853002)(7416002)(3846002)(478600001)(305945005)(7736002)(6116002)(74316002)(316002)(2351001)(97736004)(66066001)(8676002)(1730700003)(81156014)(6916009)(33656002)(81166006)(14454004)(68736007)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2025;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ec+LXikdAADemaL9gACduccgRamsx4fqEBMXxdAgVmzvfdpKSXYbm8miBaMKWmwywn10b220EqT9sn90HxNPneT9Ti2JqhYbqJr8vf4o99iETSFXu2XtaqU2RmrKePmz/B5IPqg9s8iGGq6EMWpTszBy2gQ2JeQHarRrOcKTtrSGkRZ8xRVZodkmhYG+1NHd/DQO+O3T3Z3ak9McdDrhcCqyOGyyrYmjdis4CupMs/XQLmWLfBA4mOdJhR4VUL1KQpBvJQfSv3XduDv2hPg4xOLOwW55k1XiCww7uXJ2P5uQXxoRPzeJpYi4c8h4MBdKLyzhaVlEklcRAfglrwBsbld+w9i318+qP2OMeTBIBOY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701dfa4b-7bca-4167-a5f4-08d5e332435b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 11:18:55.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Joro,

I will be sending it by mid of next week.

Regards,
Nipun

> -----Original Message-----
> From: joro@8bytes.org [mailto:joro@8bytes.org]
> Sent: Friday, July 6, 2018 4:43 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; hch@lst.de; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMM=
U
>=20
> Hi Nipun,
>=20
> On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> > Will this patch-set be taken for the next kernel release (and via which=
 tree)?
>=20
> I can take this through IOMMU tree if nobody objects. Please work out
> the last remaining comment on patch 7 with Robin and then re-send with
> all Acks and Reviewed-by: tags included.
>=20
> Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
> that sheme for the other patches/prefixes as well.
>=20
> Thanks,
>=20
> 	Joerg

