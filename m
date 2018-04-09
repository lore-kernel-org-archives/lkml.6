Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240339-2-12234497575932851675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240339; b=t9WxIVqWlbLlhEvgwVdEvoPPX80ROaUEXXoCk/gH8oOWS585+j
    3A5wYWupzQQuYor5c2yj6eKBfx8rvk+eIyDyewtlqYaxGvuulIgicOvKUYJts2KW
    r/rHy6fXl+Kc5QNR/WJ/eOWlthctS2ikFvc7Rd88StjVuOmREaA1ryQYuXPhN3pY
    DUHB03CcAgzOKzZ460Wa8dB87FcedNGSs5jVTp6J5vK2qmLO9xOdRazb5xVc7mUy
    aIXfsFbFyH4iQSA2kdvf25s125+v8vAr9omVRg3UtyU1zwdSlHY255Xtc0zioCVF
    IzXv2dN+NXR9QMLtlsGIdxM20RXZeBOrO5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240339; bh=Inzuz8hy00
    JFm9WuPGVt5kOXNEMoQRZQ5PCzz9dT59E=; b=Rd1g3d1JY4DqbCXyq50Sn9AQ5P
    Qu+2IoI2ZpXA0zWvGHhxA9k5YNkXQwasQshZGV2AE0NPA07X+U1ofLbuEZV7d0Cv
    do/iHT5Vd86L4kUsMgtPi/t/BpHWLi4xJ9rn81qr9eGOURewq4zDyZjS4RWOLp2W
    TlxA7BgNcJXi9JsbJii/vqFbG2zJ2RcO7aJ5DZNslQ8kmUEKjck3ekvRqv/ehSi/
    L8s3T/vvUvj4r5Al/5+mGuRFJwR5gW5FFtdhSA/3DKnj6XDlbko8wyrSEXay96eo
    s4AuOM0T6ECxTAag1/oUYOFQmVR/A/xN4XJaa4nBo59LYE60CxnfIr1UXAlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d2d9Yf/1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d2d9Yf/1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFzKF/sutErRRJ6MQDc4KiJ24MqaoVlYeII5/zMvUKW6rvefaEm3R3/Z3r+TcLPFAM7q3Z9NClu3GCzyZgxN0mrq3/7LIA0BbVckO++2rydnEWSWn3z3
    dtvffIn3ZHogtUPwMFhbMa/k/tFTooC6Yh0Dzfy9mbrkCvJHJQL5jdflV05v+vLi1LU/ZYb9mP7f/luzfepAZp54c/m/ihonXiejGly5oPAfInpYqeQqWYf0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=BYuelhEgyneZgELvxykA:9 a=VloQPsgkfDE4XMa2:21
    a=wGu57TMcnFdlWum5:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbeDICSg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:18:36 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755798AbeDIAaY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 130/293] clk: samsung: audss: Fix silent hang
 on Exynos4412 due to disabled EPLL
Thread-Topic: [PATCH AUTOSEL for 4.9 130/293] clk: samsung: audss: Fix silent
 hang on Exynos4412 due to disabled EPLL
Thread-Index: AQHTz5ki8dOB2B54dk67OSdDDtGWPw==
Date: Mon, 9 Apr 2018 00:24:34 +0000
Message-ID: <20180409002239.163177-130-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:I9CxN9k2bD2ERyS55oH0nTdCaCs4ECJUhUP6THxVd68tyiFXjaXV6dtXdab3EEASY3y/SIpsOErA/Ckh7iMmE4NIy1laDVS6up0f8XJYffKR7k+hM27TsjUAUDVeM08shAspUP/Ltm6696ib5xcaOrKHQrTsSt860p8kLSBDNDk0F2XqAjnQu9UtCWoNn7Me+ntqmIjfcbC7lhdHnCTCfzLzmDJftKU0UUc++Zefgu90IECyx+EWpLtArg12wHBh;20:uExVGvllepcpS5S1XkF/UTpezXtpC7rlewrzgdkXNKT0+50pp+WpsXQJJRBqZJ6T8JpFowojizMu5bTUldW3dAz7W02UHHZyngz6fIKwDMvo245GEMnk3M35OJAmg0+36RYV9Pp4b5+MRwv5y8/h1kHEqdyLTTOM1gGEOc0AEz8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9c2db6e-e544-4352-0219-08d59db11292
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103255EA162C07D7C232A6E5FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(377424004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LKq9o3qwicc6+Vk3mSkaHLX7YEQKAKfl2ZKFG2egnYiE1HvG1BwW4sLGzVTrjkkJrT19B/W8D6HzXq7Ez5WiJ3vcjZd1UK6eNmvBm4RdtztL26MtuVbXgZdQvVA7AuvdIfz/omyA896U44HHmmFMI1YV6sQJ4I/xA8IgaMhlGT3Lw2dB/DLECujg0/miPNHP32C81BpsZ3dMQm1zsqfXVQqY9IsDMIEqGy9yoP9DXImz3fTeH/XrNtKaX+cYL/Nm1dSTKoyUXMjyxHWJspyFMLIGNxLSn5y1fWGqoAXUqnUh0pjYWW7nzXRXP6Mu7D+TrmJCaHoIki5j/PLte3zcxNTKSkj8IY7wgy2kJ2Nb01ZzWb+hrF+NAS+YBiAWMGBVgI5pkz4UxHdAWdAOoTLn3ILxNDhFLHWGJhQf9WrqflY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c2db6e-e544-4352-0219-08d59db11292
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:34.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 5bb4053b5993406935cc3b01cbf8b9f1e5803f4c ]

Similarly to commit f1e9203e2366 ("clk: samsung: Fix Exynos 5420 pinctrl
setup and clock disable failure due to domain being gated") for
Exynos5420, the Exynos4412 also requires that EPLL is not disabled.
Otherwise any access to MAUDIO block will silently halt.

This was not visible before because EPLL on Exynos4 could not be
disabled before commit 6edfa11cb396 ("clk: samsung:
Add enable/disable operation for PLL36XX clocks").  After this commit,
on Odroid U3 board one can see silent hang, usually with last (but
unrelated) messages:

	[    2.382741] input: gpio_keys as /devices/platform/gpio_keys/input/input=
0
	[    2.405686] usb 1-3: new high-speed USB device number 3 using exynos-eh=
ci
	[    2.419843] max77686-rtc max77686-rtc: setting system clock to 2017-06-=
21 17:04:13 UTC (1498064653)

Mark Exynos4 variant as also needed EPLL to be enabled all the time.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/samsung/clk-exynos-audss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/c=
lk-exynos-audss.c
index 17e68a724945..f047733f1a61 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -77,6 +77,7 @@ struct exynos_audss_clk_drvdata {
=20
 static const struct exynos_audss_clk_drvdata exynos4210_drvdata =3D {
 	.num_clks	=3D EXYNOS_AUDSS_MAX_CLKS - 1,
+	.enable_epll	=3D 1,
 };
=20
 static const struct exynos_audss_clk_drvdata exynos5410_drvdata =3D {
--=20
2.15.1
