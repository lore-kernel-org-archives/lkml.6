Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E635C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611D620645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lhxFrKXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611D620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIDUga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:36:30 -0400
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:2272
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbeIDUg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUcibgYljo17K4El5sPGudzzpUfUGlJvBT6omDV1rYw=;
 b=lhxFrKXhAPl7SF1GVLV2YeIye0EuCIdTTbZbbTATmiehHlCDOx8PrmHV2pzHJR85zqm5lEFv4M7pTik+HrpP/DIHPrONsBEz6MHTQI1kcTaqqa6TFOghweCHXsCeyvXTyZh44VagnGZJCvlopIp+ikYwsswh/fLj/EXDCBgDG6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Tue, 4 Sep 2018 16:10:31 +0000
Date:   Tue, 4 Sep 2018 09:10:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        quentin.schulz@bootlin.com
Cc:     David Miller <davem@davemloft.net>, andrew@lunn.ch,
        ralf@linux-mips.org, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
 <20180904151653.GI13888@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904151653.GI13888@piout.net>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:903:ae::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 323d5be6-483f-4312-ce60-08d61280f025
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:nDW/VrTq6z+dhKaD5px0SLZ/eMoOTOosuvdnwhEMxbvZceAHfSxQWId9G2VwwU9mEnaHqPKBF0YrdZ3iNk1FEhox6Y9U8di3inB9oyq5SSd4F1MSRbboV8WIj4malMJsjmJr8fI2IQseEIe059FnvSJwEAkGcnhpBn/mqbsgUMoXnorznLq1EUkZGBAItaqflUFeV8PjPIxKKydHHJ2ZDvYzZ4gKwHcZuAbw5oNjBuVoWBKCkUmAr7PCJyy1m2Ek;25:Snvzlvga2/+Z2NybeseeVJDAayIbMPjaK/m93hE/B8G5x8lHv0+lxuSVByWi5hCldaWlJ1DVqAsQomuIFW8Ayn9DW9twkDXQ/E+BPsKYvxSmxH7f9qIScfXVmdKU8mlO68BFuJvM5Hbsd6Nza8rKoBxlTifu0WCmyI7N+l2Ll8Pqylvra0+Cjx/3mCkaF6KzpahCtrdletDNz+Q3pXmMhZGaRJo+BNmvhvKNTs1UWKZlCVOPj/IGpLKN+Hk85eACyJDKnsvGeyrv68YWk+eDNWSzsKWJmcGtdBCwctoHRaCm6k03knke+l63xe1xrKa3CrYRlvHBHocr4uFyUmd+DQ==;31:wI7i8Px2xdIMn/dQ0EmbxoBFiOcTROrX7VO0tXMprZKFtU1DdumKM8Bxr4mEA5TFZIrosv4mrTnwRYSOrNEbcuhaWurjMyczAzlXBIBDlJ1m0KwnuByYJqhT/CuHtU9wj5qmRIuswrb+CB5H78g2GsLhJ+LVQN9dKhB9XUxcW9c2w9Q3Gq8RACGeL02Fly4TkLOw9K+silQb0at1oixRPjwFjz6i+s5RqY9AAKG8Ris=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:qSfZmOLinDJQJxRNa30O655+FEZLrIm6Q0ci0CRB0Xe5kt1rRHe6YjA3wW215A7xlycA3CZcJXyV0S/JxetPlhtsUFD6mP1hbZ2HFswuIJnyTrHgnqpQL5GOfVQpygC4METmPcMrzRhDnXqL7EFqpJEG+Xc4fCYZumFwCADKFs8kgATQBnDVKMcS6Z6WSyQz0K4syhrW6Un4dq/Ugcp044oFpKc7O+b4MjJDkRAqMmdz4vzCojI6nbMiDarG99ZY;4:4VUX9ANiCjfukhcXFTh2gGfDf57vBg7FeLyb20E6VEc9ogIGP7zVFEVz5Edc5SfXFi+ajWuehPtbpSW1Ncgwb3KsZuMIjl99P1RKpCgLKnR5TZJIexBSdy+oXF5ozAy07rtRCN5a285rfGKpe6pG8rDyejVNNGqJLcD7bG37eP1c8WHwJU2Mvi6YoG6GQRnNvNc434lqw+QsD4lwsCtM2Wk2GtMQRwiIIK/tVX5/9YXZyjvDsPAKQdpsFn0FlaA7Y127T0L47lMcFp2bEPgcaQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB49421AB984C3C9F4A2839963C1030@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(136003)(346002)(376002)(39840400004)(366004)(199004)(189003)(11346002)(81166006)(81156014)(446003)(5660300001)(42882007)(25786009)(476003)(8936002)(4326008)(44832011)(386003)(6486002)(956004)(229853002)(26005)(76506005)(53936002)(6246003)(66066001)(8676002)(9686003)(39060400002)(93886005)(47776003)(23726003)(6116002)(52116002)(3846002)(478600001)(1076002)(305945005)(7736002)(6496006)(76176011)(58126008)(97736004)(7416002)(486006)(16526019)(106356001)(186003)(33716001)(68736007)(6666003)(50466002)(2906002)(105586002)(33896004)(16586007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:ma2lK1LECLvZ7wJjsAsLzBEpxg2jwP41Bz+HhX+wV?=
 =?us-ascii?Q?lB0KEAuRKYAc1eAdj8hdbzkhFEuFVbsoa4f5385FBr0JuPQRjP2m20AnHlL2?=
 =?us-ascii?Q?ZEXM5fE+1KzLY2p0C/3xZblS3562j1+7EXi4H7X9aV9mymVgmQM1x18RVUaX?=
 =?us-ascii?Q?L99At5FUFdoEWDpUHl1BqIfpUrmnQBmWYvKGvmwJzKod5/kfxZB/wcLdmswa?=
 =?us-ascii?Q?ygSP5i/NZld+wWoKN8RM9nQB37tsPhpqVJRguGlyGXjIwcOmrBKR1XWmqiUh?=
 =?us-ascii?Q?MumtNJodkFb4/Tx7RtwlUzXjkFOENkgdCNkEiaauHP2/flWbEKmtOL1cd9Ic?=
 =?us-ascii?Q?7lnWEM2TZZj+35XAoX6wZGDTOC/4aDYLnMafGhsGDwMmCi1jxl4KCPi2Y0KI?=
 =?us-ascii?Q?e5PlvcBEb9t8wczeQgxKozbybrMBn6li0p+SojSZetFlTTrOMIx/Ozuj1e6f?=
 =?us-ascii?Q?wZul761RPmjBt4KlRV5spZDpUquHwh+g472vLFxWZvU/GpVBjwkFVrO/9E5O?=
 =?us-ascii?Q?NlBvsvvc4+j3b7/cTZs3kgECtAA6yzsF6/nIgIhuMr60R9e7qNqHtk+eNbK3?=
 =?us-ascii?Q?zAtUHQukOIoW8N3Z54m5qXZ8V0J8g4VEeemhJy9siSViBEKpXJIIuw/ON5PK?=
 =?us-ascii?Q?iyokXc9EAPN1pZEDKAu/psrBxtZQ5Jlg+FdAeQf7utA1MSsknZq+P8EWHMLS?=
 =?us-ascii?Q?t962vG/oDAJQbveiclAJ3LlE8ru/cYh9JvwrQ4O7oq8HTLfIuw18TbfWfOiB?=
 =?us-ascii?Q?EYqRCxVMEScdDCQoBSS7VIuh4ry64zyqyE6XAWLAvFZfFL2AU6+Bp5xh9cw+?=
 =?us-ascii?Q?5VgUVhl3gJKSsl8R3neQXcj2253TnZxIoZeyyqxZmg+V57vaLiri2zpchZZx?=
 =?us-ascii?Q?m+GFBIRlbyQwm5ZOnDqJemETSPn6s7wCx21Cgl3iiT09kjTzKCptqc/E9Nuc?=
 =?us-ascii?Q?wY5wlEDR59lboe3pP9j6x4UUww2DDrkaFKe1ZzMYOYq0kl0a+UMHb0nvZfRi?=
 =?us-ascii?Q?CbciCBb8Eh8FjqEQEHSbAhvd/bn0kFRF6IWGbK21YQ4C4+C72NnYR2gsUxR8?=
 =?us-ascii?Q?qeR7hC4DNEb80aJ2FmoGFmwzdMCSm7OOTLMXNHzTvtnnkVU5CSgeu4rCfTtg?=
 =?us-ascii?Q?TLRRrLJxWY8rwhydz86cT/9RFgxMZHSYLldgHa8uxuwXeUsV6SeYZjZYPX/y?=
 =?us-ascii?Q?VX/n0w5n8h6Mttvc1LE2nOFBGC8ZPqp5jPZ8dx95LRaMpLHMZ2MnAhUNh+R6?=
 =?us-ascii?Q?aoaiHpt0DELa7cIpdk3vhXnAcmb4nFWkpUZvalbYyInP+IiRj5De7ASOhUgy?=
 =?us-ascii?Q?73Jz5TlAUgL9gzfD8EBBd3K5euPmoueXD3gGgsZAtYx?=
X-Microsoft-Antispam-Message-Info: Wdkr11It+VBuq/xEmrjzdT6P+a+9zARGEOqNXQA/tvjrknVKCcg/c8f8Qf5Xp5Ii1xdnSh6l1utY+aelQ66DE81uvgl86XlhiEN6rAIXYT20WdggfTXUHwPj3M+bNjPjtiA59J30WkNVZ8utVE02KKGRBCR16OzSjKyn5uNs7Engn5mzrD8u3xlob+Ancii1htj0MKsvyl6Q41iuKnUv5e0f+hQaLD6pAEHd1uxC+r8PJzTaWalOAHM92KQRa9ooVNup/Zt+EI1D6Qm+7zJqkxsjy17lUucwdecdULF7B+nrQDSAuh+ENbW2GS+WgqHUXM9puPy6X4UiEfesAfQzqje3erNNmCf+FJfPbWGIz4Q=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:1+wm7w5447Q5KAsjZo5CH3u2qg404DpQwt0dGzkPDrxajfTGY/r235PGjA1g6s3ZdBTM6yntCc9Wd5Ixsr5QvPi5SSIRTY6CGlJ7nY4OY7qaY4pE3zowmue+jtnmfbhUvp9fQNWIqW6YFg+MmH94GpJLCpyA55RQ074B3diFRWnrLR31YpFW8ytadWWffF8PL0UeuRCxa/2xhu9Ok3Y4GWBNzWsFj2zLQvEEQNkOeVzc93qXQy1Xl1iG/gM6BilmROD/qiTech9hMEq0azwLXbSMY3jAHDN4JL4MJ9G8im4g22fFG8Z1BPCeemdQ+slKHKbg3brudi04h6BMHqUA8lwqJ8nd/2WDB9Jsi+ywOzgeNlcs92ojTsTI/OxTcfYLJoX2oJdkqnBXDXu9BI0GLpmYtzh+n16BtPE2oMCBGA3ulrJGQyGuBzYtaZMflYMTJzIj9IBKunJKihu9fYvenQ==;5:ORSoiKeRuxzryxTTHoZeMxccpGqs6Uj6yOL1NKXDVV2QtvsDkc+rFF87b7kLaMu91xucViqHBHUdsnj8Aui6Yr++8mrbR9hww4d+YnBtGdH9dyUpFr1R89EWeHX9ue2zLjfOH/hWJ6RHRzrP86DqRHFxYZ2MmMqPnTzCB7VoSBg=;7:G0Tl3K4pNatfe6KtzddENwNQ6xMWY8+aIx222/yroJaxS52x2o4mMwFovvJ5cxkr2cP//V/+zi203Y9anG0yAV8eXcLViLxKjb83M3ML8VOEUuqxiWm17xy5/XWnyq9OQMMA+y7ttnw0m6SEpN6cMoMhN7+s1+os5X/70x8anO2sQh/t0DdCOd5mO6kLILj0yRfenNXLXmgycmti5/x0Pg3EdM/oouGoRZMJkWw95WkYhO3eGJlrMuGtRKvEL9xK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 16:10:31.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323d5be6-483f-4312-ce60-08d61280f025
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, Quentin, all,

On Tue, Sep 04, 2018 at 05:16:53PM +0200, Alexandre Belloni wrote:
> On 03/09/2018 22:09:10-0700, David Miller wrote:
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Date: Mon, 3 Sep 2018 15:45:22 +0200
> > 
> > > On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
> > >> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
> > >> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
> > >> 
> > >> Hi Quentin
> > >> 
> > >> Are you expecting merge conflicts? If not, it might be simpler to gets
> > >> ACKs from each maintainer, and then merge it though one tree.
> > > 
> > > There are some other DT changes for this cycle so those should probably
> > > go through MIPS.
> > 
> > No objection for this going through the MIPS tree, and from me:
> >
> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> What I meant was that 1/11 and 8/11 should go through MIPS because of
> the potential conflicts. The other patches can go through net-next as
> that will make more sense. Maybe Quentin can split the series in two,
> one for MIPS and one for net if that makes it easier for you to apply.

I'd be happy to take the .dts changes through the MIPS tree, though
looking at them won't patch 1 break bisection?

Since you remove the hsio reg entry it looks to me like
mscc_ocelot_probe() will fail with -EINVAL (which comes from
devm_ioremap_resource() with res=NULL) until patch 3.

I'd feel more comfortable merging this piecemeal if it doesn't result in
us breaking bisection for however long it takes for both the trees
involved to be merged.

Thanks,
    Paul
