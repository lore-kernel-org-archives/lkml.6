Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeBGNUK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:20:10 -0500
Received: from mail-db5eur01on0127.outbound.protection.outlook.com ([104.47.2.127]:27556
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753731AbeBGNUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:20:08 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org
Cc: stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
 <20180207125320.9103-2-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <942f99e9-086d-25dc-e008-8de2c5c721b1@virtuozzo.com>
Date: Wed, 7 Feb 2018 16:20:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207125320.9103-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0072.eurprd04.prod.outlook.com
 (2603:10a6:3:19::40) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e96a52-4328-4ceb-99c2-08d56e2d809f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:bHGtw7GzP16q+gX1qrYATw8ueHVtBJAG8rkCcur5vRRwe/UfUq9H9suDw1mebBIouiV4+ZDPFQuwzcumlkHtzHWw1zlR+DWtY4h2GK7bqejhK9WUZNlM2ap3f47/OnPAXK0xZtx/25KMuh/JrP2BbaByQkPx7Yhxd1mQ37oj5CwIjsuxS7JhquZsHHgIEFFAl/50IYZ7d94aaTAJsB0EjISOlj/tNA4rQzwSRoF8hQ/WzQH1kz7WoSDdopJCXU9o;25:jvADlRvxzxIR+Gm+6hH1C7Gt1tCAqPzJWv70nw1Yikpa+QErEMe7NEYCWkvzUV57LNOVuazX3GKC+HWeq3+rJ2nviVHhf0QVIek/CVXKOY2M2E0eu1bTGufeQC5sCQyc0qDbifcfQw+SAtgqsHEnNCyj+Kjh07pAALjw89FShcsBCmmcCgjJkiDgv1Zq+4uLMekAvHBlgxRybOKOBWuWuGGYsFLQafL1AM67+qYAn3D1qEgvDij++skikV9qlCrlT0YJa0mZA0TqphmAEU3gz+EMXaKDPp9QLtRFm3F3GTiPYeZ8QU1fTCNj691Q3eqPI8WLqePmCW+MdQjXH2NNKQ==;31:ljY1EKCLavbPoCtowxhl+paNL2WwJgIjcs7uQngfhwbCHLrfRCxX9YT12F60LWU409EI4VlIUEHH8JXnZXNw3NpbG6FgDNAbnei4qWOx0SAzkb9AP7g1YOWBFT7By5C3UCgX6dSxTelKZQ3s4th+HCqXs6C4JJzpoWry9q/XSUp5vHjdKJs2kEbbBKVDYu1wIyClehqfOMxYs4RL6LYHeU9biA7jbYjnEaSTJz70oHQ=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:xgZFqjwhgCZGjc2Ax/RI6ZlUGNfjFyEBeNMUFOo2409XRoyGnj2flZipiiNNWbM1ODcjKmiYItfb1cvay2ChMpNYcF985rZqylkiXjny1a5ikS4rbeaGXDKgkKE3w1m0mZNjMbRG+nNok7lArirnVdN4tyjYeyBKbFagO07J7JTrLWl/ySsemEvDKoyDtOwxPqjOREkZ4iyGx5+9Qtkn/MOD1HzY020cPH2WwfeCi7r2GjkTQkzwgfBEguBBXVVg60NlIhJvKtlmbUNO0ssSFVGWd40jZdU3prRs5ty2xqB4sTPTn3F24FfiDpcZ+BgOje7i/74R0vO+UT6KlXRGRxIOQmgtwDdT3ZY2DutFufc52F3yf90jkUkW/ub3HqOA9WmBpScGQlp/nmCoyYUX9LXdx8ySxWjc/xXEns5AZBg=;4:AuCq5onIV+357l0oBX/9e+FWIv9NLU4IYhK12mt3OcOi0g9pm/4xct7r7dQqf/3q9sAG7sXXvGwuvJgJB2FyrPK1tcYisjpu7Sol4A4y6mGCinu0aZOvvjsYjotuBIfWJpoAfJuSO8TOd7QWJxXcv6C77CWfetdEqhMeZs/gOI5p+st5Nu+Gs23Y+1y/BVCW4DQSOnJh5PrIYVjkKyLNk1w0RDCD4cKAIgC2TMDg75e/s6CGhVyu/Na5PG9QKkfkbxc0/mzEgO7dyR56dE+MTA==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1335B8A30C864BE4EF16C53CCDFC0@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39850400004)(396003)(346002)(376002)(366004)(39380400002)(54534003)(199004)(189003)(68736007)(83506002)(53936002)(31696002)(50466002)(64126003)(6246003)(36756003)(23676004)(25786009)(58126008)(55236004)(59450400001)(106356001)(97736004)(76176011)(4326008)(316002)(39060400002)(386003)(52116002)(53546011)(86362001)(2486003)(52146003)(16576012)(105586002)(26005)(6666003)(2950100002)(5660300001)(186003)(229853002)(31686004)(6486002)(8936002)(65956001)(66066001)(7736002)(47776003)(305945005)(7416002)(65826007)(230700001)(16526019)(65806001)(81156014)(6116002)(3846002)(8676002)(478600001)(81166006)(77096007)(2906002)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6bWtZS1pSeVFNSXY2UDJRVGRDVUEyUmhB?=
 =?utf-8?B?ZnZRVmJiMW53MkhWQWh5cmx2Ty9Sa1YrcmZhb25XenRwY1FEOTBrU0lFSTVF?=
 =?utf-8?B?VXJLaFJHT0hRVFpzQzFoVVl2dGhUQjhpcy9ZTTI3UFFFbjZUZ0I4TGVTNXQx?=
 =?utf-8?B?RW41MUVQL2Z4cTYxaFJ4RWdLN1FUL1FoUkdNTWkrcXdxanB1emRhWkJueERo?=
 =?utf-8?B?QnVlVStaUUpVOG5WbDFwU21CcGtmVVZIMExNcEU5aG5DNzJnZWZuc1AvckRV?=
 =?utf-8?B?Y0hLWG1SNUY3bmdMbGpqWlNJNFBhR0JSRlhPZmdqNStXeUFkQzBJbllNd1d1?=
 =?utf-8?B?YktJSFZLcTRDVFFNZmdsL3YzR2lBZVZhWUc0eVdFbHZFMmJPZFJKRW9FbWFs?=
 =?utf-8?B?QUtyNkRxUkQwVi9WSzRPQ0NheHkyUjJsa05YUy9EM0xZK01lbExVRHo4TWpH?=
 =?utf-8?B?THhiNElKeVpncXRCYVU3WjE2NTVuZHNvVnhJa0lRTURaZ1l1a0J5U0lCbi80?=
 =?utf-8?B?OU1yRkRpMTJnaTJuSjdmT1hvTG9NUmF1cE5EVXhPM0ZCZzlaSFZmeEdSMkkv?=
 =?utf-8?B?S2VYNjVpRFl5UmpZZlJzRis2K1hKcitGSlFldW1rUmZqT0ZuK2ZkdDdoRTdQ?=
 =?utf-8?B?YkpSdEUwWnN5MHozWGZoR2NTVUhRT1FrVVcxY0RrYlp0c1dGeTZpeHp2Z1hx?=
 =?utf-8?B?N2xndXU0Nkg1K2dMTDI4S1RZUm9ZMDVUQ0JBVHoyS3p3YUhNOWVGQ0pVVzFs?=
 =?utf-8?B?QWp4TGc1RmJOczI2dUZUWnFvWHFMS2VTL0lDbi85UWVWdmxKTHRJOXNzeDlM?=
 =?utf-8?B?YXR2c2g5WUhaZGF2bkZ6UjlJWGtJU0ZxdGxYbmFWKytNNGVoSkVVcElSYi9G?=
 =?utf-8?B?MnZ1VGVEN2t4Mk5xVElhcEhhUStMeEd4UEZlN0Q1QmxoT2drbXBFbDhtTis4?=
 =?utf-8?B?MW9kMmY2MGxWK1JBZkM3QzJZTTI1K0dGUkJLQmhuaFpweVNaNXNVKzFaY2ZJ?=
 =?utf-8?B?OUZ1MjlmY1Bzc1I2MzNpT2pIU0pYTFZPZURRcndPcW9HdExmdnppVGNrWmly?=
 =?utf-8?B?VGxDa2xhNFE3YXMwVy9Wb3l1YkszbHhlem5PNHlXMmoxMkJCMnc0QVI3Q0k3?=
 =?utf-8?B?Y1NyaW1BZFgwd3Y5VVNHZlV6SzVCY0M1aXpYTWFOTmJnTkhyS1R0Tk5QVFVT?=
 =?utf-8?B?b1VneVViN1R1UGN6L0VEb1RRdXpJSUljcnh5S1ZnU2VvS3d2RFBhdVVZOHg1?=
 =?utf-8?B?aU9sU2FVNHA1ME01YU1UTjdQVTF2MnUvU0lEMTdGamhZSXBxdjc1akVHTVds?=
 =?utf-8?B?Q0dJb1pkejRHMTcxdVZQR3A5WUVjNGZRa2h6enRPbXZORWlWcHQyVFdNMHh5?=
 =?utf-8?B?Z1pZWW9NV1U4OVR3cTYzdk5HU2hNaG5HZjBSbkdmUUlvVGNiNERrT21uTjVq?=
 =?utf-8?B?dWVvMEtTTUFyNjdGaVNuUFpjbE9WTnRraDIyTGVFNHRMVzF3d2YwRkpaQSs4?=
 =?utf-8?B?S29CcG5LZUc4c21MMUpTYWZtSVUzSVIwZkZ6ZForQXFTNkkyNlQ4aTZBTm9l?=
 =?utf-8?B?VUF1aGlIc0JIeUFZS28wVWRxaW1RdjRQV0RSbFc1bzNmc3k4WkRiL003Tk00?=
 =?utf-8?B?ZUFpS0RKOVFLUFRvVzZycXExK1JwYXVIU3I0WGtlSk9nUzJCVy8wYVQvVk53?=
 =?utf-8?B?NGFrQmJTb2k1YzJqeEJrbisyY0JTRUp3aUhEQWc5N1hEOVdsZmg3dHVaOStL?=
 =?utf-8?B?SWhJcGpoTk9rL2JaQ093MzN1STZGdnFjam41ajJzUzJwWjZjUDc4d1puYmdO?=
 =?utf-8?B?bmlnRS9kUUxHVG9QalhRS3VVd2haWWhoekV4dDVvYlp2RDF3b0NDVWNnekF5?=
 =?utf-8?B?NUxHQnp2TE9HRjAyejZVdlVNeGZGNEhZbTA3NStuekhPU3dacU1BSzNyUnl2?=
 =?utf-8?B?cXpTblpoN3Z0bytPTGEyYWJWdVlRWUdZZnhRRXZCanh6ZTdKK2RJbFhybTg2?=
 =?utf-8?B?ZVJ1dmJ5Unh2Mkk0REpHTERzWjhmK3ZDWXdLZStlRDZjaE9YditKdEdFZE9v?=
 =?utf-8?B?Nkp3NmZ4VDNHVW9USTBGOHRsakRrUHhWK1pHQ1lDK1ZWQXpGamV6THREallr?=
 =?utf-8?Q?5tpwiaX8wCziUFxYT16Q5BSbI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:8mBYT1eqAFEugOPrfSt/LE2bq6dT1ifuiNloIMEVQC5WbLCbJ6qfD5yxJer2BmeEnFr7i1HyRyivUNWbrDh+Or7rFgkDCMcNNF/cf4BOIuf2uRLjPGK6nx1uQn9E5BZ6IE8Jg7lgxBwC1aeLQ7r8Wxq2fGC3cim8wwjX3KDmz/qgafx9F3YcBE7Y33LFlK8xyeg6z91QLEKw2Az1X76zKb9Nv/rIYAmQkoXqHhL4+FxWnInu5hdoDstQM5l7wl+MWGd+LheDHfG60xL7q/ybYjfhItLOdqS+ltDMtbQnSgavpZjEIkiH2GGtbBQOM7wnqEtlRzRFYXFtKiZv99tXZPxeI3fCA7Rdi2yLnOeo1KY=;5:umFjHe3Xb9pfIp86MLiAzvNOQCc3c8xLxT4Dvt8p04mHKg79Hh+C64+zPiuOPL5/SfCisr+4q0Tq4FQG4yBn7VMjLl+QzcG/F5ROv8ORqN8sUNg3H7MG3T6+dasLplpx/MJBBFgZ0cs1zqornEMhnGM1/Hz0nDUmprY8NUUhcuw=;24:1zVPLv0mwTLg3TGyJyrZGU1W5qqkWHBcnQINzk2v+I3D7wzotyJZNIDftZDOcgxXfuTrnHIxEBUs8BE0EYqs38KwqrfFSHMGSfn8fDEr5R0=;7:IWP3bWCMQjwQiCVyeFHOWNjVo0tFAdgfbal4k8j6OUAR1PpnDohc2jZQEq9Um5/Qb1QCitKZstVqfQniyOk9XfsxGRVKDR5GvsmZrz0YyzGUM/bvma2Cj8TSgScQ5RfYMxsyub3QPAqErd+PRGfeFEkPpobgifgJ4TdCb3ajRGlXffNbdpNVNoKPcPP3qWv0MNgtKnD+SbK6wD0MHlYzW3SbQAmvf/MVmf5ZXYmIFSB75z1h+E4bZXQS7DM42oIL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:ZN1NfBhtfdyP3TLc+A0pzqUKOpB5Agp8YdZDec9YwsBXFYvIlSiPAoCgK2ZNMSR+9ovjOIcISLqSWmXQP58ZKh0CoodPr1jxtVpex/IFo9iHK5W3hc30Ok0bA5/dSpAlnC1NTjEW5ilk2EpRtiwycXIFF9CYwl0aQ8fu2szxWvM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 13:20:04.4101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e96a52-4328-4ceb-99c2-08d56e2d809f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.02.2018 15:53, Christian Brauner wrote:
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
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> ChangeLog v3->v4:
> * Based on discussions with Eric and Jiri: disallow passing multiple network
>   namespace identifying properties for all requests, i.e. always enforce
>   uniqueness.
> * disable passing IFLA_NET_NS_{FD,PID} for RTM_{DEL,GET}LINK completely since
>   they never supported it
> ChangeLog v2->v3:
> * Specifying target network namespaces with pids or fds seems racy since the
>   process might die and the pid get recycled or the process does a setns() in
>   which case the tests would be invalid. So only check whether multiple
>   properties are specified and report a helpful error in this case.
> ChangeLog v1->v2:
> * return errno when the specified network namespace id is invalid
> * fill in struct netlink_ext_ack if the network namespace id is invalid
> * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
>   indicate that a request without any network namespace identifying attributes
>   is also considered valid.
> ChangeLog v0->v1:
> * report a descriptive error to userspace via struct netlink_ext_ack
> * do not fail when multiple properties specifiy the same network namespace
> ---
>  net/core/rtnetlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 56af8e41abfc..bc290413a49d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1951,6 +1951,38 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
>  	return net;
>  }
>  
> +/* Verify that rtnetlink requests do not pass additional properties
> + * potentially referring to different network namespaces.
> + */
> +static int rtnl_ensure_unique_netns(struct nlattr *tb[],
> +				    struct netlink_ext_ack *extack,
> +				    bool netns_id_only)
> +{
> +
> +	if (netns_id_only) {
> +		if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> +			return 0;
> +
> +		NL_SET_ERR_MSG(extack, "specified netns attribute not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
> +		goto invalid_attr;
> +
> +	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_FD]))
> +		goto invalid_attr;
> +
> +	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_PID]))
> +		goto invalid_attr;

Can't we write these 3 above branches more compact? Something like this:

	if (!!tb[IFLA_NET_NS_FD] + !!tb[IFLA_IF_NETNSID] + !!tb[IFLA_NET_NS_PID] <= 1)
		return 0;

Also, do we really need two different error values and error messages?

Kirill
