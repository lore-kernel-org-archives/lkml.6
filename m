Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488065-2-2658861117272486254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488064; b=he0VqIKA8bFvp8YinoTK4AYabLyLsKzEkoVqdK5nQqIDGKB
    k1W8it2ZwWYAHQYbLnb6OBTPPxxjYZmLH6Jzc7hzl4Meu8HEvzD5E3/Vo86Xi7rc
    DAD0XZIajxZWry1qhXWrVwkInVLbz2qglI9/HMkcI2SG3iXvSo9pdjhZt75GPFB4
    YCyLeOxM68cJfSJuwN9H2rMkfwE7sPPhDk+2yFrKhOhGg7mCjjNkHRy50uS3LJg6
    ToafmAMmiFbSy7G+iT6lhvtviVr8tWTmjQZjpVweJsc1WaKgvB3d51jk14iIjjND
    Za0iZfg2ag20iQ6GPNJpOo7f6FlEdKrYPtJL7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488064; bh=YvYKFd
    Qn5BHRjy6XqVKp6dcvGBWBrqX6uXaggViJ6hY=; b=pEbuyhjfCP0qo8s5koAQTP
    UdgssVHcUteAdmbcLhJsHsf9YCF2vZbm+RUGOwmv8kKTE7uYYA61JZ+XQ2dJROGG
    H1S7dS+35Bg8UV6N5aie1THuhtZPAWw3T/sD3YMIkm01OgNYyxXlrgLbpWBJ1efG
    ivYRpzLtBl0YMdK4YccHbWzNHb1n6kUNeQVBDRmZdf2SMMVKwV68dBwxdqA6C5w6
    HuYwLp8qObWjlg/UVByengBb9PvkQuj5ZsuK2ypd12uD0kL0OZyQ6DBm8NsTLjf3
    DR5zLvdFc+hLnHrzw81C24AR1F4uetxVD/WiUDiAozGbxNeBi2/TomJQqoyH6ctg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QUoPiyqg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QUoPiyqg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965610AbeCHFrl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:47:41 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964983AbeCHFFG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergej Sawazki <sergej@taudac.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 189/190] clk: si5351: Rename internal plls to
 avoid name collisions
Thread-Topic: [PATCH AUTOSEL for 4.9 189/190] clk: si5351: Rename internal
 plls to avoid name collisions
Thread-Index: AQHTtppZCzeuRWbW4UCPdP92/4zjwQ==
Date: Thu, 8 Mar 2018 05:00:16 +0000
Message-ID: <20180308045810.8041-189-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:n8bCPn9NqhJ4XHtOVJT//k5zfql5l6bLZKYMTSO4Nh9qkXRZc6q+8vAXxqreExNVCXCofd7TRrLUUNWbQ0/pCmTOl+e8l+edRslISAltuCNaAEzAH3p2wijhvgFrkxTJTZUL+LmBi+L9ww/fFbpq82E/11WhmQrSci+zGxB32NdTtJuYOIzee6qh3M7V7ZZRDZ6gFATSHC7jWkqSH9P2LlTwWe7p6PdWz6P/KoIwubczm7XRqyhEYvixCJteud0l;20:AKDyFQ4cQmnAiGQJUymAC/rZEe+jk0LzfRD8m+GOmQScHrAXYejJN7O4eK6tLN+1+0BxGEgkHaDJANjcoofVertEC7cFWpKw+R6D4MKJ5XyUPOEb6rhU4E3GZT6yHTnqfDC1Kw567E03Uryvj5AVUqchTwHlPwwoXUhXF5yLRdk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cba2ab7-145a-4d4d-841a-08d584b225fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09815178212E3E8FF6FCCBE9FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(39060400002)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: A3WYOEONu8yQwgEHWlptkQExlU0v77g7M3o4zuppjw6j4LvnrIVpr80e0hVhwuLLo3yTIliRYXvs7qhDrUFJ7Rp8FZCK3wJwklKHK79vlF6hns1tFGQuFzEjPsK0WpJhFctmh28h7X+2w1K7EUjtaEggYd7Hx+yodUAVxRt6R7vyLLEBQ0UCx0jwBag/iJP2FJ/zZmPe/G97AiZC0un7/mFzyO++nuSlrWBEWMrVRgD1HcOoYdOUQsaL/HsFWdA7j8mlDTMwTRRcIvWRuUMJVLfUrnyLkb312QTyZatzlzJiyKG7d3d8QWFQy5YivOMFnw9d4zECiZqW96tbeOgbCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cba2ab7-145a-4d4d-841a-08d584b225fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:16.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index b051db43fae1..136a86094c53 100644
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
