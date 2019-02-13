Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3512620838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DQ/iobx/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ADyAZ7ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391849AbfBMLYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:24:13 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61670 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfBMLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550057054; x=1581593054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mFvlRKMHABWbde5ZY193gnyrPiGnNU70VW6xKuSsu4=;
  b=DQ/iobx/tzkff7QdNaU/XfVzYbTweFdiHJnzCYLpIiNRzLA3bInB/LI2
   a4m2ZIgn0xG4I53rn+c0sfnUKb338SFrwRsdTX7kky0cAqzQhjfL0ITGP
   7FPVhWTUAHaR2zYwR/eY2ZFvdXilwHGyWaj7aAc+5M3Ruwa/l7xdbg8u6
   6YhElpoLvap2IiCUNYgnRyK4qy810cIOYR7YnCXv89zr4RIeHaOZ9PQw2
   6EY30LG6iq11NkkDWHvRyhbiEAGv2eU/jwP7UPnYn29zzNl2qb8nVorYG
   DqZJ1R6RdkY56Ir569jkD9+j2pIVCdlDAwdRjXThaLmmWuAnVsfKwHRgS
   A==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102881870"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 19:24:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mFvlRKMHABWbde5ZY193gnyrPiGnNU70VW6xKuSsu4=;
 b=ADyAZ7efjSwnfoZisGVrGjKRciWAJu9CbUWTieucnAUp5invl8IDR71+FX/HgftezQMAJqaKcBEAyhvm1Ck+zz58Wnj34fRfHAdUP7Cw5PVazQHgkjSidUG4asyr1yRUTjsha9Bu1XlzzCnehmk+tFadllEv10r7YuARWHV2uV8=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5579.namprd04.prod.outlook.com (20.178.225.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 11:24:10 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:24:09 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Topic: [PATCH v5 1/6] RISC-V: Move free_initrd_mem() to kernel/setup.c
Thread-Index: AQHUw3MilRR/kWU9BEe52TaCNV3UfaXdftMAgAAXM/A=
Date:   Wed, 13 Feb 2019 11:24:09 +0000
Message-ID: <DM6PR04MB6059A17BAFA1B0AE939FFBF98D660@DM6PR04MB6059.namprd04.prod.outlook.com>
References: <20190213080647.68204-1-anup.patel@wdc.com>
 <20190213080647.68204-2-anup.patel@wdc.com>
 <20190213095951.GB21478@rapoport-lnx>
In-Reply-To: <20190213095951.GB21478@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.52.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd69938-840b-498b-aefc-08d691a5c62a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5579;
x-ms-traffictypediagnostic: DM6PR04MB5579:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM6PR04MB5579;23:osLK79HByc3vpnnud6yDfmUAFYiLWpDasE+jm5LvG?=
 =?us-ascii?Q?XaGVyO5ahWyEL0VxuoyC6215VTN7Mq1ubntkWgu4ESJ+q/xixh6LuwgRSxum?=
 =?us-ascii?Q?hPJweaKbPs3SlO/TDSZL7y1ZFh/S4F15nws6COkK7Fs9p36HI79TUgSyb0jZ?=
 =?us-ascii?Q?KPjyR1GjDMKwivUt6gQ50hyuQb0n+SicfLpGZXPrNzKAajOSg76D6YcgY/le?=
 =?us-ascii?Q?I5SnLgtMfnPBISkgVwBeZAebww6VPjLKdTVyvA2b0RZw5jTZTNP7oWNMIiJ6?=
 =?us-ascii?Q?TOZdK/ZeVGeE17fzL10MW7FDhNlO+Q8AF9zH5nSYlxw7H+UdtGTME7chUeKs?=
 =?us-ascii?Q?DaMe8c4SUGj8zXAIAFb+fMELEzflXoSXI74X+cwopUdHYAQ+E+ecje7F01WF?=
 =?us-ascii?Q?c/XEFqiDa7+lpdNrGLUfeFS71rIVdAqfA1j2BSKg7QmaamOOB6ibk5a/vPND?=
 =?us-ascii?Q?YEJt0VpBP6IUtkRoHalCjKKMVkI4p6VLOF3l92hlATzjKOdMOTXxOwJnActz?=
 =?us-ascii?Q?+6bIxYs/hG3Tq04xs0Ibkl2dAQrjmAhei3srwO7kPumK3mcFr6pcIPkEvas9?=
 =?us-ascii?Q?btFM4qwAf979YFbmfpZaRY8ttehQtFOPvJbod+fRHC6BXjnmSj3kSq/R2iXU?=
 =?us-ascii?Q?YdUACEJVo1VLsVWVUjbUSWU5qOsxXZxpDAAEgtTvF8w96BHAocVkJn1nrimh?=
 =?us-ascii?Q?TQXDaUsRGFlV9w0QrG7lbbeDbC8yyMnzdAQK3j4mmc/oBdLuMhzm3tU8E4gl?=
 =?us-ascii?Q?zg/2lfmVZlK2u/ktJXd34hnI+TBf9iFq1L1u5pe2vt+gL/irtI0hkcaOGLmK?=
 =?us-ascii?Q?OycbFO56sNl8EqmrL796wd9q3evDytKbpZVyVyto1hbzDu4PB4WTDox4vZPS?=
 =?us-ascii?Q?oBVujPcwYJdAvRR6GispfgFADpWdZpvXA1sfY32NsGbZDgIVqTrheItJC4yc?=
 =?us-ascii?Q?hK08Px0pzD+9pZ0fRUzJxzDvSPBsnzXyPP6X1NAEm59MIXU9PBsHSYzxbtrw?=
 =?us-ascii?Q?nb8ba4xxWFNO5NR5jYJx5Jw6ZK70uJpZVaJIdRLmW3W/PITLGReG33sNMorX?=
 =?us-ascii?Q?UQUahvFc6EPO0mZnXKXvVcUza0BMZoF7dqiqE/c3yva0HbneO1ujdrW8oajM?=
 =?us-ascii?Q?x1BIddF3MvF+BDnW4mVgvzK1IKolznyXrUhRCy6VIjQlLkRe09ELjsGintED?=
 =?us-ascii?Q?ltkvlTMDgMhSOXQtJRt3L65FbV47HW4U0Qjwq6NfRbnnnwMSQ6IKI3p3FAmh?=
 =?us-ascii?Q?K2vVIR5UFMn5dUQYWUlA0ECOHKPSq7/X9jdbY1P?=
x-microsoft-antispam-prvs: <DM6PR04MB55791D8BC5243ACCA1C657EF8D660@DM6PR04MB5579.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(13464003)(6506007)(256004)(186003)(99286004)(55236004)(53546011)(26005)(76176011)(6116002)(7696005)(6246003)(3846002)(102836004)(66066001)(86362001)(7736002)(33656002)(53936002)(316002)(72206003)(54906003)(25786009)(8936002)(305945005)(14454004)(74316002)(8676002)(4326008)(97736004)(478600001)(81166006)(2906002)(81156014)(11346002)(71190400001)(4744005)(68736007)(71200400001)(446003)(229853002)(6916009)(476003)(6436002)(106356001)(9686003)(105586002)(486006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5579;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pIsqGuginvfDE2FFWbQIFvbhVs2DGeu5226iJfqMSYi/xBe5qtvUSkDK8E55PJTsViam6pdVU8XbDt16wpHZnnFxbBKNWOq42Gc5HRc+Uus2PflNpSrraicc0g5e4F+W/IjthyK/v+BqHXP9YUe8X0M3TrZhYgSDT7AM/iutnicrdVFk+EHmns4+dODXeYhkRV4R6os86TgYGvQq6e1myX+yvgKWpiTn4a/ordruzsICyn6MzglI0K1kCG5j6nVk4j3h8j0fNiVBuq3GAP9GH+agBoN40aW2XX000X/pzt8FWwwH+wOs8qMGhOQkI/LcfmHFAcoL60lqEC5S6/2TUyZllAHm9FGvDtdX2M0BJCOIPPG0GTbBQXzYYbPTWKUOoAgzyaLY1dG+t206plhHqoOxzK5d5aj1UZZVNEGpsSQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd69938-840b-498b-aefc-08d691a5c62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:24:09.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport [mailto:rppt@linux.ibm.com]
> Sent: Wednesday, February 13, 2019 3:30 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>; Albert Ou
> <aou@eecs.berkeley.edu>; Atish Patra <Atish.Patra@wdc.com>; Paul
> Walmsley <paul.walmsley@sifive.com>; Christoph Hellwig
> <hch@infradead.org>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/6] RISC-V: Move free_initrd_mem() to
> kernel/setup.c
>=20
> On Wed, Feb 13, 2019 at 08:07:17AM +0000, Anup Patel wrote:
> > We move free_initrd_mem() to kernel/setup.c so that all initrd related
> > functions are in one place.
>=20
> A few patches after you move setup_bootmem() that calls setup_initrd() to
> mm/init.c. I'd say it makes more sense to move setup_intird() to mm/init.=
c.

Makes sense. I will drop this patch and I will move setup_initrd() to
mm/init.c along with setup_bootmem() because setup_bootmem()
depends on setup_initrd().

Regards,
Anup
