Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680991-2-12444556893576930097
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
    t=1517680990; b=DJxHeLOlNA1ZWDwLqImgT5otVYMtwdI30v/zDiwF9z4t0ed
    1+dd021g6KaYEO9zc4leC+zLIzTxlMgsV+5c2n2Zgx5dvj4v4WzsgvE+QNRDyyWZ
    KeDIswitgeO3jNvfSM52BvefFaSI41o9LUyFPmB2n71up7mW3m38IpYym6M9hVWh
    71yyB+ZUMBV0WnAZzpfH+aOPHG4H6H8RhEdLhkI1Qlza5lEB36C5h/Ka3eY+AIVq
    1pfrD4i2Lt1vBid2O9MJbg1gEKhPIx5X62mOUDWXzBlZIiDpfOIJ9NnceyIveOVA
    YC3NVjjzkkTb5Lmk+7lftlQnd8VwpBJwnNnkDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680990; bh=Rve0sp
    p0zEnkg1qjYQGa0WKTqSZwqQofat5McpKbflU=; b=oE/TzJV8I4EE1zDtN7dgZd
    Te4+n98CPF4/5TFty4SC+2myYG8CaFgOkOaBeAJSauzH6YDEmyCz4oahIsWpoVhL
    pcIQwRJdlgRg1/LSAn6hlneeXkXe0k8xUjAZGAwJ0PHKUG6nbkeRH3uPdgbMf6jK
    KQ170TjlyY2WN82JW0xYNaz5b8IYTc7Y/LA+vdyv8ehQZ7QEgDxkb8dWvGpVCa3L
    mgjzH4kq3YOOJiuw9q5q5XXBjfOoWMWkfcsUwE4wHqQvSaH3PqkusnhCss/SYkA+
    XLhHvmn+UKSJjNh1/evIuUbnMFgUQP9Ricam08m5T8jQvFqeN4NOuj0fGOTFHSNA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ul163n6E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ul163n6E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeBCSDC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:02 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:44500
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753042AbeBCSCM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 062/110] tg3: Enable PHY reset in MTU change
 path for 5720
Thread-Topic: [PATCH AUTOSEL for 4.14 062/110] tg3: Enable PHY reset in MTU
 change path for 5720
Thread-Index: AQHTnRjxXV0Oyk3hakuivjKEiEzz5Q==
Date: Sat, 3 Feb 2018 18:00:58 +0000
Message-ID: <20180203180015.29073-62-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:O/UY02LaTh8oVct1GfhXLvatZxdJiq9lbEr1mrzhHEmgmdih86JYWaS/dftLM+Jbnw4Qs8KL+lBHP0bjnBJm0ZDb7ErDYzrHF5//RIPFucYBXjA1nGJDWQqQ5KtKABE/mu1VPib9bSpLpGw7fmhfi60QPwPT+1xzwoPfHUr/6IT7rQrWHOlwkNsXGnLwi6WjBB9WLlTRtgRDlOdRbrDzVVl/xt0Afgjsgm0c2JPibiD0J7jMBPvdI9t9XpbKf4EP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 790f1aae-60b3-4fa5-d270-08d56b303ac5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB110589E2CF88338618D035F8FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: pPnp+u718cFda/Bf2WSPVAlUR67BfCiHpUhdi135swAD/9uQVSxA31DwXtnXAY7cVNFH23F4v7uQ/fadNDu5Tg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f1aae-60b3-4fa5-d270-08d56b303ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:58.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
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
index 69e1bd5497aa..48738eb27806 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14239,7 +14239,8 @@ static int tg3_change_mtu(struct net_device *dev, i=
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
