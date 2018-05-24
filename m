Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030855AbeEXRpB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:45:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030394AbeEXRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:44:54 -0400
From: Song Liu <songliubraving@fb.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] tcp: use data length instead of skb->len in
 tcp_probe
Thread-Topic: [PATCH net-next] tcp: use data length instead of skb->len in
 tcp_probe
Thread-Index: AQHT812Y4wWR4KLb5kOT+YUBetOrY6Q/JxKA
Date: Thu, 24 May 2018 17:44:46 +0000
Message-ID: <630ED9AE-A932-4B6A-8236-D133CE3E0726@fb.com>
References: <1527166097-10908-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1527166097-10908-1-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:2027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1259;7:LmD2Nh4M1Ja3s30GDsCXuKAtq4K0S6vMkUUBR7wKgP1LcRH04wXJj+OPvfmyl8OSqFPTwWLzsAV7CZKmgV3nrHOtuRlH9upD8/1R3CbAuwG/V03Izxq2AzvyVQQ+ad1HwFAItd6Ml5oFvKN6BYXxbRp9OLP92+i2MJyVR20Vn2HdLVm5oOjfDsR6FCE2Xz2NEMFFCDlStK0PdFfUMo27gI9LN/T+HT2uy+Rn6ZvIrIQWB74OAM9wNp47tfUdzO1T;20:vc7c1UcqsQD2GdyXIkJfjxFWn9zPSadnNH7FgDan/YWT7nW+GpN//HobkQd+9/YmgxnEHzWBq+acTVliFz0xkVf9R5Lra5MwsJADnqteUurBmCYl0wFob9oIN5Ez8F+CQFND6uVXe56CYAc+TiruKB3bJ8eEucS6rDAPH7hgNCs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1259;
x-ms-traffictypediagnostic: DM5PR15MB1259:
x-microsoft-antispam-prvs: <DM5PR15MB12592304D499035DB89AF6E4B36A0@DM5PR15MB1259.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR15MB1259;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1259;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(377454003)(164054003)(51704005)(24454002)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(62966002)(74706001)(36756003)(33656001)(77096001)(77156001)(76786001)(76796001)(81542001)(93136001)(92566001)(46102001)(64706001)(82746002)(81342001)(92726001)(77982001)(59766001)(56816005)(80022001)(76482001)(90146001)(89996001)(65816001)(83716003)(87936001)(57306001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(2656002)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002)(3826001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1259;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mt+WQ4zsgg7REu9m4IKEXC5C3EnmKQH1VzvamY45rwpAjFxei9kMWFUyTrDIeukKK/GTFFvZOshaMpUH6rmHUAbg2h5oYqGANV2R+Rycwa1uuXPuUjuwX+Ty1FfQyKximSkMaVT7ScrE9q2I6K+/By7a3BYpIL+eVFJVh7AbzBFyUCzWVlQ8topfbZEDfifK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A8CD1A8C7A51E4E93F481897EB3E911@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 68df6bf9-b4b6-4f7b-c196-08d5c19e0a4d
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df6bf9-b4b6-4f7b-c196-08d5c19e0a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 17:44:46.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1259
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4OHj8CK012281



> On May 24, 2018, at 5:48 AM, Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> skb->len is meaningless to user.
> data length could be more helpful, with which we can easily filter out
> the packet without payload.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
> include/trace/events/tcp.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index c1a5284..259b991 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -261,7 +261,7 @@
> 		__entry->dport = ntohs(inet->inet_dport);
> 		__entry->mark = skb->mark;
> 
> -		__entry->length = skb->len;
> +		__entry->length = skb->len - tcp_hdrlen(skb);

We should also rename __entry->length to __entry->data_len, so that whoever
using this field will notice the change. 

Thanks,
Song


> 		__entry->snd_nxt = tp->snd_nxt;
> 		__entry->snd_una = tp->snd_una;
> 		__entry->snd_cwnd = tp->snd_cwnd;
> @@ -272,7 +272,7 @@
> 		__entry->sock_cookie = sock_gen_cookie(sk);
> 	),
> 
> -	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
> +	TP_printk("src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
> 		  __entry->saddr, __entry->daddr, __entry->mark,
> 		  __entry->length, __entry->snd_nxt, __entry->snd_una,
> 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
> -- 
> 1.8.3.1
> 
