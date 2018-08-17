Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6720B21536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jSFPPML5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6720B21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeHQXUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:20:38 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:16676
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeHQXUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcZs92M0o5RbnOoUooZlBi43H/ET5HSKCCOYtx5sB6c=;
 b=jSFPPML5id64udon8vwgXBOAb9eMPAZMn5NzNs8VLVjCXWXkq/ZqkrOdfci3QrKgLGHd9IyrvHcisY9JgYdjWWhA4R4BdBz6bFxms7ow2RFsAEbBSnKpgMucOWy2pk/VID4D7Sb6Xx0iXKf1a0krYO6heu1Bv6tGjCC6CmUW3D0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (2603:10a6:803:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Fri, 17 Aug 2018 20:15:47 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fql9j-0007ze-1p; Fri, 17 Aug 2018 14:15:35 -0600
Date:   Fri, 17 Aug 2018 14:15:35 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180817201535.GI28676@mellanox.com>
References: <20180816215726.GA20526@ziepe.ca>
 <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14cb473-b06b-4285-a93c-08d6047e37f3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:wEbTobTA/wtVuQqE3XjHr5Jcnj6M4dy1c+A5G9z6p8NAsA6+k0xSZL4qm2tpYrtBFhvZV4lPS+w+KOKh7LlFC95Y29pnh308s3TTKhKoZS9y/ALP0Q0mjEztSOsu4JRcynzU86yyxRZIUrv+orNaKw9XHf10IsN6fDiciOZuRVlWycQ1dW3keHRceYQE+2pGreYWp7tDW2vLGERf46gbYfYIcyBjQnGTf+HITIX1+0qpdmC85fwZ/uRuHs78p9Ys;25:97ubDfA72b5rOh4dJ5lmzlYmwoX3rhUPr5TFuI7LjGAxM1Ox2JyPWKWE7eEe/5it/PqSa75tnKLNMlqh0jUo8818ax7QOlmH0OQvpIS4i5AfBoJK+HqCShATHb307rHKHkKevDX51v6kCCBYy/yICWEtZ9ZCe3AQNyRVH4l8sVtDgEvDMtvYvFaM6qYwXA2pM4wSD/4lb8p0qmkiGjtt1wU9qFoczHV/uqX1W5o9xP7GsgCxjWQMw4+HQ43JbUPA6tqsUNvdFpjQZUHfMpulX8Th1mZvoiN32zpkfPHubhe6lx3sgnGeZ2XYEFjiN6RZF8+OYuzdKqqWixSppD+wbg==;31:ysCUogdfKM2/3Rmx0dm4RxHXDAt+Sas6N8P9TudvhYCbEs+go2vMa0wv9i4u8K13bBxNaqe50DRd2cKhp2sRUnxozPQecyZ0b7K33Y5v6LsObCM2fzaUD7x6r0AxfdS/GAc7aSGuIWF8Sh1JI2VrdSmXBF2Ube7N2fuTBxnsqKsw9cXm8NNMYPVZJ5WykZZ52Z5fazJjIs7arBt9sSES9cJbVhXcY4r1JR+oFrEYxKQ=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:qBhGqf0d68NeKaYv+3xuKQToXEKbwN/RsRisGgVQPuvF4Dh/ERpJWHPPZLpoKCCqd2PORCj6bVLZybo836cK57rTteTEmHsV/F+K0uV+yIjOEEEhCvZCMev+JMnA8eeAh3AReHwe2I24R2ABWFF6+1U6t1mVnBLUSIcpWILn0v+xVVJEDfrXabf5xCSQ7jINnq5/daxskWu5nfADmPUeEjKGsBUCzFU/sDhIpJK2LhvorJV46Q+8kEL56/YHLnjktemYgD2JCIkNTRK/6IPiTTp38KP13F1f14pQhq5/jTKhc1FxstTjFTzTeqdjyB5Z152Ag3FtD3OqB2tsVYK6Q3VTNDG7KcBrad/msRTjAfrqjqfyraQ62pz/EBIXCVxR0Q1drtH+H2Lh/8wABDFHA4+gjvrZr+1sQ/R3Agpn9ZvJxTFPLURKrzPKeeYLrpvtfiRwYfk48gbLHSJmlGVGffaFehiEr0NqRh46O8SLLKKn1n6IN2nfHZ0xzknkCQ/r;4:h0cn1fLF3WdtMB4TTvvvuVCa8D5l4zzeIGsEejkedFWxhFXgMjSgsF5BTWWxQpEe2pnv6kI16e7yhPsV9rkKqAGDwoIK6KzchRdLbnp2k0F2l9b0E/7Kpw14kobdWZAgSV8+1p4wUl+BK9cYGX0iDJ0RD6+iTjoCCh9RaFgyfjakHAPxMGTjQW3Z8XeqJahZ5k1lT9uxvjCHiCk2saO2DAKTbOYa2BMgd01U92sXbTJp3P5XlNdWN6aZMGwdxXbTEppLo/eWbV9NTz+Fq7aJWw==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462A5E507D3A6AB1555DCBECF3D0@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(106356001)(8936002)(54906003)(58126008)(16586007)(46656002)(66066001)(305945005)(105586002)(83796002)(53936002)(57986006)(26005)(7736002)(2906002)(316002)(426003)(50466002)(122856001)(33656002)(386003)(97736004)(47776003)(81166006)(478600001)(3846002)(6116002)(6246003)(8676002)(36756003)(9786002)(52116002)(446003)(9746002)(76176011)(68736007)(53546011)(79686004)(81156014)(2616005)(486006)(14444005)(1076002)(23726003)(86362001)(4326008)(69596002)(476003)(5660300001)(186003)(229853002)(6916009)(11346002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:jYCyX75T/d1TiKVU76NzrMULl0drS3PCDj/3nafe5?=
 =?us-ascii?Q?+YAR2sd7nOJdwNTEkx+VBjcbzjY8tQu4z9DrzuFJfBivYoKD3Y+lbZeQGg+A?=
 =?us-ascii?Q?2p4ctokyYm7j9i0IwouVKwQZujHSiWxdRJmvLaMRHMRZ9w7Y8TxR5bFO588N?=
 =?us-ascii?Q?LmwszFHcqwUC0G717X34pvJVOS2P6B8+yADNefV2Z8gGSz6hEQRa46aQLGd0?=
 =?us-ascii?Q?HtJkqX6RyHSzqk4VL4BqfmRX02AMJ+FPYy21dXOPf1/9eHTUGxypeclU0KTk?=
 =?us-ascii?Q?/JBIznPSJpqBt9C+jLgs/tSXtMlT0gfJuQfytuWNfO4OLIYVZIUIzctyZGki?=
 =?us-ascii?Q?i7b5epXT/O1EMgZFJEuBLibqzlN+Ice7oVzIkCgwdm7jQwDCoYFy/a4chK0m?=
 =?us-ascii?Q?yrxy3Gr5agYK7u6+PQZvYb+Crwq86JPOvH/86yM9TnryyRVmGnM+W1dx8zwV?=
 =?us-ascii?Q?ZIukqZlIE8X4p6BywzKaiMcto4rY62Hn11cQgoLa4cHSw/B6pwWpxCP7PmWV?=
 =?us-ascii?Q?y8LxYuXOEhLlf6dwIxlG2gwgqCQ4UkXQG5n6wwD0ZhHqYIPUJ2cUVGzsP7Li?=
 =?us-ascii?Q?BEEvVfXpa7bti9DHp8wvhzG0J5p8HeFtfuwfqUe2SkQsqtNosd1mSiwjYh3x?=
 =?us-ascii?Q?UqQb9Cg7gaIXVnc8PkaSlonzwj4bd6TQ+mDaM5eVh2wxK2mw+FLr2+lqIsAl?=
 =?us-ascii?Q?IVDF1vSs/Hh/lu/sqQqsNy+AnFG5YyM2Zfuf4qEcfTFl7J96byc+TMstIyfp?=
 =?us-ascii?Q?0/KBQyZPG8oMOX2uvp88UBISp9CSBvZh1ATjVXR7FX1NMOZrqF0EPt9/kaKJ?=
 =?us-ascii?Q?JbanggTW1qI/4XxSWiSTCSsoW8J2uApECYSy2T34DrZ4iOf26LPtTlh3Z2bd?=
 =?us-ascii?Q?n86tg9+U69bFCWsQeG0xZQHQr89ssTLLlPNLX0EqcDruKDUVh+9vphWMGdbF?=
 =?us-ascii?Q?/sFtq87OUhLwKUD7GwvXhx2dJ4gwBlb6GLqdqZge2HUbuUXrY2P4BISvH2gz?=
 =?us-ascii?Q?t0tyBv4/ljRQJwbarunCL4jusTie8QiBFd2G61bcKOR5h+5HrnI4T7rO5DZW?=
 =?us-ascii?Q?cJ4JF8JWJ1ZXouYk4VSKAhXDg8Z4H1DoDVGMjMeh+qhyawcfvDEFrEBAs1Ti?=
 =?us-ascii?Q?6uXs46RE1BNnoeMFr4n6AkOWv6Ar6smN/DAupoC73KMcM7nUbKFDwRmKXh/x?=
 =?us-ascii?Q?N2Mp4FIXvk6bQyk81R2REPG6dSQfGAbQ1kdSrYydvmM+pnrJrZnHYrnmLSjy?=
 =?us-ascii?Q?j+RkeJIoy0K8YuBcsdZHM+sxae5YRmGDnBz7Rz5km2JYyMacABctbj8VvoJp?=
 =?us-ascii?Q?HXKlvvbb8lJvOPffDar7pOtLbuJL7FZKwGw9Qn2/MRLFFR40adpWwajcvwSn?=
 =?us-ascii?Q?KTmDiVwH6riqoZDC1TgU5phVJgb+9N/utyk7McHqq0YsWtfmrjvDjXhyEFLY?=
 =?us-ascii?Q?v1XQF9ZJQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: wNAr8X+Tiwz3YsS8po14OYXDnPe1HU8TGzbn+1AfwKvDB8yIbaYyHixmvbuBjH8Yo5d4wnAgwszbfwGOBwB6BWtde20if0jDZJ8YJVEQWxsYi0ANdB2DXwVnj5xq6GL166sjr6KdpiLH5edof2Put5Nt9837j5Q+7dj4xoW+bffqisuC3lJi9TtwwO2QLJmRsfZp9aOvIeJbvxjhWTBe3SKTrMSrgYsNp9jwPWPhTS6dKFldgWLOWca+08nXxsTuaWXox0Ns0gMrgCZm/K5ErKafE4zyT0JfRHKKKwg3URByJ2lFX4Rf0s059WyZ4NRr0YFNMs3biCp8GkUjAWZqbFG0IIrjkZHncVGm/P+IJVs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:0lU+JnU1a+UKeFxjFBW/mhPLOscguOesk/EIX/BI642KWZS9vUkaIB9FWReGouVKEv+wse9eW4vSBx27FZAbdUqjGFWTcBEFliDU7P44uupojwKpYJYZppw4/4u2X8iEgZPVnORiBXYmqvOFepi+pJNHvvFebI5yvwZbqXETevY5ayJK55UCzKXjuAuP+Y5Ex2hsUvUnQwBu/wPm7q0w7SpCTzBAOWwaw/CzVa8TjGXs51c7lsthBYJgXaDU0xmScwq0+uEWPnMtdOvJ57ypcOQocV0joggCP953F2xc3h0GxxuBy2NWXLXRSGYQU/2LjQ/54suGm3CYsvvvKsBWRfO9zCybuSNcxG2pGDy95Oz8mPyiBQduq994Re/6pmWPEsACKzPftz4MZ3W2ShiSk8SBMqlcu4HhS6+Aj+CxRUo4fuuIpf5CxifJcspdffEvgv0O0fs/+p8ic4ZGxn/Z6g==;5:rkPnZaK88WBoDdbDOtmiUijDQfZqN4iXGVoTKNFQv+zqcXwrxjyAhLL3O0xlOIiwtmxhtJ9j6CMTm6q2WGhSYcNmiDV/647JRi4XgNMxa5e1aQRixs2s5qgX5zoEr6TNiwht8B/LVTaVuoNNuVrYKYwnyz7Dd+MO7GcLwXPKDxA=;7:+cSg5TtXPOZrHsTrJSxgy8ZsRTxXx70FU3VU3g+FWtbkQ2+0XOxgJyYM4WXlxhgb9JgPb5/G99l2HSjTQSyk9bUKjvQw7gYr5NjzheoWLxM/pwvN2R/DS/GZxb5+4462iAGg0IpFNKAdvxmaCCinDEX2fUqVTBYyScvpxYkkN5oqhsvs8bzr4WcJXf727IzOYA8mYD93fvVoXqIWcM8clhlfsat0qEtFvHcsw/AF4WcH/zEzMZT6xHuefkOwSi8y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 20:15:47.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14cb473-b06b-4285-a93c-08d6047e37f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:31:00PM -0700, Linus Torvalds wrote:
> On Thu, Aug 16, 2018 at 2:57 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > This time there are many merge conflicts, all due to various tree-wide or RDMA
> > subystem wide changes done by various people. The resolution is tricky, as git
> > does not highlight two areas that need revision.
> 
> I was confused by this, because there were no merge conflicts.
> 
> Then I looked at the history, and the reason is that you actually
> pushed the for-next branch into the for-linus branch, and so I got the
> pre-merged version.

Er, yes, sorry, I made a typo in my email, it should have read "As
before I've resolved the conflicts in the for-linus tag and provided
the unmerged tree in the for-linus-unmerged tag"

> Oh well. I'll look at what the conflicts were, but may end up just
> taking your resolution.

We often have merge conflicts with RDMA, how do you prefer to get the
PR? I'm actually not very clear on this part of the process.

Historically, when we have conflicts, I've given you a tag
'for-linus-unmerged', a text description of the conflicts with merge
diff hunks, and then a tag 'for-linus' which contains the full
resolution I used and checked (based on linux-next).

In the past you've taken from both tags, I think, depending on how
the resolution looks?

I generate the 'git request-pull' against the 'for-linus' tag only
because the diffstat of the resolved branch is closer to what you'll
actually see during merge. Otherwise there are always misleading
netdev changes due to the shared branches with netdev.

If you don't care about the diffstat I'll switch to 'for-linus' and
'for-linus-resolved' tags so you won't accidentally get any resolution
commit unless you want it.

Thanks,
Jason
