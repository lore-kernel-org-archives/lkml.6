Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521817243-2-18424493552139916201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817242; b=BxgT9HnBlJTQKtmOo1+azcMtnPcExf+1RIwZLrubu4sPbOh
    iKD/n5F4zlHhOonK6kdR8Ec5Ts7+C5ngkdvmNxS5E830ON421L3nNiI2hPbsgP/F
    umVkO4WMpw9emc0NiLc/2hMV/gyfnEvpEZ94Bb/Fl42smr+hxfjGMPXnkqi8CdSq
    WwQHgSe+SN0h0x2wvHdg/O1eNojo6kjAUmeNVXZ4rHo7gIDktrleSzXSEX9TUmfn
    wfHrMwe6Q6kLK86qFMjW0u0S95p0ox1eYTaKyojZIspKUi/w2wk8dRbIFk4TihT4
    E8uqaYJ1cDlBUwmByGJoSOAfCfnokAPcAasEyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817242; bh=e
    hqhqlmIINyT+H9r6yx79ktR7zfb78nKyqM16f/kZiQ=; b=Pq6c+3E4AsuO0P+QD
    C2jo/iFfbMIj9B/55SgQ3btQgJfNgx3C5CZ87FMOvZ4T6CS4SBMLqUFTpGUii511
    cn/TVKH1WPoewZYCOKxcDGUepva/CuIoFvoapwfr8j1EI60SR11oOxpa1r1HYhhR
    uoHrEQ4viDJwlKr+p7RuZO/X3iXYb4SRu1TX84xNSkQez8J+AOBKk5PdfQ470ZzW
    7n4aRtiNYrBjaAH4RQ2A7jpV5BSsKPFhb70GwgkGBhDQwxRmWaq0JOuZyTt30Cbs
    JionWtFraWdIRrderkI2Bj/8qhA2kk5XYghqPGg+Jd4OFAPoTumQUzavyuAYVlfc
    8GaVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MMS+meCS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MMS+meCS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Long Li <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "James E . J . Bottomley"
 <JBottomley@odin.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Topic: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Index: AQHTwjxHWhwOiuv98ESE/MCGzQ8uiqPd6lwg
Date: Fri, 23 Mar 2018 15:00:31 +0000
Message-ID: <BL0PR2101MB1108CF3AEE2D04D064BA76FACAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
 <20180323001538.31876-2-longli@linuxonhyperv.com>
