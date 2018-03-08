Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489685-2-10457493010627445723
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
    t=1520489685; b=s5sTQHSbDJuvIrJ8iYBwcGgY7ZRdiWY+zAUF5Wij0guTyGl
    kdBt4tB+z/TWhP4AgHXvvCvhYvaFOng2OQuPlGKvui8aaPHyZKeTAwo1L4gikImg
    DrMGm/IXQiZKuqxHxH0m6zg+0qOfqyQX0TCrlgqxaOlcYHyCcTYxxlwlJa2Bga9T
    zF5IomPSyEiyaP4MwDYSlp4q+Y34LQblgQhbT+mjt56bFaKFRiu5PEAkrsTehKXD
    UewXVvUtedxuw4ixi6GpQnL8/L20v66oqb81khn7MgcEsO0qxG9XXncPcO8ak/CL
    ejrI5oY6AkkM1p9o2gpTXbZ2hRdPdWictgvYYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489685; bh=ibTG2w
    O7E8RKIW92owMvSWkeZzlCt3g3uKAsgp4f9yE=; b=S8EKWfpE3I8QfGvQs116Yv
    aKHVFxwHTUOBexsQr5V+5uVNYRL3iVdZx225QC21+fqEfnCtr52Xomsg2aQq79c+
    0FnJnEMmzu6y+ytItMC+91xXfTFFATwdyQhFqoJiZPkciJneHb5luTMgFJ6R7PAq
    j5h5t8AyJXflEkGIdBTmvsJLls625K1vmeB2cOMu5PiAS2TrR5tuXg7Av8MW10es
    02rA13S/AnE8ZfuAEpKyhoLhioMMWGeWq3zEYilM/2Q0XsQ7jWiQSOkYc7qj3Qip
    A2unX9Ps7ivWIDx1lg4KC8Jtiltj3+clB74OwFk2SKA5rriHnhGuDbNEuKQX9w9w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CA4Jd5zA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CA4Jd5zA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeCHGOn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:14:43 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964864AbeCHFBa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 073/190] Fix Express lane queue creation.
Thread-Topic: [PATCH AUTOSEL for 4.9 073/190] Fix Express lane queue creation.
Thread-Index: AQHTtpo61j+Tmw1FfUSmNFDUjrzaHQ==
Date: Thu, 8 Mar 2018 04:59:24 +0000
Message-ID: <20180308045810.8041-73-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;20:arFnpLttwMMJIVVPQl+HoTSvgIs1x+EydgCmWoq9YrkD86YRrBe1RLNyu2vN5ema6/LeDsmswhSdHm3c2qGVhf4QPG+GU9GQqbCGLjUUjoCtUpum6x7sbXtC0FTVg8NqX3YsC57sjCNEgtGs0tD4ZNDFgF1Da1EaM9uFrSCMTi4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea7e0225-b2f3-4ad1-f111-08d584b1a4ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090114C84BDE51061877FFB5FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(39060400002)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lmWS16qun1zq9Xv6SQ7tJm+gGTOghC9oXan4OMALWxA5fvR6KtHZ8pETDPef/VgIMxXjWWOye1AyQXp53nyKvpifcpOCKxF0YrNlY8+ZLRr6rDrgbr2YGt4KJpPXdxpM5E5YrXdt0/+eX44kJwdXl9BcYpyx7vZh8m4TY8kY0xiapicB6i2o1TrthLWO4C+PzBf6qslluCbaoDhB4bU9iQkulpg9z347xm/1EeYgodvN2ul9/oEpsHjE9ux021cQwAmSmsshq/hmjjYxlfIaZpX5DePrST/TS3cOe5mLNYh7KYkzjh2o7Htnd8k+xUz2+66TAmLnt/JcgMnbXJDXuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7e0225-b2f3-4ad1-f111-08d584b1a4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:24.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 7e04e21afa82ef024416f5413b5bdb66e0505bcd ]

The older sli4 adapters only supported the 64 byte WQE entry size.
The new adapter (fw) support both 64 and 128 byte WQE entry sizies.
The Express lane WQ was not being created with the 128 byte WQE sizes
when it was supported.

Not having the right WQE size created for the express lane work queue
caused the the firmware to overwrite the lun indentifier in the FCP header.

This patch correctly creates the express lane work queue with the
supported size.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f7e3f27bb5c5..e9ea8f4ea2c9 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11312,6 +11312,7 @@ int
 lpfc_fof_queue_create(struct lpfc_hba *phba)
 {
 	struct lpfc_queue *qdesc;
+	uint32_t wqesize;
=20
 	/* Create FOF EQ */
 	qdesc =3D lpfc_sli4_queue_alloc(phba, phba->sli4_hba.eq_esize,
@@ -11332,8 +11333,11 @@ lpfc_fof_queue_create(struct lpfc_hba *phba)
 		phba->sli4_hba.oas_cq =3D qdesc;
=20
 		/* Create OAS WQ */
-		qdesc =3D lpfc_sli4_queue_alloc(phba, phba->sli4_hba.wq_esize,
+		wqesize =3D (phba->fcp_embed_io) ?
+				LPFC_WQE128_SIZE : phba->sli4_hba.wq_esize;
+		qdesc =3D lpfc_sli4_queue_alloc(phba, wqesize,
 					      phba->sli4_hba.wq_ecount);
+
 		if (!qdesc)
 			goto out_error;
=20
--=20
2.14.1
