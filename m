Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119215-2-165952059733221711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119215; b=E/HMQhIf2MFrHPBVOoFnPj790mrusH1Yo8Zb06uwtb0Dhf+
    AaJuHiEjHgQWs4fqmuT4ErDVOsUTVIk/DxJs6BsDJnj8yJXxXihvGe+soV3RQtVl
    a/ytrkqThIAdH2W8vKmm3V3DJ6gV2sQI2xDHJp5V9l5v38YTPMHiqCVjTk6TQOgW
    5fXNLjr5FxgKhHqGK+t+10xmXxHF3L1uzh+XpNZxWZ5QNRZ8c4OuhcaST/5tuDeO
    ow8h2RN7ctRvUXz8/+aBbRMvNTkUBWoZrxGTzET0cuacMZag7x/AJvVve0Xlzj+z
    lLkgIHpE/uTmTFuhQoH14X3wqqA6k8FTbASavkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119215; bh=SstVxv
    Eti8z4//GCdB9qo/uxHIzg7ps+8I62c6fhkZg=; b=hISg5OGo1CWEuz5fSMODmr
    qSZJCNqEq4Byk8ic71WUOrARw4NcXO6jBrxNyHdypxZFYGwQeAtHdsUbsBHvb640
    gXooOsElz0G0E3xys/Ec7iX5YU/LtCNXA3sbGhIJeYLMEJLn9G9dOKXhiTKpt9/0
    51ObhqV49WlxwSJOUcSaCq3BGxquq8+gT4tPt4EM0VbJVhTtSspwCQZ/+0fGfc4C
    hiKJXd3FziPCa1b00yHHnVxEktZJdFC2UpLIgCG3p4Bm7o4j50/j6GX8eH2Q3AyD
    k7NPxBOObVoNqHXkSyMEDg+pssoq9O1U/x66drqzxzmphvr9zKNgM4O50tEEkdvg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JG8unUd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JG8unUd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeCCXT5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:19:57 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:21314
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934817AbeCCWiC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aaron Salter - Intel <aaron.k.salter@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 012/115] i40e: Acquire NVM lock before reads
 on all devices
Thread-Topic: [PATCH AUTOSEL for 4.4 012/115] i40e: Acquire NVM lock before
 reads on all devices
Thread-Index: AQHTsz9KlCc4X0Q3aE+n79vQvVkotA==
Date: Sat, 3 Mar 2018 22:30:54 +0000
Message-ID: <20180303223010.27106-12-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:syYFLWQ8Kr9EG//vUMc+supug2XfGFUhmCgc0tL4mMA9dW+jUf7xZJro1haysGkzK5hupJLbqr7RfDiQe7gusLQpT10LTkT0myp3mum8TSfWTZOg1uRHdWdhdaHUZcwB+HyyumtSvl1eb6d6nHRYh37HjYxgUc1XqbwlvfNQn334hAJm7Shf5Mx5TSinWh3GpMu+oFHn1AV6qIRysD32yvQSEeUflHopomW6G5YP2mwVqJQUhZuj95ZWX8O1eb9d
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ab82903-ed4f-4c82-1995-08d581576a51
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0938CC3D8BF386D8AA1206B7FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: F/p6xSuZnEjXvJU/hqhuYmezWDke+5cSKDCRperM7etIhTJGYwwRcfVCk6jHvSLwrQtMDeJ6MRpU7MtIR48GY0zuGz6XVz8cxItc9hdHzpWSNPJc3YXmZABuSNKZyrUutvFSK1jDrbokTk6SwvWtzvzTjTEEYAW1UJYm4D0ws9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab82903-ed4f-4c82-1995-08d581576a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:54.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
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
index 6100cdd9ad13..dd4e6ea9e0e1 100644
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
