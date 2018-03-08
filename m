Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486808-2-10035611353307475616
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
    t=1520486808; b=LF3BR2uYG8zAqD3TcVSkP7ujx70EqjMiBqFBAPWhuOP/wTM
    Pj51trb1mY5CXI98viLXFnd6mCFJQMGyEYZCnT5+2e9Da5rqXewAKq937XyAzzIf
    wSFiYI6vpbQdpfQQ5QR8qhm+aiV3bUWrUvlbHlRoeqvwiswOeStZfs9ctwwX6AQK
    OzeYwXRQz+38UE9wlwylDSEU/Mt08RuU8Hm6ffkd+9HwXf18OM94iz/3nEgI5b6A
    dl5ux0F0gEjuepkFwWHLgs85IZGPttxYPk8rJHsgApVu7YLKzeY4NlDqbSlfJ55u
    iy29740tytw1brMyz8nWdd7o0wwmsABrfm5yUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486808; bh=/ZJwIV
    4qgSlbGUbA+qYyIQ3E6OGwh+UIRmUgct0SIB8=; b=XYOPF2DSGBgC4G61mBxxA+
    7byt9oRFaSisGmskVw29TWKnzvU2W7uSTsL/ehC/2zSAf62I2hP0C1OncTApRh2q
    Dhla5V7Nupykz/0RnSPWQPoqAsH9JLJkaIntq7KW8lQQQKiYVlUnXNmQR+webCmV
    67Xsw9cBQzoOOVxQfX8YfW/Rhs2amqRx+fGW8B3o3xleKPFYn/xJcSlJtDxpu6v7
    cUfjuGZjTz9SbCxBUFd/NKZYmna99GSXns5GbuYv/MpCBwCfodF2HtZMJZvvHzTv
    LYpuPpKNfYQembqDICIPVac2IB2CfABNweNnMqfJyQ4tlhyXnIzGDkMIeQ4WqpEQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kOBsh7J6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kOBsh7J6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966556AbeCHFHN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:13 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:41401
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966549AbeCHFHK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 079/101] media: c8sectpfe: fix potential NULL
 pointer dereference in c8sectpfe_timer_interrupt
Thread-Topic: [PATCH AUTOSEL for 4.4 079/101] media: c8sectpfe: fix potential
 NULL pointer dereference in c8sectpfe_timer_interrupt
Thread-Index: AQHTtpqbLnu9jQfMDkyxrOX+4gFxqQ==
Date: Thu, 8 Mar 2018 05:02:07 +0000
Message-ID: <20180308050023.8548-79-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:VOFYhpRx9W/Errh68edGby5D7vB0vIspiXNlSozmIyxtUtDDi0hj8mOv38uy2Fpy8SEGuCAwrnggko+l+lIri+US/6HETRRL4zcM6tFaUgtj9fJzyjWXtGnSJt0ckz6L0BA2QRT1FfBH4zDHCdI7TlIkkyDc+jbQbgqaMwquWeNt5pvOpHlS39fa1GQVb0y1ha1sJMu+KMHLnJsuUjoNu1Xj1K/++Aqr20GWqXHIPBfoVoAVmeRayzG6tC5w6C6F;20:Jev6gnzj5z5m/HTtYcB2UKygbCe3XK3aAAAe2PhnPL/DH3zTiFuWSkEroj0JbaOofNJTjLXk1b35q+YCuJlv/HHGjevGZbMJRWK94KRlJ1ovsC1fVeUzBFwUMqgwQDRkjPbN+7k+yEhihtRcf4T9EIXwZ16Z70/nR8XpPUD5J8w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1f1a6c1-1219-4b2d-01a5-08d584b27117
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077784A404FFF0C8CC3E089FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(15760500003)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XqRJ1574QdsDtljei5mws/ZguK9u/L0dYl7vrJkAokql0XpRnxRL22tZiJ1atez35zQW5UPD44K6MaX77VGtelHKBAGkNlDhGQWRYqlDZnvle1lCCo0pc3eCl1JsOhEdVCobmOCCKmj9vKh4jHy5ZKFTeq/rrBGbC9hTh/6EQftL9cH8anSvb+hFUPU4a5ygzGF9hKRh7Hi3pNcM/J5OMtKN+BmmESmOR6FRH4K8DMcfRhuEy70VPN2ViJ0JR6bN5XAp+CCfLpi5u+JE0svN/acMfoOGkFhFeqV+W9gDp2l9aAgXlgUgRoMzHHS83j7XlSE27y2EEY0VRHCGv/Xhgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f1a6c1-1219-4b2d-01a5-08d584b27117
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:07.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit baed3c4bc4c13de93e0dba0a26d601411ebcb389 ]

_channel_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference. Fix this by moving the pointer derefere=
nce
after _channel_ has been null checked.

This issue was detected with the help of Coccinelle.

Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support=
")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/driver=
s/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 8490a65ae1c6..a43404cad3e3 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -83,7 +83,7 @@ static void c8sectpfe_timer_interrupt(unsigned long ac8se=
ctpfei)
 static void channel_swdemux_tsklet(unsigned long data)
 {
 	struct channel_info *channel =3D (struct channel_info *)data;
-	struct c8sectpfei *fei =3D channel->fei;
+	struct c8sectpfei *fei;
 	unsigned long wp, rp;
 	int pos, num_packets, n, size;
 	u8 *buf;
@@ -91,6 +91,8 @@ static void channel_swdemux_tsklet(unsigned long data)
 	if (unlikely(!channel || !channel->irec))
 		return;
=20
+	fei =3D channel->fei;
+
 	wp =3D readl(channel->irec + DMA_PRDS_BUSWP_TP(0));
 	rp =3D readl(channel->irec + DMA_PRDS_BUSRP_TP(0));
=20
--=20
2.14.1
