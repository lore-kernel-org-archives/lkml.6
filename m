Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E21DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164002083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lid49bBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164002083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIFDlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:41:50 -0400
Received: from mail-eopbgr730110.outbound.protection.outlook.com ([40.107.73.110]:2400
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeIFDlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md9BlBIgU60bfzqSFe/Sq+euB9LrjGradln1/ccGkOY=;
 b=lid49bBIhmU2hLFag0uZBJkWYvmQGBq6Ybk6LXQTofsb9k2XDOLHYY4DubJxKvESru/4duHowq9vpqoaYFIx76XlF1n5zloIGAQMAZGVlJgcoX0Jc09PrlcFQbO6wKWIy5iYL1gD0qGbM9IfhejJQzoUYLyDkRe/9dyggNVtgBQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 23:09:22 +0000
Date:   Wed, 5 Sep 2018 16:09:19 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [PATCH v5 0/7] Add support for MSCC Ocelot i2c
Message-ID: <20180905230919.ycqmkohubym5foz3@pburton-laptop>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
 <20180901124353.GB1196@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901124353.GB1196@kunai>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:404:121::12) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28fa1882-898f-4c99-90e3-08d613849e42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:jnpQLxaJDV3Dt2y4c+GKw4jNwTpHW6SzIvFh3i9DqvA9QUnXrQHMa9tucqB20rQjjlNMeLE6MebXbTlXBtCf9j50hqd5YPjSbIdHKdSSP+8Idl89COP1Rctrfw53J7+41M5YHwwm4eN1Sf57TAVxZOVmJHkdmjji5oAYkYQpFEFTj/j1QZhGYFSFdajjS2M/rYN7Hj9JfUUnGGCPq8ZEUcWJW2FTeRmLJe7uH7eD//GdZVrILIPHW08DLWFIUxNQ;25:vJI7wzfWu8aYjnjfYvt3O3X1+VYNKxQMBtBL2kpiyoiNRzm8+khv2ESnzexaYYZz1KgxfsOqNL/b/VF8bK/5ZEuVK2RUSmhfexat5Cdj5tE+cK8JTdMCGuExFQCb573wItaL3QFpg9QF50XgYpcQ68TzX5NJG9hXfp4NrPrzjOyQYU/JTuBgNi6XsdiIXv3BdGqrff0PdB/MGCvD7UFiSs0Rq77WfUWPt5JM1zJY2pnD3cgR50ufQue3zp6+O7jUHaNv8cNUjpEeyPJOQdax+/QWhvpDpWYVi2otjnNhtQDMPU3MNSru9ZUXWDGKSsr/X1pKEFk6vTJBT+5EUNFWsw==;31:7zmP/zYpqmZP4h7MSedg6QcGgeT5wTd6e6s5MprS0MhU5WOSlLRWIuNzdQbFXKMDgphtn4fCfhiz4p7psVEhu36D0y3zTWtD86xCqMT5WKV80q+P8ZdM4TuBICOdFeoiesm/NxFdV5XWqv4UBzYeAA5MLfiBjCQYIbFz6hrSRDCP3tPEpdbFaC5+qwByQgYjjaAcnPUqtw79rapUmlGB1/3oFkwfMu3g4uQ2LVt6Eg0=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:Fk6zcfVCynK60NvwNBuzsPBvkD0TdSIj5Mrvv0ggKK86sXK2LxeqtCYO8KhbmzBvaZPlUAYGBYxPfdEFZ7Nbo6P0Jh7w+tRscJO3ODnP3fb+lrQrFI9i6qORtHPhKoLwnDs7+pUZNQP92rKy1bKJ2yHKQylFCpIqnHXJWx+eRrTqEhNUGNrZUclaw6wo0KSzWZZl8FGmMPOZoFMmr7lk7A2GZezTXpnDSRdB8muo3mVCJZLZipsYTlhl2pL4ExIx;4:sbwaCswcxZAU3/2xLy5agVJKxGm4NpKzq1eXeG32NLGE3lo3oris07jYcE4vrmaeT3aH92ep6jN5mDP79hKVSNfprqj6yKoIkLvnJx2dbElAKCnKaPkv9hH2cvSe9jazEj22b6voWc68vAzpl2uRk6tX0BTwCZLdnLKOXCmxhJ2iq1wVMht84nZrwn/0RDsUxWFVJ5VKGT7utEXigXlhH61JVVDhzuZJwHHinjnPnI025i2b5uXTCFQHMfMcrjpIZdBuQr3PWj/F6QC1RBIuAQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494112ED6AD6B7A7DFBAB96AC1020@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39840400004)(136003)(376002)(396003)(366004)(189003)(199004)(8936002)(305945005)(7736002)(9686003)(47776003)(7416002)(2906002)(66066001)(76506005)(8676002)(105586002)(81166006)(229853002)(106356001)(81156014)(478600001)(33896004)(50466002)(6486002)(76176011)(316002)(16586007)(58126008)(6496006)(52116002)(486006)(16526019)(26005)(186003)(42882007)(11346002)(446003)(956004)(44832011)(476003)(33716001)(386003)(4326008)(54906003)(110136005)(23726003)(6246003)(68736007)(3846002)(6116002)(1076002)(53936002)(25786009)(5660300001)(97736004)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:/CelLE0m0wqsc+mA/4FhhwbzBbnPx+kMLlNrueUBE?=
 =?us-ascii?Q?XITs5wVaahkaAIFAbGG26BkciczNF9syEtxobIVbLyuk6XgajHe/v+GU1hJ+?=
 =?us-ascii?Q?LLE/xRbjUL3S5PAXoPB+Uqidmu6J8vnXeuUDP5tjejda6fQazPF836M6uogJ?=
 =?us-ascii?Q?1okBGyMJV83S1trbHIZyRaerXoeSqCaRDVTCPuMjl/4vlwK93gZ5WMhoV/r4?=
 =?us-ascii?Q?zCl5VWzCjwdldQ3yjs8oa+SnQf0jB/knMoeaboAwG0GDNokeg/tqTwT5WHlK?=
 =?us-ascii?Q?ADyIaBIw471XoVX0rUWTBs/TEIz76MOxYDJLM9tKffNQJVbUYtyAcrzPmJfW?=
 =?us-ascii?Q?M6LscrME2uAsExcbxA9RpIi6aVoyLbGWwmyE/gOlmHXRt+OuO1sm/Bc5iEZX?=
 =?us-ascii?Q?6zsFC6m0I9TNfds2FvuDu+u4I0ul070qVSJ3SWfrL2mpQJJ3F1FN8Shk8r3A?=
 =?us-ascii?Q?s6O6JeqyKtLKCyg8nMILA6s+Fl/N8LWYigMghF76ADqoynYyAp35cBOtaIyY?=
 =?us-ascii?Q?ftyE7+BiOiPy2XctPZSMNFOVjXCMfRg3EHsFjjt+tPPH9OzevFGMRjyvj7cZ?=
 =?us-ascii?Q?r5SAJsizJv5NkfNVq8rQlkV+H6YVRwf1/GMt7dhnKrOYb/PT6Eu84mwjgwVA?=
 =?us-ascii?Q?/gGIqMjCSlxtmWrQvyXQUqacP+x3zBWr/liw1VBWJj8c5D6JEqFOALMpqZV0?=
 =?us-ascii?Q?IN9lx+M0rGLcS9lYh5cn2TmVlo0CYlWIjG5qdSCwh/NxKkZHwJdQMq7CRgeJ?=
 =?us-ascii?Q?ZxXB4Nn72r52Y5KcXWiqMSPVHZwR1W4wfXgP9qij9XRPJVolg+6Hb4x0w5ii?=
 =?us-ascii?Q?Dia9pdbNC6v3bgKhK5L/tFCrJ18ll5HEupZqPw9NqFx160LwfKykDoWm4bhJ?=
 =?us-ascii?Q?V4B12vezuTw4p5/E2frFvwZMw6466qjLU+JBuxVyJ1Lo8F5LlTlV09olFwfL?=
 =?us-ascii?Q?by5RUB4gqK+OBPVo8q5hG/yV0YaCf3XGzZEKKA4Zu0ubgEZY+6/pcRYF30Pn?=
 =?us-ascii?Q?0vZ3hPbFwAw+3dX79UZUeFH6zfW+oSFa2WDzVrkIBhHJdx63BE1PhklX3bP8?=
 =?us-ascii?Q?vdqtGpoM+90M0uGAbVqp+N40nbOfm+8JFIWhPmHCR8MU0xrOph6rP7lEHeZV?=
 =?us-ascii?Q?hlFNGotY4h19cDmVtUlUhb/mSvTN1m3xx64qiMVG4k1E3gB50alqZDShUwr8?=
 =?us-ascii?Q?zd3m1vM/mjY7kGsY8ipVnENCXqb1anV0kKcpr2rxUB4jLv+ye4iX62miSWhL?=
 =?us-ascii?Q?wtsFXLsl9wUNH1wpaxbt1PpiLNcVNJLKhN3XRd4Bg4kilQZWj48EQzihMH8M?=
 =?us-ascii?Q?TCeMKVtHMyivCefv7k2+gO7WoDTWQttne/QHot8O/vp?=
