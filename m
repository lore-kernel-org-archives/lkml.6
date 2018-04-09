Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234262-2-12166757844929000480
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
    1523234262; b=OzS8aWamYJPl9eIsv6IgwTBdb+Vjbqp7gqBM7Ku1WMzpVx7XIM
    AazuTQ3g/EU70tDC+B9WrjYVNZNMUHPHAvSndW1dqFuBi+kVSrtKpoE6u8fqGVXR
    iRPdgfwzzXskuQK9rK2rRjPWHzhalKBNfpCUbKQA435KksXXiAO0aHTXaWndKGxf
    VzxtEOeg4BYPPZmGD2Ch09NP+3kOaoPa+N3vuHL6DQRPAvjD3Caplm5OMdvHJBZH
    OijXIghC8a2fpg5S8RsOywCCPjNCqMMfnBYXr+k8wGoubJUqKBY5AjLSpE32oHc7
    BsXYygiAkhnEhha4Eib8qTMf5LbvUjS3++nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234262; bh=8JKFH0QMMA
    FtDZyDgyuspuV4dBOhqV769lYoWZHOhzo=; b=bVPtzZsPqplCNa5/J3wxEm/Hzx
    4Xs9IIkAJgHuxvycx0ZLhxTVUkt+TtSY33Uyusz8dV9TyvAMl2/Dqt+JHyDp0jWT
    vvYuwbVxRRy9fhoScCXaxJ7L1HAVLpA0Sh4Px/luEsY66/pb29NjWlCKbNSLDhOt
    gDvg1hHZwoOj9dDnvG9/xcUBj0rPG6+crGQI7V8b+hOcSk6yyPGjLM/xCmKf3x/U
    ml4qCVTp4vxF3Hh6m1/j+i2oj1uQORnb0uzosWMjkiXQSyqWdhyFIoW/xIGHLHIe
    dyRX5n3k4PpLigLcfM3ggIEdc5SmwVl/RpN4k4m6uikg/AIwouy2SHZ+sgcg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EC+gEnW7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EC+gEnW7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXgKkoz2PqRfBnykPFIPfjnjT3cGcKWt8YPOJwP/BP4/XVXEbc3qjn3W17pzsmgS6qm5tGmwZXqpHVr/tfeE9f4R3jG3xjhS17sbfaIGLgwHGgCo2XV
    s3b/eYykU8N03tVl9+kN9TMoM1EmPfOfsIiXEx/2wE+391veiQJQnBPdiq5DnhMcN46C0RhwHYaHFQ/2ZquPs15XJT5X04kcTRKkWn1uS8Rfh5YGD3I608jF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=dBH0KIM3R3dudtRcFMMA:9 a=wPNLvfGTeEIA:10
    a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeDIAhP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:15 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932778AbeDIAhN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 089/162] MIPS: VDSO: Add implementation of
 gettimeofday() fallback
Thread-Topic: [PATCH AUTOSEL for 4.4 089/162] MIPS: VDSO: Add implementation
 of gettimeofday() fallback
Thread-Index: AQHTz5m6EOfXE2qNh0eyRGL+pncW8w==
Date: Mon, 9 Apr 2018 00:28:49 +0000
Message-ID: <20180409002738.163941-89-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:OQqdnN8uoNPYSSK+gyM1kd+FzFKbq4CDEBkQgr5hU8D+sAQbFTGmfUG8zmuidONInrWW+gwew0+uhxgfD8zgt50a2SnznqQIM6VF9dEMsYKbOhWzK8nfagJNWSBbZSJ7zBl+mxZITcnN+/ZWLv3Te44UgQ3pSlTbCaJISIRrZCI8DcmkOT0c1D5zZssPUdOXV7vMneQV5mV9xngqYg2Bbsg7Jx3bLaHOg6/QGN3e/fqIWudA7A7HnCMbFTC6FNS4;20:c5UMIi1tWEaxWPKiTfzMQkOjzbRSilJl8gt1ltpdsi7H2rpZuJ7LgoHYDDKBlAusfxunwmTE0FhW6tervapPIQkx8UxrnkMP+wvV2+hgZJ+cwRoTzw74zyQvey7PR8igZtv8U2R9EjTF4C2JaXlCCS+bRpXddN9ZuZTsLnlbGlg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d7bd39f-8dc0-460c-35d0-08d59db20631
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10317CB6A996856B41160F7EFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(7416002)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 03doNE3AZrIXL5TFDFxj7ECLVatAtKdfrVFvVn2/2WTRNygOTVaLZQDF/97gwt1wQO0CPeMz4SCxcDbahZC4BlgZgBgtijoJBMdBJnbq+bXhQrNgmeN3i8v8B7kHaVH+qUicI529iq8NJ52lRC7GHCk0Saj/Ur9a6FMkZ+4EVerOt6h2G3urQVXpDVSn3mGATVIgH/nfhIc9srYAX2143yepNRHh8ar74vhDgpN5Z4pyOQ+EJLzU+xoSmfkM0aOPv52SL3RSstPBEVd5Q/tNabZRVGhsIwTJZpXk8CpIuNwSE+XpURHbO4MO4SD6URjQvb5rlcqwqxbadm/5Dz/6I91aO9Cj6VD3yNM+sPE6vbwxu62It715QQv3oIBzO6osZ5sP8vwdjPF3DBOWglB+CTBaw0SSkmd52hV3Db3LbgA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7bd39f-8dc0-460c-35d0-08d59db20631
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:49.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Goran Ferenc <goran.ferenc@imgtec.com>

[ Upstream commit 0b523a85e134d41f57ddd8c5193bd9f0a5e20b0d ]

This patch adds gettimeofday_fallback() function that wraps assembly
invocation of gettimeofday() syscall using __NR_gettimeofday.

This function is used if pure VDSO implementation gettimeofday()
does not succeed for any reason. Its imeplementation is enclosed in
"#ifdef CONFIG_MIPS_CLOCK_VSYSCALL" to be in sync with the similar
arrangement for __vdso_gettimeofday().

If syscall invocation via __NR_gettimeofday fails, register a3 will
be set. So, after the syscall, register a3 is tested and the return
valuem is negated if it's set.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16640/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/vdso/gettimeofday.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index 5f6337545ee2..23305bf6c7a2 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -20,6 +20,28 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
=20
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+static __always_inline long gettimeofday_fallback(struct timeval *_tv,
+					  struct timezone *_tz)
+{
+	register struct timezone *tz asm("a1") =3D _tz;
+	register struct timeval *tv asm("a0") =3D _tv;
+	register long ret asm("v0");
+	register long nr asm("v0") =3D __NR_gettimeofday;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=3Dr" (ret), "=3Dr" (error)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return error ? -ret : ret;
+}
+
+#endif
+
 static __always_inline long clock_gettime_fallback(clockid_t _clkid,
 					   struct timespec *_ts)
 {
@@ -205,7 +227,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct time=
zone *tz)
=20
 	ret =3D do_realtime(&ts, data);
 	if (ret)
-		return ret;
+		return gettimeofday_fallback(tv, tz);
=20
 	if (tv) {
 		tv->tv_sec =3D ts.tv_sec;
--=20
2.15.1
