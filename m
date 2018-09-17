Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FC4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813FA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UKlNbZnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813FA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeIQIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:46 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731094AbeIQIdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANYIGg/d7Lvg2w8WPRreYijHaoh/6MONdtpopvFOY64=;
 b=UKlNbZnH78BD6Q4rvQI+2seNEkr2Jn1kQiJF5xlJyPQxSpnDnmdoT+jioe6N9vB+TsmK8XEC1TSYErM49uOM8y/rj/ogBLfHUGNKLe1Sy+vjJf9SxFUotMOZ3ktCzdd9pq0saqN+c9vnO5XZrGHoZRqhkYCt9fB08AREiXR8Pgc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 24/29] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Topic: [PATCH AUTOSEL 3.18 24/29] HID: hid-ntrig: add error handling
 for sysfs_create_group
Thread-Index: AQHUTjNXwOIucLqsyE+u9zKFmSdoLg==
Date:   Mon, 17 Sep 2018 03:05:52 +0000
Message-ID: <20180917030533.592-24-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:X6Yzu8AlAddJNiOXpbGOt1+xRh5A97qallXLuHprBu5zZa5Ghe5L+wnR+06mz8SP6p14rl30wykuijejIIv0vkRfDJRHWMBbgE6Hwnc2nz+zRm1yF/xrVEUv7khLKfGQXa3CHUm1Orcx9WhXDWB6K3xB7r09xJqoi1Ut0OfL5AQDUoCVxoql8gyWxaEsaLZlOBZOfOjNzLsntwqyIQpTPQX8tjrC+Ea/7xHczT+fxc+Jx04XxGolNmpji1YBw12ETAvh8Ac34fKXTGkX3GXgAfjII6jhqbk6vKDh7muUGN3SEEFOJIZd/2rDmQSnMFfTvNH9+rTKbpPsQWP4XBWNYteZSQVvu4X7pwOsfTzNDPLl8yqVNAOUtrP8WfPx/v7VLOM1LD6A4WjGu+olTEsUpvDgVPh/6Xx5TXNlUNrleUu4TT/2yS4sEkBJMDLZKdiXDURt740bgx4xCR09poolLQ==;5:0siPdp9rKUDaAFKl/pxc4zzh8UCKNTmkoRXk9h7Q81O1B6kw1JmJ/V130Jt3SQ2JwNIznJn5Cmvdhh7eIXz2pjMBpnHhxHXkwsFRnK2e31dK6ungHwkYGpq/kwi67lMZZ0RLiE8SlSu32Ks6YjW7r7uce4pEJ7UUgpbRER6+vCY=;7:kAGUJjDSlJ/R4xYjWvaHAf9L2BBkR69mi4lUYLIrHp3eiu2mhj2VkKc/mtVAcA6qQv9awd1HtXhdaPjlHHILTKISD9Qx1kjU7xD7C5CqvQs1Tzwb6qFYGn4vRRP/7223hE/FSXp+bCkD1UD/385HC0ZUP+Ilz11PSvOXUijnNDxIUvdQTY47i41bmj9IYaE0mNffX22BQu8E/HmcecUgXAfIV+2wso+1FyTaEK5PfDYfC8SWpZ2irnCWc2nRhGuI
x-ms-office365-filtering-correlation-id: 6ffc1290-ced0-4524-2226-08d61c4ad693
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821593802F1814FC290318FFB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(256004)(2616005)(66066001)(6666003)(2900100001)(39060400002)(4326008)(107886003)(86612001)(5660300001)(3846002)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pXd+rQ9NE21s3dqOiW+F0RVYUD+hl+XS91T1oMSQklnxuLlGTaoG8qRp5WnQ54lvvE5/yFXsl9xAqQkwOB40Jcn1bOCDTg9HHNIL2yMhFTJ7Zjgj3rNBcdYvbmOOEoGRM1TUwNS2KB5UYg6Js4bDoOXqKxEdbPj/55vV8WlG04FvI2pghBuZ+cEwFtsy4r9P4B9DbgXQv0jy1n+SvMyCAaTJ+NePthPeOp0MFKmrkelsnnAk86B9V8sduEhNu2BbPKY72v4ys5UrEFyAfF8IBKWiWIaKCVlp3Z/b/MSFpjWUHS1lAEE2mEM1rTrf9YC5EFlBHzpsWOnvqdRnkYEPidVcsVswvTbdcD9Cysm9VUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffc1290-ced0-4524-2226-08d61c4ad693
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:52.2014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 600f2075512f..dc497b633e28 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -953,6 +953,8 @@ static int ntrig_probe(struct hid_device *hdev, const s=
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
