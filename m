Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124362-2-8890928132838707018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124361; b=cviUaa7WtJEns4KblNlzViMW3oe3H1jin9yAtPJ+sDzNnha
    EGfGGflVZXG5eEWC5iW/vNC24Lzx241wkRTABcmvFas+EzdItmmbwjCkDg1+oVJ9
    srFjkSmDyPYIcpQjR3d+10GgePnbURXFrWluTe61tkcjqrYWiEr2hskHRLyg42cd
    chf35m18SINNV8D3tWS6lhpsjIYlz/gxUXZt9DvbgtDvk4M3GDfmU86GC8HrW6mq
    l/VfMA3g4aq0aEaDAGejSPVZkkEORFgMPt8zidq9uDXwFJBUDshrlJEcy5ZxiM3Z
    meF3EI5CyDFwWQY2jHnH1TBPHHrLpWpIBxzROLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124361; bh=OnJXSA
    /ptRC582o6oNS/QUVeBh1vPeo/ZFPyFp7gGX4=; b=IVbcBGeDBgKRY55DIfzTj1
    HI2HpO5jSNPFNWaS9asbQ5dgSpApu5xGTSsWrnKx5jWMkf7SjZIqxx1feduJNzpc
    Bajn9DfJPFnJVd9tNQgXkee4Qi+0lebO02AvBgyL+1zIi9H+QzMdn8/JuqKq+E//
    CUbcyoDqf65APGdhk/NRlp15XHj6pv/2NK02xQE7++tM+1XBYGOsOYa9hSIF3P2v
    zT2+/cnNIeJQ2Zfx6HTwJOkISjV57ZYMJRLpMciAWtSaYZkqllq6QQbDAvROnFcB
    ts6pUaOzp1xOA0ysitY6dNeggIGXPZs82uQZRTeuZxZlnD3cupTDCPe0ztH2ya9Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MX5IgacI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MX5IgacI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeCDApo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:45:44 -0500
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:13182
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932386AbeCCWZY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 028/102] net: ieee802154: adf7242: Fix bug if
 defined DEBUG
Thread-Topic: [PATCH AUTOSEL for 4.15 028/102] net: ieee802154: adf7242: Fix
 bug if defined DEBUG
Thread-Index: AQHTsz5jVpmhC9f0FE2Ez2Dt/CYT0w==
Date: Sat, 3 Mar 2018 22:24:25 +0000
Message-ID: <20180303222318.26006-28-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:dBJU0GCrJrPdA8pZYr3wOSb+rZodBfSe9DdRHUnxuWyX6psbAUV81Z3sl7C10DH+uHdDe07fKi9nNZlIdtvhmAX2M1CCZZoXMrhwYc3CWwWh++3cgznbqgTa6XB6BNDGW1xGwD5lqaGiGFPCoK4lvdXsFQ8ZUP2UX+oYEqrxc4P6xR1OPHOnYatvaGSYGIeffB/T5SaAs0XTA7lR0AwfZrj8TNImcvDeAIumI3d2jAxPFp691LbkjG7zSTFZYi2h
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7741217c-4f03-467a-c21e-08d58155a721
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3532884C296A5D9EAE78275FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(232431446821674)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(8666007)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: V4sBwvztMnsg5a3nolzl7FoC1sKJF8B3tNqEGWoatQewY2lfsV4MBBVJKYCUaLH/Kl9avthTrpuSE+MqRiPGJDOgr5g1adTVpe4E6l/JC15kaqQBHk+ujf34Emh3RRIEDTgqkuakFUc0sq2pob5TQmtUj9OQlKmFpVCoCv2LKzI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7741217c-4f03-467a-c21e-08d58155a721
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:25.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

[ Upstream commit 388b3b2b03701f3b3c10975c272892d7f78080df ]

This fixes undefined reference to struct adf7242_local *lp in
case DEBUG is defined.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ieee802154/adf7242.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7=
242.c
index 400fdbd3a120..8381f4279bc7 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -888,7 +888,7 @@ static const struct ieee802154_ops adf7242_ops =3D {
 	.set_cca_ed_level =3D adf7242_set_cca_ed_level,
 };
=20
-static void adf7242_debug(u8 irq1)
+static void adf7242_debug(struct adf7242_local *lp, u8 irq1)
 {
 #ifdef DEBUG
 	u8 stat;
@@ -932,7 +932,7 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 		dev_err(&lp->spi->dev, "%s :ERROR IRQ1 =3D 0x%X\n",
 			__func__, irq1);
=20
-	adf7242_debug(irq1);
+	adf7242_debug(lp, irq1);
=20
 	xmit =3D test_bit(FLAG_XMIT, &lp->flags);
=20
--=20
2.14.1
