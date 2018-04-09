Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234229-2-10770216592577996424
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
    1523234229; b=qWCNSxxLQ+FDd0GOMZt7jvpnfQhVimS74oCBYsdvIJ90t/O26y
    VWaZMGaBDvsbEqTSqbFWllOWb1PXSO0doZpFp/igHwmM07ByjIrfiT12UonCHtyt
    q1nCRlC/nmv/4Qu4XcoHu/l036QjuHTxAiDelolBM40VHw3zEuKyb+h4qBpNuAqO
    L8tsO/E6bVKcigkq9ARET9Y5+/Vrw0PwvQK3IAPj8aFBk1BD2UdhWDCLwkdNbSgX
    w4Vopq3EcrnzgNwf8rndCFAA58yVVgJe/KQfVFoV+O4g/b0NgflHk1CVKnEH7+Lc
    CeBixSYWE+A7QYcloHYtHsNQGo4Q9BbpARJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234229; bh=jlOrgaBwJH
    v4ger84Xtq5fixr0gtR0eHmcwMpmziERk=; b=qNCAJ56mbMuPkH9NH7Fa8LeBtP
    DHVkCzPCyAzLzpJ5UnlbS7ua8uBbdeX20t/o89BkwDxwarDagwloSCAU5Gs6qpVZ
    wR1IwdDReJwGlyBrjKFQmUsivI8j2O9PTnOeLTXnz3pKEpWAu0eKqIcE5aGF6Eza
    3nP1zd6VXP9AVWBH9Ss7kV55bm5iKapKT6kG3TfkGVnlKv2acnl6EY4bf2ZoAEtu
    G5BehzK1g0wRhGG4aFDvem78dOLMjWWiMbngcWU3mxjn9EU5ufIQ6kODnWsiglW6
    irTQr/sHLOLO6VipJtelOeupYDIXweoIgBoCbH4RvSOTWRj3JnROgIYF6hLQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oo0brOBH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oo0brOBH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEke7TxKmiG/hw4HCachGMEvL275tSfFNvbeeb8UbEnwcHODlT5bf0+YW7KYrYUeegBZIFxUS8Z/FPAdYx5MsJNnX2XnZfdE434Zgaok94S/Vh9o44R7
    dO+I9D+CT0aZo3plZGOdHkKrEGEdKT7CZMH/hdG6Qnco+eEl2QJkGl42kzLw1/CmGgVUzyDbGKq+OMgqnqycEEfc80GaQTjmPBPxozrGv3KXtmIuImu37ylH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uAS_uZ3KAAAA:8 a=yMhMjlubAAAA:8 a=oIfBM7T56LFt2f8VNdUA:9
    a=wPNLvfGTeEIA:10 a=_KzJdI3Ai4rueFdl_XLO:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeDIAhF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:05 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932682AbeDIAhD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 075/162] powerpc: Fix /proc/cpuinfo revision
 for POWER9 DD2
Thread-Topic: [PATCH AUTOSEL for 4.4 075/162] powerpc: Fix /proc/cpuinfo
 revision for POWER9 DD2
Thread-Index: AQHTz5m0Y5JR5QKmJk67UVhmcMYXCw==
Date: Mon, 9 Apr 2018 00:28:38 +0000
Message-ID: <20180409002738.163941-75-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:Uaza0B8h9ZxSUtg+gqFfYI+OaQGfAdqYjZhLetZJg2FdifjcP39Lw599j7/m82XKzdP6ysYg1MvgynNkhZd9ZUYUabWHjhvx8wD4ljlIKBVvJ9l+ZZ4HlEsP5YfX2XV+u9RAoReVav6TcgCMRf6aRGL/H/mYtNm4D09dWKcwYfvISOnB/8Ye2j7a+UCN6W4OZ+lrQgg5sOo1UJ081/5U+U9O8Sw5i6wcLOcLwVkXEfvYaWzg9RlXl5bAPgG430O4;20:F6RlYJeLtp/j7pgF0YVYb5+osW3zWbGe9zEgW7kKEMYmAqKS9NL9EpSDphajnGNPyK5oAPgo1lxWYlrpXfHuFQuUhNDrj0i8J1XsmGcCU8BXsy6UYjvm6LXf8qi0O3P8/zITY7kG0snb3/7qmGCNC+fgShbeNGb5+RT2B6O9l2I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93961f7a-1c76-4b16-387a-08d59db200e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088594699F0712F442D2428FFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LMiyOcvXcJvLg36dTSJ0GwwPwIl/tC0tGDaT7OxelctiWyNN1O5dBdBNLQTUjDwxGhKAbNBfYBoMFVB5aKyY4Knyqk4cXSvQcf4dOW9pF4kLq81+6nJR5AhroDE7HTyI1FyoTbsrxCRo4dvgI/rsjUOK25d/z5Kds2Tmx3iYyHgCNWlAN8t3nvE3cjYzNMZslBJK64dmih2YJBXjFNc0Q2q5tpVZxZVXWkTrUFTxEU7A8nhQpbuMC9F6znS7XE0N/T9hcMyfqXPmDp19GiYYC+aw7hApJq9ySWS4Hxl/bqRegg8/DLiJWgeQZRnq7RApDf/Cb9t2W7qV6/wLJtXTzWoozhwUj/zXLPQu/SZIDtf8yltpAy7uqGDU2aBeq847Exah7X4twDC72fRT1cFoAX0WOcJnSL0v6Sr/WP9bM1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93961f7a-1c76-4b16-387a-08d59db200e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:38.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 44c8d03558ac..aa25af44a971 100644
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
