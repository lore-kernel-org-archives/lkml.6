Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246676-2-6371070070943715980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246675; b=RfNFcuxJDK0B/DpR39056osfbwSfZuHNTuiOjULe0HXhxQuj0A
    wZdpLbApL1kSqx39BxBh1gGyqIjxFSx/rLrpjnsc3shz+VU6aK4uAwIle2gO13ED
    Cla0ZrMcJ2xpnZUMlw4P9Hh1Xxj1WwbS2J0NN/q6SLRdmA4ARZurLe4WcGOWygkB
    YjB+35Y3pVzQM/y75Dso3a9+BFHgThjlUMGs7tJ/slM5hwL3fqFID7sg9Bf6icb6
    nD51c/621x1YAJ100yn2APbTd+fBFfiB9Xce/YSvGEt0Nt1XzKc5w/NKQhzLnkXi
    twHBTEGyjG5hUmDI4jSE7HBmaeCwkW5w2OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246675; bh=nldlfgQZSU
    y8/kXhF8R3udGjBiufIjwtdBn3lLE915A=; b=a+tToeiBbx5GC3z7llzNnF3uiL
    aIW2/jDzNfV/cgwBjawcjy6QUufGxKTFr82sOnTTOdfLtFeKWckiqQRVhWluH5jW
    m9IHGlCy+icHCyorigY6enUBixmgwHDTkT0veVGYpI5SULulZSp4obETS0HnDFJP
    915PdCxfboyIQxEK7TzWSAfgoD72QK3cA4yL81rIcDWW1SAoRmVmlsjU/ubhiKI8
    6Iwjfypt0vrVUphyZHBRT4EFww2EcioK28BqrQIaYEwUTFl3mpKYkMW3/VcYCUDl
    xV5Meeak0fmKOwFgiHPWSfCnHQxC3kc7Wd4hjcmsFbWoFiv6G1JBP+CJXPuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SnYoRcPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SnYoRcPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM0BCrlEVvtxGr4ovdSjb3se4W3pwWZ3ch+13LsfSCFS1ZwSeh8wxn+qxu8sVF4ZK/zXZB9kHecXh+cMSq8RGFxtFE4DU6ueA0MJrLfekj2xG8eY8WnE
    1fDlZelZ+WicRPz7piPPEUdURW/7U0lni3SI0K9O0iocBiCwPPhs+DVUZXJWXgPxRfLBUPcDXA7ujPe1Rarfp71piVO4aa1jlL4ygNbufJ6+YiL4fJEibYrl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=FN1NBjK983BEj7eZai8A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeDIEET (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:04:19 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753302AbeDIAR4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 047/189] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Topic: [PATCH AUTOSEL for 4.15 047/189] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Index: AQHTz5ghmWD5LLxnXUW9mrZF19L7xA==
Date: Mon, 9 Apr 2018 00:17:23 +0000
Message-ID: <20180409001637.162453-47-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:TV+dsXOWkCPoFRbjsVvWvpFEKUXGiDWS2DRkCVo5R7/ckK5WFHvYqLzIITzwjOy81QyVkppCN/74hPPah7dK8ja4KQmkyLMwgDsncYn9fDxqWcXAWSmIQaA1ILBF44bgqK+pf/W0gGNmsq8sD2mGsbQPVOiUk/hfcMCNMCuLdSmV5qi66XES4ly3OzG3mLhnqXJDjUSERCxRCksgxiaicCqQ6Pd9k/G88VrG3OvqH1+qrtq2PZ0UJdFM2uXChH2Y;20:GAaX3afhzobBzxDRJYbIsEzu605f+KTV+y6vFdEdo2cjHsXpeBw4P1kXbuuoG91djUCYBbPIR5gUmIgCJ1NsM8rKbh/HvHRJo4aR+xmoitW3V8Gt+p7/FuBaVl01jvQ7UPgp/RH6/xAoAIysqlWWt2Q4MpTuG/J5OgR2vNHlKeE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cb763f4-c919-4c1b-9e14-08d59daf5413
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10480CA7D728CBDD6D7558DBFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SMjez1tSB6hI9CZdGRl52/UWsZiRkgY92+JV41R3w2QkgI2Mu20juL1KlXSAMW25HQ5s5jwmb5GziY76Jdein9t50q0l/MPT87aiSaGbkEHG+gLK/WPqz/PTx2c6zufugUcAacqLP+XZIzqOuu4q9RnhiEZt2jbVBq0o7Lf/jdWte2/m2dMSMa6ZNtzkw53+JrqA/nXEuCQWocNH5N58MG1v4njK8oz4+5jk5FA3muqj976xZ/OOFGpZ2c7jfPwICiyG9+qng25FztFUomeNytOcZItHMevUBi235HwUA74/dTOj78R1Tqtvbt5zZOrHE6XQKEqX2DgHX49fTP0gFzSFlsddsTAqJoxTY2MF5+YtPcJZoUu7DnoUs/W84RjqcMkZjhpEVF/Bc8MYPAkwMJ0fFzMMVbpXdtOgEyl5MrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb763f4-c919-4c1b-9e14-08d59daf5413
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:23.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make cl=
ean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/compressed/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed=
/Makefile
index c675eece389a..adce180f3ee4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -133,4 +133,8 @@ vmlinuz.srec: vmlinuz
 uzImage.bin: vmlinuz.bin FORCE
 	$(call if_changed,uimage,none)
=20
-clean-files :=3D $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files +=3D $(objtree)/vmlinuz
+clean-files +=3D $(objtree)/vmlinuz.32
+clean-files +=3D $(objtree)/vmlinuz.ecoff
+clean-files +=3D $(objtree)/vmlinuz.bin
+clean-files +=3D $(objtree)/vmlinuz.srec
--=20
2.15.1
