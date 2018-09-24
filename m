Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84026ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CIMPiUhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1F92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeIXUuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:39 -0400
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:61980
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729969AbeIXUud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sts/xQKehL3t+dLSE6K74T+9IL1RwLvIOgNumHc/uHg=;
 b=CIMPiUhG0gwVH0QAe9n6ZIMuapjUzACBWbabpJBKhoc21mkaTeJRalJQE23UkaP1k7DqnyORefyOuaB/37cvgFbKo1HL/Nch8AVH7NoSheH60E+odjPxqLuuXWvS2w2kQPQhssDNhsuR2wtDH51Y5cvTSqEwT2fu757/r7GDle0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/76] mac80211_hwsim: require at least one
 channel
Thread-Topic: [PATCH AUTOSEL 4.18 02/76] mac80211_hwsim: require at least one
 channel
Thread-Index: AQHUVBWXDF+sxESiSEGxcJrbId2Khw==
Date:   Mon, 24 Sep 2018 14:48:01 +0000
Message-ID: <20180924144751.164410-2-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:vPwTkbI3CX5d4EqKD5Gk99Kf6Tigh6trzacPv4Uo+q+xj0atL8Xs6fdSRr9AuuqnimWMHRKxvML3nnZaH5rBxgmByNO7qnitF+84qOWtxCGeP/No9RDlVE0msVLsyCEV+sHdRZCQgfbvyqIn/E+zUAwyWIFydA2e3mzzLT6ZtttflasPnSi/g6iHoKMKGxUX5nlk13Mbzgp/S/R1zb4qyZ1Vr/m72DkIiFw3mjX4bvx2i4vnomtlbGKx1pLt0bMvUx8whkztx20Fq3krQb7po1fRU73UZRJjvz/RrZchsc4+XJb90yqL/kX2j33Ybii5plADhmcXLyyURmAuO3H2KErSEsNVtmqbUn6smGQrsxyw2zfYXRJ61bDpgUMuY5YZb1403/dzoyMujKqaVb5C1vtETpQZ4KKfZnSPBj4TgUbNklAvRcVG8EPTBA5WQggkRgas5pRRN6s+FhgxmM4/IQ==;5:MuukLbtyJI72j9wdMWYmsiuPgDVEKXnajDeFo0ABCGUeiV5J4b0q7b53B8JVdHcnQ027RHSFy0Tj8+P2BVq1x6/sDFOqi16hbf4TEl9CtU9LpbpQLFcn0jwIh2uSlF/XcjdXUXUL4yWRgzamZUUpGAogfzf9w+LwsKuU1KgqzD0=;7:ZHpiJiGxAKoLYZbo1qcBcORr8DNS8W7Wo+co8jaUOCKcaouhhK3+dda69rcNAFH1akP9btXCo+f059gt53dAtx3rdQ29yl5p55oO9rZkGB4jXahqMeuRFS7QGHK6/NxdbuRtJfQN5KdhJURo3o9PQUHX7v4O8nXp4Jadfo5VSdrICwU4wPXvb8+fuWl10uMglTzStFx2RDzEAMaSa2FBB49DDIi0vyS/H3viu4B6G4qww8FOo5HDP6G2U7hFLmxV
x-ms-office365-filtering-correlation-id: 5188e514-df2d-4a27-af0f-08d6222cb9f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08214EEDB9C5E336A751FF71FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(575784001)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ngGBp8xRuMnt5TxR180/dDxrvT3TviDaXupBppjbyz2W+XxMhecPWbGk2Mj8cZSpiHViMma9HgBHDp5SjL2bypbU/gE4d309eZd2saBXNWCnGpwL7ezaKvDu9G4x4TGL2cgif+WDAS4fnZv06XZhjdzu4rJ3hBpg9nHT6Lq22Fb9kt2rLEZc4myOHv3TDaM4/F7HH3kyU5dtt6ZbQwiPwTSGk2keQc0WJPlxnsYvEUDgPfTm/q99Za5XAk5FJRuRkF1AmM57n/eXL58KY0Edji5p9yA422kIoxbzRhrhkZ9/7Ik8kdBBR0HzXVSS9jLd0tb7cD+aDGyZvOozHOmGvEgqVnPl4877J4gPmQRHP4o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188e514-df2d-4a27-af0f-08d6222cb9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:01.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 484004339d4514fde425f6e8a9f6a6cc979bb0c3 ]

Syzbot continues to try to create mac80211_hwsim radios, and
manages to pass parameters that are later checked with WARN_ON
in cfg80211 - catch another one in hwsim directly.

Reported-by: syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 18e819d964f1..fe1b0108f06d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3194,6 +3194,11 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
truct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		param.channels =3D nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
=20
+	if (param.channels < 1) {
+		GENL_SET_ERR_MSG(info, "must have at least one channel");
+		return -EINVAL;
+	}
+
 	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
 		GENL_SET_ERR_MSG(info, "too many channels specified");
 		return -EINVAL;
--=20
2.17.1
