Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D45ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1075B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jewnubJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1075B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbeIQIhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:00 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbeIQIcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyfAc19tMu/7EWYdgtY5Oe+IbgDZcuuOMzY118/U8uk=;
 b=jewnubJMvWL234Bgk4h2OYLoeY/KQyXdrSMbdcBlscMkR16UP0f7dtkZQJOgPQU4DGa10HmB+9YVID9TLQrRXcDXAkDFSkc4LpiNTwWFqbqzwDAB+koYDP/8xjVxAjqVGOL/ZonPpoMistg2rH+tgFuXOE2/lVu9b20oJ1Mdy70=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 36/43] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Topic: [PATCH AUTOSEL 4.4 36/43] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Index: AQHUTjM/zC8Kbf33Q0GjLAXD/P6eMA==
Date:   Mon, 17 Sep 2018 03:05:11 +0000
Message-ID: <20180917030445.484-36-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:jX/WinfYbdqhnMFwPo4ucFliiOk+40RyP5j90VHrkiy+K7PLWvlgu2yx06wSuo2ZJWkp8OoBea5Z61ehOM/Poivqf4CbHJCcZzIhgHOzlHsp4Mr/LjM+7/Eg3jJRP7A0tGsYSlu+IY2eykDnXA46Q3/twuRfA0Z/yzpxHgxJeqQXRD3TNeimotdypasJH1AEH8H2Q2DRpWcKcUhJCtpP5C5iSaTdz365a7oFFlhq9KviLSSVquhWmMhtjGR8gyeRzJQ0OCBo6gdMhMoo9XD0FlOg86MZ+8ChiifvvL+Uo543QyouVdaAFVxQfPrJTeOUzsAR0xsS3eocRl7mTc4DMvKG9qCnJr6wWqxG0kh7Hx0Qm/kjJOhP1A9XIGSCKMTJpwWmyomsNjdWPlKc26DhwvQJ4E0IUtxENZrLJrtX3hhb37DQKdpAmowTgkP+oq15KH/C1Pb0Z9nNyJss26iwfw==;5:qjLuN1iKGfQcwHXxkuMFwDOZde4DPtzgWfx6zMqYRtLrkZ3HICQRgWcq439s+IKSv7/suGWTe512vF/K/gKs1WEh1rO9wEIQYq+BSrxL44cdS+X+7t57zf6rXkwRUsHteizWYdUpsFols9LlhyPlfZWrlQcYl3R4+cO+sFKUzLM=;7:Wygm/DmQ4N381dk3ucpzAlxDV0IjVIfwu02Yo8VLAHopb4zTicjj/wp8toQLVUm7OIExF+odrVaRuuxT5axyO+kooBD0xgCUXZ7WLmDR2mQ5AxUS71aWVqxK2RxAjQsAE5jtNIpteo4lYU59X3Dh6cbOzrU49JF9YwCg5aItqh4X4i7Qltod4B3sKFvNnsutgm116vDpOrIThoMitrpS37UtSW8mN7PVpDiL94TOAzqhWpD2n2Z1a3uXlgEHTKmq
x-ms-office365-filtering-correlation-id: deb417d9-9bcf-463c-b56d-08d61c4aab82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759D92EE259A590304660ABFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3fWx0c6nsaG6PsQr0LCxHQAUzAbQYZoXyUhk+rUrpAiLVLaoAGpWkVuxyG3YUxywRuwCqWRmoS8LmJjUHhXaQG4W6kVagxH9oPiUy2LZN4oP0GYhH36Famig3aH9XPwdO/yS3dQyUNEQx3gXNkpywjll1qCvy3DF0ih2CwCkvNVwMIvZtSknFmMRbxueNgKO51AO+2KU8ONl4Oe1gWlU0blfzJMxP352F7556GaIO77w+0NKFpoMBCkIaSxFeD8clehSzGvxY592w1D00VG/XPgK6Vxzhkb23CPgFpY58qMA+uZ6+YEm8eKlLFfEntBUK13o+Rpij8IkhEM3a6Ei7r2fokWvg1PhLk49veTQ7ks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb417d9-9bcf-463c-b56d-08d61c4aab82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:11.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 756d1ef9bd99..6124fd6e04d1 100644
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
