Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeBFKte (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:49:34 -0500
Received: from mail-eopbgr10130.outbound.protection.outlook.com ([40.107.1.130]:9136
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752248AbeBFKtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:49:23 -0500
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
 <20180205155550.21432-2-christian.brauner@ubuntu.com>
 <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
 <20180205232438.GA8695@gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2ca51c73-71c3-7d4c-d6fb-a550038518bc@virtuozzo.com>
Date: Tue, 6 Feb 2018 13:49:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205232438.GA8695@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::30) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147d1788-949a-4758-0304-08d56d4f45fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:E0kpZQ/LtrBWMz2ejFL5sw1LMmCGQK3av7Es17TntFT3n8y7p84kONlnY92Yf8oYk6xxlTo764/602nvMB7GIJI0lwLIUWGt9trmee89vyCdrzveTEEvlU2vnlXX6c/1/AY/MSavoJcrg0dfAebgFEm6Dq6FLhOL/dJx+++MA0wSlgfqeHgki9LoVS5ebs7lcTX++q0/efT2yE5C0c7m7R5UtTW3Xdf75FfJyRXuVXGf1WgoTFV29MYB/VgMstru;25:Vrg6tASEKGaHNfVnvDRUOC0xQLWHW+nPXrXPJ32j3953f+ChgF37kEy7TcoUyLvPj/d4mitcs7l9rc/8oHKbtmerWQ1PRnxO/UqtVzH0O6/ZzWHoYJLXcZaWgUEiEobyzXmN/gxknKTyG9OPAZ1k4VoFP2LvsCsyYyyCB8Ceb620BS/lhTLgCWxiCyCxTiMXRS2eTHGkYa5Th20Q7n+jX1QYjbORjfh+ZPDcLlhYQSydwEY/VTYYyWupe6llpxTtv+dtPlywwDcz3ovnB6/o4bdk44uUEDNDLvrg8uhm9SHet33F7WMcUhJaW1vZ8brd6maWR6qF1vhAOZI1sbE8iQ==;31:ZK03r3U9eb1Rvtp18Oj8BWr55aLvdOGh/9A+YoC3klcUxLHmquIQyfgzzFhO3hQG/eqbbrBfwh/3bXrydgZ9dW60+nKPsyuBP6EjslHa3xdPUf4RKxcN2bAXdy0BSiJlt3hQ++sSE3vJAUurRzVwJl7bfKEVIwuiptjmxYj32voKPaEq/318tLNxH6qmNVod2F7VNvnAMWeC74UnoX2cjfwu12ZmejE1otCxmnSf0EI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:HKcHmGUNlGKM5dm2OsETShTZWGDKq5ILDNYZEkv/58092dGMOjNvFLnUNGnj1eO15MTht0POryupglpi1f9zsz6X9J+UrfrjQ5R7EhuB/KObLJa3S6fpRMxUYr9P1GkWGiIqH+JA+ReHAfaeFiIzxM/KoyqUlelSkm0SKPNlqlgrxJsOKom1KRR/yYSR23TeVoq4zMGR6k5MYefLvDWb0gN3WLJcPAVKmvofxuq31KGN7TBvBwaXrNrglu5lfbdpwXH5rM1Z363zAT2QhJJRmD87QpGfd2s1x30jAwbrk/xNlmJw96p0jV3wwpWHz19EXo+Thz9DOqLJOEVVx9tt+w0X8e4X5BTZ0UHqm/WlKngIvXJVneTZe1JyVNQW1WoWpaHzfJiMYHzDThQydbdu59Lr62/zpKOCTA1KWNzOvKo=;4:A8vM7D9iWlEzwN0++0ZGDsNox3biEy6lgNzPRzXZq8tCiPtE29s3nU/ZzMNJ/FGdhKGIVdRbLG06AMd5R8cG1iVOU0l8yLmqZamM4exxDYa6y0oux8u+XupWoXpq7Bv/Vl9cmxhRXcjNIxvX2Gb2CxM7yDlQ5QSokSj450/im3VKp94smAqWHCO9zBs1OKdkdc1QFIW1EwZ1GiRTb6gKlP3IUT64M2mdAoq8mrgDv38iXjgRAVUDb094rOW5MSXWwdI/dMsZe9K5J9jxreyR3uk640cPCFp7Uu7etPl5n81EmITdD1dQMiQqO5uVzVuv
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332F9680AE4B6333DF8759ACDFD0@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39840400004)(396003)(346002)(39380400002)(366004)(54534003)(199004)(189003)(26005)(6346003)(7416002)(4326008)(77096007)(16526019)(25786009)(186003)(53546011)(106356001)(305945005)(55236004)(7736002)(66066001)(65956001)(65806001)(47776003)(6486002)(31686004)(64126003)(229853002)(93886005)(31696002)(6246003)(97736004)(53936002)(8676002)(50466002)(81156014)(8936002)(81166006)(68736007)(36756003)(105586002)(5660300001)(6916009)(2950100002)(6666003)(86362001)(65826007)(478600001)(2906002)(59450400001)(39060400002)(3846002)(316002)(6116002)(386003)(52116002)(2486003)(52146003)(23676004)(512794004)(83506002)(230700001)(16576012)(58126008)(76176011)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6aTEzalV4ZW0xaktObzhkYzFJME4xR0lR?=
 =?utf-8?B?eUxMN2M5WjEwNWRuemRuVDZBU3hwTzhWRWgwcXJDYklEQUpRNlpMR2VEVVZ3?=
 =?utf-8?B?NXlUUXhvNmYrK05CUXNLQi9SVDRGcXhyQkJkUExzL0ZrSVdUR1NmQjdFaXV5?=
 =?utf-8?B?MUZCSUFQaWZRTmIzMjBVVEl1VXNjNmN6ZnNmTSs0Si93V09OMmp3UE5JdlFI?=
 =?utf-8?B?c2RDMWkyUTJnbVkvb3ZDaVpRQWRPbkc4VzN2MkM3MFF3MkQvM0NRY3l5K0RB?=
 =?utf-8?B?RytQcy9SbVFNbGhJeFB0YmtBNjg0azNmUHBxckxPMm0wZ3h5SlFzeVF1eVpv?=
 =?utf-8?B?cDVVNnh6S1Z6MS94eDVsVGZJL1hjSGFOaDRWQnI1aERmcHhaeEJiQVRyTmN2?=
 =?utf-8?B?THdyUDl4di9HQTgxQWZmZWhkb2xGa1ZWQVRROSt6bXAvaEo5eTlNbVZ2M1h0?=
 =?utf-8?B?MnNuc0U5OHU2SXplRVVna2h0T09ZcXU2U1pvd1hpVnkvT0ErckdzMGRTS0M5?=
 =?utf-8?B?TlB5TWFxRGRJa1o5a24wbmpkeE0xbjIrbjBSTzZOcnk0NXoveWJVUENpdUhu?=
 =?utf-8?B?WnpuYnYwYk8rNmlwc09aRHN0ZExveDZqbS9XaXZPYTRVN3NZSUp0VmFYNDVw?=
 =?utf-8?B?U3RuZDdaUDhGZXFGVEl3Y1JCQWZsZ3h2NFpUUXdNU3owcllYZ3RQbUptVjZG?=
 =?utf-8?B?aE5YTG01NjVtc295UHFYUEZGL1dyWFRFd0hNdHBEUSt3eXY5REVQWDFPTUFx?=
 =?utf-8?B?ck5iU01uMGZJV2FxWmlqdkJEUDJWYUhNWjBCTndIZElSakxxMUNWNldaQ1li?=
 =?utf-8?B?R0d0Ly9WbXN0RVRLYWJqZlAzN0JxVG4zZVdwUlRYSStaWUJSVzVyaXZIemVx?=
 =?utf-8?B?eFk3L1p6L2RCNHhPbXpLTzhWMXhaRjJnY2lmU3NmTm1oUUl2bXhUanFoRHlN?=
 =?utf-8?B?c0ZNV0JoWW1jUi9DOEJObWgwQW1wT2R3M01SK2NNbTZBams4RmlFU3NQU2Zu?=
 =?utf-8?B?MWN5Mzl6N2s0V2Mxa0s1Ui8yQ3RkRGpOR25rUGo5MnJJcWxoU0g0U2Jnck54?=
 =?utf-8?B?U3l5RTFaQnRIdGlHNFlGYVZkQktHSk1HYytpM3IzVDJXM2NxRG9uY2pBWnNI?=
 =?utf-8?B?eTQ5SHc5NjU2Z2w5bmdpZ3JqanNIRFBoa0tsY3NHRnJNeTdEWUViVmxQNlJ2?=
 =?utf-8?B?djJzN3c4MERCOEptTkZKZFhqRE05a01yaFVxbm5lbExHUHE0VjNrTEFUNU5z?=
 =?utf-8?B?cVZGSDhvSnYyOXNmNDFYWFdaamhNalo2b2svN0RIdFdtWThaZ2lxc2NYWjMr?=
 =?utf-8?B?bitLcklXMzhpVnVpUXI4VmZOdU42SUJ4YVZxQVJwKzEwaDdBcW1vWFZnVDVK?=
 =?utf-8?B?eVRrNWhpN3dQLzFQS1VYbnZZUkdDRXBzazU1TWlJanhPdWY4UXE5UHdzd3Vr?=
 =?utf-8?B?TGl3Y1JNV29sT0ZVRXMrd1lFeEtGMUpQb3lwbWNCQkdPNUlIaWdvRWpzNk05?=
 =?utf-8?B?ZEM5MUVMWUpmOWNabnhGUG9LUXliZ2dWc2NVUlpSODQ5T0tWTkxLRWl2eC9Q?=
 =?utf-8?B?ZlIwdHN1QTNJSVdlOFFVdjM3UlNneWJGOXVVTFBJL0M0NHA0Q2xZMjZ3YU10?=
 =?utf-8?B?V1dZY0xOblFPNG44NVE5RFFGU1V5Ri94TnVJNkRKLzk4M285U3Yxb1RROVds?=
 =?utf-8?B?bVpMUTZmb01RMFdTSXE5M3ZNM3NMcjkyOCsyMnduL1c0akpQSHRFam5WQkw1?=
 =?utf-8?B?SlVoY1NLbXFobTcxNGlQV2pnS0NLQU9RbEFsWFl1MGtCaGxNZ3AzTmV6anh1?=
 =?utf-8?B?cko0TnJVamJiWVlJcktoa294MDdXSXU3WDFuOFdYVU5rUk9IMGlFTXBHbUhC?=
 =?utf-8?B?UmNycFlsSGlaNE9GTzgyS3gzVTFkdWh5KzJHc2dSbVdJcWtwNkN5RkUzMWhS?=
 =?utf-8?B?Qm5OeXZxR2szT1NzdTlNQWNLcWlsRW1rNC8zR211UnBXbmVJckFhM2NFMmxt?=
 =?utf-8?B?dnpLaFYwa3FtTWVWa1UrckRNZER1dXBlZkxnditZMDl4WDIxbzBnMWt5SHhE?=
 =?utf-8?B?VmhoZThFQWJvRTMxMEc2ZzMwSlFYVGpHQkJYYTRTZCtFQnpyaTRjSW4wV3Vx?=
 =?utf-8?B?UndYQT09?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:UqKbKLaMtqeMi7a4h4+AH2CrfNgGPHsTNER8DQj0HIESyVt81xR890Gj9fDz0/CG0FuHzd0xRSTo6U9TNIcb93FReN8ufwPGMReUXzBhggvL+PVcD8Hdqfxf1mFheBrgcSiHoOefsyA3JxvmSkuxXI2InR0HlANiLH317ml8YvUv5M3exMT48y69coaKEShYGb0F1kr2oVlmpVV2yhrk9RCUnZG7XHdMn9hC4CRDutMlXlC0AsO33mFB0qrPBeNLY0OjkchtN79+xXyOaby36RFFeeMRbUE7jl5KZISa18dtLiA6PoEVbVVD+zT8YxUVRoHCtUNPiqXJ5IQ8dW9XvSGA6SitghfS757xyw3X8d0=;5:m3fVYeKYbnsNaG6jsEMTgmX89dp4MWc0qfgk8mKZiyLyXjg5qLQ4XbofU6YizGLCunS9+zMRk0EGxvVn+ZHwRWWSh+VM1z+yBCJDcdl8lrupXK+iPobyoc2mtavj0eYgikM+IPgieV8dLKeN27xFxDcQmcuLm6eCDt/e+2ppyfw=;24:QO6lgzzf0SXWdx3KqrX5wuDZVnFx9gnEEQ5NO/FiukUhPiWBwYEQVIFThx71oLwcOnWMm0ZlCBHglme6rg1IZU5zWJ2xx0swF694jaL6Y0Y=;7:G4TAMjsHNoBR0n5Q/sYWIHW4/rBf4Scyh7cEwSiBA3ufuaYXJ0tyXRz43SvOd6yEs5xnsjn7My9PKlhDHPvFkxEJ1au3dlXdj9OcAD66/gVRImi7v7pXLV9lk6+6tqJa/LI2vMJe8wpJmXJvr+xB4ak59kNgLeaXgsCQv1Q4JaHqVXmk0T0+7X22M3gTCpm0mLn+vDhK3v66+nmDX1ivDy9oeyogzdZrLkqfMsMfeBD3sZAsXI0ya2wTstA81SxR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:rTWf6p8fRIcDgdx5GH2Gsg7X/cIUXwwQSkwwaHJLcCm0zk8NiDosXSolFNzVTmnIooPa+89al96Op6ur4fbw6RmhLYrNEMjNP58Zo1BSITqEZzM8aa1/015HdFY5s0LSubZOYwtk2SmSjM9TwcjpFwW/5J9EiQQFCLUAIMfkuy0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 10:49:18.0661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147d1788-949a-4758-0304-08d56d4f45fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian,

