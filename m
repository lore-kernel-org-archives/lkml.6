Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C288C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139A921A64
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HAverayv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139A921A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbeHFVyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:54:23 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:52320
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727585AbeHFVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wJ4zww9rKAmeE+YDBgMXjZ3C6o4KBxzPMprftAJm94=;
 b=HAverayvpZ46WDZL4fyJN35y9zdJApCjQSJPxVpL9flrA3odGh1xk3Hyq7qNNQdB/iZqsZQvRdDmUgsVGSLCCc9kOVsFZyeIdlMZC8lWLjM0Oo2+4jwf7nhprsYu3p0RvwlUoGNSTk6ruTXpEyWcIkkXKPwD3QSiEs84Bnlbx18=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:41:52 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fmlNu-00078q-1q; Mon, 06 Aug 2018 13:41:42 -0600
Date:   Mon, 6 Aug 2018 13:41:42 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20180806194142.GK5007@mellanox.com>
References: <20180806120131.169f70f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806120131.169f70f3@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9767a75e-6880-4dbe-a640-08d5fbd4a8be
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:XnUVGFd+SR0rg9Dr6zOwInQid2VwQXWNd7bjxLuU6Y312qU66Q9mZ9DRv5rjQ58YhAb+DYzIK5eCVl6j5s0uh3qnFflt6ghkMvEhYRGr3T9X200+iz6KTnoZs+pUY7b8G1SPfJEVT/nLdA/YHHEn5Uq5Ri79Lwu4oLWezWXQCKxHzhjF1y66+WgoszTu+RVUP9lICLuRQo14cTpgEby27RKsJR+9oKIm+/Yef5K0ld0OcHk2yd3dPJ4QM6bn+wWH;25:cSqZJpOADo9G/L+UjauKkLU4kDK7rKwZe5QH1QsF5eLjYfS+KCishZUDnqT5vaGkJsMr8bgMPNqJPI+COgVTnCAtW2mbccdK/fQTBaZF37D0o2vOk/j50uoFWUJqU8GV1RFUCgCdnkXM2EbI2tLXHEXSOU2zTPshCI/bbVfKTZsGOjhrVyME6HZB2AgA4wIolors7Ty1ESIjztHU95dyjGJ61Ap2jKx7wGJRShr1lzKYPAnStcvZ+vilvjkLx57fG9BXoaaeDVHjgLZToRmjNwfdrcxok2W0TaX4o7LJJB8DTV/JJfhAtWUn2seMd74v1GxYuliLoJzx8mm/HkMM+A==;31:Gf5yoo+3iLLETeRWirq6XmNYL8qozdfCrjcxeJUrfjU5BlHqZVxZUgjq35YcdL4QCgby/K4FbXM59k2mP34T/TexRIMILXocWdvmwJqQxhm5ff4iFE/SHhxZuH7etontiG0s7Ruk5M0UfAruP7TVS5mjbrjGlJZ7CYrzFoQ69Z19ieQekyMB4QPPYqEFXS00N/pmtDPTFN0Eyel6xxJTqBFX3ZNQCW2ZsQ8Cs2AbhTE=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:RoNVtYURSzcTCnMeSTGzqy2a/GT7/eSiHjPR4f5E9AphrNvcWch6zBPcRsI3CTA5DzbS9JMU8E4ULpDmTugk35LF3igAsZMA5kqrKbL4vmja9quRyBx6MDBmrpo/VlFTfIf/hStHA2Ru2SuknnK78t91dISyQbSJJp74Cc8gA8B8+VQ/5QN0BDuPXHN6z/amugt+4Zk16BkqtRyutiXHIIrtLGOWnyhODi5lCBHJKIDZK3bejTqI/64Q6EXquKLy0DiNh6GnejHEzfH9Y5PDcOCEaasWY9IkpYCp0aWwdS2PZsdA19E9hPi1IGFGWVTpt0khcsKOWqcbSsxCioYLKASkpDLWwXDEGzEEzczqZQgLwo5IeMFgq0FuI7rEIiRbHf9WSdxTXyYG4a5i1Uv8cY1jNF+c+Tou7k0eKOzTHl0Q2QOnnI0qB+fz9pg9Z25/C7v2/dPj1ApKZ8x8Q1+5HVw5fo2En2DX/CJMuwF7R/tpqVZ06T8nj3Lrt6ObtpyT;4:wWZsqBSm+7v8AxjM0ezARXdfcaX7u61iAKJTun42xtm+t09CQYY4rf0yXbkJytzzcLCv36u7sIP93011jH/ibej/O6kc7L2LFG2q8JjWuFYNnPtssSrAe0DjrH0lrSF0YokzfVUBEzOcXq5IeQ46IrFcmewwvVkbmY3cULO6VpexEJdaYpC2WmKsRcyLOgxiABYi1NpEn41zLumUr4fmmJHNfCQi96HtJ8FiTpk53uXqXjE9uIbufvo6ULK91LRbpwR/sFmMSHei9ly8bNGX3Q==
X-Microsoft-Antispam-PRVS: <AM0PR05MB445012AD35B1546E874557DCCF200@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(366004)(376002)(53754006)(189003)(199004)(52116002)(33656002)(47776003)(8936002)(46656002)(186003)(57986006)(26005)(83796002)(66066001)(9746002)(68736007)(386003)(105586002)(106356001)(76176011)(9786002)(229853002)(5660300001)(69596002)(3846002)(23726003)(58126008)(6116002)(50466002)(7736002)(122856001)(36756003)(476003)(6246003)(81156014)(8676002)(97736004)(2616005)(305945005)(478600001)(11346002)(16586007)(54906003)(53936002)(316002)(86362001)(486006)(426003)(79686004)(446003)(4326008)(1076002)(2906002)(81166006)(14444005)(6916009)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:uNlyqABoVDxig74odiYooqSBet4UQLnxjvBsjvpLs?=
 =?us-ascii?Q?nJzTHh0MftkJbjuVxfTAgV60Bo4OH5HV/YSL9KBXEcwrwpEzXTb7KLzavyAT?=
 =?us-ascii?Q?MCWoB9aQOuz/vcsI46dI+NZtTH60AJISw0ZOycy9kfIvOIDY7lN1NdUoZC2i?=
 =?us-ascii?Q?pywzWL/3ZiSEV8OMKHrXvnZNDoQM83DbPjU5sluRpKFE+6mjrrwfvpStONBo?=
 =?us-ascii?Q?YksuUq9BXLDds1ohsLzY3ZgNBOldCugbPbx/kW7zCw86P7QRZ08Ia8hZOUFm?=
 =?us-ascii?Q?qCdn1NlE58teyDF7EXHMeEJ4vLHOCHcvidOzzx5H+CVvdW4nqOTjEoCzeY8u?=
 =?us-ascii?Q?ZLLxp+54cBuLAArNMu2dGdDXquEDPqxpLxZfaSDLEJABy3BnNVZiTFM9kfjE?=
 =?us-ascii?Q?k1LoeWzgWoAAmFhvolGuDSLqL8iuKKevcYCYRMQxEP89z7pKu/otX9xAs5d+?=
 =?us-ascii?Q?/meybDX1qMGVSld6UoAriZ/qlwPUSar9ZVfJ97zWHHlb11046PwOsQR73SJq?=
 =?us-ascii?Q?feRPCxhCNigroRY6H8+H85BnPAr0kDuSHXhApTXTEgWi4Pv+ralNt0CtwfTD?=
 =?us-ascii?Q?9Dobt+0nOMM5aSCVrZKFsAY5qcsHb1bXvcm71kVHqXtlvKo9AOQWA/KllWf4?=
 =?us-ascii?Q?VdFvB0OOEAGux2uK6LbzdkAHUyTmswIp89UyEcnBxmQwunMTRIRlH40X1ttB?=
 =?us-ascii?Q?ICT7E1momryUvQw/Xp1k3v37pSFyeqO7GErmtWgjUnenqHbF+QLFi/VC6utM?=
 =?us-ascii?Q?C5iV6Ac/Z/QT44rC1KRT64eNNwP21xOHXHyHYUPPmGoypxSJgepV0/L1S4NF?=
 =?us-ascii?Q?dJm+LJfsv/newLR+I/I7ufsiGMR4co7251pMc4atNmMRzJIoBQMGffinWW1f?=
 =?us-ascii?Q?Vz3B3c0gA7q37SjyuxlWYQK4sMaX6MNmZEM5teOb6NwZpE7GhCjy4aRDn5Q7?=
 =?us-ascii?Q?HpGh3o+raUt4kY399NAnG5dIMwZFOTC2DD6eARJtoT8H13/1bbEYjxHEI7o6?=
 =?us-ascii?Q?CMCAbmoLcXUasHr1I91Khpkgg25sY3I83wOfvwNXgXnGtyyTbDq459CKkHio?=
 =?us-ascii?Q?TsgcaCF0J4/5ZvP7i1RBovFamYroroyLdz2DBwsXweHXMhD1d9/RAc+6gG+Q?=
 =?us-ascii?Q?3ekqi1spNufbJpKMyjQuJsSwaHIh1PpdGCDwkWEf+mlEj+mDz8xrjYb9NZ/b?=
 =?us-ascii?Q?8q2JgHxl8OSl88ysnP0R+mTpHLcowtdVf+9niu9/O001i4ctjfN1usBN+e0z?=
 =?us-ascii?Q?53jquXXStkMVRm43aN6YYBuNHeaHxAb5h49yrWu8Wn7oKtFqTS1p4OasyUNN?=
 =?us-ascii?Q?L1Meehpm/eI/4YkS5tmrO4aMNlY6GeGI5tLKuZoSFS72/ECEMeb0WRJcDUDq?=
 =?us-ascii?Q?eMCHuDUljACYcoCnOflcBsZsp0kK2DyX+t4Vfu4S2+mnE7I1mFogBsVwJCLK?=
 =?us-ascii?Q?EBrPkmU4A=3D=3D?=
