Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCWPZv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:25:51 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:42626
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751715AbeCWPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:25:50 -0400
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@linuxonhyperv.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next,2/2] hv_netvsc: Add range checking for rx packet
 offset and length
Thread-Topic: [PATCH net-next,2/2] hv_netvsc: Add range checking for rx packet
 offset and length
Thread-Index: AQHTwhBc67ZwczHR5Eq1DbAW+9tjDaPd7/kWgAAAUnA=
Date: Fri, 23 Mar 2018 15:25:48 +0000
Message-ID: <BL0PR2101MB11087DD996F43224D09E35B2CAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
        <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
 <87sh8q4y9s.fsf@vitty.brq.redhat.com>
In-Reply-To: <87sh8q4y9s.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-23T15:25:47.0054790Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1121;7:IullSY0Awy4Outn3LHYmNMBuiUHOA2P1bYW4HGzlC/rXOwejqeNHUqhrnTs1o1NqSYBJrSHk4+jBJepD7jQhY7chePRf1FbyawdD6VJ4otdMBN3XtOk903VVr2BvCgNyN2mbzaeyFVF4032RmHhMXn8GPI+pq3cPOatPzwkNUmRLcqQeFSi72yJwm6jEf2fodkmbdNg1qKHDIxv6cfNdpNgMs6+Zzmsm5ydeF7YKZlK6qi4f7rgqcIZ7Ome2/Aic;20:Gm97slc+Qbc96+7D2sn2KxLaMmiRgjtyGKLrYhh2psGr39U62HsuACCtEESfMCDtKkAPnMsYnOGypgpxk0isEQqSUpBPfd0gNCup/xxaf7MiRm5zwZaqT7F5o0GN5XshN2/0p1PJR+zREXLV+gcavzFFKcY9ZROwxmF+e34U5f8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e785d2c2-ca52-4966-4b02-08d590d25ab9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1121;
x-ms-traffictypediagnostic: BL0PR2101MB1121:
x-microsoft-antispam-prvs: <BL0PR2101MB1121CE53BA11E05A566A3E73CAA80@BL0PR2101MB1121.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1121;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1121;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(39380400002)(376002)(346002)(13464003)(189003)(199004)(53546011)(6506007)(33656002)(5250100002)(6346003)(102836004)(229853002)(110136005)(26005)(54906003)(186003)(10290500003)(3660700001)(68736007)(25786009)(4326008)(22452003)(316002)(97736004)(2900100001)(3846002)(6116002)(5660300001)(74316002)(8936002)(8990500004)(7696005)(86362001)(6246003)(10090500001)(478600001)(86612001)(105586002)(99286004)(76176011)(53936002)(3280700002)(55016002)(11346002)(14454004)(446003)(9686003)(6436002)(81166006)(81156014)(305945005)(8676002)(66066001)(7736002)(2906002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1121;H:BL0PR2101MB1108.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: RQNj9b7ASoKMZHiq5y+74uFoqMr1XMt+3e8EKVIa/QXpLvAfHojxOuJj04Jnc5Zwpa2eJ9l06txkelgkwnUQpP5i/scc4vD/JAu2G6wlBfXWltYgxFwiCOP/RHxqhAhJ58zuMZNM3+26rELGJP6cF420fDexO9Zf+skuR6YGKCLsVwXbmo+ahsVxjqpa1l+d/0w5PtElrs8ZP2zOakHjfrANpQvHZrXBG5Oqxy0TEVTO8QIR+oDOPYbY+C6IQW5p7JJYjP4KRNh4SrJRtFjz2HjJj5nWIg2gBKQ4UVtEFTKfZJdBNpy6QIIasBegPIHko2m+rOYcIU3EaxShUDboAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785d2c2-ca52-4966-4b02-08d590d25ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:25:48.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2NFPwes001815



> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, March 23, 2018 11:17 AM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next,2/2] hv_netvsc: Add range checking for rx packet
> offset and length
> 
> Haiyang Zhang <haiyangz@linuxonhyperv.com> writes:
> 
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > This patch adds range checking for rx packet offset and length.
> > It may only happen if there is a host side bug.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/hyperv/hyperv_net.h |  1 +
> >  drivers/net/hyperv/netvsc.c     | 17 +++++++++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/hyperv_net.h
> > b/drivers/net/hyperv/hyperv_net.h index 0db3bd1ea06f..49c05ac894e5
> > 100644
> > --- a/drivers/net/hyperv/hyperv_net.h
> > +++ b/drivers/net/hyperv/hyperv_net.h
> > @@ -793,6 +793,7 @@ struct netvsc_device {
> >
> >  	/* Receive buffer allocated by us but manages by NetVSP */
> >  	void *recv_buf;
> > +	u32 recv_buf_size; /* allocated bytes */
> >  	u32 recv_buf_gpadl_handle;
> >  	u32 recv_section_cnt;
> >  	u32 recv_section_size;
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 1ddb2c39b6e4..a6700d65f206 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -289,6 +289,8 @@ static int netvsc_init_buf(struct hv_device *device,
> >  		goto cleanup;
> >  	}
> >
> > +	net_device->recv_buf_size = buf_size;
> > +
> >  	/*
> >  	 * Establish the gpadl handle for this buffer on this
> >  	 * channel.  Note: This call uses the vmbus connection rather @@
> > -1095,11 +1097,22 @@ static int netvsc_receive(struct net_device
> > *ndev,
> >
> >  	/* Each range represents 1 RNDIS pkt that contains 1 ethernet frame */
> >  	for (i = 0; i < count; i++) {
> > -		void *data = recv_buf
> > -			+ vmxferpage_packet->ranges[i].byte_offset;
> > +		u32 offset = vmxferpage_packet->ranges[i].byte_offset;
> >  		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
> > +		void *data;
> >  		int ret;
> >
> > +		if (unlikely(offset + buflen > net_device->recv_buf_size)) {
> > +			status = NVSP_STAT_FAIL;
> > +			netif_err(net_device_ctx, rx_err, ndev,
> > +				  "Packet offset:%u + len:%u too big\n",
> > +				  offset, buflen);
> 
> This shouldn't happen, of course, but I'd rather ratelimit this error or even used
> something like netdev_WARN_ONCE().

Actually I thought about ratelimit, but this range check is only to catch host side bug. 
It should not happen. 
But if it happens, the VM should not be used anymore. And we need to debug
the host. Similarly, some other this kind of checks in the same function are not using
ratelimit:

        if (unlikely(nvsp->hdr.msg_type != NVSP_MSG1_TYPE_SEND_RNDIS_PKT)) {
                netif_err(net_device_ctx, rx_err, ndev,
                          "Unknown nvsp packet type received %u\n",
                          nvsp->hdr.msg_type);

Thanks,
- Haiyang
