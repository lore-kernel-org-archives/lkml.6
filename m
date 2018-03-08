Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487140-2-17334329073276820236
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
    t=1520487139; b=XCZxyHESl+veARgkZjzdxZe9pUQkDKKsZABnUcqEW2DuGjt
    9cy74n7UcwXdefWnHDmy3nolTLoi1iLPWt7q5gCjrl18cM182kvDIWMjqAiTo0YG
    /s6ZI77KuAHTiZIX+xquA2rFyXgIbHTZ4AywD2nnyueokzuirD2zDPkDC/kXgCOJ
    5aGzrU1hRB7LeBh0GwbHJRsffGJ7199fcoqiz7cqNAQShCCUMFFQreK+nUyiv5I+
    ESBIsTYyx7ijg3nz/MmbPxbFsw5vns9eophnvlsXEf3PYDGKdKe+vR76YqJ02RCD
    r9Lzmg9Tix7nlWIR19pMCNo+t2OoQkphC5nvF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487139; bh=D1az5H
    sNdmlGxkqSiHj8GBhHrJSErEldIfynanzhS8A=; b=M6SP0iIQhgapUK5EvzHCvh
    tYaOmf/ySzTOXfsSUbreIvGaH2q3kZYhtBwNXuhPcjXmc9OB12VS3qB4rT1AAXNe
    vC4NQNfQB3iULy6xRx0Ezxkh15tIElTcciDfRJCgW/g7FT3KrK6qSkG4qzTLkuHf
    gV6eAZIn83wNv2NNnyykUfgtx/JybqVZ7soHI9Sw8rVRpRJ1d6UYvPtoaHc0LDrE
    t8Q+4z7Avb87xWmoHlXdA29+mzyZZLd1Lz8bJrLl588TPl+INP7Dh3dldwqFRqKY
    TnN43VAtZWcOWip8Fky3/uMsPnfALjdeqX3ZpH1RhNnZTuwi29KAbR7LKFRcWY/w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YLpq17wY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YLpq17wY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeCHFGU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:20 -0500
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:18336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966099AbeCHFGS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 055/101] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Topic: [PATCH AUTOSEL for 4.4 055/101] mac80211: don't parse encrypted
 management frames in ieee80211_frame_acked
Thread-Index: AQHTtpqTOj9yP1jIk0+tMeqihIIW/Q==
Date: Thu, 8 Mar 2018 05:01:54 +0000
Message-ID: <20180308050023.8548-55-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:A57E9OSz/H21riytISh153sg5xNolUeOYf6lHCLtQWu2MXFLCxxmntuf63tAEowYmS6QC29w0fHs6noNIEhi/NPRKXEK+ht1Cs1BzPOVFqVw3JuOiWSU75bhwYUdTCQoVGyqTiSYml624H7dWKxm/xY3nljaMGK+/WSrc1UqT9mqYz7fuqGb5a3cQDUUXxjY5HkOAAHDy4xCnu/L/+QB5XH8OGVoRABZ9lOK5G7J8oji8bdFddGPwvYDmqSslw5T;20:UQ+F/T+yHt4p4knxEK5pqTU+VADnL+KGm3LmJuKt38tdHb2GsyemAcvR5dx4ISVcRG/nT+mDO21aT0asYjk3pAqdsrHjTrAxjF04ex1S4g+1g5MHIcXwbJaJwSsaR1TEwmin4De+0f+/c075RfN2zzhQS9HPvuT7Iu5HgTz4oVo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc17cb09-55bb-4d55-fa96-08d584b250e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09176239BE21A25DF480F7AAFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(15760500003)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LjS8LaJrhW04Tkw9ZLl3P7n/3HsUqhDzo4hFM9KNnuVaNZgallCnkVfcT9zgk1j7Sq76DQ/rsU4vQLCoX6IS36amU9ap4de0aRRGRPFj2AmCHvO0S1Pdw7OnwOXIJQalvFUOcCDm8JruymUvML9eSgZjS0nT0L+xsQsOo6CtYuu5kaAQqTxXjzbYuzOJ4BkRd1SGe55sqpgSIkgCxg6KoZRAeFm9fRt2LPYOoSK4tmwy6w5Y7HNjoNyRaTwi2ZLUdOhTagP8zbIhHU/ob0LpghnPmQnJsuOWdMEnh0tpcemlK5V9pvbmKHBDYIYObGbcalX3X1S85vlgUvL9nNLVDQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc17cb09-55bb-4d55-fa96-08d584b250e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:54.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 5bad05e9af90..45fb1abdb265 100644
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
