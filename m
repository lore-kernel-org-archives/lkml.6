Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF5C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DC121A65
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LrpX4KWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DC121A65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbeHFV4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:56:19 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:3712
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727585AbeHFV4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Pu6cikT1tZiISRPQD7/G/2G/3B9+KMeWEpYh0rCO0=;
 b=LrpX4KWRY0DzqlwLUgAQF2sQBZkpBXBJfAWIuExiOQ69B1NS1MN8FjX9sQRGUDlr+rtrm4Hui76gd54flF2Qdcm+IFVmR9hyuJxHQMCp1eisgat0BUgdQ4Xb+9bIl139KkKvzydi5hs+V0S7mWosGIcx/Qqrmh52P1AkAFHxS78=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:45:37 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fmlRW-0007DY-2R; Mon, 06 Aug 2018 13:45:26 -0600
Date:   Mon, 6 Aug 2018 13:45:26 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the tip tree with the rdma tree
Message-ID: <20180806194526.GL5007@mellanox.com>
References: <20180806145331.68538a0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806145331.68538a0b@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::32) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eee4f176-8667-455c-2d38-08d5fbd52f17
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:EaEOxn/kwJEKd7tITcmeKmmazP1+lz7fM7h66CdlxI2Lqck/AE0gafee9tJbIWZilpEq7VUi2hZz+kwS1yGbQFroWsJdtRPRLd6QaLGvqarvVtZ57IA+cgDDL50TMnsxGV6i87gffoXGJa0wP5lirzspjL+ad+2PHYv0SqkaUgoEclAD3839xDaxwFuWoPtWknPJvR/XobGMVoaeZZrdX29j8tv1W+vMN/DHmMpiraXI7Po27OklUXGu2rNx2Plz;25:81EvnWl0om83O8uko6q2WpibnWG3Hm56GVJvcCkxfP0xr4/B45KrfN5Dsl+G9bidnVsFzH338mzBhkSxB9+gFDULg5+8MIqnzn/FxjPQc2hARNpOfGn2hBfkT4Vcupp6x7GOq28sfliqaGFE3os0xNYkDPGeYEt7Sk0fj9KquN1kC8TX+YZfcNrPorwPPRHuyPUBEZLxdmcczH8bepSH6/7beJxw0Exh30ng+r/0JNOXWFMqpTDdmKCH3kWHHxEOQLsuYFnxxKYuswJR6iO+eJTeH51zBWa6jG8fT5wfInxhV0RU2OXRIFQnJuBiMEJmtHkzAMFSXzlscoOd6uN49Q==;31:zlAP1IciIG+ZijPYVExbhI4sdpcg/96anwgDSkkSBVQVtRYkd3ir2BsxYHfCB0PD2yQZ9CORbK9axt7Grgtnd0qhMxmnBiXu8qTSs619kTS6LIgPcKoz90lRD/NOqJesjn1RqunTb8Sg0vzf/4n8ayo3z3YTn76knQFX8F6hYJHtalC6RZ/QyK2KzqejJzQRF3qb9RFroV5D1/DjZv4tCbno85Bl8gzCqhIrwnuKiKc=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:J0o9/Zol1qQepFsIVRsdhwHYyUNc+34MUwcCBty7EMeCjoF3AW8l3il9oSMXDSqmX/RHHJyei8vNx1AUT8QEWoZ4snvRn70ES1UQ6B+z2Ui/9pGNr0lXfEsd7ruokme5p0U92wVEeQD7ZLccb2morzF3rm1NESRMDBQYxEIjs+Gzsj4Ljb0dJuX2AJHNh51yZWhubdQCqiNQKjoj4QnQmtLaIM3tmWwrZESmDRP7SIIYhDzzbo6XlgeBRLk8nUbxWqOuOW4zvkpUSgkeATsvDTh6QBFD5ylG4Kwv5OcJ8wyI3CWYVdiJA1SCwoIhWDTyH7VYj4E374Mvb5UWOJA7IwSAZ9r84Zcw+KF7edxpUm/UtuPkBMMu4LmRgw6L4zY1fKO/UKD0aaPWoFDR6SClJ17QpzOJ/xGSAKy4hyew7/2ZVGxhSkERFSVQQnriRyMwGXSF6ihbXWRYNDCrjty+eOB+D+oHzPI81li4V2nl7BgKnTTPhAJ4JMysptIfJ/6b;4:harIp8ZM0vMtxunXd61UYx3GzHrGF1vEuLjTmWi5L8pseGBv7HAOXPcf6cX8zqCYYDoM4AMJBiUHWsoVgSsFlZXIzufKdvnwrWqYgDw1aDCVyAFOz01mktiaRCnCZtbR/T9AWevLfHD+2qFPYFXVtjkshEDdR8IAn1WDnQkfXQ7ctjb8/SlvwfoLpGd+oJ3q8W7Gmi6W5F+yjee+Y7I9N9LGP+qsX7AJ1W0hbLxzPrqo+q602E/oBZwyjaFqipsRZvKX67W8kYXBa39ZanO3Fw==
X-Microsoft-Antispam-PRVS: <AM6PR05MB44545491270BFCABFF032E7DCF200@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(53754006)(50466002)(186003)(26005)(105586002)(386003)(229853002)(53936002)(83796002)(57986006)(23726003)(106356001)(16586007)(54906003)(58126008)(4326008)(316002)(86362001)(52116002)(36756003)(66066001)(6246003)(2906002)(76176011)(47776003)(46656002)(6116002)(3846002)(33656002)(1076002)(478600001)(69596002)(426003)(446003)(6916009)(5660300001)(486006)(8936002)(79686004)(122856001)(2616005)(476003)(11346002)(97736004)(7736002)(9746002)(9786002)(68736007)(8676002)(81156014)(81166006)(305945005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:xz2PeMMgu8SWujWFmwTZVGdFkw9XWbc8UVUiSoGw/?=
 =?us-ascii?Q?TTPNz/cZ2OMa6/ui0j9BLtxq0qFoAIHptMDgAu21dBNJflkAubLrv3HAp/Iw?=
 =?us-ascii?Q?dWGFJLyyiTt8ZcatPK/OEM2kzoRDazbwyxQTJM6irpoEMMVM6KUrJ6aOwqEJ?=
 =?us-ascii?Q?h2x8SaTajmG3k4mA8VIxXuchZdqFF6GZ75wiqiT8bTvCpM6RpPcvy0PvKICC?=
 =?us-ascii?Q?u0IOZT+1YCpb2+zZprVRkMLSXR6vD+2IpQNjefeVhhFujEiVVdrc82pGJ/j2?=
 =?us-ascii?Q?8yUhuqBES4sbBFzyg8RAeiLswcCBlyHQJZBEj+YFZuRu/b8V1Um6TAfCvFX0?=
 =?us-ascii?Q?IiFlxr+cD4gRzjsvVgs/fr27mh95etMkFCXpxzIEB/xi5BakRKy8UDjlI4Vz?=
 =?us-ascii?Q?8nLYuHw2ImhZGH+XELPVQK0t8VDRfjxrlXMx7TugBPjKMou3j1gPgWrd49UD?=
 =?us-ascii?Q?3sOFyIqlXhZ5F7M5A/bWQYlKPWicov2rM9AO7xZpcBr3NPJJxPWk+F3h/a1R?=
 =?us-ascii?Q?0U4zDGMQD+JP9fGhoHIZz0isFazlkUxU4eOCNNkRufXkcb+XF/njUjlOzBBI?=
 =?us-ascii?Q?CMKH2yo9BGRQun6ODTIZnA4v955Y/ejNz060fDGDTUJ8XcO14GdbITFaQwd8?=
 =?us-ascii?Q?InY20N1VNgWTsVwgQJr8v+StSZOQXTziJBZxKr1xuD4dKxbgO2Rfcu+AjVpr?=
 =?us-ascii?Q?rJ3R+KoEqAoqXAUgOOiTF8LOO8Z08+eX1ZB2Ce3iovlQkk4urF1AhK4qoeYz?=
 =?us-ascii?Q?5C53Cv6QglUYgC0vITWBYWgIBWBBi9qGzmeO82E7Lp22OuUda6DwQrIx2YEI?=
 =?us-ascii?Q?0bs41PTm/6EIfRB8ULPgoqQ6NoAHfYdfifOjWndic3zDbQ1zAbj6RPKXJra4?=
 =?us-ascii?Q?7Mq3S4KNw2TKS8N1J+qKlFvLqkfGZWOFexMDVHKKDnuywa+4Dn4oRJkDL8aT?=
 =?us-ascii?Q?Gcaxht+Ogl0rFTQooJ7af7ncazDCxuyyGvf1ANMEx/nXnf2WPKjxq2mt+et/?=
 =?us-ascii?Q?NnaUaWtULQu6NVWo7xduZbk/lkubBSDgSmR6+6zwk82lVJozNo07dZPpI8p6?=
 =?us-ascii?Q?NU7gkhYCO3NLm8lM1RUt9zbV7sc4uKHBPdJrnILa8M+f5ppumu43wN6NHfJj?=
 =?us-ascii?Q?jhVkDCEvm4ks1wTgjxpPyuB0WKb1LIUg8i1r9Dc3m2Hh1p86aYyIgw0RzBW5?=
 =?us-ascii?Q?zZuBo8NbXB5vs1V+tdQ5bOllGrZ+bw2wHfq/wu1+Ez90LvZkXbcQ7cey6nSO?=
 =?us-ascii?Q?ETYFzKnL07h33AGfpfWS/oZdx60UX4TzUr2il8vrHHj4G5eRW8qlZ+aAyMFq?=
 =?us-ascii?Q?kNVi4Dy/RVGDaGRxBkUJoXZ7GOGGGoGa866C/j/y+mCl3HSzF7GxB4h9tNFs?=
 =?us-ascii?Q?k4r9BhOvHr+RCscDwk4vQLJ1E3LFr22DwixB2jOSm8GZ2BY?=
X-Microsoft-Antispam-Message-Info: K6I3OKMYQpdJH1rHDRByB+BsqBpOF9Pdi3X6QcwwYgoUz/zI6DomPl4uV1d3na1cqWSrM1Zl+R5+CEriLNKzh1T2LDH3vx8JM45Gx4aaZD5DmqdbJd8qtDtFFnZh63tn8WxBgRIrCtr/obM8riB47ccLsWJlmwICNJMPO5gyTkAe6JwN/AEGoDWJuw3Da3P4QriQfMIxf2+BJCkHGli25xXtM2jZDO9zRPkbyzIiPIIB5yB+MRiz/gqzMUytJm2EEN31y22CIatylKJ2M4vRdhyqKfcrO/O3LO2Kyv9SL/ij8MoaEp7vYWmfx4BMGDEfFyLXXrJQ4d3H7VybgsEnHnT/3yWArSsRe4TqKq0wc24=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:osH8FgzfqWtso+2bca64Y32pnILPtjS9tFM6cE9y96f/ienHVY2H7UMneJXG4eFLXnlxpY3/ZAwACJVhHOmet/D/Te3kdUzzncNKWsyWEyLOO+ffsrKIztO57q9dANAwxZOJoIsByekFEodvptKJRchcC3RBlnciMCbqdkPkpeFcUzoP5yHEWtjR/ekEvVU+n1HfXCpO7a+t0c7qty0tripG2DYBsR8Rw3nNR0jxBIWnZ6dNAuEWPNGNSHEOD12aP08GRbzZ9rdfg0hBlgqQ+CiHctOw0i3v0E5cgGgUelQIzmRAOn7c37dAg/Q7Isxs7FwXA3NZtcI1O11QXNHwDM1urbswRf3dXxXgBoMs4yBR+7TXXcc75ZkaCV7k+W8JzvTSYyE7IkXUoaUnScAx7ekrSVcglZketdW4de0/cIj+VJwuf7SRJyWGm3ecODvSjmlV727peXxPqWZmEj2IDQ==;5:/lu2LBu1RBZAORczNULo6gg5EN8C2N5GI8wM2N6nB9RK8AbuHklpauoWau/XgcGynyGIgW8HnVLZI2wBE4Q8jdzzQDSr2iZAxKpvRCdUae5B6c1sY6Mx/NpcPDVa87V88IYw9ip0rJeWtaW6t6SohdH7wLGrAQEfWQKbR+r0LBU=;7:I4LXbbbG2Jw8hgN8BTnMzDLb6UJALOgvD0uVNPUMYXsVZ1R89XHYsmJ3T/QpnXY/UkTntd38Q9QtKIJb466ws6flnlbxQ+Zi8GI9xxoYwZUGHJ3VqDBOfDEw0BfFK1hZQkK5J5ewSGemrmcMBzedyMuf3agoqTz8mLmvoLf+2XpvsCiMNYVJWBaLc688W4IAlTd6CY+ZJk9OfmbrFHSVQwNeF0r3OB6s4fHulYbepjt3wTXgXZutBE3RXcuyfGFH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:45:37.9447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee4f176-8667-455c-2d38-08d5fbd52f17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:53:31PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   drivers/infiniband/core/rdma_core.c
> 
> between commit:
> 
>   9867f5c6695f ("IB/uverbs: Convert 'bool exclusive' into an enum")
> 
> from the rdma tree and commit:
> 
>   bfc18e389c7a ("atomics/treewide: Rename __atomic_add_unless() => atomic_fetch_add_unless()")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Gaaagh that is a big conflict

I was going to do this next cycle.. But I'll try to push a commit
consolidating this crazy use of __atomic_add_unless into one function
so this conflict should become easier to handle.

Jason
