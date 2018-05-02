Return-Path: <anuragku@xilinx.com>
X-Google-Smtp-Source: AB8JxZpqjJEeO6xH8yAxzsKlXabyVpnHVenJCKHYqHqh1eE9a3TO+PgPmpBBbmunNy9X44Q8qTGA
ARC-Seal: i=1; a=rsa-sha256; t=1525272150; cv=none;
        d=google.com; s=arc-20160816;
        b=akogmeTE3SeM3ft6XgM3/VZQs5brAn+NEOx+TmgWJcsucqKDbKrN5Zw03PPFfCUGsz
         jfJLikmfxB+x9ss3OOZYRzhp46tpcon0eyJwGRzB94l27nec/oiMPu5JyDqJmxSgcaUk
         DmqLsTnVeUkr1xYnok/PO9ymQqNMDL80Xk1sCsqCx3yzqh+kWz1AVKjBzBk5ZPh8XREY
         m2H6oOE1nUGFDvDjEnWJCi/b20eAaQIsIZGEzIgwZWURDvNEI/vJh0UIfOOxbQiaxQT0
         qLmw/qFb5mHV2elmjiRbghApJZGYfSouran2v4r38QQKdOaUpb0xCS6EYIBfjlTm/NKS
         fx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=sVtp+TzKA2XG/aSXse21vBBKx+TehEX6hd51cxuSKt4=;
        b=xVwd7LG3IQKH8GJ0TAcRdcxIp6Sr1vmMX8I1ij6n+vbvfWAr0B49R/TOqqvy1HLOWg
         Jd+R/qpdfMkBQQ9Ol7jGQfOrdNHYqHQpJxjmxKhumle7q4N3sTQMAXmvKlCYxIXUOR8/
         eCxHP/FKkBk48AYf4zCyOX1vkLHjdz6ytxq4Zl5gyJGonMIQv6PSztsZ26NB724GxyOE
         CA5ibzB/GkAW8AM5bsxQ2ZDx9LY6h9KTZXX19xGvXIzTSU8PgxZl14V9FQ5ZSqepGqRt
         qEdyhAlIq0P4b/fugMhY76WkNQZBUR4io9lb44p78kqHPDvifwF1ChyXMqS50001I3hb
         fW6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=ORklIm+l;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.32.86 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=ORklIm+l;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.32.86 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>, Felipe Balbi
	<balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] usb: dwc3: gadget: Correct handling of
 scattergather lists
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Correct handling of
 scattergather lists