X-Microsoft-Antispam-Message-Info: L1mc9O2yhrrJGp1zeCBH/RrO53vObd9E50TbMFnwlMHA5Nsu5oVzCqb4UZIJfHDR223dhEn3K4sD0N86DF2KHeqcdCFaAIpudVJpem/2U4igasAaqv8e1GqZcZ12S4Qovw08DCxHRAw0qdBYORqtSJz+xquVCbbL19rfOvQTBJyRRiJWUZH8v34UFERnrCLku1qLo7nrFM1DPjOkvB5D8mmg0TXSVH67LI/T5Fmcr5sD6N+0PF4SkCzbWMEjm6Vui+QBeJxAB2gfKyaUTPqEzyIIhqx1eLu6vb0xRoY2o2LY6Ku9YkuY/7HH1VbapklwLCQax9Prn2wp+ETskVslHuvQADMu2Q+ag1gGT3PDgAg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:0La/9V7+mmZBKVocRVonc1j3VGShDegJ7xYBlTFfH2UIETkloFtx3NOc6Wx0KNhCTGBQfzJgxKAiGvJjP2zcCyfBmtJ8BbVVwCub7K3CgwBfJsRwUN7YqR+8JL+ehTyvyiOcBQEr3X27We/e5jV938bXbCNLPQfDMmefxCK6/si6K9UrSm9c8HQ5jN1Fho+sfw1cg0YujQCZV+pGaJfTMC7fXcVXZKiOiKFqwmHIPEQhMe/YwD7gn8Ne7a6aLJnYUY12+PQ/PZvIUbYPdTAoYIMwKBUiF/01OG2eJZrBFWbtfgsZ9RWtWCVWXNc9nyv0JVMv3Pf5Z0peEF7bfdjTw1hDlvnx0V3MSbGXpryxJmFMQxe5N737OpR63oHcaIMxLaSY7808sBhFuJt46lmK4xmmhVSJUmRR6mZrMcxZgSWuL8sd5DpzfS4pqX47Rn0ZxmYuxbvoGs5DFweHP00vug==;5:voKkVsVhA/0ABC8nSj19+2C0IV2uLPWFsRElcRrxbtQkcwC1FkYKNF39OSf/JsFrH+L/91Bdj60B61I7Hzw0MLcjg+kKCTayveVD0nGm+MnTEFmv4IFg1qT2z04b98+G5oYDFA0tJ6g5ngjVDqwZGYPhI1CGT8eXghwYKL4AHGo=;7:7XY5eQVUF6iLJUulTjHuSWlYdn+/0BgO3Q2zdLDh8Z7jRayuOVIs9wfgVwsOyJmiL1or96u53XkLbynwbV3bSBJayK+p1HTwnk9uhPEMxNHh0NC0XR05kyCz3Cg9fq533hcZtPbgWUnNQJK1HI0AAZJFohs1dwHZWKKnPN9PuaAaqIEa+/hgZ7lb2Uei3Ri+MM0L1PG6dhzVdiQI4nVlPhzqjl12V6+z+a//ws1v9s1YBPyN3DqVmfY+mPni0zpE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 23:09:22.8620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fa1882-898f-4c99-90e3-08d613849e42
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre & Wolfram,

On Sat, Sep 01, 2018 at 02:43:53PM +0200, Wolfram Sang wrote:
> > Because the designware IP was not able to handle the SDA hold time before
> > version 1.11a, MSCC has its own implementation. Add support for it and then add
> > i2c on ocelot boards.
> > 
> > I would expect patches 1 to 5 to go through the i2c tree.
> 
> Applied to for-next, thanks!
> 
> > Pathces 6-7 can go through the mips tree now that the bindings have been
> > reviewed.
> 
> They have been reviewed by Rob and are applied now to my tree.

Patches 6 & 7 applied to mips-next for 4.20 - thanks!

Paul
