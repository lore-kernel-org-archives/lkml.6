Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6815D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZW36dbbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6815D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeFZTdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:33:37 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:20480
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751867AbeFZTdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X3pc37QQ2lNDOGJWx0r6M9pa63rfSWuzkYxI+TbNIQ=;
 b=ZW36dbbO4CNPhElxhMDWeD1oFQBzgDSBuGC9JcAVR1N82eYqGyf2164Z2naZ4kgtE0aalkjHG9qUOaSPVwp+XoB6hW767DGfLZ/SisH39pPbbIl6l2U08ll4blqWCUzUYsK/+XfOnH3VitOpDMHYV8EF0t7ICuCiCXj/qj+4N8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4460.eurprd05.prod.outlook.com (2603:10a6:5:1b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Tue, 26 Jun 2018 19:33:31 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fXtiP-00053G-7v; Tue, 26 Jun 2018 13:33:25 -0600
Date:   Tue, 26 Jun 2018 13:33:25 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RESEND] clang-format: Set IndentWrappedFunctionNames false
Message-ID: <20180626193325.GA5356@mellanox.com>
References: <20180625224430.GA31554@ziepe.ca>
 <CANiq72mcwTkmEo+CnJ2P33TrTHgXaJEpjuxQjwGx5RTXjDyvhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mcwTkmEo+CnJ2P33TrTHgXaJEpjuxQjwGx5RTXjDyvhA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To DB7PR05MB4460.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3acf978b-0ff0-4e47-cf37-08d5db9bb340
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;3:zAJqv+m8Wpz0oMucDgi2fnGQTt57+VBtFHDfp5vrC+5o3AtIOWaCnFE2cwVMJvDnsuLAICXdkdmmBN21i1CVod/xDGUr6SkZKRPUg3nT5QU7rvKNbEX0mSuhxy5Ew6z+c9hiZ1lphNAPpWhRpgHm1Gcj87/RabcbwaZY33PGTdDXCHO9NfBqe8lOzrBsn2nHi24d5seYLa8f5wK89wyV6c8hHOmBH8zYD/0bE8lNHPF+Z64g5OBCJiyYkqG85W/u;25:YWFacr8g0YkjiNE1cJlX7IRHEA4X+clAzF9g/F/fdWTOanC0dBcL20udJFrCjwCes4hp21lUj/pwwQTpGs4ZU5ek2zGtqchAg+j4Y6nqccLw9FTYC1iUsFBrE7c48D1V3h6lm9RmHqpbCbr1CLaY46heWvevvVfXJ5zRmgvimDxoefxJPlQ6YNgNlHXcJUWvp8ERd64Oo1b8B5mCq8rNK/aBx9fxb0nuIL0c42w2j5VB+rnv5wWC/kndvw5UBT89pvPr6wiKd7YeVJ5LN2SgKIV0D9am1N6X/oHWfPO2BrHn0+kmkt9BQwIaU4xv0zb5tJeHZXM1qhjV3C+og1UxtQ==;31:e1cLGFWnz7GJX0eIGmeiOLsSTkiZYJ9BApy2OT+063FSIIcbkFmUM0FQKhgLlYHBOtb6H3oejMZJee+xE1q6Nghz+8mnCpqcNAMNzgIbQIeFFl9JfvJmpzIn4y1hRXTAsHSJ80c7g/lOn51MPikg1PFIXb81tOLn3yhzosGUylduGlv1c1iwd7n/BjuuZQtKNiT3pcEggDx0QZc9ODk9J0lLyjfjdNKQKcqOAf0oyv4=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;20:g3JdRGY058jDFfKp+a0t2IMafCmQQRJkXSXqnU+Rw8qfBezBOziF6xGrRD2XONhJa/DpWwUEGcSUSZClQ+r5d2TWsS50f4VVze5C8diR9BPTpB0M/5p38xUSymqnMtOiM8B7iy45/3XI25eGPbdrG/jQY91SMXqb2RWYJ5vVNaU4nFp/S2AFtrhp9xlpRY+g4Ewz7iA/DLxOr3tXnHJvxGYNSOMrYRMHQ9u6l7+1KtibnIvmsCbkCqGgfQGKlZLt4WtjgjMzPX7MVDVQIqCxdJbj7fMw992rsh4b8pO6WoNAW7TsfNK4Ms2S1ui3jNyjXzS5gKSdqu5w7nrazzuwS4IUBgyN7hyLoWyumaTsdBBK7MPNoxSn+hF/AhwxVylZAAu79+OCIzr5jElZEPBBklbYlvVfg2J6Y4ywqWf4lRtqH8rmOdf7f1aKJzk1PgbLymk+K3p9fuyfOKJ/oQQ43RZWnbjZxLaXC2UdXzsJ4qLMkEPzHCStB8B7TvGuS4dZ;4:H0rF1a1wVoHTTRGLPHUnO9upl2LX6jzJ88+4TBADjWDUpa/fFqGX0nf4Mn/ug3E3ZkAU2rKNAiHTkPIwSRnEFzWj+u1illvkFHbBOvYV0ho6joV8u46NRhoIW9a19t+KvZg8T1534b4gZvvNPBodxYr5KVDmlUeI92XfMLLj1zM9SxFtizCsgwUpMhZO5/1NI59o3axTnlVm827MkRqqNZZCqhPy/ZIwZkAeoeYq8ahvjrG6mEjhZXovNtfcdVGqxiATPqpU5Ddybjkfb390nlICyF79C+u5a7Dd9W4zozqYjbYJzeLS+DkZ834u20Hr
X-Microsoft-Antispam-PRVS: <DB7PR05MB446031D35E24BB1C28157066CF490@DB7PR05MB4460.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4460;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4460;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(105586002)(7736002)(486006)(23726003)(446003)(57986006)(36756003)(50466002)(33656002)(122856001)(4326008)(11346002)(66066001)(46656002)(47776003)(305945005)(1076002)(53936002)(2906002)(9786002)(476003)(9746002)(69596002)(14444005)(229853002)(39060400002)(6246003)(106356001)(83796002)(97736004)(2616005)(68736007)(6916009)(186003)(52116002)(386003)(53546011)(8936002)(76176011)(5660300001)(16586007)(58126008)(86362001)(81156014)(8676002)(81166006)(54906003)(316002)(6116002)(478600001)(3846002)(26005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4460;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4460;23:E9qPrUJaKk8/BH2tkcXVhQlAMe+YckB3v1KetpNyL?=
 =?us-ascii?Q?4xGP+8aF/awBvmfXPgHnfp+DBgZ3cQ9VYXsckfrF+ItPBxCNh69RbKFHXD7S?=
 =?us-ascii?Q?6Vv5IUvTCIJYtOjxtIfU/0jshWYal0fwHVuXOZaySGIfc/PIdoOLO2E/CqdD?=
 =?us-ascii?Q?cU9bIFgDitEnMznJPnjXkJpGYZUYwXi49KMJEiyBKt8XMgn/kbFwGst24v0L?=
 =?us-ascii?Q?yiZY4t48G6TLEY54VTZaK5aQLiybrgJWadkoRyqW6v1l/SxqRGuEEhA6mKwI?=
 =?us-ascii?Q?tcc/JKQIonLDHBkyDOkKOAJokj9ayECO3qQZ4Rw798lpSZKpAQbMxk6xjheg?=
 =?us-ascii?Q?38CzSTPEvrP0CRO0z8vFxFV01ov6J5a/E9QSwrDu25g9x0Qtj4qhuO/FjtWk?=
 =?us-ascii?Q?X8u7ovcS95qSeeZ0F4fRFz1HQ5qgTJryM97ugeGsZZX3jA7r17843mZy9LDb?=
 =?us-ascii?Q?RcWh/WhOcasjW4IpnqUWODaKQXuUOPBBr/azdIQ68sOMjCKRa/CSw/Wluanp?=
 =?us-ascii?Q?Vu6kU3r/tJUf20HHsDRpVGKf2tmcGJrEqW7DsgAxv2O75Z76Iswk81G/YI/C?=
 =?us-ascii?Q?mt5tw3+08K2yK95EtBAkA4QD/KBiQj3QKSuuCBlxXqkoERmomeG7e+2q4uZi?=
 =?us-ascii?Q?Z7tiFF3MLjUPjqM438nvP4+TGQ7t0OE4sxoLLjDzhFo9E2jgSojf8ahzANkM?=
 =?us-ascii?Q?8S0tU6Q/+GdRk4TvV71nnMw8iTQAZXVTQtXvK+aJhzaPaHLRtZm0WrRblAW+?=
 =?us-ascii?Q?IfDSfgnbr/ydZ83ZarJJCstjKq4QXBQRsQGQvFTNp+gPziP3mCFRcwH2MZXx?=
 =?us-ascii?Q?RqI+RfWb54itLu2rc08G0Nl6EPKib9j6RTn6OhKyuMY407NSV0f3te2FFYpM?=
 =?us-ascii?Q?Oeugd3J9uSoRi+lZ5HpKGHz5BgQligOQ/pQwy0mI2+ORSkDS01a/6FmJtjJv?=
 =?us-ascii?Q?MnfE+ffy0BouDjIeW25RBk+8Ig6eDzKbLiJCpdzIJZDQJDAyir1HJeDORy+M?=
 =?us-ascii?Q?0vvlPKYFClOLxqhiO7+0mqbjEgueSoWbPyahZLS7BRLMp0OezBJhnRtZi9np?=
 =?us-ascii?Q?dnT2KoWb9X9/78PRJxQmvSjEX+A0XAYhSYfC5OHZccTid8OsKgP1Vw2E0S/7?=
 =?us-ascii?Q?pUvIxz9Qh6xXMDFHgxu/HpcJ2YAq3Q3KysxZ2bZ5G1MkqYd/BQXiEEw6a0V/?=
 =?us-ascii?Q?zmvu7ToZFbi5oOSwjXly9//wOxOW+z/bsLelx884Lo7u9Yi4PyjCrRWo0dvJ?=
 =?us-ascii?Q?weUdvb/Q+lKAp9vv7n8VvHPY4cJQmFJyDaZaEiBeFPuxhibFLu5Mn3pvRUam?=
 =?us-ascii?Q?kSNowbTWtFun4gucLrYP2E1lHPYaOD5U6XTj7kOmXaC5oj7TEwcgL4SwHJcz?=
 =?us-ascii?Q?L9PS94iWH23QGvFHQ0GQ5LXlWoobcHAii5KrjbRhgPjB4xu?=
X-Microsoft-Antispam-Message-Info: /1QDnT6Xa3mdO8G13oHJE+rUFyLEcJJBO+ANu2Mzwix8l/B+55SAwYGDo8vTKwGK5o8TMdi6q4sgmDojDLwLwpfdUK1EpYoiZPoKqA1Rj7m3MZJeGaVMPIN/HOVnZycEZJDoDf/S1aIvaPs/EB74omCqAbsWJ4TMupDEj1fTUfFAhvVTo2J2TMulomjQLaR7eTqu3Th8mXRKr8juXH+WbpDXqne/Kb6hIxqVmeCS9kNDznOfM3K0k9oNjQF9AiUS+QnYYCooFlL4R5lswcByThJ0L0OI+/tgSZNM+n97pQII40oXI8mkEmcSejFD/g56lsnjbbIcWEnLOeB8ltgN1PUxM0B73UTBVIXQfl4d1eQ=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;6:hXisyrEmXFCk3PqyMIPro2oqGhiAtveJ3ZKgVcfHTwTrqM3YluUAUDJKjplM2K+fplFdguu9JxIFOCruYGbfQZrCmJ13fsomRt3n5V31wNSgOyCC+XkMn0/K836qUyzkOmEi0FLOnpEYZfrgYMrv5q43Xbd1b+RmVP8zh1aS8aEWI+G2PXDqtDIPD5ARPQtVLORohS4F/qGolYB0HhOiVVKOQ5cxGLYLbfe2UjsJU5R6v5+jTuXScKF8gWBfNiFmZDC8IlFR7N3mwRQVkbIk2TKJUECDuRwC8PzeS9OgtX6Iv8D7xIcbCUzOzc75MqZHfceKurBZ75zWjRKsQDYW6QI2xf3Tv7cFsWwJVur0lRFhxxLQbCzmIwyi1gb270eL1y2lz82cUAlAhE3ZdY4z9qJheVePlHHIku0DU5BhXmGdmW2box+ka7M04bIKr4u4acUuGR4PNwH4l2pU/E/4bw==;5:1kaScK2HwoveL9qcQ0yQ3t9pdBJvnCX9Ml03CKdlW/QPKlE9NjchU7WBJ6JhDLWNSZ992rnDybdQAdcRulcQe/KXQ4SjjgUS0UYt9MNovg2QjxY0/h19rEFWEOCQuGna0+YbzF+RTdAUJtZ9TzGcjkQOJp30AenD6tO8ziL2cDY=;24:Iy/xcZz1UFqMBkvVLdZEy09a3hLBSV4oVrANhkh7CU8byQyMprtEx0Yz/S/TW9760V/O16TwSOjFDfeq+mB2j2tz+wvTcyYG/BYjDqjPutk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4460;7:eUC29bI6FsTAWqpZmtawsVDW0tkY2YHl+IdukkyiZFH5q+YpO9AR7vWJB6hGVwWH5j/MgAE7FhOaa4zH6GzC3LlvsOkCOeePPBl/F0oWakcKqlVVL4bbDm1gdpVrTBaOCAJAb4Z2x51ffuwjXDSWE1Yjqt97oLK4Ai33LJIOYzWbflRT4OFkk21GAo45k+TGDMMvW+fv67MjMZVoflekbfb7cdtMzxsPSyRBc3ixfQq+J+1vWFJdeJQj/CiPG3JP
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 19:33:31.4904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acf978b-0ff0-4e47-cf37-08d5db9bb340
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:05:40PM +0200, Miguel Ojeda wrote:
> Hi,
> 
> On Tue, Jun 26, 2018 at 12:44 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> > The true option causes this indenting for functions:
> >
> > static struct something_very_very_long *
> >     function(void *arg)
> > {
> >
> > While a quick survey suggests that the usual Linux fallback is the GNU
> > style:
> >
> > static struct something_very_very_long *
> > function(void *arg)
> > {
> >
> > Eg as seen in:
> >
> > kernel/cpu.c
> > kernel/fork.c
> > etc
> >
> > Acked-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  .clang-format | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Resending outside the merge window with no change..
> >
> > If there is no clear upstream path for this file (it has no
> > MAINTAINERS entry?) I could take it to Linus via the rdma.git tree, eg
> 
> We can add an specific entry, yeah. Is there any policy for "general
> files" (or some general/catch-all entry)?
> 
> > as a 'collectively maintained' file.
> 
> As you prefer -- I can also pick it up through auxdisplay; but I am
> not sure if we should put it in any "unrelated" tree, though. (Since
> the file will not probably receive many patches, I originally thought
> that it would be picked up by Andrew or some other "general" tree
> instead.)

Well, I'd rather you take it as the owner of the file, honestly :)
Along with a MAINTAINERS update...

I also don't know too well what the policy is for these sorts of files
- other catch all files like kernel.h I run through rdma.git from time
to time, but that is in relation to patches that depend on them..

> > Would prefer Miguel's Ack to do that though. Looks like Andrew Morton
> > took the original patch introducing the file?
> 
> Yep, I sent it to Andrew and he kindly picked it up. Probably he
> didn't notice this one.
> 
> As for the patch:
> 
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Lets give Andrew some time, he is probably very busy. If it gets to
rc5 without it getting picked up one of us can grab it instead to help
out..

Thanks,
Jason
