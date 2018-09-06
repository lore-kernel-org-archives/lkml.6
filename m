Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745D420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rR0/Yr8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745D420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIGBzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:55:48 -0400
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:14660
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbeIGBzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW/nW0WLpih5Y9aOcizMg98bDYn7Z3xVyst5zXugrvI=;
 b=rR0/Yr8XFDxirEb54hrJIuYrlPX30rHtrYE+/YuElIn9ZUvPs+g6+6pcg3jndC+3eJUYqztyihOErT1Mc4y13+wkcc+/n2ekKO6wElyMRjXD+qWbq4X1vrFsmz/ZHKt7gn2Pf+UzTomvoecl4LnjZiqvfzQXzsbhT5lyZzJgccc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 21:18:23 +0000
Date:   Thu, 6 Sep 2018 14:18:21 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathias Kresin <dev@kresin.me>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>
Subject: Re: [PATCH] MIPS: pci-rt2880: set pci controller of_node
Message-ID: <20180906211821.auqlroxpx5qxo5o5@pburton-laptop>
References: <1536130286-32088-1-git-send-email-dev@kresin.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536130286-32088-1-git-send-email-dev@kresin.me>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:3:ed::14) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801864dc-8f25-482e-e091-08d6143e478e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:hQDLC860jiDAO9cuwk0PvpdT3xA+YERHbclBHGb2XLOW9pUDiX0pZJ/GB6ufDt/cNvCm2vJkUrmmWXrECD4jh3/CgleZ7nNjrI6CdjH7At2Mvx/edvR9Q/Rd1UaV6YiiLE77ByslQr/OWmjt4Nh4r1RYBvnBmLMRHX0x6bRhHzfpT7kmk15XXsHl9NGKVvn5IfwGyaFSEfX67JB8iSLUTpK+kHRggfov7aWhJHCS6TDeSm6yjSMiorW/4X6SQv37;25:yiRADiI2Z5L5El1/k2J+7rkio5jwemmetYQX0gLekPPhJcTaRSaw+Do1RYHTHUmMwQ13T+yBoyysWUKy2C+b4JEWO1GtdiooWb5Jrv3j8rcqXY134noPoLZaLygkqv8UoyFjKyRvDlkF+MKASZWrhTJHpRpxHD5iBq4BPiKdAIKfDcX0uWuSrTaaRO5mmEJen4FHok/4lG+OC9zoBUNqfDGtHSHvNgIriDDcITSgGDItkfbRbK5tVATHOrWDA2ODRZ88Lga3Qs6tUs/5pnSboxC54GGswz1shhOM/G85ykPhUNKbnx2Isw0cLt2cvrPLP24H1N0vnD5yztPEi6a6MA==;31:YTM5GaCplNTaw0hUXNNpTQCqcbwovfdCw8rAiXg1WhevCr9M59KM8ZTDrFbgfQp5cP3JMcgnHdTjA5AFGgLZqAlkw3Sutm7aWvZWw68m4Xr6x60saFoj4kKrh1nIdhi4EmBDWZ13L2+fMUrZRUxdg3lnTRsM2xCiNWWzmXcnvi8eJ+CQjjAEllJ//5zRR8l4L15du4si8wUqcvdUHkJcpOa+n/2veaZp/Sy47JIZ1CM=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:KH+NGNfcTfGy/oPXgenIpsiBw60BYGfr1d26vXPVi3La76EtBfG6xPb2pvPNMsmv0cIL5hSIsvCnMSyTSYZkEEsxGRNCv+9iMhkQbZyYEfDgKlqc1+2AUX56ycerfiIWWfanf6NRyTMNLw8dUI/P3SS7tSaw9ncr8lrhTHH88//F6zYYyXRlSWEuVgAQQ8t6LxKQHsRl0tM+nf7+0UiJ68uR5dreV/B/uWvQ2p4RhHGp5JLD833h413XKRBSrEoN;4:X3cKNe70z+hUSqgjInKCwTi6rzbi25JJi0pa40rEUI6vqC9k6PrS10Kn75hDAXQW8d7dZTOnO54p4gzAGgtCqqh6D36VmCPWmrHsQN/a70xsLasBYQAocLG9gU9RbaxhY+A1tPQtquuju2nMSMfolRaX0D/S3seWf0fla6uijJv4c4ARfTB8l3z9hUjipstDGt+PsTLvoMwNUvysIZJb0KRnKTBElebGyJ6OgmJKcb/mtzrzJ8Mzg09zPbxrgQZbo+YGtkIMawCH1ao+wdMSOQ==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4939BF0CAE56AF12A26BA400C1010@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(39850400004)(396003)(346002)(136003)(199004)(189003)(16586007)(52116002)(58126008)(486006)(6116002)(23726003)(3846002)(5660300001)(76506005)(1076002)(50466002)(956004)(81156014)(446003)(26005)(316002)(42882007)(81166006)(25786009)(6496006)(386003)(4326008)(476003)(6246003)(16526019)(11346002)(7736002)(33896004)(76176011)(2906002)(305945005)(478600001)(66066001)(68736007)(47776003)(8936002)(9686003)(54906003)(6486002)(229853002)(97736004)(105586002)(106356001)(8676002)(186003)(33716001)(44832011)(6916009)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:3reZNDqTU7P8fpljlyvDlGKQOvI/bGkGOGeg415vY?=
 =?us-ascii?Q?Cc8KjDfonZ6Y6Lyo2YrMYBJII+7ZdRvMHYh3mbLJGMOJjpAN4nn6sxRbLc73?=
 =?us-ascii?Q?pOBm6UwbQk3P3IEPVM0tTomup+14HBZVUV0P9d1nJakCKO4S27wDqI1O4RZ1?=
 =?us-ascii?Q?qviQ8otCH15YBmNr6uRAZxFvc5jxK+vnuPdFmxAex4XsKA3bDVtdD/+fdxe9?=
 =?us-ascii?Q?9ihJ3PsGJRXYKhudrJs6AEQLdCXpyFEEHo0kZZX1Ix4Sqi6dTFt8tP91PgBV?=
 =?us-ascii?Q?samTqr9VzvKZymGA3b1y+hz/2rxt8UfIal1dV125UUI8xJX8e0O+qKqcTGDi?=
 =?us-ascii?Q?71W+6A8RgGqCqOklqLR8wxibKNLn5IOC0wPZP74AtHELYYMGgCOWlro1Vbal?=
 =?us-ascii?Q?dVeGIPbq5SWcc9wpWcX8zCnpwIVqGZ7Fsn7iHCaGuuZqbm7AFsxOA24yAk0S?=
 =?us-ascii?Q?U2b4UNxrTUDuN4j/fplzxk0xLNYINUdmW7Z4gX6rQolGsXuxomhfbePaicB9?=
 =?us-ascii?Q?tV4rQsekX7HaPrjpvej4MB692/+wZ1XroXH6YyN1CTMDvMD/eeAeVa3cfvqS?=
 =?us-ascii?Q?oOTzfxIbb6MawDaMX51g2KTwVwbpy97GeX7jp0HHUtpGe/VGZKYwYYiulG9y?=
 =?us-ascii?Q?y7Cg0fkCZsK+fSeWklz6rOqhTPcN2bQEBg/HW1GJc3noz4XqPjmwnIYbAmWM?=
 =?us-ascii?Q?FYXks/Cbb8WI0S+KpEGcVUG11h6nnYv/F2mxu51FzRHLr8DXMPvvuspd7Zbf?=
 =?us-ascii?Q?llNrue5IXq5ugT0QKUAY0QojxaFTml0mzZMHyU4VT/JK1/yUWjT13DCYM9RR?=
 =?us-ascii?Q?tLKxiGKHQzg8f6SDEjzv8h8N2lDIt/aEfvDfB1vH35kn2+WZCNcu6UrRbINB?=
 =?us-ascii?Q?ym8RFkGopiexByo2OS/q2xfbS1e4hxJbiP/HSyYWnf5TYNYTCsZyoky/rWKo?=
 =?us-ascii?Q?thjXxjB9ppg2OJYRshX3NwWzE9nuElUBZsIIwzd9PoyB+zB+DyCfysI8p2+V?=
 =?us-ascii?Q?R2+sbVmAuf7EoBc61IoPzA3bOoDCZOjFiW5EFE44iNYzY54UYx5u+atX9o0J?=
 =?us-ascii?Q?T/gycuHXag0X4emgobu2xlB19GWsBGPV2otCs7HICkPoChStJQ7QJbX5tkHH?=
 =?us-ascii?Q?GKw+HGxz0Nzc8ceXpLxjWh5yXF/WsKjWixB5mNY2nVfUr4d5ljNbUS5RZaJr?=
 =?us-ascii?Q?zmf0sZ12bKwwDJV7O9R1fizhzsQJzFFCnGSCCwnN/x9B9NsMgs6dGtz508O1?=
 =?us-ascii?Q?A9XT/gMcW4J3waV3GHv+xiTFXFTj1DS2rvqCB1C1tyNa9KrgxCLi9uRlBAMp?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: s8LNSbCrskwvg45rkENG/qD3fcf8/hum/6gu9Y2OjtKqhPswi9t1zFm8RbRve8X1kXkSrZYRDCgKutkiGrNgDqwGN3QA5vYLYjUScuunMAPXeHlNKwZSd2NqQF+et5jLqdx6ix6KA0mAgobke+I2vnJocY2LnDMkPaowcmPxPDYNvHqypdG+gxNrgbFe6K0Ez6WVNnZCe/zSwyYpdi7aylmY2k/HDKGdlGbnG4FGdLVzKZUN9HDvQXOZBS9KOG5roT0nx2DUXT4jnK8UaI9ECMF4NRl4Z2izYIABvG9LiWIw5zUonaBy4201aMJ+Q45p5NfU5NwKkm+CeKJCa+jfswq0tnJMF3L6uuY9jNFcFHs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:2YFc8gILsH3AQpr9vAJ7NmdywKF2vReRHEs+CaXeJjom31XjAEZp66u8obqtO51NFLf+oxbWGNAh2pjToxvzy7Zj62LzKF42HvaqUPPaNVKkIn9nuK3F0ynhSOocafG4NwG0kzzlmItsXhz83q6F2RmJLFCgr+q99uvzsDTGtEphxQAw5/tsRqcW/VPhvtHWgPjX9A2HD6trACJRrZvOiKDrqvj/S8uXFzwwnc/4Cs2xcRX5zEQJjS2eFRNi3VkzEkdsSK0PAZfJJxhs0JCGUNwtWbhB/H7HRv6JGM+8bhuGjCMqfpiJGgmLuFlSJqHcyFNA48YZlVZVy1CK8XjMTY/qdA03npbNSv977UJqF0gsLbGC6zbLRV8xvLtb0pnsLYKjZfcOxNyiQIj2UbKt4qUIGNsHmxmoCK51dnAs6DXQCfsABmKq7rctGls3ulkd3ax+xdfidhts7Zs9oVA/kg==;5:+MHEEy1Qx9EBiVLmSwSlX9j/6VcTcPFFV0IVsDksGfZE3lhv66T3Q9GOZdVYizJu7CLY4GrcG9N27T+UyzZNKpJlWtJ8ovxayRQR+o4iLmXqp2EQdVy4UHuDBIULT9Lunqs9/9AVDCol+80gOu5Z+bTuqzHZd6LXn7YNSwi+7tc=;7:xn7lRhjqUAI+NQjsnWYi36yLa/qMWtc+V/Hopf90X4sEdVUDSTKGE+COazGD5R92E1kdpUzb//tYJenetKqpQqOWQkiZpKasRPQhk3R1jTPzLEYHdNGKlLSMkqvmCqc8q4XFnRTHc68s12ZjtIVhuYkbgEOtK8Qjo7TSAQEi1L5U5jkXq1cxQoXPiI3BjFquWYFrW7i6E/6omaH3Mt2tQJB3+vQC/7GSmQwTu5Vb7YpRG9gbKvnzVktorK3QmRE4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:18:23.9166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801864dc-8f25-482e-e091-08d6143e478e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Sep 05, 2018 at 08:51:26AM +0200, Mathias Kresin wrote:
> From: Tobias Wolf <dev-NTEO@vplace.de>
> 
> Set the PCI controller of_node such that PCI devices can be
> instantiated via device tree.
> 
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> Signed-off-by: Mathias Kresin <dev@kresin.me>
> ---
>  arch/mips/pci/pci-rt2880.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks - applied to mips-next for 4.20.

Paul
