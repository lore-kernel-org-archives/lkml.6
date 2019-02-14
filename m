Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E9A21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440052AbfBNUqI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:46:08 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:60270 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388771AbfBNUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:46:08 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EKaFAL026071;
        Thu, 14 Feb 2019 20:45:38 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qnf8jr5f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 20:45:38 +0000
Received: from G4W9121.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 90E1BB5;
        Thu, 14 Feb 2019 20:45:37 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 14 Feb 2019 20:44:53 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:44:53 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0708.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 20:44:48 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f012:82c9:aba7:b348]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f012:82c9:aba7:b348%2]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 20:44:48 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Keith Busch <keith.busch@intel.com>,
        Takao Indoh <indou.takao@fujitsu.com>
CC:     Takao Indoh <indou.takao@jp.fujitsu.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvme: Enable acceleration feature of A64FX processor
Thread-Topic: [PATCH] nvme: Enable acceleration feature of A64FX processor
Thread-Index: AQHUuixEYFzymgLFiUCqA3SMj/CQNqXLB6YAgAYoUICAABzJAIAOebTw
Date:   Thu, 14 Feb 2019 20:44:48 +0000
Message-ID: <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
In-Reply-To: <20190205143905.GG22199@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7effdcb2-f084-45fe-f871-08d692bd42f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0708;
x-ms-traffictypediagnostic: AT5PR8401MB0708:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AT5PR8401MB0708;23:tbHPDB0uY63kJoQ07F3P7+OXVvUqbZMQioesPIU?=
 =?us-ascii?Q?Te/S+GVPtqEzpGtt9XqF3IfVRlRubYaPFr9dCUpon9eXJdf8LlgC285E2NuZ?=
 =?us-ascii?Q?JGcJZrmhdhJAlx0pvnXApJYb3sw6L+BFG5MFL8/eNo0J79439CmFMDTE098Q?=
 =?us-ascii?Q?tKsI6CzIYYWjvM6UPluAfS+35W+4N8v6yRmA4s+AuCU3bLLK0in8HwTsTFKm?=
 =?us-ascii?Q?NuoqWs8KUAYT9QDIccZCYgHtf/JEQGGgzjzIJt1GLBiS4EX8/dLTl6hmbbNE?=
 =?us-ascii?Q?y9WLMkj7Nt/czvgodDSue0NkYHhOWp4dwi7eOEqZzp/DSkSSNNPvJ5L4M5SN?=
 =?us-ascii?Q?paGaXfZttRPaUyLUYSDHkE5iRJYOrH4ZaJnROMla9RErSYyzFGOQ6xBTzRKv?=
 =?us-ascii?Q?pesh4xccBfRT49M3LwNZI2nYkwrSd+N4Z96lugq0W7soUFTEl9mSagCXp8yo?=
 =?us-ascii?Q?yrJkyP7SbHk7U5GzQfCh35+brRxSsyfkCQ3H2bXkkdxR5KG1I+tlY+ThIUip?=
 =?us-ascii?Q?gGid0GWW/G0Ebvz348yxPMTu2yswk6M1pcg6FQO/Xr5J/lgZ8H8QKGk+DS+b?=
 =?us-ascii?Q?kRZ1BQbUBSu60LLaqKnsv57+X0vLjIXbts6QdqOr/KuvQwd4ooVt+vn2PHsG?=
 =?us-ascii?Q?R28xU36mVeEBwLtDXOyy41qKnVjdgw3bSAai9sMse/PMsSasFAnyNZ5oJl01?=
 =?us-ascii?Q?ImZluZRn2/w09rNfcPv6ayjZm8GqO46WeDhJGlR5fox89UQSLQgxXRjkCnxF?=
 =?us-ascii?Q?AoBQj8uJcq2Le2JYY0JYEGTt8Lor6JLxytTLvaQO8fbM4Xop87cJ2lV2Gfmu?=
 =?us-ascii?Q?8Wm5TYrwfUa8OGpMCHfx0aVlLlbU4YAhskMJyEH7AUWhb5qmSrIB+oMlVdfd?=
 =?us-ascii?Q?2kYVPmIoYg1mlqxu46Qt2aJc5wZZp+b/ke5XIrodTld1nBARhgzg2vwkO0IT?=
 =?us-ascii?Q?K2vTQwgLAUkXMH3wWooUFmw7j7RCDpjur6jR/0Tc2FZg8XoDv2orwK4ZBx/b?=
 =?us-ascii?Q?lyyEF3HzLz9hP6YMu5OyDUoCnhekUyl/MKFrNEv3bhKRwZgoFmTaqRuHYGGt?=
 =?us-ascii?Q?NywAAnkbAb/F9nkx0Srp6U7BGL3snBxk8K3eDSebdkQnqmHQGcIgjTXL9TZd?=
 =?us-ascii?Q?AHfWJUOYo/PmzyESC/J1CdkmV8K/ZMlI6XYWoMcDw/iA6c+/alBKZaGY4bZs?=
 =?us-ascii?Q?5ypByJLHXMYdvfX+B3kaJvnnt5udpVdj9NLV1+rYlzZZcCQS0tWeildLQgwQ?=
 =?us-ascii?Q?WulUN71Kd8IgkZ1jb/sU=3D?=
