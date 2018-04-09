Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241072-5-12368377835224969412
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
    1523241072; b=ak9yV2xvfndSwuV+It5A55L4MdyoE4JaJOvD5zrNW4pMKZ5vb4
    X9v7kLAxoyYBlhF2hbpeSVU26KSReKdEc7Zi3GMey19O9U39LkNhXj5SVTqrHRbA
    wsXACpLZZa/Xdh2I+nlEjaPXwgrMsHvt9Zg2oA8FdXqYVDcU3XujiMYpDuAYenj3
    lTf7aLL/+PnXKQzQHLV9S/oH+vJoj8hYV3fDX9kNpoLOedzFMNmY9PSIcb14GTT8
    mB/aVgaSDOY9iGGeC6MUxGZ7I7Z3qaQI/Nu52ExJ6dAViRMEAzLHVBy9GAm5BFKb
    djtezsQ5GfQt0Q0apxpke6hiTqV28+11f4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241072; bh=2GUdenecmg
    5ePh2Znep/ovKxhpBKmR97oMIspYMamno=; b=TJO/4r7SzjVnAzpVVUvfbfjH45
    jYRrzgK70vQviCq4Ox62jfwBns2TTPLd0/m09LA9A5CMz46O9SxJzwRO0Io8I5Xd
    dHksSFNapShUXJBoCjq4ZBUgOjtbg+jxya6Y3kwaw7QnVXF2Y5iy8Qc29nt0OdBz
    1PIIZ6djtCkxOp7ZW4MQHKteTjzhDzWSK+uEIHKoARfR0qNyaUGGkWCVDRPv7iBE
    0yR7+VIA8VIez/4aA50PRqx1E94SI1cUL0J5tMOj7HJdwoYtdrM/xz/cty5fEKeB
    nbQ4uryo/DU6wwrEuXGedpf2Mf4doaPuEfk85j2Nntzp7/aWjcZKfL6PuGAg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MnEOJH8h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MnEOJH8h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDwklGziKmQZItr5FvUOsyBp4ew1sFrEmW7poTOABU2cIYXTCBPcQULcXCOX0q6s7rtsEyq/KFld/pK8AMi+LdoCrmykScWPEbheQoiGTEfUu2812/n
    PnA1N+q3MkBFc8gfy5k/MVWwwdCu4q8DIFIHP6M2+esIfp3aCqdYQFKMquD/M7Vr6NLtL2Reh7IMW2IZRxQvGGOI85SL32kxUkqcLcJc+GsZKkrluYXvItkI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zd2uoN0lAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=BKoL6aYy6hqYyL61QrwA:9
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755826AbeDIA20 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:26 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:61393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755812AbeDIA2W (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 071/293] x86/mce: Don't disable MCA banks when
 offlining a CPU on AMD
Thread-Topic: [PATCH AUTOSEL for 4.9 071/293] x86/mce: Don't disable MCA banks
 when offlining a CPU on AMD
Thread-Index: AQHTz5kHvHpWssP4c0CBSQs9GaphXA==
Date: Mon, 9 Apr 2018 00:23:49 +0000
Message-ID: <20180409002239.163177-71-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:rqvsb0WEOSWqqRbr++iDvodwr4tIcP8GBOJw3XPCl8FZmXQRJEv7dk6lxChyCFxuEXWL0BfbgiKOHLExDDPlvMWwh7Xm2gMqr2cmDoAmLJeUR/DUaaLAxFc1BSECdxos7rQnYtj8XtnrdaO8SZm8JnAUra9UjbziNxzDbITaR1mxqcOa8wbkjehBC9+vcyK6+B+Ypn0tg1AXAqcueuR3AHtaU0+X6+bpdMjD9yYpmAc9qcMDoPOds3bzXfUebzAs;20:u1tEl/QumzEli9FcKeQu/+J+pBnXVpsZwmxfYOverus7whZZQcR5k4PKZHL79bs5VpXg8dkY17mP6sAHN310dpubmK1oDJGJ9KRXqx18+DmefatpGna0+Z0c37qehFGCM8T5ywrQ/oKGnlK1LilGJBgY0GdH9NSNRxPB29zeVOs=
X-MS-Office365-Filtering-Correlation-Id: 48e71d91-8cf3-448c-2fb0-08d59db0cb93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871AAF330C95D035D0AD308FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(767451399110)(42068640409301)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(966005)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(6306002)(86362001)(446003)(10710500007)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(7110500001)(5660300001)(6486002)(86612001)(6436002)(2420400007)(2616005)(68736007)(8666007)(26005)(1076002)(186003)(15650500001)(2501003)(5250100002)(2900100001)(106356001)(7416002)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5ZIo9JdaW2Y2SgvjSBteGEI4hyVmJ1DEWhlze3SUl50XCozYqqmvWQX4ynlqXOcSMW+23e/SX0EEvdoMp3j0o8XdD1gSKHYB5qvs2Mqm60Xh7uv+0kZQf/Z8P4Ao7NSI+CTyWjUjkNnCvGa5FbcgKMsPzbmd5keWSAC3Bx0dpeAEzT7cB203yDxY58o+UDNEg3ifYXpAj/z6N4wXbhLCVtlSddnjvNrjrGeKu+vYPWd0/5/cim6KqjYxoXAXvJvjr9Ik9yJzkFMS7b8yUlwVrLzp7fbdd/nO/9Mhd4V+a5O/Aj8iecrUkPTPbTy4aAwGv8Hry+bVX9h9RYgFzrviCY0DF302r3oLpjWTSK03sktAl8HTinVqRBg1gb7N8ltJKE2zEXvF+dgEFLQoVHKVZxmzraVJlLtNAx4bNhTt+ZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e71d91-8cf3-448c-2fb0-08d59db0cb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:49.2062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit ec33838244c8535b23b8d24b167996fd1318bb68 ]

AMD systems have non-core, shared MCA banks within a die. These banks
are controlled by a master CPU per die. If this CPU is offlined then all
the shared banks are disabled in addition to the CPU's core banks.

Also, Fam17h systems may have SMT enabled. The MCA_CTL register is shared
between SMT thread siblings. If a CPU is offlined then all its sibling's
MCA banks are also disabled.

Extend the existing vendor check to AMD too.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
[ Fix up comment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20170613162835.30750-8-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index 7bbd50fa72ad..0a8ba9adb04a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2187,12 +2187,13 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel CPUs. Some of these MSRs are socket-wide.
+	 * Don't clear on Intel or AMD CPUs. Some of these MSRs are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
 		return;
=20
 	mce_disable_error_reporting();
--=20
2.15.1
