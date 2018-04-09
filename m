Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523237030-2-8817184650305007284
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
    1523237029; b=N40HPTyyZZSYm1gJekHo1igKKZY8WSpDGsqp+xLDh+ZK1INJnM
    eBuezlzH0jnf0OW0/0XQPzYeaLFS95k2BQjXY9w09XLeGd+DIX1oqaNvFmZ2h9mb
    4L59uE2VAYeivZTvGY1AaURgHKU9l5PfIr0qhsUC0rWHkYguIH0BKW2zmqZhJh8Q
    UA0KGrPff9Ffrts5U89eZ/kuI2vTWGDJoc1x20LMf2vaA0nDkqxUIB2LV5av+bbf
    OZoJYvu40qoI03tjeSLbkm7s8U77Lr5HGEUd934+UVikeZv0OBnkYKArFogljOns
    ngiwnKJC2wMbLPSiVsgZ8hX6L+11fjz0qy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237029; bh=DVEHcRRX9S
    rUJPqQJ6jTT7zkLBPHlnA6r8i38qyH6Yo=; b=dfpky8pEHTS6y25ZaOv1RiWvht
    QywdGWa9wWpVUCh7FfOtOxCKiJN+XYmfZuH2EaR4fbPbwKpp7Rnp6yjVnOyMMMRN
    y7JaFCUQLIanwyAptF2TFrJACtbaE8cYLcsbv4x4jbqJsP622J9wfr38awl6048L
    FsaugZKsTR1cEL+9dn+RpF3dW+3BJL4uq2wPgHqPIK8/eEd0EHhyAHLy62MPlQoB
    NRXimA2X4kA/u7EkVU6uUN2A9HVicVI0rLoll6rHLhoB+xKCxVAvszfF5sEmvbHy
    K0kqobAlIoC7QBFkAzA6yxPswDInywKkwsVvPesmqukUfE8gxv96S73uLW9g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpcV/0L0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpcV/0L0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNpkaNcK522enMyK8TUpLW4XUdNW1oh63RD/Q2CKQgaMlJwlu5zTa7BGuiJfbkIZVbk2A9GHrOEtQnEvdv0Pw57KJJQsywX6m7YR+LfUYnv89ht6TQaD
    KHlWyFrrVqlQXchpWjlfKXf8D3BwwyyU0buO9cDlf50KZDlJIEvAxGmk8f5JEy/4TmM0MVDrHhlZpaEIlynHr3FzOmViO5o3hA2LhXI2Cb2NpUjC+uIDROST
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=rbF3Xw_BdXdx--86PCgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbeDIBXr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:23:47 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932715AbeDIAhA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 074/162] scsi: bnx2i: missing error code in
 bnx2i_ep_connect()
Thread-Topic: [PATCH AUTOSEL for 4.4 074/162] scsi: bnx2i: missing error code
 in bnx2i_ep_connect()
Thread-Index: AQHTz5mzCXSQfkcuIUu77rGZ6izHVQ==
Date: Mon, 9 Apr 2018 00:28:37 +0000
Message-ID: <20180409002738.163941-74-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:2uzCna03uWo6ofZ0FL991GJGLBXIX8/Ej8WFwM9HwgLY91dl70u3FcULO46aJTYEQ44ZPzzkqTv+tWAAoXXX6Ofi70u2GBtOODeELY/GVKuONs2Mo0uEw9pSUIuexrYHtYTcyFeFp0oLYpxRUixnrcYOcDuONOeEsk3PcBciHKklWkcpBzKe8lJWNLTDZ+14eSHhOLttznDUKyqZQbGCnPtksS3WUFTY3Z25RzWIKE5cgvtobVJryhjbezLQdOF5;20:Oa0EK7ArYZmdin1vc7ItMaSiVyzEm+PWoqBVWIqtb7T1J5M7KsBayLntEM3reUSjdC+QP8v5WoQdqxAUH5chng3fuh95EUihwGWPXf8Rih32/otR8wGUXD7xNS//JBrVkbCcHf7CoGq74PDuhYzsYxNNlqhtr7MHT1cjM7jh3rI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9bf97b6-6563-4391-4f89-08d59db20098
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08854390F82BE9CB9BF46506FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(15760500003)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fkhVd7yrOvjvTLfPZwDLVSQUri1dUW9bIjPJk060qEUhOyItTiY9NH/HW2rbkHRTTSqeRAW1vYEMkx3YbF3rVjp+UBfjBfzIL3rG7etfMUdnIjd+VF0A8O9g3UWdN/e0ZZlaGonQIAHkT7x1BBtAhbO1PYylIMuKZ9XaIuaSfKgdY8C0eWCUEwEh6zy1qR5gvLJkXqxqoo8GfpzAAAzLfaBiTojZWuHEaSxBLjIgFN/KZNT8Zalz7IKOwKdLTM3z9x7a1F+5YsnYgtIi6C4KnmzXVWHvMORhDbVxgQZIyG08oLDv9h4smigCrIbRvvgreYM2NuGBkjHuUkA514aQhNKEGqX9tMYx3gcenoUfnXhPjYiT+JU26mOOzAw0UsywDkA/+oWLqfiazOWkawQsnXxYVcvXa3YB1CnvDa4AD3o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bf97b6-6563-4391-4f89-08d59db20098
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:37.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 72894378ffcf..94ee4bbc0505 100644
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