On 06.02.2018 02:24, Christian Brauner wrote:
> On Tue, Feb 06, 2018 at 12:47:46AM +0300, Kirill Tkhai wrote:
>> On 05.02.2018 18:55, Christian Brauner wrote:
>>> Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
>>> it is possible for userspace to send us requests with three different
>>> properties to identify a target network namespace. This affects at least
>>> RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
>>> network namespace which is confusing. For legacy reasons the kernel will
>>> pick the IFLA_NET_NS_PID property first and then look for the
>>> IFLA_NET_NS_FD property but there is no reason to extend this type of
>>> behavior to network namespace ids. The regression potential is quite
>>> minimal since the rtnetlink requests in question either won't allow
>>> IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
>>> support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
>>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>> ---
>>> ChangeLog v1->v2:
>>> * return errno when the specified network namespace id is invalid
>>> * fill in struct netlink_ext_ack if the network namespace id is invalid
>>> * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
>>>   indicate that a request without any network namespace identifying attributes
>>>   is also considered valid.
>>>
>>> ChangeLog v0->v1:
>>> * report a descriptive error to userspace via struct netlink_ext_ack
>>> * do not fail when multiple properties specifiy the same network namespace
>>> ---
>>>  net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 69 insertions(+)
>>>
>>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>>> index 56af8e41abfc..c096c4ff9a00 100644
>>> --- a/net/core/rtnetlink.c
>>> +++ b/net/core/rtnetlink.c
>>> @@ -1951,6 +1951,59 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
>>>  	return net;
>>>  }
>>>  
>>> +/* Verify that rtnetlink requests supporting network namespace ids
>>> + * do not pass additional properties referring to different network
>>> + * namespaces.
>>> + */
>>> +static int rtnl_ensure_unique_netns(const struct sock *sk, struct nlattr *tb[],
>>> +				    struct netlink_ext_ack *extack)
>>> +{
>>> +	int ret = -EINVAL;
>>> +	struct net *net = NULL, *unique_net = NULL;
>>> +
>>> +	/* Requests without network namespace ids have been able to specify
>>> +	 * multiple properties referring to different network namespaces so
>>> +	 * don't regress them.
>>> +	 */
>>> +	if (!tb[IFLA_IF_NETNSID])
>>> +		return 0;
>>> +
>>> +	/* Caller operates on the current network namespace. */
>>> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
>>> +		return 0;
>>> +
>>> +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
>>> +	if (!unique_net) {
>>> +		NL_SET_ERR_MSG(extack, "invalid network namespace id");
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (tb[IFLA_NET_NS_PID]) {
>>> +		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
>>> +		if (net != unique_net)
>>> +			goto on_error;
>>> +	}
>>> +
>>> +	if (tb[IFLA_NET_NS_FD]) {
>>> +		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
>>> +		if (net != unique_net)
>>> +			goto on_error;
>>> +	}
>>> +
>>> +	ret = 0;
>>> +
>>> +on_error:
>>> +	put_net(unique_net);
>>> +
>>> +	if (net && !IS_ERR(net))
>>> +		put_net(net);
>>
>> 1)When we have tb[IFLA_NET_NS_PID and tb[IFLA_NET_NS_FD] both set and pointing
>> to the same net, this function increments net::count in get_net_ns_by_pid() and
>> in get_net_ns_by_fd(), i.e. twice. But only single put_net(net) will be called.
>> So, after this function net::count will be incremented by 1, and it never will
>> die.
> 
> Thanks for spotting this, Kirill.
> 
>>
>> 2)The whole approach does not seem good for me. The first reason is it's racy.
>> Even if rtnl_ensure_unique_netns() returns 0, this does not guarantees that
>> tb[IFLA_IF_NETNSID] and tb[IFLA_NET_NS_PID] will be point the same net later,
>> as the pid may die or do setns(). Racy check is worse than no check at all.
>>
>> The second reason is after this patch get_net_ns_by_id/get_net_ns_by_pid()/
>> get_net_ns_by_fd() will be called twice: the first time is in your check
>> and the second time is where they are actually used. This is not good for
>> performance.
> 
> If this is really a performance problem we can simply fix this by
> performing the check when the target network namespace is retrieved in
> each request. The intention for doing it in one function at the
> beginning of each request was to make it generic and easily
> understandable.

I haven't measured the performance with stopwatch, of course, but this is
additional operations, and we should not use them unless they are really need.
The approach with get_net()/put_net() is racy and it does not solve the
problem. So it does not seem good for me despite it is generic.

>>
>> What is the problem people pass several different tb[xxx] in one call? We
>> may just describe the order of tb[xxx] in man page and their priorities,
>> and ignore the rest after the first not zero tb[xxx] is found, and do that
>> in the place, where net from tb[xxx] in actually used. This is the thing
>> we already do.
>>
>> Comparing to classic Linux interface such as syscalls, it's usual behavior
>> for them to ignore one argument, when another is set. Nobody confuses.
> 
> From what I gather from recent discussions I had here using pids and
> fds to perform operations on network namespaces in netlink requests is
> not the future. Specifically, using pids and fds will not be extended to
> existing or future requests that do not already support it.
> 
> It also very much smells like a security liability if what you've
> outlined above is true: a user sends a request with a pid and the task
> dies and the pid gets recycled. Now, we can't easily fix this by simply
> ignoring pids and fds from here on since this would likely break a bunch
> of userspace programs but we can ensure that if a network namespace
> identifier is passed that no other way of retrieving the target network
> namespace is passed. Especially with requests that already support pids
> and fds. It's either that or reversing the order meaning that if a
> network namespace identifier is passed then it should take precedence
> over the other identifiers. Furthermore, this would also clearly
> indicate that netns ids are the preferred way to perform operations on
> network namespaces via netlink requests.

If we really need this, can't we simply zero excess identifiers instead?

void rtnl_kill_them_all(struct nlattr *tb[])
{
	if (!tb[IFLA_IF_NETNSID])
		return;
	tb[IFLA_NET_NS_PID] = tb[IFLA_NET_NS_FD] = NULL;
}

It's not racy and solves the problem you are solving.

> I also do not think that your suggestion of making guarantees in what
> order additional netlink properties are evaluated is a good one. I don't
> think we want to give userspace the impression that sticking a pid, fd,
> and netnsid into the same netlink request is something that we actively
> support.
> 
> What is certainly a good point is that if pids and fds are as you said
> inherently racy then we shouldn't perform the check but do what my
> original patch did and simply refuse to combine netns ids with pids
> and/or fds.

Thanks,
Kirill
