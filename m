Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241363-2-9492572121637692318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241363; b=Acx+Nc0Jr+GSYtmZ5aD2eD4Cj7khCpdWKbTt1OGTP25Xp5ld5x
    z4eVG+g3rwcEI13J40KfMIkxrg2pl3Lp0uEdPz4sstUxMIMP+QM4F2fQ4sxlBQao
    2DZZENcPJ1XOgL+2msmPK9KHoQEbCKc8IPgkzEvtMQh/VdUanlIfMMxM/6yIi7H3
    /eUNdmKfnj8ORPpgKK+OmBshBHs5Z/RIwthJ3cbQsapMc1TODwlKX+yLUybPOvVm
    a2ojD45AyBWE7CYCNajGjHhHdf67QrnBgaXO4HXBveFUkOOwLhUZ42ObAvutDFmP
    DkF1H0WCXVxfDaMn7iHn8BPOu4volMTdLUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241363; bh=B8NwzCfmzZ
    Alxjfb9glc2PFhLBDQ0tQBfBWAjD8bKjE=; b=qjmI2jKhy+hfE1tfO0PJj1CYJQ
    ZUyXo8nwF0+URp33IY/RVAQBtV0qwsVvO75qMgqXcP5gUoSX/PVXiheL+9S7P7gW
    Iw6/83x+pyLxRVH9M+4RjPGYViSQENDTNALprtieb5dMlOIIqjIyRNYu9pq3K9WA
    Rr3PfHVPWU3rGUmuZn0GS7E/AUWtjVCQ77gQMyO+wFu3lIOrjxTPTDAiVnIxYIoz
    fmm07KGDlRYqF3FiS4wkc6/v/KokHNYG7uyXTR7pmj3+g7ypDadEyZjj+tvyirOe
    eDiD5H/78CaY7lQEJ6HuYvuj4hW0TiyGEt2nZANaq+Sqlpc40iTPQtSyPZ0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lS0fQhKO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lS0fQhKO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6PjjxqAX5TLnD0G2miU3OBnO5VIZR9Y02mEboxQln2i2oDHyWKg8r3+hatQ4KlQ33ujci+LEh9KUPTIVraVXFJOk1Sq79kshBIQebiHNtokYiV238R
    GP/0QnACpZwKRcV6RTMPV5rp1qrSxGddYsxz1J0hbSBOQsNwMpAnBEKSXZFDYzgrblZ9Sy1iVfuE7qWOc1qzG16NfqdvvZJNUZNn8PhCEFj+vbAKwfAzeFJS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Byx-y9mGAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=isfTqjNbOI2PD3KCteAA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758053AbeDICfg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:35:36 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:11355
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755635AbeDIA1h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 051/293] scsi: megaraid: Fix a sleep-in-atomic
 bug
Thread-Topic: [PATCH AUTOSEL for 4.9 051/293] scsi: megaraid: Fix a
 sleep-in-atomic bug
Thread-Index: AQHTz5j84JIbDjCD6EWNA7Dy9nySLA==
Date: Mon, 9 Apr 2018 00:23:29 +0000
Message-ID: <20180409002239.163177-51-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:R4CjEsEKrq1rLNuZIYzc/IBT6/ijMAwWPjBuiY0e0T2hhn4aRO+14Y7PixvnVdZdoPV4wi4LF7ZMyDyO96ZnsCfK2osIfo9rdPwCL2k1Se21nePb+N63GOPJWFSvW0hKAGSroxJOR83Q9rPplPstN1+ly4d0zDZVFtSHsUOHb3bOUZzyXeubWVzmwygTCBZOfJysrvvyynw+P2k8LoSpYGj6ZtAsaztk2iuMojociWB10Q0W6PfOgr+hIYNXuxE2;20:mSdbWTZVnGGKBfD/FAKFKj57IHbr8z7hmxwMjIMvaWvdZSfGK1S2h0Q1WSGl7qeqbWrp/pU77eze/WaUt4W60naB7Qo7AFlwDvL4OeDKQuCo3wKfY4j3DcSImystMPWAS8KSqOpQ6j1l11bc7D5S8/PYp6GwGB2C1LxvsziZaD4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1293ab3-150c-4843-75bb-08d59db0ae65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103104DA9701D9F1803B793DFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(5890100001)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /hVLFc+YY2gPx2HtAIXl7OW3WKZ09OAxhULcuF7/17XlMDLkWBL/Ktvf0BKkQOmfcyCAS9jlIFzkdGFODjC7AF9/pegDRJM3DOpH0eFUys9tf+8g6PmuGjzjeSuyeGmXr9vIZka+bFRCaaQdFevevFjeH/LyRZieqUtwZtDTGNxv9dvC/z32mZYgBoD9L23YTjDfDZnW6FUp69+ZYmB5poPimTAO8QrP9Xt11cvaXcIjtRJ/w+RH1JEBpunfPRNh+FQxwPPZMduRmBPNhOWGldYYdoOyAAJv7Z97nqn39XZf2kpSmByxZBYeVNdlSrcwB2fDVMqdJisdWkrTgAFmMM2D/R5ohtMtsL+olMoJBsFMa6Ax3q1gz3oAGwjodyWKAt8soWhdcVWnFmKqc7diZPqNTpTLjsvOuK81MhEWkHw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1293ab3-150c-4843-75bb-08d59db0ae65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:29.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 896f6966fc815abe71f85fb26f0193875df8a035 ]

The driver may sleep under a spin lock, and the function call path is:
mraid_mm_attach_buf (acquire the lock by spin_lock_irqsave)
  pci_pool_alloc(GFP_KERNEL) --> may sleep

To fix it, the "GFP_KERNEL" is replaced with "GFP_ATOMIC".

[mkp: fixed whitespace]

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/me=
garaid_mm.c
index 4cf9ed96414f..544d6f7e6138 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -574,7 +574,7 @@ mraid_mm_attach_buf(mraid_mmadp_t *adp, uioc_t *kioc, i=
nt xferlen)
=20
 	kioc->pool_index	=3D right_pool;
 	kioc->free_buf		=3D 1;
-	kioc->buf_vaddr 	=3D pci_pool_alloc(pool->handle, GFP_KERNEL,
+	kioc->buf_vaddr		=3D pci_pool_alloc(pool->handle, GFP_ATOMIC,
 							&kioc->buf_paddr);
 	spin_unlock_irqrestore(&pool->lock, flags);
=20
--=20
2.15.1
