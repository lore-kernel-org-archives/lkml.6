Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D075C208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="vUHV5xMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D075C208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeGaEhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:37:16 -0400
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:46048
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeGaEhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiKJP66wvOWZ6WDXdH+7HuPzvogVlb80LKSOilKUG0I=;
 b=vUHV5xMZzELz6tNm4hJMAajidhzQvw+f+4nlY9KOicXBjk6kNT9LwW301GSET4PRMuhTLEPxmYPdkbuxGGm7rxXYznfWfRTlLThB+ZsFv6cLxVq366fYv69A4T4xVyqNQTSBd3fq4WUJsfiKxPyn2X7tvXdsmn+jTob4aLnT7H8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (2603:10a6:803:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 02:59:11 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fkKsL-0005Gw-K7; Mon, 30 Jul 2018 20:59:05 -0600
Date:   Mon, 30 Jul 2018 20:59:05 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     akpm@linux-foundation.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add .clang-format entry
Message-ID: <20180731025905.GS15118@mellanox.com>
References: <20180730162431.GA13989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730162431.GA13989@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86bedb4-6196-448c-3289-08d5f69197af
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:VzSp3yt+7Np6p4FEknSgwswiH9xo9pDyrnxWowY+fhcl9S4HWXMc6RaWGKL8uVT4z24AfFVKfvGqVzM4UKVn7dh+/V1klsnHx/1WxbvXbEc6ECgFNRzGBLQrwGgUTr1wVfiKG0CCIyhzwvpjLIFfUzQ7lLU2q4XII4/YPRu1LkQW0IlUiL/waQfLj2ehQrrqpcACPqX4gGC+794/P3jj/hE1bKWKfR7MhBYkF4iIAzxAq260DZRG0ASb/siUo7Bs;25:fSQVlmFKy5SyuAp0CtEyEj/AT2kOPO1P1Rf1Eq6hk0ulNyYMNsPeDk/BlvranHy2cZJtWQkrxDEyunsbv/SBYqMR8eTXL0xI09tNRI8s75sVJIfL7IwJ4Jri0lOuuGorhw/ZMOF+UmeZjqwHcyAyzzpNr+Jl4QrCHI+7sf3TzumRRkCLauOXHJHQyQaAcf5wtpbuJUnKxUDocw8dG4oFdkb/gyZa3yxj3NTc3A9H8Hl26OQ9N4XhHfJWTRf7wvLt9r5YTLuciaNRCLdc3uIf6pVRyMeV5w3KF6DU2nC4ilGBlCbg3S2aOJ1uHS8cx5Kauijp15CPQO35tefv4fPBPw==;31:Qb68BnjvFRDcna8TZyUMTwhcKKh/4+Li/FPZMEJOldu9oTFexXol6mCMW/H3JB9HuHUfHvSuH/iGOmGVxYJ1HFEaocNC5O2PyG3eUAawg3npQYMjTiT8dckyFWpdnWKB/JtdFMgffxsMQ42gKeXeINKlBXHk6jtSjEdCmz7Ipn+G6g5GAUqeTyFLoVpdBPdN1bWj2XdM8dogfZcrgqd4N97SLEugS1wFzFlJQoHfT7I=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:GGPYCjF4ymOpVqOyir84VykmYIJNM9OtO6MiumzOh1QQ1kyowwSsSJLl/tiuafwxclbF19+K0OwswAh96/wPqn7UjINyJL7fPAhUZWVMK46jHf8140S1HH0zGI1FkTbYeWKS82Qa//pf7CQgJ7LgMr6ywDoxvHKLEyg1kUPXaT53U3u4g1QR1PwMtLFq3zNHWPXaLBuW75TZWawYgMwggkiRK73ccrS7fh2l+Qdl+wBs/wmk2cu1eHLWnLBu+MKKm7dRxOyGhGqkt94AvL0oDfYKaE6FH2oWYWnCLf532JU3HapfyedtRlFuuCH3Ansb4PwndauvOQ05bECnwbbisCxy84nJsiWYfSNqj5FtlTn+HYKPGBtNwRZIe2dKcqazAlMuA8kiUIDNs1gWetMCV2p1ULwlH4e/9fK6Oahot2nXNhz9OF48GfMcF24F3D6mXPMdQahfkOmBUGrkCNbmqX5LHNlPuDZ5702aGUrgPFXXvN7xrFTGflTEaUr+57hZ;4:bLhQSri75O/KTf1jeefzEJgYk6eSx3l7Ehrw2kDzez7a+5H/oh6ToJnTgBCpM3A1y23rZOkNtFlbAcYp3DGvMzDJTHO860Qgu+4CEpHQW3vFgkfGM96ZjBjFhbfG/f6qHpvAHkRFE8EgzKuPWeU+z6Dws2CQW5s/dBpWTw8s46Ok+b3VuIaLRknRk+/M8z/irf+vqHOopAI2g0xFseM2JYeAE52rAH5jBiL+y89Fuifx5+H1oX/dCwCUzYqwLbIVMy+l5fOKn7GRBvgpnoYmYgxR0wSwpSsQoDxB4nU0ww9KvcB0NVgDH1Jb2HJ/wB2p
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462D2F1A8A35FBE6D72447CCF2E0@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(8676002)(1076002)(81166006)(81156014)(23726003)(86362001)(478600001)(966005)(476003)(2616005)(106356001)(105586002)(97736004)(9746002)(486006)(33656002)(9786002)(83796002)(46656002)(68736007)(57986006)(8936002)(66066001)(186003)(47776003)(26005)(4326008)(16586007)(69596002)(446003)(6246003)(316002)(53936002)(58126008)(11346002)(36756003)(50466002)(39060400002)(386003)(229853002)(2906002)(6116002)(7736002)(5660300001)(6306002)(305945005)(76176011)(3846002)(122856001)(6916009)(52116002)(18370500001)(142923001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:r2V1kC/BvBevdui+QXT5AaX9rJvaOrDZFFRKOwC3m?=
 =?us-ascii?Q?hfzmCJMPEgio2d5FFrOcpGkj7MHJMd6Cg1KKyiLvCg8YkV2F75otP5bVRPak?=
 =?us-ascii?Q?/Sj+HbIikhUDGtoTE1pSwfy6cbLCrCYIGP108qEbs6K568S4vWbytVbB6D1x?=
 =?us-ascii?Q?QFfLfGYEMWq6ZkQDN3oiPpGG19MbFbdo2boz5wyEvsuphgCGc2o9bsoVGpmC?=
 =?us-ascii?Q?zf8M7yWUMZOvmaXPlRnA9p/Q0OZda8ZOimEvYl9vcttcGB17eckuYQ+1wyvB?=
 =?us-ascii?Q?F+u9r6FxHnqwC0lojiJNsNz0urkpAhNqjVhEp13DmddqRJz/ubNWE0X5Db/o?=
 =?us-ascii?Q?O1WDcRHkFEtInXEQX83n9+takZ+YPBRG4leiMZYz3bn8Gl24Voi06dkEFf3L?=
 =?us-ascii?Q?2WG8+MVDfl4h3onQaf3eVVWFNNuJUVJEZ3JPpbutXQ6MgkzjpDA/HetsrZ0a?=
 =?us-ascii?Q?ctuLNZrtXLdgeXDV7XdGvHK5vzc2kxBSzvoINSQlgW0d5iCFoOWRTgvDI1wD?=
 =?us-ascii?Q?xLFlaDGd9wjJd6UEh7hh76FOlZfgbNKVT9ZQX/D+9ASNFKodovJK5SVLEmNX?=
 =?us-ascii?Q?bHSClSMujt4aDuMP7U1eO1PNIHRTWngGw+rpDwzaUKTGuJuTW/jCyTBP0xhb?=
 =?us-ascii?Q?bsi2PAQsPQYjySC0tW+C+OXu75zY+ihH6qH30cEUoEyOu7Q4QSrKAzKATicD?=
 =?us-ascii?Q?FbpOrcJFnTl29CbREjbj8CxbpIfMnu1pFkGtnl662BZK50hZ+pqsP6tno6l6?=
 =?us-ascii?Q?xqgLthuvXI63cQp5OTlpn/vfmVLCPEAKRiS8DQJmzSxfADTzLR4TNPVV0jCu?=
 =?us-ascii?Q?naWcMOO3AmZ0DjIVHe0JvZlBBDWgV6h4/Jz4MDi6MOt9NdLU5qj4pNXiAbru?=
 =?us-ascii?Q?mzfZuDehe7Yv3ma4G6r6MVvp97KBd2KfShpYaomzxjtQr+5T5CHVhqMJBZGb?=
 =?us-ascii?Q?XHtjMXvRqeViZd3x1Ih8O3btdk3LyOvrpaMrTuoAAXAc3mvM9dJEJxBMblCE?=
 =?us-ascii?Q?aB758xXK9l8smRJavnikr8GPdJF0Q6U2v3rsFsv6bRoNwcm4XkM1QC4KfQMQ?=
 =?us-ascii?Q?eQm5DKob+KjYt1S+J8dToSsBLqTjUaIEToQsGOaQ8ZlGYfMo0X5+3H/smxP+?=
 =?us-ascii?Q?WRJd+oMP4r0L7KQvmghY1mXijNjFDQJfc6/goZc8uE6vQDvnjCY44fM7frZP?=
 =?us-ascii?Q?mtQ6c1tTkKXCjhP/btVk9u+68MxDF0n/V2P1sk/ACgmxSaiHKsnW5841VYjF?=
 =?us-ascii?Q?cZ+g1mT6Xcfi42FHbN9C8ddnX1Sakyttsy/ZEphS2OVQ+1joeZOkXSMg+TXy?=
 =?us-ascii?Q?4QSquKIUNYcv+B98/VldeAboBMb8XD8xbrMn7S3NCHjqmtIjZsTDFdlcdBgZ?=
 =?us-ascii?Q?JhgzSrXBF77faIjeNQQbFCtrjDxaQZVmWk3Seg1Bfiuu0f8?=
X-Microsoft-Antispam-Message-Info: D8lRb3lqweIh1iGZEKKgZfYeDQKEl0lqPiZlo+v8TQEiR0pauZ0R0r4lkWWM6xUBC/mDHJ3JJ7KuI9k5O0sMZybEZZTS9XKbwDN0/xtWduyO5PKWNWR/WIFKsnKEJTxrEg4INFw8tFmPA5h8uh4WrNHrmLN4x2ut2rKlx8dNt+l9TEhpv8uQ+lV0BRPU1/h8HQpDhc8IfJOB4dctA2164morIPcXVpr+/I4KjxJ3Y/fQEwxZGYRturgOT9xLhPwFkIwrf/QthKzDdU3GOVjHmfJMwrLSSOo+0k3a4mItbqWZSXnn2WXwwOdBhKbt9mRPT1D1mxldaE54MFNgzlZJdb6HUbG7zkEbe9AM8cXQvm0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:im5pLNUftmuIKy0gKlzGAKznlT6rgA/3GN7TgTTrrgu94tnl6ZSARmV0ze+n4O+I/8QJAupcapMJstvIHjhqIyeY4DpEoFb/MYRv/7Fq2TNW+nvieGGw+EOUzqdrBqEVcyyH91zCoG4741R6FXJX4Go/kF45lPVHWJJh5f89oxUsc62j48E9Wf93LW+OnAj1U0iZZXZqKqdV0B4DCeermn8pbz2XpvxVwRsXiBfqzcoFpGlsPT+GnS9z7cMlogxk88/ViDMSHnQYHdK0F6tGs4r1upRcf11Ct5lkxkGLg+FTfjF3GSNvlpsEN1fj/KfBPKyjZRPXlqWDKyFRQhYjXEuVIX4URsxoIONS4S3VJduJuEB77lM6p1tuyct1uZq6qjckbQCwu9cWyCBe7oo9PGYWVC0vdOLRVe4/M6CNJ4Olw8W1ASHpAZ3mWwPxpeblqA5WHBdtVMa6J07gXbJcvw==;5:QrQrcEoNN9KaEJkDs8oTRKJN9aNg8CLzyBIPBor4JSZasuXi2mLxCvsTcKWAWl3EiPpyMP/W0CuPMMeFLe35nFHolERieGH1xyxHX3vIzZbnRnVLTdUzxBbTnb43yhPybzJhDTJEvF4MOLmU36sMxJ3CXtnnFEUa+cXYg3tK6uQ=;7:hFm8mvgLjPYyVKOhM4vjlYc6acFCdF2t7BfjrKtDrs+whkP9wIR/lPdaO1X1uarHJCIiqvAiAmU/d1h21z+iyjjMiGyglTvrJUkRACiNc+yK1wlJeE8wE3A0hmlGdQGiRLvp+DkwchQrGw8DrbCGXfhf6oCMB77IJQyooQDlt5Ms5AADYD5LbNUK3Xy8/7+DYlNWIRddxNqs9S9JJbYZAsNayUuA9sN8r/7lDKCEQZVfV7tLk97aWEXpFqajjP9w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 02:59:11.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86bedb4-6196-448c-3289-08d5f69197af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:24:31PM +0200, Miguel Ojeda wrote:
> As discussed in https://lkml.org/lkml/2018/6/25/877
> 
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks! Did you setup a tree? Can you take the patch I sent as well?
Do you want me to resend it?

Jason
