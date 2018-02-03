Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681985-2-11520495556908218496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681984; b=C2t9iZ+Abtrwi7iTTB20lR674e2lEjw3aUJAMtv608wTOki
    QTItWyehVDpYdlldY6QhYJ3lHulv5TuLW1f6EruR14weN3uPqmRhWjLm0GINsEh9
    9GPshUTBqorI+GXKr1SZTWSecErxMpmOvIaWWMXBH+MmQhE7SKehwmCCZZ7PO/4s
    ycaEekgWWCMPn2mcN+OrvmAsE72vaRGVqT+SQMaT+/nwSaG2ccpUFy2/SYf3g3qq
    6prqqPvKcJlze2caf8l6Kjf14LYNxNyctsGJtyMBCdsTFHJWmKtlUNG39I3sNFZp
    5cS0ZaEf/MihkPvqoIcpJA+kfHN82EHQuax3Bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681984; bh=367i55
    g+3gg0d9VFPwxUfvjs9nGOgwipcz64FqMJwIA=; b=O4Ikp4MGR3/KFGiy07UvF0
    uAyUACErEZwLdkd1sFdAOXmNCpsQeBmZY+cuIQoVOKe/XPxT4YX67SMbGG07KRl9
    Jhp/gw+MBgL4O50O8z+IC4X6+P9BWOaMzBve4K571/i2sHM7kUyKCliWgSWpL/km
    OmnF0QX1KTznUb34D3qs1uYxle7Mv2vZruJsn7rmWX2WtGGKFd6QfemzdJXRyWy7
    5kewHgqCKNlW5DzSgwciNugUmJzAHp9yvGRXAefHcMmdjhR2Oh5mmPI4n3Cz3yaM
    CXsdML7HLNRAWZZrKWSI/s7+hJcXIhuWgcLgHMlnJaMAnAQODZ/05x1MFqNiLXPQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bFVjjYXX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bFVjjYXX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeBCSSC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:02 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753314AbeBCSGx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 13/32] tg3: Enable PHY reset in MTU change
 path for 5720
Thread-Topic: [PATCH AUTOSEL for 4.4 13/32] tg3: Enable PHY reset in MTU
 change path for 5720
Thread-Index: AQHTnRlw6PAqCWybi0mpctJ5rLDmpQ==
Date: Sat, 3 Feb 2018 18:04:31 +0000
Message-ID: <20180203180413.7438-13-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:7r2kDWQCjz1vYKEBR8VELC1rC3uT2eiXpevIirEfWPURVdvcndrI5pd7B7GrLR4EjkWMhcVBCsCfDNdl6a04/vdkf0UONEzqSM0fgKZ0LZ1vmbhMCBvBvXrxd/TBd0fCcBkSp0+vjXti/TDknwXKzQr56qA7EnWoaonNBd+SAkiNGU3WcR7Um8MvV+Noj8gg1/X2jwHdCQ/AlSIJhDWd9MNn96MXadRA8VBI+lOUD8lMjgZsPz1L6hiRrM7PwJX/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3b88aba-1c19-4dae-6565-08d56b30baa9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB10899ECDF03A16B3626DED67FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jbSJqT/G/c5pQozTzPNDUwrcPqaf1KALtgcNeYkgAy1yBf/ruWhrSJluD9yUJ2a0Ag3wRwzqHoRKcxKeKg9E+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b88aba-1c19-4dae-6565-08d56b30baa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:31.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit e60ee41aaf898584205a6af5c996860d0fe6a836 ]

A customer noticed RX path hang when MTU is changed on the fly while
running heavy traffic with NCSI enabled for 5717 and 5719. Since 5720
belongs to same ASIC family, we observed same issue and same fix
could solve this problem for 5720.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/bro=
adcom/tg3.c
index 1594dfb2fa92..3bba92fc9c1a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14240,7 +14240,8 @@ static int tg3_change_mtu(struct net_device *dev, i=
nt new_mtu)
 	 */
 	if (tg3_asic_rev(tp) =3D=3D ASIC_REV_57766 ||
 	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5717 ||
-	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5719)
+	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5719 ||
+	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5720)
 		reset_phy =3D true;
=20
 	err =3D tg3_restart_hw(tp, reset_phy);
--=20
2.11.0
