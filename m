Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeEPJ67 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:58:59 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:30784
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752591AbeEPJ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:58:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-15-git-send-email-vladbu@mellanox.com> <20180516094850.GF1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 14/14] net: sched: implement delete for all actions
In-reply-to: <20180516094850.GF1972@nanopsycho>
Date: Wed, 16 May 2018 12:58:38 +0300
Message-ID: <vbf7eo32a7l.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To DB6PR05MB4695.eurprd05.prod.outlook.com
 (2603:10a6:6:4c::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4695;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;3:0bCih905Tds/vp9lqRVZUWWGsCtVhpYQa0nPPtDteajyZKMSmQsHmByihSbUX56ZxiJ9yLTFv3p2Gj3dJnfSekiVob207ryavAW/IB75TraDYODhgcFM95y7F3bKWEJbkF8mRN1kMxxG/XjbgNy8daG+KclRXSY/f9/36kMMJs9OrfBhrhyUZ+pDEUOwjeUsXdaRHWnM0RGfHDOBL1wIDqhh6Ar2u81k0YZgHA12wgjW4o8fnv/jzoqc+Ne9L7vu;25:i6XSIMJhNd3LEmC+r2fU54M1UkPQ+AWWfnf498SB2MdvNAaPMu3qBgBUqY7j1xx/hRwcVe0pOErtgjZFTW4o3J9IrM7Q/PQ9ZhSlQ6TzcDOVKPGFuwN7dDBc4yV7QUTx97hN4gP+2W2rxi7GR2NS+qCvuKs9ek6YtkeFyy0PDdCPbJu1q/IonGhYlTrFHoC/5VXuSBsDJybm7TQPY4cFuPpZr8+iGRRPkFKVAf9DQIXPTwMQyc8SClcBSv5DIY9mhxrvETeWllX+6J4GblTKgzIOz9c2S8+qZ37Pu0heEgIuZx6dLxxFQtHLYgN48C5zZOv5AgH1j7qHXKIQHdIk+w==;31:ECxj4YArAC1IAITsP0kyN+d0YzrNPJ/147B4p9ncQ/ynaoG2bg+HWeOCqSaQY8fIYvTQGgXxoS0cJ3nRapzmL29wjPY05sKKmxLNVjakJlYAr/XkXmZSnfpMvKpY1oIJGJYoY2KlWXb9d6tuj2CZz+igw8X4zgcvDPoLtMyO7RiIzj5DwSrABF7Khtq3CL7Veiq9VljOkfTpFej1q/tL7kNv0fGDivk2ROnPvlu5+us=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4695:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;20:HK55FMbqmw7aj5Vp/1sxd3WJ3QvMA4QphqH2ltWT4t7rIb536b9r85VyuwGKC/kesj87rtf7xunmjB13Fm6wIlKANfNoCqSySsnqI8OkxsiEBdYzc6gTjyhhGja0U5a5Qq+I7u2Dys8vbJm66nusDV4pLn6wrKyy8DtFlqymXpIMGNeqHJjiszM/l1f96HaXGogRhleQgHsd159lbRkvDRfMs1cVHmiZuw9NQEgU/2ALEYKugsQVouGU9tkN6Rj/1MSS5uV3YBervw4ANTW1enqGcNeBeOYM+hnwW4c6Y1l+USKN8J7eND9WSZctStWKskjLIjqh3NcVPlMZ4krq1TkYFoMU30w83kZfcRwgOAkzKType3QsbNI+VkTT7W4/4vuH6pO2fxj8QoZOyo5rLk7FBStYYFdGC6+3f8r/rWbSj9j0tW6AeNpR+3Ev1xkb0OeM18ubYglF2CPlbtCccgUquXuFZbGPKCswnRs+1QzS3OgfaPTssr9ZPFuOaNoS;4:H7KQCzpgJBAtnRbZjh2GXPp9tbO1Bmz+kgBpNozc1ppZ+l7CPlGpEc9Ef9F3e9Z2mI5YZp1s0dHs1h6YY9bAd3Ey6nOBTUjPixqJ0MLzEifeMkkIdzQX4d9dZgjfmt412HCIZgMk2GZQjlR10Cy4DmBL1S1T072QnyHWNgfkFZb4tu0g+Ch+KF/+cBkAZCafET3xoCT8GJsQzsjcjPMRRzCRU69Ne4bzvT2DWd8xm7+sr+0y4Y0jfFZ3sFTfM3L25v8qrlU7f1NnNeZiQj4vLg==
X-Microsoft-Antispam-PRVS: <DB6PR05MB4695A8DC26F75666D5782847AD920@DB6PR05MB4695.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR05MB4695;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4695;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(199004)(189003)(11346002)(446003)(476003)(6512007)(86362001)(68736007)(52116002)(4326008)(7696005)(9686003)(51416003)(48376002)(5660300001)(50466002)(76176011)(6246003)(486006)(956004)(6916009)(6666003)(16526019)(386003)(39060400002)(47776003)(66066001)(59450400001)(53936002)(229853002)(6486002)(107886003)(26005)(106356001)(105586002)(81166006)(58126008)(3846002)(81156014)(8936002)(6116002)(316002)(16586007)(7416002)(7736002)(97736004)(305945005)(2906002)(478600001)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4695;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR05MB4695;23:I+LRQDF7LKwr7bZvrk27FUu/qED9CRWoruKHmdlA9?=
 =?us-ascii?Q?pPG0SK8Rg+TN7nxW5ns1/3wLzDoMLw7mFmhaTSfzKeFMpa1/SBqZjcUIbkGh?=
 =?us-ascii?Q?9GPnqH5ooW+Co62JnuBQGigx5+WSkrvx6u1tw4/NqPR4sbfky0N8ROcpiqxt?=
 =?us-ascii?Q?j5g43NKYx8SuODDDaGNUisr5gOmBinkqvunQTifJSJXRhgl0X4RE4ucmOb69?=
 =?us-ascii?Q?/CBQZ+MPtCM0DznSywhd5/xQgYx8r4AE4ydE0maUrgGBB6HGRfBeOTU0HXJP?=
 =?us-ascii?Q?3VkRblmYKmNTICZGI83lBMh2IcScwRFTtjmY/PXRl2vCgt5+TGFGbS5MO8GO?=
 =?us-ascii?Q?qGcpP93/D8tXhi9so0ahnaEfd+7sJXAe2X581MvbHP81rLeEXENjvqJyZjqi?=
 =?us-ascii?Q?DUdxFDlD8TWU52SBL3QlOsZgTZU919VK5kIbqP5RruPgzLljucuarAmXsLmz?=
 =?us-ascii?Q?GuJ0AryzBLRRtUyH8D0hTpn9NyFT7UDLi0sBLqSk5KPdx99cwwRKlEt9c1Db?=
 =?us-ascii?Q?KPV0FI2GvwRjLi79KKr6b4EpA4aLqDV5akbFMM03kbzI8UUmkd52ksQbfvGr?=
 =?us-ascii?Q?sHaKmc7OG+Ovl9Y6bk004pyIAt2FWNOW3Qin8P6nc0q+Vz1h7zmP0qh2wxfW?=
 =?us-ascii?Q?eDerfU2vKkqh9p15qFU1l6AwhBymRZaWlqeqHRETjDKXLy38QN6k9POY12A0?=
 =?us-ascii?Q?dTZ8ezNh9qCEuIa21PXmgdlHcDo8/FTsAQ/17mdhwPV7hqYT0l2z7ht9eQGx?=
 =?us-ascii?Q?G6rCSmVv0mrHyXMvAJ92lN/nLZr33NhOTik84QxY/fa5eBjOuDv/l+Ru+YoE?=
 =?us-ascii?Q?pu+O4SLr8ZZFJizgIawDmTh//oetY4lNtXAxdof4SelZTKoHBt0NJ2AZ2fol?=
 =?us-ascii?Q?ybZGr/iOnPdbfhJjQVeV2YhjaQc09iaSbApzMjJmQeHlD58N/iZfNe2+ok3S?=
 =?us-ascii?Q?cJqTYd38GgVFq+QLAjF6h8859f4ibc/xHSMxXxPVL0v/ka1dMros9QWGJzdX?=
 =?us-ascii?Q?JcWRUHmB505OnYNG/JZIow8zvqNNmHmHTl9GbLSHNZtR30Cg4Q7oou08Ytb7?=
 =?us-ascii?Q?YfGozZKQ/d4cN2Wa9mZYt/lP/vynxAk/1XHfL2S49u1tJEeMq9iOtxhhbTQA?=
 =?us-ascii?Q?Z/vvrqwXDSiGa5XR5zI/XeRHpHhuwanq+DU6xj1o+W2Aq6DH3OQ7udTJgyEZ?=
 =?us-ascii?Q?9v0rZyKoG3P3AM2P1xjHST73WePygy+gvJT2shrqidBhIdmhrW1RD7U0dGD8?=
 =?us-ascii?Q?70cil4STcG2mvllgJIn3/rio+3pmjFwt0eYj3QM?=
X-Microsoft-Antispam-Message-Info: x9FNiwWnJXk38FYdS0Q1+hAxRCypoqwR1+HT6Q6kBaMFqh/uBiZI+ZAi39pxAwBNDRtzK9QLY7JxrOE8OCWuUrKNmot1l/kyiR0vVB5tglDiT0y+m0MIQsDIukvRLjtuZL/kSE9Nb/JsRb5NMIPe/TkQMD5K6odTJ8+v4L8ZQFYp9B/UprCz8+wJE9sKr4EU
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;6:1LEFdDdSXBKy475vM8S4nLuuCy3rLg19I16x54luZ5+E8z4nJFagQjPJ6FSCQEwxztowkWD+pfzxUDnlPQmm2ZP3L3YTYK4Xl69QGyE+DRrbzh1dqPbiccS11gNnTW3aTdyjDEcl1Gi4Y6UUfd1HKx9t9QD95uxrrHRbtkHM8ictweGUxsNv/N/X0ZlN91g44oKg+KX7ls5X7V4dGV0c8n8TtMKg/gXbp9HBuDbq7aXP0EXIA04KRqp6E864SWgy4gpirRG/ApOp/LVhalCt9NRl1rn4i0lSK0mvo4mmM0IorGcaJaa5Ovh0pH57685xctVqhcyJMpkdFZA4I1XYvIwJii3UI231sBCnpBLlcnnnTl4RYofRYezFTBxH06Ug45eyeHsVcr8/DTjbQ+Gd9J97K8kb0Hm72IoOpM36pYElpBHYFK2lpnSNx15Pdb2WoO6laBF4nRrtbPamu5RRcQ==;5:QtPtlbkJnhoo1+ySZdUbaIXZwt2VKd7WIZ8jBObZUMWkCuRd/zNX/CRJ3ps4QCRa0bm0TxXTxxBo+Tk4sgNAetLckB1Ilfk+9ZYeFrgLecXhYsW1aJCItyp1sAZn5bKJJP0fA76K99Pju9lbepa63gMCcCgqWMZsW2/h+A90Wlg=;24:TROmE442et664/2a5jP5T3PnA7mDW4UXgP2bPWbW3+5XHr3KKVaHJEaImjeCi39q2e3Y1XsbTLQsmDefMGpZfduKtcwTSkLCcCmTy00ILpI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4695;7:lRkUv2h0IWpcEYzxoywS6gKdFI+iI1+KUC8ccDN9u94U9NFfOwkEZljcjbx0tSY3VICjTcCOokS7pogBF1OMoL6WTsisOUkCkVekSyNm7yxvrL0CKgDaYZH35JFzOIwZYUljNZ7Qp2gyRTXT1QKubryQQGRvU0X3Q0cGIKJW1gYHYSxLwIvrWf23CNep943MJgvoG74O3e0w8XGWITMFxkO7voF7MUeTxK2eMa2ILAWetiHd/gBDYPAOwUkYAj1V
X-MS-Office365-Filtering-Correlation-Id: 42dc92db-b856-4b93-39a1-08d5bb139e31
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 09:58:44.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc92db-b856-4b93-39a1-08d5bb139e31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4695
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 09:48, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:15PM CEST, vladbu@mellanox.com wrote:
>>Implement delete function that is required to delete actions without
>>holding rtnl lock. Use action API function that atomically deletes action
>>only if it is still in action idr. This implementation prevents concurrent
>>threads from deleting same action twice.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_bpf.c        |  8 ++++++++
>> net/sched/act_connmark.c   |  8 ++++++++
>> net/sched/act_csum.c       |  8 ++++++++
>> net/sched/act_gact.c       |  8 ++++++++
>> net/sched/act_ife.c        |  8 ++++++++
>> net/sched/act_ipt.c        | 16 ++++++++++++++++
>> net/sched/act_mirred.c     |  8 ++++++++
>> net/sched/act_nat.c        |  8 ++++++++
>> net/sched/act_pedit.c      |  8 ++++++++
>> net/sched/act_police.c     |  8 ++++++++
>> net/sched/act_sample.c     |  8 ++++++++
>> net/sched/act_simple.c     |  8 ++++++++
>> net/sched/act_skbedit.c    |  8 ++++++++
>> net/sched/act_skbmod.c     |  8 ++++++++
>> net/sched/act_tunnel_key.c |  8 ++++++++
>> net/sched/act_vlan.c       |  8 ++++++++
>> 16 files changed, 136 insertions(+)
>>
>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>index 0bf4ecf..36f7f66 100644
>>--- a/net/sched/act_bpf.c
>>+++ b/net/sched/act_bpf.c
>>@@ -394,6 +394,13 @@ static int tcf_bpf_search(struct net *net, struct tc_action **a, u32 index,
>> 	return tcf_idr_search(tn, a, index);
>> }
>> 
>>+static int tcf_bpf_delete(struct net *net, u32 index)
>>+{
>>+	struct tc_action_net *tn = net_generic(net, bpf_net_id);
>>+
>>+	return tcf_idr_find_delete(tn, index);
>>+}
>>+
>> static struct tc_action_ops act_bpf_ops __read_mostly = {
>> 	.kind		=	"bpf",
>> 	.type		=	TCA_ACT_BPF,
>>@@ -404,6 +411,7 @@ static struct tc_action_ops act_bpf_ops __read_mostly = {
>> 	.init		=	tcf_bpf_init,
>> 	.walk		=	tcf_bpf_walker,
>> 	.lookup		=	tcf_bpf_search,
>>+	.delete		=	tcf_bpf_delete,
>
> I wonder, right before this patch, how the idr index got removed?
> delete op is NULL and I didn't find anyone else to do it.
>
> Also, after this patch, does it make sense to have following check in
> tcf_action_del_1()?
>
>        if (ops->delete)
> 	       err = ops->delete(net, index);
>
> Looks like ops->delete is non-null for all.
>
> Seems to me that you need to introduce this patch filling up the delete
> op in all acts and only after that introduce a code that actually calls
> it.

Already moved this for V2 patchset to:
  - Add delete callback to ops and implement it for all actions in single
  patch.
  - Move this patch before delete first use.

Will now remove the conditional as well.

>
> [...]
