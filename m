Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05359C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9530221777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="uU0DR/+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9530221777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeHCSMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:12:12 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:43008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727144AbeHCSMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5FgVVc9/oXHccDDaWLQrzOOTRIMAXsF3uB5osqbNIQ=;
 b=uU0DR/+4kBdD552TDkglcSscjXrB8vXjNR9NR7rdkZUfrGdziuNgAT6i4yN2Dw918xGf/l7bcM0s9okLGoL283UbQQZoTqk6ImjJ3qpfLPuWU/EP1N+xjfmJd30Ae1Jg6YAntltXJgjL8zEPykqS0AjFpJuShcT0kEPLvVoDRWc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 16:11:14 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1flcfO-0005TT-Jc; Fri, 03 Aug 2018 10:11:02 -0600
Date:   Fri, 3 Aug 2018 10:11:02 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180803161102.GA21002@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::40) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13effb54-d741-459d-de7b-08d5f95bbc86
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:pKBzvWu6GNPZrpU4Xfzggxlx3ZFU/Lrdpl0gz4ENBgEJ20uBq102+K9v1Pfhq4XLWTsYCkv+H/9afPC22suihaKdY9FUddrYTr2TFYESHKUvZ2Yo4xqOoCG+aQED5wEcLt1fZAA4lo+zFYXwDH58nDRlhf6f6f8R4ZODT8RiYR22k0038Zt73dIJviiubz05JdX0p8dvo939nlXBeIuV6sssfzpgFOmyQi3gfpWtl+IOM2eobQG8+p4PjU+3xyb0;25:NuviI1PRXyyXS8TRouoKoboHP+90RGlRUmu+w2qK+0w+TM6LLJhPra7iIHlTw1juqju/ZLmST1Ch89cMJOt034kIFHm1xDPD7IZYY2WyxsHOMvoj/SjM2JdGDfJBbvvsIZnuPpQy1Lpu7/LJHDh1kRJXm2hGZ9xlyR2Ed0acs0HGa+7p5GXMF+CsbBOq5ipRrdPL7rPIYpkRz/UAiU+BJwuFCk5TGI04HWYXylbonUGjZUjft96JiLkra8d+1/ohZPGG5KISMKzTIUCCHn/YLRiLXwAX4t3cE3UbdlyCPwj9CGoPBUcj/Co8AdaU4M8EvY1AJu0hfjSC4/GEHC4/hw==;31:kxWrEZLXOueXlcVKG1xndLOSwBlb5lfX39LKvZHGaxHGtuZoV78hqUJKI4ZB6FTJSz1B0Jst1xD5znIFWCOqe2lzmwNwwIhV5QvxLGtCq8CQ3xgt3fxiJm+Qqwxa2gX4rLgHodQOTqPowpZtjYL68v30j69IceuBFhyYxneJsixH3L8V6V4pfNP7dO1wqz+6fHKMRtEEFCf10jJPXgMsxw7zqrKsow+k1nyx4mS7CMM=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:IUaXJm4A2DVCfE1+NA6bSsjSC1q/cOsJwsjrW6Zs4G60cYaSK/FbRjYQdmfaXM8Hxqi10zPFTrms9WLAZ4jne0jp6YGPlwfpknObd/LZk8W1EHSMxPpa9TCEAuxVeM2bM+1nBjaMVa8RmF/ko8IeYUK0D5akVoPOxq23JGeV0m2/qwsEI9sM0Y+OtYuXO4KdI1gP+nAfHQ9nHs3MU0q+j/evKZ9XfQH1FJPt04jR+TP2L+N6VfxoGt7xTMIRuXmsjjkc5DRJje+18tk/F5uj/6sy6VYFivdHcG7eMXXDC1GKyTWNcfvjVZQIoNbSlT2Em7GFjExgmlB0V8mVdWzBIhxzMyxHl9mqOIoIH1opEq2mWDjU0mYCCTWq8zhGgCOAzlKmVUQQQ8TgFuQ7yQ+Mi4yyJu/Y2/sD7P+j18h5NXzJb8O6FjqdpKzbKbFwT2wiVlNeJvuhPkMHPUVHnIX3Jm6FooEOxdwUlaWcY0ywagngldZyrFwcDJnc51jw6fON;4:WMM50wm83heB8aogoGHJFaJOKnOFzbCqbZPHbRGDenVgYzrBeTuMxUn400uiedCwRtvkFtXuvrEW6TkwtAOAUwAKBkz7iWVAxz7tesvMEghNiqfCf3LRrEyvmJcst3NJApMxbhHqF8lHsvmQJPjPMZmwbxNakU2tzXUYX0ukGxt+aN9q5MSGE3bwAPCdhUy4oOcZjBd6o7cj747GrpOvmcmdL/51OmgAMRI6Fzhx8LiRTAoKsKKXRN5ruLa5W13qwTgggjz/W2+J7VI/fehlJN35mtvuhjINSVP5GTWrV+CWOnfKBki8D+UZCMyT7aT0
X-Microsoft-Antispam-PRVS: <AM0PR05MB445006929878ED0BCBEB1B42CF230@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(68736007)(52116002)(478600001)(21480400003)(1076002)(386003)(33656002)(44144004)(122856001)(36756003)(33896004)(305945005)(26005)(186003)(7736002)(16586007)(8936002)(316002)(53936002)(58126008)(110136005)(106356001)(69596002)(105586002)(83796002)(81156014)(57986006)(8676002)(66066001)(46656002)(81166006)(14444005)(9686003)(575784001)(84326002)(5660300001)(486006)(86362001)(63394003)(476003)(9786002)(6116002)(3846002)(2906002)(9746002)(4326008)(97736004)(18370500001)(24400500001)(42262002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:gx3VHggzRO7sKBaljTDm2JHsYTk6quJdctLouS2NK?=
 =?us-ascii?Q?tuIr8tWIycBKrUU9H8i6EdyTiZ89wSwX+dAedfqIj6wPdJGyeqZuOGF+/w25?=
 =?us-ascii?Q?je/lfVvqZ+P/2MJnmvYoO8352n2dtlcRQjtdrNmzazzRGAz+ueP6rfLpRa+9?=
 =?us-ascii?Q?Iju3vpzGsRpEx4BJqjso3XLGLn6UBITe51GfsxdQ2GnZrSnRi8xWl/lGi9UU?=
 =?us-ascii?Q?dbiAmboU/rjQOFy9wIxG1uX7m+Zgi5iK7kol0u4FUGoG349Q3nGZYzQ7qANw?=
 =?us-ascii?Q?1Q0dJsiKafcmYNKQrLX4EcTqUsHpl/N/KoYhoQdVt26KkmalmHjDSyT3acAh?=
 =?us-ascii?Q?BAbIwTiMzuRuagOKoc/rQaIoFm1QqqF510/vzO+7mZmxRnMjmwU+2ElagslE?=
 =?us-ascii?Q?Xb0OZmV1WTtujFIgNIjZjS4Vlzbg3xcxOGn7mxEu32xtE3DuCFk08ey2NQ58?=
 =?us-ascii?Q?U8RPpXPaIVH23ZvfsqLo5cpG4j0LdPhegBh1ssn9jJ2GfsOYsd8asL3bQefF?=
 =?us-ascii?Q?MXRd8u2NscS9qGQ/oj9nek7uF0PGRdmfZvvQ7kvU05pWyBtQ3JFBvKnHX3TI?=
 =?us-ascii?Q?Xv54MReDqEN3VmXGxCcTPiTakulwpIHJPioEgQJKz9YbSqdXyBaofTFcdsJ2?=
 =?us-ascii?Q?oucWSNf3+XoFGKGgWWeEDknZtxCEYel90L8SnV1Hsbfe7OsKiUbHnghrEGl8?=
 =?us-ascii?Q?yH96cXcIDZphmr/Xx2EeHxEZGIFFSp98w+TApXjZ+kjrN1JYK+53nM1In67O?=
 =?us-ascii?Q?QdwndNAveOFU5+MPPzaRsN6ao6fBUWljh5IZpsHZwMYjIz+s+QvSfQKd8kn6?=
 =?us-ascii?Q?eyWSt2ZaAlXkS9Ty+2etM7gDKlFoBsVtsqrN2Qlx8+h5eW4eM28IlbGKlYvK?=
 =?us-ascii?Q?yxE1Ht2F4EVBaMcYD6ZjaFYfPfKYKIqe22X0SghBZHUhmpr7Q8f4AHhkbFBX?=
 =?us-ascii?Q?bACXnwl8AZlq2QASIpIL91N2thFMfmIxMzj9kAJfLmA/ECXAelWZvJLh5Dnv?=
 =?us-ascii?Q?AvUZxwPSifObC7KJ6B41iKtNTvk3FA8V3zrtdQ4gaKMGlLkPNRWYKS5A/Orr?=
 =?us-ascii?Q?wFzzhGkAfXhxYSRH99rzyL+VnenZEErNinzgCdp6q/iupYbHjRxuxNqfya5D?=
 =?us-ascii?Q?WaEh/oHjtMRlfZp8H61tmz3ACY8OUQamu/Opg4xERXv2BPc5OQgP2dAhN++B?=
 =?us-ascii?Q?3Hx0HFSVaNrLkdHdJ6R7hKJBZVuIls20wpyd4oXZnzeqmZLHVf0b4I66+WlL?=
 =?us-ascii?Q?VhhX6EHYSlY3TNBQDiPWqyrLRDkVlZRm+bsttcS+uvcfazrvWaQEuGSE2iFX?=
 =?us-ascii?Q?h4X2dMUvVLfq1qEHv66nEnFPhNqV8Y5yBEcn4Whn3Qp?=
X-Microsoft-Antispam-Message-Info: OS0dUy08u2j3peQmCSA2Gt45rHRWuq2T0w+VVhSsWo016t1G77Sr6bOlUi/PN6wUkgU357wbTSO6/nhTJfzq1F/xWABTeEF+qqY/n+kd4yxugsOjPbUs2wTogrRPktYnrQm7QIaaH7ZaElRJTOJG0PdGvlDavk8wgxylQJkMoSntOkAgoE2csygx7jYO7p7g2ZeYm6LMyXH230mxYrB1rVq5NeYbHnm5kQrd/W9JC4x+swlVZpMhZmU2rYe4NpCO17U7twRNEI8mldCJQ+BY5FkBsp45YodeYimMy45tMa40tQ91KEHGuIaBsVRueKAMptx0G2+Ot93s6YIIPsWBS8JrmPLMfNR2Vd/BoRywV1Q=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:c9jZcuTJgyuBfS7ZVJm4dnoPqek+/QqlewUyq/dyPeKqhVj3md7VZ9e18/xlBCXDYsHIa4oxBdVZb6yX7RMBaUVr+Zif6pDy07Q2MtINQpUrTf1x7jYFEgMT7YfMn6rGiQgABhPhl+kO9LvoqLndUKNb6zKeghrI/JYm4hcKAsdGINQGJR/mRytYIq4IhmpjunoV1hRq1w9/LPAv61b8FQF0d9O3j/cMlS3AYxjw11XOj4fiYNDxXcRGm/amAM9B8GKVy/uy+y4Y9UPvPjsM6NQJhcgA53teJvf3lEhUOGWRBsL2+RhAbtJjWkwkfWhBjPU/wFV4LH67hA1CCBf5hmvgtb8T2Wwm1ta18CscmakxXRymNJxNn7+iK8DnwiAOxs1z2eeMXf03M0zO3pjFgbwZJ1f8ZPPKiqKbSxSWYAJKsQY4u5vjuGxiJuViwkn/Cd3OymwIpXrVzhHBEwWLfg==;5:+KUFjG4HeTBLOngcE4Yhes5PZxq1YR1FvlUKwlA8/rGdYIjg5A305RM3zoeulxgCfBrg6quLWz5S5lSm6/ySn7g69vPuOJd3gtwVFdbNhCAFCxT9SAxNDqEdcQpE6ee5vLG/eJt/JKPB1dOJzHdIoSDTTvHKDtxrXji+ZvW7bVw=;7:iS9PU9iaOZJPtqUYFimkmPT4uyHFTU0ogaR0oYbfybu9sMEMiU7ivOArQnfkXDu+8eBrKWysbGWrG99KWom7kRXbxYHBO7HEB2KrYTxuTAt+eL6htqMuZbusmhsD/pE1f06di6G2CRUtwlfQbnrNdpyHFwV24jmf7nB8SwwRJdZlGpJTYmpRwSOnMqIgG0Z5zIKX8kZ2EK80izkmM/VNBREf2rb2vNhA1TXToU5C4QArA9QaVQbbUdz8IMG4K5bZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 16:11:14.0987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13effb54-d741-459d-de7b-08d5f95bbc86
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Third pull request for -rc

Things are still slow on the RC side, this one patch has been sitting in the
git tree for a few weeks waiting for some friends. I expect this is the last
RC pull for this cycle.

The following changes since commit d63c46734c545ad0488761059004a65c46efdde3:

  RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path (2018-07-11 14:16:13 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to addb8a6559f0f8b5a37582b7ca698358445a55bf:

  RDMA/uverbs: Expand primary and alt AV port checks (2018-07-24 15:30:34 -0600)

----------------------------------------------------------------
One bug for missing user input validation:

- Refuse invalid port numbers in the modify_qp system call

----------------------------------------------------------------
Jack Morgenstein (1):
      RDMA/uverbs: Expand primary and alt AV port checks

 drivers/infiniband/core/uverbs_cmd.c | 59 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJbZH6UAAoJEDht9xV+IJsaxb8P/26p16KMWp5DPGTr5Kk/XxSg
fxkJb0EM2vC2kXmUQROZIIUkYwwkG/tvOYYLuRpu2mKTpPkQnIhI5ksbvOaTqN7m
+8YrfaD4eSfcQ+KVwW/6/VPHDcSHmeeIhp2ldV4TibYv8i9aE4BRk8vmm61OSPq+
k4vqAGdj4fhhWxq6+oLebsRarYgk57oXgqKmcMI6x7VQ86lcyj06Msb7xPXVhQCr
EUyPq5zreRRvgnxAby1yAtt0KV0gtzLRQ5Ko8xMHktxobzgr60fqoy6ZjUClxn8S
lPzjbL+PxOTtz7JvJ2Fu7bcEC8iAmrhxBlSdLp11Oyy7xKL13YeO0LOQnah7/LnD
5e20law3Z1K1BSDqT2FV+WZF6DmaaeqSmMkkV5bZLVLvyFLZ8HhY2XfbIy7kZ+Fs
bOQvovBztVgG3rUZqyvexBx6I7htbaoI3G7951UTR/jA8DKVI1DLobtB57AXEtVj
8A+qSRIvmnO4/IAG2eMPIxAffXlGVz6u23OYcFD9O43lPME4b1jGYLue8Ak91qdc
h/VUBsxkxm1/FaW6l2exb1Ybh69CKmtN0C+nBkL5xrAwzTmEnOreGVjn8zPBa/8W
PzCA5DEk4tWy/d2iese1UIDju781ts4XwHZZdbnphdoipE0BRijcqo0/cxEJ5i7J
+FSwEerK4XeRMr738IU0
=dJZp
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
