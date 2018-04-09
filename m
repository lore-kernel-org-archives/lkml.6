Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246552-2-11944323081001191317
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
    1523246551; b=FedziuZMXG008sJ6Q+T+uIJUL0rHAp2EHcH6amt4Rp7UOu/n0p
    VBPLQADREFzPQxpTKXo4jXkJL5gbVU8oxhveusq/KDQyHeDAGYAvW8dUB3GafTXw
    eOW+xB4/TokY5vAjgMCGWJvMTH/nyk8uAn5+pwKA1yCUC4i4Aj44Zz19LLaDrpVh
    A13H4Z3Sv8VqFOS3OmwxRA2gButfslioOhp/1SUIFJTSzr7seyA0NFCM9Z631bOc
    QDsHafuFVMM3tSewz9ZL7YJUg1zsMbkSSKDYi8wDeZzAq44St2HCc4Iz1QxiPFaU
    3bniVfytnAPDayQUSJ+7cwQmVj2GC4+TgwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246551; bh=U9sNy0UgIa
    UznZwX1HSbJrhTx1gmOCQ2lyxnCSA3PzM=; b=AV7cg0PpQVgtSN1sZsjM3eYXPl
    WFlAU/N66/+k0gFOFz6Kt9nh3XY0UjW/H9ZPcBZmuhyuVDvjJ0/6g30gCwk7Qh0n
    D3VC9mqlwiVjx4sirU/jNZATOQkid60V5o/YZdedZ3RqDj7ZDoS3V+bU/I2BLdSZ
    fgsKp8Sn2zdVcyh0GbBYSXkWnzcGDy4i6AUn58WjZyMswsXXEI46W4zbSl45tHlj
    lO58sMbejy7G/9rxFpetqFBCwyjfMSKqN4gBFvj4Q5c5jgtnQxixdOt6ectMJyA0
    eyX1FVFJyeYHDHZS6Wf7y0xTnU2mkVTx3vilVjQseONw7ItnDGO9bTdZhOnw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HI48RNya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HI48RNya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNWB6i/aXNOc3akZMRHp93d7JZ0hF36USqIxZYo89sD55jjXr1d66WVEXvApk5rLAi5MAyF+/VYuYod8qgR75OG+0hKJ0Ktw1JsDpLCPnveDfhBx4EMK
    W4PCMh8X7g0/m/GS/eLyL+EbXzsEPIh+yT3eyGwuSgdFpUT7rYnDg3Tqv1lwLES2YZjnLgkRRxkAcEw/5Z+enQzKkDQOW03vYr8dikJxX6ank0EZ5Av+jCiB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=EGYj-OwPAAAA:8 a=fk1lIlRQAAAA:8
    a=yMhMjlubAAAA:8 a=q7ZBISJrZ0O5DTBrg2AA:9 a=wPNLvfGTeEIA:10
    a=xQyHFheebwQZ3wMG2Lhb:22 a=U75ogvRika4pmaD_UPO0:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDIEC3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:02:29 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753362AbeDIASB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 060/189] ipmi/powernv: Fix error return code
 in ipmi_powernv_probe()
Thread-Topic: [PATCH AUTOSEL for 4.15 060/189] ipmi/powernv: Fix error return
 code in ipmi_powernv_probe()
Thread-Index: AQHTz5gn+ZPv2eGjPE+n1YFtK7gkuA==
Date: Mon, 9 Apr 2018 00:17:32 +0000
Message-ID: <20180409001637.162453-60-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:bY1+QUreHreiPq7m7dcGDpK9SCoKl8MrwzAD9Lp31lCAuIm282UhkyCBDY0lTVksZpTYYBRVgm1QGOzlxG2epTCbRixnM+hccaVdy47+PtpimQ2mZPRjqEwIqEyvTd/EwGfd+HAK99IZTHu+zUvq7RbTbnwXR7O+n3oyl9PRU2Wbf4cq3Vp/NWLBzb+woB9nyTDLTxX7J+MWNupl8Pwim48+GKKLjzZAY5/XXp7z6DBFRujsdadJnO5IiQP72iaK;20:yqrk/FiR64sUlFmijX9eGdV6hC1c9BqxGzIht3EFs4MZXSrt6wqEkQxTj076fZOYe88trmCsj3N4OiIiln1EbAropZPzh0B6g501ZFlnj7tlCUyr/8u0bIDadY5ORdqwM/AWkUfhJRrTgluAfS+igs4HUNj7IsyZRvzqBSIgSQQ=
X-MS-Office365-Filtering-Correlation-Id: f6656083-fc0c-4026-dd6f-08d59daf5878
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10468DBE13A253C08BFDD402FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(4477795004)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hP55owXquCRqpqXzcZwqUBysvQtbMu+sOWVw+qombU4ZbY+ylS8P2umF81GMdP/AIqrQiTonZAxa5UD5slPHQ6FTFiDXu2RHGC2IufKNlKpU5pjffDDOFEMGVK+vgGAY+nUB32NjW44jNEkFecsIbOxD1LHsFcZO/acVi0QwLbCAs/hzuK6gABSO4/gcp4UsXXzjK9CqZs5BfXsRZOUvtGLS/dLE+9CyhZ5occ/pD82aVrmH4OTNz3AsOiB0liWDOI96stCRTLT7DuzlzKQOgr/74FZL0P3KgPOewLEyh1kcJCCXNHFfaoSv3SaIiqlEgoD7HHYB9kpvLlZsd7iV6DWpMomvEzol/6Pe6F1JlOM8aehugiHjFwvbMLPD2olw7sn2GB25s9tfD5Fh9xQghON7999CA2RUHht01P3MHeo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6656083-fc0c-4026-dd6f-08d59daf5878
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:32.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e749d328b0b450aa78d562fa26a0cd8872325dd9 ]

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powe=
rnv.c
index 07fddbefefe4..193baf31f778 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -250,8 +250,9 @@ static int ipmi_powernv_probe(struct platform_device *p=
dev)
 		ipmi->irq =3D opal_event_request(prop);
 	}
=20
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc =3D request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
--=20
2.15.1
