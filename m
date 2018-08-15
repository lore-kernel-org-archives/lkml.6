Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B81C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67592150E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FcQ/S3mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67592150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHOWTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:19:46 -0400
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:54656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbeHOWTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH7m8FBa4agmQ0GQYLTqtb2bU3IClILp5hbi2qjo7+8=;
 b=FcQ/S3mPQCQoEGAzT6omkq8EFqpI1jzD9deeewgY1Vrt1AHWq6Jh+6iGcbGGLHB15o/IGw8e9veB58af+aBWbtmMqoqhmbkm+GM6B7RhZRjxOCAi4a74nI2jXeDRCjcK6cyrCgqn9ZW81lmvSMJNG1TCH5KghwOl1Hy1TYuIj6Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 15 Aug 2018 19:26:13 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fq1Qf-0001yG-Jk; Wed, 15 Aug 2018 13:26:01 -0600
Date:   Wed, 15 Aug 2018 13:26:01 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the block tree with the rdma tree
Message-ID: <20180815192601.GI2341@mellanox.com>
References: <20180726135804.0257047e@canb.auug.org.au>
 <20180815114539.34e066e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815114539.34e066e1@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: DM6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:5:80::37) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b36472-e3c9-413e-9668-08d602e4f6b3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:v8bUGQJAgM4q6+6UasW7Ib6TxP03f/4+0oty65G7IAYwrILYrErSuI9g6OdX+/DBiI8MOZKnrgvceH3YrQz8cPlYA/zZxR4JNiazqoAeWAPXNkv3YiTnqQHZAvUje/Toh65BljsbebeElyTZF/D/lauSDLqTcc/SM2JjduAzPTL0+xQgXgG61yDnnDU0A7vXXiWhL2oQubtJBI3P9Eb7moFnX9wz3WxQZQovW4qB6a44fjbqalm1exl3Y1BP2ucm;25:zKZP+2tV/bnT13LT0AWLxIB4N1UlNw6cJsDP+OvNHrN4pie/JRmDO4Mo1+HFIzat2pKkqK3YuEVNB18MOX2qgjHwY43UHkmeI91ciehng28DIwB4MX8tC5IwkznRuIuIlREF8sb0DpxDBMFAXKRaEmb2XDebkyJHNT0lOpeAOmRtrW8mjjCj9iAskhajt3zWmUoLLGgKTHYbgXM0BPnkxFCbek/m8GhYhYQyGNsKWbcdLh/sl6oxV14YhMt1ZW0Bk29XZKKIc2f/ElY0iycbj/QCTW0iH+8usevFAa688ntO2kUfknZjOQ0DjJ1DcQy3+ylEgmoi9yTkcuFd9o/6FQ==;31:BHsAB+03wj2Cpy/g5IFa+LC1PgTQf6R31YxzKBdFg+3xDlmLJUNgTl59zI3bPEKizB8XnHFrwzxOGCSs/bxOnGnLvTc4Lxp528nFYFxrpItgJSw6keL727XQm28XizeJ9UzHdXJsIQ61YKKlD+PC0seFooEhMeHTNCQXAsuBOhmCRz9GYv/F/OWIqHN1dLMspd4mAXpWwEhHCnuRlOLhxN7BCIx7FpjPWmZkqj2KfUY=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:wyFxndRJjQbGmythQa2BFZdHDSvm2D4sATg0R5HQXLRs3KhNSggXdxWKp2CgyfFEEVshduwM6fTDRpfE22WmK0zNwAVBu5NyVoFJfPGYSQ095ZAi8EI2jTK9H1xzF15Wa7pTePWk/kpKAmZPz6ARbIs5odWL7Dznc3xPyUj6TfqHSmp/nosPQDObgbZTpnSm+wLo9TXh/AQD0ujSeE4yMvcZCAE+obrw49PuwFdZEM1jQZHzQlXKCQsk1yw/L2qOn3/bvHnX7H3eeTfi8hxgLnJfEByrBHoOeX1/K/JcShpy5hSe06VfS30M1oIFJ9jenhzaJBRraKmT70N4E7eGZi/SCXf3q5lwprRR2bMocB3KFsvEJib6CsE+BkSgYocdGX95JGGRp8mTioDH6Vy6xwB3XKRpLjkgitFiIHro9fU6M5FHVYNHDEGUZJFr3WoNtakbVoPI9MYQE9D4eHIVGLoQwPBqDtCVjinP1/sBRRj0hDag70X5aAw2SmHLfhdN;4:rPHMgL0a3or5BAb891mNDn6+NiWowdnpnK+kFhO88XOgZb5KvkDvPJK4uwA7TLDVkyyaAowmQ+rF0MXnKzEB7PZZR7LXyxg42YKELVIbd7/U1W5LcAG6q8TtsEucJM3mSVJMx4QuW+GHSTVkgDfb0t7+tplPYrgO8D/UKH41iAsQ7KD3kRBnVhEUpd3XC5NWVg7Zfl6lG2d0Lm1puVubHwjtvieauC7+9Wd0/0YoXbQQG8lxoV/9sZ34fSXihuK9fmvfu/UiSfvS+/hwnDv8Jg==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4450D6AC20F8AC900A94885DCF3F0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(366004)(396003)(39860400002)(346002)(53754006)(189003)(199004)(316002)(6116002)(54906003)(106356001)(97736004)(105586002)(58126008)(53936002)(26005)(3846002)(122856001)(36756003)(305945005)(76176011)(6246003)(57986006)(4326008)(46656002)(16586007)(8936002)(66066001)(5660300001)(478600001)(83796002)(47776003)(1076002)(7736002)(386003)(33656002)(52116002)(186003)(69596002)(68736007)(8676002)(81166006)(23726003)(2906002)(50466002)(86362001)(9786002)(426003)(2616005)(6916009)(229853002)(476003)(446003)(11346002)(9746002)(486006)(79686004)(81156014)(18370500001)(24400500001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:5FEvPsn1JAr/xvY74KikLNRxM9xyx29WOsuvPSncz?=
 =?us-ascii?Q?uOXA2PGO5grXUah1G64CycYRkVPJoAPwEH94HCG/b1klYqGOYN24x5/0ytAC?=
 =?us-ascii?Q?BC5gWjO6SMDeMqUzbttMekGAq6Po6MJWJOtj9m9hmwsIHbnyZxgrJ/wIib7U?=
 =?us-ascii?Q?H86Ee817qS/fxXb1KOG2HuFO69BKsS7bS07YTJqdcWM4NHTA6TRMU3moMoNk?=
 =?us-ascii?Q?0xvZy/uKYan8N2f/qsygF0sKMUg7q2FcwMai8SlLB4m1blQy0SgiAjEdbyXv?=
 =?us-ascii?Q?TrrrUZ/ru6e9GYuAsyEEdsLobOIg+Q4idVkErXYp+N/NGPRAldVtFppONKk4?=
 =?us-ascii?Q?kPcEdhP7jJAaxv70EQ6As2FQQxr09IN2W1hnxSstgwyKvEK+dsfQtJzqgQI4?=
 =?us-ascii?Q?yhuR3wK9/qMqk6G2vQ4qIdcVVON2W5UXm6HAFMzepWa7gRl0NUMR9Ex+Fq3S?=
 =?us-ascii?Q?R6fRZGz1biORoqSMB9LWHhqb1OkH0fGiPhxK2xRPZZ0MvkwZMUfBTxhdnLUU?=
 =?us-ascii?Q?Hpl5sM9JOWdYfwUkbbzqexubtAp5Va0T2hecTROkEfrW/7aTFcu5aBfssTBr?=
 =?us-ascii?Q?hz3VVw4kxuoDriO/MaV+kQYwlD5zFwtUa33CFgS4eUFl34/R5pxkKZOfgkT2?=
 =?us-ascii?Q?A2NnPR1q/kQV2NsxW3PKi1XKB+ZaRVQ5SEOk7tkJ176eRZQTf3GGHRjEUkIu?=
 =?us-ascii?Q?OnqScrmG7CkBtpZ48X6q6v87Up/IJeltJN70jV22d8M6afNur9WpDPVcpb6r?=
 =?us-ascii?Q?RPiK97psPwW/YcNjAL7LigXGOp4i5Md7PjbbOf9AE1KRE/2YLzCYeLfVSF2E?=
 =?us-ascii?Q?tAlNMHPo/mIk6Bv9IBz9pojEDqFfjuibKwA0Dljyz1tsT1nePRmCTIQLsLP7?=
 =?us-ascii?Q?YYynbF9JuAgcZ3Y7klxixjkNpEXZEEXJfMrlyB64bFLg+tXsP5xqbboilJ2D?=
 =?us-ascii?Q?J5d/9yXKJVV/m4cEmi1p4z9YQdPOti3+k53XJGWEh9KpZFyWsOC5W/87ZZF5?=
 =?us-ascii?Q?eFwaviGZKnumzTfRtgAvr3t4B9UO5rIM2CBbBrAMWXkB2WnPKxNgyq3Mrsa5?=
 =?us-ascii?Q?/Gq+qrXOkEasUidZ+xv2Xce7OCheS4FcSfq4rxdtGMTDGEmdqa91k5p1ZDPV?=
 =?us-ascii?Q?Q47Pz1QyJpJTdNuy4gGRrC3MnYDitTVOWTTN1EmlopeqzXAJIbaZLKMG5ggk?=
 =?us-ascii?Q?XY0gMT4T6xJLFpJYhhbIwsvjJrA6WSilQVsnzaFQxVVtxnGJW9azwVCWSPAx?=
 =?us-ascii?Q?eYezUeBhOzfSJztIYEzxQ0ZZJoYVN4b4TAjyxSL93qp/Iity1axCCfNz4P/W?=
 =?us-ascii?Q?rhLFMsdpFLYwIRXdl7Gz+YrIIFoXgURnSyh81NO/q1WWzTN+MMjeQDk7M2S7?=
 =?us-ascii?Q?Kn2qysvY7KVXNt0ISTqqgGvuLq0or3UjSBGuHkkka0f9G5zoNTsWvvmKkP/7?=
 =?us-ascii?Q?0GIA7ZpUr2VoUgI50MB19WbXI9ESpSSC+INHMKmbteK5SZnpVXvQ1+LIlTNW?=
 =?us-ascii?Q?sTxqhpmDhtCeQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: zLpau3ASo1zgrg9AyUEPKP1lSFYERestjdteAiS2s5OU91Cm/3Z8yXs8h9zKpTnHNTDMgAice0x2VqEufql9vcftaABMNnI6tIxcYzcD5B4U4BJCErg3HY532P+FkK/5rSWjmlQC0gm1AdotooXI7Fo+mEHkm6I1RfGHRh0zv3nzNaz0yykQaK/qGSRom3GLadWF5A1AC1SFIfOACYBBRr1AiwHcqWIOFtz49Sl0lSV29mmKU4/DTMWaWMm601gJk8qkvUcJLpJRSfFn4s9rfdh/LlhiKjSAFKNqMnT10lUNrmMPfOpVy/zs6dyQPU9e1GJ5mJuwvvXW6fq8rFYds7+X8BLaDsc8DG1Wtrmygis=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:Zp9/ukKhctMNdRfE8PQ03/AWYQOxTWIlp3OM2ABK0gLkbjORMloK8S5Zw0rkKt3QolYC3Y7v508NAp62yo1L+K7/cTg6FXTZ874pD6H8kKGnodYxOfX3vGGPbqJ4UPCDaX+yzkdyLWeH/52b9B3WTO+hWAtuPa2i/9jL3o2QqBYx4wQdETN9jGPDejRG+ZQ5wdhTrGCSLbNkqDeMqNrVU9Vb5MxyeUz33NYBqXkzEWMXh+srPCLRjq6KyhQFbG6xkFTlmLYLbywHBOmOYL9gFEw88NoLAuCeFjow4F75l9ubiSKBHaAKSPnYjTac397tT700+LbRjyr6mmTwv86Fqcpbe/mENymvnI3FKwXWRLznrGSI/8csZXI5ODCXdoTyMGz2ItZu7PaeUMArC1ezsop+NAlvkLd3QJFaOM0bAHewnan/D7mfHZ0R/4GhbTGb/3CP+PsptZ0V0rGTsLZxKg==;5:HHDFuEYqDOcrebDo25XtXdioVOsSHJWav1TO45ew1cIWC4pV59d5fm0ZSJCnRAjvI6MzYao9SczSVMK28/x+O1UonHZ4apZ3XekE7kK/8igu2oNQr9fdFPgewOFgUY0wYKAZ1pP0vqmwa28j2rtrEFOE1By7y0FqiVIo//uLFXs=;7:aLdgIQrwQZLD5ktcvj0kR31klphTmXWSLGrxPXXcAK4hWb8galph720PFkDNptKlNoty2RrneeExlocybLnWO1ij2/BwC1GAuqJvJsuvswJVX/bnpleJ2che1La8jn7eIKgXIoou1/eMRfsEMifyYLcgj5xiq80mn/RER+N7duyxR4ZVCy0nB6R9IwMg0WrS+KiwwtH0WYKpwsIc2kGwRNyvhWEgd8kAujKj/WzaEl6i9Y4nVgRN6vzLkX9w9t1Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 19:26:13.4247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b36472-e3c9-413e-9668-08d602e4f6b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:45:39AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 26 Jul 2018 13:58:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the block tree got a conflict in:
> > 
> >   drivers/nvme/target/rdma.c
> > 
> > between commit:
> > 
> >   23f96d1f15a7 ("nvmet-rdma: Simplify ib_post_(send|recv|srq_recv)() calls")
> >   202093848cac ("nvmet-rdma: add an error flow for post_recv failures")
> > 
> > from the rdma tree and commits:
> > 
> >   2fc464e2162c ("nvmet-rdma: add unlikely check in the fast path")
> > 
> > from the block tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> 
> This is now a conflict between Linus' tree and the rdma tree.

Yes, I expect this.. good thing we had linux-next as several of these
needed non-obvious changes.

I keep track of your postings and build a conflict resolution for
Linus to refer to. netdev is the last conflicting tree I expect, and
it hasn't been sent yet..

Thanks,
Jason
