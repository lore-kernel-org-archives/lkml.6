Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242725-2-1752568275116828016
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
    1523242725; b=FPGhh7wueXcya7VmLDkKBSrJeh/uzTZc6aujfGmiSo/xshS+Wc
    P7k6RJ0VprLHUqGm2uKWnmhMHMjz6JBUwc+IYaSwR8W3y5yboHh9IPAoqgVvZu/p
    hyMpZL9yEaJSR3sxMBRGzbk0k8kDmRYnh2TOlQDUiUsKlFbCfTIso0oiCP7HxbEA
    CpgopPJfT1PtkVxpzTL0u/R5Aethe4VqPOFXSfGQ+BUT6k/FxyRHBi06F/ONaFng
    JD8Qcguhgq1BDVJKUbvyZyFWYd29t312afO+kuRZj/iGNLwM3Em0MXGGN5lJMuZi
    DJUXQQ2AJ59MiVlEi/5nRh/RAN04S+C8Ykag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242725; bh=Ig1KXT1k0u
    uXxwdKYrj/gtJ28He9/1KBdqQJPaOYAfc=; b=mIIx7RXsPO4mCtTluhF5iS/H7g
    8XZs2Mb6Uz5C2NsU5QjTZH3xA1Hb1RV0lq2IQK1KG8Nou2p3hS4A9rDigAaLi6GR
    Y9u4o1ZJeFWxXhRRfB+7nvmKshSTCbB2MO4yx5Gz0jhZ74qdxoRzuYiCxqHG1ZXi
    +ojX5Vhvu93/78NlWnEuIFfAJaDcF2p3wUDVKb/SoPdKuF7bJ0Tfo6wGl9BqXgEL
    axCzaKMPLC7LyYKTmMQoIziWkgVHO8RxIvcAd7u9MquFOqbyD5fBFqNjBCOTGCZ5
    pJMX5pXCwbhtSXft9RPq42nBUIDUyM9q/32CFfTj3CvuS7pKNAyUxesQcoxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T9ip4x2n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T9ip4x2n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFZXWvXhq+GdkyoHNjN1QUtkriWXIdDMXJJ3kqY8uxl2BEvMHAmWItaWgjbPyeQJG29RzhdmUI5LgzRFI80iv6IomShjOkweJYr29WVEB7WlVV/+VIzy
    g39SYvnhfx56p+PxDKZK9b414QQmGaSQbqjYNK7u+ZJFYyN8Ih+J76TQRfoBkQK7I6Et6o3qQv7aL2Ak/3Kylr33mZgjkt98WXXO8/xk4s2mrXNLrLS80KUV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=NfJ-nOMBdCiM8OP8BF8A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeDIAZf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:35 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755188AbeDIAZd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 123/161] MIPS: generic: Fix machine
 compatible matching
Thread-Topic: [PATCH AUTOSEL for 4.14 123/161] MIPS: generic: Fix machine
 compatible matching
Thread-Index: AQHTz5i3Baocnw5SIUidDZolW0ru1g==
Date: Mon, 9 Apr 2018 00:21:33 +0000
Message-ID: <20180409001936.162706-123-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:VJV1rtuxqWLTmcmE8qTEXKh+XQTxVBNRe42cusE8g7IVPmb9H3qsucBRH3P0LubctaT2OhqJ6ZlJ0u1P/xDvl3QgUkCtXSPk7hNYU89YJUPMuBz+etYtqiZMaVHUsgZf+Q4BZRqKrIMyxpd+esfVxMin88Ie/v9lfXmPYnMyMpjVnRz/SKCz/kOLN8syf+ZUu17fDQdtetncUuQ6W3yGQ1jGQwxppi8RUPwelKCSnyzev2O4vLiDOjea64Yt1Q3K;20:F0hiub9I8VSTudwiQRg0KvPhxXjX0MfhabzAIhLO0wpTGIfXuu/qChN7hp31Vsel85FhYdyCZqX2BgJBCMc8dMFnZB8p1Z/XRBLlXbG9rqb5B02HGG0zJgc9cBGjpHbKi77KWnL4VmE4QOTkLBLTSWRMNdVD5NHeZKdKKDuuiLk=
X-MS-Office365-Filtering-Correlation-Id: 8d6d46ab-1daa-4bed-14c0-08d59db06614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10134D527D7823E80210BC97FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dYUc4D/MzORASVBtR6Kr9Jmbq9WKX0hL5ztprKkmFjtVbfPJTRUK8CGnL2R14Y2tFUDyriov/emOp4j6FW0Upufj5CjsZ00EgtdsMWHdNN0+Bjt2g+lBmEiYD3I7WQ5KlgIFzU2wwdAXTACMVuurHImN4bT1h/w1D9XsCV/sl5RCWrdBIprytWWX9BsHqHAIpiiO6RKRrzbDDEqtFpz0YO6haPyMQavbM7Lxfa2xfYUMedyYxyBgLNRyw08z30Tf+cstcJuChojKHTonL94Jb6ems/yFe6WuBFYDLsZY+8ybVPi6IcTObHfkM4selaYF8Yc0I8w6oDkamqOxGLpsiPxtIdUvUO42WlXRtThheJMEUZIzwKDKtQ5O7mWPGwN2SNMAAnam72/ZhB6dDTkelLgyndICM7ywgU/OUtAIB3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6d46ab-1daa-4bed-14c0-08d59db06614
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:33.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board suppo=
rt")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machin=
e.h
index e0d9b373d415..f83879dadd1e 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct mips_machine *mac=
h, const void *fdt)
 	if (!mach->matches)
 		return NULL;
=20
-	for (match =3D mach->matches; match->compatible; match++) {
+	for (match =3D mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) =3D=3D 0)
 			return match;
 	}
--=20
2.15.1
