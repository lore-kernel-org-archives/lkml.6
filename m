Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07860ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C252098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I/318Qqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C252098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbeIXUul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:41 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeIXUuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clj5+zDI4VKmKJlSsGQXzhvEx7wn5zRZqJziCcSG6QI=;
 b=I/318Qqc+r4+5Vom6uxvJkRHa4xuaXxN5NksoaAqnopKWbo0tDZb8s3RtLeMAPy/y/wcUVtIPQuYjZu2pwXw83XwcZYzoIRkr2DR1slLnhjYeuvCKikw4yEUcdgUUPKcwzb2I8Y5DHzzHH+xP7g9VTk9C1LRzk6OgS45tfUMjWE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/76] cfg80211: remove division by size of
 sizeof(struct ieee80211_wmm_rule)
Thread-Topic: [PATCH AUTOSEL 4.18 05/76] cfg80211: remove division by size of
 sizeof(struct ieee80211_wmm_rule)
Thread-Index: AQHUVBWYQNHQaE5RI0++6KfvcAkOCA==
Date:   Mon, 24 Sep 2018 14:48:03 +0000
Message-ID: <20180924144751.164410-5-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:AVjSoFy4mR0JQaWnA/6U8pxuj3incS6rBo9Ft2XYmOPf4aRdi4m+Qv8iO4uyfXUvLZSR/dzbncfuAvzxKkjuf4CXF0cPGHc+JoLatfhGgLH8bHGw+3mdmiJZTkTSkra856pf+oTYThAPJmKXqg5iWHQWmt10qdMK54tGSoxSWWL4AbzQy03rXxa/BDfnszq+1COqQhjQ3F5Reokyjs2QXQ6IO2/kBgkZMHTkgtdNK3graiBqPLaw2OlPIJ4L9QHmMIX6pFv78FmWK1z1fb0GVB9YbzXwOghEZOQof2Z0fX8yVg664NfyNqMi5oP7LoYRyHl4qEi5mj9q8zz6UxcBX8mrPVQzCOekM7enDrqikz4X5SV5BOcmuzcoRIUrk5JE5QMhUjIZQy5EvszD+7F0ItzhbA8R7zhJNU60XACTDwbwpN1HthEMMKI626biZwf9ZXPDZyczbFHNOnqx9BR8CA==;5:Jr8/TgMjXz47JRSrHPs4Af/2eADkk4No2HYZTNDURdc9hXsh2NCTG93lzmbtaDT3WFmKGOEdFwMRXgxytUd6TKPtv/9KlhfsTmdE6C98+mgseeZFJn9Vxc0YuI1QFESdeF2ftDG4N6BxSmosgSegEdx1vfZhZuctSUd+yv9/o28=;7:Sf8TkmYPn6BQNq77RNSL/cEVTHnmDhGErEDP/1bjItDz7enzrndSL8EktWP8POYLT+SohDlL8oW4Lt13acZCy01bC6/Gbwtp19dQ9ZKdTz/j111dPWHGzbqN97b0w0uqobc2GtYasu8FGTsUMGCN6LEcqsgfvlPjfIMyZgrPrCeX/dLffS28tGtbPQw+EbZCgut5K02eMzicwWzy2zhe479DKfyP2x5+OMcH05oJqcvugip+3xfgJcK2BTqhAyqt
x-ms-office365-filtering-correlation-id: 6b0dcde8-d739-4bfa-0bf3-08d6222cbb17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134EA9E0A2B7A05FD0F2E00FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001)(15760500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 76q2gHVn3lbe6fdjVxpNSIdAx72nnr0WxjBZDdpD/Go7CjFJDkwZCCqgwaaCO8J3BMD2sgF+t/fqJ4Ga53GPlsX5oh/l7YH6E2YFdaC5hDbzR+TxdeEywxNWte146LflkppJ0CJcnF2TyFY+TtMuXwx6o9DIhD0QBEVeyutAdusk1ufZsB6xL/uUK8L5vBLRGpGrF8aPi/3fGV/88zIpB+QgqJxZyNeHGL9gpvdHB2r1paOgqh0c9kD+vTbBAPzrI9sjbjYYBQjToGPo5CFzGkhX8bHcNiO+Ek+HFy854eOnaTOZmj/tcQBGlec40pjvkGqjGyN/cNgb58MDH5ERSH1a4l4XbGwOyA//wkpY7sk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0dcde8-d739-4bfa-0bf3-08d6222cbb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:03.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8a54d8fc160e67ad485d95a0322ce1221f80770a ]

Pointer arithmetic already adjusts by the size of the struct,
so the sizeof() calculation is wrong. This is basically the
same as Colin King's patch for similar code in the iwlwifi
driver.

Fixes: 230ebaa189af ("cfg80211: read wmm rules from regulatory database")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/reg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4fc66a117b7d..283902974fbf 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -452,8 +452,7 @@ reg_copy_regd(const struct ieee80211_regdomain *src_reg=
d)
 			continue;
=20
 		regd->reg_rules[i].wmm_rule =3D d_wmm +
-			(src_regd->reg_rules[i].wmm_rule - s_wmm) /
-			sizeof(struct ieee80211_wmm_rule);
+			(src_regd->reg_rules[i].wmm_rule - s_wmm);
 	}
 	return regd;
 }
--=20
2.17.1