x-microsoft-antispam-prvs: <AT5PR8401MB0708762653F92E5DD365CF16AB670@AT5PR8401MB0708.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(13464003)(199004)(8936002)(476003)(486006)(33656002)(11346002)(76176011)(68736007)(9686003)(6506007)(446003)(53936002)(2906002)(66066001)(8676002)(81156014)(81166006)(74316002)(305945005)(55016002)(97736004)(7736002)(93886005)(6116002)(14454004)(3846002)(6436002)(26005)(53546011)(102836004)(99286004)(25786009)(4326008)(229853002)(6346003)(256004)(71200400001)(71190400001)(7696005)(106356001)(86362001)(186003)(6246003)(316002)(110136005)(478600001)(54906003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0708;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MlQ21nljI69hm1xYAuNz5x1BRiestYxdWW9mLs9cPgRraDIndladZjeZlfGI/R5NxDo/853u4WrVz42V1/plJ17dJmayt5LgNDRCnbZa6Q3bd9l464Y001HIbFShXIVFdKqwMLSVBA3wvrohP3UsPbtb89ijWsekzq5+Z9IHDGqBw2gmdcO/rO90jg1p4QRQ4xs/PDmFIYvCMRvBvgDU68fKJRoUysAasLbaTF3kppel8VgrSKGKPepYVTpIzBthJBby8Fc/dmpFNqIZ2a5OknZdaOMIXEribLc3BPGbhL6B4XtHClRZ+IYu6PIljK88FI0XWu5WL9nl2yvGg6o8aDVEsC7KtDBUfHqHwdf5x4KLgjvs8Nefn4JbiI/UmCjtZPoOiOEB2+aahxilgyz0pnfGpjSwZCuQ/d7fSU9HjFs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7effdcb2-f084-45fe-f871-08d692bd42f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 20:44:48.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0708
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
> Sent: Tuesday, February 5, 2019 8:39 AM
> To: Takao Indoh <indou.takao@fujitsu.com>
> Cc: Takao Indoh <indou.takao@jp.fujitsu.com>; sagi@grimberg.me; linux-kernel@vger.kernel.org; linux-
> nvme@lists.infradead.org; axboe@fb.com; hch@lst.de
> Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
> 
> On Tue, Feb 05, 2019 at 09:56:05PM +0900, Takao Indoh wrote:
> > On Fri, Feb 01, 2019 at 07:54:14AM -0700, Keith Busch wrote:
> > > On Fri, Feb 01, 2019 at 09:46:15PM +0900, Takao Indoh wrote:
> > > > From: Takao Indoh <indou.takao@fujitsu.com>
> > > >
> > > > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > > > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > > > address is set to 1.
> > >
> > > Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
> >
> > I should have explained this patch more carefully.
> >
> > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > field in the TLP header, however, this mechanism cannot be utilized if
> > the device does not support RO feature. Fujitsu A64FX processor has an
> > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > DMA address. This mechanism enables to utilize RO feature even if the
> > device does not support standard PCIe RO.
> 
> I think you're better of just purchasing devices that support the
> capability per spec rather than with a non-standard work around.
> 

The PCIe and NVMe specifications dosn't standardize a way to tell the device
when to use RO, which leads to system workarounds like this.

The Enable Relaxed Ordering bit defined by PCIe tells the device when it
cannot use RO, but doesn't advise when it should or shall use RO.

For SCSI Express (SOP+PQI), we were going to allow specifying these
on a per-command basis:
* TLP attributes (No Snoop, Relaxed Ordering, ID-based Ordering)
* TLP processing hints (Processing Hints and Steering Tags)

to be used by the data transfers for the command. In some systems, one
setting per queue or per device might suffice. Transactions to the
queues and doorbells require stronger ordering.

For this workaround:
* making an extra pass through the SGL to set the address bit is 
inefficient; it should be done as the SGL is created.
* why doesn't it support PRP Lists?
* how does this interact with an iommu, if there is one? Must the 
address with bit 56 also be granted permission, or is that
stripped off before any iommu comparisons?






