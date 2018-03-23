Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1533320-1521817944-2-4721390140224015199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817943; b=TLAvme+mRGb7xtu2CW50Ayvo4MVD5wt5dCJvweq1Re6TBOt
    +VgWp4LDNu2t+YsU+jCH5geupUSZj41wHo1fTNEi5T0OunGckQGPcd3xzauYOHGj
    6iUZiPIbHGHf4CTIQl1HYLM8wNTzOLVQ8Lyzayaq2Tj+HYedhmbc1cd+8PO+aYA+
    OM3QMdg0KOUORo7h0hUduWGF5MDwJTt7mTN7Vyx3uXT4/H3J8aDINDJV3K84SS7J
    n2Y40b1UQonap6aAQM8VhEVhyXEPxjyyYpSt//2Pc1B/Rxa4CZ6PDW0/k3uI2glb
    4X1YPe/M207PFtLhhEJOeENBKop6xR5DOYU/HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817943; bh=z
    sBbHB9EUpDLyX8VGNq5BcJAWYb39O+ygHaNvjs4PoY=; b=vxa+9Po+ne9FVn57f
    /0hS1nqJhzDaruJwHbLwK1lTekm+JD2PGRrPuEkDUBe5rWIFTyUsDIwGwBL5lKTe
    YmceoD3udrhdoDTjiDskyHPy1kKPZeGty6FdCga1FT8I5x7EO3UrV8sx6EEr1eky
    AQZ2xWGOutSav6Dyk0l6UF4TBDkguy2rNCNQ/ll7unmdkSKNZvA5oefZrKtpPeHZ
    X2l1Q48q+gLVUayK/3eV4U/pWHeYdzYImQGGHcXuKMgtIgWM5TGtK88WSScAdMvC
    0cut1jXx1hd35Nu2K8DEib1+IaEjUBqrFZy7oEopajcSkSIJ/6BabNAwIc6yInhd
    6yQpw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hHYJ1OAC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hHYJ1OAC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
From: KY Srinivasan <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Long Li
 <longli@linuxonhyperv.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Topic: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
 buffer percentage
Thread-Index: AQHTwjxHXRWolAV9rECFIikUIQEk7KPd6ueAgAACz8A=
Date: Fri, 23 Mar 2018 15:12:12 +0000
Message-ID: <DM5PR2101MB0888F3389A0EB587EE85CC8CA0A80@DM5PR2101MB0888.namprd21.prod.outlook.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
 <20180323001538.31876-2-longli@linuxonhyperv.com>
 <BL0PR2101MB1108CF3AEE2D04D064BA76FACAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1108CF3AEE2D04D064BA76FACAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:78da:ddb7:fbbf:e153]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1015;
 7:soLKs3ZexqlbRGH9JXCKqGKrPF9EhkT2M1FINTD9nBX07ZULQIuRztZgtmzPeUctXlPQuO8/mB+BT3MtZTqyQLwuxK3OHVbQ6j8Jdw/MxxXiC+A4rvWFn7Qvy8R8aFT/l5CvH8OBn5OymhnBbS/EQO0IXc0d1WPOoWz5mgSAMOFYG5M3itPiTXM+bH/jrHjL8wN0VRoZrtPnDiZvQ0ky5ewDdkwwR8Ms3DRWP0dcy2SEnDlqcW+vY6uw82Y1uYsg;
 20:jrZebNVQo6qfUn5Vl2Slnx+NRr75smoQu9RCFBKv8y19hxAEtwdOgN3BblGau6lFFQBhHcF2twDfFmrF/kH41IBuwmvmIzsSB0Cv3GrgsYxcw1/1W/fHD6QTcZ5Q8FA1OdYoOF7gpA93SclzhEo9mgNPo3r7PEDTufQVTylXFTY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2671944f-fb45-49c4-6012-08d590d0746f
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-microsoft-antispam-prvs: <DM5PR2101MB1015B2DDD10591E2CED680A9A0A80@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1015; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(39380400002)(376002)(396003)(346002)(189003)(199004)(13464003)(8676002)(4326008)(1511001)(6116002)(81156014)(7736002)(102836004)(14454004)(106356001)(6436002)(105586002)(8990500004)(33656002)(3280700002)(8936002)(97736004)(11346002)(3660700001)(81166006)(25786009)(446003)(74316002)(2906002)(86612001)(5250100002)(2501003)(2201001)(305945005)(55016002)(6346003)(53936002)(99286004)(5660300001)(7696005)(10290500003)(86362001)(575784001)(478600001)(9686003)(46003)(2900100001)(6246003)(6506007)(76176011)(68736007)(229853002)(110136005)(316002)(10090500001)(107886003)(22452003)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1015;
 H:DM5PR2101MB0888.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-message-info: bp28gn5ffXaUmwqEVpOiT+p6iwpXXk6pkQDWZNpzFv3dv+ftb5VTqmOdrq3nd1HqfLLxyFfwA57H+rlFF5ycGkIz0JtasjFnQh2JXeI1IazUr9nbVOuoFzIKKr0PHXRMIpm1hzOD4fLLN4JSN0iYgMM7Z3vIZ0IRtGDPDNmaN2Lfug6qepEPOJYNt/dq/sjeOMC71kLS1YgT5cM0pqB+Xl1WHiSwuFJ5bPYhNxtN5b67B7VuMgoqKVSg1Wjmu3NgBu9k62f/I+NLW8j5wKHFT7IslM3swcOsFwLQ8A0blCAcqEVemeIQTcyGiy+e8mo+33EHzBf5EuRaYHebNDj/dQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2671944f-fb45-49c4-6012-08d590d0746f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:12:12.2175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
