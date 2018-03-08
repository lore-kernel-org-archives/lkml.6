Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486161-2-14379882952160098969
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
    t=1520486160; b=K0z2ddfNDLf9UImqdlQO82wZYTEGaojmMVkptSGyRwfph+F
    iF3qwq63FFCm5wT+kV4BaLYgWf3C2wPgkKP87QxMaQiKJYaLDeBvuckYTUbi76W5
    V2WWVD+SP02osFlgbdXDhl7GXAkYiz0PquZ89ZAIBELddug+1BmzTWSb9o4mCi6c
    P39HKvFEWh0LAaHBme93R4YsQlprvYRjqC/iAYidLJTUbQ2RoK1JMML1Vzs0hCJ4
    MGGL3N3WURtZFjwIsUCS3akco8q1LD9dvNfiPuaN+LbAA2SwkWiH1+Nd6G9lcFkl
    mFlk3BP8Q5us1OVAdxgGjXc82jst5BWGKOFhBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486160; bh=RnOUW6
    w/B1x7IFZxpLIG5jzpIVVTbuID7l2MdkHmzuE=; b=oYHs3aEuGcpGgmzST6JDim
    FG9HN3wxGEB9TeYK1KX362eSMJgmQ5hVAXsDs1h9FvHyriVQOgUNxlg5R8G2OTny
    ROqWWAlzaKogFGERUwW3eYCmWy7CVkvGCtyhfIE3OEPYWuhu6W9bP9DQtv7qjA1M
    XSUpiVVlwG9UHLnVe4uX9WMGV/+a36GwYgeN8V9dk24L7WE5Go+l5xMfOvIYbXIr
    1bBpg9HdT42giMWK25IaVp8hORv283xl2rHPSH/c8aVBq5qQxOBRIgX1cSP3OA7V
    g6ehKHfXJ7R5tftFPMlEh2PgtsYeuxczRy6T+yE1jq+oqFvamt2Wa5E10OgxdxAQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IA+WvP0n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IA+WvP0n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966876AbeCHFLn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:43 -0500
Received: from mail-bn3nam01on0121.outbound.protection.outlook.com ([104.47.33.121]:48048
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966479AbeCHFIv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bernd Faust <berndfaust@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 22/53] e1000e: fix timing for 82579 Gigabit
 Ethernet controller
Thread-Topic: [PATCH AUTOSEL for 3.18 22/53] e1000e: fix timing for 82579
 Gigabit Ethernet controller
Thread-Index: AQHTtprEFS2fiRYOpE+S697aqiKPlA==
Date: Thu, 8 Mar 2018 05:03:16 +0000
Message-ID: <20180308050230.8876-22-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:ZEbxuVHeJKxUfCTjobWr6Z7c+QbLWt+krBvGLqklbxkfXli8bc+9pOwzF/qHw1i64CTjHLnq21uXLuUoMXtcl7QaHyWcK4sdXD/4B7gb4D30b6NkQhfzUKleMarU3DNmSdRcoQsja+c85sJwKQ4mFbDSDHjap5ElmGO3EteUPLbzeoW2zTrpSzpy3V9sDBc5gaGAGuTTy5GwTGpFGF23a1R2DjzziLQDnvQBp6wjKU7VnNjtJPGQSTORM1NLSJBG;20:sRISqxTwF9jR7r3dSxICc/gvwBjRbc2Imp17HDKakek5I4AW6t9rw2EvuIiXB1bxXwoB4gojkv+dZWxTtMVLuAA5KxvHL83NfYUiMHBwMtLgCOUDdaKeuJ13xspkjhjqZMF35aZSu5F6y3qPjkmk+C+UhepF6NdDdpejT2OrgNo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32796cd5-cb76-484c-fdc7-08d584b2accf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087168C78A102617AF3E0A68FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(39060400002)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oom1RJapR21VYKqpslZRuU+vC2O3nZEMf2PeNQcep51i4BT0fm3c+lWfAcDx7PrqbCGRObGqcWNmhFMVkj0Om+2su25sNUS5nVcZbk4GHNP4g1q0pVyqHEKWv//MJpx++k5DWnKF2S0xYAsLweCJlssuFmyZEAOFjAi/Zh9O4+CtGrgz5hGQiWrfjjWO4/uMAmkBsBAHVigMoq23krNjE8YaZZdkpY8gYcFw0TfZKZiPdxuzbSArnBCIMZDjUzBcELfS7RTTESCLtG8re2/Y9ar3Xso1xdk2CQm25CEhJX6X76Ei2BSvGQCG2O5lF4aCDJdY/I0LsLiB33vU+f5EXA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32796cd5-cb76-484c-fdc7-08d584b2accf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:16.4707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bernd Faust <berndfaust@gmail.com>

[ Upstream commit 5313eeccd2d7f486be4e5c7560e3e2be239ec8f7 ]

After an upgrade to Linux kernel v4.x the hardware timestamps of the
82579 Gigabit Ethernet Controller are different than expected.
The values that are being read are almost four times as big as before
the kernel upgrade.

The difference is that after the upgrade the driver sets the clock
frequency to 25MHz, where before the upgrade it was set to 96MHz. Intel
confirmed that the correct frequency for this network adapter is 96MHz.

Signed-off-by: Bernd Faust <berndfaust@gmail.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index 081dad4e0178..3df8366a8356 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3507,6 +3507,12 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *ad=
apter, u32 *timinca)
=20
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		/* Stable 96MHz frequency */
+		incperiod =3D INCPERIOD_96MHz;
+		incvalue =3D INCVALUE_96MHz;
+		shift =3D INCVALUE_SHIFT_96MHz;
+		adapter->cc.shift =3D shift + INCPERIOD_SHIFT_96MHz;
+		break;
 	case e1000_pch_lpt:
 		/* On I217, the clock frequency is 25MHz or 96MHz as
 		 * indicated by the System Clock Frequency Indication
--=20
2.14.1
