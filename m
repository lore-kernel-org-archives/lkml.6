Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A58C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEF120881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="dyz9kWc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEF120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeGIJ3x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:29:53 -0400
Received: from mail-ty1jpn01on0109.outbound.protection.outlook.com ([104.47.93.109]:45123
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932411AbeGIJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4dE1ImzI4zjtrkg0G498K8SIoDFKn5ZeHdJ8gknrfM=;
 b=dyz9kWc0g4x3OqC/jdYMMJgLPALIzb4ujNSNBSqopK79TYsCDvPMaDQenbJUiqEHWn11CxiJIIYp4FXOENa9pIQjOYEZ5We2ik6YajQyWjOWNP5rvM4isj6ZwUdWY5APXk5FBc/4NU/nsomNFfot9EZEQrRNjDfojQVh38lsyVY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=masahiko.kimoto@cybertrust.co.jp; 
Received: from localhost (221.114.197.178) by
 KAXPR01MB1272.jpnprd01.prod.outlook.com (2603:1096:402:1c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 09:29:06 +0000
Date:   Mon, 09 Jul 2018 18:29:02 +0900 (JST)
Message-Id: <20180709.182902.1637265651643155858.kimoto@cybertrust.co.jp>
To:     f.fainelli@gmail.com
Cc:     fugang.duan@nxp.com, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hiraku.toyooka@cybertrust.co.jp
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
From:   Masahiko KIMOTO <masahiko.kimoto@cybertrust.co.jp>
In-Reply-To: <8a437ead-5ded-57c4-c44f-95986442d626@gmail.com>
References: <1530857230-31124-1-git-send-email-masahiko.kimoto@cybertrust.co.jp>
        <8a437ead-5ded-57c4-c44f-95986442d626@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Originating-IP: [221.114.197.178]
X-ClientProxiedBy: TYAPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:28::21) To KAXPR01MB1272.jpnprd01.prod.outlook.com
 (2603:1096:402:1c::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d985b0-79c2-457c-ecd4-08d5e57e6ad4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:KAXPR01MB1272;
X-Microsoft-Exchange-Diagnostics: 1;KAXPR01MB1272;3:bjEevLDGSvx/8PtUqz8LivG2rEVW4IXMQHnsq0lyC+fe5VcNwOboRlkyTHOmi9L+1cK5i59FgryyAALA+FLqVGIWYOJzNDNcFznL0jeuv7MvJ+zmgOuMiRwo5b9F6MeCC+BqczkzcRvU/fD15Stf/8xoWRXHpCPbitrQJlqlsbLsz/J7EpqmmfIzdrUKFTgk5lHhLAgYYqdSLth2/nvoRaQlbWMG2UhXpjBVxclrZn8o+Ofzj5Zt6RSKV8cY15M5;25:eIcTb/rFXZPQg3uh0JNHO/mMYt+QZIhw5dxoCBMNhGMiYb0hknAUZ1qnBEtyWVlLS7IiWeX9bPaGpVBXOtsGX0oIVh0nOU7ClI3S5RQkMXf4gni0fiNLTScLzqwTL90loKNbRyKWGvV6KRcHuVyAMqXj9mC4jJPHOzQW8hISzG2dMDUQJa15aKJxruSVC6lPuMFZn0o5gY7hEeztcr3sQxqO2zDo/TELntrkBTTr587m7omYdmUF2f2+0tBL67T2ZcWMiFygtgVYAo7aPulrnQL+VN+gAGRxH2DVrI8GpdfkqtkCmfNf17wxgtiXmmpTwOcvyvkU4dEyZojhJ+fvuQ==;31:CPN7mfOhcGsGF1uCPYkw0r7zv0ezupPkgH2mwvfOb6hhasQfaHDot52DuF/KyDmuFYn9YRGZjltbr0Nm/gp2zw/NrfY4oSxELdUceepbR6Fros/uicMA3I+baq566tOm6ZoE++rpjfzezjBSVL6RJJqZ++hNBBCit/0hlf2sUjYkubs5EIasi6MFhuc1R0vrFm0JZGwNfe/IwWhXodmw7v/8c2Es+AWJ1DGd9U8GqHw=
X-MS-TrafficTypeDiagnostic: KAXPR01MB1272:
X-Microsoft-Exchange-Diagnostics: 1;KAXPR01MB1272;20:Q6MNtAoELW7ty9ALDc/EmreLYTYoPPCNi5fxZ377Mx/IXmJn9m2C+sWQr6CHuQFNhdaNd8JGC2aJAExAMf8+ouZdOuKdf3YtsJHNzaMwuau1DbaHeHtvFHd/XJq3u1q3CsKRZsP10+gDrD/Lw4wM4k9K68I/Z4oKimj3JrkovvGFaiwK+pMoMPoLaL2/76RkWD6dCxlgtC+n7uOdEKnHfaszLq44CxGBh6VPX+fVcvSd5H0k+0o2AN2MGvlaWJ26+GqwQw/SWlgyLUIZDAB3O8fMPIVLiqCn7hO2hOHxnWywpvGrFyGrq9JGYs7JqM9laGsJyau21ORcxDzWV5h//YOYk3efWScdEu3RmqWMn88t923jwgshCASai03SXaTUmWCWiqjWRMCDh2u4Kq8wXHQJbWN8DfAuEcEQjq11nWx2OqYpHM5gKk711vtd3r1YdyCdVaXDx20+cisLM6TKk+cb+HQyCKXL9MAVmFmgeEvbxF/qH7a1MlUwb8BISZWI;4:4gnPDPlq8gacUpxo8eaQhvrlKRKb/iEl/Zfh9yebAGFbTZNGtQ2TGtIH1+bJZssJRnxvrGfGe/6PYj4WaEzTvoMzJnCWc406foD6wDhkYnXR82NT539WS2gFi9SGXVPEPuzwZOdNpQgW1UzWK21bC93pK8H9Lso5Aha5V0C88ZRyO7z+rBIQlCqDOmRjVRuh9me6MyqrvNwJY1e9bIsXM2IiVH64ylGiYE6R10hlPAyyhM3guMw8b2Fm0hs2gWKogeV+Jwr4eI9ND9GF1Eynsz3AURqRwb26uqmJmzE6H4XBEmsp6S4tgmr/wPxEkurq
X-Microsoft-Antispam-PRVS: <KAXPR01MB12727553A2C0C19A190C823ED9440@KAXPR01MB1272.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KAXPR01MB1272;BCL:0;PCL:0;RULEID:;SRVR:KAXPR01MB1272;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(366004)(396003)(42274003)(199004)(189003)(478600001)(68736007)(230700001)(47776003)(2616005)(345774005)(476003)(956004)(11346002)(486006)(6666003)(6916009)(36756003)(305945005)(7736002)(6306002)(3846002)(6116002)(5024004)(39060400002)(23726003)(2361001)(107886003)(5660300001)(81166006)(81156014)(8676002)(66066001)(6486002)(229853002)(103116003)(966005)(74482002)(106356001)(50226002)(316002)(53936002)(6246003)(26005)(76506005)(86362001)(16526019)(186003)(25786009)(53546011)(386003)(105586002)(446003)(8936002)(4326008)(97736004)(2351001)(6496006)(76176011)(52116002)(2906002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:KAXPR01MB1272;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;KAXPR01MB1272;23:G6UMm0/qbpg/D4jjunuw756M5Hw+p8mDOUK/c+Y7z?=
 =?us-ascii?Q?pXPU5HN95AsXgMLa9L8iG5lDmtCmX84GQ4OpWoPucvKlJOpK5asd9rxveKxR?=
 =?us-ascii?Q?BKQ8ljM8KxWctJpFlypsPy9oQeruxsXean4Z4RcfXqPDq7g19C8OGqCWa6Io?=
 =?us-ascii?Q?TKU6WCEfzkGpJylwQHR4rQIZ89KXrgjXJqu3K5YoNtHOxvAYLhXZD6x9dUqm?=
 =?us-ascii?Q?O8dV1OXBk552t229M6XRFQfsXDUByIrNyU+jZBClwTceTNtzq61uHCxMV5V3?=
 =?us-ascii?Q?tSiqKP/O7remcsImSJMf0f8a1qWYeysJ+SbuYWAHjoG5dDcgOoaoXDX4oXtI?=
 =?us-ascii?Q?ZrDdqDW7j3NxreC0FbGllaj9ZxxFVffPxLXexNnhXNqqov62QXuPxuqgjVJb?=
 =?us-ascii?Q?Xqko/nZljP/cVdaXXOfN1N5DGwaT2Zr1M5ND+ubdbjh+gK38LlN8/ZzGMwaZ?=
 =?us-ascii?Q?ND8R1RHzu6QbM6+kGUFHWyh+2LbLOfo2NjgyPnfkFy99KaqSXncHmlH+bxHg?=
 =?us-ascii?Q?6j4QmwZU95oe8kwRKcsytqpTz6H5OpOgMUSklGxNcyJjgnz90fFGDViTxYvq?=
 =?us-ascii?Q?RocpbsU0/U8JlZVsqNQOewNYpDWCpO1cnPERTCbXK+z0ADakk+tq6wu6nlFU?=
 =?us-ascii?Q?MGJPdKCCIpYjCD07OntAptz2NvPY5UP8xMIW/6jICaQvZd11foriklHjqDdr?=
 =?us-ascii?Q?zZDpCZRCX23G/RUoM+pyR6S9Qg5BX1Jd13JQnPmnmU7Xw8qsbV9gy0wSMFZm?=
 =?us-ascii?Q?whm05tL+CwqGH4leN/qHZZDOllu3SOnrnsVF3TEVRvRSx0NTxLNxRRj2vtfJ?=
 =?us-ascii?Q?2cS4tEhaWCkIiLuk+agvH6mcvEXMe/YQAZarZ9JCAeJEvaRJ1KXE+bfzRv5J?=
 =?us-ascii?Q?ntsjU6jU2BFopDpSsG7ighV6v3XNtfsjIXfKc6dn4LfspDDQdtCq3XROh2V+?=
 =?us-ascii?Q?pX5M1KjeqIxiuZ1I3mIk529zHyF8jAJL0HuWFtzducH0E8d06FIfzMJncogF?=
 =?us-ascii?Q?A/KQCIyiACm9/bR4srbfPzZHDhUH+8quWkGJzUY+M+j/W7AqFkMl7duPimze?=
 =?us-ascii?Q?2eScujWeifGOEow08CWbttDeUpGezpAKgWbshJRNQOURayn1F2b0Wy5xFF3d?=
 =?us-ascii?Q?bUYx/YBLztKapmWmib2XXXSty+OfGRwPOhLh88UD6+btXTXzDtsLaH2jiNlb?=
 =?us-ascii?Q?gklQEV13lmC9h9rMIX9+RrRpqnPKI0bALplGOltNo7vIVvV4CjUv8a3/CazE?=
 =?us-ascii?Q?IBGX8suyV+1rO1QI3Mm7X5+bxVH6OPxrado0LZ4HM9Z5rbvGcly8SjOsBxPg?=
 =?us-ascii?Q?Lej+/qW1zBs/mcttifuulRJHLrHgy8+rSr4c45BPsaZ6XbljjyHrei8IESuR?=
 =?us-ascii?Q?8kixeNLXzG8PbeUs9gvfY+Ci4ePN1hO/9nVCY7JChYkXEF3TxT14S4lDyqp6?=
 =?us-ascii?Q?G2HvuBLm5FBtUmM6Tmh/rkSsR71Cz9o9ZyaPq2qw7zOC8BBz4PD?=
X-Microsoft-Antispam-Message-Info: YV132RnNEaxpgpb5TBUeM4f+370B8dFoAKDGm1k3GOsthAsm4mr5cq+jGsWm6pP0OqlP/F3Pmr60834ihtxWDIpsgKU1k6wlJ89T2T1VncaCcFodkGTYwykXXd+n1yFN2t+MVSQ5cA7am7JDwv4Qiz+Ko1O8CqMLKE2B4ENFrNaLzFWFSXESMHIe599PDkoZMtd3OXtcNNFOZ0BUKmrj186nWjKaLHzP1ZSa0KBfIgbY8iyjPL2B1rPMa9m6t/MwNT4l2IdIiq/2Vec+TEw2QR4dZs8U5KCbtwW2T8LLE9U+kiNfsrLUFkJylcgYxuL1CQDVQYKyEiR99q+OLa5rlxqcAVPF58J6+viEO6C90s0=
X-Microsoft-Exchange-Diagnostics: 1;KAXPR01MB1272;6:S328f7oZcOVaHAELugw1sKdV4Agqox225dm8+uEAslOFpFgLAUkPFDe2IHBtj2ZkRgkHPb+k/NXRYPy4HjgTXFsF33nSHzfWnjYnSaDgzUlRuseXS44mGfOVOn3GtEH39WL+TXOuOntMG4amHC8n2sP09D8r8SmYypnw9tkZDzHKhScL95e/YOLSb5FFJKskXE9rJ03xl/zhKrhLZrnCq8GMa9lbRUFFjWQMibQcFR9MG5aw4PlyxUX3pdNttwERweS6DV0rOdUIMucKUqBpX4H97QFwKS4iB3CPEeaq5UPGJems20wzoBpvyZkXckfFkV8HMfbKoGunii2SgjnMLyEto9Ws4+qoR6eOxqUU0LDweT1qYWuez863FAxPee+BQKZsbjAnroMdTtHtnjxPF0a+Ac7u8K2c5g6+7miuTVLBNn9QaZK1zA5lqPz4/EsY1t1EBX5780qk4bS6jwUMAQ==;5:RoWZqwvnqrd36UdqTlW5e4mLU7qfXW8V9uIYYpbmnl+apU0HfuoDLeCguqHOkfBFnbCYnW+vHJCXe/LE73Q4DTjPRnNgI3fT5pDkWTmhZeNH89t8oqI2eAPDqMBdDZH9Hy7GwgwnPW+2dOBcCXofZR0DolJsnGdc1/6fUItr3qA=;24:poDiowyYuBGczEhrqC9UNtHewbznXxVh40WxbssPeOJjEAvqaXiksH9eWFabGQ1+Hlt4UAzW/33WLwgzWpdOSB5WbC5rvj1w9EScc/T6Qm0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;KAXPR01MB1272;7:qagM1ukfGM84cU4kgNWvado/3dnl9S3tNmXPkGtG6TyvNKFwNTe5Z3EtBZBHZ4SV2lV9jkNjgBdRlvmbeT++E7AUyC03XPC5qiSuasxhrcY8gtF/ItIdQiols4vcVubDsR1ENP80WeeLBdwPK2afFLtUPFlBivl4FaQjRvjDhFo4gT8c3FovioZ1I5c8ZLtqflPJvrZOYGvOIyBy/hrvroLaXE2anfW8oJO58C5uS+HZLcOPR2FISckMXLFLSaSV
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 09:29:06.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d985b0-79c2-457c-ecd4-08d5e57e6ad4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KAXPR01MB1272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

  > I completely acknowledge and support the use case, but your
  > implementation is definitively not the way to go. In my experience the
  > problem is usually that there may be a disagreement on the
  > Pause/Asym_Pause advertisement bits and that alone is responsible for
  > triggering a re-negotiation. Can yo check if that is the case here?

Thank you for your support.

Concening the problem about PAUSE/Asym_PAUSE advertisement you pointed out,
I could not understand your consideration.

Would you tell me more detail about it?


From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
Date: Fri, 6 Jul 2018 11:41:23 -0700

  > 
  > 
  > On 07/05/2018 11:07 PM, Masahiko Kimoto wrote:
  > > Hello,
  > > 
  > > This patch introduces auto negotiation skipping for Ethernet.
  > > It is useful to shorten boot time on network boot like the following
  > > environment;
  > > 
  > >  - target board is NXP i.MX6.
  > >  - NIC is fec.
  > >  - using u-boot as boot loader.
  > >  - boot from kernel and initramfs obtained via TFTP.
  > >  - mount remote file system and switch root to that.
  > >  - thus all file system is on network.
  > > 
  > > In this case, u-boot and kernel initialize NIC three times,
  > > once in boot loader, once in device attach and once more in phy attach.
  > > Each causes link auto negotiation and wait several seconds.
  > > However link state is stable after reset by boot loader, therefore we
  > > can skip hardware re-initialization of NIC in kernel.
  > > 
  > > The patch skips link down in Ethernet(i.MX's fec) driver and initialization
  > > in PHY layer if kernel option 'anegskip' is supplied.
  > > 
  > > By this patch boot time becomes 3secs shorter.
  > > 
  > > I think current patch is dirty hack, because;
  > >  - modification is split into PHY and Ethernet driver.
  > >  - in the case of two or more Ethernet I/F exist, currently there is
  > >    no way to specify whith I/F skips autonego.
  > > 
  > > I would like to implement such skpping auto negotiation feature in generic
  > > framework. How should we implement these requirements?
  > 
  > I completely acknowledge and support the use case, but your
  > implementation is definitively not the way to go. In my experience the
  > problem is usually that there may be a disagreement on the
  > Pause/Asym_Pause advertisement bits and that alone is responsible for
  > triggering a re-negotiation. Can yo check if that is the case here?
  > 
  > Thank you
  > -- 
  > Florian
  > 

---------------------------------------------------------------------------
Masahiko KIMOTO,Ph.D. / Cybertrust Japan Co., Ltd. 
mail: masahiko.kimoto@cybertrust.co.jp
web: https://www.cybertrust.co.jp/ https://www.miraclelinux.com/
