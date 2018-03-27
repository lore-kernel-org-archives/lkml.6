Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4056126-1522164956-2-9157320922719153168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522164955; b=VeWXf2W95I9BH4g7jKSMVdWm7iaP7NvEkURFzia6ZKnwzol
    8hferEWfWd0mnR37YCvvFNPh68hSnNjNManDwpy5LX0TmvDJPJV/AY8+zGCWjhL0
    2Etb2P5SrSZRA54gxAtNbzA6EouYyZjmhVgDEOJVekU1AFmez/JAjpwFttFPVxFI
    +SU9qVhgWimGYrXcK+Kyb1vbT5La5/0nq6o6YxLn0BTIqAsl1lb5t+5oVne7ebiD
    pEZ/sx/sDim4FTHSlhkY2Bk1AnD9U+kJyAPxIGyT+tGxV2/L18lEtJvFpFEl9//0
    biWT+qrEePEbpN7D1b3fLa7BFZ/JxkmnZev1+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522164955; bh=3
    oX4QviPwSec2Y2w496lCTVT7m63QzOT2JiU7nWMAto=; b=bYsB/ssmIRSOT/cg+
    EYLk6wd4QXdkRwrAHmxV1O3HBo/PKI728fa/F4EcA0FznqBPbGDqZM+1QMthuDOK
    eLfQy30R/H5TuJ3QbApvGPCvN2EEAjT1OOUG1QWg8d7yr0IilR5tMgwqk9/oTGQw
    vOuPL+j+oLHZCeKlftALk+1J2/qtNL4yPG4wKjm9zmvVZ/oGiucTnVie6PZ0UvUu
    9Wb3mb+eoIqCNVhjcHJp44M7qdBqOmELGlX8uzXVKiV4LRBFwHuycXm/9gX7JDxM
    f7qyCoB9faiRkGyhSAI+NXOPx98Zy2WQPYDncp2eXvQuX7a1kwL3kcqgkJnpMGlt
    hAblA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BbLk+Xn9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BbLk+Xn9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzMAEinr5rLRdjdTs1ODazqRN+m9gxnYO0IDveLrynstIkmBQTou5QPQwa9l/St3K8x18FSR7lqt8bhT6cFRuPOUShgi7W3ZRxw8ksammbnNsYKqTu0
    bApSoCCxwdAZw6ZPZyyH53MoBRIVbPE32suDyJOHdUxjjYJR4U2h9V2zhgm/HPiuHP0It9fZcjPRMfpFEq2G3dXnabaeZmpvWEUrye2d6J3CkwRyW5Y6X9UO
    yDwM65lApxfxbCJEI8Mdyw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=qKRqC2NImX0A:10 a=EHDZXwS4o9oA:10
    a=MBTihvTpdlQA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=jZVsG21pAAAA:8
    a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=20KFwNOVAAAA:8 a=SW3Cc4XlPrvD-TDFOX4A:9
    a=tw0ajLK6D3DH5r2R:21 a=Ef9a0jTZq0dfQ_Z9:21 a=CjuIK1q_8ugA:10
    a=3Sh2lD0sZASs_lUdrUhf:22 a=lNAA6UHySJB7qmBR1x20:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH net-next, 2/2] hv_netvsc: Add range checking for rx packet
 offset and length
Thread-Topic: [PATCH net-next, 2/2] hv_netvsc: Add range checking for rx
 packet offset and length
Thread-Index: AQHTxd94dW0EPNWnd0KWArTOx9+cWKPkNFWA
Date: Tue, 27 Mar 2018 15:35:45 +0000
Message-ID: <BL0PR2101MB1108254A8052674245026BCACAAC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
 <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
 <20180327082245.591612dc@xeon-e3>
