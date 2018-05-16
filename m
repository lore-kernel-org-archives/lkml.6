Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeEPIQb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:16:31 -0400
Received: from mail-ve1eur01on0057.outbound.protection.outlook.com ([104.47.1.57]:26800
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbeEPIQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:16:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-11-git-send-email-vladbu@mellanox.com> <20180516075000.GC1972@nanopsycho>
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
In-reply-to: <20180516075000.GC1972@nanopsycho>
Date: Wed, 16 May 2018 11:16:13 +0300
Message-ID: <vbfbmdg10du.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::33) To DB6PR05MB4693.eurprd05.prod.outlook.com
 (2603:10a6:6:4c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4693;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4693;3:lETPdXBHXsNvTwx3vEJ1Qn85WLEzFZhsBLESLH5iEcUKYW9rh+emrtbupZp1MJlSTL0esU4LwrJNFWBtq4D1ryCB8NyuNziGgjdPYERRKkINetMgg08ZCOUKVF75KlMl+703xUeFWAJy7ITGnoSA3nC7P3bGuLsqsYx3L+6IBkWWN3CtIJ9BTVqiom2NR+tJzdPq+XJ1h8i9KZjZKcJr313pcN0ts2J9Udtw28m5QaX5QrB7GsOBoEjDmrOUHLDf;25:ZHZAcdjR3jA8j3Aaa3Ro+xdLgCI6Prwj5eTX79lXIZqhi2qJyxmkHx34nUnsxHOR10yq787YjdhUYGqlowZkCPGFHHv3PAAvrJN0t0SthzayVqIKmeUumZK95TrXyTKCOUhcwNc+vahSwgwuL5r6wCVvKCkVJ2I7dS8DazOSPCZv6XcdStAOZ14ru8Grh4+2x9mJVYmvx58zaKaHIYbIaiIrLTXodAE/E4rKOdlIDy0j2VfbCoCl8ae1rgJwTCnssgFEUaZp+W8oKE5AJJt3XA+tuv2tYYIsL0Te+vUFAQqodWxGcQsaIgo91Y+hGJXGh1WXCnj8/lQZR7a8OUTwfQ==;31:KL5A4CaFZ+p7QKmyThl+FLkSc3imJTWszMaRt/3KwK4Vc1edlEYlqGnDOBWw13N6NiTeg0ym1L2Phz4ToTSpe3Rez+VQNXmVQJDtFwpVjSHF2jwwX/zRAzDi4IxbND7B+uMBtHkd7AHk+B00duO4rjdFr4ZP86FabFjGfackyem6WRy8HKwzYLcQ2ZnWJaurTyxcYorltVKLRsCQ/Q5mlLLJXy15Mlg2dCttZ0zZDJQ=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4693:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4693;20:zqCGsPDZLSBVvbAGIgX2Uk+WM+s9rn1aaWNPcJsnYUOwVDmcSwt7RaAPiytJHc+Hg55opfUM8vLWHx/Cc6Cer0N1ADR/HXV1gEwKMOcz9sr/CiN86mx92EL34G6BjhJ22KluB8WxL6CcfMvORoDsJS5QrpAtoR7uLgqVhc1SlWKqcwB5yYapVnFwsFON9bwCN+s/dxUIF21HwKjjbx2yif5Lgj6QpcZZEM3nKTbwzLaRnBaXYzM8pEHIVGNuMCbU6c+/BQLrxW4vVapRROILfwfSl/ieQIPo4K5TvvpswdpW7ul6F9L68lhUPgr9Gh/T38zOlMDGg30NhQG5FSLk8fA8Vs8Vddxe+hldKGzaB9RaDt/ArQ181R0ljEtZ4n7emcmrsfogkXPVefRBffbZyNNwYj42FX4WyEQH7GYqCUOt3rLy8URE/uRPC/A/sRl16tri5N0ra+DiVYPQjEon9eeI80C+8bviTZcCGJIp6nREiWsMjPA5yBON++sl88ox;4:NXSP+/A6oeoKxhCaTBbrjXP0q6n5rsE8ogxqzPlIadQToQHdVRhYs2n1W3IRgWouRRvz73brcvz/UyZPEeRZtV8FcyIKcw8bn/XST2fJTOaewpPlfkHgWw+S5ha5ya8a/Vtg4idILLwr5gDVrwinZ7LvQqdtFqpy+T0EjrfxMCSA5nCAO9BB5Nbx1WWiXZIP8iwrj2UOsEPOW58DrEsirJaM6zIGap5+7Tid5u65utzQJtabKDE90fdu4Ui0v+d7qLaVJvo5gluFSTIveABXm2/tOEwrTAYzLEcHPielCtAYfbtjQIdf/V+TY/yd+VeQ
X-Microsoft-Antispam-PRVS: <DB6PR05MB4693BCBD9E55E876626992B2AD920@DB6PR05MB4693.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR05MB4693;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4693;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(346002)(396003)(39860400002)(189003)(199004)(54094003)(107886003)(6486002)(478600001)(575784001)(7416002)(8676002)(86362001)(97736004)(59450400001)(386003)(6512007)(9686003)(6246003)(39060400002)(6916009)(3846002)(16586007)(53936002)(229853002)(105586002)(6666003)(316002)(6116002)(58126008)(2906002)(106356001)(4326008)(5660300001)(68736007)(26005)(16526019)(956004)(25786009)(66066001)(476003)(47776003)(7736002)(50466002)(305945005)(7696005)(11346002)(8936002)(486006)(76176011)(52116002)(81166006)(51416003)(48376002)(446003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4693;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR05MB4693;23:NRuy/8mFM1DIIApbDoWTAt5sTeqdm49S0ZNSVGPD4?=
 =?us-ascii?Q?5gAknBb09XWYCiGi2O5Y56j7PTu/AwRtLb/qWjUxEZVmP4m8XWTimohlVKrq?=
 =?us-ascii?Q?EThVYCpYBbBDAqXBxsuhD8qJ92scbn1V2xXdqnHNFHWlO27+9Lw06Q51DMgM?=
 =?us-ascii?Q?pYO3cKvCs4WrJKEY7/qy04Yv/uQaSs5gmMCWWpLiXnbztTXWfyvBBdC+spDI?=
 =?us-ascii?Q?5gl4npKAZtXZ8yBqO/eky6EXBSDJ/ydPyO/GtK5wqjlSuZS1GOXEdxtaxtuD?=
 =?us-ascii?Q?0drgOr5ifyDzxbZIWdAEy9fd1cOPiYzydGIVJELA2gPeF0a7Qy1E4OPQCV1b?=
 =?us-ascii?Q?QVBubVc/cEVRnAbLysX7AAKhWaxXLOKxYdLKlYY4HknsYVOry+nAn2csnNqA?=
 =?us-ascii?Q?atcK3nfzejIdP4HNKxFKXjhTtdpXP9yDohRPuXwYJcJKHPnHFxqBYbIOz6N6?=
 =?us-ascii?Q?ugiKZXNzYZrNvxLIP6CCatYaxrChslJ/hCn0ZMnKnAKEe4Yx2jgNvOutovzC?=
 =?us-ascii?Q?1u31SoL/uiEXKz5RIrgH+yUIbKKq8C6QiYb4wo60i9zJcSlDdIhgj6AqPihE?=
 =?us-ascii?Q?p8uJC7cVuIlBqoSjfxO/98opKQ0cLPlw++MD4D57q9Rx+of1+OQMiK5tzBkS?=
 =?us-ascii?Q?+iIr3omfYBe4yR8OpYvCN9DNObn2CkFB7NVrODJWxO6egmjPy/7bTanhSlUH?=
 =?us-ascii?Q?WvqUM9PmNorpIW3G1voCFIJnFmNhUMun88r6fjTlfDeYivSN1avTMOqHXFrT?=
 =?us-ascii?Q?zjkCg9tapMo3QXWbIbgYKdX8Ek3DTLiAX+DuLh0dFRlSguJ3r4sAK2NnYDBO?=
 =?us-ascii?Q?z/sCVUMLHYsJcN3zLq/tvcRtneMbC4CCD0maEik1qS0wjdtU5fYe8+ksw7pJ?=
 =?us-ascii?Q?SYqTxXB+1O/MmM49N3nx/eoz2bBZ2XLJYiDk4C+nKaZV8s7Yksta3/5rPr0q?=
 =?us-ascii?Q?gU61zAxpvXUW5Jm+DHnL4yMEUTyZKj+YUHMrJNJHpw5vMI9RbpsZ5EVDQQYa?=
 =?us-ascii?Q?O2QEEnBY0fWP6edKTLFkPWvB2ST/5ONkO3qeUymUT5SSbJdID1IxUi5dXj9n?=
 =?us-ascii?Q?hJTd5oPZUny3nJo5kpS50JhPiIFwh4IBaQv54LPEWNDoZ8/JL0oohFZ47wot?=
 =?us-ascii?Q?70jfp13NyqfJhV+p7ZUNlJ9FoG8ehnXHpU8DIUfjF1gd+RtdWNkeqfmjqpY2?=
 =?us-ascii?Q?fVtBzHlfaB5qMxt0E8gWUq3s3mfLR3qG/e14HSDEqcM4d6HH5ljSX5447Ezj?=
 =?us-ascii?Q?F1bDRgcgMxMZT8QQneEwsqOVCXILQrgwJOMQqyHeERPp385Mkvwj3tEwPeLu?=
 =?us-ascii?Q?JNNpLoatJXhU099E1vZ64w=3D?=
X-Microsoft-Antispam-Message-Info: nWmxcjoE13SOPC+jKszF1sIQuzI5tUOZ1/fFX/KEL8ccBdQWb+4sYrJfqUWyPlk/p5DZMDQTLEygwrHb8c/1gwrgZ66HKjEfEI9Nlcz8DuMT2Z5qS+1kIw7QdMxXkdhcJk+43LFqI/yy3iWLob3xjVZfQugNiR7m/VYCIUijjBKlTsMyXb18sWAXYAYwaL04
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4693;6:ha+ZUy+XjY5185sm1pqJQMWakNhoPNxuq9HQ9enVtDxqdHbCM89nxFQEPFIX8EJw4daoH2+PhFBOcNayKzq2bu2zKUzIOzqdI+tmcGuuo1kcWcgSGJolbk9rbK5cUUixIp8djfOwguVzqB811tIjHeKzY9IRjnXz8QA3hG0eDfVHB3xb2yLF+QpJ8UZ3E8hwgbSZLGzEQAVRAEOVa08EK/D0Zm2IgHBRAJkTsH9PzNOe5OccfU0b4P7Pk2nrnFrAnKpgKWPH8vWyZcmev8dIXgmHr9y9J9Q2OilA1Hu/Fo4pDsv2EOnCOLt3vGoJ29Hqm5wNmIA3weaa7aQqIfmSNAo1hxRzltUBO+J44N5JKQiE9VTtBQ1hu0+rVoifqIgiUCLa7dNDiM9GXXFOUA5EOEiLktVpN2Wpw2n3LR1+qIexdgCOJBbxYo7eQoO7Gf5PY/wwPirEkqWR+GBG/VhW3A==;5:esPAKE5BtGj5JpTpS1YOJi4hRwoxTmBKUMlF54NsKBTe0+zbx/0qQhVf1uAN4n81aK5cPFDbzWsOl8z8y9SyioMAXxfjfWTUrlFrA7m4UoJHk+/95pkts4zNuoUX8pS/RB8vPYBAEYINmaZ03je6scB7XHjXU0mFctoEAjoONMc=;24:YMA3qf4AoCCgwOWm6CZmc4n7yDstoq3kTMax4ZOStKiVC4cUxforXLex3iJKuZx+eZp1IblWann9EMKs9YxZyWt8PcIhsL732Qy6hiCzK1E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4693;7:UUALsGeqlkMz9E5B7piZkhuM/lDVrzx4EhyUG6FiXZUSMQRGAF7Ejvd/hmYBVDbXPqY2E3su6ETp5JPUa8VWj6hU6OWZL+N6KkME36mR/nwf7hPLWFebf7M8SMVe/CvXCJiyF+O2B3u/0eXUOiG9kMJlisxg/zr7UxVdr21ggK9J+oJrMOvrthqm1kqosfa8LXwqztOtbpVpAfUWOmhk0RT63AT8RvTSbXojdcAbkthkQOALCXB/MSMxuiya/aCY
X-MS-Office365-Filtering-Correlation-Id: 4295ace4-8260-4ba9-d73f-08d5bb054f1b
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:16:19.0341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295ace4-8260-4ba9-d73f-08d5bb054f1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 07:50, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:11PM CEST, vladbu@mellanox.com wrote:
>>Implement new action API function to atomically delete action with
>>specified index and to atomically insert unique action. These functions are
>>required to implement init and delete functions for specific actions that
>>do not rely on rtnl lock.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> include/net/act_api.h |  2 ++
>> net/sched/act_api.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 47 insertions(+)
>>
>>diff --git a/include/net/act_api.h b/include/net/act_api.h
>>index a8c8570..bce0cf1 100644
>>--- a/include/net/act_api.h
>>+++ b/include/net/act_api.h
>>@@ -153,7 +153,9 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
>> 		   struct tc_action **a, const struct tc_action_ops *ops,
>> 		   int bind, bool cpustats);
>> void tcf_idr_insert(struct tc_action_net *tn, struct tc_action *a);
>>+void tcf_idr_insert_unique(struct tc_action_net *tn, struct tc_action *a);
>> 
>>+int tcf_idr_find_delete(struct tc_action_net *tn, u32 index);
>> int __tcf_idr_release(struct tc_action *a, bool bind, bool strict);
>> 
>> static inline int tcf_idr_release(struct tc_action *a, bool bind)
>>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>index 2772276e..a5193dc 100644
>>--- a/net/sched/act_api.c
>>+++ b/net/sched/act_api.c
>>@@ -330,6 +330,41 @@ bool tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
>> }
>> EXPORT_SYMBOL(tcf_idr_check);
>> 
>>+int tcf_idr_find_delete(struct tc_action_net *tn, u32 index)
>>+{
>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>+	struct tc_action *p;
>>+	int ret = 0;
>>+
>>+	spin_lock_bh(&idrinfo->lock);
>
> Why "_bh" is needed here?

Original idr remove function used _bh version so I used it here as well.
As I already replied to your previous question about idrinfo lock usage,
I don't see any particular reason for locking with _bh at this point.
I've contacted the author(Chris Mi) and he said that he just preserved
locking the same way as it was before he changed hash table to idr for
action lookup.

You want me to do standalone patch that cleans up idrinfo locking?

>
>
>>+	p = idr_find(&idrinfo->action_idr, index);
>>+	if (!p) {
>>+		spin_unlock(&idrinfo->lock);
>>+		return -ENOENT;
>>+	}
>>+
>>+	if (!atomic_read(&p->tcfa_bindcnt)) {
>>+		if (refcount_dec_and_test(&p->tcfa_refcnt)) {
>>+			struct module *owner = p->ops->owner;
>>+
>>+			WARN_ON(p != idr_remove(&idrinfo->action_idr,
>>+						p->tcfa_index));
>>+			spin_unlock_bh(&idrinfo->lock);
>>+
>>+			tcf_action_cleanup(p);
>>+			module_put(owner);
>>+			return 0;
>>+		}
>>+		ret = 0;
>>+	} else {
>>+		ret = -EPERM;
>
> I wonder if "-EPERM" is the best error code for this...

This is what original code returned so I decided to preserve
compatibility.

>
>
>>+	}
>>+
>>+	spin_unlock_bh(&idrinfo->lock);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL(tcf_idr_find_delete);
>>+
>> int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
>> 		   struct tc_action **a, const struct tc_action_ops *ops,
>> 		   int bind, bool cpustats)
>>@@ -407,6 +442,16 @@ void tcf_idr_insert(struct tc_action_net *tn, struct tc_action *a)
>> }
>> EXPORT_SYMBOL(tcf_idr_insert);
>> 
>>+void tcf_idr_insert_unique(struct tc_action_net *tn, struct tc_action *a)
>>+{
>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>+
>>+	spin_lock_bh(&idrinfo->lock);
>>+	WARN_ON(idr_replace(&idrinfo->action_idr, a, a->tcfa_index));
>
> Under which condition this WARN_ON is hit?

When idr replace returns non-NULL pointer, which means that somehow
concurrent insertion of action with same index has happened and we are
leaking memory.

By the way I'm still not sure if having this insert unique function is
warranted or I should just add WARN to regular idr insert. What is your
opinion on this?

>
>
>>+	spin_unlock_bh(&idrinfo->lock);
>>+}
>>+EXPORT_SYMBOL(tcf_idr_insert_unique);
>>+
>> void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
>> 			 struct tcf_idrinfo *idrinfo)
>> {
>>-- 
>>2.7.5
>>
