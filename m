Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeENStX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:49:23 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:40663
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbeENStU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:49:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-6-git-send-email-vladbu@mellanox.com> <20180514162301.GC2134@nanopsycho.orion>
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
In-reply-to: <20180514162301.GC2134@nanopsycho.orion>
Date: Mon, 14 May 2018 21:49:07 +0300
Message-ID: <vbftvradqe4.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0802CA0009.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::19) To VI1PR05MB4702.eurprd05.prod.outlook.com
 (2603:10a6:802:60::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4702;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;3:DxhE3LyIC8theu8QvWTMELuhhyyqCEWwy/AJT+86u+8K87bU0miCLvwoYD/IHhhNSSlvxP+3szRrj3Ki7g9mbxvjvBsopYa/UrUv1PZRpkoMHNymSUyC9kBgPk6wGe3aTY18kK835tnkVAnLW5uaDulv29wOIloN4UU6MtLvKk9tiQB9SSd3qNKJE0WQpKqD9JZMtByGouE8qvlmHVSjUAwORBb96GoK65tb/9O6wNnafSo6OGdYt9vfi/f8q+il;25:rCXNqJCYyY2Z0BZ6RTUd84NC55pzefL7BRHxQYPxjyWnAC43C31FjyjjRVmdFEjaBDxXB7kF+SLNaYn2gOsqiawfAtWjaTSAUhjolkHWTb1kPuGBCPPQp0ICzeOBA1t+xKbRWs+oVhIY/3qvpDDq+Waf5rBPsTxFDUeDGpYB5OrkplsztYxJXJP9Nj94631+R7IwymqYxovTj9zUofZQmUrVB+KAWmCciDVKLQGjJ6TiPZHhxYufN62fdCe6PMoeITOSibVK62hZxG6L02Wk9CYI2mDoPQe4EgI/U9G/R8aRbGWd36FqmY5UKJX1xUnWePhUhZt5+CsUZH3gczhDag==;31:K1gihvJpbBGdxTa9yCVnjxAx+a2fwBaB5RBndyOMQZqv7wpkW45vpLlGbR23ZIXuUjewadaEWawxUd//v1EiWv+bvS38g5csUuY+5K8NZTvIqBu8mk4HzRmDQg0rfMfEiLWfqWzBsf0wP4geKE0sq2JyH9fGeusT5IU7riscv23kwwcxLLvqlnriommkkp4+VUrfjJQunOq2eFtA3rjCgqxq2CLueTEXsppW5ejHI2M=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4702:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;20:BHRO0kVviUhxLejYL9OpSnmtTvYJfgWYcHAbn3jRJf6Bl6iNoqm067hfzFkUh2LVim5U2fJtrkNR6i5LV88owTITnwDu2enhW/NQ9wiqryPScoM+kLsIUxalIKHxerqQhk9Lv+iB8s9Yneg6BvfdPH8sx8RL5TVhvRUY5cFDfFbrn8xOxTvLSygirp4PbjaYD0EnvJbudHCY4C5gf+x/M1/URe3rcB25eqMZe63IFWf/+D/bHC2a6bujxvagUC9RMitcAyVTn5glW4ziS4MTo0IzUugVdGp0jjev3iNJOahz2pRI4scbsfaa4uuH7Tf/PqjyOsxfdxnaObyEJgTWPq20qsVjUWuypTMBkOfVv7soGpiEmXUhPG1g8fdMAegC13Ay+6ZvLdOcHAUsP6v9+22Irses+mOP2W0ZOHfrm1sw/cW/Md2Q4XF0x6LUP89WKQ1iywqrzV+evqYQZJ99mgT/Fkcm8ep+Su9MyMZjMeqYYdIvXPl1Ow+vzn/FQyE0;4:xOWb6ZhiBlL6SNB9ckGab2OV72CbkAQ9iU502qAk3jF8NA7TdJHsj5eduFEA8H6hPXxsPbgY4DJXowwq136G+aH1tB/a5qea8FP23dS1J99Y+WV7seEBZIDecYwTdOo1mgx3dwO0+SGlA2xz7c3vyVufo2d9zJOh8Pnuak41N5duFQeWMxBe5rZqstTgsRNz+6bamtvnNkO1NPp8F4A8keF1H+iQX4LFZ3aO/vtpmMuTiaYZhaMR91aDhR9IoYFfmGXMDID876NJaISOLBsPEQ==
X-Microsoft-Antispam-PRVS: <VI1PR05MB47029899E047E8C8F29BC000AD9C0@VI1PR05MB4702.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR05MB4702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4702;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(396003)(346002)(376002)(199004)(189003)(316002)(68736007)(97736004)(478600001)(5660300001)(6246003)(8676002)(52116002)(107886003)(25786009)(446003)(6666003)(6486002)(81166006)(81156014)(7696005)(6916009)(386003)(48376002)(6512007)(105586002)(106356001)(59450400001)(8936002)(9686003)(53936002)(229853002)(16586007)(58126008)(4326008)(956004)(16526019)(66066001)(2906002)(51416003)(86362001)(6116002)(486006)(7736002)(7416002)(39060400002)(305945005)(476003)(76176011)(47776003)(50466002)(3846002)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4702;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4702;23:x5iIgtzJG1dpiO9Gt6i9w3pCCHi+CZbNSHrtZcZUr?=
 =?us-ascii?Q?SzKYiFO6aEL1HcuubSQgkgWMBC+wQ/+J9E9cU9TP42O66gr1cW97KZKKh3k0?=
 =?us-ascii?Q?KVGBVIxjb8h0PoSxTejALnJPKieLlWDIVhF9hgD66XPivOglyFRn0KPJr3o1?=
 =?us-ascii?Q?FKUgTa0V95sFeP8xzhM3yMuKW6CXBTf0h5TKNWjbSQBzJu59l5NM0eUTZid+?=
 =?us-ascii?Q?ruaxobCJ6QcmGTDlldxYi0WrN7gIB4tWuc6pWh+Mlo5+pg11XV4To0/6NkUE?=
 =?us-ascii?Q?KOTogf+T4taO1ommHmYlIOmhWuN9LDQlFY1tFu7LFVgG5vfW+GLb7gDjMZ0n?=
 =?us-ascii?Q?xJekwKde366rB3rztwjfcYHljr+KPC3Sdw8fiCVPGOjyyzx1kv7o6bTJ394j?=
 =?us-ascii?Q?+ENshzpb+riF8uDOxUIJGIJjZa8vsRlqy9vWZfcC1gqpl3EEt1KRB+AwHGCw?=
 =?us-ascii?Q?9MzrrrGhKzjTYap41v3YY+jsR25utcVQvFfWpuNCapdoikU4mmE2M7A9/TlU?=
 =?us-ascii?Q?tVxxhobuhehj3nmqff1F4Z6Q3I3IahF5t+YaBAdbT7bZ9YNnSzhqJxb0xBWM?=
 =?us-ascii?Q?mbM66wHkJ7Mi5m0e5jwIwbVhB7ZR5+2ZwiEUGW4h4Zy2CombnUtRfVmtHroV?=
 =?us-ascii?Q?IUihaFxJTAed/keAjhn95Db/dLNMITQACvO3ObHuNklQf1iXzNYY5iArv2S1?=
 =?us-ascii?Q?copEp5cVSRWgFJl3g7zx4bMEE3epfJBoAZuEFxDjVfxtKkAu5EcQjuBbWmjZ?=
 =?us-ascii?Q?9P0e+e2eKAIPAsNwHzyoPFIAzrV4L8brPnpF+CWqwxASWkt21uOoOZF/LNrI?=
 =?us-ascii?Q?q0DMQHXGqsEOpGpXpY2E0s7MmSKG3jUrShKenou7oe/xuTSjweuvyxOK8fJ1?=
 =?us-ascii?Q?lHUfk+7mWbSrXbuPAcOHnGLsdZpmtrYPoXhUfM2LlTfm8eN/kKuZHGriUXu1?=
 =?us-ascii?Q?cFznu2aFWhWs6M6UavnAHCc9ulnxMKxUcGkVbaPb6gzHdNZqo3n7W82Ew9vV?=
 =?us-ascii?Q?ZHibw0zJgPzjL34dhf4SC7QFMUvVFYFdTWYQPcyoHlBsYYN34VBbL2bAKFX6?=
 =?us-ascii?Q?Kkxksg9nw4l6EOg9vDG1dC23/D4/S+8c5iqT4Zgqq/aRFd+pNhYqQJs3GTdN?=
 =?us-ascii?Q?es4AZQdx4YmOjkrtOUelNkLtyx23vIaf9RczQeieWLgzhAuavJGh0V7VyvzS?=
 =?us-ascii?Q?m1ComE8ZJHAMAP68P1eRF41yidg4YczkJN8vxDEfM9iS3gUMzGt1HptvlS7p?=
 =?us-ascii?Q?mi+ivAFXtbDD5lq+22JOqNX4IqqA8c/DXcg/GEb?=
X-Microsoft-Antispam-Message-Info: y2NQu3dB1rNn4VSe1ITSRT4noXW80yu4lOMJKgxXYUIAlPlLeyUYxWjYn6BezgHjzXsA6E38ePjIGodr6tCJpKrmkEtbhlIDkMRlFKzjJoBWaN6nU37aVp0nyyxtzzs+hut0wrm8MQzZDrF36VOOEIeIp9m3+/UD9CCcusEWEI/ZvlnH7KbL0WlOF5MynyhB
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;6:p1e+iKftKKkRBlY/GWo6JctbMLc28+iwFSVnysbp0LQjfWrJairF3ZtVbUxLEEO1Ao4VtpF9bU+6glQ7bRBoKKJ4DpQ/7jC8xvxQv/WpYtnxBbgiJfDA0VHT/hrVK5j3odoBGHpiaBPkkSk31lvo3dRDgdyyRorE9DhnojdCqsdl/Y2KxOvVi2TvQ2UsYZu4ijfyAIJMVVPdPQoCXmhSCtK+vL3h/Tf9pZwX+iBK5q9gFXiY7x48fJM8XdxeT/AfYmeckwsynH13c5VvOk9Io7WWIhydqtq9ehpRhXeU7r/av1mcwm9lhlQYUYCahKTTGfWPEWdRoSoM1rPH3Oygml+oXvLdf1whmNbnUx1rt/u4Adc6cafVX+EbDeJ0NVu3u5qsLt983/prvDI58A7+Yi3hpB72oQYV6gIT4ZnZdOiNnGHKYSb2JdbCA4OX0/Bx9qVEfJLBVQ4uAyWhgYvhog==;5:atJybLcSHmIhxNq9dhXXWRwyNzO/EhGJKEjq6Wmk46aDo1XCKGghtfzsHNnJG0txMcCQriFjv9BAE38wPPITgsvAw+LTzPNw28dTCY8WbPkYgTLfRFC0ZptkEKBkmC6tAGol1BMcc484Tlz3dMXmcdpR5rz66tiCUT2vAQvuiSw=;24:OIi+hSjVaYJBly9GpcopgGV1TlX/nLI/n15Rn3AIGr+h92AMMRAe5INmPVDwcmAE32HAJEjjHV/Y2/vu7TG/8UT28OMYEZ6VaJ1u8hhkLeQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;7:RiGWuetwUjzPCRiEguegQMqKotV5LBzU4ey/P/dLxtwNBkPYL7hYRiPpXBkE6EN22s1sIzQBOUwYBxSmh/Ct6fjbd20/6NM1hSRrD2SJfXPiB6ep1f0/6ZgQBniJpapmmAiBFYmAVoJg9T7bq6CNwVChhsCk38qdxLJiv5+NMnM+wIpdVnd884pnnccUFuQ5iCMHhB/7fwPzBZaoxawiRtsIBFsSeHvtwfMyeTbo7EJNal/YJmFf24K14rJ0xp57
X-MS-Office365-Filtering-Correlation-Id: 995328a7-7f87-458c-fc87-08d5b9cb6438
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 18:49:13.0623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 995328a7-7f87-458c-fc87-08d5b9cb6438
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 14 May 2018 at 16:23, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:06PM CEST, vladbu@mellanox.com wrote:
>>Without rtnl lock protection it is no longer safe to use pointer to tc
>>action without holding reference to it. (it can be destroyed concurrently)
>>
>>Remove unsafe action idr lookup function. Instead of it, implement safe tcf
>>idr check function that atomically looks up action in idr and increments
>>its reference and bind counters.
>>
>>Implement both action search and check using new safe function.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_api.c | 38 ++++++++++++++++----------------------
>> 1 file changed, 16 insertions(+), 22 deletions(-)
>>
>>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>index 1331beb..9459cce 100644
>>--- a/net/sched/act_api.c
>>+++ b/net/sched/act_api.c
>>@@ -284,44 +284,38 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
>> }
>> EXPORT_SYMBOL(tcf_generic_walker);
>> 
>>-static struct tc_action *tcf_idr_lookup(u32 index, struct tcf_idrinfo *idrinfo)
>>+bool __tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
>>+		     int bind)
>> {
>>-	struct tc_action *p = NULL;
>>+	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>+	struct tc_action *p;
>> 
>> 	spin_lock_bh(&idrinfo->lock);
>
> Why "_bh" variant is necessary here?

It is not my code.

>
>> 	p = idr_find(&idrinfo->action_idr, index);
>>+	if (p) {
>>+		refcount_inc(&p->tcfa_refcnt);
>>+		if (bind)
>>+			atomic_inc(&p->tcfa_bindcnt);
>>+	}
>> 	spin_unlock_bh(&idrinfo->lock);
>
> [...]
