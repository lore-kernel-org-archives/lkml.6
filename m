Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492614-2-3536097822948692160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492613; b=IGhV/wdoJNAV15gDDZJr6dfLkn+kO3gnBNGWDuz3JYPyqgK
    gdyhxFEN+jhfqhrxGyv67Fc10sRtgoekDwxWmUJLmtNeXFmHwrAUyPZ2Ycate+zJ
    oG0x3hZ2uAcAYxZAIdrrKIMiIQHSCDdrLGEN+fnZ5xlKKmhvJ4oyaByi1VSgFqEl
    syoZWD2s9M636b4dCCm69DFuyiWuzaUMPkm+WSO9aBH2y7izov2wBxaPagk3Q55y
    QGCPgEMWi2BTfPjFCMOux1hGiLllpYOCe6JVHnhBEiwkj5cYGBMiqOwekgV909nk
    17WUDTGUcdL4XO0bVBfPXDdhB54iTdOfpr5yvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492613; bh=WUDsxN
    izWq/emW/p+Qs6pqmugtI1uQStRQNqoCPeSLA=; b=NXC4BmIhqEWXsCCPEeyZGZ
    Oj0G8VKRxGku0aB+3si22rOtNgkS1K5YPGt+0BxBBHTyYBJZGqf0gShpKZFTKYcA
    qzBW+op7KAeviVuniGJ9FFiB7CnykuuObLvgnPQVwqNEjcA8gzuo74lmYjYI3u4V
    6W5kpD3EVDIK2o7hpwsSx6IYBfDSsx7nnSjntZ3tVQd2I/dzttlv04GokXzMwa1A
    oO2NSCgZlbFfTTyvV6MuID+ZxXtZeCWMlh+t6Tr78JMEU+04WHnWnSY+xZ7d++tr
    ZaQYdix4aGx6fsfluvrGcLCysehaot3+rZ2WyhSpb4OUQlSQjnxoOn1qGQxGjbFA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iNUPS38P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iNUPS38P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeCHHDa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:03:30 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755320AbeCHE5L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 38/78] sfp: fix non-detection of PHY
Thread-Topic: [PATCH AUTOSEL for 4.15 38/78] sfp: fix non-detection of PHY
Thread-Index: AQHTtpnLvetCCn3YgEeZOKulQ2Q6cQ==
Date: Thu, 8 Mar 2018 04:56:18 +0000
Message-ID: <20180308045525.7662-38-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:YY0zH6rjoQs7gMBxXTZiqeOwwDXJ0ADSlHWclowPjOITipVokgiWbsM4IhnybOGApyEf5m/6m8Rm1vVPIyqzgRaAhyMHICc0OwiQeJUD8ol3OjmaVIHs46oKbG0ySJa4rhtLkPCJN0R7ovkToVg34oQO4VXtuXi+attWRc+Mr5eEdQOIrarRoxwB1/rmiyclC2ArHH48oO07jjL+mTbQats4opss54YzVbJ3SslMjbOjQFqKhVStJ7v/ijn2U0bq;20:QL6epBBkKZPMT92Best4TeWv4zMI++55SR1GJpma6zl2xYYNOFqg4oGQw+nDTrqj0cLuNUOOXjYFz65QRX1jFeREoQIk6H/BB0CaFqGRNcTOhOvRo9IxKpm1ETnM4s8wc7jj/VNKu8o7onh3/d2kVpGDVIvKiBlXv0r1GsYeeGY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b168629f-24cb-4ee6-d953-08d584b109f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079001B0EA0B1CD7CE16D81FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: S1/0E5q1aDegVfxGNMFOuoraWausEpYRyHGDhvakaHi/UvQ4uCkpwkG0M/8z0/z5buMj1IQ5kj3cuDIHsiPK1G7zWNWATLRBSOo/2zAWnk2m6Th+zlIaZYM4yL5K7tPw+5htzLfzVIYA5DyynF4o5uaLakWYDwZ07Ze3yChPiooVRcUPMZ58w1uCr/VLuQkc9ZDCMToiJaWqZFqJOFUO7nRA2kaQpCpMWVVYHEICMURAt1E5RDECU4+2/2Aq51EeoVSlxDIUfHF1qXmTmtFsVoU0gW1LUVDIFbKOSfTNeympytG9H/vEDUfX8OimjTZz7PIG+EBk4c/3yGJ6RiPi4A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b168629f-24cb-4ee6-d953-08d584b109f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:18.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 20b56ed9f8adfb9a7fb1c878878c54aa4ed645c1 ]

The detection of a PHY changed in commit e98a3aabf85f ("mdio_bus: don't
return NULL from mdiobus_scan()") which now causes sfp to print an
error message.  Update for this change.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/sfp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dec35888c429..10b77ac781ca 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -315,12 +315,12 @@ static void sfp_sm_probe_phy(struct sfp *sfp)
 	msleep(T_PHY_RESET_MS);
=20
 	phy =3D mdiobus_scan(sfp->i2c_mii, SFP_PHY_ADDR);
-	if (IS_ERR(phy)) {
-		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
+	if (phy =3D=3D ERR_PTR(-ENODEV)) {
+		dev_info(sfp->dev, "no PHY detected\n");
 		return;
 	}
-	if (!phy) {
-		dev_info(sfp->dev, "no PHY detected\n");
+	if (IS_ERR(phy)) {
+		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
 		return;
 	}
=20
--=20
2.14.1
