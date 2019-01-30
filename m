Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03C218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VwM3v9EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfA3Ufj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:35:39 -0500
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:25184
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387609AbfA3Ufi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvquaKx42gXLhPmyqBpJgmxRyWFt+hdZBF/O779AfNU=;
 b=VwM3v9EQkjji0FNLxT0cgd5ehetyKm/DehUxLjDHWqraKyTeTed1sFxUdRMvdHkC+C9nxS1gA8iCdozq4ZG73KQyEdWk0GfjumAw4RgU9GFHvhTbuB2QsRBAiW2WIYHuG5BDM9g4nDShcSkjJV88Tjxn3beLYl4/U7MYq9N7xrI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Wed, 30 Jan 2019 20:35:32 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Wed, 30 Jan 2019
 20:35:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH] nfit: Document sysfs interface dirty_shutdown
Thread-Topic: [PATCH] nfit: Document sysfs interface dirty_shutdown
Thread-Index: AdS42zb+6lKJngzXS46K40iCynMfvg==
Date:   Wed, 30 Jan 2019 20:35:32 +0000
Message-ID: <PU1P153MB0169A031D0ED4BEEE272829ABF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-30T20:35:28.0779207Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=972b0a80-c1bd-4e88-be58-7b26132e6dc3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:e07a:40bd:14fc:76ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0201;6:SutmMDojCeIbqpKE9Uvow0hR5/GQ5kWA72EhJV96K0mhEzokeYx6qHkdGXVDfVOqCLwNM2zTB6UOK/gkwU3qzREs3Pu6Iz6CRK71UtJO8qQMDqEbjhN43LRT9/AQ8ot8Tj9ccUgjPhzjnxQNF0NmFalb2YbTHPTQJ1OSB0JNJma5SMZTONYD+FxxgX44hh3EvZlzNjGvZj47FqXIKN8d2CI5jSYH0uPGNx60Lpjry3fYhTQCGXBBYUg6GNe6UA9tThJ4xM8lW8uaNQ64pbyKCXcIp17xFBhg7x+eCnuRHE9h3r72+CfD7pU4ytsxjG0Oq7JuB+wtup8OO1LKI+LkLMuGFy6MIB7mSYrNBgDLLgMK17OFaRWoQf3WtMkCQNW0Xx/sQFgZHPKoaURmnEbvjKWf4RvIc07HIXzbKoFvKUl5NtIQi8YV7bUaIoo8sK/Sw20+02uJZZHJy7ngKcAIAw==;5:iGidG0SlBwbmRp/bqQClR9Sn+hFzmNIbRqqTVlOWKTNQ/uIHNPccuw1Qxr4s1/71adGNTGnKeeJuOgOdkmxNrygtoOFE7BDQZs+d66txt+siNlVJkAPlWsIW02O2Dw60MHFrO0DzUBBvpiDENRqeZclR2bct32itg+Rl6KQsneU+cCDnkm/gEsczPmE3wkHZ89AEdeSC/vAsruMQzekBkA==;7:SkBmbJHT+xvLwuO1SPqxtYHmKUNIvH/9csiy6tdx0TusEKZAyB7/pBUlHAeIK7Xy4x0JbEYp5Fzw3Sm9NpbGlIG4pp5abcowaOY/OwrzACW6FYwrhYugMuCokhkhNGQxDpwRIQfZYzM2cBARs1KiVg==
x-ms-office365-filtering-correlation-id: 9589271e-8c5b-4fad-daf3-08d686f27b1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0201;
x-ms-traffictypediagnostic: PU1P153MB0201:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <PU1P153MB0201FF8848207B1A014B813BBF900@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(99286004)(2501003)(8990500004)(107886003)(7416002)(71200400001)(2906002)(55016002)(53936002)(25786009)(4326008)(7696005)(10090500001)(9686003)(33656002)(6436002)(4744005)(71190400001)(68736007)(86362001)(2201001)(476003)(110136005)(486006)(22452003)(46003)(105586002)(14454004)(97736004)(6506007)(186003)(102836004)(81166006)(7736002)(106356001)(8676002)(305945005)(54906003)(478600001)(81156014)(74316002)(6116002)(256004)(10290500003)(8936002)(86612001)(316002)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5xtTcVirOueKLvBaWBSg1fwpnxsxmKBnaPfoca1p8k14uCoMQL+SO7M3lsok/4dTd1hGBq6XZboTvQxIDRDne9dapVwHgN0/Fx4c97Lnz6jrAG6HlprGX45n/QIqSxuGbjz8JC7WMQ7mKsBh7nJUsZqOrAjguzNmBrDTQZB1bJd8OPYXyjKF9SKl3+yba5KmIZxRtzwGBsY9e6DnMXFU1rKJPIqt8QzvDbKjF/E1U732pl7vIRl2S45GNzQ6DklUaG6tTq+gY2i3KsZ3dLYagVn1NpKXHfAsYmXg/TQUuxZNgItic+k6CxKkAhJYUAxDmRk6Z2TFyDYRFuk6qDi0CyOiN9zFgCH1C0xqte7ipXHbYGgswSWN06Gji1kTxnSUjkhYYy+3WLyrH+zX42CGKhpbA8Leif9ztKIA+SqeaTM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9589271e-8c5b-4fad-daf3-08d686f27b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:35:32.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The new sysfs node was added in Sep 2018 in:
commit 0ead11181fe0 ("acpi, nfit: Collect shutdown status")

Now let's document it.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 Documentation/ABI/testing/sysfs-bus-nfit | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/t=
esting/sysfs-bus-nfit
index a1cb44dcb908..bd6cde8c0ea9 100644
--- a/Documentation/ABI/testing/sysfs-bus-nfit
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -153,6 +153,14 @@ Description:
 		subsystem controller vendor.
=20
=20
+What:		/sys/bus/nd/devices/nmemX/nfit/dirty_shutdown
+Date:		Sep, 2018
+KernelVersion:	v4.20
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Unsafe Shutdown Count for the NVDIMM device.
+
+
 What:		/sys/bus/nd/devices/ndbusX/nfit/revision
 Date:		Jun, 2015
 KernelVersion:	v4.2
--=20
2.19.1

