Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245246-2-6456933200782401130
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
    1523245245; b=XKHZlm4ElA8MtBeQzA/VDU1XVA7KIHMZbHXWQiGuz9osyZJ6E2
    nLcpChw+SfV3DO2BbNuOIwlGpX8c6J2nQKi5/qZwq+C/2IYOksBqVipzVe+LE55F
    +ekazsaxFjYypAk5rHlgHT4/fj646cSa3rlhBiDq+AvJ8tw8czS2oghQx3DXjyNk
    7y+fF34AXLp+Br4TugobFdqEGK8OvmMv9Phczu6kVAJjCPvAuSTjExQmHcUCqykc
    UGbeSzOgKoVznDJ8GvhzuZrOldoeAgL9TBcLpwhjgz90Wo5acgH71GDSklsWTiXI
    F/TobRv6Lufzehc7QVAJuugeRnPimWQJOKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245245; bh=xuDeQUPJiz
    f6GBpIvFFKGRrnxR3pvyXRj9XJHPH9DDk=; b=fl+6XDGdhObuzAns6Zr0w49f5F
    pKSBeh3Y/OWHRJtSTwpc+Mv0n4mpiCQAwDLwo/rzxLTssEIdVkDOBJBkU1zueERR
    Ya/7N9alzGy9IDIU5xIcC2llv6HPLdA4s/Tt6Lee+hUhysLg0DyQ1WEeYLnb3WsG
    GaLaG69Qf9VaH+iu62OeVqc035SIHX4VW4yQ6IMo42xnTLIeRJsJ9wWOSgR+KFnt
    3gzsBB6P3Tz0XVdugRbA7w7pr4srBhMR0j9Uf8aLizpNngiueRJbQ9n3iwV3t/YB
    lNg7hDy9CDyRA1zZcG3b8ELuHJMX2peCWaxQZ2GJ4Wbo0J2xGFKouV7+CaMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hFr41f4A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hFr41f4A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHuXwvFoi2nNxQr3lM2hLvgTKXnDGbYPSimi+kIxfImF2NECy2IBcjS7wl8e5koj/4EP1dO8J2ls/oEnZtMw1BfOhdgJWFdVE/AHzr5J/HYbtrI/axIm
    Si/3FSJE7KjqpB83CIUllP9vJxahfb+gCZtFKodbvQ/Bm2/m5x7O+YlgB/2jo4WQ7JHFGsQGLaaAS18cE/WCCspLQkgxxg1pNBJn2GcnZDws0tcbFhOUUhi9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=6rqHouBjAAAA:8
    a=TYBLyS7eAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=YMnRgragKNPXYa1Kh6cA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Hx1yvPaMooE3kwe23bt7:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeDIDkH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:40:07 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754363AbeDIAVH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 157/189] proc: fix /proc/*/map_files lookup
Thread-Topic: [PATCH AUTOSEL for 4.15 157/189] proc: fix /proc/*/map_files
 lookup
Thread-Index: AQHTz5hY/86rBVA9YUmabtytGNyUEA==
Date: Mon, 9 Apr 2018 00:18:54 +0000
Message-ID: <20180409001637.162453-157-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:6PZ3/LBSMbsQi+h2N7mk7aeQ4q7Dwi8IfNOZIlDoMtyaQ/qBzeVVJZo8u2QlUsCihA+T8X4TH/OWV0V3mczdtRU6KoGR2EHxZGxf863qi/o0Q61STDmcBC6iuehjCsJSwn2tLDLCBXdCrd/EMx82Znr+5qOurOMZe7SVKHfH3BFBtI7tKdB3HTdamjj7obA9xlD0987OwiXTZTyqAZEDHzkiL6HjTCzuVCbbj/LmafOoK5ILqAfc0ABap5vwvAyb;20:wT6MF/psnSt8fV7sikvh5JueETulL2QAvbZNo/LbTcJr3FqVCOjILlI9qAR71X6G6njpFE2xm2uSTOzLEE6EtNxzKsf+9joT7qUNIwQ3hk26ZtwSc4ct7+sKc3Kly4q0zl2o64QAJOII7iKfm6akDLvvW0xb21CQ8GiT4hE1QNs=
X-MS-Office365-Filtering-Correlation-Id: d685a4ca-81c7-4585-ff27-08d59dafc5ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092064BA40FC4D889C7A8E04FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zAOHMxKfg84twvikxW1462kd+HsJvbbEO5mUUtHijvstgLlakAs71kM+edihO+ddG+9UZt99DcOKKR0V244/shAUoTbvwYNZ+v10BBVSlYub8mEEdKLQcDibZA1rLBlgakR2ClN3OA4I4bOcQfcJsE8Rf6KuFktONO49wzRO268a2m91BpiIQ+mUkfy8tbmBG6aezy8UJF8IiUz6wBQi/yGWapNLfkwKB3Kpn8iWlisFrOEXyzwR0VN3FT0mvtpq0xiPbysALjf+3+WL5EMvaQ09n4xyvgUN4fTmRMvYAk09pvBdOMbwyKHRfIdyoBFiT67I7shHJkwFwj3bJg2+CoanOmdDXr7tZqjR4QV2ytlmMuFyBrmPWDpwW+FwoPEDymp0pX9X2Z0jiEAJvkBikz2R95Q01Mk+iS6aIHjCpEI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d685a4ca-81c7-4585-ff27-08d59dafc5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:54.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 60316b52d659..7165e7419bd0 100644
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
@@ -1907,8 +1909,33 @@ end_instantiate:
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
