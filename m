Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1790898-1521827877-2-3186125660272714696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521827876; b=UK/etj7T5b5SINQF1NN1TJ/LWNDdr5h3znr7SNy05DRjc56
    OG0fBbVJdGs93xsziNonQKycdf8BF++X/3RsghKxqFXzM4i1ekWpVaddyjXXfK/m
    pBY66g8HObZrbmi2mXZvEGq2fR/hUoFSHoFVvadfrzzceXsKNUKBcsNT85Wcuw7S
    SEYnwExGicYJqpMGMakAlyCCgoGkNtX4s2eVWrdsFXZPSuzgU0sRXmZMMIevTHD8
    n28VjRh0Yol2gnNi0xaVnWYuR9bpqnunP/PrN3QW2ejBax8rYHx93OzVJ4WlEPGe
    ejumU5brCBmjJQjYkDHU04YxIsflGJZdMhfYSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521827876; bh=U
    R/G32ho0SEaiXmRmyw85d40fzlJj+rwLTXiBkBZO/g=; b=otONlJ/JsIaXmdYVz
    vkzDS6o49Yq4D9NFURvFPQuBRWpbPnVF/DKKHYYmkTOcNluS17UlgpraPLfYFBnG
    54+/pvgHCU6jcpig2UntTsMwqSIuCHw64icJa3mz5TW82yo2dKuh5WHfAin6rhxh
    ZaYKkO2d1oFnU4t6rpRIQ4f8EsRlqFbfTs2QymFhmdosXI9+Owu+txxrKr0nDI2J
    PzCnO2W/uwsV78StgKwW7Ul9+iU0Vt+AjGATmYrIUwzvs1Ce5OrwMML0ECkvaNoN
    tYOrHmKIf3Pl0dYJSXuGh4O+8Q1582xmoZm31CtRvBOhGlpKbs3nnFTSrF+mBTiR
    qKeAg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ISVKZNwq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ISVKZNwq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Long Li <longli@linuxonhyperv.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Topic: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Index: AQHTwjxH0m8zl19MNkGQP7G3JLrrTqPd6ueAgAADQwCAACmY8A==
