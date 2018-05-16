Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeEPMoR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:44:17 -0400
Received: from mail-he1eur01on0085.outbound.protection.outlook.com ([104.47.0.85]:6198
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeEPMoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:44:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-13-git-send-email-vladbu@mellanox.com> <20180516095953.GI1972@nanopsycho> <vbf4lj724th.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516122600.GM1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 12/14] net: sched: retry action check-insert on concurrent modification
In-reply-to: <20180516122600.GM1972@nanopsycho>
Date: Wed, 16 May 2018 15:43:58 +0300
Message-ID: <vbfwow322k1.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::36) To HE1PR05MB4698.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4698;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;3:33Ru3jmA9ipPeIsJt1LufEVmuWU70aOkIl1MILadfbanTOwTmX96TkF0WXgUQBT6Wr4G5GvXDNcXyL03e5QnnkWT7QLqY65bzDKUneiz9xiOQQ4cHQ/K+rFeZCo69/I3q4tlg7wIA3VlbnOD198OpQEXqv39mWunfbM7NwtJXsDeABF7UUcYQir4kEzyaZU6z3kUXrlFyiD4iBHmUqj7epfyNKayF4oCGn3do9jeh9DZqNBle3UHWEFiWhAbe2TG;25:zNK7uCPfbjKecUN/fwrgUbcI7FvHcOdGRxsR5+SRO+mmVswZZt29ei01SXYAGtsxS6Ry5PwfWlvxczDPCIQsXEyURZR6qQWftYED73ERsUfBdLgcdEy4xWhU6FqHVS+vSbJhUoYy7YgstAzmiBHO/D1gvC4q/1ZEfcHL68XXbGe3vA6XIZd866lQeU1nNK/Wem52DaGkWxO7X+VmCKPUTOp5ElEMjCWTuFhQd3KzaqS/JTfhnkMeDO040l+jBo/xprIUJfv4w+F/2cNNQxvMmxArgs/Z6C8BnAWJCopoK3s+Cth83VNtsKF7I1MFnqnyuZ+LcH7ytSxn58x6yDqomA==;31:TtTDa+Yty12TMewl0/TGEH5G2XJZBJQm5C2j+Hu53R9lPF79lp81/QzoSo2H5AxHg3B0vob1OMkEojlroYXQGiBjPB5sCe1vkE7n/SnRvk09I7lPJDn3oGrdvG70fGgDkSshdKk/dN39NZTxiOWbn4DWBZ94gNcxyBaumCVSOOIk6VRVugGbHP0CuSdb9IbeQSwAiHW6IlRH3eb5ANMCKMLCYMSySori0P5dhcfs2kU=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4698:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;20:BRat4ecE7pAPVdrpMUkzL8jwUNURSWfiFVIdqSXi77DMIfnCjW51Si0oozc8sJP9rvVMtMHSZz/LHXaE4n4rPL6r5JqQyqQXU7G7F3CuYe5alVgsWOg3/d4VcAZ+82cuCUxAVqtVvC/WvJIQShjFZS98QtwTEtCJ+TkmqWCFeXr7o5LFmOFfI7ouds07QLp7uB6wLTHB6QKtXrS+N3M4T9ULJN+m0wbWj4yp6AVtKUkrjK5aCtRnIIFCI5q1REheJvRZULltOK9LEiPxMCAtzGbPeJPwhBL9ZsyLjlcdVYEvKy1gO68HoUI8TatJ0y9KkESd38ES/9JDdFO3MKi8tH7e+3BHQuMV0TsFJZ01Rb72OeX5rp75eI1MbI5V4ucFKOhWrTPdTvDiFKmHcBNI77OaHYTCHgjNl3NRcg4HMiPsXpHgUpwgcXxd07U3HzZ4j8+x9bcgUbLHqqy1FcbWcCyxczsgTHEDLHmwFlHRS9BZCKc+IRgT0t5rmZvM5/0p;4:YuP+z7VD80a5qceeViqIszdZLVkyy7lsjF3bqb+/N5Q5zyyFUfkBfuxbWuQS5dS7dcUg3VVpfxiy4QeSIITLCIs7Xj46rebsE0awHBiI3WXv//Bit7+lE4OxN2r5rMP28/HkeuC9Cs8kYRyWr9DzvuERhUbKaA0XQMLlOHvTB55i5LeunHWUta/dR80JJocg1Kjnl1b3aLZvDnCxhdgyKUqGmCGYzSxW55ziCiywUCNEO7j4Av+stbSZHOZ2ZbnwIRSMnZa/EovXkzW2M3k+UCuTEaKq6oCh7MxbEhEGWT6r+4CT+dk4Z/1aOzOA455Z
X-Microsoft-Antispam-PRVS: <HE1PR05MB4698F3C994A92771A860C6A7AD920@HE1PR05MB4698.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4698;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4698;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(39860400002)(376002)(396003)(51444003)(189003)(199004)(6246003)(9686003)(25786009)(107886003)(478600001)(97736004)(6512007)(4326008)(386003)(11346002)(53936002)(476003)(956004)(81166006)(446003)(8936002)(93886005)(16526019)(81156014)(47776003)(7736002)(229853002)(26005)(8676002)(316002)(66066001)(2906002)(6916009)(305945005)(486006)(105586002)(106356001)(6486002)(7696005)(52116002)(51416003)(6666003)(86362001)(76176011)(3846002)(59450400001)(58126008)(39060400002)(6116002)(16586007)(68736007)(5660300001)(48376002)(50466002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4698;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4698;23:ZRe0Ia8BLW9dg/Lrj5/+/10a9wY6dtAUAJ4Db8gvS?=
 =?us-ascii?Q?WMs9CkB6gvVdxIAT6OAc6xtf4iDMTldOfjGob9HlbrIjCCU45IlFY3mP6BY7?=
 =?us-ascii?Q?gnIDQWIMQ9JqCUTZWk2/9HIJsCNDwXjE+9VdssQIuknTiGGSplQQXvvtubeq?=
 =?us-ascii?Q?4xUO2PQVKIGcanQLxesKnjgmbLk4FAHqR3ukGwr8Js0WIImThVIyfhQD/K2M?=
 =?us-ascii?Q?yyTvKCj2cvXvyX3GrZv/1S6u2pTvYvv7TH+/UNOTs+A+CtPeRnTc5zgERipk?=
 =?us-ascii?Q?7BAsqveWBiVkpnzP5dsRcyu6T+tHiUiUMwJiyPQmqIYPwCdZjEDTl519g8QS?=
 =?us-ascii?Q?fIA05Q4NBhSydJiQjTEJ0V8F04erd2DexbVy6UzUPPFN5CppTLi4K7/zR9dD?=
 =?us-ascii?Q?Q4j6Y1qie27q8VPlDgfE2c2490onLPgmHko4ubEeB7csQ3wWhq3fCRQTpQ/q?=
 =?us-ascii?Q?us+4NutnQ3+JefUTX53O6yDSTp32/7fi5qmdcUMDQV4STkuGDqaegQe7wmM0?=
 =?us-ascii?Q?pdPBSgltZ1KA2UdS2/IN7CM9ebr4zJs3e+2MY4lYhjPNh9M5iWyZPwG7TV6k?=
 =?us-ascii?Q?PBwMAZcU74uBRiIBWVfmQljjAt1hgdV7FDaveIjomg28sW2oEbqJHXyjRwuj?=
 =?us-ascii?Q?hrXIrnskEUkjUOT2YAKAzjCyn+efw16GPqDG21oMS2vjNnfHFWKHiwf8rcnG?=
 =?us-ascii?Q?no31AoBMtCrFnDtr+jzGcNU/nzuo732Jhws6Vn780SxTWz7B1mr++EVxSWw7?=
 =?us-ascii?Q?c5qkWI+8t+VsFNFDzJACaMqPT32t7XrIu9CAUanG8ap1kIwh/fIBrqsYMMFC?=
 =?us-ascii?Q?oFyALgBvWYcenGurhQwtUjMpuUlLclGQEF8IdoExOcRrFgr569VyBse3kk4f?=
 =?us-ascii?Q?Djsvs28fNJBlIr9us+wMdI3xqx5g38SA4Wa+Q3ierojaKB4ZHQQTZ50T89q2?=
 =?us-ascii?Q?z499b6/byPFhxCdexHFA0NskdKJ+NM4rDE3+eNbId1LrEtIbiNP7lcw6XRc7?=
 =?us-ascii?Q?tihxqZdyMnWd5qqF7k+GTyacg5SNXnZkZMAzjnjZVa0b53Gj5vAy7RozDqG0?=
 =?us-ascii?Q?VPm0W2Thl0FtRMPbUI0jbGu+jg+bhK43iI4SOZ24nEMUgsOQRjQtMXznONF2?=
 =?us-ascii?Q?s/NPGJ8NjNFnRCc5+3fi2RotXFULr3SBeEKzOC3GnctDFPuZIosnA0onDq4T?=
 =?us-ascii?Q?bapoDSUFQwvSFO3Np8FZRJ4DGGqmM3MJwueLmKI2g3KjsdK+UYZeBQaFm93y?=
 =?us-ascii?Q?L/LeDXPzR1pFhBovVFUZpygiUnt+JePhfeoCI6pM8IOjJkj1NSgQyoqv/pNK?=
 =?us-ascii?Q?oOyL50vYfYK0dsOrwrkUrw=3D?=
X-Microsoft-Antispam-Message-Info: OkCgNzG1UeofulzhDiXgL1KQggilEnITk0vzecbYJrEk0QPUdVy2I14Il1KXZSlkrvtngtzVr507BI2tyTPDqhfoU4KLQwfOHlj9M5hVK2qorLJIACawXz4Dc+ywomcno83BKg+B/pUc9UKEanoiU4G8xIJrulAmBy1deVCFDSyAnjxDjjI0k+HtqWJ6VkGe
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;6:D+cVNF/CJ8V8NgcT+KjMfQjAeEVzAUhD0HiD0IBRgT1h6vUzMGWzPWFa/IT2QrjELmRf4T//h7c+O3kH+bmPDkk/mdhp71SQJp4oo98yZaGCA+8/tcRgv2rKsrRzavKRXKb8UDU3kpmLtrVGy+fW36GT5VQKt8XccafJcqDk2Q4ztO65SHIqh+vckPDoyvBFku3KDqAyZXH+U0upPZziMWa9R5ST72D3xwsAPriec75yRh+2aq3ro4SoAYEvXFQsG7UUoaUBMN6HOImr3eBgENCnyiIU+r8kr+ZAiEuaPpDEUXMeSfefTYYJXEzlG4yMKnYhDAV3J1k9ov45TqMYOYPWSIB6UoEyoeLHYaX3QIyyf6r25Vq8u+ujUlC8K09IyBAoH3sdZHzzMTvasKxctyu8BbJ2RV+HczTXdQ6pJ9+i9g9V/t5yL9K6a1+WTKM0+gozHYhRabV7Afm4hhA8kg==;5:C4CKeEwOCLnu9ZBt0AgaHD7o9QRCa/CYrm2bFBP5GAdL0XChOB6VEkGV2Ts2t87x9Kt9vVkTFejZTZD2T9b8d32EoN8A8KmFgMxmIFl+evrfNPCv/P8UvD9V0QLA+ByL+ssgWpz6JQEbY+BAM2Rsx7z9nim3fCFm8dKCcmI+zRg=;24:AMjnNW+PNHecSgD+gNIjJSpwWPyUrspOpYte85jDH0/I7KRhama7R4b/h8woEuYe7CWG4kUpc4udACH4qekqro50dlziTbEtoXDKZajnnCw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;7:4R1ZePp02K3+GMrgpy0zWF9TWGxz4JevDGUnAn5ej6R8GKzCiupBJ9cEo4U++VRqpx2WqQ70QIlZLZFSRmlywmh/Lr36TJ1NHroy0B4U20E3EqcJbM053p9tYtEPRDDhVyPvOYewOiizRLwLLlvt0zp+0V8Be9Lm8cKPwSkWJAFLqkdZVD8sdo+QNVQETMP9kh6nZKOZINNPOwNPu3yP7mUtdof5Q9drXuBrPiGO00KDwzLqZCXvq51fgqrK4yhM
X-MS-Office365-Filtering-Correlation-Id: 4b4c9930-79ea-4881-f791-08d5bb2ab7b4
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 12:44:05.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4c9930-79ea-4881-f791-08d5bb2ab7b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 12:26, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, May 16, 2018 at 01:55:06PM CEST, vladbu@mellanox.com wrote:
>>
>>On Wed 16 May 2018 at 09:59, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Mon, May 14, 2018 at 04:27:13PM CEST, vladbu@mellanox.com wrote:
>>>>Retry check-insert sequence in action init functions if action with same
>>>>index was inserted concurrently.
>>>>
>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>---
>>>> net/sched/act_bpf.c        | 8 +++++++-
>>>> net/sched/act_connmark.c   | 8 +++++++-
>>>> net/sched/act_csum.c       | 8 +++++++-
>>>> net/sched/act_gact.c       | 8 +++++++-
>>>> net/sched/act_ife.c        | 8 +++++++-
>>>> net/sched/act_ipt.c        | 8 +++++++-
>>>> net/sched/act_mirred.c     | 8 +++++++-
>>>> net/sched/act_nat.c        | 8 +++++++-
>>>> net/sched/act_pedit.c      | 8 +++++++-
>>>> net/sched/act_police.c     | 9 ++++++++-
>>>> net/sched/act_sample.c     | 8 +++++++-
>>>> net/sched/act_simple.c     | 9 ++++++++-
>>>> net/sched/act_skbedit.c    | 8 +++++++-
>>>> net/sched/act_skbmod.c     | 8 +++++++-
>>>> net/sched/act_tunnel_key.c | 9 ++++++++-
>>>> net/sched/act_vlan.c       | 9 ++++++++-
>>>> 16 files changed, 116 insertions(+), 16 deletions(-)
>>>>
>>>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>>>index 5554bf7..7e20fdc 100644
>>>>--- a/net/sched/act_bpf.c
>>>>+++ b/net/sched/act_bpf.c
>>>>@@ -299,10 +299,16 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>>>> 
>>>> 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
>>>> 
>>>>+replay:
>>>> 	if (!tcf_idr_check(tn, parm->index, act, bind)) {
>>>> 		ret = tcf_idr_create(tn, parm->index, est, act,
>>>> 				     &act_bpf_ops, bind, true);
>>>>-		if (ret < 0)
>>>>+		/* Action with specified index was created concurrently.
>>>>+		 * Check again.
>>>>+		 */
>>>>+		if (parm->index && ret == -ENOSPC)
>>>>+			goto replay;
>>>>+		else if (ret)
>>>
>>> Hmm, looks like you are doing the same/very similar thing in every act
>>> code. I think it would make sense to introduce a helper function for
>>> this purpose.
>>
>>This code uses goto so it can't be easily refactored into standalone
>>function. Could you specify which part of this code you suggest to
>>extract?
>
> Hmm, looking at the code, I think that what would help is to have a
> helper that would atomically check if index exists and if not, it would
> allocate one. Something like:
>
>
> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
> 			struct tc_action **a, int bind)
> {
> 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
> 	struct tc_action *p;
> 	int err;
>
> 	spin_lock(&idrinfo->lock);
> 	if (*index) {
> 		p = idr_find(&idrinfo->action_idr, *index);
> 		if (p) {
> 			if (bind)
> 	   			p->tcfa_bindcnt++;
> 			p->tcfa_refcnt++;
> 			*a = p;
> 			err = 0;
> 		} else {
> 			*a = NULL;
> 			err = idr_alloc_u32(idr, NULL, index,
> 					    *index, GFP_ATOMIC);
> 		}
> 	} else {
> 		*index = 1;
> 		*a = NULL;
> 		err = idr_alloc_u32(idr, NULL, index, UINT_MAX, GFP_ATOMIC);
> 	}
> 	spin_unlock(&idrinfo->lock);
> 	return err;
> }
>
> The act code would just check if "a" is NULL and if so, it would call
> tcf_idr_create() with allocated index as arg.

What about multiple actions that have arbitrary code between initial
check and idr allocation that is currently inside tcf_idr_create()?

>
>
>>
>>>
>>> [...]
>>