In-Reply-To: <20180323001538.31876-2-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-23T15:00:29.3110697Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1025;
 7:JBWp3idRvSEuLy26t6Zmr3Xpnvbx4VbS1U5g5LO5+JLGkHQSAPhSVY+C2Z2UXNAzp3k4Hu+EpVjNHHPRs+SQ7Kbqz2DZnCdoc9utQ3vSLulFhaCOtQv6JVtXhQo51si5OBj37dm0gLKB4aeo/Blr0eIN+HtMUaEnodCiSnE/1AUUOIuyAXN8Wr1YqRWjC9RhzJpiaSUG7RegrN3GrEihK4OQK+16D8tq+O8TwFECRzoD/7c74GBLPgDB6KOxf3R5;
 20:pctsSu0WTYlOKqS73JYBr7gEst/XISS9ANY73iHvO7PqsTyDgIHyohH/oi5l31FuwzPq70aFYHFWrQ5gxnZ7pmbpSTl8xRcAVEh9632DQbcgfxVbL+T79Z7mcQw+aM11j/1KnRZiHziHYUghKvr/iGFHmmmF1do5UHyJROLZYgk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ef63626-5b65-4a77-4cac-08d590ced2bf
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB1025ABC4C8FDACE41B187ED3CAA80@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1025; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1025;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(13464003)(199004)(189003)(11346002)(99286004)(575784001)(86362001)(1511001)(76176011)(8990500004)(2201001)(3280700002)(53546011)(25786009)(6506007)(9686003)(55016002)(7696005)(305945005)(6436002)(2900100001)(7736002)(10290500003)(316002)(478600001)(2906002)(68736007)(5660300001)(105586002)(81156014)(81166006)(4326008)(106356001)(86612001)(53936002)(6346003)(6246003)(6116002)(22452003)(110136005)(3846002)(10090500001)(107886003)(14454004)(229853002)(33656002)(66066001)(5250100002)(186003)(2501003)(446003)(102836004)(97736004)(74316002)(8676002)(26005)(8936002)(3660700001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1025;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: QeUP2/jmCIBdz3H5DWrHuSR1KybL36pvX3YGfCkaLkWPHlkUFdtoKE9HInIIPJVr54zV98PG78IDkJ2IhwG0ge22VZdJa0hgmqEbtIVJ3EWgSUeOKesD3B5HpcrG3qLhoOT5XUwnYZXFIR3XdD9j8g0LlqnJZunszTer29CxEdXeY6QLG1yUzg+SaPw0a+GJzx9ClKP6u0k+vVAJVgp+sPHDaQzf09QAYVk9bgA7X5dufFDeMGED5tAS7q1fwuy9iyiJkn2ULSjPWo4kYeXefQ+FM0GbVpdMqYTg0eRR9VshV6pjHpvsnhsbwUg3cHVTjP3KDXYx4Xk2UTSTYYQyqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef63626-5b65-4a77-4cac-08d590ced2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:00:31.4487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Long Li <longli@linuxonhyperv.com>
> Sent: Thursday, March 22, 2018 8:16 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring buffer
> percentage
> 
> From: Long Li <longli@microsoft.com>
> 
> In Vmbus, we have defined a function to calculate available ring buffer
> percentage to write.
> 
> Use that function and remove duplicate netvsc code.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c     | 17 +++--------------
>  drivers/net/hyperv/netvsc_drv.c |  3 ---
>  2 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c index
> 0265d703eb03..8af0069e4d8c 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -31,7 +31,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/prefetch.h>
> -#include <linux/reciprocal_div.h>
> 
>  #include <asm/sync_bitops.h>
> 
> @@ -590,17 +589,6 @@ void netvsc_device_remove(struct hv_device *device)
> #define RING_AVAIL_PERCENT_HIWATER 20  #define
> RING_AVAIL_PERCENT_LOWATER 10
> 
> -/*
> - * Get the percentage of available bytes to write in the ring.
> - * The return value is in range from 0 to 100.
> - */
> -static u32 hv_ringbuf_avail_percent(const struct hv_ring_buffer_info
> *ring_info) -{
> -	u32 avail_write = hv_get_bytes_to_write(ring_info);
> -
> -	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
> -}
> -
>  static inline void netvsc_free_send_slot(struct netvsc_device *net_device,
>  					 u32 index)
>  {
> @@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct
> netvsc_device *net_device,
>  		wake_up(&net_device->wait_drain);
> 
>  	if (netif_tx_queue_stopped(netdev_get_tx_queue(ndev, q_idx)) &&
> -	    (hv_ringbuf_avail_percent(&channel->outbound) >
> RING_AVAIL_PERCENT_HIWATER ||
> +	    (hv_get_avail_to_write_percent(&channel->outbound) >
> +	     RING_AVAIL_PERCENT_HIWATER ||
>  	     queue_sends < 1)) {
>  		netif_tx_wake_queue(netdev_get_tx_queue(ndev, q_idx));
>  		ndev_ctx->eth_stats.wake_queue++;
> @@ -757,7 +746,7 @@ static inline int netvsc_send_pkt(
>  	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
>  	u64 req_id;
>  	int ret;
> -	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
> +	u32 ring_avail =
> +hv_get_avail_to_write_percent(&out_channel->outbound);
> 
>  	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
>  	if (skb)
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index faea0be18924..b0b1c2fd2b7b 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -35,7 +35,6 @@
>  #include <linux/slab.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/netpoll.h>
> -#include <linux/reciprocal_div.h>
> 
>  #include <net/arp.h>
>  #include <net/route.h>
> @@ -55,7 +54,6 @@ static unsigned int ring_size __ro_after_init = 128;
> module_param(ring_size, uint, S_IRUGO);  MODULE_PARM_DESC(ring_size,
> "Ring buffer size (# of pages)");  unsigned int netvsc_ring_bytes __ro_after_init;
> -struct reciprocal_value netvsc_ring_reciprocal __ro_after_init;
> 
>  static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
>  				NETIF_MSG_LINK | NETIF_MSG_IFUP |
> @@ -2186,7 +2184,6 @@ static int __init netvsc_drv_init(void)
>  			ring_size);
>  	}
>  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
> -	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
> 
>  	ret = vmbus_driver_register(&netvsc_drv);
>  	if (ret)
> --


Please also remove netvsc_ring_reciprocal from hyperv_net.h
Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
