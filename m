Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489273-2-10600010270300817643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489272; b=C/mR7ucOlNFyKQfFB6Yuz7Hrb1TpJ0tla0r0y/C8vHG84sZ
    h006Nq1qoCy/91kLXJnvkqoxC4kuYetlECD6OT991y2Zpy4N8YaYHSpS0MZgBAq1
    +8yhIr1Cy7ECBngBtfUzyYmuk66GHzHp2kCMIiJPPhDMY8uSvGcp+lVpSYvGWWVa
    FUkhlsmEEN97pvFr58MMBvCQcjTn/yxp7yZb0OuUdFohaicXuTkfLsTQPtgetBgs
    Cm9dHwFKRJM34rWpFYh9LOpV5ogAG9wXcRYHvubu+mCmXGWDx3wZsdm1tGKLEnxn
    pOuNuSzEh2xcDMSKhDCZ0VWA6Tggvcm81ZyAuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489272; bh=7MTYCG
    pvvdgX2DnEWt4uQmZy5Qz28FpBqAnpB75uM7g=; b=WbeUQs1yyoYyevqIbqbD2w
    PjR5vNu//RrauNU7OKamwFRr3ZJ7EhO5eTGKsVQyrvMD/KtEbb2xikvTFnSIYh+i
    3iXRjOQ+gvhLDNI9LdxFsdLcNjtweFOi3mGYMjjiXOFZcfiYnzQmpj+6wTWKf6il
    ZEVMD/Hutqs0TZkvJplWUSHE1iY2Y0Byr0k9l1n61+lGYkJz1jyAfH8nzJrYfGBL
    ZmeNWn/VDHq09qOu5QBBr9qBlnuVs5WSbGLdJDA2daI0oKEEqHHGPgm5YcM1aF/W
    2JJv1iFZb25c0jM8C/IuZ9XRI5GVOndzYI6pV0pJuEw8IOpfojxggwP4SETE2NHA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W0Rkb4xG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W0Rkb4xG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965676AbeCHGHu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:07:50 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965799AbeCHFCP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 097/190] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Topic: [PATCH AUTOSEL for 4.9 097/190] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Index: AQHTtppAV23LDYts0UupBAFBqDifWw==
Date: Thu, 8 Mar 2018 04:59:34 +0000
Message-ID: <20180308045810.8041-97-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:sBnkSGPXZ03LBqqkx3QdKPbWBRJ10hMXIjjMewdtlBN8KBrp9C2G6ax4iB+PLlYU8ljDcSmnXNQcZEkRL9CFHthmLR6PSeD93BwaIp5274mbodbsgadc+3LbPC5QmU7QAKu0bR4FcRkokJwy9MyfLXCS5hpQk7erK4DB2X84eoATUJ6BO/WEDKAp12PLacfW+1udm3OdY4l2Z88yKxKpZpYN1CCB439+GhG3SKSMYpRl/bEaIdsmtOeQTT0FN7Kd;20:M2w2FEtiBDLVquBmweNer4sxVbgvw1NjXddSLgepSHfpXFogtZDFK0KIFEBh1QZOSVxTZCJMVH/ACnf5ZudRbp+KSq0ZmCTDPMApvos3+HWoGGBpAv4CuLU+REMnBFD+Y23EVei7hvjxxEcIt9q5jjQVc/seuXoZ4kgVFaC9ex0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 174da06c-587d-471e-3362-08d584b1bf15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106300581C2CF23E0006BE48FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(15760500003)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LXCWdnmLXX5y/uzTnAorFWVhVjKjd8O6qY1u7HSpuiuy3yb9uAVZOBYsQuXDkYWHMxLsbBW8sxGsDoOG0OvaQSnNP2Hw0ttXhH9Be98yXx5PLndgJanyDc1CVg3c1paYoAPXJlIqO13g4Bvd9BpUoHDCb/FbjdR8SkEo6UQtaWF+ShfhVFFxWiFn1L3H+bIWWdnltK+XK+7JT/BhWprxf/5hP164y1GTUTjX8DUq33DliUCTe2uBO8h7OGqJeWT8NJ0M6Lbv2ADAp/u7qNHfIAyRQCS8p/UhrttKBTdrIi+Tcm7F3/o8LrqgQHrC/TUOdwHDUlwmfThXCYmoh20jlw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174da06c-587d-471e-3362-08d584b1bf15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:34.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit cf147085fdda044622973a12e4e06f1c753ab677 ]

ieee80211_frame_acked is called when a frame is acked by
the peer. In case this is a management frame, we check
if this an SMPS frame, in which case we can update our
antenna configuration.

When we parse the management frame we look at the category
in case it is an action frame. That byte sits after the IV
in case the frame was encrypted. This means that if the
frame was encrypted, we basically look at the IV instead
of looking at the category. It is then theorically
possible that we think that an SMPS action frame was acked
where really we had another frame that was encrypted.

Since the only management frame whose ack needs to be
tracked is the SMPS action frame, and that frame is not
a robust management frame, it will never be encrypted.
The easiest way to fix this problem is then to not look
at frames that were encrypted.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ad37b4e58c2f..72fe9bc7a1f9 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -200,6 +200,7 @@ static void ieee80211_frame_acked(struct sta_info *sta,=
 struct sk_buff *skb)
 	}
=20
 	if (ieee80211_is_action(mgmt->frame_control) &&
+	    !ieee80211_has_protected(mgmt->frame_control) &&
 	    mgmt->u.action.category =3D=3D WLAN_CATEGORY_HT &&
 	    mgmt->u.action.u.ht_smps.action =3D=3D WLAN_HT_ACTION_SMPS &&
 	    ieee80211_sdata_running(sdata)) {
--=20
2.14.1
