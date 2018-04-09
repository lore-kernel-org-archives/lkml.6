Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246308-2-9492182920106948500
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
    1523246308; b=jCQh697Z0ZH1pA310iB/ICYoBVLvmlnKWzWooyOw1yHIjP1fuX
    i7h39v77Gey7yO1fBhJeOffu/dDUo3Bc6YiXb6M8ocpp5eTtFREZ6IrzTavBCjw7
    eO2Dz+X/uUEw3XzRF37jrIv4ETTTChfLlAWFZUn0pkuiJdEKx0NhmWcbIK7kShdo
    GcvqVCBEHnU/odA/Gv5TZRmgWxxnnc5pZKqWiNZoPGms2SwGHVxXcRirNvP3IucO
    vHvWHlGJVBBR9xTihUpuzOCNkwQ60XQU/2gW1ugSwpe+vwauABblwmqypMp7hOsS
    uhjtPMznxQjoe2YZ0Rt6BvQy1yJJc/oLYg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246308; bh=auDUzu2A1+
    Q1EPnzBc/Ut3+v2gKFBvC+XIkihtGDw6c=; b=gLHzraYtKw/zsN+bfkeMr2r0YH
    C/1Oem5UtHhxpcLHwYbRVOf43/uba4+/6cNvsAIbyNDbawTytUJP5fL4sxQnfV0Y
    bzqy8pJtlirDl8SBoPNY3rFQt+hBPiEHtSXwBKSviv+v4c8YYo+B2wVyHR4IKjeK
    sW8gAcXi4sPLCigRPN+Xk08cs7WBxNmN1hTfo02oprcyMVlWcR3nq2OdRJhKVC+/
    c2855tmquyOLK+2V2oCyw7PvJANE9trVJ10VvQbROXbkm743pUk5mwDY3eULRJuh
    ChmkT6ew2h3IyLcQN45QOA2iN2YWxvSTHnGiD1Sj1b5VB+HtdjZK7AuAOobw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fAAK/zuU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fAAK/zuU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDoFBBJRtc5AbDWgnDDZ4jF0eQ3OoC+Gzk5zluQGaoHi53msGS9HAA56IOUW2Gz56F+FziuI3GJjZ90R3Ebd4N5U84VfaC4su7g3dI3wQucrzLkkI98x
    byCMOd2aMWwzzq0emau288HvHYjJf342BLHzrc7Rb1gqVAkr7/1eT4OoRJBVhHdwDW25RbhhslF3tGTOICS88OkA8R0p4Dg2DfV5smA+OLN4TEqDcTGy786J
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=K6fn2rewBBjh1KMvdOcA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeDID6M (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:58:12 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753638AbeDIASi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 073/189] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Topic: [PATCH AUTOSEL for 4.15 073/189] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Index: AQHTz5gts8IieS87m02OKDWYENCcGg==
Date: Mon, 9 Apr 2018 00:17:42 +0000
Message-ID: <20180409001637.162453-73-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:hajLQNKsSLnLdshtbalAUhID/jhxPuUBjzVFPDXT6WppY1diLORafuWwsClvcl75D892BelFnCnhTC70LtSFJmAhTHhBsccpUGYehJw93+avxagQXTReP7GQ1KbfqYJ3FxYMk2RgRLdzKyF/PozyxgQsxQ4HFCf9cX72ubRLXfyk+qnYs1Ubp4sgYihgHdtqZveVEtXqGmUMR5QIRQRERzwiS1jOh0jZ4AXuLaJc9aQ+9bMZHV5yPgiOnVGe0Jnr;20:3CJ5Tgx7fF4VcgY/1j9NDpiSKCwksQRDWPCI6jdNiYPUa54oXl8s542NyJZqVSWDZqvdzi41Wxej/+gG/2qQ0ufiXaXD78T4ykn6Vf6n2u8mHAKawJmgy1eDzlpGKv9za+dVDA4YvoqI9YmHICdsiRIgfuyf1dq/xRbZYKe1d1Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e74ea404-f4ac-4b76-858f-08d59daf6ed9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11281A378C0A9785F10DFCB7FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QrzlXskKdfde/fp0oN94OOMKRdU01GXFl+ChrzVklRG5jo2+GxcYitV1eaAcaQNTCgc+LR7cHveJfz/BClpGLx4jZQjSeYjzF26nFUrIBupbTq6+BDCKIKBREizUVi1jRginyN5/eBb7b3K4GksSfhS6bV8Nznvb7wNJKzWp2umkeut2YePfZTURLOmO/2lkXpQe1IcbKxSwIz+b3I+8p1mvKmj0b5ff2Jc7YchR0LAKZJwEZlGEjKkZFNaDJiG/gztY3OgiplqY9RQHi11/iBD3SqGlrRJoYiep/Mp/PEmUdEFZwqQvnJ2wAcRokK8zMNs56eUs745iCw3HgevoHGEx1c2tBUiCR+DxBFzaeUB0ofj0jGdI+mKkoMpDXLD/hGyEpz+rzgeSYZaMSE7jZYJjEgzeWveIcJEh2Ah+uTc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74ea404-f4ac-4b76-858f-08d59daf6ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:42.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 43617fb28b87..317c9c2c0a7c 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
--=20
2.15.1
