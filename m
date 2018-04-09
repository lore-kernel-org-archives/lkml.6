Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235252-2-15785023705767471236
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
    1523235251; b=bD5+VW1Q7NAKFKlxFu3c/+Nb6jV5cOrX60k66sKEWyz4o8wi4N
    TV2IeEAkUnWviu1nJg4LmSvvvl2QBQEOLfQx9O+LVY8DIryKBIaaYvw+wl+NAB/G
    zZxKm9exJe/SRrQaF+LIFWOKP86eYu7r8b017XwAvBqurBY/Z0N1rDbab/+ZqxTm
    RdmpTQOQl4gplRnMh5EQgmlMDArlPDiPN6ux4QqpgJAKyLpYoVw15wrBTPos+b1k
    M8/LE1xhvhQfjs7PrSVkfA0DD9tZIBx/2KdK8jDNQSg1x++wpYHdYEvOlSV9EHUu
    LgJiTGdISUwgaq99/9IZ7s9AJnVEg1dn5Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235251; bh=KvDrGL9nik
    Y79BYcvER/F5aN7iJvFXICy4jL0E7j0sI=; b=e4HB0q2MD2lPHvlzfwkK4y+gMC
    KU7Ob2PWdpOihDRetx3rFfD4ade3oVm+cwsNn01BFRe1OquT0Dvb5BlAMM4mZQS7
    EyAMRj6YWiLIxfEaEEXDYOlL/KGn4yl5sNpTF1QuYLDmLB23/4+gkuK/Ae72AR6V
    uMR488BH0ekt6YL0ms6vuRpnA83Jh8j9zLIfgpEGwos/Csyi7uYLqWesiCPcuhhB
    cug8QZ0ib/kvsnvwCN+Ipr+Cq82omkAhmyy/vUmJWJFeaiGLXj/hnRe4vSgS6AhA
    cC+6sABwr7ERydmi7LjHHf7kTgrg68fUjKGvJ1Nm51frdA35tIpjfbhwYy0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c224P4Lx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c224P4Lx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG6N0c1DdtF+nXuD0EKkSfjlQHTyUwRmYCOeErPfmoRQ3fMCLh+3cAIb2l9YNzUcWlCnjr3gO1Pcwzt9fTbimhgHDIMgRFZ1/UMLG+u/ot0slYTTxKDo
    K1/9Rqr8cjJYleADD+nIHJ+zaloPHWA+0UOFqi0OScu5L90blSAikhWIdbVDyvHBzo+/z2YFN2vdjsP96vFuSSa56tzIZcU+WjZS2qqt6JJRV3B+W/QDg4vM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uAS_uZ3KAAAA:8 a=yMhMjlubAAAA:8 a=oIfBM7T56LFt2f8VNdUA:9
    a=wPNLvfGTeEIA:10 a=_KzJdI3Ai4rueFdl_XLO:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbeDIAlK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:10 -0400
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com ([104.47.36.130]:38544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933323AbeDIAk3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 049/101] powerpc: Fix /proc/cpuinfo revision
 for POWER9 DD2
Thread-Topic: [PATCH AUTOSEL for 3.18 049/101] powerpc: Fix /proc/cpuinfo
 revision for POWER9 DD2
Thread-Index: AQHTz5q69QLc54yhBU2bJlPTp23+Iw==
Date: Mon, 9 Apr 2018 00:35:59 +0000
Message-ID: <20180409003505.164715-49-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:hQMrDcwguP+HAAAmq1WpRmehrWzHKrvYpAEIhtjU/KdRZri7yLuBz8k6BwTXThNF+vRxx5RdJtCN3rkSni7E4tNK4mrIWtvrnrB7G0h9256TqsoIcRWxf+7fIuy+AQHz9pFMJcsOK8fge2wyzkmcd4+K9C43XXrQ/7IAVBl9Fvwfic0Y/tbw9UNGaNvsrLjtfC0+XycbkrdqFLLe2XntmCcocDKQ2wy8AZV8M3lKcD5cbBs+3ajFFNcpeVZLNPIR;20:XIXDm2LeJhkSMc+Z1O2UcPVxDGHA5kXLTrYOtyvSWZNmA5qJgNwjPwK7sLMmSwz1hoXTFc7yWujj2mwZO9gnEMgs1/b5vdeaqOk09d+kydGwGVEgtkbz8upWMbDkybYOb5MZjgV5lJpRLUJzg8qpYSsO7qgXGbYGmIQGOJyMAAI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c425620-7b88-42e4-dcd1-08d59db27bdf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087019AB960121B74FF19A9EFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5/n9jqRZZv2Mqy0uAVa+hm72lQNEQ/iLHMdsfGBVLhCX22X3fb1DmWgTnATeH44ZJu7MHBe+tiTECUcE52nSi109Uh47jZoFl0Qszq21RLb/hm9op16eian/ytX+839X2OsMv+lgUyhClhQ2k6Kpd+39In7cXKeoHDCUG7/oAcuXY5mLEdgOMuKriVV2XqIvc/Z/bv21GIIrZXuldEa4nI7Im1FCqsJXc2xAFW2zojWYIkLVg3xbx6UW3ytcDGkAMq39zEvXyeieFRu0QdfjDOvnXbdmqskBbpjffnBI5AIAAblxAcsJ1dOkxDbklhvnQoDiaSIRrgb1Ww5T5p0UGoh2UsI838AqnUoq4BsrvCowfliU+27Mk+L/okkBVGdBxD+U9pHbzn657tFxiRDZu/xn0DUipkbCy/mz+VdRGEs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c425620-7b88-42e4-dcd1-08d59db27bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:59.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 64ebb9a208c6e66316329a6d9101815d1ee06fa9 ]

The P9 PVR bits 12-15 don't indicate a revision but instead different
chip configurations.  From BookIV we have:
   Bits      Configuration
    0 :    Scale out 12 cores
    1 :    Scale out 24 cores
    2 :    Scale up  12 cores
    3 :    Scale up  24 cores

DD1 doesn't use this but DD2 does. Linux will mostly use the "Scale
out 24 core" configuration (ie. SMT4 not SMT8) which results in a PVR
of 0x004e1200. The reported revision in /proc/cpuinfo is hence
reported incorrectly as "18.0".

This patch fixes this to mask off only the relevant bits for the major
revision (ie. bits 8-11) for POWER9.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/setup-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c
index 1362cd62b3fa..01b2950273cb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -310,6 +310,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				maj =3D ((pvr >> 8) & 0xFF) - 1;
 				min =3D pvr & 0xFF;
 				break;
+			case 0x004e: /* POWER9 bits 12-15 give chip type */
+				maj =3D (pvr >> 8) & 0x0F;
+				min =3D pvr & 0xFF;
+				break;
 			default:
 				maj =3D (pvr >> 8) & 0xFF;
 				min =3D pvr & 0xFF;
--=20
2.15.1
