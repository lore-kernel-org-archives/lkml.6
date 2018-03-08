Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489753-2-5314478095982685190
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
    t=1520489752; b=WPxVu2YoIvUJWjF04oGYop3Q1TKsUfv0r+/VfAlK09DgA9R
    iVDhyhoiZBIRjmtLgycsxlLBKin21SRFz8Kr4J9dyDRcSKKnQ42r7jEuSML+fLOQ
    EE+8IsLevuZ1xVgTUfbkoCMb/ha/kw4Uu6y3jHnY+kYxnivkdCZ4PTK367DEVpNz
    1mFnSWdfZ8TTYd9ygH2bsYi7T+4Oj50vNQzHS6K+Ff3rFZgXx4RhIVrwhafDYT14
    utY8JB31nxV5LwlFsUHkPQczB4Jl7X0dwKqSuheMzvwJng6fNkFKWdwbiA3/nRVo
    YmvN579kEPDKisPnKINyKIjmUCN9METic8m3mBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489752; bh=zCw1IO
    I74PYyEaXHAorUi5Y9FCBpJfUqk2XZVMaFAlY=; b=bRXQAg0N5P+lYiWxK7/hym
    FAk7r06BgJOk78P559TJbAdkH2BFHVsOd7i+6FOh4hEOkfQPcyUcwYTW8SmXO8iD
    4oTqS9yShwgzfPyEUUiKK3ueYiItEXWFHfXfE0sJMMiKgsnsBfbdJZEqcpTRXhqo
    RUPuHY8Z/cf4NEgLILHmAtpZhc/8EapAo2+UKKXszu3qAkIUHyxcSVHxKHvrAh8Z
    kVW22DgwaUqaG9wrQizQpyqib8ZCjJBvcXxgMBBPByhcbHjmGlvWux3le71h7zuD
    qxi4/jMtZuysre4gq9btHoYLhUQ/ID2UJKnBL1VM4KbjAIb9OHepMDKzu6rT89ag
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PQ+rIYk6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PQ+rIYk6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965207AbeCHGPO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:15:14 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964788AbeCHFB3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 067/190] IB/mlx5: Change vma from shared to
 private
Thread-Topic: [PATCH AUTOSEL for 4.9 067/190] IB/mlx5: Change vma from shared
 to private
Thread-Index: AQHTtpo4fznmhPyi6EGJ9i+DQue4ng==
Date: Thu, 8 Mar 2018 04:59:21 +0000
Message-ID: <20180308045810.8041-67-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:19YHiYVA7Nqwv+w+qwMQJFR2I5Mj0PaX1Iy3GDyAAcJvJ9lXghp/lC8/qvQS4DTE3AOwnpdZQYedjVCFDUr2At2xBJiW45Tq33v3Plh310U8nN0FXgzwGEPVeNUgACnHBniMtrZ7IbRwoRgm0SlCEPh/lm/4w2OZbGatCmRbu75NxiGWF1BsaRiL5/2USOqOYdYM0C4tNDUk1qfFYv3Hf4dQsO42PMUUgFvK6kEeT152hvRHNGrRB7VlkeM8WjYj;20:Nx1SekBGIzl4icEmnwBbLGWscTY3PohJknCmF7uHib9mL0KcHZyvzymRcXM3sb2pVjqOqk0g7m92UFfzyTvQErznOvNzs99ZOHMBCTXG/RkUtWWZsm79T4SdykCTQMLomOk5GOcLsLY+0S7yE1XadnVTe16T8BVIXLSsmsV+2J4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4de59826-7b66-4180-77d2-08d584b1a338
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999E289934DAA51FEDEB239FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: KBIxbhVg5rSbWHKpkA7DvSQOTRUJ1nShCX2FlWnytbdqI6VmkgNEX66QWNclojBYE3VAbt4nWqVEyh/iPtE6+8+fLuu6CJARp+zckUM/VuVhaFfAV5B2ww+UZYGI35P/ujgqYBRZXZKxMJ7qeaXQEjy97ehFixOK53IlHpFEkDjbAm/oGVvdeRVVZCChB2kguSddOdU795ANXRKENhDxWPs2rifkpGZIt4TD63G0/7T9743Bf3Gi/jTEndV9SNQ6sozGMP6akJpPRd2fBb2aPttSGj7ypCRUvhyzzHhGglIJWOVoaytqqD2WtZSU98MpgC03KAZ+sAnPV80HEOGnoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de59826-7b66-4180-77d2-08d584b1a338
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:21.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 1377661298d2820d675553d186c31b6f46c140d0 ]

Anonymous VMA (->vm_ops =3D=3D NULL) cannot be shared, otherwise
it would lead to SIGBUS.

Remove the shared flags from the vma after we change it to be
anonymous.

This is easily reproduced by doing modprobe -r while running a
user-space application such as raw_ethernet_bw.

Fixes: 7c2344c3bbf97 ('IB/mlx5: Implements disassociate_ucontext API')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 150227786969..d7da1dca765f 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1323,6 +1323,7 @@ static void mlx5_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 		/* context going to be destroyed, should
 		 * not access ops any more.
 		 */
+		vma->vm_flags &=3D ~(VM_SHARED | VM_MAYSHARE);
 		vma->vm_ops =3D NULL;
 		list_del(&vma_private->list);
 		kfree(vma_private);
--=20
2.14.1
