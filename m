Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485448-2-6885449272268088253
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
    t=1520485447; b=kPlkxWXX1Moz2Vif06MzM1iPbBv4rqmExC8GfucPNMZDo53
    IX8aQlSDbeA/DiG3Fbe3pJlsbggT7LKmWFKy+Q1g2RAb7TXhDgU/XT5N9v/bsReJ
    a5StD56kXuYRxU5XCrNUEkV37+Tbnx+iXPrMMv88b7JDr1rLny6Ae+SxUTWjSGuF
    rt+ziRAAl0FaMpOR6GbAu/SRvTGtgTWA2ZDPkJu+phx9yqSYevsIeXkGo46LEl+z
    4bSLopkutlmgIPn3BASvWpIfJO8qh5z28cC+CBHLPlZxZTDB6bHR94KWiroq5Lrz
    1xR6TnAm8T0Ya1767qJZpCbUO8tMtj2oX1ed3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485447; bh=Y64Jio
    lD0gPHc8nJqAmZ/wMqRM3DkmqalR3dGth0vM0=; b=buEQ5lY2q3kHkC4IYb7a4r
    5xVSqvyP8uzLsrnZ04OEy0l+Pyz4VwkrIUY3Fk8QHphgOtTTQ4RZ/DtlSAMN5dXc
    aUFedG7V0HplWxQ7ECnso6z6Qywz3foPEWANmUfr1lLzi9muJODbBgDWeB0n2Fti
    7n5VhZk8sLcCA53m45KEKtn9VcyTs08wpi7PBnJXC6jTdmSzSDUeRbfw05iCzj95
    4aGDxnzgBQZdNEAxksbj28Ov2oj4OBFgcyFukkzRKwkVthNkYJyK1MsXonhnWzBw
    dDaH1VmA1j2ww1xZVk+FwAbCGwrY3vZp/FCkYDrCfcUu3rZc4b3y8h5Lqd4Qv6qQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Szbj/rtD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Szbj/rtD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeCHFEF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:05 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:45512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966089AbeCHFEB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 154/190] media: c8sectpfe: fix potential NULL
 pointer dereference in c8sectpfe_timer_interrupt
Thread-Topic: [PATCH AUTOSEL for 4.9 154/190] media: c8sectpfe: fix potential
 NULL pointer dereference in c8sectpfe_timer_interrupt
Thread-Index: AQHTtppPF3FuaRPuD0O3f+MPiZUf2Q==
Date: Thu, 8 Mar 2018 05:00:00 +0000
Message-ID: <20180308045810.8041-154-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:GwU4g++CCgZD6o6bT1XxfR9UP4+RLQYnvjbp7t9oyfHYxXyDBtOzgBjsK+q4RYdD9we++P2QhIceIVBQD65iwaLG1YoTlsRcCmX5LUfv9HVYo3uQfl+r5h9TBZ4uX4wTW1deZCg4z/bsfE0629M5y/IGco0wscIT+T0U4KIajPg2sVS517LhbWEDNAvVx7OISHlaEgLefRlljEkWw3ayXqHjmsUkJE/neAoBNk2ToKHMILuAqNdbz8YhkVT52HOR;20:KtIBUxbf6JqKXC1TNT0kfahz5wr0hcrhI9R+gmCrCmsejZv1X7pvQq0eh69Zhx1vTzHdLJrWah1AK/g5/DozEx/+rBFHhtWr4kwNB2BGiAYPgMdQ1RQnnRs8uXT0ft0Kz+NfOZOle+KCbmoy6WeW1fuYo8/1d9On3PR8K9DWC0s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fe0fc33-de45-4f33-6e49-08d584b1fe3f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902D7FD83E285922D9457E5FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(15760500003)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qXYLQd60cfBNL5jfMJvyRyVWqSSwHyJo5SRMb9HPJb9ZLJzCWrcd4wdsZoIrQGbzL8s0wzjYSpAJpiYjMhERVv7lq2yGwNRfgy8cdRmy6JwCDcczQO+2skw2ZnDOXfb4xotnuTK6mrz0Vwpg/YlcwH6IpHM3VKtKtnfwdD5Wp+9LtLvI2vmyGfWKpJWKLeSZHKN6zmW6Ro2uzyG2VYYa1YMtkECH0dwPU62oTh+G/YwaWnnSPOVEEFG21AJWyN99JzVOU59lcB4DaX8gEav2OSdt3mA79Fg/ZxNcNFjUO+jy5AKqal41wJXGm7WeZZ/v9uqzKcLkz5qLPz4dyuUqcw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe0fc33-de45-4f33-6e49-08d584b1fe3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:00.3356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 30c148b9d65e..06e2cfd09855 100644
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
