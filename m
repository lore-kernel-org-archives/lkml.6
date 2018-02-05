Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeBEVsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:48:10 -0500
Received: from mail-eopbgr00112.outbound.protection.outlook.com ([40.107.0.112]:65497
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751960AbeBEVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:48:01 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org
Cc: stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
 <20180205155550.21432-2-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
Date: Tue, 6 Feb 2018 00:47:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180205155550.21432-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: DB6PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:4:91::20) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72483826-f1fa-483d-7f6d-08d56ce21ea6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:Yuu0Ucd0NN3o6s/kyevnGAEMG0KPSutPRiUDVeea5F0iZ6D5vRD8VlNh5q9hN9gSoG28jV0ftLsuE+sKgYbYh9gEfqH71RKm/SrIvCSEvDitWN6B4Kc90gB4S1vLgapPuRuF0WUMG8IJjVKAk2NjyNRwLF9D4+syP21nJwH9ghV8a0b9typDeA4w85M1/FF7tLbtHFhi8uRZUdg0XSnOrCN1c/pTtVIJYLblF6D76DmwmlVz9H1NKvUIpL+wQycm;25:bDPJUpIba4Wgv41E4GjaLqOQY1XRQzTqfnO9fCRj9iIfx8GbPQzNe5Bq0E/lyAZ/CxUQ8JyQjw/KGrpKNgovVNEys3oUto7TQQJpz6Hs3G0ze1E4OQy5FxXUpy4vE5uQrDLHoGveirdnBnH5KjpOtNnxkgbvFnzVhA+G9bzLjhWGDv+uhpULg0NAgQhLBAHSuSbjwS/kuerVIGeVJRaf91mv9swSoVNwHb5fw3Wyf9Qs8t1NZO5KiOQ3qXsV1PgnF94LcASfSi6vvKiVLS/TFbiXlxqvkHWVu1vFGKJ2Ssa1aI/A+YyIHfnzYCzZSUpP7ExxsnZ4dtryQT0vHNWxuw==;31:ed2R0Aoo/+gStb+/qhjl+krLmjTcWJO317HReCGWmAQiFiQevaoFAbnt2cQvjIjFukWOZLG9e+ijdoiJ5KtZwMvXP0B4uggHoSpevfM4Jf57M/nt1BUZuCi2QVrWqgJg9vPo9ew2qVEg8nIgSAOpb3nsP+tvTgykgWUGzM5Xc1pEZJxrwRG8Q/gOIl2gWyj8lGkHEc9z3k745LExZ+Q7hpEWjnzwvQsx7qTS51SxAms=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:dB42eQHmE0Vo1vdY57o+CwxkCF1VhLZxvTONWaYbfyQz2wGCMXYdWKh9o71KSRi4OvwlB94FVaN7O8a+mTFoolnIkwkU0ZOXouwFPOewOiwWbCVAo76+LaTN/J12Zj71QjISx5GFX2ScEMhaBn8e7rK4Oy8cQpQHUlMLC6gaPqy2iLoE+5OAoix4PfNFd86S1UiNZLgRbbGlpX1ZFfa3ChLc5e3bGiZCiQlMrdcXRxxXvVOQ+ZUoO3J+BJj4XDIewQjvczLjSc+Lnx7nr30G9IqWFkC87pYgC+1IhjqRBpVWk1MKgC2S2K4l0y/KaoDHUQfYWEAU9s63YQyg6F0Tgt50Eb6wB54WgrUjrsBkIX6z+TiRNEIhllNRK4zCLSkg7SWWV3YVG8iWeb/EdA34ZXVb8W/1hWZOF2b/PSwczbY=;4:6V6xz/4EvoaDqJxaIQgvbQyUxBvd7EYaBH3ZTXmMva4ceB85kLfaVUBhitdyMXQ1sJg30FbCBchvS8eN0weUFOzd0l448cApfCfSV7CYDNpxo7/8ZYNhacfhrCooDz4d6cWtFtvoDSpin74G9dmJ1Bj2PFMfYZ7P0S2OmkIwRDMhdpBAeQAYnLiX+sBUBiCWg47zHWD75RsHfvbnkwmqAHdArNlUrroOu5wWRwHqw/KYvckfnG/j9qoXbb4bOtyHVDLRwDP29a0dkqvw+pa50Q==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333DF11EA33C0FB0F643E34CDFE0@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39830400003)(366004)(39380400002)(346002)(376002)(199004)(189003)(54534003)(2950100002)(5660300001)(53936002)(4326008)(478600001)(6486002)(316002)(6246003)(8936002)(39060400002)(58126008)(64126003)(229853002)(6506007)(105586002)(86362001)(106356001)(53546011)(47776003)(65956001)(66066001)(65806001)(50466002)(386003)(25786009)(230700001)(26005)(31696002)(2906002)(8676002)(59450400001)(31686004)(68736007)(7416002)(6512007)(36756003)(81166006)(97736004)(3846002)(7736002)(83506002)(52146003)(65826007)(81156014)(6666003)(305945005)(52116002)(76176011)(23676004)(16526019)(2486003)(6116002)(186003)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6c0ZzZ2Rmai85V3B6cWdtWm9oaFRQeG85?=
 =?utf-8?B?ZGRtS3V5YWtVZ3pGVzZKR3VkeDN1V1RaYlFFNFJ3UFJFeitCVWlGTFp5V1ZH?=
 =?utf-8?B?YVVRNFJKbVIrQWw3QndMdHlLOXdmRDhPc3J4YWpWZ2IwNlhsb1ErdFlTcHBt?=
 =?utf-8?B?MXlGYUp3aFVFNVhGU1EvWHp3dHJId2dXbjNta0Erdjg5ZEhtMFdyNHZOVkxP?=
 =?utf-8?B?TU9hM285TEdlcGdBZzluZDNiQjNrYkEyZXdvVGRBTnFZKzBLZlNYeGN0TVRM?=
 =?utf-8?B?dEZhUVVwODhMcGZySy9TUG9jVC9MVXppRWpxRitEUVgyMzhPc1BRNktHRG9p?=
 =?utf-8?B?VEhYcnlPeFpKVTdlcmN2bEtZai9ZdE5OSC9FWTRpUmtET1VJaHJ4dDdQVHBm?=
 =?utf-8?B?OFB5clBKOHhxWFYyVWRzWUpSR1dpMTVnaVd1aXNOMHM2QVpvZnF6b0RqWDZz?=
 =?utf-8?B?YXlBR0JoMklqbTFhb0tOUXFtdTdZbUhhOVhnekY0QzF6TTRQaGJrS3AvY2Vx?=
 =?utf-8?B?RVVDaGpadnJ1Z2VxWnc2bmFsS3FzbGZWTWUvSVBVaFU4NW1MZ0pvQU9PanY5?=
 =?utf-8?B?bFJ2MGZHdm9ZRkpBem1URlZiYmRLNS8wSUQyMGxoNldDK1NveUREaXFmaWxw?=
 =?utf-8?B?bGt5RzlrQUR1WGZBUUg1d2c0M0VTNXEzc0p5UFhDYjcwVDNRZkdZdThsZGh5?=
 =?utf-8?B?ejlmenNMdTAxZU5XRDIvVDJMYVdwblVFYUEvUmtXRGJTZXU5c3pHYm43dThJ?=
 =?utf-8?B?Vks4UllHZGtUV29HV014c0dwbEoxMm1rQXJpcVhLaXgvOHZPelRFbjVRMUVI?=
 =?utf-8?B?YTJTdm1iTXlPV1dQalVJMHNyU0x6dS9tN21hOEo4cEZIQmpFL2xIYjhtem9G?=
 =?utf-8?B?eERWeHJGNFpiV1hYekMzbFc4eXFKRWR3S0Y0VUg2bWVZV3VKZW9lOGlvRThO?=
 =?utf-8?B?cDRSSHFJZUkwaWpxaVArQ2JlSGdCaEM0TjB0dVBxZWpoTnFLTjJra0ZQNnlP?=
 =?utf-8?B?dHpZcGNVaEd1aFdqU1p2a1MwWkdXSWdkamt1RXhXZ0NtRXExNzFTUHhZNlpF?=
 =?utf-8?B?Rk9XUms5am14S0tPQTFmbmZlcjA5Y01ObXVJVHJIUnV3VmJFTHpNaXRobjBY?=
 =?utf-8?B?a0psek05N3BrRVlmT1hLL2Z3MytRZzBxbGUvTWtIQjdWNHBzV0wvT3ZJSVF2?=
 =?utf-8?B?UHRZNkNuOHhtRUM5N3ZpZGxjN3VRYnIzNmFWNnRLd2lha0M4NGhaRDNud1RK?=
 =?utf-8?B?UmhzalhhZEMrdDU4OHNWbjlDYTg2REhhT25reE1JaXJLU1YxNzNFSmZOdUl5?=
 =?utf-8?B?ZUlvaWlQaGFHQ0wvajRkb2hWQjQyNWhYNUVFbVhrM1NzNjRJa2l5c1hmeEk1?=
 =?utf-8?B?aUJNWlBLdUVZVkxxZUlHNitKTEtmY1dDT3BWVjJsNVQ2Y1dXeVQwR21kbktk?=
 =?utf-8?B?V09ubCtnbklISTc5aytOTnM5clA2NHAxWTNlU09YWWRDQVRKSjJpMDRmeXJW?=
 =?utf-8?B?cE54a0lEV1VveC9RTkxrOHNPR1dkeDE1NlowWXpqUnkzTVZwOVRCNmh3VFJi?=
 =?utf-8?B?YjQ4SXV6blZEdHVUbEE0a1dSSi96dGtMdlRQOXdqQlNWek50RTV6cWtLd2Ey?=
 =?utf-8?B?cm55cnIrNlFqR3lTb1lPdm01bmJNWjVKZHNRODBTQVh0VTJHZnpVNlVDV3BI?=
 =?utf-8?B?eVlHSWU4OHpQY1dqM3VNeXlyZXAzdW00T3J4K2FtemhXcHVTSXRWYXJRUHE5?=
 =?utf-8?B?aXZGcmdWTEJTUUEwcTI2Z05lTTA2d1F6M2tiVGJJTGJyZFd1OEVpNnJIM3FK?=
 =?utf-8?B?Y2R2MHBDZ3dHeHlOcFUzdS9CSkhUQndKc2pYbzc2R0pnU3haTUQvWk5CdjR1?=
 =?utf-8?B?L0RlK2c2WnMvY3ZuWFdKYXpMbm5Pa01OdGhxRkwrWVF2dE9aM3Q0L1FQQUFJ?=
 =?utf-8?Q?BIWWC5taQzBrcq6l1FlMgh4k2rKMRDEE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:58u2ECMjzmE8Wg44uz8NANqnBDNT4iaUm0E61BUuiUNxoXaIsH47FPO7bA4QU+yKtKWwdcTZjoRGm2w9xMGKu86E5YYADZXen1MS/Dn1SCsNmlQv3kk+rYZSfJiBzMeOD8+ZpbFSdvHmErkBEsNrCX7PbGRLW3ohaAIgRGFUCPuu6OP8orZsWCRYzgnSJC2NwKoZ/UsMi30NTtNj4/uYfEGR4fh3SiiXUushtWlu3hkhHGPS6raPoPeDvJenAUGoe5bT6zE6Lsd7Tk1lCTAKwg+Lm4u2VuhqizLGZIdXjvsIol9kj/uaLKytjE+vhosCJawfWRXOwMk1g/9/lweIsBaY/le4zRo83nnrKezMUrE=;5:vH8ToN41Tb4XSeIgZfkGVxMVpXaQFIIiY7ULxoRAtLi0IGsIJflPiDlnTAaa0CouDAagN/IPkPj65q/x5INPTiGtJRT6FBs8M4nd+8bQAK2cPa7QVekriQvyxUzf5qMf0MSaPKWm5SXcJx0VihtBwCHdO7JHU9sA7eNLBlm0+lw=;24:If15JJYmZCavGNrxz4qlejwCW50LjMBmzRwd86bZjsV1VGcCyGGubQghNZqruYij7nJsqK+4IEKM9h4XQ8MahSEuXSdKs73nlWMen57ZZCk=;7:0ohYsOL3IMGE+QXM3aj5x8cUyn32H/mf6CzLHdajr5L8fxUqEdug+30f7Wt2WPuENqOj45dmXR3JRxfJoBzac1GIuBy4YOKxwXjY4EvVw5ultIWvnFRcvqsl80BzCi4OPCeD+J+n21HhSdT74fqSYydVBHwoW48AY3LiRaxfaG6S2B7+JZ9SpxzAxjgiL95MPZmfUYSp+AkXQnrVK8OY+nJUS+BJYVC5E3lJ5EOptg9TlqHVkYWL1mv44ro4ngit
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:CWVtSwt4Z2PSXkIRpyQ+lQHhGBCG2qxdJKyt91N8RVF79qTzDfR4Tz0eoETL+7rjzoMpe5s+VuKTcYw64mXvS5Ehd5gs2KANrBIq/U3tB0XJuhfeA55fAsOazkE4v2ZsH/1lRi6YpyqfMHT636lanwhxFVgwrygZ2MJGiQOP02M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 21:47:56.7304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72483826-f1fa-483d-7f6d-08d56ce21ea6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.2018 18:55, Christian Brauner wrote:
> Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
> it is possible for userspace to send us requests with three different
> properties to identify a target network namespace. This affects at least
> RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
> network namespace which is confusing. For legacy reasons the kernel will
> pick the IFLA_NET_NS_PID property first and then look for the
> IFLA_NET_NS_FD property but there is no reason to extend this type of
> behavior to network namespace ids. The regression potential is quite
> minimal since the rtnetlink requests in question either won't allow
> IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
> support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> ChangeLog v1->v2:
> * return errno when the specified network namespace id is invalid
> * fill in struct netlink_ext_ack if the network namespace id is invalid
> * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
>   indicate that a request without any network namespace identifying attributes
>   is also considered valid.
> 
> ChangeLog v0->v1:
> * report a descriptive error to userspace via struct netlink_ext_ack
> * do not fail when multiple properties specifiy the same network namespace
> ---
>  net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 56af8e41abfc..c096c4ff9a00 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1951,6 +1951,59 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
>  	return net;
>  }
>  
> +/* Verify that rtnetlink requests supporting network namespace ids
> + * do not pass additional properties referring to different network
> + * namespaces.
> + */
> +static int rtnl_ensure_unique_netns(const struct sock *sk, struct nlattr *tb[],
> +				    struct netlink_ext_ack *extack)
> +{
> +	int ret = -EINVAL;
> +	struct net *net = NULL, *unique_net = NULL;
> +
> +	/* Requests without network namespace ids have been able to specify
> +	 * multiple properties referring to different network namespaces so
> +	 * don't regress them.
> +	 */
> +	if (!tb[IFLA_IF_NETNSID])
> +		return 0;
> +
> +	/* Caller operates on the current network namespace. */
> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> +		return 0;
> +
> +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
> +	if (!unique_net) {
> +		NL_SET_ERR_MSG(extack, "invalid network namespace id");
> +		return ret;
> +	}
> +
> +	if (tb[IFLA_NET_NS_PID]) {
> +		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
> +		if (net != unique_net)
> +			goto on_error;
> +	}
> +
> +	if (tb[IFLA_NET_NS_FD]) {
> +		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
> +		if (net != unique_net)
> +			goto on_error;
> +	}
> +
> +	ret = 0;
> +
> +on_error:
> +	put_net(unique_net);
> +
> +	if (net && !IS_ERR(net))
> +		put_net(net);

1)When we have tb[IFLA_NET_NS_PID and tb[IFLA_NET_NS_FD] both set and pointing
to the same net, this function increments net::count in get_net_ns_by_pid() and
in get_net_ns_by_fd(), i.e. twice. But only single put_net(net) will be called.
So, after this function net::count will be incremented by 1, and it never will
die.

2)The whole approach does not seem good for me. The first reason is it's racy.
Even if rtnl_ensure_unique_netns() returns 0, this does not guarantees that
tb[IFLA_IF_NETNSID] and tb[IFLA_NET_NS_PID] will be point the same net later,
as the pid may die or do setns(). Racy check is worse than no check at all.

The second reason is after this patch get_net_ns_by_id/get_net_ns_by_pid()/
get_net_ns_by_fd() will be called twice: the first time is in your check
and the second time is where they are actually used. This is not good for
performance.

What is the problem people pass several different tb[xxx] in one call? We
may just describe the order of tb[xxx] in man page and their priorities,
and ignore the rest after the first not zero tb[xxx] is found, and do that
in the place, where net from tb[xxx] in actually used. This is the thing
we already do.

Comparing to classic Linux interface such as syscalls, it's usual behavior
for them to ignore one argument, when another is set. Nobody confuses.

Kirill
