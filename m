Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242542-2-12817276134623580501
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
    1523242542; b=Mim+7or0W7AIr8Ywec6lo0pKt9WLIXzpo7T2KQvtCPXQ8yN8gi
    7sjkFXd1ayx3jBufv6fDtsyvY/LWmWIh0TQg0G8MWjuoZGU5DVBKzZBvt7P3+acv
    ZrUW5MLOX6Xq95IJSuFbWSmj+47YSbanvi8KAgUDjNAzSM+fv7B/9ApISGXMLNel
    4d+Q71bqmWI8elFsUl++XHnKuw7QFZucPCrwuYmAF5nYFNdS8PSo1izNKtu1uDOA
    fbRaq0bcBoYaU3SvKGN6n5l53e+aZ+89NbuWMkCRI1POyaQgdrg026xFMt0PKiBf
    amPdIaW4Mse8Ggts5v48xN0TNwYS0KnWTzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242542; bh=FkBRQw7O+/
    bqcGnjrGhyUc0z1hMf6hd+kTlZcMlMX0M=; b=g8k2eAxDK6VAgTtlP8wLM2RICA
    dQ9MT0mFQvR8+BjwRlIN5mUfc3GDXVEkyWkL9EqyDKVep0Q65+5JkIcsRzULOj06
    J2Z2nwuRbrxaITUxTok47tRBk8WK3KfbNtx+yyWrJiVVwY34HKORiRDw/phJ/akT
    7VFcl3n6Oz9DyhQOiEsirDr+75+n43QrTg59LsTpPJ8aRHyGhbc78+iArQgQuy0v
    hNQHR+y7G6c2y8EaHOYPpx0qbsOEsOhvH820/xAhS/wn/Onyv2JOQJkWHDYYn+pm
    XG+iPINVNhKloCW/8h/0c64gvcCjQK82YiZuT2MU1Lry7z2FL+TsVB6oxnNQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jOOOp4J+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jOOOp4J+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFrKKotBAkRNEfJMIkZkKQ/KkI8mTUDubZ8ar+onsOEc98tDeWXi1kohdccvE6ayRy+DcuI8GdEGOYOB/1MjO+4v3yHUSRP+VcCO0l+Q71ttRHI3c8VB
    6sSvE1DZgPlm+Ve3Kz6YwCmE+vmss2ZwL3Ok8rG+3zv0p16ocbEK6ILZXp8QZw+DmAwy/Qs2eP5dQVKRXZO/ho4rskjipXmsc6tRyTMjbJifVaOLeaTKWsLP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=6rqHouBjAAAA:8
    a=TYBLyS7eAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=YMnRgragKNPXYa1Kh6cA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Hx1yvPaMooE3kwe23bt7:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbeDICzX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:55:23 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755248AbeDIAZs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 133/161] proc: fix /proc/*/map_files lookup
Thread-Topic: [PATCH AUTOSEL for 4.14 133/161] proc: fix /proc/*/map_files
 lookup
