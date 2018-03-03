Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116295-2-3603207424466039589
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
    t=1520116295; b=kCT+3pviHZCyFVEOPBdwgm7L7FkydTkTROtWhDqosnotqeT
    7RkRcFwzzzHpMMW4Ig4n3PgORGgAeE/rresJLgYJgxiyVC4Zr2PdaUiBSVE9nPIX
    bW6PvfjJs5MIA/J3FILZ1wMydjJNwvfruQcBhE0WZ5W0VU+jq/folNSLaNUmIT5u
    OVPfzkG/QyWkY7uM89jhOPGYKQ09ZBXiZtrQ3QEdfjDevKB8M033xdJK2Xl6T3Qh
    32yWQiDZQ+JW/GjToe6Qd9yoMa3qqHjVXFm4+JR+TxbIDFGrcUcCkRHY0+eOSxcr
    Z7AVg31xhg5Pbx63u440H6Ddj3C48rPxTHpOk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116295; bh=TWdCke
    Ecquk68weq5oHCEP9tko3SwJ9PA8rjPea8u/I=; b=OaBTAahaq9ZCUUvV5HEBCM
    31csPhv9G06cYjE87R4/6HJr/WJbAMAQDXNIB0CcyJ5ECCKf3OUAP/TlD40CzADE
    kt8HulSNkjmVQgOv+18Hw62XyAi+TRkDLkldjKru+J43NEQKDhNDm38kUHSScnbt
    nVqxqjibWI2iHg0lZ1UWjJVi4SlFp66Bm7tPhKPD1Ak9deqXSx2KEU8AD+hxC2CV
    qq98aIdiBsMbHalbXZU/aVHhZs3HAgk/FwG/xDOSnvj7CmmYuptZn2+WTkTT2XnR
    4IgvsHT6DVWMRx7h6lM0J8m0NbU+/5wIeibpOHbmMXC5baMCa+Hzueg+/8f2Im0g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RTTT5TNO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RTTT5TNO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeCCWbb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:31 -0500
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:49722
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933355AbeCCWb1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aaron Salter - Intel <aaron.k.salter@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 026/219] i40e: Acquire NVM lock before reads
 on all devices
Thread-Topic: [PATCH AUTOSEL for 4.9 026/219] i40e: Acquire NVM lock before
 reads on all devices
Thread-Index: AQHTsz7pgVWUQi4QVkWaST+a/IO6UQ==
Date: Sat, 3 Mar 2018 22:28:10 +0000
Message-ID: <20180303222716.26640-26-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:sSR0zw6nxJ7TJZObdaa6RkUtWCYDMDDKWJLcw1Pre9b+GQYJOeuxzpWElCDzVGNxKF1dD3KnlMJTzbUqZPp83MHDWUm8tsA5vwdBRpCAAph+LObPRZkyuKs2crLXlagERnzSlAdRpATZp0Q2QpOfAMCr5Q6eOf2iwm5qAU/9vthbLZ780J2pyMWS7KxBcmxdrMRzuamLFi8C8MAUrpKWSgQSW4LCCrIYwOkNwgEiycZ7dksxPek5WhMk6v8FwcAf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58b1dc86-7a69-4725-9842-08d581567cef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB097030967CDC83899E4E5672FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /X5/Tts30AkgRmcdFU4ML8M5EVkQhAqUSUJ8A7GpKw5jKU23Fi4MAcbOoVNK+xXFpBQH/egG37mLyKPCnFYhYEJCSr64ureH2NAT9jfA3aBws3e/Q/9hMB23b6P6NVEsEWVAxYab/PGcBRRmDCNoqpfag7mAhdMovdohzyZfuts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b1dc86-7a69-4725-9842-08d581567cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:10.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Aaron Salter <aaron.k.salter@intel.com>

[ Upstream commit 96a39aed25e6559b160786117df124084feb9080 ]

Acquire NVM lock before reads on all devices.  Previously, locks were
only used for X722 and later.  Fixes an issue where simultaneous X710
NVM accesses were interfering with each other.

Change-ID: If570bb7acf958cef58725ec2a2011cead6f80638
Signed-off-by: Aaron Salter <aaron.k.salter@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ether=
net/intel/i40e/i40e_nvm.c
index 954efe3118db..abe290bfc638 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -292,14 +292,14 @@ i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u1=
6 offset,
 {
 	enum i40e_status_code ret_code =3D 0;
=20
-	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
-		ret_code =3D i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!ret_code) {
+	ret_code =3D i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+	if (!ret_code) {
+		if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
 			ret_code =3D i40e_read_nvm_word_aq(hw, offset, data);
-			i40e_release_nvm(hw);
+		} else {
+			ret_code =3D i40e_read_nvm_word_srctl(hw, offset, data);
 		}
-	} else {
-		ret_code =3D i40e_read_nvm_word_srctl(hw, offset, data);
+		i40e_release_nvm(hw);
 	}
 	return ret_code;
 }
--=20
2.14.1
