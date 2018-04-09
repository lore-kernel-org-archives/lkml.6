Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238870-2-17512257728717105321
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
    1523238869; b=E2++GOgu62wktlJjro4PiWGumdR4W+V89c0LqBhwcRAMGMN68l
    sAb46wEue7MnYGXUzHcRP+S86Q4Y9klEy40NHhnb2iLBkvYUE4+xyLWZJseOB5Nd
    CGFfy4GUScRW3LfcqQIdl05MYK8FsMMxsg2IzaOrKWwVkwXUmia3XwyipV0Lojjo
    shL0G7yIVJbbtN2QcVzJt6CUWMpQi6Sbf53J8qTUzyY8S3loffP+ZH4zqnUoTJ42
    bvJjzYBceoiBs+/JB5uiqlGFxov1M3KZo04Gibzso8KOJl6AV/xuh7IiswyxcTPT
    /PE21k2PISW9qrsL58PMVgCb9Z3tvzdK7FtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238869; bh=UADr6qRNR1
    Q871HLtIUZAatGAe9GBAI8TJJ623dBM64=; b=D3nhXGbX/g/aC+0zClDtecf+VS
    dvokiaWxLulzoOFWehrlJvduRXXVshOkV2mA6VmyyjzidrPvuI8XGSOXFtJZ40s/
    10Uu1pFC/AwGzqJ2w5BLn4sO9k7Ph30yYDVWjOZ4OyHuNWiApbCoyucNkc9zbtBY
    U8+knZRCeLvuqv58MYU4Deb9E/lq1c+drMT86t3zMhqxRvmOhZ0H0ayqy0oMcPrd
    6joZOMmY4V7rMBljI3zzA+jYK7ol4krrL+BEte0boRhzLqu0pLg3CSDXiDqiowFj
    46LGFHeDQhLIn1UU32Yjw24fUbUjBDW6ywxi4gmgTKHxLhdRjMpasn3fmecA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XHK56j8M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XHK56j8M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBdMVXZuIeuvCzg9A9np3vPHQ8+rUvbSw0OHZz0ssG4XNRkdRQl3Itb9sHnMdxm1NxGWiw/J8YGZbbzBZQbLxSGh8+fnTMUZkwlh87KsMZGxR3i4zq9K
    1T2X5mV069rOn4mSJwBCZ13JcWLV0+txIcvZc+xvddEEeMQNrzGad6mr8tJIJCeT5Dn0xxPnH4izHsWM585WaP+0BAsNJBbV3OjxgiFZRx+TNWA4aYYLQgz3
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
        id S932279AbeDIAdN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:13 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932260AbeDIAdJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 230/293] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.9 230/293] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5lR7s20/06CbESuTp9Fsoncuw==
Date: Mon, 9 Apr 2018 00:25:53 +0000
Message-ID: <20180409002239.163177-230-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:YzFyqRhEUntDGhIJUALmKNL8M0jbWD6tBsfmIm3FbA1UuyPULVJTpmRnQZewt6Srw9pyeb3cyrMovQDoQ/4e9Kh+LRdIfLBPNge4+c/fC/CE9KNaIPJOjq0bTGxDu3EFGdN/rj57YyCUKfcp4oyH96auxRhJWlHQfMMdveZqP5/XXhcunVQD7avQjUbeE6nD5q6qtqVwdxq+BQLgxmp6mbxCQs/B8PmWGHL5rSlRNzx7DgY1r19TGsLaWd7kt1jo;20:q0vOY6pE3tK1CIcccosF/OkZwCQBd8ho0SYnxvKplKDYye954e/Q7dHQNibmEYdyNfUPh25yzjguDUfpT+jE3oPJVrbreCaXUVvZACoAyuPFMMdrcuzM8/Jkw2Kjh2vn+AXW3Vfdcqm3e7mJ1H7F2LSi2z7ijlawny8atz8j0m4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b05fab0f-0ac5-42f8-1564-08d59db17541
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902DD06B25A7C7D56E1BB9CFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xGoTTSrt9ci3U5BgE3sNbCCSFUuHS7Qh884hExxtGTXlqggYFSHmKJtXwletjzaS+C8+8JB2Bbo9SQvf8eTaMGP18cgpfuUrylV9+NWyjz8zUaM62ehAIyNsCQRCJSpAqiZ2YZefyxTqDtzSveYaAom8jHQROrnOrUdYVcN7yPI/qevRTXp2EOb9WsMSGdtIqzmEr4r8UB0iCbn0FLDnXYga2gF8M7aDOCgQhluDWbEjDWPbr3pkJQorUag/vySIBWCz0zLFtvzJjWgjI5QrtLxfhmnCg+phCY3xOvB22Qsfh1fbWrRgF9efrlsmm2TDIFpwTBVXm667+AlXOjA87AIR7/e67PmPCKnb77POCznfvITZGmebM31yQ2H/A7WPxcWc7VfG67cu241HMEW7SFiTOqynFj5IQHJZh+8UyJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05fab0f-0ac5-42f8-1564-08d59db17541
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:53.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index e8248f9185f7..eb9002ccf3fc 100644
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