Thread-Index: AQHTxbuRpxRRkTrSWkuPKxweCPIF9qQcbfGg
Date: Wed, 2 May 2018 14:42:27 +0000
Message-ID: <MWHPR02MB2816569033C90C85ACCFB767A7800@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1522148721-5744-1-git-send-email-v.anuragkumar@gmail.com>
In-Reply-To: <1522148721-5744-1-git-send-email-v.anuragkumar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2686;7:0SmMynpYmtzlzfWV3ahQhJfJna/elRXdkhOQlQ+3sDDxCJQTTiHCgwE4XqiQQ3mddQ4shMQXYMU5zdZq6XBhUyrGzoRYY7WMygsGqsuKVOsDidXSm3uQv3IBOB8hCWA6mxro5MwYdFbseVX/d0QevnuU1R/+XGwP+p1p2nlW3KLmVTL3HHwHziFwoxW9FsmqeHBph0J25wvuxe1qWjTxJPb2ObRBvT2Q34KJKjUfb8b6JIUd6ypCqDviKrNJZM3n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2686;
x-ms-traffictypediagnostic: MWHPR02MB2686:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB26863E6A741630AF39C597C1A7800@MWHPR02MB2686.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592)(36289512736943);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR02MB2686;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2686;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(39380400002)(366004)(346002)(189003)(199004)(13464003)(53754006)(33656002)(476003)(3660700001)(3846002)(110136005)(6116002)(5660300001)(81166006)(478600001)(39060400002)(8676002)(2900100001)(3280700002)(229853002)(11346002)(66066001)(316002)(4326008)(2501003)(7736002)(55016002)(81156014)(8936002)(97736004)(5250100002)(105586002)(9686003)(74316002)(53936002)(305945005)(68736007)(446003)(7696005)(25786009)(99286004)(86362001)(6246003)(6506007)(55236004)(102836004)(106356001)(59450400001)(186003)(486006)(6436002)(26005)(14454004)(2906002)(54906003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2686;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: psx6iYUd87McvndYjYadptMylp3Nn1UmQqOE22iW99gcae0Oo+dY6IzJlozRa9Iyrvca8jazMJq7s6M8dKm5qn1fUwOZzHA5DyV5CHEBRHCceX0nrBTitGQevERz+e73ebq16fu5II9/AMKwF7kLmmfeDjIL+42iMPYyy9lLNYU2Cp19a/l3MUXO/hgWnDN5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5c1af943-3a66-4cc0-6202-08d5b03aed3f
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1af943-3a66-4cc0-6202-08d5b03aed3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 14:42:27.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2686
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596088641378533923?=
X-GMAIL-MSGID: =?utf-8?q?1599363770433045385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Please let me know if the changes in this patch are okay . If the changes l=
ooks fine , can we proceed with this patch.=20
=20
Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: v.anuragkumar@gmail.com [mailto:v.anuragkumar@gmail.com]
>Sent: Tuesday, March 27, 2018 4:35 PM
>To: Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Yugalkis=
hore
>Pandey <APANDEY@xilinx.com>; v.anuragkumar@gmail.com; Anurag Kumar Vulisha
><anuragku@xilinx.com>
>Subject: [PATCH v2 1/2] usb: dwc3: gadget: Correct handling of scattergath=
er lists
>
>From: Anurag Kumar Vulisha <anuragku@xilinx.com>
>
>The code logic in dwc3_prepare_one_trb() incorrectly uses the address and =
length
>fields present in req packet for mapping TRB's instead of using the addres=
s and length
>fields of scattergather lists. This patch correct's the code to use sg->ad=
dress and sg-
>>length when scattergather lists are present.
>
>Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>---
> Changes in v2:
>      1. Split the single patch into 2 patches as suggested by Felipe Balb=
i
>      2. Renamed sg_to_start variable to start_sg
>---
> drivers/usb/dwc3/core.h   |  2 ++
> drivers/usb/dwc3/gadget.c | 25 ++++++++++++++++++++++---
> 2 files changed, 24 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>860d2bc..1406c4f 100644
>--- a/drivers/usb/dwc3/core.h
>+++ b/drivers/usb/dwc3/core.h
>@@ -718,6 +718,7 @@ struct dwc3_hwparams {
>  * @list: a list_head used for request queueing
>  * @dep: struct dwc3_ep owning this request
>  * @sg: pointer to first incomplete sg
>+ * @start_sg: pointer to the sg which should be queued next
>  * @num_pending_sgs: counter to pending sgs
>  * @remaining: amount of data remaining
>  * @epnum: endpoint number to which this request refers @@ -734,6 +735,7 =
@@
>struct dwc3_request {
> 	struct list_head	list;
> 	struct dwc3_ep		*dep;
> 	struct scatterlist	*sg;
>+	struct scatterlist	*start_sg;
>
> 	unsigned		num_pending_sgs;
> 	unsigned		remaining;
>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
>2bda4eb..330a4de 100644
>--- a/drivers/usb/dwc3/gadget.c
>+++ b/drivers/usb/dwc3/gadget.c
>@@ -978,11 +978,19 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep=
,
> 		struct dwc3_request *req, unsigned chain, unsigned node)  {
> 	struct dwc3_trb		*trb;
>-	unsigned		length =3D req->request.length;
>+	unsigned int		length;
>+	dma_addr_t		dma;
> 	unsigned		stream_id =3D req->request.stream_id;
> 	unsigned		short_not_ok =3D req->request.short_not_ok;
> 	unsigned		no_interrupt =3D req->request.no_interrupt;
>-	dma_addr_t		dma =3D req->request.dma;
>+
>+	if (req->request.num_sgs > 0) {
>+		length =3D sg_dma_len(req->start_sg);
>+		dma =3D sg_dma_address(req->start_sg);
>+	} else {
>+		length =3D req->request.length;
>+		dma =3D req->request.dma;
>+	}
>
> 	trb =3D &dep->trb_pool[dep->trb_enqueue];
>
>@@ -1048,7 +1056,7 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
>static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
> 		struct dwc3_request *req)
> {
>-	struct scatterlist *sg =3D req->sg;
>+	struct scatterlist *sg =3D req->start_sg;
> 	struct scatterlist *s;
> 	int		i;
>
>@@ -1081,6 +1089,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep
>*dep,
> 			dwc3_prepare_one_trb(dep, req, chain, i);
> 		}
>
>+		/*
>+		 * There can be a situation where all sgs in sglist are not
>+		 * queued because of insufficient trb number. To handle this
>+		 * case, update start_sg to next sg to be queued, so that
>+		 * we have free trbs we can continue queuing from where we
>+		 * previously stopped
>+		 */
>+		if (chain)
>+			req->start_sg =3D sg_next(s);
>+
> 		if (!dwc3_calc_trbs_left(dep))
> 			break;
> 	}
>@@ -1171,6 +1189,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
> 			return;
>
> 		req->sg			=3D req->request.sg;
>+		req->start_sg		=3D req->sg;
> 		req->num_pending_sgs	=3D req->request.num_mapped_sgs;
>
> 		if (req->num_pending_sgs > 0)
>--
>2.1.1
