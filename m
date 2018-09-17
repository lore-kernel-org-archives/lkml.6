Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC402147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H+rayLmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC402147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeIQIz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:29 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:47904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729473AbeIQI1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFpFRKuhJ9FsxNm7rHdz3sdAtMXtxV2RbBC4z6maSdI=;
 b=H+rayLmgUm3lnZvKOPDgdfAPzXnn40z97T/i3nQ4JjCQLa0J1szgfk2s6A5TMz8y2LosyM9YaiCE5HUhc/GdgyLJQ4i4YwXuPbrD315s0Ig2Xu70wONVb6PKeJ11QZPJf27H9qbFy6zGPOugA+YBqaRsCG1h9ZueWgRmsZ4vNdk=
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
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 102/136] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Topic: [PATCH AUTOSEL 4.18 102/136] HID: hid-ntrig: add error handling
 for sysfs_create_group
Thread-Index: AQHUTjKzhRjNb8jkLkOHhhc03qsmow==
Date:   Mon, 17 Sep 2018 03:01:16 +0000
Message-ID: <20180917030006.245495-102-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:fFWB3ZedAtBYqP0HdPfwV+pD+UC4L51xlne09L5OlzeKFIO+C2qtqaE22do8+r2eCgSuFlWkG1F49ArjSY+x9TVP59AnSWFnbRKC39PJQOsyBJwEtC5sfT8N8GuESts0Qa8Fb93PPS2yCgX6QwSeYsY5GLFe+eIl7meAmGQKNn3oh0IUG6XWXqXDQTyIW+oI0R8h2RKtEO+uVhXa78Yu2c0uxNMHcqCVAfvLyz1SHc4r0fB4GMvnNfNJU5FZVODoOXnqgLZKtpuxkEGiL306Lu+Msxa3VHb2Gd2u1WsCIzTekNIlTb89BCXCN/53cCIp7uT8mKOUZbkX95f5ERS1wrGVgX/VAlQEC01sXp6H9/+THYAzfzgqzGS3E/YYdgrKxdCmoswoaAZerdj6tg04TahOLGXbtQVjBSyN7TDyOB3kgBzVH8K1Meg91FLmSQAR9xJqs49UwfZmi1WfkJaxow==;5:yVny76mZJBXgQpwaklNLhWm3SVM7nzcEApoQ5bHTPIdhZbEygaaTXXneQadwM1/F3+xMtjTG8JNGbKlbYqdxSqDj88DUn1aG50FcNIfAw29TNhPkqrbht35Z2jL9ixuS5O4xXH6tsbt1ISgS+Rr6l9K9JTz0QAFWLRll0AKn25Y=;7:gDM8mV1zu1sjYShGAfDMniC2czh0/YBS0lUTu8HhxS3JCyinjzfUkkHDa2RvBRP7AbWcJuqbOh7cU7FYMoVjX9e1n6wz8M8XUNljY1GHD65s43kDMS+JQz3OYXDtHkMROCqwAx2KDOtPrVn4mmrXMtq8pJfBxyFyLZ6V2JhrZVzGBSfZ36PQ3jCXyL5OeQsyws11ZpM9rQPmlOcHOAacVj0xSQ8iRb7CP4u90KbVjbnKvSNfHCi8K7o7NOM92ILI
x-ms-office365-filtering-correlation-id: d00ee043-dc3d-4c28-e13d-08d61c4a071e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB016804B44AE4D54F562FC479FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(39060400002)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: nMP3bAJMQ79iiVNkxjYyfdIexs5pRfFQcTrtKQdUf7LkAVWBYGPDQKYa/Hkr//1WK4dgXWFeBI2P3GlmwL7qy2NKv7RFVHZR55rX0H2f5rDQuJFn1O0aZnRETFed0+gJ/SHiEM5Qa0yPIupsq2SoUuIvzxqG5ko8VHVCyGVABOAxMmEWxe/I2K1DJFGhvV3Sn0EejieVypK7OXEnw69P7QS+D/oziyX6QGWI1lqxLLeyZSSKJrJEBlW1jTJn0FNIVibfNEeBcPmngdiUbo057BPCmyzmB6AB5KNHbyU8b24b9OXOblPZczx23I9aksiGhJAt8bkXGPoFyEY1bNFxS+LoJAQZU6BpSZJGSqeenCM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00ee043-dc3d-4c28-e13d-08d61c4a071e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:16.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 44d4d51de9a3534a2b63d69efda02a10e66541e4 ]

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ntrig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43b1c7234316..9bc6f4867cb3 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -955,6 +955,8 @@ static int ntrig_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
=20
 	ret =3D sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret)
+		hid_err(hdev, "cannot create sysfs group\n");
=20
 	return 0;
 err_free:
--=20
2.17.1
