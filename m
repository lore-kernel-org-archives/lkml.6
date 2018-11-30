Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB05DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F412146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qnCclCUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F412146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeK3R5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:57:09 -0500
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:36352
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726712AbeK3R5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU9Nuy5ft4SYNx64SrtRP4qRjb4rZkEGyNoAXnF9HMw=;
 b=qnCclCUMjWNsAIPZFwRjbDUVPf8ZBCSDA3OzuEfPfa62om8X2FpahJEF8+/GJqSPUNna3BK51KcCY0PpHTgser/xgoVoGrTl7zgUGMnH5VxwShq9trZAmN9TmyTBr6gA5/SCXEdO5Dcre5RCgGiqPObvUSzZ3wPWImZojclYoV0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4111.eurprd04.prod.outlook.com (52.133.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 06:48:08 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f%4]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 06:48:08 +0000
From:   PETER CHEN <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "pjez@cadence.com" <pjez@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 02/15] usb:cdns3: Device side header file.
Thread-Topic: [RFC PATCH v2 02/15] usb:cdns3: Device side header file.
Thread-Index: AQHUfyb+aUFhhBYMmE22NGY2nigEBaVn8MfQ
Date:   Fri, 30 Nov 2018 06:48:08 +0000
Message-ID: <VI1PR04MB5327F686BE6E9F5D85380BA98BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-3-git-send-email-pawell@cadence.com>
In-Reply-To: <1542535751-16079-3-git-send-email-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4111;6:ry8DgYxSJWdtjPQKTxBJm03tdulFHSIAjZp5eEVa5E9YDGZHtefSGayoXrouD3UX+xEl0nPt7eE0xxGx2/Qgkv5Q7Cc116N86w21RBb1dsZNLYl8QtuS/V+meZ9Bp4kHTeifDx4FKFc/8vjc3C+348R/X2fZj7dcgtbKWbOhU4eieFSKX6t97T9VorCFN0/uChPtk3nGldB4wlfF66w95aXtio8oDoCA33zlmNCWK4xAjLNIfSPvYfwIZPIcmyTOLBg/ZafeYZCz923A8Jp0uTD1bBZUj7iLorIcXfEbCDkwGlVntF66ooBefHclsWU8/OvLwAtvhWgUUdtNqRddayXH9dEkUVazeSLedYpGWnLq3Zi2TyXAgsDyA0Y5wJZGZSKN3FVax6elzul5k98uXx8Y2ibWfQikVytjwKtd47ZrVWDQffTGGmCxPdlWiA15RDNjrrDtCM0zWsLCn7xiKw==;5:9aSlOXvSL0M0wa+EvtIg/QVGP58kl3crF+itsXT2TUiGkHiexU18KheNjrM9X5Rbywq8/ycqciIUpRso5nd9Ez/KqbgkrKVFNq0hPBW3MaF4Q6ggaDMv8zqTeOUApNj3eJkdSPLqk7lxBAnhWpuc91I/HpT2WYjMaZGdT0L0OyQ=;7:iF1og2ftL8nr+U97bvORzQyzYQPfF4DBWJTRsg2fqouRtRrAWAmZUmkfpJHNzLDsU1LxmNKg9v5+R04hqYjoFFf//4xmxPPLai9BL7jzbWQrmrlkTg5UM8DzUIUvDwKZQI3jXCCLlS+Ot4pAaL1Q9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 093c803d-6a54-46c0-761a-08d6568fc9f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4111;
x-ms-traffictypediagnostic: VI1PR04MB4111:
x-microsoft-antispam-prvs: <VI1PR04MB41116E95E055B41D751A7E188BD30@VI1PR04MB4111.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231453)(999002)(944501463)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4111;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4111;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(68736007)(102836004)(5660300001)(7696005)(66066001)(53346004)(105586002)(2501003)(25786009)(7736002)(229853002)(305945005)(76176011)(99286004)(97736004)(53936002)(33656002)(74316002)(316002)(54906003)(8676002)(110136005)(8936002)(6246003)(81166006)(81156014)(55016002)(9686003)(2906002)(217873002)(11346002)(478600001)(86362001)(14454004)(4326008)(476003)(106356001)(446003)(486006)(186003)(6436002)(256004)(6506007)(71190400001)(71200400001)(6116002)(14444005)(3846002)(7416002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4111;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZGtweJJHH9DxQ8gA0ARP/WTwgSLS4rwF4BzpKOcCvJ/kwhvd12ESnkEjX+ZK8YnmyuleP85l37sXKv3mmYm1+XNIEAskfyvyGZ60zFavEAckjbspu7/ojPxdxPiZVG4kb+PtjGIsK4IdAIc8DDwzRgUlXQroXg1ytFQljsC0T06lSL3aXrZvAGXNgd+fTnsRoDVfbuN4WhQHh66fISW8EKd9oFPrTNm/nEo/7m6BmV9H7ikcnLUGVLUYGDTkKW3XfpzpfNRPI1HSpDMpOMYsfi8Lnkx+P78686bBxc77OByH8v0b7ZDujTOxcqbDcvhlFC4Q2SPVNw4FsRtWsIFnSX4vxwMn5aipJPqhRQyzqAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093c803d-6a54-46c0-761a-08d6568fc9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 06:48:08.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
=20
> +
> +/*
> + * USBSS-DEV register interface.
> + * This corresponds to the USBSS Device Controller Interface  */
> +/**
> + * struct xhci_cap_regs - xHCI Host Controller Capability Registers.

struct cdns3_usb_regs - device controller registers

> +struct cdns3_device;
> +
> +struct cdns3_endpoint {
> +	struct usb_ep		endpoint;
> +	struct list_head	request_list;
> +	struct list_head	ep_match_pending_list;
> +
> +	struct cdns3_trb	*trb_pool;
> +	dma_addr_t		trb_pool_dma;
> +
> +	struct cdns3_device	*cdns3_dev;
> +	char			name[20];
> +
> +#define EP_ENABLED		BIT(0)
> +#define EP_STALL		BIT(1)
> +#define EP_WEDGE		BIT(2)
> +#define EP_TRANSFER_STARTED	BIT(3)
> +#define EP_UPDATE_EP_TRBADDR	BIT(4)
> +#define EP_PENDING_REQUEST	BIT(5)
> +#define EP_USED			BIT(5)
> +	u32			flags;
> +
> +	void			*aligned_buff;
> +	dma_addr_t		aligned_dma_addr;
> +	u8			dir;
> +	u8			num;
> +	u8			type;
> +
> +	int			free_trbs;
> +	u8			pcs;
> +	u8			ccs;
> +	int			enqueue;
> +	int			dequeue;
> +};
> +

Would you please add kernel doc for above structure?

> +struct cdns3_request {
> +	struct usb_request request;
> +	struct cdns3_endpoint *priv_ep;
> +	struct cdns3_trb *trb;
> +	int start_trb;
> +	int end_trb;
> +	int on_ring:1;
> +};
> +
> +#define to_cdns3_request(r) (container_of(r, struct cdns3_request,
> +request))
> +
> +struct cdns3_device {
> +	struct device			dev;
> +	struct cdns3_usb_regs		__iomem *regs;
> +
> +	struct usb_gadget		gadget;
> +	struct usb_gadget_driver	*gadget_driver;
> +
> +	struct usb_ctrlrequest		*setup;
> +	dma_addr_t			setup_dma;
> +	dma_addr_t			trb_ep0_dma;
> +	struct cdns3_trb		*trb_ep0;
> +	void				*zlp_buf;
> +
> +	struct cdns3_endpoint		*eps[USB_SS_ENDPOINTS_MAX_COUNT];
> +	int				ep_nums;
> +	/*
> +	 * field used for improving performance. It holds the last
> +	 * selected endpoint number
> +	 */
> +	u32				selected_ep;
> +	struct usb_request		*ep0_request;
> +	int				ep0_data_dir;
> +	int				hw_configured_flag;
> +	int				wake_up_flag;
> +	u16				isoch_delay;
> +	/* generic spin-lock for drivers */
> +	spinlock_t			lock;
> +
> +	unsigned			is_connected:1;
> +	unsigned			in_standby_mode:1;
> +	unsigned			status_completion_no_call:1;
> +	unsigned			u1_allowed:1;
> +	unsigned			u2_allowed:1;
> +
> +	u32				usb_ien;
> +	u32				ep_ien;
> +	int				setup_pending;
> +	struct device			*sysdev;
> +	/* The device mode is enabled */
> +	int				start_gadget;
> +	struct list_head		ep_match_list;
> +	/* KB */
> +	int				onchip_mem_allocated_size;
> +	/* Memory is allocated for OUT */
> +	int				out_mem_is_allocated:1;
> +	struct work_struct		pending_status_wq;
> +	struct usb_request		*pending_status_request;
> +};
> +

kernel-doc please

Peter
