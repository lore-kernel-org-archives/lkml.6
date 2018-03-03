Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119829-2-3521714041539821013
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
    t=1520119829; b=VdwGMeTUiqdSwy9JFG7bBsivGNnEaPgGpdJzlT6PuJNVjmy
    oEVAxQCP2qpYd2ZwkGkhjdVPo9PsTX+bA0nvAZsMyUvLpFiyMhjyMOtu5p4Tivgq
    nQhb1/S+7t9Y/P5ETQLxS36M8FDM62CL3bJoqHVYsRjRi1zGULXyflC0krUnT93W
    UQpgsAXJ+BY+AVeo6YHxDNPf3qGsxSBZZc9qYOOeSjciqFibQtL2XIBYxgnBvfrx
    cnoDlY9bsczbdufkOqH7xik8vkCfK4gmBStXddWQI8kbRnEFgwCrewLAQTbSXAx7
    WtnwzNesybfHRuqwaICc26Zz0jBncoHgypC8j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119829; bh=m/yqVr
    MH17aYNHQQP5B8f63TTzDe2dGTuvnvMuGwY7s=; b=OzrHKEi9cpA7QRnECvd8iz
    8CQLYwm4ADhU8vyEPWkTM/huxRSMd88RqyYK69EiYlxhDZC3NmXpNRPMEZ3wbJRj
    lQX9AAee2aKYNtBmQ76DAsvlKtbBBgykP5Zw7eY0X1SCLhAOtpZolU7BTVmXPvk7
    Ezx+d9LQxE+hyICWuveDdp0fOf1kcYHd349elt7dk417rhdwxFy5maygVjv8Stny
    UzjsxdlFc6Gu3v/mbg83BOvWqnH8sTV4JPL3Xfl5Uh6vuVmau2SdZN8fBFsXdQ4S
    xT+O11oebCAy2dF+6R4Cy/5bMu8mDRoDUUC2eB/HPgV9WUysEUmey9g/IuIByxeQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dUNx1ttl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dUNx1ttl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933818AbeCCWgn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:43 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933275AbeCCWgm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 181/219] net: ieee802154: adf7242: Fix bug if
 defined DEBUG
Thread-Topic: [PATCH AUTOSEL for 4.9 181/219] net: ieee802154: adf7242: Fix
 bug if defined DEBUG
Thread-Index: AQHTsz8giYKO/z8SHEK4yHyX5GdNwA==
Date: Sat, 3 Mar 2018 22:29:42 +0000
Message-ID: <20180303222716.26640-181-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:fZFz5pn0XwSc+gfhXk2RIEwWWpWlz9dfRlLtVSo2lQJW+dXahXOL0uDdxnpFClSZJyrSKETy6Q8zQL6fsHHDZcTE7Kv+QQhvV1AeDsYQduBY2jajbxQXGIpt7+rsEc2V5rwSRc7h26gu9Z+8S/cctpICuDtfl7GZMGEbTT56FRRThM9pCHtJ0POp4EJmjOjhZej1/nE7XoyuEzP7lnkkXwwBR1D2ymTTjaV3CfdadmLJe2gfCLjxkS2Y5NSUerTL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dee8e95b-d9ea-448b-77f7-08d581573b59
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020A78987B7D339ACE0C03FFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(232431446821674)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(8666007)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 56kH7Yx5smqbAhkqgDqp+Dw7EDYFx+2jwCMo45nWYw4EP5Xz6GMqdZiU0gynLNO5JxCYVFMS/bT7nWOUYsysv4OQUYGWkgZg63JWRodoK2Gk4bYgOdJKsT35PQLh/VdKCXEHn8lfxe8AwOj4KDhIgGm2ts9BhF6jNybnDKBST+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee8e95b-d9ea-448b-77f7-08d581573b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:42.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index f355df7cf84a..1b980f12663a 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -888,7 +888,7 @@ static struct ieee802154_ops adf7242_ops =3D {
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
