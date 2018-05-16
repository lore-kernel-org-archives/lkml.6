Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeEPHr7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:47:59 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:32704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752489AbeEPHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:47:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-10-git-send-email-vladbu@mellanox.com> <20180516074332.GB1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 09/14] net: sched: don't release reference on action overwrite
In-reply-to: <20180516074332.GB1972@nanopsycho>
Date: Wed, 16 May 2018 10:47:32 +0300
Message-ID: <vbfd0xw11pn.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:802:29::27) To VI1PR05MB4702.eurprd05.prod.outlook.com
 (2603:10a6:802:60::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4702;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;3:JKjFIvrR+tigmxnXYexopE9q4tT6KCmnDS/VuvJ/b2aJtpV0fx9y9UaY3UiA3pnVrdgoO0GLJepn6ECay1O+ADc4KsKGZWiqEJnRYCpnnn3pSpN5wyFyWqV66bQx7SRvKfF396ub7xpKI698OyABZp+5MLUhGvbi4OdQ3OsK9QiFF0EEwA/fr8aBsN3UrBLW+YTbxAUPHO+xN7BKK7o5FOHFlaAE+160QQYjNR+GK3Nh5xnj591kGfS5RBMSyo7x;25:Z28JUEIk0pb1llItFixp4wGFa7RVL8KA4ICXeL+/fVt2EK8wJfSed5d/xFCaiUkc9ZBAOvEmsPadZeQiJqRom17kTNpBl9xfdQzDZDQJLC9sRexEWek04UX9uIszGVVbd1YXt/RG9rxxEXxQJ+ECs/58SwaIpU/f1GI3l96t+DUNV1fJ7r9gZwHVa3RJBk9OGfOrFAa92OuD9XgH3DT0UeBLEF8K587IAr6+fJbMdmxViIuV7qfE4pEsw/lVuO/nnSsUm3tp6szAGPn9gA3xLg3NinAFxD9veHJ4ZyqDTNNg52TfYHMMhyPWQn3k2Jw4uOXhmbeJVAYnhNW7py+nlg==;31:aUXkjE+AcWRO2Kp0k2y45bKFlqO9n4znug7EHZoSHuZeKLzt5z2/Bn+t17hqepKOLFNQNAQ7+6w2JE1CmgCUgigobybNMpg8+yHMVlxEhEbrzUMU9LVU52q3nR9j/M2r3P5SkzGHnLuDoVFxiwYm1Q17TWmA2pUpbuqOO1Is6toZTYE5BsJ+qMU1HLB29wl4ZW9JNMPJ6Lj9auScC5jDdtJn7FMaNxvKh5OvDSyMjWs=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4702:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;20:g2SpgkD4Z0KI6Auyw3g1TzzMGr1C+ZVZ+Cl8pE+ffFkU2LA56fJwOYnMRp8RVFmU+/aW1BD5uOU+P4jA3hpc+RkcGptYKZpc/7BqtFjeW8FrrY9v9qTg8gPyH73s26ZYOiflQf4vORBg2ock1tRfiSbTJrcyFaCmaSrncmi/xbd0uUXcWdZB9kfSPsCR2mAlYDZ492O5l8Dy2vnmNrEJDcAgRLZfYXxSYO+sbqSerLKdXxXUGLGliWO+uV40u4huP7jgv9T5tBuqL8iuKQHEN/WdvZxBDRQGUpLeyD/sYN+jAwVbJzelATYEt2J+QilrOyhfnP6gusKYk9IgR23TGuEROBD/jUA4avYBS0q6fwzgh2J7Noac7sLxdB0oiHvFdYaBG23BWWWQD+MyTCQzWzU/sBP3Vhn4h29buFH5eNDWzd0cjx8u/vCMKTnURWGCGlS2rnfqLi9LpHoaN5l+JhfmegALDbM3SPwRckitsBjN3K4KA4nv6GQrXUqouUJE;4:P/JAmj5/c9vqqJ7cOhDem/1BWlSFkjr/XYdqID43EGws0en0eW61+fCLyB+keYUJcqkpnPxTx4eVxpkwq3ls0+BJcML/cZ0eby0FeLIDeAKEnZeTCx3DdHcxAIcblm8ipNGXGqPB4JVb8THhLsh/sSbaMO9SqgPAzrHb+KvXZjTPobhqzCIayV24mw8Lw3UQAwbHFxnlWCUVxx+NCu2TjuA2lHNFlIPoRi2b/bjsBqPa0wov3R64mnujcYL/LlV9ny4zNxIqcPye8tyl2vgJYA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB47020BC4B6F60BBF32917EC4AD920@VI1PR05MB4702.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR05MB4702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4702;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(39380400002)(346002)(189003)(199004)(26005)(76176011)(6116002)(446003)(386003)(107886003)(81156014)(7416002)(11346002)(81166006)(39060400002)(956004)(316002)(50466002)(16586007)(48376002)(58126008)(486006)(8676002)(478600001)(105586002)(25786009)(97736004)(476003)(106356001)(6512007)(9686003)(53936002)(6246003)(5660300001)(16526019)(6916009)(6666003)(8936002)(66066001)(2906002)(229853002)(4326008)(47776003)(68736007)(52116002)(7696005)(3846002)(7736002)(305945005)(51416003)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4702;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4702;23:upi8rpVtQAUGtyfSWMuDkPwdtQUlhVRiETKmk1iNL?=
 =?us-ascii?Q?q8707qelLd4A5OLX+BOmEVRZjl2slrFTjh61PLBcKRc+TvINtsUA/AZpChEZ?=
 =?us-ascii?Q?K5Ngh7AGZ6AxvfMm0No/zelimYWHoMeouM6Y1LWqzsWgu6q/x1TEv8eNUhcn?=
 =?us-ascii?Q?V2hcy/eHmwvwrUQuPMA66CvE3Oha1A29z+etux5mtvgiPza28J83mH/YS7vN?=
 =?us-ascii?Q?aCbSPmC9Jl169FJAYBHej7+8Oi44sa7z2qacnwQGHUtSpOpXhlzyXqCD3lNA?=
 =?us-ascii?Q?UaIES5ydGMmRgtC/dkZmOO7Rt6/qjPUtOAZsJPGEckAu+2jnQjhEiu1f/k1G?=
 =?us-ascii?Q?PqcusXribqx/lzlUYAnk5KTK2IQWGuLIlVrT9b28iYNERz34iAAqtPRyMDbd?=
 =?us-ascii?Q?izx66jqUPegPxAyvmFsm3ASklJ5JrWJLVeJj8cxUJI584/48SVXxIuTaQ8J7?=
 =?us-ascii?Q?RACWpWoXN/Co6lJg5p4Uu+vT93xtWtD6nm5rYkTsf9oZf4IsjZ0W9d18y2mZ?=
 =?us-ascii?Q?g3dosfrV62OGa+S/ad9gc9Xgvjuoyj59PljeyTzhikFhAQ+3+LtgBmb6Z5vA?=
 =?us-ascii?Q?4LFsLuA+SlOpEjywhu95lx+VYYxm0p9IFRXJyPLY+fir+plAp5RZJ5VTJMrs?=
 =?us-ascii?Q?sbUxj8X11XzKtXy86rvc/P38FRc983bQ07FqOaeGY8Jfz8ZJh1DUZhP8nzqZ?=
 =?us-ascii?Q?5qiaXJ6ulozvpMmf/slfkx3yD689KPhXD7j2IUmSOpK3T/NDqBhc+IAGFVYX?=
 =?us-ascii?Q?4MKr6olz8ZP8cKK5Q10Qe0JHXA54EvEF5KTVPYS0FweOGmBy/Qeh1ALhhbq1?=
 =?us-ascii?Q?jejGBwY16m9r16XGKo4pXKXZj6hiv0RnkkA5I6J9CT2xKWIDJj8wQx7cRq0y?=
 =?us-ascii?Q?bYbFX8Lngat27TpXRb17fEWMuPeHHZBaPR3F05n1XS6rNsKMjQkmABFN0w5+?=
 =?us-ascii?Q?FAJ/r0JT0u24MyMckA5pRojcnDn6c4DuDk3aLWhFu2IV9S5gprKXSFPNBhDX?=
 =?us-ascii?Q?t1J3Bs+PqvnEJPklHDbVypj1JEZiVqhvsbAJdND4BbIgc1uD+QSx+rN6UhSI?=
 =?us-ascii?Q?ujbZKYLlX/Sf5EI9nQq9EMVd79QyGFNmKGVTcuxkqY67XdUynySCnyPPLgBj?=
 =?us-ascii?Q?HbKr5DnbLKQBHZvcy5DAHVR+IiJct2SCVi3wk4Q2hKhU20G6x/cSE6IW7MPE?=
 =?us-ascii?Q?phrDtuQ2A8r1ORQ24B8htUezgoN0Jv+rkASEvI7UMezKvc/pwR3ZzbUMpE6C?=
 =?us-ascii?Q?Dz0W6fkB+PcoLY9/Bg=3D?=
X-Microsoft-Antispam-Message-Info: 4P+i2xH75ly6vF/u/ETjuFRwMMnXrx+/zpwtgnvwYGAc4x2pGHYFQjZLfmD3YKGL9+OUK+dfCrIoyd7mXjCIf823KiySK107MeM9jGMyYKokreWrWB/Xt3llkQ+kOcuNm+vOXRd3UR/BxTt8EaUDsRiQq06vP2KsDHf7r3PX/2oqadYTGzSiWWYPLx9y+O7u
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;6:+hGz+i5Z6HIBdDMuJejJ0O4U6uwe3qw4kHvX93hkMansZoRjZIa2A2Hluez12eIyAPr2qbDMONyjqnAucK81jVGGLmcfPzLZ1kMHknyShvXUf8AncAM8F3lYM2tQQSUxDK9YOW5X0JMwX0C/lxf2FCKI6tDh1bpjadnbL2YW2DBRGzg0LLt/owK2Vl/sd1X3ZaCLf2gt/MNaBOg0vFJiXj0s/4IVmpsrAQFv3nIoo7dbMSC0iLUH+ivK6mrpxdqo3K5/aLrWVGJXg0jYV0C9kZ5BfP+hP/Y0WFQmGZf/tl0W5LulAyBPDWht0VrB4kxAR6xvmkAe1sHwEIpb9TkLk0Xe4eGQnTOR25n6P/cVv+QPkfBvLf/l/6hnczq7TjJGfMTQx1056FhhyGyiqq9Nd03UeQ5XIdub1l0t1ybo020FXJscQy20c+g/uOgZHJqWywjS/WnhKrO9q8Ta4d8Kwg==;5:YhbjmIaY+C7UPVtue2M5LAFkkcMtYfUE12lBS71oSO8aJXkhggCSZl7QZ3sCK3O7A0Cpxl7hwZCJJbO9Sv+gSsCgs0lAdLRWfwSRn6TEROmwr3R6FjiMtQ4+jNrBlJlD1iHhhKoYvc3cKSgLDbXUzUN7DbELJnUlWLDcap52sj8=;24:lnkPGF/oMHChycYrWaCK0JFkqX6xbM2H7TsjMNkv/hlh2ABqB440e8umd1ZbXZ4f9JnpEs5kEGRYe9EJM8HH4ldNz12X7q9hM7PR5eAT6ik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;7:/GzIJWpTNg3CUK7Tgb1dWNz4rpaKG8SbrxPRjeVKwipaf3nZdVVs21zKk4PxS1aCpD+RtzjjsRCl3qrh8q1T7ZRX9TGdGoyH0RPU0JIuy/gFzDTaCZwo0DRLCbMLE45lP/60+gF/arNSmS4yvc6gOxPZQ4c6PLNtQG5ZI5ePg8hd8XwgMgC8GHKVK2OZDH1ZPSkwwmYVLhmfdBUaHldIpCA52gnSERdU7n9nLEb2gwBLa5ZIxgQ3TRc2C2XMrIHY
X-MS-Office365-Filtering-Correlation-Id: dad6b78f-ebec-4547-c124-08d5bb014d2a
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:47:38.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad6b78f-ebec-4547-c124-08d5bb014d2a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 07:43, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:10PM CEST, vladbu@mellanox.com wrote:
>>Return from action init function with reference to action taken,
>>even when overwriting existing action.
>>
>>Action init API initializes its fourth argument (pointer to pointer to
>>tc action) to either existing action with same index or newly created
>>action. In case of existing index(and bind argument is zero), init
>>function returns without incrementing action reference counter. Caller
>>of action init then proceeds working with action without actually
>>holding reference to it. This means that action could be deleted
>>concurrently. To prevent such scenario this patch changes action init
>
> Be imperative to the codebase in the patch description.
>
>
>>behavior to always take reference to action before returning
>>successfully.
>
> Where's the balance? Who does the release instead? I'm probably missing
> something.

I've resplit these patches for V2 to always do take/release in same
patch.

>
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_bpf.c        |  8 ++++----
>> net/sched/act_connmark.c   |  5 +++--
>> net/sched/act_csum.c       |  8 ++++----
>> net/sched/act_gact.c       |  5 +++--
>> net/sched/act_ife.c        | 12 +++++-------
>> net/sched/act_ipt.c        |  5 +++--
>> net/sched/act_mirred.c     |  5 ++---
>> net/sched/act_nat.c        |  5 +++--
>> net/sched/act_pedit.c      |  5 +++--
>> net/sched/act_police.c     |  8 +++-----
>> net/sched/act_sample.c     |  8 +++-----
>> net/sched/act_simple.c     |  5 +++--
>> net/sched/act_skbedit.c    |  5 +++--
>> net/sched/act_skbmod.c     |  8 +++-----
>> net/sched/act_tunnel_key.c |  8 +++-----
>> net/sched/act_vlan.c       |  8 +++-----
>> 16 files changed, 51 insertions(+), 57 deletions(-)
>>
>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>index 5d95c43..5554bf7 100644
>>--- a/net/sched/act_bpf.c
>>+++ b/net/sched/act_bpf.c
>>@@ -311,9 +311,10 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>> 		if (bind)
>> 			return 0;
>> 
>>-		tcf_idr_release(*act, bind);
>>-		if (!replace)
>>+		if (!replace) {
>>+			tcf_idr_release(*act, bind);
>> 			return -EEXIST;
>>+		}
>> 	}
>> 
>> 	is_bpf = tb[TCA_ACT_BPF_OPS_LEN] && tb[TCA_ACT_BPF_OPS];
>
> [...]
