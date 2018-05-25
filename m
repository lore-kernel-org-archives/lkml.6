Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030775AbeEYWCY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:02:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030465AbeEYWCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:02:19 -0400
From: Song Liu <songliubraving@fb.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len in
 tcp_probe
Thread-Topic: [PATCH v2 net-next] tcp: use data length instead of skb->len in
 tcp_probe
Thread-Index: AQHT9BEzdsZVRYb1gUyc62SrUQVIhqRA/wqA
Date: Fri, 25 May 2018 21:59:02 +0000
Message-ID: <CBE161A9-5116-4866-BC89-CFF6B2509E0C@fb.com>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::7:1409]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1214;7:zzHoOnQcGZei2A20x1+pIArs8DBsYRX3sVfdx6NJsMtu80Zojmmgw3muqLR1qkcN6vzuRZrtsEpR04XOR0KWYX+mWFXKxbHi9uN0xAbALR5YlPo5NVEHRnAgbI4cBr0ScEs2cecJSZg/D2E/UQ6NJ7iqcEU/Rva0QmmND6C4OZaIQZ3n/jNiuGwzaeeMAoc47fwdlfVHx95StV1+5N2R6XD/yayEFIrihgXpsNYI80FpdcVWKI/HyjHA1EDQIAlq;20:9xxFKcTcBg3LsuaqIdND5pc/T0KxbOI9fde3dvXpc8Pv4ZGVwPFR2GjL/0Xwllz49Pi1AtDqaqaioNwbpTjw62t+O6nLTp+4ZgfNPoTM20+cpPDtPCoalVIAtiAkTCcads7XUXJo6SH6yNY3LzUyYEOfLpCxyS75zaTWNxXaX4A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1214;
x-ms-traffictypediagnostic: MWHPR15MB1214:
x-microsoft-antispam-prvs: <MWHPR15MB121450D4F7364F685FA8E322B3690@MWHPR15MB1214.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1214;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1214;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(396003)(376002)(346002)(189003)(199004)(316002)(99286004)(54906003)(68736007)(7736002)(305945005)(102836004)(83716003)(6246003)(53936002)(5250100002)(39060400002)(4326008)(6916009)(36756003)(8936002)(81166006)(5660300001)(81156014)(86362001)(25786009)(50226002)(14454004)(8676002)(186003)(3280700002)(478600001)(3660700001)(53546011)(6506007)(2906002)(57306001)(76176011)(486006)(476003)(2616005)(11346002)(446003)(6116002)(229853002)(2900100001)(6486002)(46003)(6436002)(33656002)(105586002)(106356001)(6512007)(82746002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1214;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qd3l/+KdwVTw5UgDTwhNf11K2kvUlTMI7JAXIazF2Z0zlHsEEbsNIKQmuDGfhBwOXbYQ+JmcX1tghm9s8NC+qRWhBJm/Gio47YDWfadLV6UIhyUPQcy5sXbuXw/nAYezZ8xw5HJWVqXRDuDDI4FRrfPxHHNSMm+5upSBRUZECFZNTfqCGDPLXX+TYQg6vsGI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3D8E0BD2A29FD46A8A6F3F5377544FC@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 79eaa413-15ce-4c38-84ba-08d5c28aba20
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eaa413-15ce-4c38-84ba-08d5c28aba20
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 21:59:02.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PM2qrU024723



> On May 25, 2018, at 3:14 AM, Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> skb->len is meaningless to user.
> data length could be more helpful, with which we can easily filter out
> the packet without payload.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> include/trace/events/tcp.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index c1a5284..703abb6 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -236,7 +236,7 @@
> 		__field(__u16, sport)
> 		__field(__u16, dport)
> 		__field(__u32, mark)
> -		__field(__u16, length)
> +		__field(__u16, data_len)
> 		__field(__u32, snd_nxt)
> 		__field(__u32, snd_una)
> 		__field(__u32, snd_cwnd)
> @@ -261,7 +261,7 @@
> 		__entry->dport = ntohs(inet->inet_dport);
> 		__entry->mark = skb->mark;
> 
> -		__entry->length = skb->len;
> +		__entry->data_len = skb->len - tcp_hdrlen(skb);
> 		__entry->snd_nxt = tp->snd_nxt;
> 		__entry->snd_una = tp->snd_una;
> 		__entry->snd_cwnd = tp->snd_cwnd;
> @@ -272,9 +272,9 @@
> 		__entry->sock_cookie = sock_gen_cookie(sk);
> 	),
> 
> -	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
> +	TP_printk("src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
> 		  __entry->saddr, __entry->daddr, __entry->mark,
> -		  __entry->length, __entry->snd_nxt, __entry->snd_una,
> +		  __entry->data_len, __entry->snd_nxt, __entry->snd_una,
> 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
> 		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
> );
> -- 
> 1.8.3.1
> 
