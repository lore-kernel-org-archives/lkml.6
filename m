Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520117934-2-3466369988344639654
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
    t=1520117934; b=nPQlCvkJ5qRb5zRpxDyMccvlzAirst5hwlNVrv15CkFrqQ/
    ROq1OaI/Q5JTB+ZlTyU26pdYODlJ2y4uLckEM/E+l2/c45HJwCX5cxjH7pEO+vJt
    KgFMmQdkRmLlFFu9A3TO+Rp0XsNzZG+Y5TYHZo20JCjQvxO5339XCimFO1lwCGoX
    jc4EJjiqaU5NrYjz7YWMAIOemOSycPx/Vu8N9qmxu4TEYN9Orct324zMcMgS0FCL
    YJCMTlDkzJmdqvptZCVG1j7CiPe7pDrGetHIuqVuEUSqpMGacj406/fzGbl0nsoU
    b8RZSJ5ABXy4cvVoKSbpxA+qi/LLrkV5is+s20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117934; bh=mcyYAy
    4N1GtpJxopqIQA4MATaNzyrcsGWHUV7FNDBzU=; b=dzV8TJSX+mtzzns9WoVSLx
    8TSZmHl6Ih42MVvkL/N2pAqfIf4hFsb/BNJd4M1YFBH/zqHnAMQBXR9kAhi/beCY
    IApBVGdljAi/nGI4yG9C7VFejkiBvOoMbJJK4cHlQ9OdGcPzHoLYg7665LOhqA5f
    WBdZxSUKefwjmOXpi9FjRE9zGfB1J1XuzBlN20hKqPd7JoNrHB0MVJHWu/rKLAsu
    fM22RB0Xv1gekAwzpWtQvVFM5XLLQ5Sbpr0Nzv0YWJgPMSuhXlQFTjWoMwC6MkDp
    vSuxcAEIcePIGfhmaVcP5coWUB9WJ/KLiaZ6N5u5UFZOPEg80csuq+eHWHsB3u5A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jBXeSY8A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jBXeSY8A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934083AbeCCW6c (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:58:32 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935334AbeCCWkz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 111/115] mac80211: remove BUG() when interface
 type is invalid
Thread-Topic: [PATCH AUTOSEL for 4.4 111/115] mac80211: remove BUG() when
 interface type is invalid
Thread-Index: AQHTsz9vS8tn2RMlEEeL1UfvjG4OzA==
Date: Sat, 3 Mar 2018 22:31:56 +0000
Message-ID: <20180303223010.27106-111-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;6:HcmmYuMqXaZbFMw6+TjKvKHQXvwTQnOs6fLUPsbT5+dYprOhPsjJPfONoaCSWLDoaJw5kuRnQRLL1rNApirbao88WAheTHLL0nesc1ESg+3JvirVFKBacvsHzKAHsQa2CJRfv4kPiJxHKCSUwG4w6mPK6R0jINWvAVqcJK5BhBOWbBnky+9wEFLvfNZ73d0poFMSugPKhWqE4x6gNXuUCQ19U2Tj6Q18GUCBHxOwI23IVsp9PJn9pIPaswKnL/ki+k/k+BYx//Q1XdAS8nZS8tAVoDt5qgyIs03oClOaWBhfwed7aKi0OL/Exy7uGY+EPyc8nf8mmHTfq/EiK6hH4WBjMao/gqCEq0qAwATsDwACpLqe1fiMXroiNro418ZR;5:cLOVILLdKqXoNep6XYFHYRy4BEgiJG0/TNG6JwcKJTtZWVx14GG/QOG8gx1mRmlOthZKI2u9G+Ow4/PdZEdHcmCeYqP/Wi/llQLdsBeD2z3chSF3amGB4JOUAfJjykA3m6+UDUpXro0czDY4EQJDJlHgOv/zvk04jcUjS1fw7bc=;24:2Gi9qv/NZ3Qh1/QhfrcS4GSFQLJri3H0/jKU5f+LgZt9ZgElWwawM8r6Tl1psmLKylO6MwRy1UmkZxdox0z7vbPFubErGeAJD3Pa8GLl1to=;7:RaMLlA4eat2RCGHN1FnqVPDAnon3k5o4/uUgLeRs/FtREbNh9HYUez4bqwCGQAXabK8YPE16kyK4sNxvcBXfINLzmf7RmOHeazZuWoIfGjD6/JABMtNmOjLCV5JEwjAqvuaKdd8qeaJzRMts44Ldq7pDS99EZm+mWlmDYkUPD3r2XZt/G6h/jzQxlyDHdZ8k/rZQXRii2qKNWlyyKgAd1KBDxXuDWwN1T36ecbz2LlOdjC9QwkUd0KDS9WpSQU94
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd968782-7866-45bb-66d0-08d58157d19c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3449E50B3514BBA7466D64EFBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: F8WVB8Zb9eWdDyQyx7aKeNkJG4/V7oYwJD2ZBBYQO9KkyimC6egGOBiq6FOANw1TLIeIsOACB7dgybbLCZKIqZvB7lY9ZC8DQySgxTbMlPOnxsmQV+4kDiqxOcOd3wZ84ZjLB2GE7McI0R7lIWWhPhlHiE87rVg2OVtUhJbrIUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd968782-7866-45bb-66d0-08d58157d19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:56.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index bcb0a1b64556..58588a610b05 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1441,7 +1441,7 @@ static void ieee80211_setup_sdata(struct ieee80211_su=
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
