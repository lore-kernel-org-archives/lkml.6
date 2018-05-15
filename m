Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeEOLwi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:52:38 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:28715
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752671AbeEOLwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:52:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-6-git-send-email-vladbu@mellanox.com> <20180514162301.GC2134@nanopsycho.orion> <vbftvradqe4.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180515085827.GJ2134@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 05/14] net: sched: always take reference to action
In-reply-to: <20180515085827.GJ2134@nanopsycho.orion>
Date: Tue, 15 May 2018 14:52:23 +0300
Message-ID: <vbfin7pm8zs.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0701CA0032.eurprd07.prod.outlook.com
 (2603:10a6:800:90::18) To DB6PR05MB4695.eurprd05.prod.outlook.com
 (2603:10a6:6:4c::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4695;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;3:tuMboPOBl+Q/Ce419lkRPn1z41bnJqWvcj4Rh4ekrriRzwmzLuoWSOAuqaVcd+YRk3Om6Kj3P9qYbkjoXVzL7YWQQIMjgGzTx4VfrW5wXBw4AJDPxrDIYSV7BZ9guj+hpr+T1oE7Qk2L/85AG7iQGKhiiP8JKmNcfTkLxpQ7GqFUjb+7fnUWZpExH2TieL4Glhy3GIg9kXFiFDxrGDX90wD+x1Lak1265nWQcmOhEBsuP6JfoLCA91iR6gOTq2vk;25:ScP3kWMu/Tpdqx5tF8i8i5Pv/6iq/wuCAt5PqOJ2PNrxgml2qXHKqXuY9uWXzRT26TEFYV7HYtL9IrKqSkiUyh6ZaStLVokycJBGk0lCEbwBE0ody9Yv/aeLJQ+gnIZVQOQTgkda8VoAj3OmLKqVrYFPwX3XlVNRTJgQdKwg3oXk9nkNQDwPdDV1ztEy775yJVr9LtufZWg41EOiV7R/7Gptv/gxxJBFOWpqdJPXV6NRRN6PxaMRhs6dqEx/+3YFFUrK1aPDMwwNTQPz2ylClBu7nHfdKQfYgVQdEvjvdARt+7jYi/zGhJ3uK7D06WHB2YHjs2Vsr3OlfUmGcyqwWA==;31:e0vxaqsopThLxHGxd4FtfVAiNpgIxno1FtaOJrcnaHm2ejM/NwkiVN/HpXSa7ClQkc08e4Ll6xT2szSIYIhBxBwz5F+c7wXvRsMkALCXpJo9VbC3H10oMdxbYB02YY8U1eSZJlJs14mMpAUc5VbyU9GRMDhLcXf3iWhUlME6W0hJfe1hZB2TdEbhcFKPyGcl3CJzRQAzJFq5qqYyjuAMoJOCQVKVH3qwO97fn4dWBbE=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4695:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;20:pNFStqlVj6vxcdv1Pl26nmQdD62coeq5TmV6w4NAU/8H/XfELiI5UrjTZgQBFFxz5Zwna+f+uz7E/yvjnWYAIc87T+AMq/ToQnXKRXsmNpgvr97YMmARH8VjTGn3uCwKPFmDRJ7jswaa95owfXrCZpACfFUOx9+gcpZEous7tYkpjJKuS6fpPwc39UYX6v50UUT/wDgoNIUo12lLG45KLWlwcXfI0xUllafo34w/IAqwHLbEif7CqETm0kRAq0nYsb5pCATtGgVM47KF0NdYQr7xQJpRoiB6cnEumtmy9ZTa6zKF8xq6UXyAH7MFtwFUS0+dEWkgL0eyknZvA8Yt0j/DP7oHzjh1KJWAhyEPHiPrA78j/UQSoGRQYjgcOpV93DjbTRFgu1KwrlxCVIrd/pIyS3mdOwKL9yd9mjB4eWz5kKG5J7P2tnhSAbXToMICQ1Wil4UXkbwUoM+fo4t4vtQcMdCl8mFXFBhPA/cZnnw3Fpl0s6LMzEYKCtVeTmyJ;4:0te7+j7oQ44dhMYs98pAArHJ4K8EfyX0sGZc0kg26ZVAmjXZISzqTKSvb+EATf1O3dpyWbe038UViCGC0yxyQFFtRxMsvFs+pttbWtMqPWWdYKyF7xKlt/kGMhnbmA8o2hWCbZYu2kSlL9gv2DWkNFJGkG5P+zmd9tCXA7Y/oTgZZ1//UxEjXTYr2H+Yb7iMbNtuWal+a5Xxuc6dGg4Hqfsb/V7XH3qcJjr3sTG/plnPGS2VZROYOLH9xHBfogZlYxrkgzmHug3U5cJqkil4Yg==
X-Microsoft-Antispam-PRVS: <DB6PR05MB469553742E69FFB3CAE71C7BAD930@DB6PR05MB4695.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR05MB4695;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4695;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(316002)(7416002)(305945005)(97736004)(7736002)(16586007)(81166006)(58126008)(106356001)(105586002)(81156014)(6116002)(8936002)(3846002)(2906002)(93886005)(8676002)(25786009)(478600001)(5660300001)(48376002)(50466002)(446003)(11346002)(486006)(476003)(956004)(51416003)(52116002)(7696005)(86362001)(68736007)(4326008)(76176011)(47776003)(66066001)(53936002)(59450400001)(6512007)(9686003)(107886003)(6246003)(229853002)(6916009)(26005)(6486002)(39060400002)(386003)(6666003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4695;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR05MB4695;23:HtixFnQpcaUETxziqkKQXCK29V5Ske4yeYV2889cK?=
 =?us-ascii?Q?AxDW2a+ofDvzIEfy4PMzlWdVimpFYtoVzzhO73kv0ezZkPeE6MfXLXbaRDMk?=
 =?us-ascii?Q?nSWLKwXcGjGkl4t9RWb1wpcqNY/ou2m+Pijo/EnVUCIx7NXlsMFYEjFacC6H?=
 =?us-ascii?Q?Hv9he6kGEEFDpw+L1HGLB0QVUQHMhu+wSi10OsjkcXJpO3cAb9W2BfwaXy64?=
 =?us-ascii?Q?hVGC5sym04a4rWRQG9/lYxGl1edkqXprr7EoGR+CE+YZ7rhjnh00EwfKl4bo?=
 =?us-ascii?Q?TvH75T5RrD2cDAa2CS/dfZG278QmmJMjBhsgVNFjNFiiOes0Zu0oNQb3N2QN?=
 =?us-ascii?Q?fWV2fXWz024OK0ar8cWnh+WasPceh1uWBrxX2qLdNkuVW3IQe6YMNkQwC/ZZ?=
 =?us-ascii?Q?fjM49X8EKkzW+bmItBj8Y0UWN+gBvjSGPZMjwg8ZP5gO/gQ5sAJuol3veA1G?=
 =?us-ascii?Q?L2I+WX6lu2fjX6DI66rtMfi0zPHiPZJFPmkXQJYG8CYE4RGUGb2E+p0ysMIR?=
 =?us-ascii?Q?dGPT3myFaYLXpT3aNyDKJJ79xJWeB6dcp2GThKY1D9aTqFD07QhJDplPqCWU?=
 =?us-ascii?Q?ghLVNhIwbAyIfjqT5k4hX8ACvGnfRX+BFaBVhxumWEujQ5dsheYtB3DIoVHP?=
 =?us-ascii?Q?iin/VX24EophrplU/b8Q/8k1cUB/VKe9xI4Iab0ZXyEpEJFiMyzT9+2ClGrF?=
 =?us-ascii?Q?hmVN/6wyF959uPfn4f9t4tbI1tOVbeOb4ES8E59D7gF6D5+H4rsPQXTSqQtQ?=
 =?us-ascii?Q?SdjAqOnvGSyGtdYRhWy/c3s29F5o8hLLAa1evzQhC1qvUFwqm0h4JlZrVZiq?=
 =?us-ascii?Q?t8ZlMaqIrpotGy1bYr0LKXW+4RsttMG3x5sn8ONciCNHgQS2Cl1OXY+mOnKd?=
 =?us-ascii?Q?Lb4aGQnNn0gbX4jrOMHLXQ32xHUU3p208F/S3372H1oWgD4juhSFME8wRYnk?=
 =?us-ascii?Q?NCJdCmyMkfWRJqjzY/cv06+BnoeVSM8wfWi5x/Ipj4ZiwxXLRh7QEQXtssKX?=
 =?us-ascii?Q?IuEQ8m8a5pjRZ+AnU786N2K9/Fh3aywUPQMrIFV+iPKthXZWktWndcx6GveF?=
 =?us-ascii?Q?DD3oIBzGGm9+LIytN0dhvK+KA08zKU82xNwPy4DVzzuY19PMujt7flbU5Kcp?=
 =?us-ascii?Q?SgAW00yEycv4Z3x25TQGpePpUX4aU104XbtEu5JSJZjrxJMOTXCa3uxA0JEA?=
 =?us-ascii?Q?H4mjnS2rHlZVzZOY4xjZf6Z4LodW+kG7zcex381uAHtYajmrkfGf71eX6ahZ?=
 =?us-ascii?Q?Qss0QNiJ1uXHmlMNQrNpY3EeSRCeaffXX6kM99ebMdWabCN+HbQ+d/vgChi9?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: OJsy1vTqVDYijiioPzF29nwb8yuIgxXcW0kbKg38NcoT48VE62Bs40TmqJGem7VJEJk6KBVy9lOdi+5aZJFKmKMj6uPXI0oOKOiL6DTg4T7YaW5E6YoCXo0oGEpCEVNLolbKACIP1A5rZ4U8Na1z5qlWv/lj4xVQgg76UqBX6aNvmm9VBOxHZD86brd4I9/0
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;6:/yc8etkkPYfMJeozvOYFVnwo47zzwMBRdrDUIi5UqAn3/d9tdFXD7U7AEGUR+O3X72nxh6fSMWjC3Y8oPS9dlDtEOwkJ4zWa7yVE/gj9ufsebhjF+7urmRtTOeCcjNN+biHBHfRpBAF+0b6T0udOEX9yp0B0s65aBvSkEiEe6Em/Rx0Z1Ta7vL66FpBMPIlWChBZYnSxUlifCXe+lVUcyYnPIcaD+dQ+CEigZDHIPhfAdSn0Ialctmv5B5dcAp9oow/jxeIZMijqBK7XL9sQt7nU3R8uCXbl7ubv5zMDy197ysxlBgWruUokME9OqNvvTXFQekyw6WHpJqZVEmKbqDjLQIwjBAxE39u97m8Qae/Oxf9pRYCS1CBRFqdxBW+RER5VzjSBxCspA7mH1X7rS3MZSlXnbtAVsklYk9XY4MsWYHTg72E6B4y66KYbhmyaDJjyskJARittm4FAgB3d+g==;5:j8XREMvo5u0TBZIb3PUVyXqgvk8IeO3p7r2Xuq91T8LbBnysXq7zzSczPRSBX4+0zL6DFnxuqYYG5mAgM2gjqIqV7UbTTOwSymoEdiMmAP5JdwE1Kd2Gt8zV52Vf4NJVjamlH/XK93KbfeLKi66mGVug9OT3QZhoANKYhSbB8lg=;24:AQe46F0ILQtVHi+p/abpBJTskhdlTZC6+mavBvYiurDodl1eJu5s+X3dTr63loG/x4QunB9UN2q9PZbFQJuUWsjP3z1InN08G+RpDDzLKJI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;7:0Ez5lP+Gjo1Z9us9ydRRhWp1VHlB4aaqBVdaSYlxPE8/fpCZRvDOlC8Si3ZSKOydch+tERzk6aXFIOXBlPTzcMIccxPnqPt18yX63+5qPUCjTs0ql+vMm5h0EmhbPMjbuoJvQqO4PlvafbZzligwbMAn8hRGV8zu/w1e+gIjq1EtlB+6MvbuDiTNWYHCKxKeS1HPS3XMbF+Ei5lUtDtLDGBLwI0Pt8Ri0kZAMPPdPB+B8RELiArsw2jeg+JRXxtW
X-MS-Office365-Filtering-Correlation-Id: d61e57b8-b31b-4af9-a683-08d5ba5a574e
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:52:28.8169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e57b8-b31b-4af9-a683-08d5ba5a574e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4695
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 08:58, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 08:49:07PM CEST, vladbu@mellanox.com wrote:
>>
>>On Mon 14 May 2018 at 16:23, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Mon, May 14, 2018 at 04:27:06PM CEST, vladbu@mellanox.com wrote:
>>>>Without rtnl lock protection it is no longer safe to use pointer to tc
>>>>action without holding reference to it. (it can be destroyed concurrently)
>>>>
>>>>Remove unsafe action idr lookup function. Instead of it, implement safe tcf
>>>>idr check function that atomically looks up action in idr and increments
>>>>its reference and bind counters.
>>>>
>>>>Implement both action search and check using new safe function.
>>>>
>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>---
>>>> net/sched/act_api.c | 38 ++++++++++++++++----------------------
>>>> 1 file changed, 16 insertions(+), 22 deletions(-)
>>>>
>>>>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>>>index 1331beb..9459cce 100644
>>>>--- a/net/sched/act_api.c
>>>>+++ b/net/sched/act_api.c
>>>>@@ -284,44 +284,38 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
>>>> }
>>>> EXPORT_SYMBOL(tcf_generic_walker);
>>>> 
>>>>-static struct tc_action *tcf_idr_lookup(u32 index, struct tcf_idrinfo *idrinfo)
>>>>+bool __tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
>>>>+		     int bind)
>>>> {
>>>>-	struct tc_action *p = NULL;
>>>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>>+	struct tc_action *p;
>>>> 
>>>> 	spin_lock_bh(&idrinfo->lock);
>>>
>>> Why "_bh" variant is necessary here?
>>
>>It is not my code.
>
> Yeah, yet still I wonder :)

I've been looking into it and I don't understand why it is used either.
Looking at the commit history I see that long time ago rw_lock was used
instead of spinlock, and some actions implemented they own lookup
methods. So it seems that it might have been used to protect lookups
running in bh context. However, in current architecture classifiers hold
direct reference to action so action lookup is not used when processing
packets.
