Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E18C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546920857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dLvghPHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeG0EIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:08:24 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:52352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbeG0EIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc5w0lwSujfxYFIrnMk4ek9Bgzwc5KscL1ya/7gT36g=;
 b=dLvghPHXWKu4E+8hOAWcbokmEYCqiTpG8im0bXJ7gom1Rsej10HVSe/RrHTX/y7PLhnrmepZtH/gvr9xhkXrNkgvY61RYQqWQ+axhulqvoV3a40gbCglJY9GctSmESJY/HaVQpP9pVxNfLKyKNzYRY/sYJlb1lN+Do5EcRxlQTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4456.eurprd05.prod.outlook.com (2603:10a6:209:43::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 02:48:41 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fisnw-0000zi-6x; Thu, 26 Jul 2018 20:48:32 -0600
Date:   Thu, 26 Jul 2018 20:48:32 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20180727024832.GA30023@mellanox.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727123301.3ac97ddc@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: HE1PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::19) To AM6PR05MB4456.eurprd05.prod.outlook.com
 (2603:10a6:209:43::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f38c90-14bd-4bff-5950-08d5f36b76a0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4456;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;3:iAbvxlj+ZafeyhPqkeKauwWLX4EuhJMCNFQwknLptg0uHhchBjQZQInd+M8LvEhU6k1x+1AkqGMDXUWM/d/JNdsmjjoh7scwheTfc0FihoWg55vF0Bij8kAyeRVX57c1nzX5M3Ks4fRsel0b43kp9gqfA+Ka4bjFcwGl/MeFKBlmfjexnjoB+xHM9Y2ZsxhwW28Qgttu1+0nyBAmMXFGbzkUH23xh8WJDwJDjS4FcEnFNpmy9nyPob4G/gKFydU9;25:bgCr/9PbqP47nKYT1as0J516qL/MyrfdgcDp9GufgtV1KQ+ITWkvra1AlixMnQa6YHkKgYNlDiz9fp3cGOhHy+pAXrkqAl6Out81rRmmZxUbiGpWUXVcmUhvz7AJppkd21Cz2uGp6rWsCuV/XEJ4qEIV6zaZmMiYoFZ+VfYbMqJUEGbPe80GOr3dQ8s5aVaMzW4iBLFLJWSuc1vyVQZjpsn6dqN4NPqflNv2f7pFlOg4RvjM6yKyaJqi8Bm9NB1eGDXe+ocuG3UivIU8RlAxy1EEt/hjt/EXQKEY+1kzlgD9WJ8APxUA0zZdm6ryCM/NniBRXiIpzuMH6I/g1cux0Q==;31:lKNNz5AmoxeUUCb9LKRVtVEmDad4y5uh0xJvSCpokLAnYyeTrNrWUi4ZpsIZE9N83WbWRBg7uQPNHXemuFryWLbAc3Rq+DjPsCx6WzpzgjfVe+gt0m6x9JQIUfW7E5vDYs2sT47XpWw0kQ3rEt2OW4GsJ1zWiuqVIw0XG6TyEKpuFwH+ZIjBVlx2Z/SgO1bfkHejA0U7Kbt9kNXs0JixmQwsVi1aOXsmkKCi/9BUd80=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4456:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;20:610wrJY8BIOo9fbfcUteycAe0YPoBz5P2CrYkbPVEYbmKXuxXR7PyS27lDjdhQfO9S9g/6GkHx9SwTMbv71v4ybmPGKVjmGFGsp+5sD8cBd9NQRpUvCDmAKmALuqQzcx2yxBAhnGZmvlrUSDYnmYvpmo5aScVXNpUEo4StCJBHNEa8xDaGfCak04VsnTB96PRq5C/R3kewTL1DlaVgGWS47PtSC0CTokW91GQt48PBS/DYI7fvlUl7w1Kb69o57uiha/2TpOvwvJpKGwZViXPu314SBVvHh0rwSbdzN+y9QN0bztgGH/Yr70N5wLTFR3oa6kzKbRQPYWZa059B0sdjDxOX2SQzwiusUbEMldcjtxGAYql1uMBx19KYHqgoK5AdvifROWWu9oLT0N47eSkDdc164ZD78o3XMeXtWzJfrPk++isZfkmMp++/lwwIwULuIVdFtTliQXoEx07IdQnhbqyfXzykt4c/KNKgyB+jVsjnKAccZzJlyvaAcx/maj;4:PczOwxlJEc0/Fg4x8p9PWHzMmd06+Jbvn4xP3Sy3mb6dKX/pEmrilxW5Kfrvgr1LSownGE9EedaPxm9FwSaWmd/IZO1XU9E8uvmum4pkU9eH32xk9wFUScoYByF4vjTareAnYeA2OlnMD3itK83rS0+x0eqYVLu7dXtpMa7oGtXb9t8/7z5G9/68xF9IDyhYI4IrLGUwTGshbxU00KwPVuTmeSuGAFEAjX6cfpuoq0JNF1bOgi2vOD8oc8EFb+1Ln1hH/B6NBoVnJM5QCL0hAw==
X-Microsoft-Antispam-PRVS: <AM6PR05MB44565DFD525CB3B75E591CF3CF2A0@AM6PR05MB4456.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4456;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4456;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(2906002)(47776003)(476003)(97736004)(186003)(2616005)(50466002)(6246003)(57986006)(446003)(105586002)(53936002)(106356001)(83796002)(68736007)(76176011)(305945005)(54906003)(7736002)(11346002)(33656002)(1076002)(52116002)(316002)(4326008)(16586007)(58126008)(86362001)(478600001)(229853002)(5660300001)(36756003)(6916009)(8676002)(6116002)(69596002)(386003)(23726003)(3846002)(66066001)(46656002)(486006)(9746002)(26005)(9786002)(8936002)(81166006)(81156014)(122856001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4456;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4456;23:3XfhKVXAXrb43mcQwmJjvLH/znbRcu698wa56Lyrb?=
 =?us-ascii?Q?BRXhqmvMZRk09FCeUQ2pVzR2nozxGG7Wxz7rX7o+G10rycN2ENrfVcfP3g0n?=
 =?us-ascii?Q?eYVgfV6Cw8fbZQAZcJuZkhrw8kTSYsr+IhONkJVxtfQuCyACYuCGnAyxbCqw?=
 =?us-ascii?Q?LMx8t/TRc7WDfAayOIPUt9pYePy6icKcEmKDm3dKGSyi+aKfO+hL64EDnrgn?=
 =?us-ascii?Q?4iaJrQZkrXK2QxeptXY015nrfyBOh6qRao5cFwsicrYVNcb+pZaVwsQagJgS?=
 =?us-ascii?Q?mmHt+ywItIEdAgz31tNPPX/3j+exUvxEb3Ovu4UN664S0Xj8AJsZsGfs/KP6?=
 =?us-ascii?Q?Mt+I8dZsDmk51m1lwe8CtqXHlRxDy7rxpbLiU8lQL1CT0cwlnfbBWMgQJAjT?=
 =?us-ascii?Q?Q3mghp/zAsearC1l6Pqi8YtBNbbgmOrHTZt2Mbkj94kWQFvLZRUyZkv6ReBc?=
 =?us-ascii?Q?AWjZOe3/jkZldLedGZAg1Yu9lsjq3N7kVAUmAwseTLVJGzzrIITP9UIYSqrl?=
 =?us-ascii?Q?LTzLNLsomjlbikv3CfiDGo9iYc69d/2kZl4c54OXxCIntq0LqheErbiLmY8k?=
 =?us-ascii?Q?sYCHbubxHcI4RvwcPp6UgNTa3XjBnO1RGqwjd0is0zBDrW68QV8ABEPa1PQf?=
 =?us-ascii?Q?qncoxXox/YJD81AIJut9g45RR42l1AvSbNqh1VzqkNgcG6M1xxB0L827NMSf?=
 =?us-ascii?Q?+V9CnsHHdcZatHiEmhIPaxYmzdOHo51rK/xzTh5YGkgqWNvrL4SyFpG9Tw50?=
 =?us-ascii?Q?M599P5/TT3dmNvqdtB1WZiK1kuZiQKuIb/C1VLpWovc5BZMXTrdM74PqXAs1?=
 =?us-ascii?Q?jQJqy+9qo8vtQGC68wqgjD4sl49JDq2tegLxdew6lNyEeYKRFntt7kdv/xL0?=
 =?us-ascii?Q?rQPHTYg1f0ZzjXxSs4kdT//vQVCNuA0QrwH0piPk1Oq9eO7V5k3EAAwh4ckX?=
 =?us-ascii?Q?/1CpH+cgwU+YV6P5FFH36/9kqkez3GWFXjtsDt0z84hOeB1ZbUx8soxCdtus?=
 =?us-ascii?Q?BLoM0B++iVVMDsEDS4Iw0jsBuFENH1Lm04VDcskU6Ev7MTWP/eW0023X18Qz?=
 =?us-ascii?Q?c2RyFRgp4g5IklpLsCCts8ccYHTCn93P4toUfXZh6Xljir/iZgz7Lf4RL4/r?=
 =?us-ascii?Q?TCmVFn196taOj+9ELhjHW8OiUe0gUiKasxuwTiMy0ZkE3Sg1X+GWSKl1SKbn?=
 =?us-ascii?Q?M5GrEv5ziN0OImnvLfgVcvRF8V32ILi6/06lmfUdVRTYaCdlDLzbj2N/R9JC?=
 =?us-ascii?Q?sg42vSuD4P9biCOYgluITyAJlLURxHgMYACcwtPoXVXjCeohdxA5HD6wAWVj?=
 =?us-ascii?Q?IC/iyauXpjHhyi78XDJEmmQaHJT2YhuzFu2kR9iB8EI?=
X-Microsoft-Antispam-Message-Info: AbpAF/LIV57oA/IzbyZpkyxzxlRXuKkgZU0G4j0UUw3KdDXwcmtPZ8iONf5bIR9HIUI49ezPedp0PS100rspQcZGiyWnVu19Oj7JsMAAECNsQMFjlDRRtytEwzDNMKf4cYZsprR//ED4J4/8yGWq9nL8OsO8W159xjQDUZgMW2jlfnMo1Tyj1pt+mPPT4uiHpWVcbi33rlFIMZlUKZXQF2FVM2RLfl/3d4ZIZ3+g966lDqY9jjKowxfbhEPV1kqgKOefStnyUlvG5IJY42uZDmVYQuZo+HcK2aGor2+etA9uU2izNGxicvkFBw2hvfnNcMz6ovafanYiK95aafFI2KSzVSiFl6nAqEykMEsVaNk=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;6:lpdnI7nd15SSEfPud4kfvKd7AhI2J0a/7Ty6RCHGS+i3a1THoN0jEX/9dSni0J03d6ccX1nQBf8EjevGKLA56tpbi/GRTkRNd4CenX/ySMS3X1gHryrxlHpXsdqSBoliWOAnkgX78xEqWhWZmwKhF3xcSbo8HHPBZRS7mnvvqBa42xDqlhYp2G6uwSLrZNrF0I7ag6mY5OwkTUNcjTIfbLjry9nXT6TiHRD3g8BRa+qVXNeLvtf6hHi7mcGS2k/WIpB4ZMxx+iVHAAQwkJpFtJxK5YX39Ao9adHhFAuY18td7l0NdAiopdyJOFvIo4ol7Ij9OnoXzy3IkpK+KxfhkOmHIxVyZi+I3e7QoRxI9B4VXAGwOyEXteYo6LoaaEak2cMzD/koEQHbqAk1rCiFaGKcOTIA9RKvWJGtlm2RpG3uQDuHtCpSdFKv/VqYLOgyDhYAl0HsIMg2Rgphm230Iw==;5:MKASwgeR687HjItog3SgVZCuGzZe6VMDn88j1Y/MEVG8NX2vP/JZ9DynfCaRo4J1PZbouhEMgh/0V580663NZx61D7AyFjVBBxTNJNNY6Bc9sopsptmXgxE0beYXTHStPVMA1ElOq1vIvSnYF5zZYBPhX2EvFMrcmfAzmVpkMJQ=;7:0dIxMEhZEC8LNg1fXEqn2QhV1o+kVTlmaWrJbs2QoisPaZi+vSpHZBtBeSmtwrBBcXMZ54zxQkYwGYDcwCqsAl6N4MsM2aBBEknNNRRQVT/UKDqKp2Vu0yFAoy88pODFDhht0iUCEtS+Ut4fTXV6FoiObjvwqUFEZaQSwKVXWZ8EFVrzRIVPvThBRQES1NQ3NCFBe/2v98ZSt61tsYJzTb1ZfivFKbCg653D2yUw6MkVbeBbr8ItrwM0J5RFf6I0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 02:48:41.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f38c90-14bd-4bff-5950-08d5f36b76a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:33:01PM +1000, Stephen Rothwell wrote:

> I fixed it up (I wasn't sure how to fix this up as so much has changed
> in the net-next tree and both modified functions had been (re)moved,
> so I effectively reverted the rdma tree commit) and can carry the fix
> as necessary.  Please come to some arrangement about this.

How does that still compile? We removed ib_query_gid() from the rdma
tree and replaced it with rdma_get_gid_attr()..

I think the merge resolution is going to be a bit nasty to absorb
that much changing..

Perhaps we should add a compatability ib_query_gid back to the RDMA
tree and then send DaveM a commit to fix SMC and remove it during the
next cycle? Linus can resolve smc_ib.c by using the net version

Does someone else have a better idea?

Thanks,
Jason
