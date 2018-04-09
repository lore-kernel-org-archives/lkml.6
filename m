Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234622-2-9201600213516440765
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
    1523234621; b=aFkvb02QUVI6xGiUNdH6OFKASL4NN9k9Cx82OShsOkX88Tjq1l
    wBlY4FcQrk4JDlwoHcPARYAkMxsmDiVEm4qgSutdIAUHtKHgYlIwnHY2kYurAxTe
    0pyc+NRjLEUCwUd3aYs2lA+myZXVS1GHn8iLCPtvNgGbv+1ULej3eV10bbNo3fTv
    xifSxor7f1Aa7EkNhi4fLad8Pqh4kWIjTAf1wugDmDpsPkX1y0VixbOjhEpJByr8
    dd/5ifqP3/EgHdTZJ4BsV8AZj6kbZuKoLK64Nh6b2+r0WgJbmV8EY1jEVn4Y6Yx8
    bttPCfSBMoGWnPWKMoUte6iEZeXulKsx+PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234621; bh=b/Ishiur8L
    j3PuG0dQJxY72VCjfr0HxTScybQz6ldgw=; b=g225w9R/flT14W8X3EMv5qKIQY
    8+6k7/AVQDa9pZcnNA01GHyIk1dNXEm5C7f9DbeYlq2gC2qCGyjUdvl3a3SD+ARQ
    /0AmVdkuJxTw9tpOPjLX24w9eXtdhEFrxwv90njQeovg2dqH6icQag8yUOQzL/j5
    JDYndjZNqhb5NhoTd4DDveAKsBo5YgnMzsKfudPPKIk2tJBwhb5zK5bo/Su/tUGd
    pwqZwk976F5TIuh1jVFrPu44U40bTinkKr3JadQINrmAL1B4GHMGFyeOVasbhk0b
    XfptstbHcwAoTXDi3SreTtMpGUSeGRVInV+dwwlV3lpodzkz+HwxCAcJyI/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P15MCXqv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P15MCXqv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKFZgKOiwlnCJ4irl3Fe7HdYx29Ev0M/HdFkQ9Qflx5JsSWj33k1BM59MmfnSctFt8a51KaoDPH848mWF6rUacGkKhrt+xUi46xXPdpHB5VHjn8a3zgu
    QRXE7IQX5XY+091Ok7KJ79Tl+KEkfcU+PA86OAvch2FzCGCOP9sZeg9UWz+NlDRef9+xcc3P51kV8V3BRDVLGEWn+jf8ybiVSDk8ZbwN2whew2fLLijAV+FW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=6rqHouBjAAAA:8
    a=TYBLyS7eAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=YMnRgragKNPXYa1Kh6cA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Hx1yvPaMooE3kwe23bt7:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeDIAnV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:43:21 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756772AbeDIAmf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 094/101] proc: fix /proc/*/map_files lookup
Thread-Topic: [PATCH AUTOSEL for 3.18 094/101] proc: fix /proc/*/map_files
 lookup
Thread-Index: AQHTz5uMXk30SWKDZUW8EWP0Jaiv0w==
Date: Mon, 9 Apr 2018 00:41:51 +0000
Message-ID: <20180409004042.164920-44-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:IOpWUn1UjVrdG2u3OKkyXODyc2XauOX0PZYMI4onm1cGp2lf1XWK7IT55AP2nnIB/Wu9EBXwqhBSCitXrUb4VFLg5e4C8ecMLuzNHabel8s1WVABJabWCJ/gHCFUu3kRZz4FNdo93uHrnVBGg0vrqutZxpSzEl1MRa2eOBVMy6fEHpQK0NQwtwp5U2MUYsR4nicrYWiUyi/L8nmS9/vUoxekeKCBY/q4jm8BV36oAPJ4ZMrdKCvvd72hMT+04XIk;20:vP6z5imS2oMsM/AHOSGYusM+P3eACNkkeLot0NfFcIeS/nzrnI2arkr3ScAu+0xJwCc6fKY36+aHPE9SYrkbTHD0isXhdEURGF6wx7XAjwSXapiGUouCVR2GnZi+WIgf/SQnuZjftUvnB3ywjRgFFnIh/4mMiN8IUF2nKA7kd04=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70a70733-3631-4a7a-38a8-08d59db2c38a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10621AC83C674BE2B75157F0FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ccDXDqhQ0UlgcydRbsWkULq8pD5NaAcDcc4KMWWLfZByhmrRwau9VZHtIRObXrSbNcCZgm7+IUQ2raWAalfl+tbMbEsN58/rObtWk8R2TBkWUYAtWP0OymU7WTd/9Sl0uf15TKHjyUAlwV9dylkd3mZDeZrny0n58X1FQHvOPVWeWSF9UhE3O/xw987vT4po8fJk3ZPam4Df9LgZcdVG5WgN10WfwcEbkdN9B8YfFmgDsC1K/Z2dO58COLnrvIWKrRIJAMXwFuGU2fVY/4O9cH3K3InBsJRJkcOCXkiSotb2R1VHUp4V7LzyBH/b32cN+YAXy/lnu30k3rBlAHxtZ5+s2LPq3q/KKhimV6FcgnrZ8+Lkm/x4Nzj4v85ACaKAFVwFKScRZJ8OeQ/c1ooJEPe9hh96F5LNhe4LODL80RQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a70733-3631-4a7a-38a8-08d59db2c38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:51.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index dc98620634a3..71e586465168 100644
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
@@ -1642,8 +1644,33 @@ end_instantiate:
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
