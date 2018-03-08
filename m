Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492896-2-8281112576545638392
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
    t=1520492895; b=d2kEUB8e2BuLuYGk0qJlDWR47Zkkf3kxfndF9pFxHtnoHZl
    PHIxMiVDdaneXISNqbi1AcY4VTLSm+h6QeBIKZr9o4HiRNs4sXds/PC/QxbEwjzx
    FRboQVwl4kx8AAVG2ww6srRjCtJtYwGHprN+0lAd+NSrqAKaMj31jb1/9D3Ia+MJ
    AkvQQ8lau3lUR7fpT/Ws0Zm2Lf3xSexvFtlefZbz7a2NRgc1sA/6CcDZAC5s4ax2
    3NVlDJF+kKmQL2I6B1eoKdxJT+aa15HJpNmzwf73df8Xec/9xhQq7mYMqv6Jertf
    V24g/q8pOPN09TYJPLtV6TTdtemQXJVT6dGvMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492895; bh=jq6hTV
    GEZWhLUMYTVEOVrlKpw6lssn+qMvVdEo0SMiM=; b=eEBWy6uWPvaXm5cE54O88s
    aIR8JDa30BOY5rra5yrQRUg6uDiNNmfSpQW4KRV8aysg3t5GPfZ6/e0HZ5ffMLu5
    sQeUtWenl848BNDY9vdiSRco8DL5fM4O7OvruS/ws+iYafPpYpDVHhdC+iYUCUVB
    Ch2/nyxba/JdolqzORRbUr/tTlztRdiOn+FkPQc2i1o3kQzx/q3xFnY9OPOo74c3
    CVKASYYsKxhMitcpFg1f7bXuALWACBLfCiBGNsI7hdZtOsNS2zP0g3Kj2XOXKUr2
    dNnGmsJB+t9xG6HJKX98Oi4tKtjn9iYZA++hZvGSlu7EK/8s/cSk8g1xbFM6eONA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y6xQF/4o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y6xQF/4o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeCHHH7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:07:59 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933471AbeCHE4a (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 23/78] media: [RESEND] media: dvb-frontends:
 Add delay to Si2168 restart
Thread-Topic: [PATCH AUTOSEL for 4.15 23/78] media: [RESEND] media:
 dvb-frontends: Add delay to Si2168 restart
Thread-Index: AQHTtpnHHeyr3gzgc0Ot4dyWBIJ80g==
Date: Thu, 8 Mar 2018 04:56:11 +0000
Message-ID: <20180308045525.7662-23-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:GFHrrc7S6hyb3LJxNKxrwt8XI5MpUMt9nTkzQOH91s0jSprh80pS06vAlwZavxCZ3lxs50xEhec4ToD225sZqkC2t73kBRGUQN6UDiD++Doe3BEynuhnvvtJKev5gFMI8n2SF2ks7nQZIY6YrxCRGylpOl0jnX2R01y4nQJ6fLU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f34107f4-46a9-4088-06eb-08d584b0ed35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111114C5C7FB2A69D995B061FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(6306002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(8666007)(966005)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0VQph0n7oa+ugQFM6PC91su43kX76ctJxzeINOpdWPBdmLKM0BU6KZmBoxQ4iI9NE5d5x9bhJtnu4TUq7G5kvn3ZpCI76mFfntD4Pfetm6kK6Kp8OgWpoTUSMVukXSZHKOQQMA9Pb4k+HeKmhlXS2DGHURBKtrkFgm8KkBEIe0o0XTcU/r5lmsarNsGbHzTqiblHDi8MRmF7oFsC6mm79eb5lzEk24t4oAIpvbDlElwEjs8cR/MVHhRtXTTS7iARQUYdi7lmWB/LDGUd5hhjsVHyznA1dsFzlFXc3kiPVJjOXPFCtoygfx3yP7lOZEqRMxTZJSw8aZVBv7Gj921NJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34107f4-46a9-4088-06eb-08d584b0ed35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:11.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ron Economos <w6rz@comcast.net>

[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart=
 command. Without the delay, the restart command often returns -EREMOTEIO a=
nd the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/=
patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/si2168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-front=
ends/si2168.c
index 41d9c513b7e8..539399dac551 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
=20
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
=20
 static const struct dvb_frontend_ops si2168_ops;
@@ -435,6 +437,7 @@ static int si2168_init(struct dvb_frontend *fe)
 		if (ret)
 			goto err;
=20
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen =3D 1;
 		cmd.rlen =3D 1;
--=20
2.14.1
