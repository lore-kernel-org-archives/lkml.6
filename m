Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492546-2-5292754064128343853
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
    t=1520492545; b=ZosZH9xPxcmyrwLqFxRxheVINFMTyrb+cImvmrHBJlg8Sg6
    rQwQepdZK2qOYXidaG8ZrCft4D9neoU3sTzzTOvdzOl9jfoUqNbQ9T4FmcdwqI4Q
    XHgF64r8+8qh5ePj+cKLrWO2eFx4yvFgP9mCIJF+6yHxnH23XuTr5p8B9gA53fYM
    1GUUrVywo9F/PSeUcpkDuTTpywivivLAN9pBCoYyaA5s/ZcQYlBxH5NVPtmUDZDE
    vWelilw7fHFK0E4UlXfBUwGmgTvh+LQjiDTHZcDtTxTKFfqVH7KpLgFTZfkbQdd7
    PvbzMApbe5wibIjiUbBtrkqM90EZyDcjqE5aZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492545; bh=18kC1x
    wjZcxIeWJjRNajOAQHvF50Hd0RaX9WeHYamLg=; b=wh0u7KMTAoZg2/O0FhhHao
    gPrXnS0zdxT8MYVEvhtUE+m2No2YZ08XF+l2FkFxtuAsYHtVstx7I1b6QJsiC/Uh
    TZQJEbe5kdw+TeZggJD/PA4PxOhv/r7QqiH/GEIdTtz35GiQSkPN4NJaseOYDzFl
    kgTM8FI+JLawPhNsqxqB4vaTWAs6ZsY1UUvNDApagzyJkdQplurNMOriR4ctjUiN
    NHn4K7nUacYFn7R34xZbbX7P7SOWfhVI0CYfw0wZlwCfxowAJnARbZzlSgIGuCL3
    a3O+nijMOXEpR3rwKUN8xQFOrwb/B+7yZ/2KOdplxQc3ZUhxBJTyP9kGhyOqi7oQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FincGkI3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FincGkI3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeCHE5O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:14 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755319AbeCHE5K (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 37/78] sfp: fix EEPROM reading in the case of
 non-SFF8472 SFPs
Thread-Topic: [PATCH AUTOSEL for 4.15 37/78] sfp: fix EEPROM reading in the
 case of non-SFF8472 SFPs
Thread-Index: AQHTtpnLxUCYPEYqDUun+v8H1Z7ZHQ==
Date: Thu, 8 Mar 2018 04:56:17 +0000
Message-ID: <20180308045525.7662-37-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;20:wp5v3ffvnaIv8LRMsrzMhZ3T+aZ9VLcF9Ms3m7CNSPtwcjzdWWpqr7LxXhxYBxvzX72IWzy7S7aSe1RxIW1ufiXJKtLd7y3HZ0sKVEdfH9tRP/7FVc2a0Fqp1kMiJ2ySo+RL3tJPUyOLhV6BCW2NbvbCoX7/W7KkE6DtRE2JcM0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaacceed-847d-43f1-7057-08d584b10999
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10794F8C8C10E7E760E6B425FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JzN1kxAMA7UK8YI4UrGHUs+Q5AaTqqt98PJfOdhPuvWfhKAO9uWv/50TwqVMu1Tb80Ric9qDurSSnv4WSa8f3WMkY7kJ07QSAVMEmy84+IYNZdKcLAWzjAFDL1WgcwK2VbPkrAevY18b5kD93xINxJxvxvLrnaTWXFhdG71+V/zdl4Cnh2/o5nSnM7IWnrU5rmvQ5hbWc+TiPzbQ/ouYN+CNklGUxgJ4sqb4baJEJX3wsJ2eHUSQQeOWaZOP+uwyDBONF1G++D9yQyxs7N/nknJCWDJlKCnPL0xB21LHsdUbdZvrjXy7plTOUecIOQuEJfnyd7B2js7VWjaSAL/SMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaacceed-847d-43f1-7057-08d584b10999
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:17.7863
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

[ Upstream commit 2794ffc441dde3109804085dc745e8014a4de224 ]

The EEPROM reading was trying to read from the second EEPROM address
if we requested the last byte from the SFF8079 EEPROM, which caused a
failure when the second EEPROM is not present.  Discovered with a
S-RJ01 SFP module.  Fix this.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/sfp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9dfc1c4c954f..dec35888c429 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -683,20 +683,19 @@ static int sfp_module_eeprom(struct sfp *sfp, struct =
ethtool_eeprom *ee,
 		len =3D min_t(unsigned int, last, ETH_MODULE_SFF_8079_LEN);
 		len -=3D first;
=20
-		ret =3D sfp->read(sfp, false, first, data, len);
+		ret =3D sfp_read(sfp, false, first, data, len);
 		if (ret < 0)
 			return ret;
=20
 		first +=3D len;
 		data +=3D len;
 	}
-	if (first >=3D ETH_MODULE_SFF_8079_LEN &&
-	    first < ETH_MODULE_SFF_8472_LEN) {
+	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
 		len =3D min_t(unsigned int, last, ETH_MODULE_SFF_8472_LEN);
 		len -=3D first;
 		first -=3D ETH_MODULE_SFF_8079_LEN;
=20
-		ret =3D sfp->read(sfp, true, first, data, len);
+		ret =3D sfp_read(sfp, true, first, data, len);
 		if (ret < 0)
 			return ret;
 	}
--=20
2.14.1