> From: Haiyang Zhang
> Sent: Friday, March 23, 2018 8:01 AM
> To: Long Li <longli@linuxonhyperv.com>; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: RE: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
> buffer percentage
> 
> 
> 
> > -----Original Message-----
> > From: Long Li <longli@linuxonhyperv.com>
> > Sent: Thursday, March 22, 2018 8:16 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> > <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: [PATCH 2/3] Netvsc: Use the vmbus functiton to calculate ring
> buffer
> > percentage
> >
> > From: Long Li <longli@microsoft.com>
> >
> > In Vmbus, we have defined a function to calculate available ring buffer
> > percentage to write.
> >
> > Use that function and remove duplicate netvsc code.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/net/hyperv/netvsc.c     | 17 +++--------------
> >  drivers/net/hyperv/netvsc_drv.c |  3 ---
> >  2 files changed, 3 insertions(+), 17 deletions(-)

Why is the patch being sent to the scsi list and not to the network mailing list and
Dave Miller.

K. Y
> >
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index
> > 0265d703eb03..8af0069e4d8c 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -31,7 +31,6 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/prefetch.h>
> > -#include <linux/reciprocal_div.h>
> >
> >  #include <asm/sync_bitops.h>
> >
> > @@ -590,17 +589,6 @@ void netvsc_device_remove(struct hv_device
> *device)
> > #define RING_AVAIL_PERCENT_HIWATER 20  #define
> > RING_AVAIL_PERCENT_LOWATER 10
> >
> > -/*
> > - * Get the percentage of available bytes to write in the ring.
> > - * The return value is in range from 0 to 100.
> > - */
> > -static u32 hv_ringbuf_avail_percent(const struct hv_ring_buffer_info
> > *ring_info) -{
> > -	u32 avail_write = hv_get_bytes_to_write(ring_info);
> > -
> > -	return reciprocal_divide(avail_write  * 100, netvsc_ring_reciprocal);
> > -}
> > -
> >  static inline void netvsc_free_send_slot(struct netvsc_device
> *net_device,
> >  					 u32 index)
> >  {
> > @@ -649,7 +637,8 @@ static void netvsc_send_tx_complete(struct
> > netvsc_device *net_device,
> >  		wake_up(&net_device->wait_drain);
> >
> >  	if (netif_tx_queue_stopped(netdev_get_tx_queue(ndev, q_idx))
> &&
> > -	    (hv_ringbuf_avail_percent(&channel->outbound) >
> > RING_AVAIL_PERCENT_HIWATER ||
> > +	    (hv_get_avail_to_write_percent(&channel->outbound) >
> > +	     RING_AVAIL_PERCENT_HIWATER ||
> >  	     queue_sends < 1)) {
> >  		netif_tx_wake_queue(netdev_get_tx_queue(ndev, q_idx));
> >  		ndev_ctx->eth_stats.wake_queue++;
> > @@ -757,7 +746,7 @@ static inline int netvsc_send_pkt(
> >  	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet-
> >q_idx);
> >  	u64 req_id;
> >  	int ret;
> > -	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel-
> >outbound);
> > +	u32 ring_avail =
> > +hv_get_avail_to_write_percent(&out_channel->outbound);
> >
> >  	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
> >  	if (skb)
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> > index faea0be18924..b0b1c2fd2b7b 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -35,7 +35,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/netpoll.h>
> > -#include <linux/reciprocal_div.h>
> >
> >  #include <net/arp.h>
> >  #include <net/route.h>
> > @@ -55,7 +54,6 @@ static unsigned int ring_size __ro_after_init = 128;
> > module_param(ring_size, uint, S_IRUGO);
> MODULE_PARM_DESC(ring_size,
> > "Ring buffer size (# of pages)");  unsigned int netvsc_ring_bytes
> __ro_after_init;
> > -struct reciprocal_value netvsc_ring_reciprocal __ro_after_init;
> >
> >  static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
> >  				NETIF_MSG_LINK | NETIF_MSG_IFUP |
> > @@ -2186,7 +2184,6 @@ static int __init netvsc_drv_init(void)
> >  			ring_size);
> >  	}
> >  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
> > -	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
> >
> >  	ret = vmbus_driver_register(&netvsc_drv);
> >  	if (ret)
> > --
> 
> 
> Please also remove netvsc_ring_reciprocal from hyperv_net.h
> Thanks.
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
