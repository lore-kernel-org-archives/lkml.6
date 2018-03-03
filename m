Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121826-2-13753539370744824045
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
    t=1520121825; b=Dx75EAJfda5OB3KOw+/5/m8O+P0meT0lF74zHH5d3Luhlt3
    8yzBKGa7nvM8whH5gYLd/qwoXXG4vcPaNFz0AXG3sT1jgc/q8wto92UepbX5uTbE
    GB25e0W/34o+Lh2ts3Ty0fWVa7i3GSsQ9s350sc+Z5qYLRFUjCbMRuSoivbCOVd0
    tOkerXnEEEhDadIGfMmEGmFY+CRyFgIBnn0tu1eg7gqPK1mJ1wkIwzTD6p4Np0EP
    hucAbbRtEDGDlD2GUnwo/YIR+NzlTriBGI8Brzg0zvlG51sZQu1ZmGbQ1oKJ6T4i
    4rsznyijMFNAkw+hWDOJeZK5DQOfnV54wQVTU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121825; bh=hzYmEz
    ltv//DmIOhVPCutTOIAbbHTYb8QTRU7AyFgxs=; b=PM1p0erzVXgsedUKKqwGAf
    6n0EUhdBYWxP/stJZFgg5GBFNZcjfovdbzjYH8fL8yMjWu7AhGZbFRIIMHHUMjS3
    qfVvp//jxGKwXegVFPx+RPwtsrSC9valkuU8XDl8cckB0U9VersWaJG/ngGRvpR5
    vXlbX6dufsaAMpcpFbN+6LJV7Q/FGg8IKpFtqScOHM6zcKiNDgUKpYtQYnFuuwm/
    /Iey+vpN0msf/m3ryTx30cGljEoafqLBrEpvcsf3KD7DLLbnTYJwxCCtDxjdGyV4
    TVSkF8J+PfVvCZFbAWvxBjZI8EofviIg874L/HSYJRJCiEpOGDOrE+u2GdzJpgcQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=edfwVOsE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=edfwVOsE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeCCWba (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:30 -0500
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:58832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933275AbeCCWb1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lihong Yang <lihong.yang@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 027/219] i40e: fix ethtool to get EEPROM data
 from X722 interface
Thread-Topic: [PATCH AUTOSEL for 4.9 027/219] i40e: fix ethtool to get EEPROM
 data from X722 interface
Thread-Index: AQHTsz7pR2XzxPEpgEqmoQAi3N9piw==
Date: Sat, 3 Mar 2018 22:28:11 +0000
Message-ID: <20180303222716.26640-27-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:gR51n2n+4fkxeCk0gAKnL0h7Lg/CdEoFmMslgbRjtnT/0u+AbhdnuF124Y2h18U46MaQTiSfwhtIradrYbNf/7ixWxBlp854RAb08YNHwKO/F8V3rGiEOvLkLzwosdlgUsXdiJz7FpIw1D0VaprVsp5EPrXuGWYewD2NiPv+Uzdxsh0cgOt8Pvo0K0DV2TCBE7szZ0XBPljHZmZ7Mr2qcPDVe1H2UBfeC6mct7UVLNoBhwwmWqKnvHMlCgiue6kJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81c0eede-c81d-45f4-4487-08d581567d5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097088329706A50AD88AA350FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HbkPaafOfZA2Dr0xAx737eGxntZfFdsb5OToxzaWuzy51xDpmYB55LbbK0ozczvJALkZ9JbfCdFpimlyQVljr3mZHJj5AGEMUcKM6wojUurluzCeFvRFuz+MOS9IdTYa+ouPnAxCkQQKLTJjfRPY3a4RvOjJQ5qd8HSG5dj+IwE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c0eede-c81d-45f4-4487-08d581567d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:11.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 92bc8846f1ba..f4569461dcb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1135,6 +1135,11 @@ static int i40e_get_eeprom_len(struct net_device *ne=
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
