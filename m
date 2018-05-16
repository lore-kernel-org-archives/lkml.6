Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEPJkJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:40:09 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:18683
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751046AbeEPJkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:40:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-11-git-send-email-vladbu@mellanox.com> <20180516075000.GC1972@nanopsycho> <vbfbmdg10du.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516085628.GE1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 10/14] net: sched: extend act API for lockless actions
In-reply-to: <20180516085628.GE1972@nanopsycho>
Date: Wed, 16 May 2018 12:39:52 +0300
Message-ID: <vbfa7t00wif.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::34) To HE1PR05MB4698.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4698;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;3:KQ772Kd5/W6bJcV/bk6Fhg3TmIEgdwHTC/MLyHMDntCz+nbslGGtq1aebdHyVdNumEEcQYsUrXoclbKB4JiW+PQRXaakDRm9jvcdRrHNDpQ1xJeXazWZS+fbnQSQ6fD1Xx4znGhXo6sR4330W7dUJk8AIFsDgCX/I2jp5az4MdZUq8j/anvEoJDSvR0uSXu9yMJlqVXvkzBBC0gVEw/5p3mg+tpaWXoQvfafgfzGb6Z4kexCZ3KJDtUHta/9jEON;25:c8TJtMylfhZSQEpQFdZDrFHf/mfPBnvKdyLJp2I7fo2PcQOailGSuz9jKvveBLZVRXJDsCypGEIeyAVDSE+lHBDYQV80mUH3zUYK6UNjFIFtyqVY/QKMrg30cFzqZ2twSyoeTJ7FwPkGWbF6+h3rckuNK/V5ZIj9bthPPP3m0KL20UfFHNY1qIn1+MWajSCVK2Wd2GXDTE/jd8Spc9pr19+RYQNeUt8DhoV69A+z66kxVwd2NnDO7TgnUONJStS4N5BMIUdkRR1njlMraGSW0Gnf8RNF6XfcUXlhfEVDnYDd7clJiV/5w9F2Xe2rgs3pq/Zbc70zCkEj+cG+/8ebCw==;31:auQp4rvYe24ML2Vz0K53ehK4YmbrBf4+9UBodnk/owp5IMo7ATSNgWQw3StcMoKYSWOkuYAdVTRuP9/E9ykpDuR7hyDeVkDyFhagE04sdfjws6WtHQ/hDHiZ0MaBJeQXUxFgIOr0yb37u6S7aj92P21LQzH6tnx4vddIz9uTREevxK9+RcE7EbXW1vSEr5Oiv1AhUHB1+jFzm6aENTcYSImtNW4wTrt2E2DOTKyYqxE=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4698:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;20:usQfQTsvnQFNDWVBd2RbEc5S+GvMgnTFC3Qp6Sdb10RhfJXkj/ShdTNTp3FpsVp3sN1cwuibfYv/IJbTbuy69Vh79bX5xCuFOXAcgrAYuO9Mtb2ukiSKNFpjffrlzsEJAL2+lCpRBaCUL8S5M7E9Lp7/sX4Oz9b8WFPducLkvDsZWuZiRIAzkzkY/7Y2vrhkyXaAgXhxQK7/Uonq3i8B9Rif2pEI0lLS2tJQDII7mUoCivOs0XyjkEOLTtgsaBteI5TRk3Hbskxc+QPJLdH/jBgyLo6/eAEbgZyBlWYhTIQJhDIhyqBTzKPXpBmjQzjxJfuRR4QzLgo1yDY3hoqVNoQxhecuKodCAHatduimaW8n3hlKeEwiXcYSRwQ3fj8kWFNTUMD/a6NyGzhxCSR0vmtgIeBZ5r4WbnoXdCpuVMGB1KOakzti5VQV14HjaSPEv328zZZCDvqXJ9pAFkaQdtXUbqCNl+zgW9W1zShjNaJfzGiHlC9xDLEL44BZCUjB;4:JFtnSMT0sVrt2ua0B08qxo1fB1mKld+rTBuJBV4y3z0ZYRibYuXWeTiCzqTvcr43yEReYQMBc6GpeGIasAzoAdKBzOaQu+uyt5N5Rg3vp1SRsZJuD9Peg5qK9XM7tKXYhk/4DRKkmRk1/8fyLVT0QiAmCUh1vq9GDN3NFfrabO2UXYIwJM9YdopUtBVHAdO0vF/eshW+1urr34bldE2jFtdSZHJ8edeZvKdaWQJ0qgivMj+4tel5YaQJsquc70Zhmb3UeH7j5ZD/BCGa0e6ukuPgHvnO0pHQR2ZFCYdd3pPIXSWLrHvYXT2j85XEfpB4
X-Microsoft-Antispam-PRVS: <HE1PR05MB4698A3FE61EEFC29331A1F05AD920@HE1PR05MB4698.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4698;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4698;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(366004)(39860400002)(396003)(376002)(54094003)(199004)(189003)(6246003)(9686003)(25786009)(107886003)(478600001)(6512007)(97736004)(4326008)(386003)(11346002)(53936002)(476003)(956004)(446003)(81166006)(8936002)(66066001)(93886005)(47776003)(81156014)(8676002)(7736002)(229853002)(26005)(316002)(16526019)(2906002)(6916009)(305945005)(486006)(575784001)(106356001)(105586002)(6486002)(7696005)(52116002)(51416003)(6666003)(86362001)(76176011)(59450400001)(3846002)(39060400002)(58126008)(6116002)(16586007)(68736007)(5660300001)(50466002)(7416002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4698;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4698;23:EgF1Mc9oGzaVcZXcI9/lEA79Iw8qudcbADFLWsD8+?=
 =?us-ascii?Q?C8cV/gBxVj9CK79UwlHvRV+9o7dfOMgmWT6EeHjxnvdhul174GUsAyX723SF?=
 =?us-ascii?Q?daaOMoTeiY7QAoGIhYvqwacLjP3WLZDGuN5S9fJuTJxNZOP6l8PPsf9ghUN6?=
 =?us-ascii?Q?KPO8nSpchXaOCQsnHwPkwM4++Pka835aWBLV0KM6INaMPoVmyU8ZnTkqZoMU?=
 =?us-ascii?Q?WcIy2jm7zTHGxB4NPLVsXQVPRJ3kTImE3ZSnhPUtqNxSwYAlAx93qZSclvyZ?=
 =?us-ascii?Q?VJy+RRO4dT8bEG5d+T62q4KoW8NN3kt769dymqKJ66fZb2QNMrCVy54m7SSS?=
 =?us-ascii?Q?4sxavYJzQPv68RDy1JlKWS/dD5YCHNVrGFHF/GDB4dZlX1mXtpESfwOXh4Sr?=
 =?us-ascii?Q?UYaPAOaAnUQtS3agZj0yRwCcBJRcfkgtWxo5qZvrjB/NOIgtpELQ54V54yv5?=
 =?us-ascii?Q?uL6XehLT2AzyL7jb/VRWAB7vucSO2IMiincKqLGuAQKnKwjOi9wX8HEiXiiO?=
 =?us-ascii?Q?M8ZkhDdFCRZbt5R9/ctNzwxvYdDFd8xCf0DDbDWd5xY2TaZyozcmKPZk7Mys?=
 =?us-ascii?Q?1M5Ov+1fG95YK+xNsyL9mHjTcxg7TuH7JWn8z/JvDBnKNabRQO4gfYwnxMPH?=
 =?us-ascii?Q?RsHdG9hM4zfkje0wPb5ZXXiChtYLmqSgxssWYwltQ9MvaDI5acOS6Xs4a6vP?=
 =?us-ascii?Q?hcWqFlHcE3GoaahyuoUcCNto/XN53rJ2j72YzxpLt3shH1ZTc7jK6ArwQWKE?=
 =?us-ascii?Q?8Gzn/YGz1Q5/vLCHDMqOL1fxU7RRuOm6paqIFbiWUgMKNLNu7832SExtP4q7?=
 =?us-ascii?Q?5GYn31dEWajz44wwOfgDm1UFnukAuFy5tecywgeOIJnQUAK7jYXm2/5B3Uy4?=
 =?us-ascii?Q?ioyZdnpafpzB/KTWIjQGLfCcmuUIAqGM9DV3pQiNElUiknbIethD875LnSZe?=
 =?us-ascii?Q?Gz4uuoy10zyAFG+pXkR02Qchy9WhQK7zhaOFwORuvKTufC/+jiGYa8NZNo3r?=
 =?us-ascii?Q?1rq8rgCLg4Pw/K4fo5Yw9U9NU424MHrJ8rf00zaFT8FQemPsqZqRKrGB6db5?=
 =?us-ascii?Q?4u/57R5AN8FKZfwvq3KVL55OYzhQBzXJIFHFdfKSdUDM1xAu0kiF/+nddkGn?=
 =?us-ascii?Q?aYS8GK0alj0wm6ft+2e+xSnW/BIssq3foHsthr/eLEe6ezyqBZjaGsRd73dF?=
 =?us-ascii?Q?BALFCrxlPo0D9ZHQ4MjQKENdCkFJefg/7WatV0urUK7GyNsgfHLaG4tE8SaY?=
 =?us-ascii?Q?Ni65apfHP5SiNDsDTcfqGExWSTpnpA9pLWWDhqx6V7Rvo2F1sd6nvCDPBHvJ?=
 =?us-ascii?Q?2LVXLSc1JQMLdtoFeQR4j+aZODCd9/wkpjyLYZOmjEj?=
X-Microsoft-Antispam-Message-Info: FMBchx40pNiFe3x2Q6MiMDOSM1nuv4FxRANOvkih8UQhsvbCQaN9a7WRmuPDm9OOJNdIxG+oZ/j+HDyb6h3PvblyRoDuu08h5+RXWtRDwsGqRLYhOTaowQcy3P2CC5862CetMjNPtUc6gh8QW050qJMupZxL/0fpzRWLwDEbW5ObCDtPOWJacsLk8sbVbSJ6
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;6:ir6RrnUepzRG1xRv4kK/I7A7ZKt9oChdDdIALrghtfsmKM2QH3WBHCJHN+DpTax0BtILoAAvfeW8BPZvQ4zZFkSDCw/JYryTWdrL0MIRSyhTqnYnYaC3YUQRrOy56fgwgXTpZdPs55xaM9kIcRv8cvKiqJuxJ+D/NNbzTCwPZPi9VpSteK65hgwJWBrG4MfUHkieWSMznWMilv+r15zC1u+MANosovxikU6g+7jBFwJ7WFZTjS6pn7IMAunZDutl3cXkAKDzhRnrY9G40zZ26lrkN51Ls6JVUAM2/Y02AdO+M4R3H9dSzCUIb5lUp4OpQvKZOYEz26ouTuaGWqUwM29tgiMVfUXa0iG0ugMGXZh8dXQYAf1/pCy5O4+Di2L42kUED4VVWlK77u+9DxhHcKhUFRGNmoegX1lAXhl3SfQskr9qN9j+WGGSwD0dutxs6if3zxv7LKbAXYjk4KD3QQ==;5:X2hm9P91Y6wbYvQU77YRPCfyfsuulbYTk0lyCqK4mzve/gENEx1A2ehKP5ycH7tfiLjJa5zG4hy6C2D2E/kLNZEVCzHVwsmkUlKPp1DnqxnvRiYV1stJKHbTBpbl5VwPk6p2IhpH6qZvQetKTJbK15/5ULBBIGzzV3sxtFnWVKs=;24:pxsAH1mzJK8Z0zaCdKo8EGuxse0J9ZxNmO/zaxIfyOe2F3TJpL37NuahWC59Vle85PnRk0ovNoL2+0n+caYH5/OjJ0GKOLJL8CM8Wpy3CMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4698;7:wmetPysJzebdEwPdSQHruK+A3eqLgNZpeEnMVebm0hNKUa0H4/BNYUuU3HzAxS5Mo/XjEkTeg1kd1ObJnLcNJalqHYwLkT9TeGpl1UxOw8FrN6GqoJun05Y3/4LoRyewrnJ99yspVCyomWCHufFAnoTgra/xkyseB6rOW6lTd+EJelmsm5ZQDz3+aOnoPXj7h8Z76FM8uSICGiZwPLrpuCZsfMtPGtanT22sI5re+P9Zb4BI1k9VjldNQxBK/05+
X-MS-Office365-Filtering-Correlation-Id: 020c56ee-a99b-4ae7-bb66-08d5bb10ff1b
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 09:39:58.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020c56ee-a99b-4ae7-bb66-08d5bb10ff1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 08:56, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, May 16, 2018 at 10:16:13AM CEST, vladbu@mellanox.com wrote:
>>
>>On Wed 16 May 2018 at 07:50, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Mon, May 14, 2018 at 04:27:11PM CEST, vladbu@mellanox.com wrote:
>>>>Implement new action API function to atomically delete action with
>>>>specified index and to atomically insert unique action. These functions are
>>>>required to implement init and delete functions for specific actions that
>>>>do not rely on rtnl lock.
>>>>
>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>---
>>>> include/net/act_api.h |  2 ++
>>>> net/sched/act_api.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 47 insertions(+)
>>>>
>>>>diff --git a/include/net/act_api.h b/include/net/act_api.h
>>>>index a8c8570..bce0cf1 100644
>>>>--- a/include/net/act_api.h
>>>>+++ b/include/net/act_api.h
>>>>@@ -153,7 +153,9 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
>>>> 		   struct tc_action **a, const struct tc_action_ops *ops,
>>>> 		   int bind, bool cpustats);
>>>> void tcf_idr_insert(struct tc_action_net *tn, struct tc_action *a);
>>>>+void tcf_idr_insert_unique(struct tc_action_net *tn, struct tc_action *a);
>>>> 
>>>>+int tcf_idr_find_delete(struct tc_action_net *tn, u32 index);
>>>> int __tcf_idr_release(struct tc_action *a, bool bind, bool strict);
>>>> 
>>>> static inline int tcf_idr_release(struct tc_action *a, bool bind)
>>>>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>>>index 2772276e..a5193dc 100644
>>>>--- a/net/sched/act_api.c
>>>>+++ b/net/sched/act_api.c
>>>>@@ -330,6 +330,41 @@ bool tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
>>>> }
>>>> EXPORT_SYMBOL(tcf_idr_check);
>>>> 
>>>>+int tcf_idr_find_delete(struct tc_action_net *tn, u32 index)
>>>>+{
>>>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>>+	struct tc_action *p;
>>>>+	int ret = 0;
>>>>+
>>>>+	spin_lock_bh(&idrinfo->lock);
>>>
>>> Why "_bh" is needed here?
>>
>>Original idr remove function used _bh version so I used it here as well.
>>As I already replied to your previous question about idrinfo lock usage,
>>I don't see any particular reason for locking with _bh at this point.
>>I've contacted the author(Chris Mi) and he said that he just preserved
>>locking the same way as it was before he changed hash table to idr for
>>action lookup.
>>
>>You want me to do standalone patch that cleans up idrinfo locking?
>
> Yes please. You can send it separately, not as a part of this
> patchset.

Okay.

>
>
>
>>
>>>
>>>
>>>>+	p = idr_find(&idrinfo->action_idr, index);
>>>>+	if (!p) {
>>>>+		spin_unlock(&idrinfo->lock);
>>>>+		return -ENOENT;
>>>>+	}
>>>>+
>>>>+	if (!atomic_read(&p->tcfa_bindcnt)) {
>>>>+		if (refcount_dec_and_test(&p->tcfa_refcnt)) {
>>>>+			struct module *owner = p->ops->owner;
>>>>+
>>>>+			WARN_ON(p != idr_remove(&idrinfo->action_idr,
>>>>+						p->tcfa_index));
>>>>+			spin_unlock_bh(&idrinfo->lock);
>>>>+
>>>>+			tcf_action_cleanup(p);
>>>>+			module_put(owner);
>>>>+			return 0;
>>>>+		}
>>>>+		ret = 0;
>>>>+	} else {
>>>>+		ret = -EPERM;
>>>
>>> I wonder if "-EPERM" is the best error code for this...
>>
>>This is what original code returned so I decided to preserve
>>compatibility.
>
> Okay.
>
>
>>
>>>
>>>
>>>>+	}
>>>>+
>>>>+	spin_unlock_bh(&idrinfo->lock);
>>>>+	return ret;
>>>>+}
>>>>+EXPORT_SYMBOL(tcf_idr_find_delete);
>>>>+
>>>> int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
>>>> 		   struct tc_action **a, const struct tc_action_ops *ops,
>>>> 		   int bind, bool cpustats)
>>>>@@ -407,6 +442,16 @@ void tcf_idr_insert(struct tc_action_net *tn, struct tc_action *a)
>>>> }
>>>> EXPORT_SYMBOL(tcf_idr_insert);
>>>> 
>>>>+void tcf_idr_insert_unique(struct tc_action_net *tn, struct tc_action *a)
>>>>+{
>>>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>>+
>>>>+	spin_lock_bh(&idrinfo->lock);
>>>>+	WARN_ON(idr_replace(&idrinfo->action_idr, a, a->tcfa_index));
>>>
>>> Under which condition this WARN_ON is hit?
>>
>>When idr replace returns non-NULL pointer, which means that somehow
>>concurrent insertion of action with same index has happened and we are
>>leaking memory.
>
> Is that possible to happen? Meaning, can I as a user cause this by doing
> something in a wrong/unexpected way?

No, it shouldn't be possible unless there is a race condition.
Otherwise I would put some proper error handling code there.

>
>
>>
>>By the way I'm still not sure if having this insert unique function is
>>warranted or I should just add WARN to regular idr insert. What is your
>>opinion on this?
>
> I have to check where you use this.

Every action init function uses this.

>
>
>>
>>>
>>>
>>>>+	spin_unlock_bh(&idrinfo->lock);
>>>>+}
>>>>+EXPORT_SYMBOL(tcf_idr_insert_unique);
>>>>+
>>>> void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
>>>> 			 struct tcf_idrinfo *idrinfo)
>>>> {
>>>>-- 
>>>>2.7.5
>>>>
>>
