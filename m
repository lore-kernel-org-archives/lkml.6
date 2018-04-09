Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246686-2-6670307482112773706
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
    1523246686; b=on/JD39o3eYzBjEl/u3ZJ/67lqVBtzeA0IT3kiVR+bpjqozrPW
    ZE4daEUNmkhWxrvZ/kVoQSUEEyyJbBiHYVHjTihDgJN6XYy5uBefXZBL1LDmyJGx
    OGPBIgWPqIaSpJg7S0aKK9hh5d3dpeDFneVcsOtgCd4E7LYF37AGgFnatAHhyTEA
    TUO/zilsllQy1UqPuWqvP5ivOG3YB1aoniA2Y9XQj4kZAoUrnHmDLfCwSfVA0GUL
    lxSPm8RbvLe2UNplFs1rPKB4sQXYF9gLuZaicOgT9Gr6rEN9IVQVMWJmYGu7q7XN
    IT/DlJRMZ/0GrhYu++ofVuhq5s7+DKg7EK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246686; bh=rWThu3jr1I
    8EvsF6RDs86jM4LlV13ElKJ9DwU5jN4K4=; b=rsHajIIQfc4V50CMKo34wqORRa
    Y7sAj9T0Qh6rP7aISNSv/5GNrpcg8xkyCvFXCyCkDxysKmL7PGb/WP1nW2RkNxqE
    1ocy5pTntWI7L/fuWxlGZNGd5bv91VGpUSYqHnyiiMVSqB+lfOG4ggKR5BDGwwJn
    evIT9KZpayqZPzKp3b9hz06lomWSWZVQ8L/cGrlBKgsYV37vxBRSghzY9NZscsSi
    ftq+4VIrYGyrY7DSwS3+0jT2JZjtz1/2eXOIyCStvsOZ6hSyNA6qanQdGd5JUvbU
    80ZFwi2OT+gyG3liwfMYMAUUQ9PVry0ccX5oejC0mfRMi0LvZ9J29QK6ZoaQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT79OABB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT79OABB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGnzNYbdyo3qlmWaMOkp2AOcAoZzdCnBACvsHKO3wvLnUBwG/VpbekSV80JS9W0OT5dfANxTHUKr1USW7ohzOz4nGvE8l5jcpC6Q5AHTxiK0Bg+RMRkX
    Ibaiwh2s80CYVMBbvz0fdYCIbTZA3Uk6SfDdfJ4p/QAioY5hrhPYYGduJXXtAWCIoWUu6FC6gSMvohJN2UBI/SEnlXfEQ7UEIyvh0u964vwX2tl91CZLuIj6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ER_8r6IbAAAA:8 a=LpQP-O61AAAA:8 a=WPyIoOwQAAAA:8
    a=EHaNKQqtAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=PIe8psd_NT3qpsEeU0EA:9
    a=wPNLvfGTeEIA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=pioyyrs4ZptJ924tMmac:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=KIA0-nbnOXq3vJi0w304:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeDIEER (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:04:17 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753307AbeDIAR5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5git3dFULHUMUCcLZ/m4cWq6g==
Date: Mon, 9 Apr 2018 00:17:24 +0000
Message-ID: <20180409001637.162453-48-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:VyPLb+s6D2eKQQumFLbKI3J0KaUPfmbaV1Bo5TSlsVNyGhJtisgJw5sdd1GhNazHVeuI+ycuH+BDbjjh9E7ulF5R5/vZiEeKm/ZUsfOywZyoke6zjU0XicbpknWZKl5wB/X7J9GgBhLgEOUwmTiLpRwoSMNX83O1udPLkdmDnF0pIBxGLcW0g1rVDZi1L2lJEMH3xk35HllfaeHB/jqD7u9foZ4XK6yB2meN4zYnRgAdkcAHcDLHK17hDkh36SQy;20:VahbVopeRMgjB6CtT8hoHJ3S2czdl/h1cyIFm4e2s0YYJb+JFRNdC6UeXHAc4DG6QboV7Jo5XNi3FzOP2xw1BxYClmZDygku6vjfTW4rondjp6Ghx7tlIOS9U/RRRvxa8PuZmxQ1cynlS99royQR2GOPAJLMVEII9lLjdJGgwD8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66a96968-0e82-4f8f-fc3e-08d59daf5453
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048BC02AE58D33B3A6F0523FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HtsW4DS4EifxR64y/kqTq9toAiOhG52ToH98WXJGy6FPlZApbxZikOcj/48kGzl/5bZDN8xaDnfQL0JQFrs1ULK2sU9ZAcnOvxpcOGuGfYzxTQXF0esJJacfoBpRdNz14XKBKrUMELKA5AxZFtNS4TBO7lat9BDBihamNFvEdOYelgxkB1999p/eToYIMQX3lF8c3r9QfgpzGrI68SJZH+djY7PMC8uu1+vm1ut/DaCLCzm3ZH9UOpciAPTqpT2KyTsj1XaJp2ziyQvT52cHV7Eazq9/wMx6n9F/d6Z0n5fYGyQYt3XAvUMj+7mZju6TG21jyC3UgFQbRdcjY5XEr3o8QTWYTxalAOXufVDmEQPoVbmETISdRFifF7BhrEE87F8KDbEKZmYNcH+5HMbAEoYLZ20bj+7ZE80YDvMOE/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a96968-0e82-4f8f-fc3e-08d59daf5453
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:24.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index ab393637f7b0..a2e73a6d60fd 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -328,6 +328,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned lon=
g parent_rate)
 		div *=3D clk_info->div.div;
=20
 		rate /=3D div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /=3D clk_info->fixdiv.div;
 	}
=20
 	return rate;
--=20
2.15.1
