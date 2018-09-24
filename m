Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4572087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VAN586MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4572087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeIXU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:04 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:30644
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388527AbeIXUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAcWRqCOHo0znh0QPXrrC85xdB+xXAa17u4gc0+b2wc=;
 b=VAN586MT33iMS4Twfbj2+xnjtd/tg++O83tAHj4Z4hK8qEdUBguka6n7D6Cb5fQm5BitTBQ2pgdgnpYAoOQ9J90kxwcrJvHXtCMEtrV+Mis1bqVoFaZuZ5ke/c2VgO2LcvTbk/2UBxU0Fr6xVRCTiaiYOsLa2XsLcx3H8zJ+MsE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/23] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.9 04/23] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBXJSbm2R1rNJE2XYt3LgSh/Rg==
Date:   Mon, 24 Sep 2018 14:49:25 +0000
Message-ID: <20180924144919.164617-4-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:hj/PtPZMD0kE4Vieea166oYEAAJByeJuhs+qFVyPHWyvcthVIhLSyGXmN2MttXW7dR0qQOrHcqehug7gFQ67MRNQfx/e1ZAgiNVn+mUH6Nl29nJac/cvAXRYgxsLcLduWKxECVQPk3nCH65EhVmdWcos29zPH4juzGSlzkENv4BmPW8gMWubpTmR8Te2cvjxie4bM1kb5i4AkvBIlVrc862icQpPrOtrFG3ZToU6nrqs+hRilUNdPvY+iz9gPxRM5hNi2FX4VJ1d8PtD3aSd0GUhJMxS5KDR5ZH4g38pBGkUucbZ3adZHkvjSevJu2LPYLlJR+Q/fVmtJxip3FcMQ42NaWhwx1EO9RjDGdN053DdUfX5yGt4CYl3droXKovUqS8duxaiuxKMu4yntyfJskd0vUsia1N0IFOjpWVgP7CHvHJq/6rpimR7d40HhZI02EeuMIN2eZkWr7sLZtF57g==;5:/ONZflMWmJ9ybGWDXakjiwSTRmTmI7vtH4zVGuCdTVABPSRGG4Mwq07Xa2AbnMuPsD/C78IIm8ptRPWD2GibR/LyRc+/AIHucUzN87ulQ79MYI4bped/XBBXZQAhTSng6RVx2jPOuGbR58Gw5G4+ueEfXIBDoRDFnJYSVlno2Dk=;7:MS2T8cz7zFkPEm1WleW5e0dqpFN9FuSV6Ja+dQm264o2dmwgr5vn3fLTxmoGGXTfF8txkgDhbypForR8z+x41DHHCY7vsCZA+w1XKSAXy0l+kyeJEv1KNYfenLWbnqRfAoIjoUf1eWbcigiZ3aPL22Vf89Bt3A5t+R2cN0VN+q8l51ePjWJKVWl068nc8O19XEgFVI/ifN1RYcCM+i83MPDQPb1tYgyUoaRMuKEQsTxB9MvvhJRO8R62A9DPZiex
x-ms-office365-filtering-correlation-id: 14fdc8db-b3a7-4e11-7950-08d6222d0f8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181ABBDC154C26ADE3D546EFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(15760500003)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qd+MWOujOW+nnkH5mAVe6uuxKIhfENOMsY6It3yNCLoav6ZzZYw4Bq5u+ST48hXkSZdzjwJDkS0KGkq5ojwfu76C2y57k0J1ZYhsl4LppvsbLCp/Sgdl+ire0msjHVJU5ce/RvKAW1z/YIy9SlMn4zWottTgQfW/+FiXjrHiM042ctFr4Z2KEtFOygMTrClH+Y/RTLoPxTvM9HK6z+T9TVdv3WtpiE2Ev6Hsb0upSsqfe659INIpJQzObeYaL1jkySb1u72ODiy+ntdHYWXtvJUcbtg2JfXesDoKTx3QGCL29HawWmdVvCc7yi/QhSNt5zYXHpS264NSt/ZODmnB/WtdTE0UoowHxyPvyKByiVc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fdc8db-b3a7-4e11-7950-08d6222d0f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:26.0621
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
index 95e96419b4cf..4bb36dc73433 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2569,9 +2569,6 @@ static int mac80211_hwsim_new_radio(struct genl_info =
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
