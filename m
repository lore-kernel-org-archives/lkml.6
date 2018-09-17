Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311AD208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AiU46qyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311AD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeIQI15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:57 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:47904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729483AbeIQI14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BywqZ5QSg6CiGchPncd7VdxCgOiJ3bEGenEX1by9gQ=;
 b=AiU46qyADG4TzPr2Ani6Q+2XBLOsMiHpt11Wz4Vaol/o+OKmmjOxG5hI7kusurFW1To584l330gNVsL78gftflhHrz20UfZHF/SMUW1poxjYzHrjYB61eHw6qkJ5IhDVFmIXcVB/QemyjwjsEi7ba+bQDdN1kBJMyQTSuGmrLak=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 103/136] HID: i2c-hid: Use devm to allocate
 i2c_hid struct
Thread-Topic: [PATCH AUTOSEL 4.18 103/136] HID: i2c-hid: Use devm to allocate
 i2c_hid struct
Thread-Index: AQHUTjKzt5qiF4nk4kKYKvbnZPUdoA==
Date:   Mon, 17 Sep 2018 03:01:17 +0000
Message-ID: <20180917030006.245495-103-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:lMt0CD0NpEZkuajzAQ/EyVZ+7pz5xGiq2SBlesX/D7dkcmKk1f5TTmcb4Az/N4y7VZKUjmZeaLFsGOKF+8SLbnx+MwldEGXmNWwLcue+dqwpZAV8ckdzXT/GokbI9ykxf98OypSGOfnx0e7hUnSJd5YyvMCdK3oAn7NOCtAs4uah1Mzs2uOfxyHDSuh1sVWrTCXTFg6GTay88jRBbcgZVHqaWB5CBMgKnzWcHgW80YBTNwq3nrv4sH0KQazEJ6vRLMXkF3/xK0uZLj086Vza/890BpokjFRyGDuzwYCfch4LynSApxEmKtyRJ2tzuieG9YLrLXO9C0PAgEI+/bNEz0QHGiwTivbPMHs51BzAlx6p2A8uN8Xm+5uqLBCgvdEVJIpt5GURgrM1Cg3eKUpeU458XHqc0HicVmnM61cBKsIhStjWYoiU17jhzhjcT/7OphYdLNEzRf6wVY0iCyi1yw==;5:rLsg5NsPHoX76Fn+q3JVHjXwGBIpsX1Tv47aA3i8MRVt1G6ANz/NSbKR2sFHB2X68vQaWsChoAt6gSyY84PEdiPL725j9Fq7oNwLYEOaxKHyuVCzAOMOJzeQNaeuSlqFiqPlQFAIOU1kaWLA4K+CHCVbR+83ltdP7WdBBsvgMqo=;7:beDCi8u/Mtpu/X3v4V/b166ox5s71q43YzFKQ82ueHcYOreqKOO4DaZ40gne8suZ01b/Is7uTiFQFiQCXY0Prbfz2xaSN5ytHs0suSCBlIcHOTTb06e3ReGhkn4/Rlos7GWsFnWXRnWONgvNtc5XPvC1vdY8v7sAHwirsJ0o8q56XVpt9iQKBHOP9J9HL0EP0IHw+FRGyDRfez4vS4jduo83S2ZEYfJEXUp+t9Ru9IKc++y4BBXMfpicy+YgmIMa
x-ms-office365-filtering-correlation-id: 8ccaaac7-a0a7-44ac-a2dc-08d61c4a0761
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB01686A4B0DFFE9959A4CBD55FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Y1veynlfDm5SiW1ikcpJ+wh1BvBasR6T5nZzz+REpfsfNVaWru7JH4vB6I7P1vghUEKuYhEK5NrxwHDi2PGTOOm0vCMTU1HEDyZYj5kQJfwK6QAPW+A9pFuUMDcoRv7sWx5MOEtP78KqhAGTiU5QeivSbL68MemKZfsdQe6qU/kORsujAKbpBXemgh6mEYCvmN3qToul//1u/Vs4I1aBns0+MulLH+n/IY/NuVgJ+3naTPXNE+dBNvDesVw25emDu8FN//Z5xXf9axU0Fdmw0EausEz3FuPnpxawcQyPxfk2Wbkq+VNSzHcFIWCicfBRTcGg9uhx1nwtYfAlJ1oe5UmA2ESXj1nXluOVTfR1LxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccaaac7-a0a7-44ac-a2dc-08d61c4a0761
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:17.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit d6f83894110de247a81392ab7ef89e5498df7e80 ]

Use devm here to save some lines and prepare for bulk regulator usage in
this driver. Otherwise, when we devm bulk get regulators we'll free the
containing i2c_hid structure and try to put regulator pointers from
freed memory.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index eae0cb3ddec6..3d1506f1c590 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
 		return client->irq;
 	}
=20
-	ihid =3D kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
+	ihid =3D devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
=20
 	if (client->dev.of_node) {
 		ret =3D i2c_hid_of_probe(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else if (!platform_data) {
 		ret =3D i2c_hid_acpi_pdata(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else {
 		ihid->pdata =3D *platform_data;
 	}
@@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
=20
 err:
 	i2c_hid_free_buffers(ihid);
-	kfree(ihid);
 	return ret;
 }
=20
@@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
=20
 	regulator_disable(ihid->pdata.supply);
=20
-	kfree(ihid);
-
 	return 0;
 }
=20
--=20
2.17.1
