Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116244-2-5681531110827832735
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
    t=1520116243; b=Z9dqqTJUGK00NQ25rYeC6/OHka0m6gRdqYZfr5O+RqWoFP6
    zoDOz9BZCxaCvUf4vcG8EgQ0Dp1j2f9s3Nca9NVBLDBelXojUkc3bRw2uxagpMt5
    HJML20qmrgz9m4dKL64hnb+aW57f64YP/zsKkZB9U4sgmJOBTilKBtZN4AYTHZ+P
    grayPeZKv/073vocUCV0xP076iPkuH4E+NpPHCYtK/qFtxkz7bd04rLg5LInTEEw
    JC7uH5JL/ygko3sMT3m4AMYnaYBRZ/K87Avlcb+39jNfU08ifWlbPPfC5ubqBw3r
    x6qfnOueqZ5RJHWO+ma1m3UvSYkeepiJ/Ss+ylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116243; bh=MxjBtj
    yteYcHy9CVsv41PATyxhcIQoEELAu2vAJYTEs=; b=gwADqM/NWKksy5cK+FoJtB
    oS7ZqUEHEuWapA96GfvVvELqd1svM8QECqfnEnGUzyqn+cQN3nQNjdnXFkkv0gL0
    B8axZck/bjn9Cz8PlRYCaCxKcjGxzDC28RwRMbApk2064ws23GUudROg4eCJ3/dT
    vZS2u/YJnbtftqIGBMaedBzrJ9lGjfHanQvAWaRO65Z5zN2kwOHm2WK6HK27MjLP
    fylqgzVfUeiSD04feiEUogXTqLIa7+HIL4rviCx2BatWzgBLVZGpe/p+HUVbbtBo
    9+YA3vaJcrRxMh2Zv3iapZ56lGA1/obVev8trS15Ywew7UaL1f2ORLILL7hP1LzQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O2OGVgdY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O2OGVgdY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeCCWaG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:06 -0500
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932492AbeCCWaF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 52/84] clk: qcom: msm8916: fix mnd_width for
 codec_digcodec
Thread-Topic: [PATCH AUTOSEL for 4.14 52/84] clk: qcom: msm8916: fix mnd_width
 for codec_digcodec
Thread-Index: AQHTsz6t67nOuTE17k69kEfBzK+A8Q==
Date: Sat, 3 Mar 2018 22:26:30 +0000
Message-ID: <20180303222518.26271-52-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:UU2+B2kUnqAVC7jP2S3kYw7P8Mq6hMpcChWQOOhjqWmpB0bON/S7V7NQHPwoL6ssjHlfThjIpvYjrQFaYyzoA1MEkp48Lgh+knSHoNb/yfxjwuogtPyGsh4OSW156aLFG56BUTzCQNqE2sxHiGgzjmLxUIQAQWCxKzj48PPD2C05n49yz5YoA5PaY9kaCoYkrhJXPiirTS3KusvSUfwHwvwleXN5JZya/N63iRLiASE7xpVlRdn4+I6qV5lqmbSI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa80f5c0-6bac-4d32-94df-08d58156318b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065B6596965D183F524F49CFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9oGFSwXBpoaSu3FQMHBu7rcJbltVU9G6gqelUkcRd3tRya2z2g+3IUDC3PaIDXSzovKsghC8Ux3yfxUz2taUOqhOdcwkeJkuklOF0KUdcXDlz0tv4FNXsQXJmY+cgHMTpJLDROpFyh6ZED49PlNnlWVXLgovxuukQH1zGaVYano=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80f5c0-6bac-4d32-94df-08d58156318b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:30.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
index 3410ee68d4bc..2057809219f4 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1438,6 +1438,7 @@ static const struct freq_tbl ftbl_codec_clk[] =3D {
=20
 static struct clk_rcg2 codec_digcodec_clk_src =3D {
 	.cmd_rcgr =3D 0x1c09c,
+	.mnd_width =3D 8,
 	.hid_width =3D 5,
 	.parent_map =3D gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl =3D ftbl_codec_clk,
--=20
2.14.1
