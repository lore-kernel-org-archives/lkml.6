Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-722628-1523663666-2-7215381734199914382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523663666; b=rU+lMduJJGKGGsjioIgqUbmt3GIMRhV27WNlFx89CZxCr1uBgw
    Huhzjytb38UQ2SkZz/wvo8xJwW1hiYDkAuiG4bGW/eOaMSyMgrOMonIXU4yp7e3o
    pGFCom+5GfT9yfRfxZe2eUcSOnJfQ822nXiSr6Az7qHB75OylBJT9ZS1uL4JN9l4
    Wdi67OciWWUNmtCMnaSnfrysbe2z8spTN7mL6J/CylW1Rpl9/9ayU+Z+1RaQs4iM
    6lUVrbROM4e9shA2qgs0VvO3a6djZmjySswvwgdDNHTkqstZCC7Oe8hBLBIBj1NF
    4w/EkrqJI0VZB9lYO/VgMzUChR3feOAKe+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523663666; bh=QwDhx
    3A/CE6LrkWjdVE3qhZX5Cuu/kg2drz9pZPAzYI=; b=IZH5fZgFMDwP/4Z6CJrdY
    7Q4jlbVdTYBojqhUHhYLnVfY8Ob7XrDKmclC61agoe/mKznwLIqIU7KhRxnl6Qb8
    AaMaGRsUNALGq0E3qEPnhVl27FcJJMOTQOot25UM1hSzSOLOT01FQY844/0ytP/n
    q1X6MyuZ+jVaJBy3E0Jtw9MWUvdnhYr+yRRB09LZWwzVLpC+y6ZHemztKmIAceUH
    lJ4MXU8Qdv65h2ygYuX7lSAUkdydfJMVMFLG3MZFKYp8agwVbLJ8Qa784aX3n8+E
    H+YsxjB1dQQ2JNxQLUjSGnapcPgpQuVPqJNbedLwReldHdAxmzoMJ8MVgt0nGkE6
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=asmj6yOb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=asmj6yOb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNy0ppBLw/XVXObx9lp4UR8mpqcFpQpcqmqppCovjz7rzgVNO+MQOKz5dld7FOqeHYz3k8IylG4s5X28Gh3kOmyUoddJvJET2S00jCuA1F12nCuJqwmH
    mVqw1AE7z1m8bx/QUZxsersqt/cOiuLeP7T+y5hCrE0DSyLnDbnIssQH8uw9KKLxyrxszbRMRFGil2Lp7JgqWK/M7Ze/bcGSXdGWnbmkYr+EE7xFYyYPPPSe
    srfPxcVZcvPlZzeTzWHHYA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=_TKFW_rNyuwA:10 a=ezrDjaGQ7gEA:10
    a=E11VVgoSWi0A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=6n1iNii3AAAA:8 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=U49Ifj-1jw6lW8hivqMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=qL8UFIJES1IU-uv6apQ6:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [Resend Patch 2/3] Netvsc: Use the vmbus functiton to calculate
 ring buffer percentage
Thread-Topic: [Resend Patch 2/3] Netvsc: Use the vmbus functiton to calculate
 ring buffer percentage
Thread-Index: AQHTxi7I8rZEXIH4PEm5wNnltgfC6KP/dNGg
Date: Fri, 13 Apr 2018 23:39:58 +0000
Message-ID: <DM5PR2101MB103001D09986D57D8E0EF124DCB30@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <20180328004840.22787-2-longli@linuxonhyperv.com>
In-Reply-To: <20180328004840.22787-2-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-13T23:39:56.9901144Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1030;
 7:8peZ5AfDc4m6x/Qhw6EdEL1uKp7wTYEIRJUbKWZ9QSkJ74JHxks8MhA6U4BInQqpBjgPG3+yO4PpMyarhWiVQRgqjNpK1rLwlJjj7nyYUUdcRQOWtP6/qWKyP3hyhhU6R7pMC7fhK7+JD8lDqidEPptr1+NhTb9yxK22KB39TZ1/jp0x94+pmmDGhXO7aUnxHckxootqP0lhPw8M+ZMIE2efxDuUlOtJ922OiES9E1KABXR1QVCwqhGREjCpVOnP;
 20:nKc10GMVX7TaQJLrgpJZ7My0hx6+QW/JeSTLSUP7EGu++L7fc0+Yv4uu11zpHNFCa7+rH1ONurcHmxcQv82kALThaxwXCyS0iu8KATq6dj6RXnCGNvfAHTGfbqBUYShnJUvGU4zz95q903rIjI8qfvzsKGolt5fPIuOxMifRt7o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10302FCB3D3143542D7885F3DCB30@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501347)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1030; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(396003)(366004)(39380400002)(346002)(13464003)(189003)(199004)(6116002)(8936002)(105586002)(6436002)(8676002)(575784001)(446003)(10290500003)(86362001)(66066001)(1511001)(74316002)(305945005)(478600001)(476003)(2501003)(486006)(3660700001)(2201001)(316002)(72206003)(68736007)(2906002)(5250100002)(33656002)(55016002)(3846002)(53546011)(6506007)(106356001)(110136005)(53936002)(25786009)(76176011)(9686003)(86612001)(229853002)(8990500004)(14454004)(7696005)(10090500001)(7736002)(97736004)(81166006)(26005)(3280700002)(102836004)(99286004)(11346002)(6246003)(81156014)(5660300001)(22452003)(2900100001)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1030;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bb70afbf-bbaf-4761-1ad8-08d5a197de83
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb70afbf-bbaf-4761-1ad8-08d5a197de83
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 23:39:58.6990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Long Li
> Sent: Tuesday, March 27, 2018 5:49 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>;
> Martin K . Petersen <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [Resend Patch 2/3] Netvsc: Use the vmbus functiton to calculate ring buffer
> percentage
> 
> From: Long Li <longli@microsoft.com>
> 
> In Vmbus, we have defined a function to calculate available ring buffer
> percentage to write.
> 
> Use that function and remove netvsc's private version.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/net/hyperv/hyperv_net.h |  1 -
>  drivers/net/hyperv/netvsc.c     | 17 +++--------------
>  drivers/net/hyperv/netvsc_drv.c |  3 ---
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index cd538d5a7986..a0199ab13d67 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -189,7 +189,6 @@ struct netvsc_device;
>  struct net_device_context;
> 
>  extern u32 netvsc_ring_bytes;
> -extern struct reciprocal_value netvsc_ring_reciprocal;
> 
>  struct netvsc_device *netvsc_device_add(struct hv_device *device,
>  					const struct netvsc_device_info *info);
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 0265d703eb03..8af0069e4d8c 100644
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
>  #define RING_AVAIL_PERCENT_HIWATER 20
>  #define RING_AVAIL_PERCENT_LOWATER 10
> 
> -/*
> - * Get the percentage of available bytes to write in the ring.
> - * The return value is in range from 0 to 100.
> - */
> -static u32 hv_ringbuf_avail_percent(const struct hv_ring_buffer_info *ring_info)
> -{
> -	u32 avail_write = hv_get_bytes_to_write(ring_info);
> -
> -	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
> -}
> -
>  static inline void netvsc_free_send_slot(struct netvsc_device *net_device,
>  					 u32 index)
>  {
> @@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct netvsc_device
> *net_device,
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
> +	u32 ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
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
>  module_param(ring_size, uint, S_IRUGO);
>  MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
>  unsigned int netvsc_ring_bytes __ro_after_init;
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
> 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
