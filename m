Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123081-2-5924299890146738015
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
    t=1520123081; b=V7Oov7VBsOH1LkXqTsNElTW4iph8csDn8th7KAjFZIuxYYk
    D9p353L8sse0KJseI0nV6JNWe35nW2SAV+i3ScBle/2ct1qbS5ZAsfxk0rkhs/yk
    541SzQMaTyHXT2mTATRR87zPsV7OEoLA/32xlHCCCfJ8yZXH9y/5IGx6+swqTT+z
    t5PC20Cn28Z3PHgN/bZuXUSdefPg5UwVpjsrwrMBl2sV8XwAwtAjFrBdKTvxusmv
    qru5IBbtn3Ro2Y8sTiz3hjqo729CWACqEA8gVuA4HLhebMIFbdeI/CPB66O0kbRV
    Me2aBuEDp9JytjFVcFcHVIxVlLHlfQAYTQLgJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123081; bh=kMfegS
    h8l9vB7GmKQuLyahQ1j0qfMuru+ZdcVcGGJjE=; b=MhIC6w7ftvd9DSftmdGIF1
    Q1mBFt6ueBivK8JvqhxKn7otkJKiJIPgilDcv4UpJ8W/QBMpKKUkVdf1wcGUTDof
    hpGq4AZm2Q4zCHSiipElzrpauBH0zXUNU5lfplJqVlbh+mwamy4aNRCX+JmNtBak
    6Z4HQyJMAJ3kw88wNEQXh/wene+mjngr22KvIUD98EiPN9oRiP/KunGujh/gHu1h
    O2Hek7Pzw4QXAYilYXgDs8N8bI3nBJCdAfCt/+oL5as5RAffjMJoj49mGcHPCOWY
    lEvYgeiSuSZHlAGLR3+5LvhKuW5jTVsB46JbU/ID/nRrJiWan0Grbi0ij5feBnOQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QGtbGpNW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QGtbGpNW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeCDAYZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:24:25 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933192AbeCCW2T (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 20/84] net: ieee802154: adf7242: Fix bug if
 defined DEBUG
Thread-Topic: [PATCH AUTOSEL for 4.14 20/84] net: ieee802154: adf7242: Fix bug
 if defined DEBUG
Thread-Index: AQHTsz6i3Jr5F1h7bkSVovddGIZoCA==
Date: Sat, 3 Mar 2018 22:26:11 +0000
Message-ID: <20180303222518.26271-20-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:JeEJQF2ZhJv/7FZFJpLJvmiO2TZjLUgOAIoVyysJwgJmzKg3/kXuz8Yb/SbibPbDe7OChD94o0C4SJn8/U/MR4ug9VH6IqzzqFJ1Vh4C7kqT8pV8TQYZ/ugYMb7kMtWG/JMRA9rjjb/WGFHQpWwDXvTcEBGZlXNRvOAGX8wmwpVXZJqbFi+nqg1RqpBrSXcYAIh+rJEjCHAlld6YC7EiJ4Z91Pa+CWuSAFg8V1bWW1AeLUrJNszuLqbCvaTZogiA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c17ab8b-ec29-457b-b0dd-08d581560f32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11155C517C7E3904213F04B9FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(232431446821674)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(8666007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ch+awzrLgzaG+GxGVMFCd57n6NpiElE/L/Hc0K20b+UhgOe1UBxcz9rM55sdQtlpxZ9UERB7IopvjgCAaUCHoyvAbRrDQOZC9iUGJSR66x2iInwb/6PhszLaLBhXo+p0Fi5UcazHYhta6uSqPsSRpZ6nNayu9rDTuOEFORPDWuI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17ab8b-ec29-457b-b0dd-08d581560f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:11.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 3e4c8b21403c..46b42de13d76 100644
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
