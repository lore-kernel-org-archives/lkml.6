Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B2E214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ta0zvcws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbeIXUwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:16 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730027AbeIXUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2oJpA4CC2L77bAkS9QCiJRgd3kmcXei2JRJ/i0rr+8=;
 b=Ta0zvcwsESRvs88/yfYno6CZZx17+WE5tIprLRfcqqivJLXoV3xrXhgXLoEi1NYWhCkGO6IkCX+muLxj3xSCbG/D6gedmB+lLS0Ief6ix+S4NX+dZefuaxgwGgcbsNCDODBJ7H+uf/eMVX6MpuK3FettWhuQka0Z8T6ue+tw3x0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/36] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.14 07/36] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBW4330Uqd6LgUWOTHJgPa3ipA==
Date:   Mon, 24 Sep 2018 14:48:57 +0000
Message-ID: <20180924144851.164533-7-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Wuxs2beK0ppz6+a4W0PsbcbZdMGoNYemzLsHS8pu7yq9O0EZHzP2atc5dcICZil4e5qLAedPBaGUtOhCQqUJWBLWGjIQPSD7E8IfmGV6/Z9MztYVk1RsUUlhVI2ezyl2N6GzDAiP9swRbRXT3aSy0jQ3KBg2vBO7EExZYJpsd6vPAufO7oo5PZbstWfxwK8fjfyalkx4JzmhE62zgmNRPQ0uLS6GVo3FKjLiwcYykEyvqOALDdV1aYqgc68YeA5rHgl+a7OBd0hWPkqp9dxGmvTnZFWWwMBV9CkvzPmgBHj8t9dzrsH4qMZYc4i7UcCua73E9UR8yJMJLc6fXmqFV2v1SC5hZzjq3v9ih9iR14BE6P2n9bSNYE+AG9B2WzZeA2nzJ2wnEVnAnxmGAeHYGB/A2JKKNge7EMjwwVKQPeex63JnbrA8v6S15LFn3bivfLH8EBdKJid6tpQTFURTgw==;5:zu4RAYsWA8iFJnqLE2L2dB1bIh9tUD/PQjy69WuF/UGrAfKMLrGT810svwLmNQJqYO5jnS+wIqtdReBr69Eg71WOLp2vfuGp0SFun3TOslJ68SKt58Gu0hnbxWtt05/Wa01xGU/uOYgXiKHhhz44qQ11Tzlcrx89Yj0hG63VZAk=;7:HF/4MkshMzs2iP3g5lljGKrdwxLXeHNEAEQsezw0eAMLP716ri3xWeT6zxytLIzyBH/dqRZh7TRFC2yM8h7/u5aVwuaXmGppmfsgNGwh458aib1uUISogd2z+wqvnfNgb7A+SMi7t+10pxINB2sT4rQuviJ+rObhXq7cmYRCB9PEdjImvYgivLEw6Y18u0L7R8Gqpgc8tOmN+HDokn35Yxf+nSXSns55bfltI9mJS8gPctkWdbTTxq9twWsAWB2+
x-ms-office365-filtering-correlation-id: 48dcab8b-fe2d-43fd-dc9d-08d6222cf5b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181F5FC8B547423EBEBA4A6FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(15760500003)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mfZgt/vowx1hs4c5EbVFdwCUccFF+CfzeKvzKUbwYhOAa+cFeZ83hdeVMLhQUC0JXmD03y1mhAYZ/AnaEXO3rCmELEeug7s9nUhh8EeHT4b8RA7rtWsKHPU2qj/vKY70yEFj2eEA1Szb4JwxlmqxYS8p248CoHV1R2Gl0bdcqbp6yyH+vmQhmdyxZFTP47KxMmvyslSlS0pIxKLb2CFcrfu84S7Ep6q+V6EhwhvBgidr/zopECeFtXqfh03OuR1JGQw8o681aw9KQuUXF8Fmswj65r8ky/nL5nT0vvwrMqS8RAyGDMK0dYSiJiNo38I/dm/SYAiyq9FxcDb/MkfHHbni0Ys9pAzSux7c5eF67Jc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dcab8b-fe2d-43fd-dc9d-08d6222cf5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:57.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit d7c863a2f65e48f442379f4ee1846d52e0c5d24d ]

The mac80211_hwsim driver intends to say that it supports up to four
STBC receive streams, but instead it ends up saying something undefined.
The IEEE80211_VHT_CAP_RXSTBC_X macros aren't independent bits that can
be ORed together, but values.  In this case, _4 is the appropriate one
to use.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 62fcf57e2299..aafa7aa18fbd 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2632,9 +2632,6 @@ static int mac80211_hwsim_new_radio(struct genl_info =
*info,
 				IEEE80211_VHT_CAP_SHORT_GI_80 |
 				IEEE80211_VHT_CAP_SHORT_GI_160 |
 				IEEE80211_VHT_CAP_TXSTBC |
-				IEEE80211_VHT_CAP_RXSTBC_1 |
-				IEEE80211_VHT_CAP_RXSTBC_2 |
-				IEEE80211_VHT_CAP_RXSTBC_3 |
 				IEEE80211_VHT_CAP_RXSTBC_4 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 			sband->vht_cap.vht_mcs.rx_mcs_map =3D
--=20
2.17.1
