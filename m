Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233896-2-9064583679105990167
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
    1523233896; b=GMkg4+GN8bJW2qeyjkFXGwkPAjsOltNoY6G9XMntcsGrs4jb6T
    N8Ol8xvfB4pD++e8XFdAgvASzGnVV6yDxT04Ob64V1z1w3dOT/CtvpHjxRHXoXWp
    oUevCtRSvWoULffhKKfwfWgqaDaT8LvXJL3GR4gui9KqAnDfIuporPI8cJx84VHA
    YEoumE+w1utT9fQ5fiOmssO+TmtY/r1k2YmfiEn/IakZQQVw+vvbDhsjfBfPjILy
    YcJp8q1nnBdQVGXlqJw/Yjx8mwl3jNP24838XsUrpeYXW4UedRb4ErlaXOh8gN41
    zzNI4yHhV81poHH/tRq7ddHPtVvFx3ho5vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233896; bh=8JKFH0QMMA
    FtDZyDgyuspuV4dBOhqV769lYoWZHOhzo=; b=jDbj6KQg8QkYIq6oxBmgPCdHsl
    qzUo+MQeypsLA6hlqIKLo6eQ4ddNr8kwNpkWZhsJEbcz5WofXoJkqU6wNHEmOdcA
    PdwFo6Ee7HIURm2ggOtiBv8/gcm4Kbhb8LfVkXd77PW4zgZxulKfZPulbdHedyVt
    10Po+8G7kgIBpUDs0uK3TlAdl+r3ncBXC7mfsyCcMwH4kb3fE8WyptWZhJaQKxqf
    VPqejFCan039N85UAHozQ/zj+l4XGIeZJ83EjB0rmHJPN2KqBJQJ/Vqox5bhLOOd
    1WjA8LsOU2EYW8vMUz0yx9urxYuFr2Zq1sR/jMuj2CzYBes6MJGtwvfWY3PQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cC98K+fr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cC98K+fr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBbuWO8avWeO3Sw9GbSumpchlJHaHGqX7HuZ8p5phALer9JG8VZOSKb1e3KvvTwa+6OcCbg0wDPgKYrRu9EsyL1MmqTNI1vej2dBVta3Ol95d56cGYX5
    3diF3qKPD2M3/Kmqko5anhaw789E/5su49JKjRZyKYzTBWjJmgAyOvxsnSjux1a87dydJvpDsTI73YJiCMBgH/lNiF0edKlM68F2pUqQyn3QYNd2jdM0+tny
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=dBH0KIM3R3dudtRcFMMA:9 a=wPNLvfGTeEIA:10
    a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756289AbeDIAb1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:27 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756251AbeDIAbY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:24 -0400
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
Subject: [PATCH AUTOSEL for 4.9 175/293] MIPS: VDSO: Add implementation of
 gettimeofday() fallback
Thread-Topic: [PATCH AUTOSEL for 4.9 175/293] MIPS: VDSO: Add implementation
 of gettimeofday() fallback
Thread-Index: AQHTz5k5Io1fjS0igEq/qoH3dQ1mTg==
Date: Mon, 9 Apr 2018 00:25:11 +0000
Message-ID: <20180409002239.163177-175-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:f4BEBLN9wfOeByS8+wYh55d9ly7Hbd+cUrC/1CPHjCzBv8Eiuk4u4XnSKMEdiqP4shsNKibhAJJgsImwikzoCUa01kyTpTlZoyCyPIRCNvgXoCsZWYsWpwdiNP2ltPJtzhvF3Pktmd3VLyBf2rjitefRycRILlZBKkUvzibOb/MkBmsSTwElacP4IUgl4alj6kqrZl+965m3GIusb3j/iWOHaLatmfC4JiZGVBJ2fS9xQo/6L/jz1OV5nT2A04Um;20:Egs5B8dX4aRIn2Yw6ryRDMRu6Cu29cxc9U745LRy+liVWlu/5UuRc2enN4GPhpUSnqfoYw931PPARp45yWCQKnu1ZIZPH/S8HnYeCR+cTrDUpApcOZhet+g26fUweAFY2VaHMsDi74sIjY3Uh+gsKUVeAcoupOk2GK9Jnh9KoM8=
X-MS-Office365-Filtering-Correlation-Id: 7000980a-3669-4fe3-89b3-08d59db137c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112693E574433C357CD221E2FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(7416002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6aldkvcvGZjUqlNESMIRFzd4vNhs2TS5PM4EQrBjUXCE7KI6gWPtpWqeRPKI/xdWOPh+2JgB4huIBIOurUIdZcg1KQbpzSClBKJ3ht2nwRYPFiw+qywRXwT7GyhZGSHp4SWYb6OEaNPu4BeE8Cf2yPxS8Tx7zo2c8wi11I0oUDHh73EyxBbD+x4u7W2zmyLEjlOCY22xLJU83tETs+ubTwlPKZPi6JSGQAn0E4FaOFnOB47Zzx0RTQ0mlo74kgrduqT8J/FDQDDosxveEWN2cptxfSY0jWuLCAcmCUIgFrleZOGtsXVkUDy0S0z2mOYI3LO1SDLp/HlxHWsx+Tvq6JLua7W4SNMPupY582UuPIM/D45GqF0nqe+91LJQPlLzOn5cWGFSabwO9hO6ATC87vlAu5kcmjNp2Nv16vFXe4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7000980a-3669-4fe3-89b3-08d59db137c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:11.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
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
