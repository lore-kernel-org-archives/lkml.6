Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122348-2-15325898644187149516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122347; b=tRjrgOGrNooxvRDxH/zsHjouCXhGyFB/H7QFQsch1JQFAkY
    tF4V+uPneOyamIT0XG3OzRH5fvamHEeJW21H6QlmbKKOrhbj6YJ8ZzXC035J/yj/
    Bhsq68T17ui5nMIGd72V31JR8HSz/udZYryWIvQEP+L8LfrHq+UwqwAKF80KtkFA
    jRSJqfoPlhKr1ilp6IMzjBzHkSEhw4Za/Em2F0BR5GlTNXBoAoZUK5PyMLdPPXBd
    Mmszxq9CMvWztCjlQwvP9jJcYnzDkahycVs290UTMljAdxIlh6uh9uc+l1+RVI2O
    X9jc52LfG7SCUBKnTtpQ0bo+Qe/qJ80X4ey7mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122347; bh=2cUa2S
    6OveRr7qtyuPGeOApTxBk7uBTn1EpU5TIp53Q=; b=LqN0pXEWIIWjgr6F5NpMmm
    mHm1kxRFEIMrR6qSiCy3xpvsYa6UlOLKLEZ4l6mgKbMIZyPHfJ3k2LlwIYEgFNVV
    Gze9m6Hkj+yJMN2tv3Qrn+bSp3mnLi3m5UTLd7YEStZ8ypTKch4t4FikCn/gxSy5
    on7M3/fkVHPp9FxIkOGvsufCiMEyPciSAYgk4boHeeMf2ny1bIJyAauKzcP97Dxg
    V7UBdFZWMTvirXeGBww9HcAiYCcvx+k+qXqBgdBYoBC4refGsenT1I8NZPfm9Gg6
    Vc1SiLgNkfNLSbexKvrXQqSJzo9h17ttBJY0SToCGVNjok3rzK44pDDcN6ZQklQg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HR9w+MrN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HR9w+MrN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCDAMW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:12:22 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933515AbeCCWav (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 74/84] mac80211: remove BUG() when interface
 type is invalid
Thread-Topic: [PATCH AUTOSEL for 4.14 74/84] mac80211: remove BUG() when
 interface type is invalid
Thread-Index: AQHTsz617ZSMGW8S1Ea992qP7+2e5Q==
Date: Sat, 3 Mar 2018 22:26:43 +0000
Message-ID: <20180303222518.26271-74-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:2zjE7tuM6M5XVtqScfrW87o06KaqP+4zQA6mIhfrM19TvJlq4sI3BZixET0meF7/JI4jhvSe9x4P49lA0cD60NH6HKP17h8I7klWLYYIwLQxdAQHgs/+c8MR+ajOWYU+ckH9Olp0/fZUO4Y96dFYBRcYPP6tzt7RQ2dl+5cOowGW/u3aFoo5lhcfPwV7a5crTuNi3dA2Xe1yFbQntzIBa6Xb9haQxpQndb8Xu9dFNo+7HSF+SiYwYu0tcoBFyeOT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ca3cab0-ddee-418c-62b1-08d5815669f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB111563878BC9868093797DA5FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +m9AUNpjF+J2cP4+lcaw1hS+SyozCrjEfAeXPir/qOCCB7tz/c5h3o0ta25X+P8lF0uyLCjz5a+cZr3SHFllzVml79IcBywKSrXZJPG9NfK3Fmp92uJRMQzHDbcM0DlM7xxHJ+9QmYewWuCs7SfYwbG+EnHCS1mEPfhsOICIBmM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3cab0-ddee-418c-62b1-08d5815669f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:43.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit c7976f5272486e4ff406014c4b43e2fa3b70b052 ]

In the ieee80211_setup_sdata() we check if the interface type is valid
and, if not, call BUG().  This should never happen, but if there is
something wrong with the code, it will not be caught until the bug
happens when an interface is being set up.  Calling BUG() is too
extreme for this and a WARN_ON() would be better used instead.  Change
that.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f75029abf728..e4912858b72c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1493,7 +1493,7 @@ static void ieee80211_setup_sdata(struct ieee80211_su=
b_if_data *sdata,
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
-		BUG();
+		WARN_ON(1);
 		break;
 	}
=20
--=20
2.14.1
