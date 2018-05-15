Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeEOLmC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:42:02 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:10656
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeEOLl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:41:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-8-git-send-email-vladbu@mellanox.com> <20180515112404.GL2134@nanopsycho.orion> <vbflgclm9wc.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180515113954.GM2134@nanopsycho.orion>
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
In-reply-to: <20180515113954.GM2134@nanopsycho.orion>
Date: Tue, 15 May 2018 14:41:45 +0300
Message-ID: <vbfk1s5m9hi.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P194CA0005.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::15) To AM0PR05MB4692.eurprd05.prod.outlook.com
 (2603:10a6:208:af::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4692;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;3:bZBxImbas8B1JbsDY4m5T4g33qboHcUFycLAXXwNt7d3GAixPkj2OyAKdFiAcVDkPuT6Y42t2kBZEy9YN2kBYPlo9A+qtbf0vadjc3zHtJUSMDh0FdVSi8IH6wMpCzlkW6UgsyvY8YXaC97h7Hg5xgo6LXLV3qbZgKPvg8IE8+G1j9NaQGUaVWaWcBnYt9+wiginA5dEptqo/Ay29YFwiFSeUfNiuPNToNIiQtwE7jXKyWyPDlkr2m6rEU4Otvez;25:z/8I8zOBIR9k2r/mkSjffCl987b/g3tJ9LmvdLamOrfmf4bi42yk3af2FDy1pujO3LHFQ4KQSUEVUsFCHp7jIYFRPR5XnIOJSirw9AJ1ysUfL8xAMqYwopAy9DeZMNFZ729MS4z+vNkEAp3asBNIUTGaTqfjEXmCk+Rm3DrQaOeUL+BMyvcsYl544bFwYpavbtlXFAq90fHw2QPVkYmCQ9tnyi2Mq+v65fA6lTUEqdYundTTVEss5cKg92TzEZ4H76XMODeslOf1K99erlwfg1ohaY3ErgU4nMJ5MZEo60VGsoQGKApznaD2KptOYYWUdb1BCqiXWmsFKGzHGUQq4w==;31:yYwVrL2PC0UlexcMQXoXM6H/Ho20YakOY5TKTHmby7XXhwwQLFMU/f5K8PtgHrwDSo3dX3TPqddC8hVARhk3DCVSvxwRL4urqR9riiC2l8hJ9hIoP4NuPIrDvVhHPqD/j1sgnG53PEnkRn9qiKr/JY//JCT2kOYWN5eZ8wfkcwDibh1b8BaJDWspQ38MXFEiaxenGyBaIXUQoNQzlx4BAifkjPAWwyykeGKzajNzZuE=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4692:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;20:6gfKNErhye9QzPngA0MmyiDEHRZsuCfc/adDa0iYFdtkq+0Z68JQaddHa5rTGsbHUmxe6GmwjXxZsUY6ltWIYF6rcnuUgSKYaN4F7WmTRJVyf4rx/hw7urvPxzFjwuFRLwh2kA1ikDpCeDM20Ik+V4fEt+aH4+jpoCeUw4D8A2s602KyaSVydCiOXVIViUt24CQr+MOCMpCXI46wnPKj3eTdzQFgfL31aVV8t1GejscphXDJfpTBXPNW5bjFNZFQ0+G04KcpFrzPADXkm8FCajvV5bfrM+i+UjTUivNmJNa2vqzwcEm+RJonPws3ynH/jJ5rUqOsNAq44Ilu1jQlpFRfsRvezDAqbXeuE638uwghDE++/uQ3sU20XwfxUoZpvwn3dh6MTeLzPXlxD7D1hwHJVHilK4ohhN5nHauW2W3w8MgINhvQNNk9E1hZffI0V7C4H/HwMkJBUG7PrnvdCNaAY7KZbnu/0hCI+/Uktsu5x+eryGL12pleJWsUGZCP;4:a2DR6eUejNMSfZCsLL9GawYE+FmMAXplMhFSRHJ1PQi8Ho2gW6lm6ucNgWdFQqAtWHu8g42kBPPPi0ry43AbXYnf0/XncC+rD7QpCtV6hYP37rZBLSSSDeNsmrYy0NU+krWc5hjbxUWGLOb9kxqJEdu1J28GDCthDjswQ8VsvBwQ9lfUMYLeQmTCrNBMVLQnwGA4sTIGTf1xurXZWnnYYfh+b3Cf2P0AjjrRej5b8bZjpyuUSCdCcXapHEtwTRIIe3XiPgnHNhGh+RX+2IXymA==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4692877FAEB3C1A760C72C3CAD930@AM0PR05MB4692.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM0PR05MB4692;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4692;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(11346002)(25786009)(68736007)(93886005)(50466002)(47776003)(8936002)(58126008)(81156014)(386003)(478600001)(476003)(81166006)(8676002)(4326008)(59450400001)(16526019)(956004)(6486002)(6666003)(486006)(229853002)(446003)(52116002)(51416003)(76176011)(6916009)(7696005)(26005)(7416002)(305945005)(7736002)(106356001)(53936002)(9686003)(16586007)(3846002)(6116002)(97736004)(86362001)(2906002)(105586002)(66066001)(6512007)(5660300001)(107886003)(48376002)(316002)(6246003)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4692;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4692;23:tCT9n35YMZe+J3ohO0idykj9QEQq0aQq6MZ06gvtY?=
 =?us-ascii?Q?jXLh7C8pA2tQsdZERSHm3Om/03dJvWVjOj5t5ATpqYHtKHTUtBssaodBoQhE?=
 =?us-ascii?Q?6vgDkEHnP8n6H6fn75SAxG/kQgQSdSjpzeianD/3ToVFElg6EqObFf6phYTv?=
 =?us-ascii?Q?alegs+bQkp3l0oqkig4sb0TlPA5mpAUkaq6SL0KkbczQd4npDhCokMoSiYtU?=
 =?us-ascii?Q?iPmXq9c8gc75/Kxb5O5gSQuUkOIHPTAu4IFWqJLCuKkq/llx8xI7CZwuqIUK?=
 =?us-ascii?Q?wyp1G0h5jm52u4a7885eeCzkoMm6T2L59iDfwwFmZ4XacYV5f1DMZkdvFMLO?=
 =?us-ascii?Q?z2nf4rkEO5JylTuLrErM8i83tRaIIBN8t3vptWAmcMCxXQd4iYTx+xO/imnl?=
 =?us-ascii?Q?wP2AubMrPbZnaxmDvQEoMVaBNEFkC0PeolwvsBQ78V4A+vYoTs6j2+EFMEKR?=
 =?us-ascii?Q?5dG8Zr+39GWalc65VTYFARl0ioXNTUi+53FLIezH8TFqxrfoqGRXeED7RDbf?=
 =?us-ascii?Q?BU8St6qBaZ/4tg7nNOlwnCZQt+gLbVg/ZZ9LiOZMaKRDo0KOHoNIjwJEZQdp?=
 =?us-ascii?Q?mYxdn4R76BJAMoiclMZwjI47ECplzjnRUQ4yt2LJnWirj8Ooubd8ZnV89gyb?=
 =?us-ascii?Q?qUIq0kyYiP3fCr/Bqw6W9JpzWjvYHszKk3Atm5jMnNote0PuvO3cQc47pWuN?=
 =?us-ascii?Q?L6vYgIpnugWx8ys0WMF7Bpi1Vnzg+w7Hdh8J3zjRXmW1TKFG3shIH5lUOzyz?=
 =?us-ascii?Q?zi0wIqOcoEPcBKDWs3gExSKbWAn0ZEDR2nmKUAUw+89tdekSnlCktNGI7mRO?=
 =?us-ascii?Q?lVTwQ2j4MlsK/ZkvAh87l/S2gdaINDm2u+VsBbbFb6qU8TITx8lhtSQ/aG9S?=
 =?us-ascii?Q?VoX/YIem9fNp23ABIQhYW7O9whKei8gpml5+dOwv04Q9TvU7YsMTOB4T0nG4?=
 =?us-ascii?Q?hkNv7kO6s4c1sQ5ZRtckc06kl/H08WZbZ6S8TkDeiBacVUjD+I2r0pHfJhYL?=
 =?us-ascii?Q?Mtf1vMACpuk8cse4wNxreptN1SXDdzRHXCW3ya+oryzBqVXCqXpGenOZQRpi?=
 =?us-ascii?Q?O2U3cQv8eF029p4yg6W0WiEWVJabtu4rlcq3xJbv/l89t67pDZ1NmQUfVcsZ?=
 =?us-ascii?Q?SnhFIDfFmh0EM9Xw7RiUBMtOP5OUGWFtN2Ufn+nxq435z180AYnZVIl6qmEU?=
 =?us-ascii?Q?l8fIGZZcO7Fq55ZIykFc4OGQRgbLdqh4U+OZBMNSFi1tJAehfVA/1Id2A5gK?=
 =?us-ascii?Q?0zi3wZvd3p7gnnfBhKIvX+D3BVbfLAjpFQUvgoMyY4Hxqpn64szWHgAWyqBs?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 18UHcnT/2xowwTHayM/1oQ654zKI3ShKpp0gZy4OyeUxWFVQugQfFwOG0Ja2aCM1awZVadwINDR1I+r4axrePlpJrKTv6uq9ki1Hm7TZzw0WsSvnQLkW5Zf1w8mwh3lLSM+2bV+0dB1vRz4QN2MLkzUcxJXKq0Ex5TcrIqWDI+ocRLbagwc/8X8GOD0QLtlm
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;6:WdBPkBCzVS2Xf98BD7JF93j/oRwfmas/WUH9jUh4puKU6xpUNWQ1TFbZyu09mp49mmffJtPBeRK6X02d7qfNz1UuPYhhMlNjz78lOGZntRnpFyoi6rhskfna3A9GTqWbtFfqBijiEOjRM6pOVzUfo5sR6Bh5irifkxKQ7c2r+0ZQhxiTOImY52gKo6nd1YjnDwqalq1OENvsKKp3gx3M/Uz3r4shBOEMBJRxVZSV02K2/M7IrqXcjRKxphMlHnex3wYPTI9cACWuyfjYtIXV8II/a7aAo2KuwXC4pv2PfnzGkQz2LSRbNXfrz3jo1glf8qNyuMHDUpBupg8mjzllkpn5BmH/kFTos1QTnPjXNLtA5gwHoP52xW0rLZBJ5N6aqYVsMD5rqQ0BFouGKPRJJ8on/hU9XNLJyzw/z2PjQ4P2u4FDj0tq1mfHncjJHAjflUBPBCxXveVB5p5EjPqf4Q==;5:KnvCClBskmrPCth0Ubd+kDAfEUoJ4/1BaYcVXswcEadZjeMymNhFxnejxJBXI8zES4bGsCcFjgrntLxmj6qldqNpB7H9rCrdNnSH5i5QZbvnKay0m+keENLI8IVQXLcz7yDk2T2SyKZ8Y0zoKDUX7Bv6qCL2vk4cNGaWZZBO1Vw=;24:7wGdGiD09olmvpuyuLuGi2eaKBXbyD5yokQ0x3mkyxcLf+vzNh19H+qcZa6dEOyjCyZdTFUrTHR0kUydvPHJq7LcPwCEn5ny0OSGb8cVSuY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4692;7:KuLsNdvn+FAou6I05QQrhaRirVKcqZF7PIWZXNQad6j4xxmAgFgzsuoxHMvVTI1haPF0o5szWtDbQkZIm0ZAlc4DIpq7Xe+w1I93N1v2w3HSerNsPlKTvVZyu0A37HCxhyCy4JT9D9ilkrr6l2IogU6ANYkh1lQoKtLCaC/Hgmj4Wb56TxFywS2pLxIOMnLTxxDDA0Uw5SBOZ8P2IAXsELqq7wL/Q2ZvJcXTxVNynGn8wObZedbB9YewBaNLyNBa
X-MS-Office365-Filtering-Correlation-Id: 183ca6c9-9501-4280-3ae9-08d5ba58da71
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:41:50.1441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183ca6c9-9501-4280-3ae9-08d5ba58da71
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 11:39, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, May 15, 2018 at 01:32:51PM CEST, vladbu@mellanox.com wrote:
>>
>>On Tue 15 May 2018 at 11:24, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Mon, May 14, 2018 at 04:27:08PM CEST, vladbu@mellanox.com wrote:
>>>>Change action API to assume that action init function always takes
>>>>reference to action, even when overwriting existing action. This is
>>>>necessary because action API continues to use action pointer after init
>>>>function is done. At this point action becomes accessible for concurrent
>>>>modifications so user must always hold reference to it.
>>>>
>>>>Implement helper put list function to atomically release list of actions
>>>>after action API init code is done using them.
>>>>
>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>---
>>>> net/sched/act_api.c | 38 +++++++++++++++++---------------------
>>>> 1 file changed, 17 insertions(+), 21 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>
>>>>@@ -1196,8 +1190,7 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
>>>> 		return ret;
>>>> 	}
>>>> err:
>>>>-	if (event != RTM_GETACTION)
>>>
>>> Howcome you do this for RTM_GETACTION now too? Where is the related
>>> "get"?
>>
>>In patch 5. There is always a possibility of concurrent delete without
>>rtnl lock so all usages of action pointers were converted to hold
>>reference to action.
>
> So that means that if you run kernel in between, with patch 5 but
> without patch 7 and you do RTM_GETACTION, you leak a reference, right?

Right.

>
>
>>
>>>
>>>
>>>>-		tcf_action_destroy(&actions, 0);
>>>>+	tcf_action_put_lst(&actions);
>>>> 	return ret;
>>>> }
>>>> 
>>>
>>> [...]
>>
