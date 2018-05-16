Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeEPO05 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:26:57 -0400
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:26272
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752038AbeEPO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:26:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-13-git-send-email-vladbu@mellanox.com> <20180516095953.GI1972@nanopsycho> <vbf4lj724th.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516122600.GM1972@nanopsycho> <vbfwow322k1.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516132135.GN1972@nanopsycho> <vbfvabn1zic.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516141319.GO1972@nanopsycho>
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
In-reply-to: <20180516141319.GO1972@nanopsycho>
Date: Wed, 16 May 2018 17:26:40 +0300
Message-ID: <vbfsh6r1xsv.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::31) To AM0PR05MB4692.eurprd05.prod.outlook.com
 (2603:10a6:208:af::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4692;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;3:MwyjScnpowb8H9Oi7QYg9fiFyGY38b2iD7KFSCvBgnR3wAANQduMTp16By38NyYjAyPL5GMLS5JuRi7NEBeN7s6c8C/LMvxuJwh3A/0o9H1uns7GpazLF4wZgxHr5eqsLpbJEgnlmcTgMyO8kZj4Fl8id/CpWAicrCEnuai6nG6a6uy52Miad4MVRl6xYH0KSUAPQmuTgCyXKOKjUgQFLNc2hwZRig9phsJYS6xTnJvuF9lDG0E9GPHcd9OBnL+W;25:b6dQAIxgjm+CemqWnqFeItx0U/qV5qtFMszMRtnhqP4VaS1OjX+1wQ9wKkW0sSFkgzn+JU76L/u595LMYXOHNrmwSiiZkGDmk3dDvv9njKgI1elR7brWpbPbyqdOduN71lpbTfWHh7PmfUHkPhoklX2YSlUPiIL8NnIjj97yYrbFI6YLjSIV4UWgGjzcnDQhYhcQsAqDmmHiQqd5IjvJ3I7TKQdpUMBZ2qhjAfU8LOIUTsXhiF/3UIBgwF62go8cvyNi7MMBAqlyEBD7Y49saZJ0U7G5fZzlup5xNFi/I3oLU8WsykOTulx0+7KGj6jF0OEdIYB98U8eBVfQukVihA==;31:0RrxvvsE+rupg6lZWBm4XqwP2I8gBQ3Q2xs9cjjW2+47mgh7JB83Ygf7AqyOLzpr4IY5vRaYDXIJy/+5XCUf0RfnOdn0TuZKQxsaa1PrKpucjyEqugrbx2Ppmkh1spr2x7iT8BpVKOn1341cceZdSsX3GGST/l2GUfDwI3RnZO2Aqb65gVRrVSuUIZ/ypcAtzubKtBzPilnCoJSglxJB+WloX9iRU38PaL7F6n3OGJk=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4692:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;20:1uiwPsJ/aIXQFKs7ZyVCUwthYVRajy9PRj0RbjL3tDeJ8a6U8oqjOnND7AeT+0ISC5VBCZRUIKlNlTuCnse+K91BiI9IvFUJK2K65U4Lr28QftHnfTjIqUrZ8yM6CIoctjt7RSLFUNLDZor6wRSeN5MibTmLXxQj3jlbH77AdTiiIV+nFH2/OFm4At+NAZ43dWPfv1ipdftsEphx/OzA3dQHgKPJ/zYyCOGFafoOERiVAcXlv6yHcj0911uTnNgbGn8ukQaVIk8sn7SdWv06/Izrhwe9Ov4v/IDWKlJT73WcszfEQ0QVPY4WXUq3Mi32Hn/TN0vxJ0T9ZBo8RnhxWNm2LBrnDqFOeP1PfNCPONTJHQtIN5nk4d40loxCzeJGFYPN7R2RkJdpLHCtE3apyM1U9sjf9DqzzXIZ6XcZAH5lcqzMB3p5DouCk9n1omGB6LO+ZwhFdbbMpbw9JN0dABWyq/WTDdNPqGQHQT4TSfXhmDedkNg7XwVZGUweApIh;4:r1u6TE6fGdEKKLTfE5Per1YjF/Qt/je17/a+5Tgoe00HIUmf2Nt3wBqGaTPVYaq6FwG61Rg9g4A6X82W5rB+sjh36JCHXQlsT1NgZUQCrHSyz3uswSD+P8La7kzjEQFi4MobYtxy/5cEXpiLCg3eza5OV6Qsi5qMZA2ZO5BfjPX8RmTU8YJ0Im82Mr00HyfjqGFsI6N0GQt6L7nkqmV9KkLYOpMUM7071vRPqH3MvTDUlPC1go8p3N9Pc0ubf/UN5aXQKWSZ6c2ECuu4eOVOX5aATtqod0FcaN2KPUMIwh0C94h96RBmuQK1FVHspkAi
X-Microsoft-Antispam-PRVS: <AM0PR05MB469212DFD74673A06CD0C1D1AD920@AM0PR05MB4692.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR05MB4692;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4692;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(39380400002)(396003)(346002)(51444003)(43544003)(52314003)(199004)(189003)(956004)(446003)(6512007)(7696005)(9686003)(53936002)(26005)(386003)(11346002)(476003)(6246003)(76176011)(51416003)(107886003)(52116002)(486006)(25786009)(6916009)(229853002)(6666003)(97736004)(16526019)(305945005)(7736002)(478600001)(93886005)(316002)(16586007)(2906002)(5660300001)(39060400002)(47776003)(8936002)(105586002)(86362001)(48376002)(59450400001)(8676002)(6486002)(6116002)(81166006)(68736007)(66066001)(106356001)(7416002)(58126008)(81156014)(4326008)(50466002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4692;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4692;23:WhUJcus6sZaNBEz1cQPMXPWvFXzs7D0NeFEsPHjdh?=
 =?us-ascii?Q?SFWIxzSw1Od/reph0RyjEPbeH+4+lQnmFQknPoTx9nLDRIurq4mtTtwI4Kve?=
 =?us-ascii?Q?3RR6egJxUNiTd447m/VhlkxaVPhTutEAN54ORA/8DaODb7tEb4loXNq4zhtC?=
 =?us-ascii?Q?RQ2TmtCfZCY/uLvRUUarNmJn61ZMmj5G9pabOGbDrz4n18U2oTOirb+r0xxa?=
 =?us-ascii?Q?Vps0ON9JXunJvmCyooHF/7vGTvA95JdulE0sSeB7jhpuWr1GYnegHrmosGip?=
 =?us-ascii?Q?jtS2bpTcOT++3kaMtq9164mCy3jpJNPN0WzQJt64Mn0T3QVuFuFGBApEOO4t?=
 =?us-ascii?Q?HyZ0fE8ytFwareRbLzHCmbOko5b+DoiIyzo+z2W8YyF3DnBF6iGr/7R+6fhV?=
 =?us-ascii?Q?iX27M37/Y2P853RulWKdqpTppW1A5An+fBnpMxyMpnvEeWOiVYVQdW7Xvpbc?=
 =?us-ascii?Q?jmVRomiySGRYOt4rY3WEffhdjiNonmrmuBQ3g9j+3NupcXXWRAXcUZCpRo4E?=
 =?us-ascii?Q?PFXENXgzVGPxxh2fyqhrcLrKILXu3ts1f07CYx/JtAtWbqi3wZBCQOF3seNr?=
 =?us-ascii?Q?DH6saQzmoFuPL5cQooYuI6IdZ0cqfyaoB3czHcgmf64tzsKRSqgYSvO+qye7?=
 =?us-ascii?Q?VIoExZxcxNpc3PCE+lhL4TG6BM46k0U8YxqWWS54s/MmnM/9LPsF1R88chrd?=
 =?us-ascii?Q?xIpx2dcjwlzuTk9+nMeMbnHGHZah+wDDtJVjSeMIbZil9zGy+Yq1iq3USSNZ?=
 =?us-ascii?Q?TVVWNYwDR9klAFstg1HeKPh9O1WXWKMHgLgoQAbeBXlEsE078wlcWnJSTaOg?=
 =?us-ascii?Q?USkWf8jk5BKpZxaqE2145YvV/htfZVS18Wb1Jg6tu3PDtk9/EExEzbl1/1a2?=
 =?us-ascii?Q?acehTkPC9HwjeZYXVuRXQIS10SiHtGNE3oyao/Ao4lW+qFVsl4GihHLz48P+?=
 =?us-ascii?Q?fHGhydPQWbNG/NM/jB/bDQXEdJKcfhDPezfAL09+zV6MMiZDcKD4LsDDvhrw?=
 =?us-ascii?Q?6RMTqEHN7oJ1AwxL127gYEIpAVkJJ+BKB5Q0o4mDAVZJYQk0sGJORqC8IYYb?=
 =?us-ascii?Q?FB5CP39aBmB5NDhlf4BoJ9qb6oGAkpEkb8Me+yWjDpIeAK2B03752hzRZXfO?=
 =?us-ascii?Q?HqddtWnnxB7etlynvfwENDMILvin5vHsnOr1RZKb6TQU/IXaR9Q2PCj1EK10?=
 =?us-ascii?Q?gnpbPskKqAcDVYokoL6/oF0Syh5f0OF2e3YKr5pnBuBrU3tNtXACoks6kk7Q?=
 =?us-ascii?Q?8eswVoI7rTY4BtS8PuDMkgOKdybgr7FtF23cFvxjz7/SHuLbiLvz84NTHETX?=
 =?us-ascii?Q?yRb/NAjWvg7O1WhkOey64VtWP3kAiCJli3xfvNS/WHZuCsQB+epULLF04KxL?=
 =?us-ascii?Q?+x82g=3D=3D?=
X-Microsoft-Antispam-Message-Info: WYqMulyryZVrE1WZU9n9gfM8Lhp/pd1vkUIZ9Uy0kJlaqcCpn3NBsvZSaMKomZzMPadbCztOb1OBRQDzLIIEKgiJQ0Kj6TwU1VUCIzB8nH3h1TulVhViHbBeqievps/QNA0rTIh+pRT9siSEWXjoqeMYs8OEhzWy4Zkw6f9Yo8JdP+jgXEA+A29CRwsvUGBh
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;6:frOSqpLO33ZGYxAD4w8oZy+i5vgjjzGLp4BE2lzSjtEbvloVrz2B6onafp/BJw9UCSouOwOgx0jM7mJPjMJnwXq/cnnDC/yVsQQ0pJMOc012vf3wIzlQxmw5nkE5u4fpbmZRPGrRaar8gS4So2L8IDfTyTOL2ElRnxtGXjb31WRldJmYmxM7SYFguU18Tr/6SpvDfkOC7IXbWJuCiUlqQmEWiUQPf1/TC1m6q3ZB7IFO0J0XKGSZ5QqCTjSztiqTLtWPvUyB9yMbz0/BqaAgA4shJGIIopSJhMvKxeTdo5sUTRU8K2mlCQXwns7nFMddaFTq1T65M/9HUHe95RW4AWWce7S2JQTixB39hpDXVAi44A4YWxEiZvmj3qxxHscBDOWSLlSl4AnmUICs95gr84jAPh5vnkD0jH/glga2jekKpoWJ0VWZ0pmHsQ+Pu0BAToTcwGJF/Z/2bktJJE1/Xw==;5:VQNAkFZKqA1tJQ7VtmBB0jd2dIKne4CN3Yxo65iy+JXd3j3+fEZ61Fli3pYn3QQ9fGFrS1UO4BysHSdx5rW/yEkW//rivMc+J+ZOCuvi8KKN5JLvJW8ecBUVB/JAuhh9wxnT6ta2fS8pklXMAWUNT7pW7ibVRi4Vq9nxYr91Vzg=;24:z2QGSYFbxkh/8bQ83lvJ04oBbyWIsU4FzDYG0KeR2hY9Nf5I9alVJijCOhkBxlXJsZysmOk5eQMGA9J5VK3JgAYj9U2jn/x4EZMSD0E1tFo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;7:g5pI6KmmgUQ43F8Khbqbo3mX6G1IdIGo2FF/zKT0nKdnB1/HaY2HWlcKSnSlUWD05KF+4LlnZ7jKWFQuMeSP98SY3bEIFQ+EZRArrRFld2bZ9/YUJCToqRz7S1smijwGOX0fVLSr8npUA8HnQR5Ai79QubBWbIV7WetO77SqvD3ex1WF/Evb8uXQxe3PRMjLd54BxhkCIM1DYpWtB3V3cXStqDfNol/z53aIfPV1xHGjjJ9DqQeS5j0qRonqQ+0A
X-MS-Office365-Filtering-Correlation-Id: 823780fa-e4e0-407e-d9f1-08d5bb390fc9
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 14:26:46.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823780fa-e4e0-407e-d9f1-08d5bb390fc9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 14:13, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, May 16, 2018 at 03:52:20PM CEST, vladbu@mellanox.com wrote:
>>
>>On Wed 16 May 2018 at 13:21, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Wed, May 16, 2018 at 02:43:58PM CEST, vladbu@mellanox.com wrote:
>>>>
>>>>On Wed 16 May 2018 at 12:26, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Wed, May 16, 2018 at 01:55:06PM CEST, vladbu@mellanox.com wrote:
>>>>>>
>>>>>>On Wed 16 May 2018 at 09:59, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>> Mon, May 14, 2018 at 04:27:13PM CEST, vladbu@mellanox.com wrote:
>>>>>>>>Retry check-insert sequence in action init functions if action with same
>>>>>>>>index was inserted concurrently.
>>>>>>>>
>>>>>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>>>>>---
>>>>>>>> net/sched/act_bpf.c        | 8 +++++++-
>>>>>>>> net/sched/act_connmark.c   | 8 +++++++-
>>>>>>>> net/sched/act_csum.c       | 8 +++++++-
>>>>>>>> net/sched/act_gact.c       | 8 +++++++-
>>>>>>>> net/sched/act_ife.c        | 8 +++++++-
>>>>>>>> net/sched/act_ipt.c        | 8 +++++++-
>>>>>>>> net/sched/act_mirred.c     | 8 +++++++-
>>>>>>>> net/sched/act_nat.c        | 8 +++++++-
>>>>>>>> net/sched/act_pedit.c      | 8 +++++++-
>>>>>>>> net/sched/act_police.c     | 9 ++++++++-
>>>>>>>> net/sched/act_sample.c     | 8 +++++++-
>>>>>>>> net/sched/act_simple.c     | 9 ++++++++-
>>>>>>>> net/sched/act_skbedit.c    | 8 +++++++-
>>>>>>>> net/sched/act_skbmod.c     | 8 +++++++-
>>>>>>>> net/sched/act_tunnel_key.c | 9 ++++++++-
>>>>>>>> net/sched/act_vlan.c       | 9 ++++++++-
>>>>>>>> 16 files changed, 116 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>>>>>>>index 5554bf7..7e20fdc 100644
>>>>>>>>--- a/net/sched/act_bpf.c
>>>>>>>>+++ b/net/sched/act_bpf.c
>>>>>>>>@@ -299,10 +299,16 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>>>>>>>> 
>>>>>>>> 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
>>>>>>>> 
>>>>>>>>+replay:
>>>>>>>> 	if (!tcf_idr_check(tn, parm->index, act, bind)) {
>>>>>>>> 		ret = tcf_idr_create(tn, parm->index, est, act,
>>>>>>>> 				     &act_bpf_ops, bind, true);
>>>>>>>>-		if (ret < 0)
>>>>>>>>+		/* Action with specified index was created concurrently.
>>>>>>>>+		 * Check again.
>>>>>>>>+		 */
>>>>>>>>+		if (parm->index && ret == -ENOSPC)
>>>>>>>>+			goto replay;
>>>>>>>>+		else if (ret)
>>>>>>>
>>>>>>> Hmm, looks like you are doing the same/very similar thing in every act
>>>>>>> code. I think it would make sense to introduce a helper function for
>>>>>>> this purpose.
>>>>>>
>>>>>>This code uses goto so it can't be easily refactored into standalone
>>>>>>function. Could you specify which part of this code you suggest to
>>>>>>extract?
>>>>>
>>>>> Hmm, looking at the code, I think that what would help is to have a
>>>>> helper that would atomically check if index exists and if not, it would
>>>>> allocate one. Something like:
>>>>>
>>>>>
>>>>> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>>>>> 			struct tc_action **a, int bind)
>>>>> {
>>>>> 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>>> 	struct tc_action *p;
>>>>> 	int err;
>>>>>
>>>>> 	spin_lock(&idrinfo->lock);
>>>>> 	if (*index) {
>>>>> 		p = idr_find(&idrinfo->action_idr, *index);
>>>>> 		if (p) {
>>>>> 			if (bind)
>>>>> 	   			p->tcfa_bindcnt++;
>>>>> 			p->tcfa_refcnt++;
>>>>> 			*a = p;
>>>>> 			err = 0;
>>>>> 		} else {
>>>>> 			*a = NULL;
>>>>> 			err = idr_alloc_u32(idr, NULL, index,
>>>>> 					    *index, GFP_ATOMIC);
>>>>> 		}
>>>>> 	} else {
>>>>> 		*index = 1;
>>>>> 		*a = NULL;
>>>>> 		err = idr_alloc_u32(idr, NULL, index, UINT_MAX, GFP_ATOMIC);
>>>>> 	}
>>>>> 	spin_unlock(&idrinfo->lock);
>>>>> 	return err;
>>>>> }
>>>>>
>>>>> The act code would just check if "a" is NULL and if so, it would call
>>>>> tcf_idr_create() with allocated index as arg.
>>>>
>>>>What about multiple actions that have arbitrary code between initial
>>>>check and idr allocation that is currently inside tcf_idr_create()?
>>>
>>> Why it would be a problem to have them after the allocation?
>>
>>Lets look at mirred for exmple:
>>	exists = tcf_idr_check(tn, parm->index, a, bind);
>>	if (exists && bind)
>>		return 0;
>>
>>	switch (parm->eaction) {
>>	case TCA_EGRESS_MIRROR:
>>	case TCA_EGRESS_REDIR:
>>	case TCA_INGRESS_REDIR:
>>	case TCA_INGRESS_MIRROR:
>>		break;
>>	default:
>>		if (exists)
>>			tcf_idr_release(*a, bind);
>>		NL_SET_ERR_MSG_MOD(extack, "Unknown mirred option");
>>		return -EINVAL;
>>	}
>>	if (parm->ifindex) {
>>		dev = __dev_get_by_index(net, parm->ifindex);
>>		if (dev == NULL) {
>>			if (exists)
>>				tcf_idr_release(*a, bind);
>>			return -ENODEV;
>>		}
>>		mac_header_xmit = dev_is_mac_header_xmit(dev);
>>	} else {
>>		dev = NULL;
>>	}
>>
>>	if (!exists) {
>>		if (!dev) {
>>			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
>>			return -EINVAL;
>>		}
>>		ret = tcf_idr_create(tn, parm->index, est, a,
>>				     &act_mirred_ops, bind, true);
>>		/* Action with specified index was created concurrently.
>>		 * Check again.
>>		 */
>>		if (parm->index && ret == -ENOSPC)
>>			goto replay;
>>		else if (ret)
>>			return ret;
>>
>>There are several returns and cleanup is only performed when action
>>exists. So all code like that will have to be audited to also remove
>>index from idr, otherwise idr handles leak on return.
>
> Yeah. You have to take care of the error path.
>
>
>>
>>>
>>> There is one issue though with my draft. tcf_idr_insert() function
>>> which actually assigns a "p" pointer to the idr index is called later on.
>>> Until that happens, the idr_find() would return NULL even if the index
>>> is actually allocated. We cannot assign "p" in tcf_idr_check_alloc()
>>> because it is allocated only later on in tcf_idr_create(). But that is
>>> resolvable by the following trick:
>>>
>>> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>>> 			struct tc_action **a, int bind)
>>> {
>>> 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>> 	struct tc_action *p;
>>> 	int err;
>>>
>>> again:
>>> 	spin_lock(&idrinfo->lock);
>>> 	if (*index) {
>>>  		p = idr_find(&idrinfo->action_idr, *index);
>>> 		if (IS_ERR(p)) {
>>> 			/* This means that another process allocated
>>> 			 * index but did not assign the pointer yet.
>>> 			 */
>>> 			spin_unlock(&idrinfo->lock);
>>> 			goto again;
>>> 		}
>>>  		if (p) {
>>>  			if (bind)
>>>  	   			p->tcfa_bindcnt++;
>>>  			p->tcfa_refcnt++;
>>>  			*a = p;
>>>  			err = 0;
>>>  		} else {
>>>  			*a = NULL;
>>>  			err = idr_alloc_u32(idr, NULL, index,
>>>  					    *index, GFP_ATOMIC);
>>> 			idr_replace(&idrinfo->action_idr,
>>> 				    ERR_PTR(-EBUSY), *index);
>>>  		}
>>>  	} else {
>>>  		*index = 1;
>>> 		*a = NULL;
>>>  		err = idr_alloc_u32(idr, NULL, index, UINT_MAX, GFP_ATOMIC);
>>> 		idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY), *index);
>>>  	}
>>>  	spin_unlock(&idrinfo->lock);
>>>  	return err;
>>> }
>>>
>>
>>So users of action idr that might perform concurrent lookups are also
>>have to be changed to check for error pointers, that now can be inserted
>>into idr? Seems like a complex change...
>
> You can just add a simple check into tcf_idr_lookup(). Where else?
>

To me it looks like we take something simple and already working, and
make it complex to save few lines of code in action init...

Anyway, how should I do patch split for this?
Patch to implement function you outlined and another one to modify all
actions to use it(with all refactoring to not leak references)? Or patch
per action is better approach?