X-Microsoft-Antispam-Message-Info: j2pzCbVT30Kf0E/L2zXZWTvtZ7DPq4RakCiMrC3CMbfqVCOdWQnGMztyYXIngJMmMSv6pliDkVPTl0l9WaGmGITfhNhAcW3MG2BLASlgALcDyZKMP8l81KAu2h46lUdNLy5EXJLkaK4EAs04CdNDqYAB0vCtQPn6lRRfM8M5KMuoOfIiq8aCUU2CJZyvpEce+m51TDPUIHi1rw5zT7mDcrdS+kBKDx6r1DpRxPtnDd6eX7qLF87FBFOPPJAG9m1hTrsJUZWhZd8K0qkjgxk6BC5WX7Vmju4EoVHLhgnHCO7z9KjdJGO7sCSWNJmYEya3u0npAWcbSdtDrKIqowzG6Lk3++SZvjX5KA1+oVXIBZ8=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:bYFX/3A0MDL1NqIkgUBhxNGPYmcZ0RppbA2oamFpTvf6Y+nvjK9o0xKFWms3hzLhKo0mKx3hLWEWT7jjRLaFN1Xz4JUBv1xLIY9/RQf5yPeV3ILUO4M2h4L3W6ZXwFPr3VEv9l0QDLjlEsvBPIHeXMm/d2o9Ji5uopeAEAv4gu1lQa/A4nuOxXkO1qfBlwBhVVzuLilzKrEKUlBuxMHIb7DkAHe+8KMVpsjUCcoX3ccKlyLJq6zV/+At1ystmsdB+yC8dWTR4nsoyyCATXOJWU/S0ZI24+9NnrI4vzMZDoCr63ukTmripeHmU2Fz+iX//8TyC9mbcBwHpy8QruD4sfC95fCtSyfNLBRsyO+QbrlMiJL5yRmU6DZ2mQ4zeqnmBvragB9VcpRbU+vNw01mhquOQaZW8V/XRMXULorVqMVlVFkcvAQbrw5lV9IihDdrPxE+wI7qt24cdH4VoCzP4Q==;5:A+Tk+DotXVCMA0rHfwZOSeZBg66KGnVOXTDVImns8IFy+1esrSv+U2QJicDfRrZJrB6pTPzRD4xFzsibaj1al6gRzP9ylUf+qXzSVJsCg/kJ7a1jb9lFiDx54Q+ds/cVzGqrz5ThE55l9szsskHpzatcVDB0MZ4JVg9wCSCPBRE=;7:aeB9Ox+LyACyeTKj8AZQDlqkRi/SdsPN+EKF/EJw31WbKUxhksupXl+71I5ppChLlGTFZ5WJ+AB/ErT0s+FImLbOH+FxwgFb+0Ly1ulexRc2bmOYcEsioUG2xmCqR+Q5EFQCJcdpBWiHfbC4i1Bxdh3uWPqUCXEXTB2twxDNP1RCY7xDhpwihiA5nR/elelNHdpYF/Nro+xGHtINXs4xlnIh5DE3S4kWECiFotRPQ+M8+IMwGcbiVund6hd8FLCq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:41:52.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9767a75e-6880-4dbe-a640-08d5fbd4a8be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:01:31PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rdma tree got a conflict in:
> 
>   drivers/infiniband/core/uverbs_main.c
> 
> between commit:
> 
>   1eb9364ce81d ("IB/uverbs: Fix ordering of ucontext check in ib_uverbs_write")
> 
> from Linus' tree and commit:
> 
>   a9b66d6453d7 ("IB/uverbs: Do not block disassociate during write()")
> 
> from the rdma tree.
> 
> I fixed it up (I am not entirely sure this is correct, but see below) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

