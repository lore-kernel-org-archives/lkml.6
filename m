Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233732-2-12697467218022404840
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233731; b=P3Aa+iJOn3ClBqNyeoaOYoTDaImqLJL1Q72KmZ7YD4OGIghc1J
    897Lcl88FDc0dCP1DiRi0lKxr8RP+ImWS++BkTLTaIDhfYfDjF1no4bjJhj5fW8B
    UL1ZJ3v0xkPWHsaiuw7uyvULoRwCh730cgf0KUZ1AwbsOVwr5CgkLk+JkwODSw/p
    eMQa3Y6vP/pRikKTFJkgRdQJTTY7ekC1QoXMUsPSSGXpMjQ4B6AeGD8DoyE525dY
    ePetVuxZrermtv8MDZBs9xUmmYkYx+r8jrLNnSTezH1sLFBuQZHZEsonrh9pcK8i
    WblYtlintpS1TenF6PDPJxaSJffov5Qcf8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233731; bh=U4xRZDFf17
    z06AebYzJMPAD/HiSoim2KXoRiGYorqps=; b=ryKkbx8+rHLxvAw6TMATWn4rXB
    8wwxnh2UmUP2nHwdxR1Zju+jFJo0ajVkMpsRSYYMFo6EWqWzaaS0auIa/dn2E0af
    9u6wKnt7jqVw05RsKYvBFQp3md8UImYUpeLY/HHK8yHNF/vGq/9Uh8srOu2bOBQP
    imRyjaut60dNnwy+CgM2dRsID+ELj2cqU9RcQmvrAziSESOgcSqlVnZDzGL34ekV
    PA2SkylT4mJVMh3xu/ZDLGjleSkLtDg2YYjeDX0r40xGBx2bM5w0m0E8JlwQk5qU
    Ij/MhEUFm2IfiSJvXF/P5xx5P7xBElddbtySN8sTClgG6l8nxIg3gk2cF/dQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oJX3MDuI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oJX3MDuI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCm4HUbhZ/xKLS3hcH3BkrjyJEhzZdDQDLOzbgxnuSy28z8XbLRrKfrThiCxkkZR4LSWug7JEI0RxYbDEYYKotauI9fRbHXmH25Im9NA/BoK+baD8VAS
    E/SmMhlTQXYf2pRWL5FEl+pUqiA04fjOrXWidCWvqKdU2sSVSTfV5KrfRooWUMyhKWjdV1xIbW1LKXFmSBELH+qBAgLtSTn+BWeLhoUb6edP3jG+ePQf2cf5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=6zZ5Uxn1AAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
    a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8 a=geDHFwkLLC47uv_NpbcA:9 a=wPNLvfGTeEIA:10
    a=MCuRiewMJIbjqZ55f51s:22 a=xmb-EsYY8bH0VWELuYED:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeDIA2s (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:48 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755894AbeDIA2k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Larouche <mathieu.larouche@matrox.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 083/293] drm/mgag200: Fix to always set HiPri
 for G200e4 V2
Thread-Topic: [PATCH AUTOSEL for 4.9 083/293] drm/mgag200: Fix to always set
 HiPri for G200e4 V2
Thread-Index: AQHTz5kNaUclYo3d9kyKXUHEPIIp1A==
Date: Mon, 9 Apr 2018 00:23:58 +0000
Message-ID: <20180409002239.163177-83-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:FSpea/vt6ykMFTqrkkzq+gTxMfEEUB1MpdXtf84Da1G9E/cc2+l5TC/prwgJa00QLaHDx2A+rB3z793FjpzeE8dkaT4+kttSp0Zp8yRi+vi7Z94fjjFwsgn72xfxCYhbhavqNuw7yWp4jr+jyEeCbLIQDCzs37klS7cbwzmiNINq9ET5iFgGYEJOLeaQ+lVD7B7X0M3N75nWHrynttbb8OQDy1evUYh4OhGfEWvQDrsWD0xGezEjKy/WG7E+xyQA;20:cOnesvIPLoqWMtIwQV8GmjavTWfu/n881PIQ+nazj0DzaI2bscob++7fKsxCRjKwgKAbSVfksHa/6H3mZ72kBQP9VqsqJHWsCA7wMhGEk0NbiBRwulO+uB+8w9pzgkTAB0N5OmxOC+s2eyVdaMucTvDq3/S2/uWVfXmI97Gaw/s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fdc369d-4f86-49ef-9c59-08d59db0d376
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807F5DD74FBDE69A63D6452FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(966005)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(6306002)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 539Qyjm/eXpjWpzeF0gojGmFaRbj+CC0EGj9Tko7+j1NqNeCbGtFjHjE1Q+y5fh3Uo+vuKj8xu7XVbhXbhyircGswOQMqufmjdX6jg68Zxb/Y/JQxmapGF02Olmn9heeqv+KZQQXi40TdMYB16FZLvN3xnr4rlJF7l5Dk+MhH5UBYu/x9OUlrl01BObGvmSaHE4HVm0676VB5xQ60n6AG4N/X6DCof6MxGg+PAe4lEpvArkdXOMHpjTqBTcCvF6kkXW7FCyDEONusrR+b6fmrmEaBi571oFSzF1pUjvzgp6TX0u43vbMySfXWxf/KZuLXu/6EDk/d+3WB1O2WkzenaSm4QxOE4YXTrtZ+na175ClEj+H/s0PCT931MaUkv5sNL62OQbOYOLZ18p2qtOcN82aMSlMKSOY7Yz/F3G6DQs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdc369d-4f86-49ef-9c59-08d59db0d376
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:58.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathieu Larouche <mathieu.larouche@matrox.com>

[ Upstream commit 0cbb738108927916a659b5b0b96e386fcd7cc6e1 ]

  - Changed the HiPri value for G200e4 to always be 0.
  - Added Bandwith limitation to block resolution above 1920x1200x60Hz

Signed-off-by: Mathieu Larouche <mathieu.larouche@matrox.com>
Acked-by: Dave Airlie <airlied@redhat.com>
[seanpaul removed some trailing whitespace from the patch]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/ec0f8568d7ec41904dfe593c=
5deccf3f062d7bd8.1497450944.git.mathieu.larouche@matrox.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag2=
00/mgag200_mode.c
index 6b21cb27e1cc..e27ae5437089 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1133,7 +1133,10 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
=20
=20
 	if (IS_G200_SE(mdev)) {
-		if (mdev->unique_rev_id >=3D 0x02) {
+		if  (mdev->unique_rev_id >=3D 0x04) {
+			WREG8(MGAREG_CRTCEXT_INDEX, 0x06);
+			WREG8(MGAREG_CRTCEXT_DATA, 0);
+		} else if (mdev->unique_rev_id >=3D 0x02) {
 			u8 hi_pri_lvl;
 			u32 bpp;
 			u32 mb;
@@ -1598,6 +1601,10 @@ static int mga_vga_mode_valid(struct drm_connector *=
connector,
 			if (mga_vga_calculate_mode_bandwidth(mode, bpp)
 				> (30100 * 1024))
 				return MODE_BANDWIDTH;
+		} else {
+			if (mga_vga_calculate_mode_bandwidth(mode, bpp)
+				> (55000 * 1024))
+				return MODE_BANDWIDTH;
 		}
 	} else if (mdev->type =3D=3D G200_WB) {
 		if (mode->hdisplay > 1280)
--=20
2.15.1
