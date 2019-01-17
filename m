Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D433F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gNVKizDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAQQEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:04:37 -0500
Received: from mail-eopbgr700096.outbound.protection.outlook.com ([40.107.70.96]:12218
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727584AbfAQQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L4pYCNsXYujSLk8ATBti9oOkeJ7mRytjguP8qVqLmM=;
 b=gNVKizDxcwHJR2ygRRh2iHn1Y6ZXD078aSr9vr8lVNs0ol1Ie4hCRI1uEo/tfhHl8EyuZgZXXtQ9SdxtVf0v6a1CisXMmOqMAqo//JpXJ5VcN0rJp2W8z1+4uN6K6nB9DVKHt/+KSu57ePAwnyPRaLQkujLqfEpqszsmxRRt2xs=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.6; Thu, 17 Jan 2019 16:04:32 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1558.009; Thu, 17 Jan 2019
 16:04:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUrh5woO6j9xz0e02TR4MQQ7VlMaWzoBtQ
Date:   Thu, 17 Jan 2019 16:04:32 +0000
Message-ID: <CY4PR21MB077319568D7029F2F91B6C15D7830@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190105043518.GA4072@ubu-Virtual-Machine>
 <20190117043759.GA3395@ubu-Virtual-Machine>
In-Reply-To: <20190117043759.GA3395@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-17T16:04:30.8636782Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=44fb39d7-be69-4dfa-a7a0-6bfa7f1de07a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:2:e118:1107:8ec9:e85f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:FNcNDVq4y4HTZrso/FVQzhuS93qw58BftSR8B7IuQRqo/lx8/ko14nGrq73VjVMzdad0HsZBtemjUrz6+8m68ipAoztq62XB57lMw5L/dziwwt32QFpOaMlZ0Kr1rL5o7CkgWyIhzmELfAHknJyxvZLLtJg+pDQQb2GzmOdgZlJM/ygmaznZv7rvoQs+tSGnBAHoHXUdzQelmL4AULxPeTnPuCXS92PkIMki/98yVEwsPEfFF5UGbHtKNJgruUtj3K9lJw865ZaU0e2tyMB7ZXn4yzsHfcvzvHif+/wOR3EsTH6E3ZB4bOlP3eJX5kM2NhRD9ZrNZGQ1dmgNGhTxt6kreWNFq6AybItGfORVp4wv8bFPjbP5CbxYC/wCzUo6/CwA75O1SZH6fMURaWAAP3RN9uw47Oe6cUjyvtTMdcN9HrMs1DKvmhjvZkjs5Rjyte5e1/GvoAr9G8kBi/nqfg==;5:JTvOasgq2EurlpHlyNIRWEk910CnbA3pX1P5kUg0Y0GGu82CZLi4rWLNWYhpyZD8OV20rI8XY57670Yph19lYmF25t81t1gIpuxVzjk7B7lD/BKNpAvUD78FfWkiL/+mEXkjM2wha/3j56GbwyHgKlKlKp0pnH6xZLU70idI1+6tAFDk+E4mzBjp+lMOORFojOpwcsT+IynhnQZ8mttRtQ==;7:GwBM9L7ltcrAGddRADye1Wyx+qIJ+io6hAVfZBlpt3zsn6eLxLrY7faosq+kxWYkOuROF/joXhhhIFgxv0keCXWwOcfHnenrb+p39pJKP5GOfCNZPgVbvozJtRCBrJ6xVCjaGXzlcKDH+WnKp9z/Ng==
x-ms-office365-filtering-correlation-id: adf9d0be-0073-40a6-d49e-08d67c957828
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB085495D6A7247EAF3D790891D7830@CY4PR21MB0854.namprd21.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(81156014)(46003)(71200400001)(8676002)(81166006)(6636002)(446003)(86612001)(39060400002)(25786009)(478600001)(7736002)(10290500003)(5660300001)(106356001)(53936002)(476003)(76176011)(105586002)(11346002)(4326008)(6436002)(102836004)(186003)(14444005)(99286004)(71190400001)(6246003)(6506007)(6346003)(486006)(7696005)(256004)(74316002)(305945005)(229853002)(8936002)(1511001)(33656002)(110136005)(55016002)(97736004)(54906003)(2906002)(22452003)(9686003)(86362001)(316002)(6116002)(10090500001)(68736007)(14454004)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e35Xniib92G7xLDc3QWjqQkefZX36lYMLu1MUeLVYrUc87ClKGC88d9fFjCHIRBvsP2GgsZS/qiGrXQSSunb+n5LCO8oS9I0UNUaEnge+z9/UyVfAxi4t9U8j1vuO6V56b1yqt+TDGbcuGTe6kL1OZNviAbrtWSCN+SygHto1e2HsHUIHFXe6gSCdHRE+8nicZiZzjEv2L8n7idJA2latH2W7p6aXnIp9Zu71n1fGiOTeFEY8+JSuQVCP7GCpFxsUd9Meh4eRSNMgJmAroeJiIkK7ARmGHzygEbGTRzI6nmoj/6H7fxGZ/l1kUGJl4lCVdfFM4zQOeMTfJq/G9FmSSHkFEIKlR6WW4chErzKQS5Z3uocU4k0lPVSHBgHV4+7rqY+bxdng6EgTlevEpOyLLdXhKVY+5yBh7YcAu6Ynss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf9d0be-0073-40a6-d49e-08d67c957828
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 16:04:32.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Wednesday, January 16, 20=
19 8:38 PM
>=20
> Counter values for per-channel interrupts and ring buffer full
> conditions are useful for investigating performance.
>=20
> Expose counters in sysfs for 2 types of guest to host interrupts:
> 1) Interrupts caused by the channel's outbound ring buffer transitioning
> from empty to not empty
> 2) Interrupts caused by the channel's inbound ring buffer transitioning
> from full to not full while a packet is waiting for enough buffer space t=
o
> become available
>=20
> Expose 2 counters in sysfs for the number of times that write operations
> encountered a full outbound ring buffer:
> 1) The total number of write operations that encountered a full
> condition
> 2) The number of write operations that were the first to encounter a
> full condition
>=20
> I tested this patch by confirming that the sysfs files were created and
> observing the counter values. The values seemed to increase by a
> reasonable amount when the Hyper-v related drivers were in use.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
> Changes in v3:
>  - Used the outbound ring buffer spinlock to protect the the full
>    condition counters in set_channel_pending_send_size()
>  - Corrected the KernelVersion values for the new entries in
>    Documentation/ABI/stable/sysfs-bus-vmbus
>=20
> Changes in v2:
>  - Added mailing lists to the cc list
>  - Removed the host to guest interrupt counters proposed in v1 because
>    they were not accurate
>  - Added full condition counters for the channel's outbound ring buffer
>=20
>  Documentation/ABI/stable/sysfs-bus-vmbus | 33 ++++++++++++++++++++
>  drivers/hv/ring_buffer.c                 | 14 ++++++++-
>  drivers/hv/vmbus_drv.c                   | 32 ++++++++++++++++++++
>  include/linux/hyperv.h                   | 38 ++++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