In-Reply-To: <20180327082245.591612dc@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-27T15:35:42.8606735Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1076;
 7:TJMMd2f+/4Pefnr/HOnbCbMrWhOjMLbLXqIh8bnFLpd0OaOOLgV6pt6nMaQAcO9KTkN5/4OdE1dmDPHM49ZjNUwCMscWEKzcm37kQx+Jm7kE1t9q+98Kaq0c1OrEHc8JXkNMFsNXd7AF/md8EotEC/+kGA/o61CMebWdDs6N2HbQoABDTuJSZSe8TDgReE5B1bPor+QsimV4GpUOWrGkz6FfHt8qtzdwPGn3VZZpFU2Bb58C0JK+BWnePwq8nxFS;
 20:CdWbZ/nFPPrL203F43nI0nt2Halzbieaq7VraEwSa3fi572pIVhKMAarzx4ab5BdBfTauu/kPnWbZQ3AEDPw2cLQd3BQlKheoESKSTPglK/2BVbxmpaL6tZd8rSpns4xAICLwIXK1bf0mO4r0wwSpLR0dvMsfgf7ezPOzUPAN7o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f368fde6-9445-49b4-55de-08d593f8687d
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:BL0PR2101MB1076;
x-ms-traffictypediagnostic: BL0PR2101MB1076:
x-microsoft-antispam-prvs: <BL0PR2101MB1076949EFE134C6072843BC4CAAC0@BL0PR2101MB1076.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1076; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1076;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(346002)(366004)(376002)(39860400002)(396003)(199004)(13464003)(189003)(86612001)(99286004)(8936002)(2906002)(6116002)(3846002)(6246003)(33656002)(106356001)(4326008)(316002)(305945005)(6916009)(105586002)(22452003)(3280700002)(6436002)(25786009)(74316002)(68736007)(7736002)(14454004)(26005)(55016002)(6346003)(5660300001)(186003)(10090500001)(97736004)(229853002)(8990500004)(476003)(486005)(486005)(76176011)(11346002)(3660700001)(478600001)(86362001)(81156014)(81166006)(446003)(5250100002)(53546011)(6506007)(9686003)(54906003)(53936002)(8676002)(10290500003)(2900100001)(66066001)(7696005)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1076;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: 7JFg2dCLoEop/M40wpXpEVLvzR1ChOs7rmRhmDJCHr0fHbX/JcTKuqirD+yoaOTkNSgA4iKjpl53VnlUmIBjpv/JMhiLhu8F0u6RtSuASRxNNHL4F5PjXlyi38CiyJHJQsolsDq0JUh2gYniqBG1QkhO33Zq0rkUi3fIBfGK5fWobVdeDIcORB+VefRUL9+OmW3c7HbX5x7Fo3wRJiaV6jTi03pl+D/aK5gzJoF78VhfStM9nX/17yGmrB4d3N78EUOQHoKjE9/LNrazMsCPdRdfE2Tp+zcaIsLsHsThPTP3OZmoaT3KBRtg+aPrD3mmB266KxF2/wtW2a/xRCy5DA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f368fde6-9445-49b4-55de-08d593f8687d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 15:35:45.5038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1076
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, March 27, 2018 11:23 AM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org; olaf@aepfle.de; Stephen Hemminger
> <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets@redhat.com
> Subject: Re: [PATCH net-next, 2/2] hv_netvsc: Add range checking for rx packet
> offset and length
> 
> On Thu, 22 Mar 2018 12:01:14 -0700
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
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
> > +
> > +			continue;
> > +		}
> > +
> 
> If one part of the RNDIS packet is wrong then the whole receive buffer is
> damaged. Just return, don't continue.
> 
> It could really just be a statistic and a one shot log message.

I will let the loop terminates and send NVSP status fail to the host.

For statistics, this range check is to catch potential host side issues, just like
these checks in the same function earlier:
	/* Make sure this is a valid nvsp packet */
	if (unlikely(nvsp->hdr.msg_type != NVSP_MSG1_TYPE_SEND_RNDIS_PKT)) {
		netif_err(net_device_ctx, rx_err, ndev,
			  "Unknown nvsp packet type received %u\n",
			  nvsp->hdr.msg_type);
		return 0;
	}

	if (unlikely(vmxferpage_packet->xfer_pageset_id != NETVSC_RECEIVE_BUFFER_ID)) {
		netif_err(net_device_ctx, rx_err, ndev,
			  "Invalid xfer page set id - expecting %x got %x\n",
			  NETVSC_RECEIVE_BUFFER_ID,
			  vmxferpage_packet->xfer_pageset_id);
		return 0;
	}

If these kinds of errors need statistics, there will be many stat variables... Maybe we 
should just create one stat variable for all of the "invalid format from host"?

Thanks,
- Haiyang

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
