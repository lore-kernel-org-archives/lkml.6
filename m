Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492296-2-16235590174269352411
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
    t=1520492296; b=QBcrgvmQSanrJ1PPPnJU04WXq2O4ITKTRQcJNxl9G44CYhz
    ZopOgKmuxOzpcroXgEBntgf+K2qJ3IcpiBFXFJtcpYJ/eVNsheou1YeVV8V7rzuZ
    6xMO5jufBA1rkjfLdDvKrSBFWOKzZmiC+uLhXviSSCBzW2tw84t6NFzCK7ooAaK9
    U4G1Mwgw/VHd07ZQkp0nq+eCu6KNeMWWoKQZy1S/znk7vXrEPO2APriFTS4y/DQR
    aMujV69Mw3iJmwRgd71Yi45YAQ08RxB0yZgsj6lChhovcJ4TKrLTRyjLG6P0Kw+W
    wiQKpcm4rrotQNU6pQsql+fR9tXy1VBpafh/YsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492296; bh=uN5TA/
    SyZJwMUSQ49Vvyvk5AnrCWSOXaKlbuFaHdkH0=; b=GLGbUMKhlVOg8ypIVQF/+k
    s4wom9UNQM8iJkJIPQMh+YaSG9W9MRwYhbfF7cYu2R1GHGLp5JeLUOFr+hKJzALd
    /pUUOjB/ymXfQFNH5CyaY1s4BY+yYAkHd7qwGprIuTEAVJ78eYrWzqzMCbeAgYpY
    W1lHCLMNlpicwnlf7j+vKS32ngnnARBCPIWjBPK50s/R2hBsrWNsPUu3Rn/6fdc+
    47Qyv4wKnDKHRKrM7qhBrm+zq3VC+7GTVU6QumB6IwKCATmi0LcZiMHuBSwkKkG7
    qd4/6sIHz2//h22OH5UaW117AnHaFnxJ3YNTPu9AamdI9786DUx1+m/nEE2gjgPg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l/ls2EkH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l/ls2EkH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965003AbeCHG6C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:58:02 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:9666
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935053AbeCHE50 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 59/78] clk: use round rate to bail out early
 in set_rate
Thread-Topic: [PATCH AUTOSEL for 4.15 59/78] clk: use round rate to bail out
 early in set_rate
Thread-Index: AQHTtpnQSzrgscDpe0KxX935nC77iA==
Date: Thu, 8 Mar 2018 04:56:27 +0000
Message-ID: <20180308045525.7662-59-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:q/VXbi1zbX5tce0mdXdciqeGYOjcrEhHXOTfV5NZkeWtQcVpzYnut/9B9hlciRJuGZjpeWvsQkUsYqO9un+rDXHQ/OTLSF6R47MZkoEXbClh3GazUxH73q+1lSOyGR08WfNVIRTb1AUMVexMeTEvJxfRbrbt8EFEWdLQNoibb2JrPjBIxYCnlaI9NrExbOiLsBocHdGURuGSIO6tLXOYIQZsefH1vPYP/T1kxiVQV3yNdy8btT1wEjpXkNRofcWc;20:wmUJWK/w0pgIcH6tLw653nwdKXWKjZkPMgXTZoxRq2hEflouHvIVg/YQ/XLmqLQsvU8pmwRF9yqmp23Tf5zyMhdjPP7FNOR5sNDSVz3/nRyOL1F6dw8dPqhn7a4vJd1zUTjfXEruIJYZMNjzWJwikSc2tzuV1fQ3n14zjv8jQWA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89281b8e-1632-442b-2d65-08d584b110bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032FB5252EA791A16998E5DFBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(59450400001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 582KmFuuUnTbWQ+c5v3ZQLQu1QL6xXHkjLWX2W1nf0jCWYfE7DQl4O/LwUSTsMNebDf2cbw3SU+kmFB8VpmeqNkjTVJJbOowIt48MQI9ctMZw9Qhn4me7V2Tsk3vkcAq0x1J1XJskYr6GiR2JVDKcS0jVTTuRX4m2Opb7rQoTx/exLJoyec/ASzTs6r+VQIBh4XPrFEDzVF9L6pvZqcPlFXmNKacQ0sYo0e5FqMDwBXBR24AfXN//8dypSNM4seiWmKrWSBFkPmWqm7RI1QUtplKPbIH/g6aDpAVIGnDbqQZXEhAiktpg9XPXdO3ZuMOecXze6fr4YPoaKXn0akRhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89281b8e-1632-442b-2d65-08d584b110bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:27.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit ca5e089a32c5ffba6c5101fdabdd6dea18041c34 ]

The current implementation of clk_core_set_rate_nolock() bails out early
if the requested rate is exactly the same as the one set. It should bail
out if the request would not result in a rate a change. This is important
when the rate is not exactly what is requested, which is fairly common
with PLLs.

Ex: provider able to give any rate with steps of 100Hz
 - 1st consumer request 48000Hz and gets it.
 - 2nd consumer request 48010Hz as well. If we were to perform the usual
   mechanism, we would get 48000Hz as well. The clock would not change so
   there is no point performing any checks to make sure the clock can
   change, we know it won't.

This is important to prepare the addition of the clock protection
mechanism

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/20171201215200.23523-6-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 12180049a42a..0cca063f70e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1642,16 +1642,37 @@ static void clk_change_rate(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
=20
+static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
+						     unsigned long req_rate)
+{
+	int ret;
+	struct clk_rate_request req;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core)
+		return 0;
+
+	clk_core_get_boundaries(core, &req.min_rate, &req.max_rate);
+	req.rate =3D req_rate;
+
+	ret =3D clk_core_round_rate_nolock(core, &req);
+
+	return ret ? 0 : req.rate;
+}
+
 static int clk_core_set_rate_nolock(struct clk_core *core,
 				    unsigned long req_rate)
 {
 	struct clk_core *top, *fail_clk;
-	unsigned long rate =3D req_rate;
+	unsigned long rate;
 	int ret =3D 0;
=20
 	if (!core)
 		return 0;
=20
+	rate =3D clk_core_req_round_rate_nolock(core, req_rate);
+
 	/* bail early if nothing to do */
 	if (rate =3D=3D clk_core_get_rate_nolock(core))
 		return 0;
@@ -1660,7 +1681,7 @@ static int clk_core_set_rate_nolock(struct clk_core *=
core,
 		return -EBUSY;
=20
 	/* calculate new rates and get the topmost changed clock */
-	top =3D clk_calc_new_rates(core, rate);
+	top =3D clk_calc_new_rates(core, req_rate);
 	if (!top)
 		return -EINVAL;
=20
--=20
2.14.1
