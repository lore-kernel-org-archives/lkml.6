Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487160-4-18188009360136726968
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
    t=1520487160; b=OfJjUA8HpM6QD3g0t5k2Xk5b7TOOC1vASZr3Ty66bEY9CrL
    B8jYqUiZCwslcrL6iTMtwVhak6xAsCVVi6LY8hkyU7uxzEMNidbTse2O8i0LfZyl
    2kvgqSZaFNk5NF/IprY+rEgfYvm+8HXRgDucxSsAwCqVkhUZLRo19hNlf6uMQgZS
    szWdI2XgzrcR4YQhoxdRfuCklnTRql8w3yNrLmuSthl2oZzmqeYn86TyUfo/oslM
    fExMQFzDbvIfWV0KhSiXxTro2CTkKARpiL8ksDWjHVO4flEZTeoFbsxs3o4IkqNK
    UNQnUbpYsH5sKsXmbmLScFjWjx1tc5+QVth8ZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487160; bh=I+WzG+
    NpsCCnZKjK6YXgWvrAt8wCcMNEIoZC0TfIJak=; b=UUgaCO9wbmpCXE9GOPq8++
    nnUiQyRBWKcG45i/7aMTQNHBK05xXLYMxCR9ZcWhBKHyxN1lQIPWqTdylAYc4Hlz
    udDSmqwsYImEvC75TWQw1ZyhAlM73Kfo2UIhTTMWDnoCTEFM8PzNyy4929W6Pj5y
    9KQ/Asfn2ruHTeLwKgtRYVsE5+SZYdKVPY0eRdcuoBpxnYPMU8HuaCx1FeoZLpba
    kRbuMxWjqxyfmTED/8PmzYYqdin+yh88r6yeOrr2X6eV8ZHdlZVamxNF9JNwPYsX
    E6LsdnVYbx0X4MwNw1ntOUJTUlIsmaYqCmIbAuwsfiGjKbWotIs51Lw57MCLZr8A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EBVCHf0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EBVCHf0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965994AbeCHFcZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:32:25 -0500
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:18336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965954AbeCHFGT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 056/101] mfd: palmas: Reset the POWERHOLD mux
 during power off
Thread-Topic: [PATCH AUTOSEL for 4.4 056/101] mfd: palmas: Reset the POWERHOLD
 mux during power off
Thread-Index: AQHTtpqUzMmN3WIZUkuzOid5EjTtvA==
Date: Thu, 8 Mar 2018 05:01:55 +0000
Message-ID: <20180308050023.8548-56-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:stiIWPxLcY7uE9UcoTXSWc1kXitaQ9RDCL+iRFVy+YRJQxT42BCJ2vAktlckjMMuJ1F6RlephyYI6/txpSI5ovADlX1dbxlBf7n34o3Uop+kdNKqJ7NvkF3oD8lK1I7ei926U2P4885op2huGxmRANDBickxOEMskcucqlQhPCdbxHc8xfxkRdJM+tUOEkxuwUlp2kyr/N/QU30IBL2TEPObrc0owXaRJZSmdPCETkgnfjstXvDyiq4rhx4UFRh+;20:DFAEAOHQN8cx6kuJukEfgp0pC0Go4Jg5xPI3S0DOFTDH90eKHT6IK1y7/lEgB3j5iJ8lov0niFtGfssS8dulrQOMhT+QAOyQeXoFriRNmliDWgPyJi2r1jeUk4oHXjhSQQ3Of8ElCExjaD1wFvmC94DXhmZv0Y7qE56TuhEYplo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea750d96-aad2-4df5-bdaa-08d584b2513b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09178AC4D40D1FBC4D3869EDFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2A3XFLDZu/gvGoCbT63lmi7Uo5bdbafjNZVl+Tp+HhBGcYZCMW/NRl7+43iv/eDn+rfa/qfgAiPyL/ah9SNUxm3RRoQ+8xNnXCyHkwFUh4RL8WKZXQscP4b2SggTENF7h+rAvQnfeYjLE5TSST8SkGb6/QZlPUozWM2Kig5nQTknbMCoPAJwj/nf5jzn0W0k09YBe36NVMOekbvX7g07d5J0ASuxXjaS/GNT1qxRzvA5jLel9XtIIkIvPzzsax2R/tM16PlIR0KUROsw5NxefhgCdzhFJesCkgOReGbHhXampPEOn368w5sGgfWvBE7VFLe3uXhos1mcf+tyiAMMUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea750d96-aad2-4df5-bdaa-08d584b2513b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:55.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]

POWERHOLD signal has higher priority  over the DEV_ON bit.
So power off will not happen if the POWERHOLD is held high.
Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
and the DEV_ON bit to take effect to power off the PMIC.

PMIC Power off happens in dire situations like thermal shutdown
so irrespective of the POWERHOLD setting go ahead and turn off
the powerhold.  Currently poweroff is broken on boards that have
powerhold enabled. This fixes poweroff on those boards.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/palmas.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8f8bacb67a15..a6b5259ffbdd 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,20 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	struct device_node *np =3D palmas_dev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
+		addr =3D PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
+					  PALMAS_PRIMARY_SECONDARY_PAD2);
+		slave =3D PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
+
+		ret =3D regmap_update_bits(palmas_dev->regmap[slave], addr,
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+		if (ret)
+			dev_err(palmas_dev->dev,
+				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
+				ret);
+	}
=20
 	if (!palmas_dev)
 		return;
--=20
2.14.1
