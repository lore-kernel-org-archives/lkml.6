Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116954-2-9528454830252520485
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
    t=1520116953; b=IINdJl2NNyDXTMm1dZXD2WDjyiIIrwfyh3c4yxfoLBctJrf
    m8W4xajdJLR86uV59GiKrQ3Nm79iS5dsS6ecDnW2NSbYGPouscOzcLJF7iGccsnZ
    24sN+mieeF7sc4lWRTDGR8SYPH0QD9lKf6JAoDd/rh+Jdc6eGXD8O1iIhqt0J3ra
    7oAk1LWzXKCj5d4TKTqgYVAzOzghw0dFsYGFjirrdo/YgKbJu4FynKRkhLX6qbpj
    jkglqz/hLjwgkQFogUY4YgQhM6eFCvcjj1rYdZZLb8sOpn9ff5MutU3ne2t7gBwo
    BHJ6s5YT3sujovvQU7A3n3qCeg2IjwHzIa9dnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116953; bh=MuJXwn
    xYzIts3Y2ACvT+yAjY4yaQP/nUEU4pIbKHenQ=; b=gmKRBGtCRxctPukGWDliWz
    otBn8GSftXee/On9SJfX4i//o6MtcBjhRq1mo6XMQM4VWz01/gLOabezaUnBolCq
    NnmMpqq41TMYfCBp93SeYsdoiAW79hYMb/LYT/mBMaiursZsGJu22MpUqB2FWxPd
    rz2olN7dshLDLlCy0q0DjWqyBuLC+MSP0IFCqpyQFG1qiftljCIRiPnWfRL5kBPc
    XE+H37WzIaLD2qX0qZsGbEbrobso7/oncq9GPLzYQnztOU4yPqir2nEdsSPq48WZ
    5Ci66feDXZJfWvLnUpC0w0gE6kGBclCNbpVsq/afAsNSGzm2Aqv5rlViqWeoH1VQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dqa+xzhH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dqa+xzhH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeCCWmX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:42:23 -0500
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:22992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933411AbeCCWmK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 60/63] mac80211: remove BUG() when interface
 type is invalid
Thread-Topic: [PATCH AUTOSEL for 3.18 60/63] mac80211: remove BUG() when
 interface type is invalid
Thread-Index: AQHTsz+y558sm3xWHEaQ4aYyyBt/mQ==
Date: Sat, 3 Mar 2018 22:33:48 +0000
Message-ID: <20180303223228.27323-60-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:9nJXbHY7YgIu3HqZfKTPU+7rc49C0iPbK3BCxvP8JIjuS5nNyPnYYc04bytlx7J9a7yP5tPHuKk/bpTkc4sZUgILnAQgJHSZcuHQHfEXSYAcdIanNz4qcpzb1FvgObznlqTIAHsH+HmskXwGSiq1fHojp9t5AveK/aG+m2vMXhakJPWBEE69rbprhMYu37BsJWfUEiQaHtq79NoWf/KU9doUS+v4XXKkoeDGOpmCITS7kAa95VB3qc2+ythddSAw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0677d512-6464-4ce6-a5da-08d58157fedf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB101872101129E485A4A21435FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: CuepKLORA+Mfqq2b8UBBmhJ1zShYh+Wn775xv0K1bmbclHdfV9deDwpxbKsQBoPAtQH9VAGtw/QO4vyLAHB4EPSOT7DndXm9spH2OoPuBSACVO/ih60EMpYywKwBf4g4FdGAR61D83P1pnnfLtSU9AtImNkWPNL6uy/iRTIpc+A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0677d512-6464-4ce6-a5da-08d58157fedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:48.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index eeae0abd01de..672e28918a44 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1379,7 +1379,7 @@ static void ieee80211_setup_sdata(struct ieee80211_su=
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