Thread-Index: AQHTz5i8g+mUbqKDr0GOIxzGVOqbaQ==
Date: Mon, 9 Apr 2018 00:21:42 +0000
Message-ID: <20180409001936.162706-133-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:nGT+E3wo69lNfoYYcxv9viLM7DxC8v91du+LzQPb1YsxdZ1viznMuSr6WmKdbQrVEsMm/wMeKeKaCX1hQlhOnOj9A2yKz0Y3UWNg3Rk+owNPoGz/MUvWaoojunHjfpKpfMRN5b8K4NeJ+uQJ2BduyDbqslKrbCuH61TkURgySSAl5GhX2hiuWIh1xrUcNnMNhN+2Y0qvld4lay3bMtOlFNjytHthrMePp8KkG5PAzazzafVtdKuMtywD9abgfYbc;20:6YCzz9cO8Vol7xIMEX/c79I7X0Ek1khv1MOr29ga3gSND3YecsjPyCXA/Pl+YvKu0uhClla/4o6Lu0xz+FaKwkWxvhFQJFGq2VeHMsBmoamyRph7MWeSxw/CZT5ujKHsQROPfTncSHW0TedOYgIp1+MxQ5HCljpXDub0nx8INJ8=
X-MS-Office365-Filtering-Correlation-Id: 3ca60aee-abbf-4bfb-72a4-08d59db06bc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013A5D4DF6FFC61EE1A3C31FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: g8CxjoFe9/snNaQpWK0/jL6cJlfCY4BD2tjQGZ5jA1VUbWrnQ0khVd2XCB9lu/CcUmVvRTnshlOwF3cQYE751HZVpSTjnydj8rsHevurrP276Z1FKx629gKnKxrcuOhoommKoB6/hUJl5VXdu929rnLNnMl4TSt+X7qCqe9VCqUTulqBiTMgn6Df4apU1ORXYVAuBxgcrj8/q6GBiOVm8slgElBU6SDLD0GR0T44yUgIb4A+Q6orcHMVPyxdCnCQpa/lO/tlMotGU9NvO3c25sWW9kPV7PJ2n/Mnp3gaEwu9JpM37SJNigkc06Y4Shvnx1Dz4OqLz72qArklTwUZ0R7vStwcOxHbGHnYO6RgfDggBcR2bT8UoxkMY81f7HkKXNNOA9tldW+TOvX05/9JnBGx7C/hQZlfk58vPRNnBRk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca60aee-abbf-4bfb-72a4-08d59db06bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:42.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit ac7f1061c2c11bb8936b1b6a94cdb48de732f7a4 ]

Current code does:

	if (sscanf(dentry->d_name.name, "%lx-%lx", start, end) !=3D 2)

However sscanf() is broken garbage.

It silently accepts whitespace between format specifiers
(did you know that?).

It silently accepts valid strings which result in integer overflow.

Do not use sscanf() for any even remotely reliable parsing code.

	OK
	# readlink '/proc/1/map_files/55a23af39000-55a23b05b000'
	/lib/systemd/systemd

	broken
	# readlink '/proc/1/map_files/               55a23af39000-55a23b05b000'
	/lib/systemd/systemd

	broken
	# readlink '/proc/1/map_files/55a23af39000-55a23b05b000    '
	/lib/systemd/systemd

	very broken
	# readlink '/proc/1/map_files/1000000000000000055a23af39000-55a23b05b000'
	/lib/systemd/systemd

Andrei said:

: This patch breaks criu.  It was a bug in criu.  And this bug is on a mino=
r
: path, which works when memfd_create() isn't available.  It is a reason wh=
y
: I ask to not backport this patch to stable kernels.
:
: In CRIU this bug can be triggered, only if this patch will be backported
: to a kernel which version is lower than v3.16.

Link: http://lkml.kernel.org/r/20171120212706.GA14325@avx2
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9d357b2ea6cb..2ff11a693360 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -100,6 +100,8 @@
 #include "internal.h"
 #include "fd.h"
=20
+#include "../../lib/kstrtox.h"
+
 /* NOTE:
  *	Implementing inode permission operations in /proc is almost
  *	certainly an error.  Permission checks need to happen during
@@ -1908,8 +1910,33 @@ end_instantiate:
 static int dname_to_vma_addr(struct dentry *dentry,
 			     unsigned long *start, unsigned long *end)
 {
-	if (sscanf(dentry->d_name.name, "%lx-%lx", start, end) !=3D 2)
+	const char *str =3D dentry->d_name.name;
+	unsigned long long sval, eval;
+	unsigned int len;
+
+	len =3D _parse_integer(str, 16, &sval);
+	if (len & KSTRTOX_OVERFLOW)
+		return -EINVAL;
+	if (sval !=3D (unsigned long)sval)
+		return -EINVAL;
+	str +=3D len;
+
+	if (*str !=3D '-')
 		return -EINVAL;
+	str++;
+
+	len =3D _parse_integer(str, 16, &eval);
+	if (len & KSTRTOX_OVERFLOW)
+		return -EINVAL;
+	if (eval !=3D (unsigned long)eval)
+		return -EINVAL;
+	str +=3D len;
+
+	if (*str !=3D '\0')
+		return -EINVAL;
+
+	*start =3D sval;
+	*end =3D eval;
=20
 	return 0;
 }
--=20
2.15.1
