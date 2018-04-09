Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239789-2-7036814608209815123
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
    1523239789; b=VuMzWYHaVL3h7Im2FS5gZcnGKz6g0xoUdFpUEIl4TxNHXbUnvF
    JnHHGkqQyJ4Bnfqw3kS9rnC2Lbd5gi3UnJMqrufMFve4FWexZmNM1mqqYqTmboSM
    KCPrmgDxpRHjaNnFo2nXyssXtKL5snhWCnwgAOn2t0+B1PWep/x0z1yb0Ic4FQmS
    ymGJ+0rlNQyC5S71Kncp1905FbnsTrD2NbNbNRCYnLz4GcA9vPRiNRFwQz2RRuoT
    Tw3XNjVwx/DuZzzl4w3xlGySdDKfTVcaOVPD7LjXwWIoTY8V2q/dRDlh82466QTg
    7OO+T7VqWxKVJmak8YrihG6x7gHTnH1usWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239789; bh=Iee8G+mgZR
    ubogqk6Sd08ha7Ez7oo1impZ1XlR/rMC8=; b=Fa9ls/4yZRABVc7Orsg5at98Qd
    F2arrdq0m2gYGootp21rH9YSyF/dElqGQS6UWmYoEZ4mb5H3uWLUDgRMBF3FyHXr
    2eNAu1K7UX6it9XzazmoiIn6s5PSZ0Iz2FiyS1QyylATopyNE8gTUZxY1lIZBV5K
    nBlavyLf1/51qV91eU8nWGQbgJnwOcArH7uXbEYebMc0tZ7osuFG8QnFTFA9hwuq
    tMUw99uimIVe/8uMu8ApQv+s5rU5jpk+S1BCwRDh901kiazTI7B3SE4sSYTf0NQk
    J0A5weCE17vOxYytFsdd2pXV4inYFV28ImRC5zyo4dgago+D3rT/rROPHayw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ssx7key4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ssx7key4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJozp5/Kv5obixmxyP/zgyY5U+UbSFvy2JjHQrTG7Kz/W05Wsqy1B9qPkttI/aIUdV0KMaG8tYwqXidS5qCtfrFRM1DjPaT70MCSTrTJV5z/Gunc0SJ
    VIIi6hbpswamY69BqdaNvmT525b8Q0nw6rYG+TwIyawUtM9ik/FXDcBEO/aldafVjVOJ+rd7pkoo4lqsHsmbfl6ehvxHWOqlXpkSdmR+j8io5gYVql6zT93r
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=Op-mwl0xAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=CXCrUu0I3pTnwKueyNQA:9 a=wPNLvfGTeEIA:10
    a=_kNtSFdpYmJUICABlfa3:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeDICJa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:09:30 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756238AbeDIAbT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 165/293] libertas: Fix lbs_prb_rsp_limit_set()
Thread-Topic: [PATCH AUTOSEL for 4.9 165/293] libertas: Fix
 lbs_prb_rsp_limit_set()
Thread-Index: AQHTz5k0fGOAk3+3mkqe+BXA3SWFkA==
Date: Mon, 9 Apr 2018 00:25:03 +0000
Message-ID: <20180409002239.163177-165-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:whsZ6SuQKErg6Gig+msT2Fuyfks7YEX30MSrGQPRGFwaBS58mOdTaEeTJG/Af+TSYred/Ukti67oV/K8K+XX17kEfbOp5djHgd3FRM1zhGZV6B4GlbOJHW2pU+nCzrUdDgJGPjWhfMUECZjchxqyLfRxNxe2KxHpGVHg3zx8i0Q1KitEgBte2oa3pPTKVRF7+17b5KePqNqe/jegjrQEvv6ECqtl7eGE/fOCTBef+XkBNpmcoefPYmYXH4891HQJ;20:mAxKQ8X4Mvpj28It4C00iM7ow1s9/dQsjcSzR/FUpZlfotfswCo/vDMCph1kYmQCqgXLoXYGMdES3wHJkOXAwBUuMYLeL3rvKg8UtftiCjVg71NzdvYaS1e0jAThksy4uVIZJF0jIR4Rmg2P9JXz53me8JdpwEEDIylpEYFyBgk=
X-MS-Office365-Filtering-Correlation-Id: e0f8eb94-49a3-4959-031a-08d59db133f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917BAF9EF616D5615C1FFDDFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ixUt2arc51utovJbnGPz88d+/s9Z47L9MYgnJ0N9eB4EvnVbQZBAV6M9LuG2gfhVFEPIN5vLebHsBcC0DGcuVHFZqMr96jmP8s1NKeJgYzhN/HJtRTFozlror1fjieqN0TOy19Nl5U98rtjzjvg1ObDwpVwWqHKWN2cF8TBlxr296g7Ozcf/p2glyNKOcyvWxQVIHVlIH9NbNF5Na2j1U5Bstx4USZhh6T04BYX7PUXnKT+YE7CCu5AuAAwUcJzNfB4QLtlzIqPuOiuHc/NNeQylHW27+vKJXoz48tug13UByrICNcFVMURWZxImyTfcBh8DIr3Rc4gbtLNJ5d4dn2oMedk0w40MUQREnvEwEpRpVNS8E80PMGTfwdKZ2lpB8zP8FwZltekMG5pTB4ah3kF+wr/Q9AgQ7FlfoXOzH5A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f8eb94-49a3-4959-031a-08d59db133f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:03.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 69551f5f370cc20342fab17ca54716b6ec7e332d ]

The kstrtoul() test was reversed so this always returned -ENOTSUPP.

Fixes: 27d7f47756f4 ("net: wireless: replace strict_strtoul() with kstrtoul=
()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: James Cameron <quozl@laptop.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/marvell/libertas/mesh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/mesh.c b/drivers/net/wir=
eless/marvell/libertas/mesh.c
index d0c881dd5846..a78c4d18fe4b 100644
--- a/drivers/net/wireless/marvell/libertas/mesh.c
+++ b/drivers/net/wireless/marvell/libertas/mesh.c
@@ -239,8 +239,9 @@ static ssize_t lbs_prb_rsp_limit_set(struct device *dev=
,
 	memset(&mesh_access, 0, sizeof(mesh_access));
 	mesh_access.data[0] =3D cpu_to_le32(CMD_ACT_SET);
=20
-	if (!kstrtoul(buf, 10, &retry_limit))
-		return -ENOTSUPP;
+	ret =3D kstrtoul(buf, 10, &retry_limit);
+	if (ret)
+		return ret;
 	if (retry_limit > 15)
 		return -ENOTSUPP;
=20
--=20
2.15.1
