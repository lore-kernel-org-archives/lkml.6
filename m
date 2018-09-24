Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A55C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ECE20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZTAp6Hv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ECE20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbeIXU5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:57:05 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388764AbeIXUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmnXPVUbIJPIIZiObcZpLHSiWUhLzGu6E22RVCnKFu4=;
 b=ZTAp6Hv4vFB1L5R3aaZzFP4FGj0jCiZeooeKVLd8V8PGDOSwB9uuD0Wz69C7t62SLNaKG1S7gOK6Qhls2sE6o/Ax4GKfr/0I5qPYHXlIlUnS8BP8y+NzerWQvH++HgfVCNMZsvIG5tCtlhdGI4Cw/y3U/3mhUD+CgyKsVICOqpA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/18] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.4 03/18] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBXWH9CnBkQuP0aieHZdpbpScg==
Date:   Mon, 24 Sep 2018 14:49:46 +0000
Message-ID: <20180924144942.164688-3-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:1i97czu+/6F8B7RNndcR7tR6ErYIpuVIn7epniq2IL6iZXtpmsecJlhzmvMQG+Lz6YlWEOTM+EuYvQK3xzKgA81Af6OSjoRvnBxByscNln46ElobGv0fqKkBYbkMjwgzwQNM9nsQ7zlNk+fL2YEFosLzxW/YQ9LJsf5X2XbQhe/2uCVf1ly9iDPb+9JvHc4LI1EtBgDRvZr+M28sLbwXJgOqojT2BJ8j1dokHiZTyZ7RCIEIIHLcSlqrAF25oCzzWridZaNiAcIC8hnRIyTxNVgix8BHVWbxB2tYNDshIc7FpI+2pP7sqlDjt7+711wKZ/m8mGc+FUeRU1417BMiC6yE20zsJH2u5QBPgD/nnVMuvMmMIGw/mGaTbCO/WkviQzvv5DjXfz69VzbogVMBtKMhD75AkQntgux0GrccftdmZyxDNK8ClJyIkbrlrCm7Fr08eIaBWT3WyGkpEL77FA==;5:pm6RkYDtAq+sdUhXxOszS/i51slBtxL/NfETwtrri/d/ckyb9Dj0PO3ncs391QA9oYV90YAzWt/T1Mr8zxYSmPoHkMMYLkdYilJXArv9PJNWj0a6IGDcuycPJIdc+hIbQab/iczXJj1JPadIG8kTGyMmO3/DWzG8SJWTD7/Gda4=;7:DTVn8y8vMXbWDh0t280NIkq4mFP7d/XdlhWiIHDwq1OxY/96hjifsVqh8iXDApp6p23lSLUmbwR9SEV7pgM10yvLV0/uxgL8KzNLZFmb8hb8ny0FBVZRKjlMw/lHVHLTdmCORJRj/8zZ1By+XhHB+yzl0OYa7FenhQ4bFobyOMZJQgBAMSdT3xnoOOt5IwUO6Yuj52OPPQhjOfed+mfZQ8puDCN0T8fxk9PBeoqAf+vWJ8jgK4UR4JGShYMRfnH4
x-ms-office365-filtering-correlation-id: efc10dc8-e890-4a98-2078-08d6222d285f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821C8FBE28A317CB5386621FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(15760500003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GMUPX47UOH171ZyNOQ75/4+BtV3xVqyuvI39P+mafemy0hL4KNMSPou6UUOtUeEY5/8PTLUVgO2aThtkJzpp5T5NOjn9jh+pWPjZ815WftZufr++TzKyzv6sEHr/wNescIZTqAq9Qrxl7gkJSB2x8g91gFAYwUgR4ZKAN05mmK660K8X09d43F7R6pI2LWRA7qthfugg7Q2PYoz2ELkZdZu8uRBGw19Xx5d1DexBnABHyQ0UcNFH0JGyuARSqowCDgjtFldrkopnOaV633ymwBb2wxvDNlp0tjjnW3PBPeFUH52Kh4VzbKV/niAMgGQnPHYqs4UCCt+IOBI5BLBRCzciv/n3pldR4bcRdmoWIak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc10dc8-e890-4a98-2078-08d6222d285f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:46.8272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index e8b770a95f7a..c98cb962b454 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2453,9 +2453,6 @@ static int mac80211_hwsim_new_radio(struct genl_info =
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
