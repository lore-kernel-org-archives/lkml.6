Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95235ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD6B214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JwpuXEtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeIQI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:19 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729221AbeIQI1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqJ1nP12v9jtDgwwXue+a+KsafSnEyS6JD49gmPCoSA=;
 b=JwpuXEtAB6hST9tTzbDaWvKEDJEmcE2whNA6inlDx2t6KOKC4pIdl8gBhgQ+Ex+0m7W6ktOnLrjSKMf3PTL2pnh72rsd7Pmt6gh2EUfY0VMdC7DWatZmvmynFG/VDLdzrlsK0PeoplRsPVsOIno58ZkwtjTITRW+qgrMiVMdVL4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 082/136] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Topic: [PATCH AUTOSEL 4.18 082/136] media: tm6000: add error handling
 for dvb_register_adapter
Thread-Index: AQHUTjKrrqDZ1oVec0CbJZlZBNNTHA==
Date:   Mon, 17 Sep 2018 03:01:03 +0000
Message-ID: <20180917030006.245495-82-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:n0ufZVj35xhXUVq/HzER6rtXJWctOiA599qlMVEfJsK9sZuiymhMVzwmFxXm+ascGAPYUVnlCmLP2ygeVB/IUnFh7Ox0xmQaM1Ze18k0PGkW5XghkhK8KJlwbxYZvX5ArLd1Ol2F4BwQx7jK0hCvIfVAhznM6Lb8Li4WxfuChcRMC/5UhMrOW90P+y0MBxo3iF+Wuzd/bL+r4yD7lU3BYnvMNIvwEgG75cQMId+KbqEF3cWZgE7VmA93gmuRKoLwRPPGn5gz6eIlWK6W84uF2KPdu/J2xSSUX2V+Vgtm6eiA9c1Z4XXTIqT8yj3Hd/nAGs/JZ+lrmqkvqd5O3RE4seumTDh6XZcDvrCn1PA4CD6RiKm29AbQFwJQ1q4gCuXs5uPCwp1qMRNyB09YdV4ND0hLos8x3VEC4ej/3b048VdVAPp2mSMgneBTHAEN05wvkCmUHpC+CL7ZbCTG642BOw==;5:zJR9AdkdAoKaH9Z70brBTHbp0bmK/UE+rksmJBP0rbU/3l+FEdmuI7R8wBXcMnvEvcAwABliJ2uO5QUL01oeDxHQzuyIcUFFZcm2H7ELAIY3WkUmm7L0qVprju9NF3TM2P+24ZPDXkpdE8oSv7MH2fDZ6vUksWGN4xc4CYVS1rM=;7:HFREj9v//eWuDIY6g+cBffrnlqfrV98Y/aU1TW/8DCA0qOe/TLbRLOyqxXr3M80FIvgkWqXDQZi+PqioNnR48W5T+0vk1bhtqjv+634rKW1O7oMQihCCA+lVy6NlbUxtqGWVOWamNtmYYxVH1oDf/5JYE0yGC0HbKaYE1aJV2HEB6Mv21Ixgbeq/xKvXQlwWvmeZ1GSki4mus/6tNSoUGEVdRhen7TND4KQ339UD1Fh4wQCzRIl6u3K8edfGEozN
x-ms-office365-filtering-correlation-id: 8aa93fa3-35b7-49a8-8941-08d61c49f065
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB079007B7A85DB6EFE678C846FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(39060400002)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fscFcvqoRvzUKoOuAXj7RlU3Ew0rlZelgVGLjriLgWAO/SvZdnMUhX+WgbWprVBEgtBoOI+0yG6XFUADyT86NMEYYVXMc64cbeWaH4MXLOBT5q5M8jqemz6Gs8Jz09xmbAqQHYTzVawiay61EbG3tvyuSbi1rQjfQVOBw/CJ86I/Jkzl7GyJ5imqrQr8HMYIVp8yBJTW4SDPMGCfMvwNCVaVIPlhtEX1JHUgJ5+zpqhKIiKs6MiOCiXgcOSzU5Q4FWwJzTNcVq6uqWTjVFwlyHoo61tN+sEVP1feMFwm0tIOzPCtOZDtgrgqYZAg0GeeEXGXvYdvLQLxhD1oTmcOEkWOx6kufXZeSbywFvIRYXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa93fa3-35b7-49a8-8941-08d61c49f065
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:03.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit e95d7c6eb94c634852eaa5ff4caf3db05b5d2e86 ]

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
[hans.verkuil@cisco.com: use pr_err and fix typo: adater -> adapter]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm60=
00/tm6000-dvb.c
index c811fc6cf48a..3a4e545c6037 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -266,6 +266,11 @@ static int register_dvb(struct tm6000_core *dev)
=20
 	ret =3D dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T"=
,
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		pr_err("tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv =3D dev;
=20
 	if (dvb->frontend) {
--=20
2.17.1
