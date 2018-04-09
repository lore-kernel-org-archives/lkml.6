Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237750-2-8184458931541902167
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
    1523237750; b=b4gtaFY+tp209faTj4ta6tNb4Q3B9G9EJvmFpSphgZKRSXhVp3
    6XH4PoVUVbGzZ+9/3iK5GlyP/Y/B6vgdSIDYh+bxe/kHsrJ0JChHuEt5az/YxqAx
    79EVp3gsoBbPT9eIkG0RDw9+tavpudd9V7WEEECnWptOYzL0wOHJVo18C/wM5gju
    ZU8n64gi0gatWi/Z/hqqO8E8XcZfvAeFM/PC3wEPMymcA9sH8MIjgwGYqUCWPvSv
    15DOqWjlr7OqrG+ckQJLi3b86SaxYValM6aPPCXm1P6AvF3BR05FmPIXsCxTzHZt
    YmDmLZHjtxBb90D3Yxo9Go27u9ecjSZxb3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237750; bh=e8UDj0/H1V
    7ipQyzatHcVrUOw57HyTfFQ4om3LgXasI=; b=V82XAXoI6ovnsQKHZkvfhIPtGH
    zd5wnexJPHnhfHaOBTWfcHzABiufFscxCUz2zEALSqs+hT6fned2C6hJkfYimiG+
    SBXOrA94eLMxyRjEDsN4Usz01cSGsqAhzO/3VXfUY9G18hHdFNEZBkLWdFY8nub9
    uf8qGoT2CPiANUyt977kNl+LfY0KUGpKIuClbGFvwkEVBeacfilRUNIA3+WKWlaI
    pNeakgIGdXAXcbA7lxmwGSanJeaBcmnY5t1yLDfMVUgUYSxeshOVaDnYKg7OA7mG
    YScfA9TLCFviqzLaLBdbCnGdmNevEUTNRqPzRjrEeSasNTEsUMnMyy5z/lMw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NjpbBqCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NjpbBqCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHboLltpk9+U+4RijnEyxx0YPZuuvDEthUgy3DkGbRjVEW9kNRt01K/IX01Nw5dwSTsPnobQRA/i2hfY4CJdZo+B4YbMHSAg9ia6vUXEDJwhSzs/1no
    VJuw3gmLRi1OJ12g2NKOD8mb+Vg+k3k8CI64nlp+AopjIwCVncj4/A9m2OEs/W2ZxwWBhxQErYTkIjDLQAZRncEmJAmvtZyqV9gvjkEC09SCKZZrDLLlgc8B
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Byx-y9mGAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=isfTqjNbOI2PD3KCteAA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeDIBfg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:35:36 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755736AbeDIAfI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 024/162] scsi: megaraid: Fix a sleep-in-atomic
 bug
Thread-Topic: [PATCH AUTOSEL for 4.4 024/162] scsi: megaraid: Fix a
 sleep-in-atomic bug
Thread-Index: AQHTz5mdAg7uyGxtCk6uLNgT6Eo5Ig==
Date: Mon, 9 Apr 2018 00:28:00 +0000
Message-ID: <20180409002738.163941-24-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:TsBo8xKRE9MrqsF2dpptasoC1y/ucAj15TqQy1AZYL88eN/bRezR2sxjAd2Sn7BNrsQRIpisbEgNN2rVb6XuYyVR3hmLudMPN3aGF7lZg0VIXrfCdFKb/SrsxuUEklbyXH+h00q4cbar+Ngtrw//XWqJjrhMFq2fhBMvORjkEqZSkpReUhT1aXTOkO2RPQWv5MBDR0ro+QCJkcVTxLr1K0bRdk+YsHTJKVQd9pIgBHzAMUaf3L8k/VtLKX0ta+i9;20:ASemaBuFWshhB7FV4YueM7DGK3RWR10a0V0GxYMXQsDRnWWboORKe0NlWLvzQuqn6kA/r7aYPNY6EWTgVT7mkiqW4V/A/n34HTh1aHBpM/oknWaGd3wzqTm69Hedru8BJx19ScrhRTh6yF+hJlxc/JSeWgaL81n+hnvF33s38RQ=
X-MS-Office365-Filtering-Correlation-Id: 0828a6e3-84e8-4ee9-ea5a-08d59db1bd9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101356B30CC3258A005E66A7FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(5890100001)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EcMR3Zu2aoAoDKiUwHdoEcwJ/4vEOgzer5jlOJ3O5mmn/FaESA8jobC9GE2IL+xUxTbYlhpNDSlhi/74H822JEn207uGX6zNyqN9qn05PL8Tcjaa46LyHxq8242v0B0YKgDUfU1Q0qGjF5zTonZkti4XLH5e1SF517xAiqdXhOekMp7r7e/H7Av1HljreVoN0+PUE2McD1rrRvef7U9RhCv0MrpRKA95h5KS+nn83QqAztAN9TUvk+UYgIi9HHXu1V6PaETCqP3vGn8yyXRK32mRmEsnSyVkcFuGbZE55gubQ6ZYd3msyxfrM+pbhPCfkyPosi0rEk7M8v5GLo2y2CcW7uVH2emIJBIgZZtt137sGgRPUZCfw7RVcqQto8jnqmvqNiwmH0rTpq4+en1kVSTWhgNhss1myYUOtF7Y6Dk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0828a6e3-84e8-4ee9-ea5a-08d59db1bd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:00.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index a70692779a16..bfc7984a1c17 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -570,7 +570,7 @@ mraid_mm_attach_buf(mraid_mmadp_t *adp, uioc_t *kioc, i=
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
