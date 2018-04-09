Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233365-2-2818327976295350451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233364; b=qronAjCnzJtB8f2JFnARgsnjvKd1wAyNifd3JNQ4IHYSYnZn4k
    SqhWdlMAXqoV0xP9VWMbh1Y3oQqeu5zd2171RiHLdndF3sXNcjQ57u8ZXrtKWfe2
    fPG4yjRe9WS1yv5zSGcpt/oej9CQOJdkM36RLiBIk0cibtaH9CF2XeBK7Y0esJDI
    NI2n7WbAzLcyEqGYyYvsqw78BA2UAuMe7mvaVRZjex6MoI2IwRm18n5+NdrtUny5
    LnNkmcqyUyBR9oOdpQhR7RF9aeFKa5pUZmfUycznFKG5/OPahpM34fJASJsJHImS
    Qk3KmkSsvFjp34PaV85X3/LEctxy3Z+8jJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233364; bh=1eMbP53AQY
    dSX0Jm5PD3UOWH21KGytsTOBa67eHjOi4=; b=rngoaag6R0JuAKddPjNEce0k8W
    Zz4MhBbRhJDwV4gpNv6lIMGF4Q+Z0cLnUAu9EoRxi/coCwYa4OQewly7Oyenr4T1
    8sO7QX4iyXEoxWTKDHpnlfgVmjo6gEOdhoAu95B61qUk2kFC2pt1j/UxeRHFNOw4
    SYtjJie3XybKFGoMyE6AwM9fMTM+73rOyRe/ZF/CuXx7CqBHCpAMD2aMo8oqGHNI
    FQMeBwnww04gMNZqa/fYec9uRxZrhODVuShau3D0IG61pS0NeNlyUYuGyDa1+8s2
    y3vBTsTiMPI215adL7ZvCtPMh0fOOf9vnbmdtrO3+lYmbOCl9ydRMO/JH+7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vx2vkYsj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vx2vkYsj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOT8ls50czNVvPj4QMhloLZs3x7tLLoGxRAN9BiZklBlRkeVmegqHJuKrKKFPBET1EW2bqY1t79x5qwGhRcXmP8sW/RVxWALYj/dqrQ7N7r86TjpyuNa
    rZm81gJ+2wpwgxfn3rBbCVPH7G/QdHQlBoJ7abxwsg9lEqE4JUe/9Qs4epUS/3CpulSIH90qqq69tEnm8B/UrEogRDX3dOYMRBpp+Wu3V1sMIBGzrUVjzRbh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=D31QgfloAAAA:8 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
    a=yMhMjlubAAAA:8 a=cufhOiw6ZOseUkg5WgAA:9 a=wPNLvfGTeEIA:10
    a=I6paTPn9_Px6ARgSWtWf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeDIAWM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:12 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:31261
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754576AbeDIAWK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 020/161] Input: synaptics - reset the ABS_X/Y
 fuzz after initializing MT axes
Thread-Topic: [PATCH AUTOSEL for 4.14 020/161] Input: synaptics - reset the
 ABS_X/Y fuzz after initializing MT axes
Thread-Index: AQHTz5h9PwrUfvjjukmxz2fY5z2o4Q==
Date: Mon, 9 Apr 2018 00:19:57 +0000
Message-ID: <20180409001936.162706-20-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:6YEn/gleE4K+cq9y4iu4F38Ya1J+8O3ALRl0IYacuOpL+L3CHaiCxIfVYvRttMIcD0KQlR7a+3N/noz/SMjJdWs+zZ06mhXgHVurcBEDN8q2G685N8Agd3CUyv0T0qP8rRSYKYmJNbSriOzTRAqzyfYyMdEL0OssWLMUT4fw7N4Xclf+E3pMUNkJ38m1J07qeJy+/Jj4ScxhR4LS7OygAFbS0/nByj2Sm0q0hCUUgs4AoxzS+GMyDwysz4BEmTMz;20:k3rtAtrylyG6XOI0I71cLGiDNHu6iKSlnHCi377Oj21cSiI/MMRgoh1teXT2+mTby2/BglhMr3ppjjpj8ZwClAJxvvi6wUTrm65IROLErMejAvu/F1ci7u+IlVZUrRpNZL6vbTwEJaKRZDql5lAJuhJ9OQnruOEnQgaOfZi5XRM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a32d4700-03ee-45a4-69c6-08d59dafed95
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096699347B99DE28252AC548FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(39060400002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wnwfxg7wr6B76RINy8k1mijs0I0ypZngry29Gv7BfC8sAkLRYRNnIibF21IhEHFoRMqdtSKT4uvNdq1qoyDyyvQyv2TYUu2lWJuQf1CL5jDKMPDNuByszvepfNAw/QhamWZcq5jks9UGNpTzQxwfe8trMbF+LDAOeEVNY5xXAGefEL/Y0u4n30zp2kxO+wViIonWpVpfUA601n3gJjPvKEkTfYsksH/58yk5ZL8nV8QQhfS6N6NSOZQ7tiDVf6xaEHVYBzdeHT/U45sE6FXU6AfKEKhkG9S833HsrcjeTwqfQL6OTyUtTyNYWbpXGWVjlZwmRzoNalAfIOPX7wwBLF/uaEgfMIMFG2L1TP0dx4dKwrCxXxiMX2nbHsNqngjoh67nC3GbdksBRqCBGUxJ09JmiF2SqsgQe1YhlhZXyZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32d4700-03ee-45a4-69c6-08d59dafed95
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:57.4262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Hutterer <peter.hutterer@who-t.net>

[ Upstream commit 19eb4ed1141bd1096b9bc84ba9c4d03d5830c143 ]

input_mt_init_slots() resets the ABS_X/Y fuzz to 0 and expects the driver
to call input_mt_report_pointer_emulation(). That is based on the MT
position bits which are already defuzzed - hence a fuzz of 0.

In the case of synaptics semi-mt devices, we report the ABS_X/Y axes
manually.  This results in the MT position being defuzzed but the
single-touch emulation missing that defuzzing.

Work around this by re-initializing the ABS_X/Y axes after the MT axis to
get the same fuzz value back.

https://bugs.freedesktop.org/show_bug.cgi?id=3D104533

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/synaptics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptic=
s.c
index ee5466a374bf..a246fc686bb7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1280,6 +1280,16 @@ static void set_input_params(struct psmouse *psmouse=
,
 				    INPUT_MT_POINTER |
 				    (cr48_profile_sensor ?
 					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
+
+		/*
+		 * For semi-mt devices we send ABS_X/Y ourselves instead of
+		 * input_mt_report_pointer_emulation. But
+		 * input_mt_init_slots() resets the fuzz to 0, leading to a
+		 * filtered ABS_MT_POSITION_X but an unfiltered ABS_X
+		 * position. Let's re-initialize ABS_X/Y here.
+		 */
+		if (!cr48_profile_sensor)
+			set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
 	}
=20
 	if (SYN_CAP_PALMDETECT(info->capabilities))
--=20
2.15.1
