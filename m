Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485907-2-2373748059108873307
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
    t=1520485906; b=MWivWa0rl/YuyR7oC+CP6YzVMaudSGdUTYddWYDUCs393jh
    JBwkEsA3KS7ugOVivRHJm1AFsBlcg1xPi1zytezDmk5rgX8k/UsBpOkuEME/MA8q
    OFMShN9QTbWYxocZApQKvN5hE6HWzFy1XwrpcPYTpivAocb7vujKnrmprTvKJBjk
    FjnQV9bTpmpVFRpgJsbNiemIhx255HYqPr5G69j+kOkH2VYQ3NSGZeU/vLu3ZK9E
    fnod0ZI3Ik3TL6UL5uKhojhigoKe/8khlrKJY9UKPkYNmB4dVYDUs9iYyhswkeTk
    lq86HyzIssnKR672ZNLXgifGl5HTfq5prTPT51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485906; bh=bTlgau
    xNVZKBQO7hsjchJH5eYawLjWJLb0t0hjL4Zww=; b=V7VZcEhvGf765gI/BVBE7z
    iahzZTSuamvbJ1jjrAbf/VTF8IcxWpSy0N5b9b6ZNUpFa8jQiPrEW5otMdY3UsSH
    cecf+8cBabceJl14cTY4P+1CVTozHMlyP1VTCKwUM3LeNT5kFKuIDExWUKHuL1A4
    48hbCKBi97rrXN1zMp5tZAPpYU9D0RuqMFBH09jI2ex5pe2GZZAkhuqI3rdrwvsl
    nEE4Bt4BGi8pbNbiitPfKc/6vD8F++sGF8r4VGTQabePWcVEHVq6v88Z+gWZs7z9
    BoBS6pHO5712HXDMsC7a+nX0jBjsfHom67+tcwGSaIpPd3xE6bSJOSFLXSeD+6pA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MRhWLQk9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MRhWLQk9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966888AbeCHFLo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:44 -0500
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:35342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966629AbeCHFLe (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 33/53] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Topic: [PATCH AUTOSEL for 3.18 33/53] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Index: AQHTtprH5zeaMVR0n0yZ4MgFOJlzLQ==
Date: Thu, 8 Mar 2018 05:03:21 +0000
Message-ID: <20180308050230.8876-33-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:ZQEtAQxO793Zruvl0+kuwQYNt/Gn+1JfHLdFxX3j5fcFLu1JbE0qSZaWHa8SnPxyeAkw0i2y/Jp1uaejCZuZfFL+nwR9RhOmsOFcRbINFUmNbaUVeswAs620frNqOpgG57mgBOtb8fFD6l4JWJNfqTnDVxW+D7qmeYCih0fE6DNFF7BSyeZQtKdDusDYAmhqBplKkeURMBYog3giwgr5zF5lFpZ44QwdkZqSwiaDvN4mkt43Qb4d9HqYKX9htYMG;20:343RfAa94tOItWO3hjXDGPMDpn4cLlVqKn/dzXMA5wYp3/z8ErMsR0pchiW0Kvsn6lOEeswuDrvC7NJSCfl3xaJlVw5UkMcE182t8skSStYN4g3x/vXWrBXicG2bs2v7cxuI23Ut80Ng+zprri9qkgBMyxcUjgxbGMsgm+zOZqk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 146760ee-3b6b-4ad3-ebfd-08d584b30cee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030CCAA5384D1F1468039B9FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(15760500003)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OJdv2KOhvnxrO53QwxruzhNm3Xyar3PtRBNJbpJ3z3Nri4GUg9ExvmPS+fEFdhxZYaoJsmYUXkil6VWqO33d3LzQyDfdnSDQkTezCTtWpSxlFwp29FlzvA1pIAPgkyC+denDQGGriJTsCSQI39QuOsxjhrSq6xHofCP4Qy6A+K96Y7UAE29QvCnbZMQ9ldfuOuM7gUqehVBRR7Tg5DglVp5myRF5YXjvo+QpB3VB9QnRjUBu3choVClTTDxirflVgbS9TOPtqsR5r+wPLpgOVS70CIenFrn7W2Alo70ooaGccxiKZgIUsrdA+i+99lZ3+IEo3oPcqmcpvt0bdAEpvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146760ee-3b6b-4ad3-ebfd-08d584b30cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:21.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 89290e33dafe..e166bffcbbd2 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -194,6 +194,7 @@ static void ieee80211_frame_acked(struct sta_info *sta,=
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
