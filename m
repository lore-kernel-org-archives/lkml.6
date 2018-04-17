Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeDQRjX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:39:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751230AbeDQRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:39:21 -0400
From: Song Liu <songliubraving@fb.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
Thread-Topic: [PATCH v2 net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
Thread-Index: AQHT1mqJ9xgfIFuRz0WmbFf0D1CdOKQFOQAA
Date: Tue, 17 Apr 2018 17:38:39 +0000
Message-ID: <A047B5AE-CA5F-4664-92F7-935E8ED4C0CA@fb.com>
References: <1523983016-11005-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1523983016-11005-1-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:6fff]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1642;7:c+eAhB/A4fg0L2eWieWcbnPz3TNIeAO2MHy+p06uNJTPJqhzhvfRvgEcnaSTdlsKQ8XAAlSy9hRnXLEDgG0nUVBlFLape4safI/jkvivCmSl+2V56dWu14+JNMOXw48O5ULg1RrsTDYCeDJfrsIOVC5OJFZbG/w2V43wG6oaQdEDmpj2b2WDKsNKWUx36QxK4T0O1q+BXLe3BhNvkp58XGGlMERfyWm2IFDktwT3aEO7wND5ku7p2lY63F0MVU1Y;20:TtxiD2JJJ+KsGupfPLzyZLbIteBAx08EQr3fAtLqVMwE2UlqNrvMLaNUfCB9Eev9i+i6gHgGxjqMkPm5nW2VUXrbmxL5jFVm//TNbD7l1CBynxolvx2whtmVXvQEVL1gka/AP18GtjDaGn6Sn7HpY1n1OH+724wUsjUZhMkNXjI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1642;
x-ms-traffictypediagnostic: DM5PR15MB1642:
x-microsoft-antispam-prvs: <DM5PR15MB164266C7152BF729267117B9B3B70@DM5PR15MB1642.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501327)(52105095)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1642;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1642;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(59450400001)(39060400002)(68736007)(2616005)(478600001)(5250100002)(14454004)(33656002)(53936002)(305945005)(102836004)(6246003)(53546011)(7736002)(99286004)(6506007)(105586002)(76176011)(106356001)(97736004)(5660300001)(6916009)(83716003)(6512007)(8676002)(81166006)(81156014)(316002)(11346002)(476003)(50226002)(446003)(229853002)(6486002)(486006)(2900100001)(54906003)(2906002)(82746002)(6116002)(6436002)(3660700001)(3280700002)(8936002)(57306001)(186003)(86362001)(46003)(25786009)(36756003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1642;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: U0BYtIb0ZeK6UvLUMdeSscURlE58TI+Sg8AadB+RmwLKybcj/y5znw+dH3CF6Ckovvxefvk2R2VDinZJs4D1qYH+aeb3DGZLLC8op6DeBqXUjUnicKCPb8lYRol9LzMkm5Bg5+ikGylZfn2CQMFHZcaNGcx7UbLu5iEaD8fo0z8tzgHJfl1SlAxQrs/Y83cF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4DEEA3228AE2C64187283981A4310806@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b565018c-0415-475c-d9bb-08d5a48a0e33
X-MS-Exchange-CrossTenant-Network-Message-Id: b565018c-0415-475c-d9bb-08d5a48a0e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:38:39.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1642
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HHdSm6006623



> On Apr 17, 2018, at 9:36 AM, Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> tcp_rcv_space_adjust is called every time data is copied to user space,
> introducing a tcp tracepoint for which could show us when the packet is
> copied to user.
> This could help us figure out whether there's latency in user process.
> 
> When a tcp packet arrives, tcp_rcv_established() will be called and with
> the existed tracepoint tcp_probe we could get the time when this packet
> arrives.
> Then this packet will be copied to user, and tcp_rcv_space_adjust will
> be called and with this new introduced tracepoint we could get the time
> when this packet is copied to user.
> 
>        arrives time : user process time    => latency caused by user
>        tcp_probe      tcp_rcv_space_adjust
> 
> Hence in the printk message, sk_cookie is printed as a key to relate
> tcp_rcv_space_adjust with tcp_probe.
> 
> Maybe we could export sockfd in this new tracepoint as well, then we
> could relate this new tracepoint with epoll/read/recv* tracepoints, and
> finally that could show us the whole lifespan of this packet. But we
> could also implement that with pid as these functions are executed in
> process context.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> ---
> v1 -> v2: use sk_cookie as key suggested by Eric.
> ---
> include/trace/events/tcp.h | 33 +++++++++++++++++++++++++++------
> net/ipv4/tcp_input.c       |  2 ++
> 2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 3dd6802..814f754 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -10,6 +10,7 @@
> #include <linux/tracepoint.h>
> #include <net/ipv6.h>
> #include <net/tcp.h>
> +#include <linux/sock_diag.h>
> 
> #define TP_STORE_V4MAPPED(__entry, saddr, daddr)		\
> 	do {							\
> @@ -125,6 +126,7 @@
> 		__array(__u8, daddr, 4)
> 		__array(__u8, saddr_v6, 16)
> 		__array(__u8, daddr_v6, 16)
> +		__field(__u64, sock_cookie)
> 	),
> 
> 	TP_fast_assign(
> @@ -144,12 +146,24 @@
> 
> 		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
> 			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		/*
> +		 * sk_cookie is used to identify a socket, with which we could
> +		 * relate this tracepoint with other tracepoints,
> +		 * i.e. tcp_probe.
> +		 * If we needn't this relation, then sk_cookie is useless;
> +		 * if we need this relation, then tcp_probe is already set,
> +		 * and sk_cookie is already set in tcp_probe, so we could get
> +		 * the value directly.
> +		 */
> +		__entry->sock_cookie = atomic64_read(&sk->sk_cookie);
> 	),
> 
> -	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
> +	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c sock_cookie=%llu",
> 		  __entry->sport, __entry->dport,
> 		  __entry->saddr, __entry->daddr,
> -		  __entry->saddr_v6, __entry->daddr_v6)
> +		  __entry->saddr_v6, __entry->daddr_v6,
> +		  __entry->sock_cookie)
> );
> 
> DEFINE_EVENT(tcp_event_sk, tcp_receive_reset,
> @@ -166,6 +180,13 @@
> 	TP_ARGS(sk)
> );
> 
> +DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
> +
> +	TP_PROTO(const struct sock *sk),
> +
> +	TP_ARGS(sk)
> +);
> +
> TRACE_EVENT(tcp_retransmit_synack,
> 
> 	TP_PROTO(const struct sock *sk, const struct request_sock *req),
> @@ -232,6 +253,7 @@
> 		__field(__u32, snd_wnd)
> 		__field(__u32, srtt)
> 		__field(__u32, rcv_wnd)
> +		__field(__u64, sock_cookie)
> 	),
> 
> 	TP_fast_assign(
> @@ -256,15 +278,14 @@
> 		__entry->rcv_wnd = tp->rcv_wnd;
> 		__entry->ssthresh = tcp_current_ssthresh(sk);
> 		__entry->srtt = tp->srtt_us >> 3;
> +		__entry->sock_cookie = sock_gen_cookie(sk);
> 	),
> 
> -	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x "
> -		  "snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u "
> -		  "rcv_wnd=%u",
> +	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llu",
> 		  __entry->saddr, __entry->daddr, __entry->mark,
> 		  __entry->length, __entry->snd_nxt, __entry->snd_una,
> 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
> -		  __entry->srtt, __entry->rcv_wnd)
> +		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
> );
> 
> #endif /* _TRACE_TCP_H */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f93687f..43ad468 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -582,6 +582,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
> 	u32 copied;
> 	int time;
> 
> +	trace_tcp_rcv_space_adjust(sk);
> +
> 	tcp_mstamp_refresh(tp);
> 	time = tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
> 	if (time < (tp->rcv_rtt_est.rtt_us >> 3) || tp->rcv_rtt_est.rtt_us == 0)
> -- 
> 1.8.3.1
> 

If I understand this correctly, you can get all the information you need with
a kprobe on tcp_rcv_space_adjust(). Why is it necessary to introduce a new 
tracepoint? 

Thanks,
Song
