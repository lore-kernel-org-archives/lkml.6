Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A952C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16620861
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W7ozWQqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeIBRWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:14 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com ([40.107.68.126]:15261
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728528AbeIBRWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5InUnjwskybWjPpWjx8o76wedm/StdPlOQ7oNCbGRdo=;
 b=W7ozWQqY9n9OgnglttlMTWNltZNMYWdvu9tU8Tb7MUpI0T8XlLfjVbkVf5Kna6Jf1gclix8++Bq1dIGx+HZfBpGADwF66LZrqPwH5GuQdyTD2wUKi0RCOTzaZ20AnkUnuXrosK65lyi+4khh5Zf6Do2rJcd2uGVt1rN/crnDWDw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 091/131] thermal_hwmon: Sanitize attribute name
 passed to hwmon
Thread-Topic: [PATCH AUTOSEL 4.18 091/131] thermal_hwmon: Sanitize attribute
 name passed to hwmon
Thread-Index: AQHUQr2N1Ia2fvtRAkuiAHbaNWpyQg==
Date:   Sun, 2 Sep 2018 13:04:59 +0000
Message-ID: <20180902064601.183036-91-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:jaDWz/n406AyTkr0OpJQOt2eaoFk3rss8dOgU6xSwpik7U8hYi+DHPi0tUdKjBTTtJSgthPHAho9VKLRapibj+knh5wyb8ea24Am6/C6Zo7gstjmiTgPpaFs/pQ7iP8N1zeCDz6Ttr+SekHfSyScL6F2cXXJMfIiRAW1h8eGzQmnZbxWqEZibvMv9BOCa9Hm0/d5Ky0AEyAYUljBC+M0LxqQQZZraoD5O8R5tU3yxg15IQVvyoQDAo+hxxhHfuDR4jq4XLXp8Rrei9nGAPaYyWjpue7PA5XwEzHeuSrqfmkQaeaSkUSFiV8OLNubujb4zgJpycFlHOsGuyVoyxGgFwoHWExOLpkInDZxqJ/fRWS1Xu8qR2m4jfhWuLtu432bgPXYbFrPi8cn0VvNWocRjuVDuceIhSnthCuGpWw+5Lnh8dofUueQI56GmIAPBQtiSKFcdarRTwTDJenjmXbLXA==;5:HPsA64wirosvwS1qZhTgbkDhyAk5acoqbYi0njVN88wIlkHmONAlQ7hkLqgA4Zl3BeVqwGKN1YG9UzkqZrVIlG8OGoj4KCtPj42ysFAOpY4KM/3UN3s7KZ503k6Ab26kp4kT+pTPYofDivatzZF0d9Wf9/Y/OnDS0AsJG+5aKGA=;7:pH8ylZJSKGPLZA5MG9/9n6gnqKK80/eONp1tgts0BnOrwcXTnDWhsIQm6sHw/YHJaJwQ3ph52gjxcxqDL/THiJjsBGaUhROrsdqButQPiKXr7wDK6FyMCvSN2cl4CIjoIsoleLGBfmEeGvTDsa4U9HwUIfIR35pPZRrf31vmtJ9SUtasVKmyosfuIflFEm1WxOxg2mQPPGOCW27hvFzjfZPMnbh2tDpzpIQNUe8sn/9jUNNdkPA4m5wMTqYmMXo6
x-ms-office365-filtering-correlation-id: 2793a39a-a801-4959-40a4-08d610d4c330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074121680CC5974E5691EC8AFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nhPzPQ1JpLar58j0XHTh09XDfXj7+ZPSBlINOEbyYJ0CIB+4Pgah1xC/6qtaEK4q6wbCFfssPKagHOoP+K+Bm7y5X7Yz/T8oEDCUI+8hjF7G4bWxe0hG5YIcM+8TkihlrObsvCVH0oPP4mdmsmBZa1TUcJWxwMSGi2n8YGkd9AaCh6DhY/LagU/Lsq6kxu8pJLkKebuwNX2ctRzDnP8ysiQyl81bxsLbkNgv4FcKzxf8lner3tNjdVlhoBgRgbfFHENm1khgHliU4xRdg3l+uEsGHoqg7LcXEE+B1Y4NdfvBfbOHkw03l596Onlmh6sWqj66+SyeX7e2sbQP3MF7i9rup7+dRlZ5QQ9xx0j25zA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2793a39a-a801-4959-40a4-08d610d4c330
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:59.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 409ef0bacacf72c51cc876349ae3fdf7cf726d47 ]

My Chromebook Plus (kevin) is spitting the following at boot time:

(NULL device *): hwmon: 'sbs-9-000b' is not a valid name attribute, please =
fix

Clearly, __hwmon_device_register is unhappy about the property name.
Some investigation reveals that thermal_add_hwmon_sysfs doesn't
sanitize the name of the attribute.

In order to keep it quiet, let's replace '-' with '_' in hwmon->type
This is consistent with what iio-hwmon does since b92fe9e3379c8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmo=
n.c
index 11278836ed12..0bd47007c57f 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -142,6 +142,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device =
*tz)
=20
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
+	strreplace(hwmon->type, '-', '_');
 	hwmon->device =3D hwmon_device_register_with_info(NULL, hwmon->type,
 							hwmon, NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
--=20
2.17.1
