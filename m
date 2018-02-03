Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682910-2-18189557308843430341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682910; b=aZqop+6YCgMZYIBPlgn1qO2rRlr/VxdyPyvnIQ41hNWDerS
    6ojbxyw61Zd/CUD6M3M7NIy3zsl5tSeMZCWiGxeegLG+A36vNuu4Ga5RD+VAQDr2
    hd6CHFizbZgAcjfYw1rykfCjMdmc8DxyUkkdwUtT0Bxcrrv+D+1v3nmIhSJIeEEQ
    0NLr/ihVOCnIo2l0WsWqsbKQ8xq5CatDh9pvoUM/t3iyDrVyX6HYXWxdAVQb8+ud
    BhsVxvDuswUPHI1q8sXSRrNewU/aloRAbXkZUrbeR8VQ3cfGJR7dMwdoN2ZAFxf4
    Dnk6OSCG+fum4VbfntYS8bvobt0olkhmzx3Eg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682910; bh=ioBCHc
    xcjf1/4Fov29F8aY2pxx//9se78+nVbkGDx1M=; b=fyVs55es/px9GWvprJquWH
    9KnvgueJNAiDzitOVhmJqisBqP8vwp0eRkg3O9cVAil10rRyLO84MRdgqoevARhK
    3tPLQIYon2ICFtrkYdcu92SoO8ujmv1VbfS+jaLCwOqfNTEJ58pNMQOW3IFfI75+
    ou81e8iiXl+WgQutUb3+SUdnpwbf9WZbGj0Be3we2w1kKc/QNa+XaxZN9vSmudlA
    +JXFyjlJ5NIoTbejOjWgwYwlUdwnW64ju1Xi5l0GWSDHA4bOPmyMco+uAqOYJDvX
    OjbYyk/xnxb4eaPEIAG8ziK+/e0d2xrLJb4NzZs+wE9lPcGutmdg+6B1WkvGbyqw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UTMC/wbB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UTMC/wbB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeBCSfF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:05 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753009AbeBCSD5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 088/110] mac80211: mesh: drop frames
 appearing to be from us
Thread-Topic: [PATCH AUTOSEL for 4.14 088/110] mac80211: mesh: drop frames
 appearing to be from us
Thread-Index: AQHTnRkBaPXB47p/OUmD6Je0hjjZ/g==
Date: Sat, 3 Feb 2018 18:01:25 +0000
Message-ID: <20180203180015.29073-88-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:7Aq8muQK1+uFMKKUHfOupRfDCgpwBwTFINw32Dcrjr0WMwA4W6C0QGo1rectwDW8SUlB1OE4z3enz5Xpzay7IJYfelfqSLcrUTMl94ofGBYFxokR8ZPJPxvIh3qop18IAL0wMuHpppImeXHHP8xQRNm+W4QBETAumPnyHmhy5Cy1/pRJPhyf39NB1ljYN98g3QmOnKDLGQpWkRw4w5GOG99ZIkrAYCXcOcfbXKsfm7OJYDrry8jbGUhp9hNoeVNN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c0be462-c9c9-48eb-8fa4-08d56b3041de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104140956D075FFB2E0EC333FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(52314003)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dg4w304K3NJu7NVCPuOVFF0ExKooP39p6zTTGT23bzvWoW/bpZdJRlr+kVGdxhBoOv2l41F7fHgUV/v41L0byQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0be462-c9c9-48eb-8fa4-08d56b3041de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:25.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 70e9d2ca8bbe..4daafb07602f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3632,6 +3632,8 @@ static bool ieee80211_accept_frame(struct ieee80211_r=
x_data *rx)
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
--=20
2.11.0
