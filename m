Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC220880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="TzQdWuuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXSoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:44:20 -0400
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:22119
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388366AbeGXSoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA/KtSRUFbjqNdySqHizCHvoscei+oYDrel9oXcogGA=;
 b=TzQdWuuCrkgjzqcifmDLop/cwH2BUv5tMQzAU+3feswkBlIPP7XkBi6fCopOcxlbBMRUDSuRQGzohoeBazpmxExHevXzHqOGE8K8NVvDDYvsVIQk+Xzb6g5ER4mSkJGc4+SigDPz7cK/Y4tpbqAEGcxLRP2eEyxdQN1sNI9OBXQ=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 17:36:40 +0000
Date:   Tue, 24 Jul 2018 10:36:37 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: Re: [PATCH] mips: use asm-generic version of msi.h
Message-ID: <20180724173637.2y2cdpqean6t3vso@pburton-laptop>
References: <20180724115208.11199-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724115208.11199-1-thomas.petazzoni@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0072.namprd22.prod.outlook.com
 (2603:10b6:301:5e::25) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d6bcf7-176e-4ff2-4bcc-08d5f18c03d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:l4yEJcxeMQG4iUpTo+EIr0NInK1yGWYxxnDs3oSZPG0xwmJZ/FmdmzVesHcKJh2fxz88sWgp3BPcOfOacJdd7HZMlzu3lhE4WSBkJAUFN+wiuyMpCTJlvWaZiIT6OfP2j2UH5A45GqE+XD2k2TICaAzs/BqXSyQc18MJ+PmsqdhWPsE+u9IMwneAuWP5NMmOPLJMWNJ/pkf+7iQh/eDxrDWiFHjipwpI3r1gZACXyEqf3YJV5opcLLwQDn7hEkEZ;25:4rO8NOiPVw05QodHiM//KY0KOwsZNLrrrmjkLRRCCeDDLLKwNqZ4NqQQmU9VobeoImTDSYfw7JkdgMY8OupoEvB4Af37k+t1YyYLffIs0wk2nOYRebA4vrCBsKUVSG2PoydGIc8URJZf2pwVOdfXGjz7V1CZ50A8/gZbid80wJG1hTBev9JhX2AQz/o+AtS2lRxnl0zAI19l8M8wYWnBp9MoZe5dl8pIxcd5B7NF1AtEfHC9DHh1bKnAnd5QCvVWKCl9no3fuSVMQruHJf3kcPETb0PQZlyhcQ4c6LmJhNnR1ouLRLF9x9lqYXcWVGznIWOE22KZAUoUqibhAananA==;31:LgAGMW30ZsV+zc8TzDjqv/F99aFH33kIzu4UUnreWyLl4r4Pi7Wdk3fTHXVpE7AEA6Pt5/RSEwS2NRPA7Qd7plqCV7Apeqe8XEaXCCbGgpqvtzwc9BgJ5iXuhFYH58EakhUlVqwZowsDHkHWXbPs7rK51yw7UW95dHkk+GFZNmQwSzu+0XtISu7O4V5I8x+ESvGbGkYrTaoTYUJtZ1aGz7b16ja78xsSS6Un0wX+ISU=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:0b7y9yE6VRGHRaQZ3ASCzSgWmYC43Dg86gDTG1v7Jft9YShWBoIaudfHliaT87ZMKOAWgIw7+1qTO+aWfDS1EPfaKfPMaJXrFJMKCLfumzPatir6j+JleZjkLULgmruidNwboRXqvTJlnNaeXqEx72s6O2AKtj4YA6mTCLUZk/zeiA4A+WqG7CN+z9CvJXWVuLKaEuhCUJumFZAAfJp40rXKpbAFNjKrhjSZPH5v94yDJSnonHky+xsN8sWiGZCb;4:sWIk9BsMBL3DnFPh9tyY5gZiiBUQh9BaQI9UmVcSbCIWOmdyh7i/s5FjPAGQetBR3NQ1aQfZtzgBIRKMyQ3d5CkdB+m0jo3Aw9pPURAFT6poJppicTPawqc05H+JkBMZIZ6RIDbRi4eIaC2J8YJqiDU+aQ6o2CKA6/lPZW+TAfXsHhMhcZnS7fCzn39TcZaCrd0ffITQ1iy3l8EaFOHsHdAmVEwAz1Kjf+Hhf39n3kpe3YVGPlQQaSGKA2sfj7X3W3rsmSn0pOEXW5lyyrrsyQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49331AE563C20C0EBDCB3D01C1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(376002)(346002)(366004)(136003)(39840400004)(199004)(189003)(54906003)(6246003)(42882007)(476003)(33716001)(2906002)(1076002)(26005)(97736004)(68736007)(76506005)(305945005)(446003)(486006)(16586007)(186003)(58126008)(956004)(11346002)(44832011)(3846002)(6116002)(5660300001)(478600001)(316002)(16526019)(23726003)(25786009)(106356001)(6496006)(76176011)(105586002)(66066001)(53936002)(47776003)(9686003)(52116002)(4326008)(229853002)(8936002)(7736002)(386003)(6666003)(81156014)(81166006)(8676002)(6916009)(50466002)(6486002)(33896004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:tWfGEr4EHeEdEJRZpFPQzouuZOPT6iA2NM2MOzs1O?=
 =?us-ascii?Q?7BruPRfo01RXL3Ti5+gwNaWmQnHHFJ4FSrAEMPIpRcMFmO9zk89KkBSJ9tvZ?=
 =?us-ascii?Q?jkiNsxivceLrPZLT+ngeNpGzIgoUSVPgLiNczBWqSzE6sCCR7w4wtWCFrX1k?=
 =?us-ascii?Q?GKwkj0MMpUYllcgWt5lkLArlL8nDPRUi+nPu6uzQUwLNkx8TUZmcFH2+lN9L?=
 =?us-ascii?Q?KxF9lsasLfGj96JCdNrviCSQhLTo33+oAref3vPOrUD7AEnL6YgSrwejSNqv?=
 =?us-ascii?Q?Sy6mGbBFvpwFnLDm7bsq/l8YMlDTQhMyh+8+J3EjBFVETHdfjj7WHXl49ktP?=
 =?us-ascii?Q?a5hA51u789v8bAXLpyGpx6Yk/Suj2rFvLvyHVpfX1gL44d+lzel81vy+C60G?=
 =?us-ascii?Q?4X3xQ3IAyPGc6zkVmxI6D1s9hB/faY18yBHCIXJeiyh4/zZc+kDDmNioSm34?=
 =?us-ascii?Q?S4GX2BSYmmRaZxQdfrOKeTo5oigqK+u8mjj1UZg0dnkGLn1lLsU06k4lIaSF?=
 =?us-ascii?Q?IMHh5nFjzIZwOlrOCR3GoaNd3LLbkz66Mc2rR0wx33oiDoOuReOmL6zry3bf?=
 =?us-ascii?Q?66FSZqdhuDQeG1t2mkQZPU+lFCXrbIkCmeiTUCHf5vNxjBLErgw1lbhBn23q?=
 =?us-ascii?Q?LrzF4Box0IYAvZw6uPKfucYvrx1uTycepEsE7YEISGCCQr8hyKq0pFn2ee3h?=
 =?us-ascii?Q?CZXeoECJSLJ53vBHZhX8suyB9Nr9xdebbi3CRHRNQAZ5CR6Lp9+hIRqxNOHn?=
 =?us-ascii?Q?nU3tTlF+pqLDpmrrEZZRKrzlCbBzDGRu6kw1E0L0XrvVqGdq6CcSPe3ngOWh?=
 =?us-ascii?Q?+upNeHUlJPn5BunxwEhz2gMjrOIVInhaDM97OWhJjqePjwxSAGBef42in07/?=
 =?us-ascii?Q?OoXP2Vbwg3rIyBk2Rwr4w3toudFfByOrf7kTpIZI739VQ9mRidu3kMTSHgOd?=
 =?us-ascii?Q?6rkqt6mSeaPtYk+mlotaclyZ3baXTI8Jf6Fd7cU/AwfI8GXjHLM5lP9Y6SPZ?=
 =?us-ascii?Q?5FUYsX8AjUTHuqdVCrHzt2W/EbutlTv2zC5LfcIsh7/UlYiy604sUFAmE7ph?=
 =?us-ascii?Q?YUObVRn44rmJeLLMbQ/YEYKSFosXXntkb+Nem7kSwEMVJHuCawvGVDjTqaDU?=
 =?us-ascii?Q?RyQ/cZJiuqVlDe3r4fsNZiW0y3/1bEHWxdmwAAZgFWoTCzqj6PoNjbomcRWq?=
 =?us-ascii?Q?5SZCeMf8LxwwEXPHzGEUK/VbO+T433E+UKQMSLDNVqSG0tmVWdjvhIp+1I0s?=
 =?us-ascii?Q?zwtNNzps0pb03ZlyS6i7XZDA3r7dJTK2x8VtEDRig4mip6/f91gHNoR0w64I?=
 =?us-ascii?Q?yxwUCANAfiCa/A5iz2/Ep2PJib0E/0Gx+4HbDB/LD4+?=
