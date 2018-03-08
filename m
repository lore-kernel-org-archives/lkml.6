Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491797-2-6570133474057480871
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
    t=1520491796; b=EpCoiWe5uxiQwwRa8cgW38hvHhQ448niWjXvPf6DProCViV
    7MLphUIADrzod4iYuxrddlut8QEPqV5fclwb67sLnJfcNlOqhzz5UACzXVVZ8ce9
    swEqTeg7fBUNO7GJuSoLHUhfBm9how0sFCersit9FvkMHintZjoE65iJGqVumxp6
    bl0t0bEd9bvgmWFIn3Ffv7DtiG7NJMUeq59PhmTlzrcOlYq+bZBX1i8q04DQcUGY
    zS+ByF48AsbI2mAA9hRynMpI4O+Pu+7APFkClRbAneOHioL/SCgT7yV2xUKqNDHm
    xNB90L1oGeD9JWLoPoTjWfRPE5nr4iT8Nf0C81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491796; bh=losky8
    f6qbjt2Id6JpIcqhCSbrY1P5tbB96Juhhxb6k=; b=qNB6ubu9C5SNw0vAOWUaar
    uJeOhOBQXyxju3YB+/X9vmOKaab2vdy30uExuBSY0VD05nKAjYPlbYp5wtJ3sUWZ
    MBodET9BR+I5JbrrKp13sQDtDVmQBeYJS0WuOTq+P7al6Q+rXZ61SV3Ucc4ZNvD+
    hdec8nt7YBXowAR9WeBKZ3UCMxtW6U6y8GOyn9+SEhDielMp0MB+5EUcob0OAIk9
    eMEi12NCX88AOkb/en7aXQMQpl5nnOZq7kHqIAoRtN8AQqAR4eLEUNa40V1sr907
    CpnxTHsYW58IA1l0gE+qyZlC+nWmMg30EhPkYO+MqNtMuhPWBUKr640avkCJXXTQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UXKQPaM6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UXKQPaM6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965070AbeCHE6P (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:15 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935224AbeCHE6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 05/67] media: c8sectpfe: fix potential NULL
 pointer dereference in c8sectpfe_timer_interrupt
Thread-Topic: [PATCH AUTOSEL for 4.14 05/67] media: c8sectpfe: fix potential
 NULL pointer dereference in c8sectpfe_timer_interrupt
Thread-Index: AQHTtpn47cYujzlU5kye4G/3ssq2Dg==
Date: Thu, 8 Mar 2018 04:57:33 +0000
Message-ID: <20180308045641.7814-5-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:E5wenbtZ5++aX6b06fd3zAwMP0Ri3vMK7uOuMwEyPnHJi1GdBP+7Y+j9pQTwDISY+/huvlK8RjgVh4LxBZ4Quia2/a2AkanArUoSveGoaVHiHMzm2atZSPEq399OuJ1k8RJ2uqYu58HUpmRrUvPqL6xhYX6moDvJZkyxV3BgHJ1ZzjNRY8zCPNA5ljhdCbtM53z1N0VSJvctJZEnONVI+yHglyKm7vk75gOBrciJhHgp4JQ+fqx4OM2ZR3sqcB60;20:b0rBCgNn0emiYp+u2r73uyjJ20mKznkso9DXOHMt7Y02olPFGvDCYp//FrpQqcYFgTiqqLz1VD7ChnM4o6FjeXeI08LNFis3jmvESnz+Xa3kJ29zFtHo2gj/FU5PJiL8NQlD3caJrLNopo3XtCusquLxKcjlQZmVwRxz4tQ0f80=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81b0731f-9230-41b3-0ff2-08d584b12cef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936414ED505A7EAC2E023BBFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(15760500003)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: o9MF2/yMl//qAPQaQdWMj2dvX673f9ypPPxpk6veoTmgQUpNRbTv7n06TOb55EZ6tbNzW5xsdhm7cyDsmFMBTD0goI+KO+1iAWSvNUCN7i1KLqZQu4aT1hsCnjSTfYdrs4sarTrdgj/j8LgU10D/7DnMeWrGsWvDpEyCXuvZZqCCBLwITuS4sT4YQQVegfzkkLlQXYwsmKca53hDGnpAjofT0cjLPXQpk/GkbD5fCvhTbVwCz1rzkKFDF5XuzMbJHS2Je8UWWN3uyvME01bfBpJzRsFhVbF6FhBr8oifOlgnRxStF+ZkquHis4s98pVIJQSM//yD7uyOXLFOzpXhoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b0731f-9230-41b3-0ff2-08d584b12cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:33.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 59280ac31937..23d0cedf4d9d 100644
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
