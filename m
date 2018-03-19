Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495670-2-17601799503627922529
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
    t=1521495670; b=Pfq5huUcQaL5YeEnorpejfh1fYJPA40yqetUuYJMJXKTCAs
    YhrBJBtOQa2T+fkBdefR+12zy1ibzsASLYlfTXXNgOzGSmfdwFzIFTkvhwKcmV4Q
    RP2nVLa0kd+w0bkfdh+RJlbBHjKoeSqHHfUgNT4CGFpqCijKbsIECs0GTCanmji9
    jsb+Xu82B9tdqeDHfmLyHdML5NiOFDftdXgVP8GBFkDe94XHk8sj/46UsGeWoPit
    rde6ooJLa2ewSe8akiMuZMQzZjsjfG8LmO150KweoXM6CuzMkReI2Ca06aiNmYi3
    2W7rg3FJP2wQ63fmOjrPIo4HOfiGKwN47gBSMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495670; bh=qDCnKT
    vUaQ4vXo9WE15E24NSIA5qG/Tc/CGiL95Mj9A=; b=YB7g5x6EUW4SavP0Vgc7kB
    kqUd3cQvChwCHAh5VosxO0mzw7++Tf2wQW6xz6BUMs5SWmr7tj7Z4vPUvIlghboA
    WfQ7AhRmVjE5PcN3IRCwoS6TZ/5YEDjWtd3nNEVJ/0hmYmq6iKrcn+f7mK1EnSwA
    u0fbntmv6uyJgj+CyY0lflIXVIbvRkyTkRDHcVPe7GWynAlhLustK6HE87eVh5QY
    HXtUpnu9VYr6YBwbJRRAoe5VJ2svW/WEFI5MJb07AsKza5kisxKtBw8Y+Ep9hbWh
    mRGzAw8KQK1vZH1PCjFildomjhrjnt1C+1mG4eXmNkVxYQWLjYvhu/P2xelefIBw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J3OifnG+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejheenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J3OifnG+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeejheenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965169AbeCSVky (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:40:54 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965017AbeCSP7D (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 034/281] Input: elantech - force relative mode
 on a certain module
Thread-Topic: [PATCH AUTOSEL for 4.9 034/281] Input: elantech - force relative
 mode on a certain module
Thread-Index: AQHTv5sgbfVnsgzQU0ubSHg37IhOOA==
Date: Mon, 19 Mar 2018 15:58:30 +0000
Message-ID: <20180319155742.13731-34-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:+aeht0jDY/SEx192qjYTzXjcisjnBUTn+rrKb964ro3+VyQExOquUidjSz3ZG5JN3V2lRwmifI5seniu0O/KEzFGgjru7uzw9SZxyGVg0vnjuq/wQA6GRj5QJamDQApzAX5Cqh5lPaPrpL62GpXKBqBfZbnk/DEn0pFjGfFnkgENZAgQrxK6xdxTehuZXEt1EXUZpH2NGRDTEuSEckmlhrUJa7lhOk7OEvBm+KjroW30W1qSWc25k6cElHBf0Qln;20:+40E8K5Ej1SWXaQ7h56u8cdU1JS7ys1N1mMoKX1K2uAydeNMF6ebOgGNMPOC7ZSUIANyX8ylHpObsNHHswHIXHEoQKp4Diisk4Y5h8eZ4AmMJXGodcGcZpdqKACITOfZ2yv8S+nGC8M4wx62NtDZmmoPOP80BU6zo0vQg+ERgAs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 293bcca7-a318-4c84-9f33-08d58db253f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726E79A192402D5E4EBB5E7FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(39060400002)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9ercyex37CNCDaI93LYeHlGELDkmKMuHTA+/IvzHwa675W5q6+PQEAzk3bxObNpBYX8R58gHOpj9RpTE46Djjbh7Fkh2vDZcGoTykjdI6wRmsnUQo6LNYbBCsQNCacV3D3LalH+KbMnXHrudmzmXXyZoslfem7RSKitst17nCrRb5k8JBUcnqqFilJXo4DH0y9O++iPXqSfdM0/bFj6B85FLDOGTEBWo2dl07wIyTW3sGMZBRwXUztwhjRC0f7+nuJgBsW3dELvcNbM/8ux5Ig2epo0bEAG7mz5Vaqx778g6EB8o/yJzXuVY1YpIh7YKZsJuSitPIvCz+ewidm/DJg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293bcca7-a318-4c84-9f33-08d58db253f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:30.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KT Liao <kt.liao@emc.com.tw>

[ Upstream commit d899520b0431e70279bfb5066ecb6dc91d0b7072 ]

One of Elan modules with sample version is 0x74 and hw_version is 0x03 has
a bug in absolute mode implementation, so let it run in default PS/2
relative mode.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/elantech.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.=
c
index 59603a5728f7..c519c0b09568 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1711,6 +1711,17 @@ int elantech_init(struct psmouse *psmouse)
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
=20
+	if (etd->samples[1] =3D=3D 0x74 && etd->hw_version =3D=3D 0x03) {
+		/*
+		 * This module has a bug which makes absolute mode
+		 * unusable, so let's abort so we'll be using standard
+		 * PS/2 protocol.
+		 */
+		psmouse_info(psmouse,
+			     "absolute mode broken, forcing standard PS/2 protocol\n");
+		goto init_fail;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
--=20
2.14.1
