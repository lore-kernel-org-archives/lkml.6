Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486025-2-14152134227845757572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486025; b=squfHgnQtxkFvobgr4wi2eQGzgZv3Vz96ejpIugmbrSXi7d
    zcr1iTNnfSUlI0cyDKvnGboYQv5x4vhtqtrqwUCph+ATsrO1KYs2xy/xtCmz5qJM
    7hkR43JBcbfPXLr2M3EkRCHRncn2VS1cKZ5eobdeQtoP0hDdNsQnhKr0QZg+JAPK
    fw/lVZ5EEpSlamgaf010Pz4kE9TyXkaeVzLzkzjjiYL4b2h8mmDoMUwvOmVECI11
    bKMI6cr+NwUVp8u+ayRMg5zkamoDNaXsiC43PMJb4S+rnPGjnyCMXmM11B24S4oB
    K2+YfnoagApFlo4Rei0FaCZx0Nx54wXt5yGYimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486025; bh=vdBKmg
    pTi6bth9jX8Hhu+JfuMUKnV+jpfXToZk0QQs0=; b=kqAWtJSm269RCwP9BTtn8d
    1ANfus8baUlAX2EJOsEOz/QPbig48bbNkj/fWDiq3PfLmxpcIX6VfaSzP4ElDcwM
    3E8UTUnyTXyM51tR+o8x5nMqHhoeD6tzW0f8CvfkrwSp4MeGuS7lvG0gwcpDvFAg
    wFi9QxXPy8ls3JOpVvg6/spBuE/JtUfIePPOR3/i6UH71Ogumo22NtwPpFeOkyrf
    jDmnapUQDisSNCPUx+Xya1E7HUo2u/AjtMTYYRKi+Env2ul5MHUtqGXiC0BVNvCB
    necLcFegTVnRsWkpFMIU8Pl233OZlz2dYmAgOMJdKRqCzAHmlLA0s2UuBm0eotew
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OO4AN0Nh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OO4AN0Nh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966029AbeCHFNa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:13:30 -0500
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:33696
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966943AbeCHFLw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergej Sawazki <sergej@taudac.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 53/53] clk: si5351: Rename internal plls to
 avoid name collisions
Thread-Topic: [PATCH AUTOSEL for 3.18 53/53] clk: si5351: Rename internal plls
 to avoid name collisions
Thread-Index: AQHTtprNSrPSpjf0WUSUp3IsZpiH0g==
Date: Thu, 8 Mar 2018 05:03:30 +0000
Message-ID: <20180308050230.8876-53-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:WtEOEbUtosi/kaeOiQqEAGrJCj3GWB8Ygf2Pzoaa4M9r/USBE4hAQSeQgOTs8+wb8+Mx2kmqAim262ZfadP10KVgmcYpSJNoyTWtOq3vusv8tAZzxwcFvx+yzCwg0sL7xJzivn6Mv4sqbNKC14+cx6QilQj5Fpbj0VcqFx3PfRGaFa50efDJ5CxlFg1aYO2XmkvLxml4JQ+3yfiBF5ZrpE1g8HamCLDJAapEyBKxQGoA093oTj8bgjD5VMkMsR/u;20:CfG8xq3N3f26xefbzqzp+uteyII29VxAsXYgIP2hLfbluj6Dh0REwHLLCaPx5ecYDvyaawhtC7Tbr9a2TBQu1xqZhgV5CoMB7Bv2EHuXucvOFKxSF50KndaEEwbdd24VZMaPoSoFqVylAj4/i4e1TatfkzJqKeTk1rDnZBBBrfs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b771693-bc9a-417a-005b-08d584b318d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871FEED875A55549C459F9EFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(39060400002)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yvK/uYSymRU4l5BShKqG1ts3NxFisVTUxb0cf3+Fe5AJUyB+BO7UUV6fM0JmzPPr0358Jp4Q3UtNobEXmrrvsgqTaYsD/IIKHTaLoQDJzOCvrX6wJBldhUijG0CCACeGadIE4EfEFnzZBFE/8pV9nePw76gDX20m9me8tz34PvpddCkJkue4e2DjO+PgV3sOwO576fkx8V15j2U5omrBsvJFtvdpwb5iQUDhtPsRrZAatEhKmP/pWFWUA8/O8nDUHuTQdS8XppH0231UI4v+tAYMc+/hbuZSkPgNnb0uucI+aGsKpCmcKDv+Za+QqcABINC45GThjTD+/SbEiNPKFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b771693-bc9a-417a-005b-08d584b318d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:30.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergej Sawazki <sergej@taudac.com>

[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-si5351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 44ea107cfc67..8c8c2443f601 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_names[] =3D {
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] =3D {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] =3D {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
--=20
2.14.1
