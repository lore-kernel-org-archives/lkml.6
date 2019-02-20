Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cYqfrYjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBTOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:36:04 -0500
Received: from mail-eopbgr750094.outbound.protection.outlook.com ([40.107.75.94]:52448
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfBTOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejOHt670Q4VWjRJYeN9j22kjyg2FO4bq+a4AP8yZS1U=;
 b=cYqfrYjVzjRBTwvSr0GzavWJrwm6vnHapyvrw/4jOdqquDYQhEi6YZLLIjvdbeaBtAQ4E/zXBjLqHvXWl9AdeZMOkDWMG2EVR03qf2PRxUMmqfgc4NuXOCpMpxQD9VvqCqrOtZ3+sjh+Nopc0awB2bu3cN6nnB4p9qXAxD/d2Rc=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0936.namprd21.prod.outlook.com (52.132.131.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.6; Wed, 20 Feb 2019 14:35:20 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Wed, 20 Feb 2019
 14:35:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Change server monitor_pages
 index to 0
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Change server monitor_pages
 index to 0
Thread-Index: AQHUyBVPicmAuhkM4ECG0xm+8y+3g6Xowh5Q
Date:   Wed, 20 Feb 2019 14:35:20 +0000
Message-ID: <DM5PR2101MB0918DC46656CF89D98B59F96D77D0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <cover.1550549612.git.kimbrownkd@gmail.com>
 <23823f617d325c9e961d2433901e6bba3e7ca5f2.1550549612.git.kimbrownkd@gmail.com>
In-Reply-To: <23823f617d325c9e961d2433901e6bba3e7ca5f2.1550549612.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-20T14:35:18.7864054Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69a52286-5f74-4d35-848f-231a6423263b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 450a9461-f0b4-4d80-d157-08d69740a430
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB0936;23:aY9q5Ft6r/BPd9TjBx8Rm7FW7ayGQGaHKSSQnOf?=
 =?us-ascii?Q?2muwPm1STxxPbfOXWkf9eu8p2ci8+uY6QxbIi1f6dl8epC1InbYTsNPQmPCR?=
 =?us-ascii?Q?95SQXwju/KMOyKZHKq8hXw7FfL90J0n+SIrD6653EgtEFl9+qHyjHGYvbqY+?=
 =?us-ascii?Q?FIBSPgeCQruy0w87InvD7S1FEzzn9CPV4QM/TI70VxvTaXiKQSMRsMNzroTE?=
 =?us-ascii?Q?6L4XOyNDOjGe8zCnCakbQl5+kE6ENITwm9FyYKI1ZJFRtLZRRRJyFxZvBJJ8?=
 =?us-ascii?Q?ZSWTGiU1kDZbqCwAekhOa6Tq7O5vUHYsugdzznLNY5VGH+hQP4k0Pyi1DV/M?=
 =?us-ascii?Q?XXGi+cmEp0vnKCIXB1rAsbYgel5R+4rhdfiQXs/OsLGGlpc0DnOb/9PUE+CU?=
 =?us-ascii?Q?hGzFmtIEezwJrMKVsuB0XVdqybCc8fHy+JqZh+MYItIFxBJxguSmKCZsOLj9?=
 =?us-ascii?Q?rD3IVAwJqaKy2SPgmWdveDp39W/faFbZ7NmYsDmXNfSPGqb3QiGFn5CPU24Z?=
 =?us-ascii?Q?SsEmY6CZUryq/XYvnl/4xHm9ECaEShfvrVZNXWE3dEnTalZQmBcEb5On8yRt?=
 =?us-ascii?Q?aw6SIRhxUIioar2PXbg32VWM2nTEIko61RMFonh9xtijhF5KVBZH5JpO9Pis?=
 =?us-ascii?Q?4Fgf5uIXNOa9+tr2orKUzrVM8KJO5YEO+Ek3EoZvQfS142nXZ/FmkDKdn9JV?=
 =?us-ascii?Q?OE5/kYDixgJ6Ncg1iSEgSSJDXIYxebPktxA7v0Po/+MjO/zKn21U5JwPVydJ?=
 =?us-ascii?Q?j4vuB6J+ePGqSspzv6krxCSsBhXxWxFN5pHkYfFZ5jqGKuokdqF1TMn/sqqX?=
 =?us-ascii?Q?YJ9UlfpS+xuWkxjFj7g1znjC7axfrmQ61/SBYY3Nnjfd+3w+S1cGtu4UF9Ec?=
 =?us-ascii?Q?Qr6hyELrUAQtT8JHjHuZ3CThSKFlIbkhouRSlwReuYD+L+fpeUOQZEMs9Aql?=
 =?us-ascii?Q?VZv6fWvFEDoBXiszH6Ha+qU6B3vXgP3uLGSBROd5kedR8NjqZo791+D+JnbW?=
 =?us-ascii?Q?s+FCDiOvGNQHU+E0vvbZTym5J8/AJ+g2UvU4MNdLVfxN6GY0wZeGFmqCvSY/?=
 =?us-ascii?Q?8aYlDPl7OlsWsUoNxkU+zAZma5j2x9llgfT/wWGEW9azVoBYJoBEMQ5fU6gg?=
 =?us-ascii?Q?rKp4LKgdoKwX25++1FWPGwp4PVWk9b6D0HBxA1XWW2JVWkxBeRhtb9Mt1kd9?=
 =?us-ascii?Q?0SvbEQFW5myW2IimHUdj9GQhSajKqrgNFocwbA8QX/7AZPeyo5zzBB9aETz3?=
 =?us-ascii?Q?vKTcC+s/8OSLRV6J0bhyBOfR70h+EqaZ8nRpujUy8+W5yxH6sgZB2+wlKXBe?=
 =?us-ascii?Q?5ywn1sqlksMj3Zrj86wSxkTx/ynuORsOksvAxtIWO0mjtNrbN3DdgBtou1SP?=
 =?us-ascii?Q?7GMz+VYgMhS9pCWBhFszWt12g4+Wi+0JKeejvXk7Kfbuf93svFMQOLJyigOB?=
 =?us-ascii?Q?05gCz6UDS7Q=3D=3D?=
x-microsoft-antispam-prvs: <DM5PR2101MB0936D32C9F010A9397D8F317D77D0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(3846002)(99286004)(102836004)(22452003)(54906003)(4744005)(6246003)(7736002)(110136005)(8936002)(81156014)(81166006)(26005)(1511001)(74316002)(76176011)(8676002)(6116002)(7696005)(486006)(11346002)(5660300002)(4326008)(446003)(14454004)(6636002)(97736004)(86612001)(25786009)(476003)(10090500001)(316002)(6346003)(2906002)(14444005)(53936002)(256004)(55016002)(68736007)(9686003)(105586002)(6436002)(305945005)(10290500003)(33656002)(8990500004)(86362001)(229853002)(66066001)(71200400001)(106356001)(71190400001)(478600001)(186003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qdbYE3dSsJI6Bb35YSJlXSv6tngDYIp6qYrd/m7dHQZFmc8qOs8oO7H/ETf0X3xRa+zVxNcFrEwYlIfqGCHWV0g4TQYoyRZobJkCKtWzkiUHUcxLzRgNyRfmMDy7+AC/GySYu59V4GrELwxeh7V2w58sOOQpGuFZOwaGYPZO/DseXE1gdi44CHoq1mLE6S6RKt+aKuCZfrMvFMBFFjWYP0g8NPsSw15d2ekl/1aUNYiOrhdvVMMnix+B8r9Wu/cMGsPrTOInBVFDRUP5RF0ib31ZmZ8b7iwcp5DJcmPZeAX6JPciar2dqyJHFWlN0axu9yx43nVnINv9Owtk42jt2T6Eqplq7IBnEYLGB+6/dBoTY3UKZAVfs5ZnRIl3r2Wgyn3BtmAj+BPiKBkhpkDvSmakwyTk9PjHMg5iyk4FthY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a9461-f0b4-4d80-d157-08d69740a430
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:35:20.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Monday, February 18, 201=
9 9:38 PM
>=20
> Change the monitor_pages index in server_monitor_pending_show() to '0'.
> '0' is the correct monitor_pages index for the server. A comment for the
> monitor_pages field in the vmbus_connection struct definition indicates
> that the 1st page is for parent->child notifications. In addition, the
> server_monitor_latency_show() and server_monitor_conn_id_show()
> functions use monitor_pages index '0'.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
