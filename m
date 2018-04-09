Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240063-2-1785628659713962107
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
    1523240063; b=r0Njf3OZ0YBXkRfVcGwtQZWogObKVFRldbXQYWBrFausFgylEX
    FUqJ64R/eMNhphO8A+7ExAdEBryBR39xTtVbkarGMCub3+kq1Qjbx3eCNIYAQwBg
    EhxWPZZStHiYz/8wZ7U6NOxAhetVoVHiqe6tD307BTVKyAwS940p1zI9OJ4Yh8jT
    OrnqMNg98p3q29LvBDkGLM2ZM5tWAj9MmhNO8mpT0IjdznqKBNWMyxFSDq8nsEPN
    ObRvBTew3ESmkwvROR4obrPJNEsh3wGo9l2hUQ02qf7WENwXYhftJBbC76i+Cl9U
    0xlMmayRd1286LK4N1ygbL62P+U1kcokwAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240063; bh=Sv6reaFl2A
    iin+6yeH1tpAamhb4GD1RWhhVvsjvApwQ=; b=KSH8ANcLE/Zlakg8TtnqDwU2a9
    PnoYxziZhStN8lnYYoXAjN8JAkbwnorn0B5MdAW1Xs3ypS5wj0Xkk2jWKLWwUZ2s
    YEeOG8AxJhdjTvALQu43vY4awVSl5UTlLTVf3sei/gFWPo+UMg457FeGtERvQmZZ
    niEBKJIxJfLjrWoRVUeV9czzNKErEayAZOrVAIBBV0svDSYw3/d2Hr0/sHBdr8Pc
    NiOMvGljKy7uB6HHPc+amHZ7LjiIz06QFKJ393IT7FSb1UJ1R0Xd6iNtcCGerUHY
    oFX5ebw6n2GL0m69Pp5LjwqGsG0EGfZyTYMVYiPdbiZ7ZoBtd6TIt6WXIKnw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fFSYqVu2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fFSYqVu2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLaAAtu5Y55Jd4jmwx3Fuq0DZSZ55q5fQ6qD3TRQN8/cW7s7C20VBld8GsmzUk9TyQzB2r52USMh9FiOlAZBjsbjEzpR5Dm4BNvg5MqIloCtsvPNwVBh
    5ui0wnKByWurIlK9qLCtfCtuEafpK3Or3GLdtNfPoh36vtQI2kS1D2U02hTyh9PfkkxxOgn86K+bYsIINStDmzLxspkcER7KQS8jUFxOOOhG/SryAYgW8UUU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=rbF3Xw_BdXdx--86PCgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756136AbeDIAao (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:44 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:52647
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756123AbeDIAai (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 148/293] scsi: bnx2i: missing error code in
 bnx2i_ep_connect()
Thread-Topic: [PATCH AUTOSEL for 4.9 148/293] scsi: bnx2i: missing error code
 in bnx2i_ep_connect()
Thread-Index: AQHTz5krFuuJnnjrUUqM3fz/AYPDZQ==
Date: Mon, 9 Apr 2018 00:24:49 +0000
Message-ID: <20180409002239.163177-148-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:dXW8qJaYcW/VcVin6Jm5RR95I7/j+j8qBklpcm+wx4xZM71U5tL5A4+/sXVaCvlJw8jcZZc/Qv/xYvFRCWQYLtDf23z5Q/w+8vth6b1f73Xp0QmHpLWYx9l45L2jDUgv8xYc/A2k7X1jUKzXEwftzT/xYLIwJzaBQ/45QLmIoYWuksW8DHTAMLqpJf9x94GR4aqvrruCon9/+5Eg1Y+GURLn5PksnpdssTrk5NCBRRlmdo5mXLWON4T9I9PuxB37;20:D9mgdH5yTgIb3J+RU+ztBDMmulMJeKGnCxH1vEz1R9T30zVyRN8AKxVoZ8twUx882R/cb4zBQ5xX/xC2B1f+r38/Iveo8WrCmH6rlliJ7zH8GOpPWumWTCcpGCCGrQeP9pUYALu3jo3zPAvMQjviqdT24pLO44nDki85lp5XwzQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61222de6-9cdb-4f25-a4dd-08d59db11aec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807524882B7AB75743418C5FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(15760500003)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: f0be+0sG6FbFc6GZ1Rvh6AuzRKu5gWoaNSSMnECeerrv1O0Lr9X+qw4LmbGTTZxKOLje9CI+8JYghCqZK5wPQy0xk+A6OD0rVSV4M566XtTl+baYYH/15JQYLyBJEIgW9imbEzUSfm1nTCG1p89tTyxXE5ajfM9ohiY3C8wuSozNoQyZx1w1BIn+IJMAFiU1DCY40Nv7L2CYOiTlGLiv5exqFFsHVAkPKLXKZmW/aJsy1eebhVcFw1m8Gwyy3R1xzSXok1gNKeqTO2f44/Ou815htowjCaNk4/9ktLTXDGobDayunbageo3PAJel2d0OXEKdX5Fe/Vv1k07ALdOrrcJwp/RIzxnOwx/nJsxKpDTX4bM6S6cXIz/5UH26GOdohgFT7PuGs3/mFp2TqcXRIE5TQGf2PnOLoxOUdtv5H2U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61222de6-9cdb-4f25-a4dd-08d59db11aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:49.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 1d32a62c74b3bcb69822b0f4745af5410cfec3a7 ]

If bnx2i_map_ep_dbell_regs() then we accidentally return NULL instead of
an error pointer.  It results in a NULL dereference in
iscsi_if_ep_connect().

Fixes: cf4e6363859d ("[SCSI] bnx2i: Add bnx2i iSCSI driver.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/bnx2i/bnx2i_iscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_is=
csi.c
index 133901fd3e35..24c920d3ffb2 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -1909,7 +1909,8 @@ static struct iscsi_endpoint *bnx2i_ep_connect(struct=
 Scsi_Host *shost,
=20
 	bnx2i_ep_active_list_add(hba, bnx2i_ep);
=20
-	if (bnx2i_map_ep_dbell_regs(bnx2i_ep))
+	rc =3D bnx2i_map_ep_dbell_regs(bnx2i_ep);
+	if (rc)
 		goto del_active_ep;
=20
 	mutex_unlock(&hba->net_dev_lock);
--=20
2.15.1
