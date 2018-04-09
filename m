Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239670-2-1839645549925117098
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
    1523239669; b=ctj/3VuJBpom+KbOiV3EQMlZ62cxRqIf0mf+ipB1eBYbgmADPF
    jfA7DaUxUsVQm1QrXcAXEdDUHU9/1BZbzFYDTzHCDZftzOF0rA5wPjrgxwG6jJI3
    O5mXFoeqAkP4rXBg3mYAbCN3PZyW81lsMCSRccEcd8qcpMnkKRFRGAhRLfHJ6Az1
    +lNKwdYoBYLanZs9cYKfxN8ovQcfmxnzV82ZsLE7neG8d5SA5JjcCkD+pdXbDDuF
    90XO6Tacd4/8ozZxwRtGO70TLyBwcWwhpSC7CtrleT1mpgCqv6kx83S9DmGqzudQ
    /sJobogHkGnhD+9fMe+FzLATBgWZpLBcLAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239669; bh=ueHMBHYDPJ
    z7V2tYBq5LPs+h4Y4VQoe2H0SWFyjmnxQ=; b=UHquriSVMDvw/pacwrq22neDTJ
    4jXVyXWy4UukMFU++5v3Tg0Y9cAmU6Mec631BOyg5cc+xsze51rUfcL5+Rb2RWAk
    fgokp2RJhz4BTFbbfXRbNyMcqrfaq0n5iZBd9kv7vCS3HUOlNt09xU7uxhUe6Jwr
    ZXQYyeeHiatCG8JxQ+OZavmgrMbPkgZL3lP9uq5daux/xbVSrfuB3Wm1lkRqQ0DS
    hcK7j5NgM2xfvZasX12c4X1aEEPbxTcXkkhso7nBzBSZLgGyVQxm4dez9U7OI64h
    6Cl4Ed13YMgbD2p5dooLPLpQnX6O2nSwSrqjiMBdaOaX74ySwqwFXNQiRHdQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=am0ZPzO0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=am0ZPzO0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDHRZ3tp2jFfnKDBfiIlJM5tZPtSNR5G6H2qKGRGbPe1LOhYD58TkPVMIXDYcczazOWKgUW1fAhfK77QGReCZ8OJIJD2u4wB7iFVTt8nSMoJwk4Bc4Vx
    P+J7HUGqy1xtuwFNfkYFd5wKqIhY2aaGGCOUx8dNX2K0h8+4o5sqtJIwLe4ew3NrWme2+2K8ZieM0sbxLsA+Y5HMwAgU2UsB+wijLWJm4D4ghP3BvDBqP8yj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=2iGazB43HB0AJ_O2iB0A:9 a=g0rAZlEUfkR_pNrd:21 a=GOcm9bT77Yt5Mh04:21
    a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757862AbeDICHK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:07:10 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:54752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756262AbeDIAbX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 169/293] MIPS: CPS: Prevent multi-core with
 dcache aliasing
Thread-Topic: [PATCH AUTOSEL for 4.9 169/293] MIPS: CPS: Prevent multi-core
 with dcache aliasing
Thread-Index: AQHTz5k1mYnjTrjHV0+WKCUT8mJD5Q==
Date: Mon, 9 Apr 2018 00:25:06 +0000
Message-ID: <20180409002239.163177-169-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:MJfDGnMaU83ry/RdR4+x6PtdyWTS6lEaqvhUJatGOPPvPP6hgAYtJSBozOHyQX2wLWX1aE3WPIIU7E0V8u5PgTYaGFLmSiTqtUW830k4B5bfs3sD9NYm9ZegjBibdv5woOlIBYjqnUW4rvGUwaXp5eLCcLrZ/F78xvq1mOGyCYQpXy2W99cObODQGo+qJVNwJRSqpoLLVxTF+RrFPuzFrZKPLzAJByBnxAVq3u8+uE+DJK4FpjcBripe+b4xX5oB;20:d3+hnvvJgZnBtocJhz5thprxXB3xA2DNYINTIkdeeB34LTaHFfLxgg9i2yIB8sjtGWbIoNTol5Z4TeVkbb7RHDWGrbqvMucGCuE7uI4OqA4qgm+J7g7wJjIeG8Tm3ZsTnIekGRoEve9+ZP6+IrmqdttVXTUZVSWuLhyoJivAg64=
X-MS-Office365-Filtering-Correlation-Id: b3714986-f084-4211-6962-08d59db1355d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09179AD733D47186603ACE98FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: A8UIymRzetnnlo3c/mf1FeMJKShBikiqSKi3ry51xARKk+A1cYwANRBh7JO9KszqhYG6/Rhp02dXIlGE9028I1/RdLu6m0THxoN+/obn3EEVItFzN4l5kiZ0PrnbWg4pJcCLS6tHh+yHFSLBV1bVdBwKf6FhJIti40xJ9qxVim6TySZIYJuCFSwjmg8K1XZ/AfNCQIpJr1tjFXJMzETSbbOqG0iHAxNCEj5hrG3ggaF8xM5g0tqZVDBi0OI5QdTyDRIF/bm/Iz1PL8VrCiYvSw7Ip1Jq8UZ1CgbmDrvJYhMC8Zbi6HU2z4r9HaMeg1x44xrrQ8cAVYTh/fP6A9DsVxmcj+33QnuhCrzav0+u9FMJI6hbMLPH2AR8djbhgOTjHOa7xPbP+3WYNrwS3o1VUzCtejdGVLc8MG5AlAGbMAI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3714986-f084-4211-6962-08d59db1355d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:06.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 5570ba2ee920de4e7760a2802b842771845b2c32 ]

Systems using the MIPS Coherence Manager (CM) cannot support multi-core
SMP with dcache aliasing. This is because CPU caches are VIPT, but
interventions in CM-based systems provide only the physical address to
remote caches. This means that interventions may behave incorrectly in
the presence of an aliasing dcache, since the physical address used
when handling an intervention may lead to operation on an aliased cache
line rather than the correct line.

Prevent us from running into this issue by refusing to boot secondary
cores in systems where dcache aliasing may occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16196/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/smp-cps.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 6183ad84cc73..63c8136d5132 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -140,9 +140,11 @@ static void __init cps_prepare_cpus(unsigned int max_c=
pus)
=20
 	/* Warn the user if the CCA prevents multi-core */
 	ncores =3D mips_cm_numcores();
-	if (cca_unsuitable && ncores > 1) {
-		pr_warn("Using only one core due to unsuitable CCA 0x%x\n",
-			cca);
+	if ((cca_unsuitable || cpu_has_dc_aliases) && ncores > 1) {
+		pr_warn("Using only one core due to %s%s%s\n",
+			cca_unsuitable ? "unsuitable CCA" : "",
+			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
+			cpu_has_dc_aliases ? "dcache aliasing" : "");
=20
 		for_each_present_cpu(c) {
 			if (cpu_data[c].core)
--=20
2.15.1