Date: Fri, 23 Mar 2018 17:42:04 +0000
Message-ID: <MWHPR2101MB0729D643AC561D9F9494EAA8CEA80@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
 <20180323001538.31876-2-longli@linuxonhyperv.com>
 <BL0PR2101MB1108CF3AEE2D04D064BA76FACAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
 <DM5PR2101MB0888F3389A0EB587EE85CC8CA0A80@DM5PR2101MB0888.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB0888F3389A0EB587EE85CC8CA0A80@DM5PR2101MB0888.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:8::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0874;
 7:veLWxZ9c8w04WgCIB0v5JBK2HlTAX9M4QTKRohiQhPuypYlBpOK8bj8jumVjkWwpk3ObFimHtaofTTO+QYLqA9+uToIbNxGitJuQ0zTvVeBajp9ABDw4Elxv0Rm4gFUX967gIJwOM8at5yPHdEqew6PoB4tV8jCSCwnYfU/wmKIcP7DOnnuJjPdv2fIT/LIbLZHdqbxUDDsPZr9kM2eg2DZXQY9JstnBjV+8zW3kBs0LfPrGYpiNPkOz1+xvllSI;
 20:j5vB3pD7mHPnKMNTKXtSZ3jN2MvsFe3ULw4GiKWow14LbugYKbsgrKpymetphu2lZ+ok1QrMBT93MYTUG7LlS1nqlo64CfrcWQoTpVy7WJoWRw2hvm22AtyA56KJobzXrsj0KhJH9vk9+3Q6WEJ3vE4AMefP6GYgjONyzEEbKWI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e9c8e17-b7e2-41d9-c8db-08d590e56493
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0874;
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-microsoft-antispam-prvs: <MWHPR2101MB08741702BAA74AD6D091D2D0CEA80@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0874; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0874;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(39380400002)(376002)(39860400002)(199004)(189003)(13464003)(81156014)(305945005)(446003)(93886005)(68736007)(106356001)(2201001)(74316002)(5660300001)(86612001)(7736002)(478600001)(2900100001)(10290500003)(3280700002)(81166006)(11346002)(8936002)(14454004)(316002)(110136005)(229853002)(8676002)(99286004)(575784001)(22452003)(86362001)(6506007)(9686003)(7696005)(8990500004)(55016002)(53546011)(53936002)(6116002)(2906002)(10090500001)(105586002)(3660700001)(25786009)(97736004)(76176011)(33656002)(5250100002)(102836004)(2501003)(6436002)(6346003)(6246003)(1511001)(46003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0874;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: AtGQbdder+nRojKsDhk4u585OJP89tYi5BV92r/PGhA3p8GxJUZVjpW80cvQLGTcg6eM4pGd+t71xc47uIUo8VQoqOGCxUmrfw3/fLY0DmnZduIWsDM9t5KNVZlSAcNVlHVlU4a4XT3wBdz5sxgO2p0KgmHtraShLDjLucfXyIpD/lhB4tbo8zUIJ6MKZGrovYmuPr1sADje1JJmbF3YUzc+f0DAARdlVsvzfHjl5k9SASHKVtTR1hGv+jSkwiJHWpBA+Z3fXBG9ZpeRezWfsgO0mgoGlJXJJy6rNnnTvHvHbvdvUwMTLTvbfEJML6OdJaDgTj3D9j5cJncdEKfkoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c8e17-b7e2-41d9-c8db-08d590e56493
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 17:42:04.9718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
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

> Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
> buffer percentage
> 
> 
> 
> > -----Original Message-----
> > From: Haiyang Zhang
> > Sent: Friday, March 23, 2018 8:01 AM
> > To: Long Li <longli@linuxonhyperv.com>; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> James
> > E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> > <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate
> > ring buffer percentage
> >
> >
> >
> > > -----Original Message-----
> > > From: Long Li <longli@linuxonhyperv.com>
> > > Sent: Thursday, March 22, 2018 8:16 PM
> > > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>;
> > > James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> > > <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> > > scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Cc: Long Li <longli@microsoft.com>
> > > Subject: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate
> > > ring
> > buffer
> > > percentage
> > >
> > > From: Long Li <longli@microsoft.com>
> > >
> > > In Vmbus, we have defined a function to calculate available ring
> > > buffer percentage to write.
> > >
> > > Use that function and remove duplicate netvsc code.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c     | 17 +++--------------
> > >  drivers/net/hyperv/netvsc_drv.c |  3 ---
> > >  2 files changed, 3 insertions(+), 17 deletions(-)
> 
> Why is the patch being sent to the scsi list and not to the network mailing list
> and Dave Miller.

I will re-send the patch.

> 
> K. Y
> > >
> > > diff --git a/drivers/net/hyperv/netvsc.c
> > > b/drivers/net/hyperv/netvsc.c
> > index
> > > 0265d703eb03..8af0069e4d8c 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -31,7 +31,6 @@
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/prefetch.h>
> > > -#include <linux/reciprocal_div.h>
> > >
> > >  #include <asm/sync_bitops.h>
> > >
> > > @@ -590,17 +589,6 @@ void netvsc_device_remove(struct hv_device
> > *device)
> > > #define RING_AVAIL_PERCENT_HIWATER 20  #define
> > > RING_AVAIL_PERCENT_LOWATER 10
> > >
> > > -/*
> > > - * Get the percentage of available bytes to write in the ring.
> > > - * The return value is in range from 0 to 100.
> > > - */
> > > -static u32 hv_ringbuf_avail_percent(const struct
> > > hv_ring_buffer_info
> > > *ring_info) -{
> > > -	u32 avail_write = hv_get_bytes_to_write(ring_info);
> > > -
> > > -	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
> > > -}
> > > -
> > >  static inline void netvsc_free_send_slot(struct netvsc_device
> > *net_device,
> > >  					 u32 index)
> > >  {
> > > @@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct
> > > netvsc_device *net_device,
> > >  		wake_up(&net_device->wait_drain);
> > >
> > >  	if (netif_tx_queue_stopped(netdev_get_tx_queue(ndev, q_idx))
> > &&
> > > -	    (hv_ringbuf_avail_percent(&channel->outbound) >
> > > RING_AVAIL_PERCENT_HIWATER ||
> > > +	    (hv_get_avail_to_write_percent(&channel->outbound) >
> > > +	     RING_AVAIL_PERCENT_HIWATER ||
> > >  	     queue_sends < 1)) {
> > >  		netif_tx_wake_queue(netdev_get_tx_queue(ndev, q_idx));
> > >  		ndev_ctx->eth_stats.wake_queue++;  @@ -757,7 +746,7 @@
> static
> > >inline int netvsc_send_pkt(
> > >  	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet-
> > >q_idx);
> > >  	u64 req_id;
> > >  	int ret;
> > > -	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel-
> > >outbound);
> > > +	u32 ring_avail =
> > > +hv_get_avail_to_write_percent(&out_channel->outbound);
> > >
> > >  	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
> > >  	if (skb)
> > > diff --git a/drivers/net/hyperv/netvsc_drv.c
> > b/drivers/net/hyperv/netvsc_drv.c
> > > index faea0be18924..b0b1c2fd2b7b 100644
> > > --- a/drivers/net/hyperv/netvsc_drv.c
> > > +++ b/drivers/net/hyperv/netvsc_drv.c
> > > @@ -35,7 +35,6 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/netpoll.h>
> > > -#include <linux/reciprocal_div.h>
> > >
> > >  #include <net/arp.h>
> > >  #include <net/route.h>
> > > @@ -55,7 +54,6 @@ static unsigned int ring_size __ro_after_init =
> > > 128; module_param(ring_size, uint, S_IRUGO);
> > MODULE_PARM_DESC(ring_size,
> > > "Ring buffer size (# of pages)");  unsigned int netvsc_ring_bytes
> > __ro_after_init;
> > > -struct reciprocal_value netvsc_ring_reciprocal __ro_after_init;
> > >
> > >  static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
> > >  				NETIF_MSG_LINK | NETIF_MSG_IFUP | @@ -
> 2186,7 +2184,6 @@ static
> > > int __init netvsc_drv_init(void)
> > >  			ring_size);
> > >  	}
> > >  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
> > > -	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
> > >
> > >  	ret = vmbus_driver_register(&netvsc_drv);
> > >  	if (ret)
> > > --
> >
> >
> > Please also remove netvsc_ring_reciprocal from hyperv_net.h Thanks.

I will fix it and re-send the patch.

> >
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
