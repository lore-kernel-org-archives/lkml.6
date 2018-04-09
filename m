Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236474-2-6149548507138387470
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
    1523236474; b=ZPlFFfgTy5ZwNUVoYnMm/nhO43yWlb61MaIRd8v4umGv7h54PU
    iwoVqBQw2S8ll72NAHuCbxNehSYLKUEsA3SpLmicQvXWhRho0qUdfidUQuJck7W5
    UMLMikQB/HXW2+OJjeCdjbQ4BY59ckVQz7t2SKnjuiUBh5XGltekphAhUuBoruiV
    WYMG1AgTwWMS3vwWeAyEBmvO8a2JySwRsd9PhYOrzMKnKs5okNnJUVU1AwWJTZqt
    xfsJ48KdscidsCWC65rlEJbCmHKSIUUWH7iKLRa6h2sYRPd5jjo8eh7NnyJDE6d1
    Fc94mT+d2AJr6npMuTCq3aOdIapuszuvN4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236474; bh=1T1YHlhj4r
    yrResjhh/LSF0l5b/gmjHIU+MKJELoOpE=; b=KBa1aCdENyePas00Wf/eVJ6EbR
    WtLCO9fBOibEXxI6YgcF+9A0t2s84uPOmX0N5K5lErsnRcquQj/bJXojgur0CTiL
    es5x0uSQ9bJ0nQ7fQoNAF3Mf3sQBG1MQKE0JQjLG9N/bQ/kjrxgkArCbXBPMWXOe
    a4XD64R9zXG7h8hPc8XlVL6TDVQXQsz59UzH0ikPMFg2KqK6rvnuHotq2YQGEZBd
    AbOpWKiFwmNZDMcP3kjV1FjJNSYraCqS1/gkHgl4DumRVyiZMYSzFba95iIRlHu1
    nCLcRAThC3wdV/yKwtB6ylNcFWFMItmb9zvJwxz23dcYZDLxSn6lmEsYNe5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M7MFanxN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M7MFanxN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmnP6/MQuVPkk++pyz+O5qzLDWMzoXUxjv7dBndc9UmM3ev0jo2u0os8e9WRN5+IOUhpd8x911GgRecz0zO1uBWkU+bMI1ger3azLb3+zcMfVrDpDoJ
    hB2/ViM1Zq6am7746OhkJXuiy+9SahFND4nPKqBewCpNFuUOtCWZeRyYYtW8jNqfmhBDiLwdvNU+r17BdhTp83apAoIH4dfVeX5Y+pebOGpoGqifBQVXMD5v
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ER_8r6IbAAAA:8 a=LpQP-O61AAAA:8 a=WPyIoOwQAAAA:8
    a=EHaNKQqtAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=PIe8psd_NT3qpsEeU0EA:9
    a=wPNLvfGTeEIA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=pioyyrs4ZptJ924tMmac:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=KIA0-nbnOXq3vJi0w304:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756875AbeDIBON (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:14:13 -0400
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:17312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932882AbeDIAiB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 118/162] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.4 118/162] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5nKGdYjw+XmQEuGDFF2C8X15w==
Date: Mon, 9 Apr 2018 00:29:16 +0000
Message-ID: <20180409002738.163941-118-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:wSNwQkKogeFBg4j/yngQnXMxUD+ldrIBlOLgxB6npu3X3ccxHeSlNvPmkNM3tyyUez4o4+yJKTPPWfTTbyjWghdMt7x6a8kcR/fg5BkA/BpZOALLpIshpr1CyQU7S05Eqgc2UdXAq56Ofq5siKiRVMLWd5hy29qm1jxOQIoQ4bUfyPZsvOU//UKrGFh9g13fHftQ1QT4Dv7yMkQefd259F+vuJ9+T//N09Im2GxvAydYMo601985OK+3BBhvqgJa;20:ny5E/nvZOemYKriCXkyVZM4PVtihgi8hjVPUGuuL26hjoOg54FHHS9AoLCI2FKWsz28Ym1h2Ev+WHW6d+8UaVpdB7oogIfqnQiVKcnSANqaHkNm6gJb8uuiEOYz4JcUM4pR8m6FCPTAB/hXUfPrm5G10KeGmvioNgzrwWTikUtI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83161fd9-80aa-4330-71f6-08d59db22492
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110F61FF068AB245B0D8E6FFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(6306002)(186003)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ye6x4KB1QE9705zUwWaVSFMUOQCeEkJLTOplCM14MgQ2EiNSBCZDoWtXzkDOCcSRYteqCVW/+B8aEi7XEU+7jH0VIfG/VgliazLgT/PYe6mPlNliiN+AkRJj71ApT6qNSV1x2bjSUvcTE0EOH12zGBS282AsQEMmP2HapUmCh3uU1ewe5/LtcUYFn10J4bcUvquErEQioQtIKO6ZFf0Jzfh+u7M5zyrvSMDhHlFMvE47HsJzgJHGrN1NvUdezFBeiHfNXh6eB4fFq+OStZv9HLPgDyitIcWTXhqkdUfvJr02wIWd3RFDXoaTtZcmyA/SEAhNYtEM53UfU9NPXuxbLSWIG9KSZTmeFrlzZUJvbwNAiWOd+94A2rgX1mpalMY92n/yEIqBdRCzEaW2i4HcCgc5TadjnoPOQtsiA+PQ2tY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83161fd9-80aa-4330-71f6-08d59db22492
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:16.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]

Previously, the clocks with a fixed divider would report their rate
as being the same as the one of their parent, independently of the
divider in use. This commit fixes this behaviour.

This went unnoticed as neither the jz4740 nor the jz4780 CGU code
have clocks with fixed dividers yet.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18477/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/ingenic/cgu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 7cfb7b2a2ed6..e5b1bf4dadcc 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -327,6 +327,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned lon=
g parent_rate)
 		div +=3D 1;
=20
 		rate /=3D div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /=3D clk_info->fixdiv.div;
 	}
=20
 	return rate;
--=20
2.15.1