X-Microsoft-Antispam-Message-Info: 2RXfskHs5E5722fVXliDxpxorlfHqrA5ZWjK3s1BFh49JwAKq1b/9iIjlJ2bO9TU7dMxf0zi7fjDVHCSu1veVyK/WTMKflTNl5G7cYO0qbVd7dKDYmZ8N4OiJobGL52FQEqNr4/Hdw5w8ZNLYLtBmdRe03Vr/WcVHiPGzPZg/Eq5JyqXFKgvU/ebHu3W1MRIUARPExBS6KIsezpg8svbvxwLuW69mloTaC6bzOczQvGZ51zjDv3MyIcP/eskBT04hYPFCtBtWG6YFSy+mjZaJapIfXephSNnlV89KxG3a3Nb7wJL81/k68Zprvt3+btXeGOTlJ/sX7r7ueuvrDqqruKBQKqolG74UPHwEFFh0y8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:M0yP7T60eoxFO0eJuRHP7gbJjpFxzqhdG4DLKrPvOHsGAufUMuyhkgGf/ZeTqpXge/fCpU3PifnSrRx/tMYKm/NdyILo7YNJLuWBQmvdJG91E+IZ3f3GONtGS2lzkbqpli51bTt0wuHV/xmb80wXd+IRyZDccok2vd9vcmROnPnt90ywpL36jKdc3x29Mx8UI0Aouzl8O7GqzhVXsB+l8fWVkbo3iO81pAZ339M0Z7XQMtyTPvQuz+LIe9WdQlAiZRVf2UG4skAPOrB3juMGhrQ/HZI0JYp/wV1QPP96GTLERCjuxhRHg0VKnHiGuwfXnNkfkHqEMhoGxVBMygbeEU4weulel9C9JZzxQv+r8eFDvmlr8HTrA5hGXIxCPG3T5jYyRord9FxGiwX+nrnHMmakhvxoTlFtJOrA/p0xudkJxEaDKKDavQ+A7lsaWZIPlK89FaQ2N+43+22kSBgSEw==;5:ynxTW2BWQZsNoIqS1xwPIgGQss2SWOA3/weNDI8O0q4LFJiHC8Yb4I5a3nWDBRGBr2XLuXJQNKYSpFmP/dgvHYOc85/Q86ZK43MbEb/dTpxx9HAKu2T0NYCTjKpAc7VoPJP6jn2ZGZlA0sgoMkeAabWydqT1eyx5VT+UA9aYAjM=;7:qaOHCTQpMW3jvqmYJTRigRX1xjWfeCnpJ9CIArHDQohJPfCPhKET+w146z4EObtJJZB4dxWFY3bvWRokpLc7D4cmjgs77ehmnEiHl0XnLLpFKk/otuG8J2q2014qT0X6Sm+DxWeAOXlV3eWxkQU0ZXxayNktfSCDSUhIu5qzLQ63zwYfRyw08WLvKdm81EWV8PU7C55gUb10TbiFNY03QKJUP574iLhONyqETDMEkwb0Tbo7DKUG/uZnpKxUqBfR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 17:36:40.3156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d6bcf7-176e-4ff2-4bcc-08d5f18c03d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jul 24, 2018 at 01:52:08PM +0200, Thomas Petazzoni wrote:
> This is necessary to be able to include <linux/msi.h> when
> CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
> CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:
> 
>    In file included from include/linux/kvm_host.h:20:0,
>                     from arch/mips/kernel/asm-offsets.c:24:
> >> include/linux/msi.h:197:10: fatal error: asm/msi.h: No such file or directory
>     #include <asm/msi.h>
>              ^~~~~~~~~~~
>    compilation terminated.
>    make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  arch/mips/include/asm/Kbuild | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to mips-next for 4.19.

BTW it looks like a bunch of other architectures might need this too - a
grep suggests more architectures lack asm/msi.h (17) than have it.

Paul
