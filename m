Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489428-2-6605994154129801212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489427; b=QPTLsY4Tid+3s5SuJKYCq6iyHDX76oophl+ISGXrGlXuMvr
    ls5mGphxD4Z9o3qnylQ9oouNrIv16baNjaISjZeMKKSDanRoGJEOpJJ9zSl4CJ7Z
    kXxY54TrLxag5lx7oL2Ctz+PmQdgH2SM55lwHz1GgbY7wUdJL7/Kd0jDN+/J2K/d
    Lspd9xlU5d8Eg+uDuA0jl1Oy5WJQqaOGMMbpbR87wbYVXq6hWBv3DzgBR/X0/USt
    tt+LmrBP971NMManW3mBztmuoWqDTZE7kaXmGzR886ISESPDRispue6/NJfO7XYr
    mw/kCDQrcwxfkI5vIOdNGeBeLyqlzv8xfTm7zAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489427; bh=ingkrN
    nzc6Iz/zIAit9tThoWWdsO+8rt6JJXAFeygIk=; b=WYLe8b0Zod7NcrMuwWEkwd
    RGtN8bjCxOmebS2kONhivgs8Fm7OLyNm680v6w4V7ZrBcW+i9dToBtuEWGDOtg60
    PIuDGBCdXmDuvSjBw/OL6x/Yu0dRAN4F3oS8d9tDXiiQSqwdapRzv6FBdDTE4bfV
    yTvhHfLzJ2Ii82UuFzpprkus8qXbwi+f/2lBL9mx7lfzRWrJXAk36dR9JiOBqNIH
    S1Ux4TrVrwDOMo707sYkXuSH599LZy7tWIEX/QPDlSIp9yt6RSMURtsvB6Gp1bCD
    Qc59++Z0+QJ3205h25SBOCk6VuLiIh2EidlKg2xn2iessjm0TQzSngU3vueLHwYw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1yLBRnQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1yLBRnQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965386AbeCHGJ7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:09:59 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:60864
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755357AbeCHFBn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 090/190] mt7601u: check return value of
 alloc_skb
Thread-Topic: [PATCH AUTOSEL for 4.9 090/190] mt7601u: check return value of
 alloc_skb
Thread-Index: AQHTtpo+SOSNqkTSBkCLsk85eOw+Jg==
Date: Thu, 8 Mar 2018 04:59:31 +0000
Message-ID: <20180308045810.8041-90-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:MjAjlLSH6sr25QdEEKb1lqYHEtUS6xg2AGvmYcNzd6dEjs0ICcWevhjjr4LaYyUOII/iPHKXJe8W1zAAkKJ9ZhDzY6sbTmtwXYSuKQpUMDkmQQH/P+yZRP4ez64HWUCVi5ylgD1wBPWn80nhMgeInnZxsDFNmZ9TISy2/NbmnyOAJ7NluVCThe79IaUNsSFBKcJIIJIdUWjFtAB15M6dGUTWuF387UzTtQiOBwpKMwSy4ftalh1v0inzcEXVs03N;20:256KoqjGH/IcqFJCmf46ScuQGvGWxTfnR6UzUbfxrPlV0gUKOrZgfz+LLqDoYTXyUcjRcnJ/LNseLFZfwvjLK8yYvcUzIoRumJxojipRRxjohRFC0VzzVjOxY/Hzd8vzoVqqkyHLjANrFEGDKgjQtwbVa+b7jB2QFiBDoUGtTAA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68681b57-a548-43d3-c3bd-08d584b1ab15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983A0B149C37BA8F49949B9FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(6666003)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jw4m4FOKcoZlvRX7xtzHs6ozVpWU2X/67xE3lTXOaxe6P1UzgiFz7N+JfdYZrUCtgQgRlLL9jhZqrbibl1Gxc4zjDA7IzcWDmcD4RNUshnOGgJRr68ETwcEOSy8sSd3S9S8Jy3oGxJS44uZY5o4EKT4rwXIWSBhVnEWlagnhx40s5BXyviBQo5NrjLK5b3ruF2YvCGILTLbvj8R5sbE8+ynBc7k7bDIf4tvPM+wKDZpdzuRmoEkOCJ+u1m93ZCnEBhza1ml6cfz62GDpyhbSR+RAb+RF1KA2ECpjVjOPguL0Huj8M/Y5SUOqPCUhA/8cXNpOsmWS2z4fwobY8/4UwA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68681b57-a548-43d3-c3bd-08d584b1ab15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:31.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 5fb01e91daf84ad1e50edfcf63116ecbe31e7ba7 ]

Function alloc_skb() will return a NULL pointer if there is no enough
memory. However, in function mt7601u_mcu_msg_alloc(), its return value
is not validated before it is used. This patch fixes it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wire=
less/mediatek/mt7601u/mcu.c
index dbdfb3f5c507..a9f5f398b2f8 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -66,8 +66,10 @@ mt7601u_mcu_msg_alloc(struct mt7601u_dev *dev, const voi=
d *data, int len)
 	WARN_ON(len % 4); /* if length is not divisible by 4 we need to pad */
=20
 	skb =3D alloc_skb(len + MT_DMA_HDR_LEN + 4, GFP_KERNEL);
-	skb_reserve(skb, MT_DMA_HDR_LEN);
-	memcpy(skb_put(skb, len), data, len);
+	if (skb) {
+		skb_reserve(skb, MT_DMA_HDR_LEN);
+		memcpy(skb_put(skb, len), data, len);
+	}
=20
 	return skb;
 }
@@ -170,6 +172,8 @@ static int mt7601u_mcu_function_select(struct mt7601u_d=
ev *dev,
 	};
=20
 	skb =3D mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_FUN_SET_OP, func =3D=3D 5);
 }
=20
@@ -205,6 +209,8 @@ mt7601u_mcu_calibrate(struct mt7601u_dev *dev, enum mcu=
_calibrate cal, u32 val)
 	};
=20
 	skb =3D mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_CALIBRATION_OP, true);
 }
=20
--=20
2.14.1
