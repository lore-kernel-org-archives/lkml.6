Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241571-2-8556326666824635454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241571; b=Vs2sSfi9537jqly7ZyXmpd8KZ2Twr67GwInhTDx48OzGO3jRb/
    3JtGw1JBsT35cQeLCz8okcd/nGGUZRivsDeAWgpfjw6SmCUPJ+pcNgggy3/icWnL
    6FMJwMSCEuIZ3iD1VGuLDctCNH5QnaLcbaf2VoVsAwbMinV3Uz5e2ADe1tk0HZ2G
    /RDydnHCm+K9Foe6v19qHGxRf4JJ9AEh98/FfdzxwHiWZX9D+XhndMDPCBpBaHPi
    SOdUmlfylpKrmzq+C1mvoahj/VZuAizq/i1cCDRpVD7ZG5Y+4DcyYR0K/e6CR7Xm
    /N0n2NziYzrfnqTRaeUShFW23vkW/+yx2K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241571; bh=dC6dHuQxyv
    3Q0EsfaFHeHVDg/64BpEKCvGurMVI/gr0=; b=KAFyV8bESOHWmCGVWB8ifnyKqY
    /UfVxcDjG2Cwc6XdVZ4IVGmlJG2i15xuCnY8v+BtBX25i8oUHnC05l2QvVnMlir2
    F4APfyeZx/k87OPDm/3704K7SELpSuyl1xrXC7c5k4HgKrN8D2+xNAVPY855WEqC
    JqozySN9a2Iw6is9VJLF5vP/0J7FuSaJ/BdLsp2SdliPjJ0oXfuS7UWX6B+pLFrq
    C3OecHa3v0FnA06y6ZXAbL/dJzrNCGMKtBe9j0ZPmcA5AQkwc43x4cA+07tGoT5P
    i9oU6XiSIU4upTEK1LjZdu/5XG8fZFlMG0T6ZUpdUJWmaw3a9hFtYB8cuLdA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XkMy7EFk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XkMy7EFk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHszpUKyeT5J9yQl0Ewwt4QjdozAICmLd5Rz5h7gc7paM9L9FYgCIAtV2GdWF1RL8DYAOweoldQhTUtgbPVvnbMSNe0AYrtTdg9o1OGicH5cInkZOb+G
    4KsQMbwb46iRchUQsSW9D8GfgHqIygwzhEicNlRjarfYsJBExoEdATGtiPWGZ4doPtl89Nbz6LwzqoFao0Kbq6IMClJuZVlT+gDHKCqg8io3v/Jk/ib+NIOo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=oe21-FF2zf8bFfTWEBMA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755913AbeDICjL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:39:11 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755569AbeDIA12 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 040/293] ACPICA: OSL: Add support to exclude
 stdarg.h
Thread-Topic: [PATCH AUTOSEL for 4.9 040/293] ACPICA: OSL: Add support to
 exclude stdarg.h
Thread-Index: AQHTz5j30d06Ra0ds0S/V7jcLhLB1A==
Date: Mon, 9 Apr 2018 00:23:21 +0000
Message-ID: <20180409002239.163177-40-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:Ki+JJXdo0wW/2tB3hwBOo5raaqlwl8lObUfBgN33niJFxFvZyB3d6jV2i3YxeEi41MFOfXbWoq2Ig21vhNSJ+5bh9LxnpFSnvag5x6uAAV5aQcwlIImqLI8+GbxLll6RC0OKsXUacGpxS5imRjwO8foALKouY+P6ZhBBnWWHZ4cDKbjOI+Sd+/7axvDtsENPSALAbeAL8Nx7ibKuaOt8T9IRkNlIh5tGJLtUNL11hTfBN4dnLLtdZrGunaCy1BFS;20:G+J6s4AKMgfutIl/Zv7kHMkX6b2MacC1OuuLlRGB1HeWqLCVZ+7nMrp37BEu+/xons52OdCB+E/j1WWBYiw01+YXrCInrmvvWLttVYHTLWDqLF+YwgSYvt2v6x6nfjqn3jvxCo3VIig1wkRTLlX9cH5TIppyuVfYjmXZ4xzGGyo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8884fd0a-99c9-4734-9526-08d59db0a9d7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312911EF583B65E2563993FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /pemL6vf71y966lF1kh3Vou/GlD7uFPrnHbZlsY7AT/QPYRWUbkM4Pb2Dzzpa9zUSDRhIzlG1b5bTXSfC6kEzuM3UlVKm7bIQhIWlhShz5vyT+jrJZgi3ZkKSFmu5NHYUr865dgHLYmp5yAs/7GKkyGPrWXBqs816f8XjfhsKBEszrGlGqBE0MrcgFfHM9ViWS+zpOeKrm96WbYgvn15OqQH+2UwyhhO+KwOefdJoNT3EaME2WENJB2Ia2nl3EJzfn0CFFYk8LW3GjgmfpsKyIkuhWwgfMvJ/4qYH8bS8+Nayi4WGLX26GHFgfi58lSC6sEJxF/IPTshS80qDGUmX0M6YMoFwBQhevtLTb+aexkHeW05xs6x9JYL8MRJS721+pt0mlICIprJO1Bv/yUT/RkYQBOfejN1D5+cRyE0BI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8884fd0a-99c9-4734-9526-08d59db0a9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:21.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 84676b87b27d8aefafb9f712a5b444938f284513 ]

ACPICA commit e2df7455a9a4301b03668e4c9c02c7a564cc841c

Some hosts may choose not to include stdarg.h, implementing a
configurability in acgcc.h, allowing OSen like Solaris to exclude stdarg.h.
This patch also fixes acintel.h accordingly without providing builtin
support as Intel compiler is similar as GCC. Reported by Dana Myers, fixed
by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e2df7455
Reported-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/acpi/platform/acgcc.h   | 10 ++++++++++
 include/acpi/platform/acintel.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 8f66aaabadf7..9e3f7618593f 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -48,7 +48,17 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
+#ifdef ACPI_USE_BUILTIN_STDARG
+typedef __builtin_va_list va_list;
+#define va_start(v, l)          __builtin_va_start(v, l)
+#define va_end(v)               __builtin_va_end(v)
+#define va_arg(v, l)            __builtin_va_arg(v, l)
+#define va_copy(d, s)           __builtin_va_copy(d, s)
+#else
 #include <stdarg.h>
+#endif
+#endif
=20
 #define ACPI_INLINE             __inline__
=20
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acinte=
l.h
index 17bd3b7b4e5a..bdb6858e2458 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -48,7 +48,9 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
 #include <stdarg.h>
+#endif
=20
 /* Configuration specific to Intel 64-bit C compiler */
=20
--=20
2.15.1
