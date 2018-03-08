Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487988-2-3279082185978402762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487987; b=m1Ic5OnSnLYsufMpIcVlli6Zh2vPyTV04kIrZbrYConAxzS
    /EKbrX95UUfuL3a0/aUF1HkKixenAIhrvVoIk8RyIqc/SW8OsZ5XTrh3CGki/SxV
    eH9SpsbA6SFAPsSWKh03X9CtKCzUI3kBKtHsejDY2R3zi36dBnSePzWx19HKH0Sf
    nY9nBHMoVzQKumvweq0c6LlaLQ695Ms9ubtbG9UUoeSbmCbSweSL1bvncyxtbLHH
    G/mfJdr5NNPHQxstkJ672FETw8jLfO4IspT/XZSYSE3VYXe6BsL+nwFVk22TTfia
    oNhDBFmz014ot3XJw6txIKXW5ok8NdWsR84ugjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487987; bh=pgJ3Mm
    q+PLEQRcyQaoYF03toWQB6L3DaiA3xh8TeGtQ=; b=CbUe2AAY6fizz04isUkyWx
    orjiHHK0A+/NrgpzheiorcQD9aRLAruXUwVrQ9mfGBcj9DPCIoRla1gGQrBgNUtg
    7UvM9bJ1UqSNV2iSVkhlumDWKw6ooMD/an8chIYNuRPPB8uXDCectlYCAoLFL3Uc
    zwYdNg/OJeU2C9c2J8PAUv65zCpD8akrl/1tusIb5IYwXWzZEScvuRbS22o4oG8T
    1hG/0Ey5zTB9E9GMdCEorG+t/ObdNyjtBnaH1YVxbRhV76oaKYabq8dCVrBFU3wy
    v+xRH/RwMcSSM1qHvmn99qm2ZZOMuUIq3qforR5WZhENIrA10dHT4avMTqKePgww
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Li/40aiY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Li/40aiY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeCHFqA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:46:00 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:10302
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966110AbeCHFFK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Santeri Toivonen <santeri.toivonen@vatsul.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 011/101] platform/x86: asus-nb-wmi: Add wapf4
 quirk for the X302UA
Thread-Topic: [PATCH AUTOSEL for 4.4 011/101] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Index: AQHTtpp7PZIvhNJ3okelHj1KGHDilA==
Date: Thu, 8 Mar 2018 05:01:13 +0000
Message-ID: <20180308050023.8548-11-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:pxBcsznYNzBKJCSS60ltK2ibo14C6fGXHoOWGtCDdGwcT3rNphHyin9BNXkYLs6v1r8Dtfs/ijqT8GbFjCW38QzIzjMTzpY4oA2nA9Mp53cfkIJ17L++Eda9PZdZOpx0SL1Vpm1cYTnBisd27idbTVHxE+MCWM3TO8JE9UWeSuuN2mRikrmYQfio68+q8RV4eoMFutmZG1u/ZJPpPAPClLt6gky5zaVBACPoPvSQxrbLEdkPy/sLxbVn41ftcUbv;20:OZ2viyCpIdWyR1+WSc50+94ok5lpRGPBAuiFXXYXbXfdUwum/PlmWh/F7a0zmjFilqRzMkvnLd4ksHQyUaIWjIdebbpVF1i2Oud+ls6HQUb4zvOPwPUB4gDLFKoQjpKNmoadHo+Ke4qQlc5q66WlGUiQgeUfMYhtSaxoCOCMV0Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4decff94-2ee1-44b3-d52e-08d584b229a8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072761883D8B0E23E0DF98D6FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uPc4DrphKdpvv2SDycmEHBvvn9qmYSTjt2cIqtr2CuTVMZuzpD1N61+T8w1l1Gko+bBPtQxb/+Sv8ujFjjNbGbXuIWwRrGsf/3fyLqaIepmxMAHOagC1rOhBZQiSCwaMqtpd1I5p19s9C7ob45bZS1Bxt7Parf2h85G7rmAbXNeYVud8uPiNDETYcqA24h0tfdk/+Ik+waDWF2lWAxfaw/CEv4iRtlK7CfS+iUEZxkgAHAdy55dOqVEh0eBke1gZhfx6PH8hF5M21sbZ4fIoOQN7S98BqcmHm1Kx1xUY1HD7ePFkJD+2HP7SICR1pGbC6tX2zZwdBtuuP+HjlWJlMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4decff94-2ee1-44b3-d52e-08d584b229a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:13.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Santeri Toivonen <santeri.toivonen@vatsul.com>

[ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]

Asus laptop X302UA starts up with Wi-Fi disabled,
without a way to enable it. Set wapf=3D4 to fix the problem.

Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus=
-nb-wmi.c
index a3661cc44f86..0e0403e024c5 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -99,6 +99,15 @@ static const struct dmi_system_id asus_quirks[] =3D {
 		 */
 		.driver_data =3D &quirk_asus_wapf4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "ASUSTeK COMPUTER INC. X302UA",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X302UA"),
+		},
+		.driver_data =3D &quirk_asus_wapf4,
+	},
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "ASUSTeK COMPUTER INC. X401U",
--=20
2.14.1
