Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123506-2-4085956898137098077
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
    t=1520123506; b=oMPUsvWJ2ifVNu4B6EjVzKP6sADwtx//oqkPZU0r9yjpbip
    AoZItatzjIdqXbWUvp7neiVC2Yl2oGf9cfvTwDEcvwQVB9LxUlOhiZSzn0yKkk7l
    h4pmYuBKMwzlaClvRcXTSZsyDqHFT9yhoBJ8QjATthnJELBbnDnwvhFAt3dGyT1Y
    iVV96OmerJRXT3+xyijALLXKlaqacj62wspeNMDHfuaXHW2DZtiIf13eR82zexlg
    7JRMEcLvr5SZsVSMBloL1nOhgUaJErxv7aMLK0mZfd+gDTXDxbuxasTlKn8LI4Pm
    5nEa6o7yCPajfqGI/fN6OVRPf5csBU6hZ0r3Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123506; bh=ul2BOR
    4ABIFZ/eBx9SQctDRFRhKFVx0nvlAPmpmU8v0=; b=pjXYI7lABDzxp6FIbCFuOn
    UXTiGuPu0I+76pxZxsSBllQ3uVW31QR1VSXtisLQirxbpy2Aaou4ViSTqETFVBQs
    YUkZ9I7dlpvebIQ2wqqi58p7W1IHn9ticAg1soJUQvGI/m7aIS07RrSXnUwf3mOr
    PuP2na8l/PGbD6rpfzmGVA8+QW3r5li6DC3hS2xwB8dwx7eJalq9lQIyxOiJrM4E
    VE10KN6ltUV4NwH4on9ZDW5mK+aGBnGYma/X84b2EeM843ZDowNlb6zzKy0dV8tU
    N5TCcPET6AK5SqtDozgUzEbYOiwm7GG/q8NwBUz0ToascdeokJkPZsJIN9LSgVhA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EZOMhN1g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EZOMhN1g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbeCCW1y (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:54 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932963AbeCCW1v (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 092/102] mac80211: remove BUG() when
 interface type is invalid
Thread-Topic: [PATCH AUTOSEL for 4.15 092/102] mac80211: remove BUG() when
 interface type is invalid
Thread-Index: AQHTsz55y/LwiqYrJ02Zy74XB8Kh/g==
Date: Sat, 3 Mar 2018 22:25:03 +0000
Message-ID: <20180303222318.26006-92-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:lvWShstIXz59Ss6rjH3HEP2cOD6Q3+ncqo7Rfy5SWWwCeu25SREYQj8OqXTCUUWOSFFvN6b3XjXLOkv/fxDzbBqD4wWiFS3Ft/02t1a8NKVIp49+jbjH470tOyKAvRmgc3ZiRVB94mQyEzPp4VhFbmrOM4fqlSs8TAgTHEaECEq8m+MHHwkOSdcOkSxx+iHiOwguXtDLQ0qbhD/ra6KjoHQzBPeAoHAHS1fDnhM23UC8cPNsM1e4UGw6bnXlY9X4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ce2e508-bb84-478b-f101-08d58155ff9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB060FBBCD6DA37B17DBF79CFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ONvS25DzLNRIgbRn+guWouKCJUFOmqzR7iP4VhVRBAxs5cVzxBTwhm5JQqnALTqwtw4aHQ66aIMh558Fhv/oRcbxoVV5pvMc7Bi+BUYafYhNDpSkIa0kMcSTqUfaNOhJubpDVHq53b4Ysdjxly8/KvNUsxW0qSGSdX48bTyFNSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce2e508-bb84-478b-f101-08d58155ff9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:03.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 13b16f90e1cf..0fa844293710 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1474,7 +1474,7 @@ static void ieee80211_setup_sdata(struct ieee80211_su=
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
