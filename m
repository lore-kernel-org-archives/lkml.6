Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119193-2-7645092088682640760
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
    t=1520119192; b=AHWPIadHw1nraUr5P0W94TRzAP2lHeoQ+AQw/5g1FR1iFOX
    UHuA1htepXAeXbd21t2vyqjCYICOdtlKRQ7yrMCzDwyK9ka9AIzYQ0+sVCmI2ZCn
    a3YGST29u80xOCja4031WE5BIqVMNz/sGdVYWOgzd03ZI09vI1mm79bD4NupAl1O
    RV/3g6icrzBkegH0iC7e5vh2CBhVoSU77/iIV4TY0WwSzcj/a0Fh2m2VAUn2tISK
    umO1xrAHZZVW0RJpQYJBAq4HmwhUJliDYn3moIzpZZCIWXP82Hqx6FSHrK7du3IZ
    3d/I5E8z9BkEiSKdA0YuN5UVSaEhtjN5lsTxMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119192; bh=jTj/8C
    xYhc9GAsQ+cGI7IO0twC6xw/GJDx433LAKyik=; b=wcgJ9H/RaukXKH4S+rO0MY
    0hq+euvVZPCZxDmONrfhMcwF6O7hW6RlIcfwp3fWEHpjMOgdTqyQn0PgIEN7JrJP
    KsAcghsn6A1IXr4MnwkjR0zkePI+ehzwUmnRmCGx+rPNuA6bn45PpW7LI73TIdNy
    sfP25wCEIC3Cj3GN1E/ns9T3Hm8tCLZCo/If7S77LP35eH6vChFu4dbzrv1rW7nM
    9X69zXTzR64FChi84NeD3TqD4pQx+7T/VFrO94C4CFfQUaG3Q+gOsh/hWLIAp8pM
    BfC7nZppS8Wtr5khbFesKolWQIlCLaAK0FaD1pwCCP4aXDYSWtN4B9PrMZc5v1eg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDKnVrsp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDKnVrsp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCCXTd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:19:33 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:21314
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934420AbeCCWiD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lihong Yang <lihong.yang@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 013/115] i40e: fix ethtool to get EEPROM data
 from X722 interface
Thread-Topic: [PATCH AUTOSEL for 4.4 013/115] i40e: fix ethtool to get EEPROM
 data from X722 interface
Thread-Index: AQHTsz9L3ewlARzRn0yiXGxLewcpTw==
Date: Sat, 3 Mar 2018 22:30:54 +0000
Message-ID: <20180303223010.27106-13-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:1BZbGn17swSKdo+OlF5yDn2xMNyOIB/NmIxZH6jCTjyWK/OyURl+xZBmQzQ8pWlTjcbE14nKvegGmoW3HfIEqYCjZiXrkOgBncGote28N+xuaa6pNszJCUGjCDlZRIkYnWxjJx2Ih1ktnXcawz8xr4Jj04kO97ar9zEDbDmaqKs8QiERdQdEwT2ld1l+oVQDRC7JcVBm2GOjroBoXMIEUNsmGkOcwUKOSMUgJa4Eufr30T+POqm6xCGCssfJG9mBFiBnI/5NhYupRYXaGWUKFGU8tRHDqXUCjV3pjHeCaCKuUa2zFlkKSo4GcfRWDDHhqkEUasfvSrNJN2LLhWYftT0b6X3iFsC1QhARxEwIwCHPaMKeMXbG4O0wlDmRPffQ;5:CojZlBkefQptoTNKDs38mpJstEy+N7Jik/KYRqLLpZYBn8k3cMHk7AjMMol9d1+OVodPhmngyYD0eXmJqBKLI9JtpdCU5ZTyG1EtsiU7/x8cEB4TYpJIdohDzYjHgri5SS4dR/XXILvSkcPHjhtZTXD5WwX5ThE7V4Or7jPr5ds=;24:o34vyM31auPeymfrI3HA73/9OJc/qX/EeHOT6RJcCAr7OdpYuJpAJtypNngoAFmJEn+RMimHhiSUC5HDl2rh5QhSvEJkpWuBLRx3erd/NKU=;7:Y5++uKBGfuXYDYyYRB84S68VLPHqN3pydOd3ZniTtewSJQvXoKp3C+anZtva+LyOUbRIizPz40s6oNK7rg2N5RKIczIjErD8jKPB1mvl+PDC31eRRcKIdJtgoWiUHaY//ApXIkNHkyNdbleAmT8de5nrsWLMinTHYVn5kT+Eqj9XitfAsWYfBthKmJndQqUMoDm97GPen4vREq+TiQy2mKPuG90GHBudmPljKdo6hTMm0W9KG5VAsqNr4Wx/5RrB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 767e28fd-04ad-44d0-c77a-08d581576a9f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09383D8FAE3BD72B8FD13593FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HfnXmwyjxjjfBTMTvLUjN+3Omfk2ce9ItvpRcZpgjoFr47uAxjiOuaFTXPaYQctQqORpMYNm2iYu9NpRhqBSOgY1aMSUnm2TxiKXi3RtEqEg4YTdLyXIsQvTpUhNz8/SY8DMF2E4iOT0WqpcGW94ZytA+8qRM9GWSP8Yefq+6M8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767e28fd-04ad-44d0-c77a-08d581576a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:54.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lihong Yang <lihong.yang@intel.com>

[ Upstream commit c271dd6c391b535226cf1a81aaad9f33cb5899d3 ]

Currently ethtool -e will error out with a X722 interface
as its EEPROM has a scope limit at offset 0x5B9FFF.
This patch fixes the issue by setting the EEPROM length to
the scope limit to avoid NVM read failure beyond that.

Change-ID: I0b7d4dd6c7f2a57cace438af5dffa0f44c229372
Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/e=
thernet/intel/i40e/i40e_ethtool.c
index 488a50d59dca..3da1f206ff84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1073,6 +1073,11 @@ static int i40e_get_eeprom_len(struct net_device *ne=
tdev)
 	struct i40e_hw *hw =3D &np->vsi->back->hw;
 	u32 val;
=20
+#define X722_EEPROM_SCOPE_LIMIT 0x5B9FFF
+	if (hw->mac.type =3D=3D I40E_MAC_X722) {
+		val =3D X722_EEPROM_SCOPE_LIMIT + 1;
+		return val;
+	}
 	val =3D (rd32(hw, I40E_GLPCI_LBARCTRL)
 		& I40E_GLPCI_LBARCTRL_FL_SIZE_MASK)
 		>> I40E_GLPCI_LBARCTRL_FL_SIZE_SHIFT;
--=20
2.14.1