> diff --cc drivers/infiniband/core/uverbs_main.c
> index 2094d136513d,6f62146e9738..000000000000
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@@ -748,24 -758,8 +758,18 @@@ static ssize_t ib_uverbs_write(struct f
>   		return ret;
>   
>   	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
> - 	ib_dev = srcu_dereference(file->device->ib_dev,
> - 				  &file->device->disassociate_srcu);
> - 	if (!ib_dev) {
> - 		ret = -EIO;
> - 		goto out;
> - 	}
>   
>  +	/*
>  +	 * Must be after the ib_dev check, as once the RCU clears ib_dev ==
>  +	 * NULL means ucontext == NULL
>  +	 */
>  +	if (!file->ucontext &&
>  +	    (command != IB_USER_VERBS_CMD_GET_CONTEXT || extended)) {
>  +		ret = -EINVAL;
>  +		goto out;
>  +	}
>  +
> - 	if (!verify_command_mask(ib_dev, command, extended)) {
> + 	if (!verify_command_mask(file, command, extended)) {
>   		ret = -EOPNOTSUPP;
>   		goto out;
>   	}

The resolution should end up like this:

        srcu_key = srcu_read_lock(&file->device->disassociate_srcu);

        if (!verify_command_mask(file, command, extended)) {
                ret = -EOPNOTSUPP;
                goto out;
        }

(ie take the hunk from for-next, discard the for-rc stuff)

As commit 22fa27fbc64d01cbbe1e4da751e64cc22d24a6e4 also removed the
'file->ucontext' stuff

Thanks,
Jason
