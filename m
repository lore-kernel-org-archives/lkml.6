Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116654-2-11178711560421987870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116653; b=Qt7JVokV3EHZ3ODg1rk0vyEQIU2/OEU+NsK8nI0zlt12/6A
    gOF3QhhYGUKt2tgXQBy+S1VsD9xunmEw6fX3PzFQZVd+LeGraWJhL0cf9g5ieMSJ
    OqGx9kZmI9vJ4rB3fhbU5RX6d4EJXW2SWGaXzI/x6nAagqp3nsjfq4MivMK0rnX1
    E/UX06fBrR1ZFekB7e6jcBRw9k5f34D+RcBAob0Z98TK7vjWeR1Qk76BfCOLpBmr
    Zmuq9sf94EuAiUOU/ZmeCHim5xZx4OcgKUnDRGms8hXQD3NfuAR+4IcgXtgp/1Hd
    M81S3+P8jk6GkWdulv2lb1yiiKBoGOvbvK8pLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116653; bh=1O7TgB
    b4gsKerFbv6QdET/CDa9knCIiEXG94YtZ4wss=; b=ECM2mcdCJFjPH/UkvYYQ0d
    vowrLEQmOHDft0BrQxs+f40r7beLcDkQSuUoYyT3x3BcvMucYA+QaeoazwyrP4P6
    AyTBUQnByt3kyWfjcK/d/1gF8ExiM2z8oB6PHokMBijHm6Afrz78l0OrBdqkQK/p
    c0CmSiC/3+EnoGh2sxvbdKcfl5T89V9idsc2Jmb1Ll5G9w0gVYnlLg2RuA+WAxF3
    q9LN8/TGpoNItRhySvJx812XW5Pi3vYk1JEIOBTwaXEPmeLMAoeMwpadxt5UQi3R
    ++YghxxGv/aPWqbar39Ise69ki9C2/L4CZ7D/+jNGrAh2S304gqDSolap20n590w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FwVbbCH4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FwVbbCH4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934702AbeCCWhT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:19 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934689AbeCCWhL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 198/219] clk: qcom: msm8916: fix mnd_width for
 codec_digcodec
Thread-Topic: [PATCH AUTOSEL for 4.9 198/219] clk: qcom: msm8916: fix
 mnd_width for codec_digcodec
Thread-Index: AQHTsz8l/DzKv+nb8U+JwONYJ7g7Nw==
Date: Sat, 3 Mar 2018 22:29:51 +0000
Message-ID: <20180303222716.26640-198-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:Nuk5YC9b/7KHuf5Ip5UGcchCP658GT90qrT64tUnN/fjGozZ0L9oxk/ldG2mpybuXZ5VZQys6OfKIV0dppw0Yj3/b6eByewWQf1TGWnKppobYhuLuNvD5m65jt6mhldD5n5eFQ+T3QErzxNisk4YvUGFFQ3/qCwcNXOb2SBYdnk0wFNmXqrglsjI+CeMUEftkRHB2ZWymmjJ2WuIv6ZyK/ROyDpftxuLeEaz8krZZM4RFrfsn1CLQCGTYjCKp1IB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ae15d62-b70d-4ac7-c853-08d58157427b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969BFF652A1D46CB0D89559FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 04d/s/cpVJ7pANzVBtgjOBKKOr0hBe6P42k0GLx/7oJgKdHzUPmXuySm7WxlB1zd7MQ6jsF2RGhnDiJ3cVx4axH+LBshottr+zRmSTwx3gBdiJ0YzbvuWYnRnvKS76/B2sfqDfiwSouQwCfNi8+PzdASg9C5kZShY4CmhmSdObU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae15d62-b70d-4ac7-c853-08d58157427b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:51.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit d8e488e8242ecf129eebc440c92d800a99ca109d ]

This patch fixes missing mnd_width for codec_digital clk, this is now set t=
o
8 inline with datasheet.

Fixes: 3966fab8b6ab ("clk: qcom: Add MSM8916 Global Clock Controller suppor=
t")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/qcom/gcc-msm8916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.=
c
index 5c4e193164d4..8dd71345b5d0 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1437,6 +1437,7 @@ static const struct freq_tbl ftbl_codec_clk[] =3D {
=20
 static struct clk_rcg2 codec_digcodec_clk_src =3D {
 	.cmd_rcgr =3D 0x1c09c,
+	.mnd_width =3D 8,
 	.hid_width =3D 5,
 	.parent_map =3D gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl =3D ftbl_codec_clk,
--=20
2.14.1
