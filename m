Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240379-2-13914422085721885982
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
    1523240379; b=D+XvWS98DNU351fgmvMQR+Z9HDCzTJAGEAd7raEluzmZZVF8Tn
    1qIgQRchsZN3p045Dlfz5/TODdrXjPaF0E2I5gh/ygX9uAPW/pdPasSAOMRVSS+4
    jrsPT6b/tBCe0jDwfWdGDcGwxV4vPgQKixZSTy/qdKGro6XCRPKS6p54vJaNuO6i
    jxjipkqymm7KcrhYwftnYA2dWB9ClkewQfxBFXbHLDoxnYoAl8MyhfPQ0eP4Pqsh
    yx7zMkXYg695iZBNrt/tgeybXFs4a/D7bUCj5LI0cVuULRorzdYj+g8E3hiCwrka
    5Vi5G9ONfTR+qrRTy7PW1zlztKhmF3OC0aLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240379; bh=i+dYy8mO6h
    jS1+vbOw3sdiGZZKC0d32tdIngjJ07sSU=; b=w9nt/DB0HaVUwv/oWskPFiPNDd
    dZvJBEljiqaDvnx9jtmPkeJzbLdyoDlaXNSiKXzpsmi3Hj/eySmSIOH28ry5gvTO
    jq2phUiyLkjH//Ch6B/xgYCZzOsTsUxaEHg1XVuchYYhwkxT3obsW5WeZP7UJ88I
    gfjPAV4rbYdEk3d70/b0vpS3+8ZOIHuu85KuLxEvFRvxYb72hHMi3NBWuY9Uc6pP
    naMhsblOPZFR7oQQxj1wK7lh81OuHwfYbH/R2cBnZNd/e3g03EYhIZgPgV5Ji4Wk
    ui/nn4hoV3aSaYy8hpe8Wa2MTaw0slZ6QTizlktBpw+YXLgEhQR5sXaqlJ8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTVfaOdV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTVfaOdV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTMSDoCsq8t3IEdbe3vkn2VYq8gDSMNniqww4NOO2BtYVfgShoNYoImJoAr8iu9fwWuO11rZM4uZEFFq7lRZ+JN+vTW3MU4IAW0MnXCF0xn2Pg8sWDr
    NDh+f5KlKt9C/oap1HFfwrN8BNgHk7K9XLFEafKQWEwnymarBEp4GIMtiLfZqs+rgjwhm5lQM+LAgVUqh2e71Iu+FiZAscUROL+x7RXW2/JNh7if6jvkitU6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=uh3pEEOyBC-aNyoQVy4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeDICTd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:19:33 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755777AbeDIAaV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 126/293] libata: Add the AHCI_HFLAG_YES_ALPM
 flag
Thread-Topic: [PATCH AUTOSEL for 4.9 126/293] libata: Add the
 AHCI_HFLAG_YES_ALPM flag
Thread-Index: AQHTz5kgArvDk9X/W0ajqUJ0CZg0OA==
Date: Mon, 9 Apr 2018 00:24:31 +0000
Message-ID: <20180409002239.163177-126-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:svu7VaIlzP6iFoOVwBAU+2mf3VhrycM4S7KgX65GhelCG7I15IerQUhF4X0upELqMgUBiPs/wK0X9YI2zkFWoWiYkA3T+48EQ1Qhkx7myr0DIsP4x+ixHt5yNqgg6g8uEKPRC5yrNO2SIChNbbBcP5Zh1IIeBEX6yQ5J2eXqWJAuDMA//v1tIynmwqd1HJQcYQlVUMuxkZQLL6efRndFaTXKt5U3kMJT35En/cPr+5myLl/ITlwb1QcEUdIpnvBY;20:qs2f+yeoYBupCrD3oNtJG46ByZpWcmjteOBm1erA9VQmE1lVqMgYProbSMh7hPFIhRDtZaOJcWCaPzxUWNG3w3hYDCB5U3K1NVs9lFKPVaoDr6ZD4Gf5eVjcewIxdEhEArAMAsA1hNu9cAKYsSiJT/8k6fZr/Y///XGxyOlA1us=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b20baa-9aa0-4521-8657-08d59db11152
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103297198AAE5D87FA988DAAFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(39060400002)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Nbi+ao9TwDwE+85HumsnMWY8+HSU+5NRLP0YuRfxRrkE0kwqu4hYAYkcNtV6QZd4jF3Lruho3OOM1hFYxja6XA+R8gYWBIQwyFHu1+GTtTXAHxthYKJaBcQAuvO2xBSOLuSDDpfDu+MFsmpBx1ErxIwBf7UP/L7tJiiUx4soUzmjHgXF7LmDBSUbRo0hvO7MnjApZnVK5dDKz4oJNBHdugIX86mhY8yy7LcaheCe4iJgT6D4LY6XWfMX2jmdAtKPLNH4Lv1JP43usVfpq+kiVVFIbHaZO3mwmjkQ/GcPKm6qSGfBvDt5w+0uOjHLM2U8xTeYZ26RlD/QM4PeIsfzPXYR7ukeW0JBVlnIIgFo1u2ajl5hpUwEMLmgj+kNxK3UhQY62C23M8cIp38wA+PjYM4o+8DLlW7SGsxnvJ7TqMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b20baa-9aa0-4521-8657-08d59db11152
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:31.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit ef0da1bf767d9e557c6375c7066717eead54cb15 ]

Some hardware is capable of supporting Aggresive Link Power Management
even though it is not indicated by the Host Capability register.

This commit adds the AHCI_HFLAG_YES_ALPM flag to the AHCI library to
allow indication of this quirk when the Host Capability register is
Read Only and therefore cannot be changed.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/ahci.h    | 1 +
 drivers/ata/libahci.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0cc08f892fea..bd9ba1640b56 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -248,6 +248,7 @@ enum {
 	AHCI_HFLAG_MULTI_MSI		=3D 0,
 #endif
 	AHCI_HFLAG_WAKE_BEFORE_STOP	=3D (1 << 22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		=3D (1 << 23), /* force ALPM cap on */
=20
 	/* ap->flags bits */
=20
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0d028ead99e8..e9eb98a33467 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -503,6 +503,11 @@ void ahci_save_initial_config(struct device *dev, stru=
ct ahci_host_priv *hpriv)
 		cap &=3D ~HOST_CAP_FBS;
 	}
=20
+	if (!(cap & HOST_CAP_ALPM) && (hpriv->flags & AHCI_HFLAG_YES_ALPM)) {
+		dev_info(dev, "controller can do ALPM, turning on CAP_ALPM\n");
+		cap |=3D HOST_CAP_ALPM;
+	}
+
 	if (hpriv->force_port_map && port_map !=3D hpriv->force_port_map) {
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
 			 port_map, hpriv->force_port_map);
--=20
2.15.1
