Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242042-2-8056040066951286675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242041; b=JpEQ3OIMP2KqX3G3nXKUackkCqC8ccauBgVrNMkbz/IHx6/GeB
    1QvN/jQ9It47z2fyf1jaLschdslygxxShw3fKK3Hsd8V7tyWet240GPBpDCtdV0y
    P7c0sQkqo98sJRALD6t7jtFtsu9szEKIvPt981D4dTxK8DfkA5fxPCnDTvOPxwn3
    rEYgYzz7BPe8XJ6ejR2iCyDbQUvNnp40SicBzTAtjOqKqOSsZb/F0deK+kpYb8VQ
    56UrMWRcBOhhdkv4UlgUI9GTp+xBV208yTTgKaAZ/ucqp/x8ikXGSAmAmDKE2lwp
    DUZ2AbTy7f+PaR9BSrTg7AmlfiDMRZPwRbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242041; bh=NUJK3M8cK9
    izr1h/vD2POeZ53Ft8Bz+Q6Pe6RfDNbDY=; b=YpRIsSX+I4pAQvHc5pLHaXZGX4
    +Q9VYzYLEYy/LiWmNxp+P1TwpFUbYc580RYmuROYfXZm3U+kWrESrhUmzt9JVJwi
    PRgF6lUHp5CsvtxtrhAehCNF3qC6GvEoa/+hixnf9bVqzLK6bU6O14Sh+IwVoXOX
    8pZh7yz0U9gmWnRKFpMMrm6pR3ZPwW9XAa/LJQsQF8x5U9GxTqZTtwbwcpoaeHZ2
    UoFn1/7/oXHqow/NHXF7vpYfNCP65x0lNGk8dRD0KwZqmi3rrD5YHjSAwg3KU19Q
    vK57ijstmJ0TNvn5MziHTgrR6Ucjyb0TDLXi8nm6ENcopMu/uVA+MWC2VQMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VKXVftgR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VKXVftgR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN7ujj5bf0wr0TWjtR7uknFYWFE4ZXg85u6aI+WPMSJV93LE7imrOSol7eQCcBKneeMOVvZmcl2JeWcb/nJi7ZllY09CbA4P5hqLLSRIsTqrUpHKw/sw
    kRz9OHQFCplFS2AYObMkoAEB6cBPAH2cEyEZBNWAfY/q2CICBJJdcBjtfS5QQvTcRfWFFMYS7bHiq5aRURQIYPFpvqdsiTVijWcLSPY1F4M4VbBNphuJXQrk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=P1BnusSwAAAA:8 a=JhOpUDsbAAAA:8 a=yMhMjlubAAAA:8
    a=xSunblDM_nCwrVi49GEA:9 a=wPNLvfGTeEIA:10 a=D0XLA9XvdZm18NrgonBM:22
    a=id22BOPz_3nJaf3FINPD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757750AbeDICqf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:35 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755405AbeDIA0l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 010/293] ARM: dts: armadillo800eva: Split LCD
 mux and gpio
Thread-Topic: [PATCH AUTOSEL for 4.9 010/293] ARM: dts: armadillo800eva: Split
 LCD mux and gpio
Thread-Index: AQHTz5jnWTK9wwbZdkKZeCTIPZtDrQ==
Date: Mon, 9 Apr 2018 00:22:55 +0000
Message-ID: <20180409002239.163177-10-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:hjW0mT5sB5whQqCCnS+7ahg7odpQVVe0irwEEiIoiAI7LN5kwmDYGE2Fo+M+aqhzfiPl5u+6N7vdp7BPGXKcl0jidZU2xSFS7d2GBcA5uI2IyEAhRWMr7lulHTIAKKHdzeuDVquogNAbMFLW9CskWNdkGLEybAbZIfiImzHE2sfmFKaTzU9x/DDnTQK4W9NDoM02r4zIT2Gc7kYbCNLv6yxGfAk20ca+MrWeWvD398QygG66PlI/1FzYxOg+99Kb;20:FmxtlTYgCZnVYpY6FODmmziobLywWj6mGVGhghf6xz5hQU8raZQ+ODAlMBC2J3hjp4OCupw0NDwgp89zGL4N/1CzhwF/kApyKf9wHqVjxoD4fkW+ts+TRWN0N+g3gfT2AmHQ7ilCtxVNdv2Zb+eJGc/UJ9+5mwPh+l/AQW/zFeY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e7c8b75-b275-4c2e-0bcd-08d59db08d9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015371BB13B0F7D0DFA2E83FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GCOfzC3s+0k508kpJG0txNQlp98VpR0tGpfJzry8baWDTp82aEhdcHNAfIUzKErUP4UZwAxOlox6nyxrVRKQc1lO0pkx4TIrCyAlIYktGAMZMD2bYOMWtvPurTLFIXeWOLorg3V2qZWy797jvkJlhArpQUvnDq9peeUYM+WMDmMmF1ki41Qif0EeUtYy5aYfHcqBqY7DTn/j4AvNgGovQjnYODu5N2k+JB/fUhvLMI3f9SQ0HzpN6Zh/3K9EvrYYKzUllc+3NSMyV0tsddNUR0zZSs6nMHSl1jk7m1rSsdnK6wtuMhN8kLREht3HbT+eBUfvm9n7+1yKDC/ZHlsViwerCLloD8UoKrnwM4ld1t5gSIGNIQXdCwTnPy1VbAe/3pz5vOID4cu4nZszzYMn8ncGULadaENSfJVqzTjaR6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7c8b75-b275-4c2e-0bcd-08d59db08d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:55.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 13132b3f44d3600983aceb7e9920b8ebb55a7cf8 ]

Configuration of the lcd0 pinmux group and GPIO hog for the external
GPIO mux are done using a single device node, causing the "output-high"
property to be applied to both.  This will fail for the pinmux group,
but doesn't cause any harm, as the failure is ignored silently.

However, after "pinctrl: sh-pfc: propagate errors on group config", the
failure will become fatal, leading to a broken display:

    sh-pfc e6050000.pin-controller: pin_config_group_set op failed for grou=
p 102
    sh-pfc e6050000.pin-controller: Error applying setting, reverse things =
back
    sh-pfc e6050000.pin-controller: failed to select default state

Move the GPIO hog to its own node to fix this.

Fixes: ffd2f9a5afb730b9 ("ARM: shmobile: armadillo800eva dts: Add pinctrl a=
nd gpio-hog for lcdc0")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/=
dts/r8a7740-armadillo800eva.dts
index 7885075428bb..1788e186a512 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -266,7 +266,9 @@
 	lcd0_pins: lcd0 {
 		groups =3D "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
 		function =3D "lcd0";
+	};
=20
+	lcd0_mux {
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
 		gpios =3D <176 0>;
--=20
2.15.1
