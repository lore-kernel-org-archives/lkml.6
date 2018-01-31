Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeAaVyj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:54:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753244AbeAaVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:54:36 -0500
Date: Wed, 31 Jan 2018 21:54:08 +0000
From: Roman Gushchin <guro@fb.com>
To: David Miller <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <edumazet@google.com>, <hannes@cmpxchg.org>,
        <tj@kernel.org>
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after
 mem_cgroup_sk_alloc()
Message-ID: <20180131215401.GA8956@castle>
References: <20180125001911.15597-1-guro@fb.com>
 <20180125.120302.1117695034222616751.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180125.120302.1117695034222616751.davem@davemloft.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:180::1:3c09]
X-ClientProxiedBy: CWXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::35) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9186df35-f1da-4ef4-de97-08d568f52ed4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:hs3bm/smQWR4VtzJ1rfoZHdpKwfbAPvf3mV6cpwT5dl+rwXezhrmqq7DXfEvOl6raYZs3irBAA+wNppVc78Nn4iSPmEvgouA5MHl11JZEukENyR17OTzcs99J2d8XBmrO7Ict6ATKrSA5cPhOdOUypg/EHSX55YXbarO/WR8H7hBox00Wg67dTllc3r5eMOSXYCQgnBxK+SvGDsDa5nQoIN+va5PW11an+GgbZCUkMiD9oP3gm0fPtDJXgGhbhTv;25:AXPYg+7+5yenJtClKzvXcUeNOe6zySsOjswIpscsrpZVwalynDJh31sDcfyxiQv94/yR9ocB/Wlrk542Nwha/Ho2qf2G+Opq2xdaKuvufYKgqPn0rB2/+AmQyVYssyltEGzTPhn9jlPFtECWyGqc+QC7gbx5N1bF8Af7xsiSbxnM4aT+1nEMy00IkKNYYyIT6QAgc/KfS6jkWX/8kWbsdPSMpP3+6y1m93efX5Kf8Skv0JzdYRxzmwpCOdPj9bmBLbgzOgUfRqQLg6nqGuOPth8segbRtzB28Nje8TmYcInUa2kVXYrQm3pPLg1AaBUqeveQRAKUlGm9N/Q5x7Z+VA==;31:LCQ0SaXTHsgbZm5tFnXS79SdubVLC73LLpYriNIu5JoDRfuJDgSwkMBgXd8HR9cYhqMxxjLWtv+jcC48SMJP0DrYWlvaMckf7YjA6D+2KeedDNqGqM1eSFRnTl3eEDxMXEyLctqTffuWdlOLmh3gvaVN5NwSU0MjytzyX7OrD28/i9R3vLUxK/vv+2xR1GyjxfODy776kdwnR8aIrDjSxQDExtYlJ7qOznfhkus0Kqk=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:C+jQh/rnw6RYqg/0PngSv5miIVqtZv5rJ1nKU/6rkOdufxIHp3xefqA4tblVhsUTDNy/ygIIrh7k5GeErc1us+gJGgS7GZCpfrjBO1aVK6Jrx6VPClt4gSy/Rcqz88TZ3VaPqU66794LFw8vkVvmdAz9ISm7gIMFpf6k8e203pLtyRME3SBPhgwzg1kdvJxO/qRiT3L11OfKe4AKhTkJNlRAC76lz6v3shWrvfZznqJbx8lCOEUODe3EdmnJvCpICNj2UOOc0ccgVgr6bRu2x2vEXaQHhSgFi9w9X1mJrzb714FIdWc17RoX6YfLN7kU5GniaGiuOd+dhPbT9aC+Wj1hgBCFcssyzy8Hje/TC9jHIebsfn+A7BJzoQFcUM1DWCfON7m3CkiqpsAiAPA2CvfRf525o1kddHy0A4Y+zL+IPCaseQWs1iXozTp4uGh2kJQ26gNfvrHgrC01ZBb4dpNRznZ+NG4seC7SD0ykMX+i5G5KimYjkh3KpD3Km7yz;4:L0qAnJnr3qKM/Ch84UmELUFSOpnd72/531AaR6PB/ut1TjXz0g0e61lSrjyMLPQNbMYWChNtElPab9tAC79/PKYoZOO+R29EtPHFk4no82qWRdviRqZ0yGO8d/nmMLwPAMdMBT2L9L3wPq9bDUQEr2o9M7CsL6E6qO0BRjD/ZFKmGRDl/T/Q0sDdwmvf1T6jI8jS9W4c3Vkb6AHxFpZh4c9iFlL9aaVISS/PCKtfRpgMskRrpOSPEZJ6dFX8u+yMK36wPB+a7BM5vKsTBFWFUA0r+D4GQ9EnupxpQT/zNJQeAa/IDGep1H4uau1QvH6R
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077E929258E4D16D546F18FBEFB0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(2400082)(944501161)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(59450400001)(33896004)(23726003)(81156014)(6116002)(1076002)(8936002)(81166006)(8676002)(106356001)(68736007)(6916009)(229853002)(33656002)(55016002)(6666003)(7736002)(9686003)(25786009)(5660300001)(2950100002)(105586002)(2906002)(53936002)(305945005)(6246003)(4326008)(478600001)(50466002)(47776003)(97736004)(316002)(33716001)(386003)(52396003)(6496006)(186003)(16526019)(86362001)(76176011)(16586007)(83506002)(58126008)(52116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:qYnXkebRhq3GyrvsyR9DqSIQWGJzp99uSeI1ejdMw?=
 =?us-ascii?Q?iw1j2vEJXpqQWErQlpzi1EHb+3zIrM8NZb3OBRh3feo2l7TtVJAf8+tA3IvR?=
 =?us-ascii?Q?1WL/dafsAvIgEl3i4GOBuCzeCy+CbRUl13aDsw8+w/qB9EvwtQldDXB3yAA5?=
 =?us-ascii?Q?fdva2qktQb3QbKj8pAIhv+bV6l0AuKFQ71xxXsnzIqpWna3XOeGMrlHreKsw?=
 =?us-ascii?Q?lpym01sDEehccolEFnrcH6bUmYmvRhjMGaR7Xxhz9cIS74hCHHgtdEYng5iJ?=
 =?us-ascii?Q?KDTJbXkr1OV950FO5Oo7YwV4S98VJO6eEQNeiDZBnqbTfS8JBTU/43CWnKhJ?=
 =?us-ascii?Q?i2kPjRjqmRLR8jvYrYLMt0UdqIo68TPJxrnpXEEjnJzSj7SvqHJHgi0+/aNI?=
 =?us-ascii?Q?yuLKEqgsBtHTHZrmmIVtBE+assqaWD110twvjO7HunJoqw2IXnp/WJLu9sqt?=
 =?us-ascii?Q?+x3ZoN8P4P4Jp/i5E6JMjD4Q/Kwn4GiVuvMuDf3n03TvUZfA5KJ+FbC+gcvZ?=
 =?us-ascii?Q?y08Hv2ABqndzjw4B3lqc9KpUzHmkacZn+XhzDRlbIYKp8o1hM2H6uBlfsHpS?=
 =?us-ascii?Q?sTXbybv1yIirq1EdATMbeGoRNZ1nk0PV3EKwICtzdUZgWVnTVzYB2h2qtN+b?=
 =?us-ascii?Q?3P09CYTfwAZJK6peF8kRTBYIC9pcInX6e9qqNtUW9C+HHrA0HiMjWRKUJQg4?=
 =?us-ascii?Q?+vEMD64ZC4gWEQq9XO+RcW3BOAIkubHRNkYI98MPiL4AMvvnNMlRZqVPha8i?=
 =?us-ascii?Q?Q/oINQD879qvHRURHc3G8XEh6HLhzQ3DzI5euDl1W4IdKXTo8qq73oCrLzpG?=
 =?us-ascii?Q?G0bZuau8GrIlaMKMfsjR5gUms8mA5M+UgMSEvbgF8EOmifFLumanDKzbvz6o?=
 =?us-ascii?Q?N2SrtgtpQkIi9EOWm0MKcOwzBWomatuLNKLuMgvUlB/AXJR0NB9hvH1EE7VC?=
 =?us-ascii?Q?H7gxxJQVVN+kwC2UxiF45Hn6hivmazJiJ3pO1ahjZRJk8Cs8Q58/VwFI4yLd?=
 =?us-ascii?Q?vtzPOBw9sIfS9OYpYzNXXVVVudkEajfbYD/ajqpmEx7lSBkd6xp1tAGLk29D?=
 =?us-ascii?Q?hzEjdoU4OfXc44sXrnERiy1H8hucHqMwazMq0AbB+kmoJeIjvvvOIUFPd1gJ?=
 =?us-ascii?Q?VnLBNS8P/FKm1zBEBL+Je5gvBm2hDBkJgX9EigBJWEejeoCvgd97ClQzWRBA?=
 =?us-ascii?Q?A0qRDxwGa55Fe99rDIKz3jEpDItkSmzxs6Xcrc6Trnd3YWPRgnEWLEBgqrWT?=
 =?us-ascii?Q?VI5dOuF3M7/OUIpW4c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:qBk3UcKf24HRYuLPYuHddTfi86d7fo3YPK6BYbXz1sKiaf30KZpPOoN+5rOZQUKKe8QKSSkY2rTzKY+o7GMopb9bW89ZMbIT3YXcEVseCe6AresYWeyAKzZNll0eqgZUdsUuvzvgYTFkxA6DQxI/XeNV4AfUGgf37yRdI972NnoCZvljMVunkcmovPOvrqXhPzjwjrb3ZNaqyeF/wHdP03fYhaptlFJNnOJml/JMzMHwRZWIq3Tsuv0bQaCgP+T6YfVEn+yZj7D+kYH27X7s0kCooWRlGD+UHLBg+C7Iut+LF16Pb40ColA02BVLHBC5DcUm9kzIhxc5gwAiFg7bQWFS+gpH8zOU6rcr7jQL1AA=;5:/VrMGKUOxh+oCdVp9mrozskq5QYK1chy1JKza9iY4aIJp8YfjoC+Bs5t1e21GxqGcl3laXL5iOJuX4U9X22uiHpN6aPs4EAqOghytzYrD8ZdWFNgXK1wcWEdzj7/v4KIf5NI3eD7xmlCDEASt1ZOqIJcCpqPUSfHInvT5MIOaCI=;24:ZQ3n5B4m7wr31TODM9P9HY5H6a5NdxxOw9MWii9uLdZaHSSLj6HHVAzPWM43HIqdPgJ5qvOS1z6xCo+K7m0dLNyga7ALL8Gns8eoO6wxSJ0=;7:s6F2BRcogMErKR7GU9UGNGfTaDpN0Z/MeW4UZDFqqPWU5HY97FQy1ATvhr5sQP2Gb9htH+bWaNppZtAo8O5JQoEgCvShhsRDCPk8dSNovs3IwgKV73eSdYMdC7bOg7lZy025IzlPov2+Ffjcpvzf56oYO0wZMB9lKPoyWePrdns+XTlj3lnB2RrVt6zkRoJMDTI27+ZDosTvPA5gXvurpU8E+4WCAh8O+SMZCk+JUPrnR/+9cW3dkGmfoJ5NfSiD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:uZzyyhnPf7uUAZpi/U2q2jtKHAPk9MkaJREIoXalQqJUdKGIn3ilSppDFASYATy8Oje/2flq2kOTCfyJe0rqdKTtS8Q9dgNnzpU060MrJeT+MQNvwVKNmBhceVq6zrnsARrD9JXkJpmyhfwWdB+GQyQ6q4sz1NB4A/9ufcPlz+w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 21:54:18.9302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9186df35-f1da-4ef4-de97-08d568f52ed4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 12:03:02PM -0500, David Miller wrote:
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 25 Jan 2018 00:19:11 +0000
> 
> > @@ -476,6 +477,10 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >  		spin_unlock_bh(&queue->fastopenq.lock);
> >  	}
> >  	mem_cgroup_sk_alloc(newsk);
> > +	amt = sk_memory_allocated(newsk);
> > +	if (amt && newsk->sk_memcg)
> > +		mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> > +
> 
> This looks confusing to me.
> 
> sk_memory_allocated() is the total amount of memory used by all
> sockets for a particular "struct proto", not just for that specific
> socket.
> 
> Maybe I don't understand how this socket memcg stuff works, but it
> seems like you should be looking instead at how much memory is
> allocated to this specific socket.

So, the patch below takes the per-socket charge into account,
and it _almost_ works: css leak is weaker by a couple orders
of magnitude, but still exists. I believe, the problem is
that we need additional synchronization for sk_memcg and
sk_forward_alloc fields; and I'm really out of ideas how
to do it without heavy artillery like introducing a new
field for unaccounted memcg charge. As I can see, we
check the sk_memcg field without socket lock; and we
do set it from a concurrent context.
Most likely, I do miss something...

So I really start thinking that reverting 9f1c2674b328
("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
and fixing the original issue differently might be easier
and a proper way to go. Does it makes sense?

Thanks!

--

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ca46dc08e63..287de1501a30 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -476,6 +476,12 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
                spin_unlock_bh(&queue->fastopenq.lock);
        }
        mem_cgroup_sk_alloc(newsk);
+       if (mem_cgroup_sockets_enabled && newsk->sk_memcg) {
+               int amt = sk_mem_pages(newsk->sk_forward_alloc);
+               if (amt > 0)
+                       mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
+       }
+
 out:
        release_sock(sk);
        if (req)
