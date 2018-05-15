Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeEOJQ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:16:29 -0400
Received: from mail-he1eur01on0060.outbound.protection.outlook.com ([104.47.0.60]:52496
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752357AbeEOJQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:16:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-7-git-send-email-vladbu@mellanox.com> <20180514164753.GF2134@nanopsycho.orion> <vbfsh6udpk5.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180515090357.GK2134@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 06/14] net: sched: implement reference counted action release
In-reply-to: <20180515090357.GK2134@nanopsycho.orion>
Date: Tue, 15 May 2018 12:16:10 +0300
Message-ID: <vbfmux1mg85.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0602CA0019.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::29) To HE1PR05MB4700.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;3:NcZERJGIr36AsfsljPBi4PpNAZ13pTDYNLY2FLGukf42dZD6QUclw3EoQjHES5FZtdkKHt3G05pc5zpWxuxY46WRAQ/Ff+xtwZrceLQM/1poBny2OTkpzgyEr1hDXbQOBVbu3YVs5JZyuloFWpzz8V8mCZiEfFw6lcex/VECus6xp0cZ72pLRK83E0FFvpM5knmTdf9ikNmbQhHL7eJPr8jy2r3ot+g58Ha2Glpo58dVeuUfuxjpKOM/b5zOOB7P;25:/VlClGEPdkETp/yAhTEc59l4A8VMER8NQFiHj+xXi2V/tdGKJejU88FU1jsm7PxyLRm1gHYHgc5QPquoMJ7jP+8bXP2TeE6fLiuooEau/nAb3N0EiiG1V1XyZhDOpdQ+DaZI9Kz7073AUpDHjiv14HNst23L0B5FgnsElF05YQ338tORqHfKFofLwMJeBgQdC5B2MKYhXnjuZ0RQGI1fMRAI6z/77P0Pne/jAbzt01+PXLfkijHxjgCNVBXUEwC67sK3DKflzIb5AEUZXYfEQ2mJA33dwMvng3O13LsLRQml7cJlYwvheYtveKonD9aevXZmDh2eC43Kbaq4+mbncw==;31:DksXeklN3yvWWIk64T1VYdHCjVsP/NwE9r3LrZ9RybaR/sOvcmSpD79IZf24rOR17S2AwJOI34vZxpf7MB9swgvlObTmB4TPfHGyjCPwEdKiz1N+huWakQGj7FIk4T38FAom9rUdphAGbt6FYxGj0XpnMqoIWolLzE+vqdYjByvO0bsAf9jITfan/kV6fayfn27ZfyTxQoeLq/8tPcaHZzhPsPGbfJ3Kyl00Zcr6l4w=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;20:Ym/c9QGeEhgZXHiui4qVZOPf96+8/NzQVhXIRXSfDdWArS2IbFa8V21QTf6NPKI8rgjehyVHJIBVMcY+o8MZ8sUG5XGaJsNqkt2iv30Fppy2PXU02URxg8GTFN4QLI62EP6N9PRJ34BaZLskKbGe6rzAEu39T92Y8vel/VXOFI6NiopN/FbL11nPHyaeOaCSOFi6sgyCP++wEngud1Eul7u2mSuD0nV0d0YSMuBsSSROdNpupibnaIz92FL6CxWl5z1pCYsOBMMzXCjgE8enXmKVdevQVTDA7dfdO/4pfRSqNUgU4NmaGcvQzIxhuPYKbectB5HyAbz+kWIudg1xJWOI48dpfbDNV+gsLaUeg/8drIvoQnwiUajpmPdSnb+IhEAauxu3YUWWs79krOyz/lzJa20X92oMB2GB7FrbM8zUthl1VhvxqFp6njaV5W73yS08LN2U1iRdj6juLiYQXCjHotNo13vp6s5WDdx7sb1MXPmv492xxLhkFTKlk9Tk;4:/6PRn21bkh/GhIbGBera2A6GRJf0AmW6jxeCRUEaXrwZ0SQCpkNRno5ET863qR31OykG49IA/Php9qXzYYpYXWG2UXb16BgZALjyZQ2r5Lyff5aQl4xa3RpWjFCMU+rCrQYoxFhtcu6c9/+cujsPbgx43OPtKAx1T2De5YVPjaBoIw5dLcqhpDxaAlkaJa3UDBoQWtHG7LSeG97g1kzuiCqBv0UgZCVIgMHAoXRbSPUw8WCiapRt5qZ4yd5ShLHkBhGeYS6yysSasf+Qd9ZqVw==
X-Microsoft-Antispam-PRVS: <HE1PR05MB47004AC4B3D9337FA8541757AD930@HE1PR05MB4700.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4700;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(189003)(199004)(81156014)(6916009)(105586002)(478600001)(106356001)(48376002)(50466002)(305945005)(386003)(11346002)(476003)(3846002)(6116002)(7736002)(446003)(486006)(59450400001)(956004)(8676002)(93886005)(86362001)(6666003)(8936002)(5660300001)(68736007)(97736004)(81166006)(6512007)(6246003)(9686003)(107886003)(25786009)(6486002)(7696005)(47776003)(52116002)(66066001)(26005)(316002)(58126008)(2906002)(53936002)(4326008)(7416002)(51416003)(16586007)(16526019)(229853002)(76176011)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4700;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4700;23:YkzROUrpM21M25dGidYgMZ5U/Uo7Cnl0+LzJU/aUz?=
 =?us-ascii?Q?5ylDSzHAIgXrhAacs0cnH8ZcOO9MxS1F0dKrkvWG9BJQQsVS9D5wgvpM4QCY?=
 =?us-ascii?Q?Paota69PvMolK+Ng6kYoKGGhOlbaa358KKCshHUPNLqYLESCeSloon6dzab7?=
 =?us-ascii?Q?eP6/IMpuNgIcsbKPkwJgL2Rk52muOOuvCLV3HiDcYK37ppXj8pEYaYqY+OCa?=
 =?us-ascii?Q?nqXjVyoVq/S1bZIIb9yO9o7BYZBOZd97B9UrNg+Gz8cVBPx3+IeEDACuvUIv?=
 =?us-ascii?Q?qzmiWvJJ036q63BUqt6s/TQdITTs8iAjvWhX9Kg1VS0VxvDye5HIeVWo/dLU?=
 =?us-ascii?Q?YKy3ltQfFJDsSf/epIz6hQ0Dc6kDBKrUsGDAAJgWOB7oA+tHtpxi1cInbK7f?=
 =?us-ascii?Q?b4R1Toghs4K0Czr3J+cNbjval268e5FafCBzFcomrNJ6Xh2yNYDWjOkR/L2W?=
 =?us-ascii?Q?Q5zpUAPIUQPqxWnzlNRskuyeHYIYyWzqmUvO82mp5FAjK/lDUdFTx5aVSHGL?=
 =?us-ascii?Q?aRVJm7Svmpg5QFnKntZGD1x8W3B3dYjjST3o8tIhasIoyZgrh1NPi6yNUsd9?=
 =?us-ascii?Q?LiWIz2/arA7vh4ZRUj5nc9jDPb+MKTUpvqve60PJhtbpnYWFAOGLN9Oav9pC?=
 =?us-ascii?Q?GvBNgq57LNzOy1aEdFeJzqZruaECGSjrROpvQYhFtFKKwZbuukaLV24hTRPq?=
 =?us-ascii?Q?gGrU+6Kkm+XdtCNearxPh4WsUohybkdfTywdMdUCGzbnk1DQj1w7vi5ygA69?=
 =?us-ascii?Q?+iL2moY8QR6+0WsWmAWlnD/TeYGjhTEUGT2GaEo/VwXrUkcEH1t8yeOHiA6t?=
 =?us-ascii?Q?r6c0C7bu5m5Ud5E5RnnOE1Y58Som+/F+3JjSCRvRHVOjdByDDr+UeFPLSitJ?=
 =?us-ascii?Q?eNy+TA0M8czTB1obO7AdtOxPCmAL2YP5i1ACfk4bJaj/o6A+Rk7/vOpHnnYM?=
 =?us-ascii?Q?4/bmx425bCwaI0N+kD/Abep7Gg0Cam85zr5p6i4eqRRWIEDhbfrpYHT6bCtn?=
 =?us-ascii?Q?XjN0wbZwGFvG/4tWr1Astf+jv3zZtW97jXLsJjBlkBmEalR31CgNF56u9Yfr?=
 =?us-ascii?Q?CiQEccbMfp7mRaz1I9Ro460Je1mV3PSVlFESbOzwSiQXgye+chq5fPTolKyE?=
 =?us-ascii?Q?rsQAHNtYg43MSYus/p8AcYrwkTWj3fWFgJGS3eAT3dJkCjaJ5t6uNjTH5Wvo?=
 =?us-ascii?Q?7t3Ta8o+Nt1cpcI2PWKxzHxCAOJ+aVOyDp1vjxzL8A8FNPnoS0HUJ+bShNWx?=
 =?us-ascii?Q?hhDXYFZ5hRxN+HwkI60jv1Id1jH9MJAbmHqeDgg/QXnSMZmpijeAmyMRudKV?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 2VzTlQW3q+GxS/AlbLLjMF8DqCvoi8HGYhslPAIZwI1FNP4W+phmatfsEl3hoC6/rOHaD0K8fj0P410c80sGehffBenfYSo9wHH7+aNaJIyVCX54qGAX1rApt0ECJOIJMTz/keVQ060QDWnmBtvqtVmVst484FVyZ+5MwRMw2aVJX9Rm9VyrDtYGSTTQx8CV
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;6:kqo6H5uMGeGePFgP7Xz9F62KLZ4o6FlZwsCG30JH6AUGNGYvKoM+9qhDGguGOP4GAT/WbKho2ZyKPJ0/KUEwSrMhyKYOvdTvo/EVNF7XcpYtS2NOQ/kNCUxXn91koymySFXXGkTSvuGBhTfY9vWUn/UOnuTDrczct54GfPoajmGkepWz1V6AyC9/XVoGvAdGp/PwxNICpeC4K5bEu1TxaHZIYQSAAMaizW+/+/rYRipiYReUm7AoiD2uTKh0P8Qb7xm4lxp77ugOJvNWmedVa58ZD4YxTYg89j4vBprHW9ua1voIVCxXlFvqwbX4qJqMHAH1+Qm83O5nQ6yOIbrnDYoABhHylWLVsPxJA9BYwr1e1sLgdeajQTHcWwS+uDRmLUXJLImDjDzYis3ociQBLbzCCoSZX/Cv8kavASOux/lWuyiWtG15wk+VdNso+kXZ7ZsimYd9ahGWofzpaCmTNQ==;5:j6JC55OVZ5nQ4mTCWmB8NRU8t9esNVMQlSCNuVliogcZMHWQ0e35jvKdVJT5LGD2BDNSGNSGSczO2VjIy0xSMUDDkzCR2jCsG+xPrU2bf0+1WsbfYkmL6s7oJh1m3kFA7/NiwiT4kSk/5/9KB4g9PNJWpoJSNbV3+vl6RQMXOeI=;24:xy/PXdRbUM+mMWKJAsZi0S2NOJgLU/lt6UJnNEHmW4k+RtYQ8g0/ffvVHON2gb4IP0ZJshaq7+BcH5FrsVBDZzntTY6DxGZzGkqprajWCY0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;7:IchQIpgcFr6tPKkAVv+ISy4TRAnmv4Mr+1bum3oE/fcwUJKkzHyVg32ccBhVSzgwagQz/JI1nDzjBW9/dfA62kx4XSnJ4L4pTHQDOiN4qy+9V7P8/AnQkqEaxVmwbitn8KjztM36LXmsiDTE+7h4S5FVZ5QIWB7GhzERiydwUEhxknqTv70QNCkNmHQXDW9MgfU6Uwt3S0sSsT5oVV3Uqnjh3GVhfsWUQlFIdMEQfiHFSImDy+LCyhDzOQXJfQBo
X-MS-Office365-Filtering-Correlation-Id: 2230bee1-1d91-43b4-ea1a-08d5ba448509
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:16:16.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2230bee1-1d91-43b4-ea1a-08d5ba448509
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 09:03, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 09:07:06PM CEST, vladbu@mellanox.com wrote:
>>
>>On Mon 14 May 2018 at 16:47, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Mon, May 14, 2018 at 04:27:07PM CEST, vladbu@mellanox.com wrote:
>>>
>>> [...]
>>>
>>>
>>>>+static int tcf_action_del_1(struct net *net, char *kind, u32 index,
>>>>+			    struct netlink_ext_ack *extack)
>>>>+{
>>>>+	const struct tc_action_ops *ops;
>>>>+	int err = -EINVAL;
>>>>+
>>>>+	ops = tc_lookup_action_n(kind);
>>>>+	if (!ops) {
>>>
>>> How this can happen? Apparently you hold reference to the module since
>>> you put it couple lines below. In that case, I don't really understand
>>> why you need to lookup and just don't use "ops" pointer you have in
>>> tcf_action_delete().
>>
>>The problem is that I cant really delete action while holding reference
>
> Wait a sec. I was talking about a "module reference" (module_put())

I misunderstood your question. Yes, I guess I can just save return value
of tcf_action_put to variable, continue using ops pointer and only
call module_put after delete.

>
>
>>to it. I can try to decrement reference twice, however that might result
>>race condition if another task tries to delete that action at the same
>>time.
>>
>>Imagine situation:
>>1. Action is in actions idr, refcount==1
>>2. Task tries to delete action, takes reference while working with it,
>>refcount==2
>>3. Another task tries to delete same action, takes reference,
>>refcount==3
>>4. First task decrements refcount twice, refcount==1
>>5. At the same time second task decrements refcount twice, refcount==-1
>>
>>My solution is to save action index, but release the reference. Then try
>>to lookup action again and delete it if it is still in idr. (was not
>>concurrently deleted)
>>
>>Now same potential race condition with this patch:
>>1. Action is in actions idr, refcount==1
>>2. Task tries to delete action, takes reference while working with it,
>>refcount==2
>>3. Another task tries to delete same action, takes reference,
>>refcount==3
>>4. First task releases reference and deletes actions from idr, which
>>results another refcount decrement, refcount==1
>>5. At the same time second task releases reference to action,
>>refcount==0, action is deleted
>>6. When task tries to lookup-delete action from idr by index, action is
>>not found. This case is handled correctly by code and no negative
>>overflow of refcount happens.
>>
>>>
>>>
>>>>+		NL_SET_ERR_MSG(extack, "Specified TC action not found");
>>>>+		goto err_out;
>>>>+	}
>>>>+
>>>>+	if (ops->delete)
>>>>+		err = ops->delete(net, index);
>>>>+
>>>>+	module_put(ops->owner);
>>>>+err_out:
>>>>+	return err;
>>>>+}
>>>>+
>>>> static int tca_action_flush(struct net *net, struct nlattr *nla,
>>>> 			    struct nlmsghdr *n, u32 portid,
>>>> 			    struct netlink_ext_ack *extack)
>>>>@@ -1052,6 +1088,36 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
>>>> 	return err;
>>>> }
>>>> 
>>>>+static int tcf_action_delete(struct net *net, struct list_head *actions,
>>>>+			     struct netlink_ext_ack *extack)
>>>>+{
>>>>+	int ret;
>>>>+	struct tc_action *a, *tmp;
>>>>+	char kind[IFNAMSIZ];
>>>>+	u32 act_index;
>>>>+
>>>>+	list_for_each_entry_safe(a, tmp, actions, list) {
>>>>+		const struct tc_action_ops *ops = a->ops;
>>>>+
>>>>+		/* Actions can be deleted concurrently
>>>>+		 * so we must save their type and id to search again
>>>>+		 * after reference is released.
>>>>+		 */
>>>>+		strncpy(kind, a->ops->kind, sizeof(kind) - 1);
>>>>+		act_index = a->tcfa_index;
>>>>+
>>>>+		list_del(&a->list);
>>>>+		if (tcf_action_put(a))
>>>>+			module_put(ops->owner);
>>>>+
>>>>+		/* now do the delete */
>>>>+		ret = tcf_action_del_1(net, kind, act_index, extack);
>>>>+		if (ret < 0)
>>>>+			return ret;
>>>>+	}
>>>>+	return 0;
>>>>+}
>>>>+
>>>
>>> [...]
>>
