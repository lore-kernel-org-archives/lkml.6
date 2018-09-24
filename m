Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AC32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FYEWFHHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AC32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeIXUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:18 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com ([40.107.72.120]:39245
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729984AbeIXUvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xosYeObQ6mustw4vTKyHZvTTLg+48CfFMwXjH1S09Uc=;
 b=FYEWFHHKZ5nP7+AK6R0UuYX1M/YgQ/5/8Jd72XFSaF4KYEytFE4WCWeLKn3G2btNPweyKI9xhwNnkf5lrXLps0d8PbqPWvdIuSXH5UK1uiAFp2ogjZqlZWYypzG/lzBrtTGovCK42pWdINDevN5zcw8ECdgQ8636qF+OWnGYub4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/76] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.18 14/76] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBWbH79tdQ9v8keNg6WHTdsHuA==
Date:   Mon, 24 Sep 2018 14:48:08 +0000
Message-ID: <20180924144751.164410-14-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:t7SmsM3/ESVdMBzVntqBu6hrPANc5Ify5tzmrnI1gJIQ6apb0WhklCV0/Q6tH4RH7/Comy12DTkImS8ROo6UfTuhvBYXAwxuK7me8+g31/xy3XtA8DaJsmWBPGqpDlvvys6bo4OvpaZnZobGmTVzThpT8y6CDsF2B/cfHz9mJzdZBf9jR3mLoXWxkj9NuiK4cqs4Bsi0xVvFTM9TGkrU+y7V5RBl7oToBU5Kiahrg8FXhxVEjpIwA/sKajOwflcT6+xMTOtjafIg+JXof4S97JSAnRy+7Ebs51BOYU6kPi8ZB8MzhQ17bAA1wACiUhwClRnzTCYWBEmkjOcvA3BqqJ8qlJdUm0WpnjPvYinxKC0lrQvAjEXRrWG4zKeDaBgS4IzTgFtYehV5TBqMRSPnYB78yrRRl+A3P6/JMKHkpnZWkt5b+M8QeagkKkqfnkk/Wh1bTCHl37ZqOMl8r/0L/Q==;5:KZI5rRBRuq+8Y+aF6Aeq2vqkbUBUlQIf8Ct5ZQq2pSR5VBadjQdjV0MseNWk/TsfbdU8LAe1rgyjBCp2ZKoEHHF5FT8GocObqPFBQPLKqRCnKrDEh0kvn3EV4QUwhJ3l+Le7En1Ku97V4cih63P0o+v2wPUPkCRegms9tiLBdbA=;7:WXULiAqEtUhgZ8gWrAF4c6Pz1nTaQuvJzvjP+setwv7A6iXBzKFyhqw+uuOw5xJbJEzc59OHEsTr5aezy8RNL/6/On4taSGqcXKPeRW0eKvYKT9+jZJS/V9pWzYIx+Ugf7rMkIyHxeujRV8f2UHZBIbWOj2j0GAB2y22d8Ii7W4kD/9inmpgi/oBnNZPHid7PWQKH5c2y2eyzS31D+fynqel45QUtREHdfZP5TUMbrWrZpwZoSGYb9V9jkkFqQr4
x-ms-office365-filtering-correlation-id: aacedc1e-7466-4e51-c9f6-08d6222cbe43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB01345E84767B1B374A32002BFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001)(15760500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: L08ovtXLiWno4HHtujOAU91GXZeOX7EfwJQ8NT8u6QWzAlMtUJ1AGiDvu4w8UiXb/kTzoOyBo8TDY07ckXYBlXfcHiW6BzYAcvFOn2gC5jaBPcuuVF2WQtmKpZ+1h++V6wJ+L2ofGdNIRhg5+K10XpEJ3eqgBQ9g4dAd31tr+qrSrIJAdIkQr+bi+Zez9R4Hssjw70CTiV5ZWq/IojjHw9KZu9eGKEWb/26f0hE9jt3OIrz7WkxZkkcQzdCoDGwicnCQN5s+UZDXlT5OEmf8ScWp9q+fURLogf2LBkFKxnKD9YBOIv7qTPBzTh4g2/4+/v2dfK/xWeHlSSkiRBezwR16fmKeohwCIDMB9rUz4fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacedc1e-7466-4e51-c9f6-08d6222cbe43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:08.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit 67d1ba8a6dc83d90cd58b89fa6cbf9ae35a0cf7f ]

The mod mask for VHT capabilities intends to say that you can override
the number of STBC receive streams, and it does, but only by accident.
The IEEE80211_VHT_CAP_RXSTBC_X aren't bits to be set, but values (albeit
left-shifted).  ORing the bits together gets the right answer, but we
should use the _MASK macro here instead.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0358f20b675f..27cd64acaf00 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -470,10 +470,7 @@ static const struct ieee80211_vht_cap mac80211_vht_cap=
a_mod_mask =3D {
 		cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC |
 			    IEEE80211_VHT_CAP_SHORT_GI_80 |
 			    IEEE80211_VHT_CAP_SHORT_GI_160 |
-			    IEEE80211_VHT_CAP_RXSTBC_1 |
-			    IEEE80211_VHT_CAP_RXSTBC_2 |
-			    IEEE80211_VHT_CAP_RXSTBC_3 |
-			    IEEE80211_VHT_CAP_RXSTBC_4 |
+			    IEEE80211_VHT_CAP_RXSTBC_MASK |
 			    IEEE80211_VHT_CAP_TXSTBC |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
--=20
2.17.1
