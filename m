Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234892-2-3444071084998256134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234891; b=nWA/UNjKpnMstf8fepSXmE3q/4RZAj7tkc5cGqRjMttwRzSEo2
    MsOUZFuRoR02+r5Z/+gu3zZapG7p/zejD+kxGKoRDEGRUmEv4XykRFb2dQxRo1Ul
    vX4625PdsgjOz0hv9SKFkUVJY+sMOeFumtoqvlk4RyCL1zfj1uOfOMODeCt6lela
    PxVD1Hb/K+OKTNwX1xeQYhHv5pFpaQShYVnQCfPoGzKiYraGir/s/TvyjNBBDW+u
    ouxAGTSQs9bAkf975zvUpNkJ3LSCfpC/Ka9CgnVFN72k7UXCqTQR3qTHAlAhsUjJ
    0l2G/cT9E7mipu2OTvXqW6yLtcHr42VpGuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234891; bh=cxuAOp+oG6
    MfqXk4+MG6pfPStGdA8brM5KfHHG4a8dU=; b=aVcAYbQHUhl7uEFz3N+XybcLMj
    oN1NcfP7OwU8ePrG60nCgSQSwZc/2PN/m2Run2Bw4EGfAcgnYGEDr6roBoCRUit+
    gEbut439NBluwVuazBFGU3Y2Qp5X0Bf12VIyS7+2ebuSiIJXhI9s3yvH3KD/iMGZ
    RrHfu1LKrwdg+pf5PmyRjN/mCrKWTPbYWQBwngf9tl/WXDet3UoaXYqLdf4eYSG4
    KRwQZ5DLEAGzGL/7CIPCa25Ixds+NQWrupMTFSxJrqv/bbaQhKoyXAIKQx4RECQF
    jgkdNNGKZ4ixMNPs7sXKFZ03z/tFskeRmCWsaMybtoL4OFjUTUNBN3mhwGeQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V9IunfQg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V9IunfQg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJUZoe3cQhGL8iPZdaUBmZVv7FdKNwpc3XKlJqSylz8SRY0ba9WfSige36inJYDz8R9JgbWQYy2ABUUu8W4NIDjQ3eAUbQiFV/7mJiWsKRaANOiKx6Gi
    NlsWYi/X0rMXCGj07Gxk5TljstgXcA/K+RyMY37lwza1H8yWZRLPlWNF/N3GSxoCykCUG+KhfJQcU4lb70JnQAZZ52Yg0FJSps/xwUizLAvKzKCtzKJgHCPr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=Utfb4SCxKVlw79s-hMwA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756829AbeDIArr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:47:47 -0400
Received: from mail-sn1nam02on0109.outbound.protection.outlook.com ([104.47.36.109]:10733
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756339AbeDIAlm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 078/101] scsi: fas216: fix sense buffer
 initialization
Thread-Topic: [PATCH AUTOSEL for 3.18 078/101] scsi: fas216: fix sense buffer
 initialization
Thread-Index: AQHTz5uE9NxLRSkex02Is7m7uUFCww==
Date: Mon, 9 Apr 2018 00:41:37 +0000
Message-ID: <20180409004042.164920-28-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:v4HxZCuJEHWcnXnPqgfvl2izKmn67Ro1w06z4qJVHSJ6CRjhsowyyVnSmR91aBoT9+L6vYyicFp/uV+zhR39PGQQVqnRMvNQyKcY3WNO9wHvbmerS9UYzkzfSbT7vAKHthCKIhuY+EX5+Wa6uDi/TDYauddkX7ZxF+mCxR6KLcdXQ+UhqtuknCwGEi+SYXuogpzlmMJxMXtl0Jz80VChPaED/pLF+eFkgV+7Md4qsIA8u1sghlILJ5eTABd89oTG;20:cBQXFvN4qJNan4iFXq/LJTDRZ/OIe+U+hIx6UzGK0E0qS3HDwIaRiF8Pi3rAklsPpgY1/oYt00ve8b3zB4uoFXkefrGLwHrToYvaoQ2uEC5uDpHKNDLLfz8QdX82NxGyIdvsHr909F3pHhpB+i9PhN9hgbvjQ4xdKJtiPwtJ9S4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fa3eaf6-752f-42cb-476d-08d59db2a8e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062C1C5C09F580DFDFD6A88FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pDfdeRSFyeEdsYIufuOqj0t3WNlC+whISmY90+S6ygtgRXt0lbk8a1aYC9UpnpO5knvFqEUb/3THOkqJwxXzLz858q2ipOuyiU0CML+TUUumDe8einfefjrzSAWD/eiClHPom5k+iqyLdErFjMexf1757Rywbv77wr8qdOOHof0VqovSdO0Pvmc6mvcGpNTWj1/r2CUQUsW9ghAWw/X7wo/wZpUFUW/RsLHDVYzFI+5an5C7Z5ozvKe+DFlO3MKzO0QMHDXDDZ6XxsqrzRAIGanCOuLulOUFFDNoqhBDoE4ysGIq8SoKrV5TjYnnCtImhOL45Dnjr9eqgB03+zhkDtEc1ar7Y14tPAgqvRYJWRdevUMHAISi93kbPh5SW+WSmG5pV9MIIS9cNO1opJmQdAAMjeOCyPwUrmhOoiypLM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa3eaf6-752f-42cb-476d-08d59db2a8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:37.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' =
call is the same expression as the destination; did you mean to provide an =
explicit length? [-Werror=3Dsizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 71cfb1e504c4..80aa67df41fd 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2010,7 +2010,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
uct scsi_cmnd *SCpnt,
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->de=
vice->id);
 //{ int i; for (i =3D 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[=
i]); printk("\n"); }
 	/*
--=20
2.15.1
