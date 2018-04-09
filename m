Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240051-2-17954701394280747528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240050; b=IpmWSZep8P0YLLpZs+INZAExQ10NEdmuJrcBE8I8r8p5Tw33Zq
    LEcFDPrU8T8Ww1nzJkhvPNpe16riryiEnqrH+R0XxagzR1wF2/KcYlL3OeB2TUU3
    Q+ubxCgltANwdJUOgeyxjg2kX4eJ6mzAvx1ooqeZLRoTDpaiRfmewo/eg8meZLJE
    dYXRI6wfDfDI4YRRkU17EHsEx9tGTspZvW3qmjpdIGar0iD0bLwbPbz+gQE0ouQA
    nw2LrJJm/6wHwZTIGl4bNujOUEApDpC/I8JgVNf3Va5izRF9W2dMHK9P6pbaUt1T
    XT2CF1DbfMHopxhK6sBzLpNrP2FGry864Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240050; bh=PMh7TcrKyr
    l3BAqELtodm9eWigni+3eH3zn+ZIestcM=; b=W+BYu1n12ZezbHkHvOJ3mKzmNE
    5YiljUTh+c/smQ5bcLYUOhaPADIX2X2OIWG8ROWQXczntSI1RWmqFAp5f9GEjCMw
    dDIs8qo/zzE7Ku3OY/qlyPwIUbqRadEw09/Wy5ZsAfW8a6NCmR76O/eNmulbFXZB
    vTvv5R660RcGtXVxpToC6NVk4j9nMx8SOD5I0+q5/Gj9nlhkGDn8JZv0WZ+Bf7Qs
    8SF1L4APfBGbQE6/8FJAoDvXhp73BFRkG/1IKLH0Et2If6jIjPs7ASF7VgADVAsr
    cOash2r1ZgF6UL1JciauqniOhk7XU8BicrqkyYE9mj4atc8lARwVewMI5VGQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kjSqnqSU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kjSqnqSU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFOfOcYqsq6MKnGAvsfMuHKObx1MXKhHpeDNdkkb2lNWXNwOI5EHtzPx1rVD1IuFHiH8QStkW/T0WzS3WondV/KD/gcGk94DyTfCN5Fm12bm1Ft34vxd
    RAOeCD3AGzAscmBILHa+LkDgSIGjcASuT64dQLGeaKpT+BN37TTMcgDVvORT+gdNujC4YDEGZCEHkOKyTk+MaYhq/vf9LRMYZLvXcUcwXFd1+/08naQJ6EX3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=Z5yqLHp-0Zm_W5QtMCIA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756264AbeDICNw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:13:52 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754856AbeDIAbJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 155/293] scsi: sun_esp: fix device reference
 leaks
Thread-Topic: [PATCH AUTOSEL for 4.9 155/293] scsi: sun_esp: fix device
 reference leaks
Thread-Index: AQHTz5kuohRTMfZ3xkKGgPsNoNaDWQ==
Date: Mon, 9 Apr 2018 00:24:54 +0000
Message-ID: <20180409002239.163177-155-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:nk3fGyt5tKTPtYovOdKjgH295Nm49ve/QXgwNBrdtIgyTzFIRaZnk61q/WW3ZrBq94bXILiGzcu7iMP23cIaKX+D/Cyk2uEwH6bXpIkf4oEZzFNntViQX7jqX55cmjbJcBJp/wYj0wI/O+JdQ2a139okwC71+8bmqok5/cHC8TsR1SK7xpOda4n0q8RwSYJtuCp3sY7CA7gSI5MMFhpsEknoJXVJDMz9ME+rJoVLGGujT7eFahAc6r2zner0LhJn;20:GZBM79vDV1DVUtZSZUi7w8T28cmwmB0gLfeCEqHQ88Ya3nJYKwI4kLnDXkiGDdLTq7r7sWL+IAyhNdcs3Qc89G6PqCMKNWqwXtwVGb8LZ9HfIilNPJnhujwb9gLSVt0vq4AEGq3NcSFPdmxp6MFP9F46P5c75fKCaFhY8jN6F04=
X-MS-Office365-Filtering-Correlation-Id: c89775a6-9a15-4632-f472-08d59db12ff8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917F9F5DFA0EC8C792C2516FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aUGCoAhbuWbGi8IVacT/n8/+TC0MexKiwZ+eZ9wkP8gkSQS07+bRzxPGPG5mAQsDDlm/46svsyXzt1Inu50yjY0huDLiLeat8Q7+LeGgmFzqBnBZIOQaszGPpbnyg1pknp+adr0dzUoT3cvGTgcbrIW9tKXPwzywiFh+8Y6C84yRRoJ++Ql7BYG12VWwFUb3ZSCUMnJK+cG6+icamn2W4BFf/jXtMVp2s+A6wmmIA1u0TETwnarPwxV0WlSc5qe6UlqvWQwAflO6cX4FLOnMkfnTQehFM6FhBpvd1ITODFmz4CYUV9O7YUqf5JLDQpLc6YJxSqeLM4k6se0YrEGN31yTqUHiUvT37tW4CjLX/n5tSZ/BqldeAW10X63Zlzc4an59rzXEuQ/OPwDlgM7VDqa2GkEwYpJFH1/Vf804Oh0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89775a6-9a15-4632-f472-08d59db12ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:54.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit f62f9ffdb5ef683ef8cffb43932fa72cc3713e94 ]

Make sure to drop the reference to the dma device taken by
of_find_device_by_node() on probe errors and on driver unbind.

Fixes: 334ae614772b ("sparc: Kill SBUS DVMA layer.")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sun_esp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 7b6d4c2087d7..747ee64a78e1 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -566,6 +566,7 @@ static int esp_sbus_probe(struct platform_device *op)
 	struct device_node *dp =3D op->dev.of_node;
 	struct platform_device *dma_of =3D NULL;
 	int hme =3D 0;
+	int ret;
=20
 	if (dp->parent &&
 	    (!strcmp(dp->parent->name, "espdma") ||
@@ -580,7 +581,11 @@ static int esp_sbus_probe(struct platform_device *op)
 	if (!dma_of)
 		return -ENODEV;
=20
-	return esp_sbus_probe_one(op, dma_of, hme);
+	ret =3D esp_sbus_probe_one(op, dma_of, hme);
+	if (ret)
+		put_device(&dma_of->dev);
+
+	return ret;
 }
=20
 static int esp_sbus_remove(struct platform_device *op)
@@ -613,6 +618,8 @@ static int esp_sbus_remove(struct platform_device *op)
=20
 	dev_set_drvdata(&op->dev, NULL);
=20
+	put_device(&dma_of->dev);
+
 	return 0;
 }
=20
--=20
2.15.1
