Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236058-2-17991589031689142929
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
    1523236057; b=DRbKV9tZZnFrMoKy+S/isoBHo/rhx8MI4EpvLKjYJPE7YlRXv7
    xFw4GSzMU92mWhSNDj0B8REtdcyebv6y/AQ3FQR2Yu+ITby4NzDqkz14cludS1gL
    ET5HCBu94sY7StLzg0+xSdpeLdFD0MAzaiNPBQQBMKTq/8P98Y24lXoADb2TijQ+
    /DJXus3tqd7UxYenDrEJPX3gJQP9dTMOt2KnoxBn3iD5ea0My9yRqpgGNAsbJTsx
    up7APiLyXut7taqDiJ0xVSiPA8FJrGZnlE1rKHVBMHjNF2sSu5Xso4GD6SxbHqCq
    fzKAd/86h0K02JSjiUJ2XCbH/lmicCxtLSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236057; bh=LSYCh97MTa
    +BVjvOY5pWvctbWZlGajz0Fkg8r/pZlZI=; b=Mgxp+GMf2nLWpey/v7IININp/o
    0kSQ5d5g+fAsYpysfinXWmem4e4dEfLGPY+5verbXTf2zR8ev3pLTyzopNQAe0wf
    lHUjizlNaupESOR0SYNF2/cPS7P1gm8NOvxMM7s5VCwdFkWy/a0oO5fozugXBzyo
    9es4DsvWc6s1c4g/UYwhRDtMc5a9Wa3M5jPqW8F9FtHR3uO4p8SZ5y4sf+WIdvqf
    JwxyiqruOzzHUWAYRssNmmKJnTzYnu5IV+nzhOEPuoncW6c5tSpPJJbfYwt79dMm
    sJ1dlcZn5NefM8bNrKwtpfdhOsrz0/Izb4rm2y0T9PnFdUitSB3sW8ZfoWQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RVeFwCGl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RVeFwCGl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/WW9K92+2VG5HcE4dl1IN4KSLpBviudaesDwPhtqAWwgkqKl9BT8GfZ31gzp65aoVmPASgiIdI7xwDdKwdOjFezCY8uTr0GxQXymq+F6IhneP+T0WP
    E2lqkpRYwumbr+wfGjuVmRdA/LlI2In3w6pQ11ofGXWcFC0V2ITsNh7d9M52csVXjqvxKyLbc8RPlTr5Js5ZvlktnTBSiJTlwPGG5INCBfW5I8g2U17Dos7y
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
        id S1755513AbeDIBHV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:07:21 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbeDIAjV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 153/162] proc: fix /proc/*/map_files lookup
Thread-Topic: [PATCH AUTOSEL for 4.4 153/162] proc: fix /proc/*/map_files
 lookup
Thread-Index: AQHTz5neNnJeBtkMhEixsDuEp+R0rA==
Date: Mon, 9 Apr 2018 00:29:49 +0000
Message-ID: <20180409002738.163941-153-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:NXRl97aPQKCrSyl6vBGbotRROrSbkc8ULqyQJpHXTwSvlmE/8iwHF9fq3YCfRsJG5KD6cYzdBKy8XOwXrHd1t5hJTPSjpPFqvIlsW13KLKRFgBnybv4spAyQgMhUkVF4y6DBWZkHLgRbKjSyRFQuCAX1zdHGIPX4E+ZP84u0sWrfm/1qeDKVNbIk2/OMtIn/N2aY1EUAbFMtILUUgQo2NH/lgoI4wDD8UFdyw+5MRM+Uc2xAEiYc+m+1mnYtaiBa;20:drJTA13hTBBkdN1fz7atP8cYV0G6y+tUbKF4Sv3uXsYdsbw0l7R7fzbDm4+ytqKwRJtjgZFJGrScCwb8pQXOZNQCo4UvY02RgIqB0eH0TJTqChmpG//mCvPMEW+EF6BzgGL/Ed8wnJm211w+ctaTE3lWjJeKtdnW40HiXxmAjAw=
X-MS-Office365-Filtering-Correlation-Id: e3347547-b3dc-4852-4431-08d59db25484
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11257F7A0FA0D2DD89B9C179FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(6306002)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(39060400002)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(966005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: X3wOPYAlL4ig/sDsuWzTVtkIM9vEVHrStLonGz1UZQU8C7/0l1OSbzJeTKJ9uojSsMt7dsvjFwbvJvGCXn522Oddi8uPLF2DhWKLoL+qzJCeYmepaCjphWNX4dt9gLEp7MDxUApVTwwC10gjNOFdRcZGZXt9Thvf04U+dRuUdxWpanR+Hj/lLTbe9jbaUUyfqweSe/x7A0IfAFW1H+Er6EsYsruTNBSAjMt3B5UkHoq7+C/9CKd0YG20c7JGaAaJRbATaovrFfmf+H1RkSbBwrr7f8Or07nErJzHa0vKXc88n+Pq/jNdavwljnQz0lbJKU6vlGgWrD5A7+RHhrRDJNOn0FOfVtMvzet5bw+1Pcr9gv2hO//58NetXf4KtLbkNtq9N4kghVjf3uK6jj7Aq+acH99sr9ej0ksgP/LUHAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3347547-b3dc-4852-4431-08d59db25484
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:49.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index dd732400578e..2e6266944253 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,8 @@
 #include "internal.h"
 #include "fd.h"
=20
+#include "../../lib/kstrtox.h"
+
 /* NOTE:
  *	Implementing inode permission operations in /proc is almost
  *	certainly an error.  Permission checks need to happen during
@@ -1829,8 +1831,33 @@ end_instantiate:
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
 		return -EINVAL;
+	str +=3D len;
+
+	if (*str !=3D '-')
+		return -EINVAL;
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
