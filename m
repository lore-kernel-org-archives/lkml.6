Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeEOLdX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:33:23 -0400
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:55552
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752671AbeEOLdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:33:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-8-git-send-email-vladbu@mellanox.com> <20180515112404.GL2134@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 07/14] net: sched: use reference counting action init
In-reply-to: <20180515112404.GL2134@nanopsycho.orion>
Date: Tue, 15 May 2018 14:32:51 +0300
Message-ID: <vbflgclm9wc.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To DB6PR05MB4695.eurprd05.prod.outlook.com
 (2603:10a6:6:4c::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4695;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;3:o6Rir7jNWQkItqyo+6TJvSXhJm1NMEvY5R/CmJrS9THoWD+tLu3rsh0L06JHYRrzBiGG+wPO5/Yk6ZNCqguUdbglmIAm0UWIyKkcAq1srThGq+gFhxnG/RxCUJ8abHXsewxYoh3ox5k/j8qo0z1KkTG8RlQ9bx+hqJHzBBYFDzfZiOBJhyi8OlZNvFZHwVn5Z6RpO30iyzDdAyFB6IP33RK6w3tf52KumDnzgFXZf92EvWdCCJxdRPX9x6wJoTVa;25:N8ypQLZGG+1zsLVtM5oV2ufhDbJNulhiw425REuWx8LvbT/1DURTTYOn2vyvIyhgjax9BGAMnkUmqp7SRfqStRigrfLS2HJm0K2axNXhfkVFf2Y70mCcJ1XdwzId2qAGDT9lfGmozPFjqJI2sRImTzzNy0OwRgEOz+FMYb/323m8VdcHmi/gZtJgqOrdp5np/wyyT7Lr05IzBeja3ngJjmDHJG7UetcnoNdWGJB6YFSNvvPTbhNcq1LmMq3US1RaPjZa1McthLbZXBpNZRkpRld30U6reKk4s56VQVwoiR7PUT1HSkZCbmX502Niv9hVjeh8pNOBCqXq4TqdQ1UZ9w==;31:ivHiG4ntzvhVfPbOJBuT7VKED9gd3HnsnUyBEeW03+2IVME1KDiiFXaVhMwL0jsTE0wdM+NWYPH+NttI9O3tu7ErMzcRCDW2gdbv5ytD1DEYQhOT1xlfdaQVrXWE7f8aC5GQNnjl8m+UJPv41WlyWTuRwzaO1UO86kKU+TWl2cw8udB//P8LbNR/0Hwj07Vm3p41TP4yce/patW/B25l2I0+8lhj8/wukd37V/LL6iE=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4695:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;20:1cSIKrOiacnPsLuauTcb36oge/WUiUZ+aIDwlWTNTHjw/Q23C+C1iwNY1eTd1nx+0K8GSfNNXPdcR4LP5yBDbL3cVwk3rBIDYDQbvFGWvTfayVi3I4IjGsXCSXz1wgRh4ap1Hn8UUXIoobK8boi7F6GELb4sPWK44S7Zlkxd0EryOXhUq5hw2HIf8Dwqr0MkYKYSZNEnlk2w31Bid2n20ObuoL5o8nBlyMtR0LunnM3XwoZzshfTkJxVuNv4sn/n9CPh3uFSSMbVc5nQ12CRK+W0ga472ERD0lDJbA+hJcUXA4JaH/evzuqxqXnuUERN6qyfqTDQMUvfxx2CJPOeITBQs6LQhKz1GC7dOJ/ATY//VOC83C/31o/nOuXoqg2dZD7eK3e03i4hshHO8XfSFKUVPAL1j8PXRwMMcKZrTPvaJkvjx7/WmZqqo+NnCC0Y+txPK3xfn2839m/GVridMrRwNP/0vehT2VHaR0xCAdlzhkP8RI/jahcn54XzuVL2;4:a0jTdAX50DFYV9yEi9aLlW7ahgl5waBT1/KArWZU+vXFx7mJfxI56ErzfFpR9XvZjdoeA3K0ZrOTxViRUYtDxNlc4ssRGGtkYoBgj7qCsiU6e6gqGWWC1jfwhZDQ7Ee9e2Czr71HF+2kM2yKS2KgjfZVH0q1EB+/rHJpfZ0E3b/37gPBLILZTcAB+zbeZtSbiE2VkU/SkiX7BvoEdhhHm81vgWXlxwzB8QerZmhkKnfu3QLuJwSJ9hF/s5A9S2Nlk2ZeW0FTs55TW+Ms1nIyLQ==
X-Microsoft-Antispam-PRVS: <DB6PR05MB46955A9F623BFDF00D7E69ABAD930@DB6PR05MB4695.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR05MB4695;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4695;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(11346002)(446003)(476003)(956004)(486006)(4326008)(68736007)(52116002)(7696005)(86362001)(51416003)(5660300001)(48376002)(50466002)(229853002)(6246003)(107886003)(39060400002)(6486002)(386003)(16526019)(6666003)(26005)(6916009)(47776003)(59450400001)(66066001)(53936002)(76176011)(9686003)(6512007)(105586002)(106356001)(81166006)(58126008)(3846002)(81156014)(8936002)(6116002)(316002)(7416002)(7736002)(16586007)(305945005)(97736004)(25786009)(478600001)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4695;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR05MB4695;23:EB1ch88DlIY+D9iKuqxluk5eZgnZd16YViFJKby90?=
 =?us-ascii?Q?qpE4+fOkU3RscGWfrNLO8cvtZWtUyl3vnZvR9wD4TjHnxaqohbtPEtTBcYmU?=
 =?us-ascii?Q?7gOg+1kxWYMoJF6ujrRfwc7J4wdju2ynOV3nwqlKVL3ljNMIZzUqyYDniJgn?=
 =?us-ascii?Q?KjtZ6Dop1ASRYDVxWEXOPScVuYEbyppOu3kbyUGVHMkhNu48Cz4W3aGIV2xY?=
 =?us-ascii?Q?BdyFVkHW7YUzsH340hYF4KkG8sSdJxghecCXn8Ae5w1PpwjmgeBEK54mmsmA?=
 =?us-ascii?Q?xD3wE4DIkUmqzsWXqItyGu6610C4DvO9MsLhI9QGCIHclvYObhd5nxSSyqYh?=
 =?us-ascii?Q?dYupW8Bvb975HTN+BBoDEoiPw44idQFMFF80xxsJqeS5+eXgULq5GUTjUOfH?=
 =?us-ascii?Q?CpoM3ommc4vXazmMY4KPRVfFrDUssJdpol+OLUScFJo7OYenbTdpevH6DcUK?=
 =?us-ascii?Q?4jnIPID1dW6x6M992W8FLqb+Mu343nbcYum6cx7cnbR/et2vxzbW0Md2uRdk?=
 =?us-ascii?Q?gs5U/3Mh3rTHkssARq5ym5vmS3zM1mQs9y6cNVyBfGP7vghy9VF0kYvwyHuD?=
 =?us-ascii?Q?Nv2OMbgkyxstubY3bPnrvdmCYux+ZOyCD0uyOxuPPs/WRtEy3upvf5fX+9JE?=
 =?us-ascii?Q?L76evpBGS05MI7xvkUGQJMyXLn+K+qyfnPPWV1uIV7/JodftB9LgSSFteEzU?=
 =?us-ascii?Q?uL+iV0r6G91v7QTRLY0i5dIZuq/LyPP87rw/uuAFrQ+Jwv4DMAzVc9v+w+Pl?=
 =?us-ascii?Q?0rPsf2Tdc3pUOZ1pAtI/gUyNQD0Q42ZYWInWFmpcL/Rp2X2N/EogomKWWg1v?=
 =?us-ascii?Q?+Z+oYSwGof3VF7V5r5XWBJ/HwCuyS3IR0YdmMPXYgZz7o83mgscsEBQKbHYP?=
 =?us-ascii?Q?V5KaetvrVHNvxfkicbOQPidS8ZKUO1oyjVtJX3NOddKPfqzpRuP2iZ603lqk?=
 =?us-ascii?Q?3KayAxlD9RzUeQerYJm4UeynxFbcgEeuK+Pq+SvWYQn1gDa1S07boT6B+/Fb?=
 =?us-ascii?Q?oYNMMi/I7Z7Bz+bAGUaneILLipFSUXt0brOKbIJROaJVCMP6ILDZX/ladXS6?=
 =?us-ascii?Q?LlTOb8IA8SZKEC8k8BqKi4uof3+txQ5NUnb757/FgE1jDetKe+cV615bhNlg?=
 =?us-ascii?Q?uFZ8n3cBSOl1xUfeCS3uH/tBAY1C4H4RdG58GH6bS26GqY6ajQb+TwaH6SIn?=
 =?us-ascii?Q?H5NyLdO75Chqqlumyfo9sXXPGf6eIF81gYxc4UHJRB8+4EYwSF7CWU4N70DX?=
 =?us-ascii?Q?vWv0RsXYA9O8ClJ86+I22Mdx2AsWnDCF0DCw7ar?=
X-Microsoft-Antispam-Message-Info: bNkAK3NXayhJyYIW9T1SIeq6S+9Z8UCyVLSdK5ch9+x9l+OONkpM6pELb68/j83yDLbMPHTyw4wJhXwxTPzSjz82G8XPqh4MiieaIVVj2YhTm5cmxjCQgCD23gQtYRlsl8NqodbVIXKYxp08Y6ChVqajQKg+5XHxDq3aIWta+BZs29ODjLlrc8VKgLawIBC0
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;6:IIubP5wsbwO9ol9ms6AsVPWj/xhiUnN93vTf8VxbAJUFpDGcDLbnc7l01Xyit9PZoCXGpGXMIAktw76k/3qB622ZyxJlf0GgK2qmD4MWoeVApWN266OQkErjRI4jTQlQWOwnjXX84gmYbgQuWDs97pVkpNFrjjVTvlGRlofq8HGbiP92tQIJtL3c0NL4j4U3PFs6gYkU/DNGwGgRR5FLM7a6UWhID7p2pho1pLpnrva66aC0prBMQrjqvV4bwUa+GcqWP6lCbpF6N5BP9OoZ+SiKSP0KNUILoTKCAImUTesg848aChMZFArQ2Un2VAfmUMYTcIkeSzH+NZLw84h4/zgIp5eVzd9gz9SkbXHGpv8yuS910qZ33LpaLi2ykXKGLc9epHk4YESNRHnPedj9GkGfabhZCACABDV0DZNWcvwvxrsKNJes21X+/tmTsRdWixSjeUKno3TI4avRvlsRqw==;5:unQUYdIroxlFGp7zmBU8QAiA1YMFihtdPdjC9HixVSUv6sYd+MmS2VdMwyDxA57k6J77k4dfOkvj97bKjXVbMsnDfgyvZ7kPBLj5e6gdNLdGu1hoaf4LfmKQIBAKpNdsPH1goVwYB3B9yxGXJwFCFP8LUuLByTNNlt92yY8z43o=;24:TFEhfqIwS4XpQa2d0GbWl20e154skke4xPeNDDvZuKb5ciSqZmQh4nYrPmFj3cFLp5xXNVgid5hz+ubncsFCEYfo1DUtKYp/42Deo/YoGOY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;7:Do9qqcDuZfjdhSK+tsPJwo3Xng6jbB7ihz+BULGru5tyQWpYGhNhiXRM3t0msGtPq/13IUoQ3ji/PyK6ectCPj0mcRCl/hKv4LEuvoVuh1Kvq5MG30giLTq9zz3dWVWYbG+RbmrS83ztTf2hN8Yhs9wefKbSvPvf4aePtspT4Uqj29hXhMJK66kln//XZxiDGoCJbZm4GBMkf3u1oWaom4+Q3o9HrKU7sMmPPbpQvtLLkqx0q95r7nhZSEBH19TX
X-MS-Office365-Filtering-Correlation-Id: f0c0b53c-ba31-40ab-5fcc-08d5ba579d08
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:32:57.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c0b53c-ba31-40ab-5fcc-08d5ba579d08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4695
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 11:24, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:08PM CEST, vladbu@mellanox.com wrote:
>>Change action API to assume that action init function always takes
>>reference to action, even when overwriting existing action. This is
>>necessary because action API continues to use action pointer after init
>>function is done. At this point action becomes accessible for concurrent
>>modifications so user must always hold reference to it.
>>
>>Implement helper put list function to atomically release list of actions
>>after action API init code is done using them.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_api.c | 38 +++++++++++++++++---------------------
>> 1 file changed, 17 insertions(+), 21 deletions(-)
>>
>
> [...]
>
>
>>@@ -1196,8 +1190,7 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
>> 		return ret;
>> 	}
>> err:
>>-	if (event != RTM_GETACTION)
>
> Howcome you do this for RTM_GETACTION now too? Where is the related
> "get"?

In patch 5. There is always a possibility of concurrent delete without
rtnl lock so all usages of action pointers were converted to hold
reference to action.

>
>
>>-		tcf_action_destroy(&actions, 0);
>>+	tcf_action_put_lst(&actions);
>> 	return ret;
>> }
>> 
>
> [...]
