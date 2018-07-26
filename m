Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50359C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF1820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="StiK29tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF1820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeGZS4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:56:08 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:45518
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730095AbeGZS4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95VgnUHfa0Km2mOx/IOoaZDCGmuEYvU09CDYAMIpzDo=;
 b=StiK29tQLldEPiEu7Vb2qQR01ltw6Y5cf61mOnGQxuCpUWz3lpn+1dYHKXzeQ0pDxla4cGCIilo7YYG2CpxVcnQ6CuiGEUxR3KJwRvalvRBdNWrEcs4DL9eGXzSOp0BTRHWTsa0cyP6UNt9DNUhuvKZZh072RQUBajXHmFcfK9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Thu, 26 Jul 2018 17:38:13 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fikDG-00078w-OQ; Thu, 26 Jul 2018 11:38:06 -0600
Date:   Thu, 26 Jul 2018 11:38:06 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: linux-next: build warning after merge of the rdma tree
Message-ID: <20180726173806.GG10178@mellanox.com>
References: <20180726105553.00a36e3c@canb.auug.org.au>
 <20180726030503.GA18170@mellanox.com>
 <36211fbe8a548742cf8e41a57f02f81e55c86794.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36211fbe8a548742cf8e41a57f02f81e55c86794.camel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c28d0ff6-b5da-4914-e17e-08d5f31e901c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:b1dZvrcjMbajzPrcfh3IK5o4/yyL9zyOOsxzX+YX4F8mhetcBM2uSINzfaeV1Jk4E2g/8+0bZ904jJmpV+TR5NQ11D/11XCA9BEI1eS1CW3/XMgJcNupWkbeoS/lPZAmQzTdFibg1coHTe55P0Vj5JiaYBGeu13a7CEMa+DXun2qMO3PRJVyCBxFmsXy8VDOYtfMGD6FG+O0zmkL993te2af6P9pCPJO7Mop7LXlV9s/ns6sosEDPpfzqdLPtIk3;25:ewKaw9BhtPwGHI5U6ZrzRzDvHu4/cIo/vwJNgV+DZt1c+V6CTqkc7droDcKsWaqBWe8vg4wzbDXtf5JwMoY2kETyb2L43QGV83W2pKBOkywG4wvOM6F0fj5uPCD4G5VQlm9seeNu9faA7xFqqxRrPwIlbL6AueifPA3seonjS62nN/FJxORqV7yRZv4C0G/1ixO1X+SJh5UElOf3emfA5qQ976IdpZ5BOEmPTqzqSL/MWbjMU0B+BVUfaWT2Q3D1P2k/7h21GU4bju776L+DmhbO9FBtKr49cU59Y6r0KAa0XgSXq7Z7ZIRXi06cDF0EBiZLvaYeLgK8nrJt4AWUrw==;31:DNLNtqfVPv/RkeLi8+r01LoOAYunnqgtc+vTV74/C0wqyhJ/6VF6RukXK5WvP276RC1+EU8vzNCHmZhbQIYOm1+ygs9rI1ferYuTr1mQoGa0vvVYZL+bTDTCt12ejUhgHFcMEPhdTsjVV3UX6A2LKtArH/GbuZgj/IXvqyPZEHGgFRMMeBfMz4GR6MR8FScwKBPAHiYUrlXHYcJ+Bv/FkZai+jNeo0CR3pNg56jluhQ=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:sTKtbAhxr26qrsgvVH1t4aQBziIrhQ6nAWzb4I/hc0rjcdvZs2yhiYFCVtxvavP8Oz9hJ2HYpBU41VAfM8ubRUbBd6oZmXig4cRnbxwYfAQPA1e6OG51b5BzP338svhm/g14rsyxrznYGv/rYIO84n6NT8e5HK3jH0fYaFSVPB+aAfSDQWWw96Q4B+IvaLWKJlS4H6kfL9EooxE+niNlGpg5H1EgZzQJpU3c0ui7pFRkZlsaUxn/hp14xK96/SI97fI965hnfLDmgO8PTuUSto9p1E7SsQVPxt5IxCKndhbixYN9z2DRCAeoyL+3nOJVOHig2qssj500AHafTzwwWibTf1m13GizwzZgmSV6fGJENuNQlmJArjt84rZqiJsOJE533lJ9NFNdEuxDpdt7ot4Ty0bktQTV2hMVIgW56h1LT7Tg5Iq96/3xj8jcZvftbM8bY2jp1O9F/QSV0nIEOi7cmuXkSwyusiAl4uS/Rn9YlrM+/fLE6WfBQtUWavhd;4:ZulJy3D/Rx+QWgT4/olc7x7/oIZV2BBqmb96j85vvDAkR2KpgCcVKunkKpAgoA2T6fMCbGQtDQ+cs1JWs5wLfC6c65KV5khUjLMb8mOrYiMAoVhc1GgIfI8mFrzxrDnD0ivoUGuEGiVs5mYXs6xIOa2WgUNGwZRzBx4ZXZveQavkcbxhn2rKfLM5n/FTVhcKlToSgg4SrjRXtJo4KzNH0nawvSlxTCagLaVhIQeKj6ZNpY6DoXjzHsjO213X//e/b7A0dX+1ZLMLKpahJSalGA==
X-Microsoft-Antispam-PRVS: <AM6PR05MB44544FC8D66B20A00A121761CF2B0@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(53754006)(189003)(199004)(97736004)(83796002)(11346002)(5660300001)(36756003)(6916009)(57986006)(446003)(486006)(2616005)(476003)(66066001)(386003)(106356001)(54906003)(26005)(105586002)(14444005)(76176011)(47776003)(186003)(46656002)(478600001)(52116002)(86362001)(575784001)(316002)(8676002)(81166006)(4326008)(68736007)(33656002)(2906002)(53936002)(58126008)(16586007)(81156014)(69596002)(122856001)(305945005)(8936002)(7736002)(50466002)(229853002)(6246003)(1076002)(9746002)(23726003)(9786002)(6116002)(3846002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:FNsQQ9COfggM0I91yU4KwvuFMnmqR9GE5nmZEgEvf?=
 =?us-ascii?Q?HKFcVbVVepuD+1UWuPjuASUsqSVGRLg0POBh+ssqGsKDN46+kE5Nd8or19tp?=
 =?us-ascii?Q?Clq9h1lLDirB0rFRTOPojODSe7tn7S4sS1o2axk6Ww1hykEChMDRZj1UB+gL?=
 =?us-ascii?Q?fbGgIhRFUzXe2+1/WiHrbGkUjCDvIW40KhTl25blaqNvrmt5FBpvvukPgN7f?=
 =?us-ascii?Q?8FbmTwInNw+2A8vcRAnrvquGtcsHpItbbuOETLak1efarx5fYnfPU+n69yMi?=
 =?us-ascii?Q?QSXj9g8b/BkFXO8seSmini4l3og+WtV8wxFrzCbPqlVj5nb9L+guYzLnyoeb?=
 =?us-ascii?Q?LcBhM52huSL8bkd44joFHx6mIXoymd3GGr2kqJEDin5/OjLH/5A+92mxPPGu?=
 =?us-ascii?Q?GuN1+BPyzhVrCRA6OIxqrbEInBnbQ8Hdqmre2oeMm6SV5wh6+cdMXVwK4h6s?=
 =?us-ascii?Q?fxb37RNVHG/pxgSj6YJ72nLkbEGg6toF151JJQbg08gzYe5Pe8H5ANmzVXIa?=
 =?us-ascii?Q?HVucLrk6HE8Liq2asrEehzdGNGnAXFQnmBfx86zFgWcb5DQv2qCZ3VNasFyE?=
 =?us-ascii?Q?pTE32gcf76Db4L3+AErDnOfQ8eDwjc1czbFu4iACOyaFGP/NCRzRKkx6qsq6?=
 =?us-ascii?Q?pAecZgClbOguA4JNNGgVH9ZAFyrtHXGdzDJdQDWRLehPp3/3Q8VgdBPyaNfo?=
 =?us-ascii?Q?qPW0koNUqM1V+3I0rn3MlPiqmCdVqJzc2wcfcY1ipZKFaD1rdN1SZZ8cabA3?=
 =?us-ascii?Q?V1X8y0RlzPeYrbOG8eDx+Lr8J+K0RgOT19LMrfYiDeYpYOLS2qJNU+uMGGgZ?=
 =?us-ascii?Q?x6XxidG4jLjt56OaRmroUzGixxFzWm8r4HIMe5wrzFBX20w6b26OKWey0144?=
 =?us-ascii?Q?vMe+RrFJZ12AaJBik6kjT6dIFJ9ItBLKiLEWzP9KUSH5iBGHjeKQaM+/OdLc?=
 =?us-ascii?Q?bd6LYyfu8SBxEyRigpiZdMHs/0H6LAvuRwcm+AXhaBLfaUCKXBcl7YiXumWo?=
 =?us-ascii?Q?V2BycshFE1Wxy4nw4FXwp5QVD0u0d4emAZfCbhmbQ3U61ghamVddVX75kHAC?=
 =?us-ascii?Q?dPW3OOaRKJs0XUl6Ycxs3mYO9uNI2A6Vc1MjhtusVBW8XJcasjRVva6MX9GP?=
 =?us-ascii?Q?+R6WW+jCqtZyzkCBPVKD70+7lobh/25lihsIpLBkQfqiuOYPQzmzs1L+UFX3?=
 =?us-ascii?Q?JGtkrSx19HFCBuZ3bNg5TgJZxzvgNF0+IfzyDQXxKx1p7yC23KuM1i6HcrRf?=
 =?us-ascii?Q?9D9g86a/Z3UjeA2LRiIL7lK98nRujpz58hQ0Wc1R9ROtL8EXCVJce9UP6ufC?=
 =?us-ascii?Q?A8cG2NV7+kj08XfaCDBarTiHyVNaSkY3KfEBnVAlQgjMqKy1wMTG/KaFAzDd?=
 =?us-ascii?Q?8kKqW3/0ojRoD9m0kEKycA9McGuEQgYSxfkJh6Hw4y1x693?=
X-Microsoft-Antispam-Message-Info: oSyusPVp6kkQ1mf3YAYKgDetxYZ8iDNXwlLiEAV1dXleSmIT/TbeLUdXcMwXQeKKWhrG561U4BQOl/qtu7jdkieT8Yl2x9Ote9IJ+clKICnxZKpfKeNXVdLGgVAkZEuOxCIOV/vJT1tEDa2cINDbGtjvjAFJNtakk48IwuQL4MGsmotGK09FryIZFNoyCrGbkBDVsp8XlSH1haUWGbxw31krBZmrXRLssv7lWKB97HJ2LrK4CADpMMhcbRWlN7seMyrop6dSqF4MCJ1VgrBOk9zp2xBJORhCu/GCrKGCltka7K4L1AodR8pjhpIxPP3zOIvvKKDsC7nrMK4hY7IxTK0y4jNsbxmesaZ8/P/Mcjg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:qgqYMFzw4HBQXzXWBmCix5x2ghSVfv6hSvZICtLKAwNz95l18TpWQCK4W2phSpygYxnimvpHAGYwrU+mDyUetBuDoGeeuVPyfnVaXx9XJ9WQe2L4R4w38G+a5+GPl2Ar4f6oIw+oAKnluMSTUDmYsmbggvsYQI39+gjxB/GnyINTnWsy3X5/4tsYVQtJEItgw3D+zRrkNadJTEQcbUA1EPAb0aJXGcIjAgSjx3Ii+21XFbcDaKX0FIjN3yUOb2ntfsVDjSrxpL8s26f6zZECzLJwC8q9GaGNi0CG/RI4LOzYN2p7BsTUrJ4MP+32HY2klrAizdH93LPE6YHbimKQ+VWKc7ZvweGGPIN/JpdXzC8pU7YSL4GWfDhqhzorXEGDkWccDAYarhPHGG0q/EwdTonjh7QbmdzMgz5kEJ17WiCfZvsRN/tqlW5g5zvlzUKMLil7kp7BnyNWf3VqrVY3lQ==;5:PVyuMntmlsFRBsvxyvp2ArtVJX/eCkIx5YsKbbSEiF4IbgnJkKLI7Mvp7N0i8iY79kJ2Iz4xzF6Bx/00PxRhweTqS8nh5mK5/K5iXbqoEQQwA70vDx9Pu8sHJaVRaxRFbRmr2XAmof80suq7+5cSg/ikLll/ijm5I2HdQy+3Qo4=;7:RBHZ9uIvDX5c526qb9fGDLhrSfMvOqmmFS+KhMej23PV/rsvdTm8xV8aT+QMZeWKZNyPM02hh7h1x7aKoZRTQT/2jWHfMV03lJdTxR1SJoW6jj45tSY9jLef2fpSe7PudUt+R/44yN9f7LA1RWepV0rrnuQnGtDesO1kZn9AExinp43x9/yiatDxMCb9+NUqs+3ksisCjeg7YBmBx6gDJvoxUtYLyfZa/Wv/zkjIQkv81yH1Klw/GKxrrIfgBDnx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:38:13.3552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28d0ff6-b5da-4914-e17e-08d5f31e901c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:10:13AM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-25 at 21:05 -0600, Jason Gunthorpe wrote:
> > On Thu, Jul 26, 2018 at 10:55:53AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the rdma tree, today's linux-next build (powerpc
> > > ppc64_defconfig) produced this warning:
> > > 
> > > net/sunrpc/xprtrdma/svc_rdma_rw.c: In function 'svc_rdma_post_chunk_ctxt':
> > > net/sunrpc/xprtrdma/svc_rdma_rw.c:350:5: warning: 'bad_wr' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   if (bad_wr != first_wr)
> > >      ^
> > 
> > Huh. I'm quite surprised 0-day build service didn't warn on this.
> > 
> > > Introduced by commit
> > > 
> > >   ed288d74a9e5 ("net/xprtrdma: Simplify ib_post_(send|recv|srq_recv)() calls")
> > > 
> > > This is an actual problem.
> > 
> > Yes, for sure. Bart?
> 
> Thanks Stephen for having reported this. I propose to revert the changes in
> net/sunrpc/xprtrdma/svc_rdma_rw.c. Jason, do you want me to submit the below
> as a formal patch?

I applied the below.. Please let me know if there is an error.

Thanks,
Jason

commit 5d85a822fae2b484f26ddb09815063a88962a0cb
Author: Jason Gunthorpe <jgg@mellanox.com>
Date:   Thu Jul 26 11:36:50 2018 -0600

    net/xprtrdma: Restore needed argument to ib_post_send
    
    The call in svc_rdma_post_chunk_ctxt() does actually use bad_wr.
    
    Fixes: ed288d74a9e5 ("net/xprtrdma: Simplify ib_post_(send|recv|srq_recv)() calls")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 80975427f5235f..ce3ea841970483 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -329,7 +329,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	do {
 		if (atomic_sub_return(cc->cc_sqecount,
 				      &rdma->sc_sq_avail) > 0) {
-			ret = ib_post_send(rdma->sc_qp, first_wr, NULL);
+			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
 			trace_svcrdma_post_rw(&cc->cc_cqe,
 					      cc->cc_sqecount, ret);
 			if (ret)
