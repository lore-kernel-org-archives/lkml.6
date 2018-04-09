Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238219-2-1723618313188915213
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
    1523238219; b=Dis/1uHWjZc1oQQrGZ2IaOw/UXLiaOxJRn+im5t2FWHZtsyxfQ
    DheXlW98ODKucb3SEwAnFRwQ8FweGo62NE5JGuXFZEB+B76bENKaoxWTpfWCH0p/
    eYbfYHeKfRISRV0K724Rjm0B+KDbwRpsvbnWu2TvNJbppPPjOcOG2yg1uoPlnXxY
    zUBtyYmF5/0QjlaJccnrctRS3i+c5/qn2n6EKkfES/A/lV/ZsNeP22uvKzoPadeE
    z+TXJj9q+kDH0Z8FgF6Vp/Lx5FFTDGij+RttWsafpmKAIteNkjIBxMVesQICmR3C
    NL9vGn3HCDcyDIPKih4duPVu3/66kwe1DQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238219; bh=v97pO9OQrN
    NWhDOJpkk07ZIt3SV4vfNF++F6FrqMha0=; b=GoPaUIVLCTsRIQ6UHS14D5IQJ8
    QtBONjKk5sx52yOFmEabFt3UqISTgLdhqUsiUK9SV8UlVFXOdc7XnLL00qUxJUbU
    SaQ1OzpNrJcCjyKjih+YltGZkw/Zx6AUsTkof8tMY62PtTpT+I5JqBDB09j23K9y
    wo19gTYjkUmTFCOoBTk3pPwz1Gf9fv7DMOCjqp+1P4lWsxO4SDN0BynLJjRt1zbG
    I+iKiwQL4tGWJ8ijL4FjgTliE93i8THBlTwf2IylbBYeHxJKV2nyDKjqwY4L4W4S
    rUhmETKvO4grXVXhQILq70W+W+utnWqyrngeXTx21pZvebJO/zxoaIh6sSpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o4cAcSx0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o4cAcSx0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKpftYgPEjLAvjpF8DBTBO27tQwX9W/3K6SMgdFO30p32Loy7vfz+oAzllRKjv9sqR/ISLeqI3Qk3Fr2GrPV30Vkl8FpOZqZB+J34MB76xlD4l6opfWw
    tvGTSsvPQkJWx+s13APMfeThhs6muQkz/KwfOhmq/cr235oPmNAIphnxioaAX0TUnz9PtQZIelhVdNv3zyk/FelNEtYu4UnhBOlbaCfOpDlE8rlsBFg7PoQy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=6rqHouBjAAAA:8
    a=TYBLyS7eAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=YMnRgragKNPXYa1Kh6cA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Hx1yvPaMooE3kwe23bt7:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbeDIBna (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:30 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932509AbeDIAep (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 279/293] proc: fix /proc/*/map_files lookup
Thread-Topic: [PATCH AUTOSEL for 4.9 279/293] proc: fix /proc/*/map_files
 lookup
Thread-Index: AQHTz5lplOOV4TbqMkWpAESxLodEXQ==
Date: Mon, 9 Apr 2018 00:26:33 +0000
Message-ID: <20180409002239.163177-279-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:23DbLGZSekIBZlIb1kcETcAqDkxq2NkUdgxDPoQna/LOxxb5YyztbHV/+DepGtXAY/l8UBUZXPh1oRPuVNLIpVBTElY6TRUyj/wtWPCid7+RBwbDcV3e0YfuCrZcGVtFo4DVLz0Xf68RBXQ5xBfHUOd3NpInjk2CPzu5M1nXjGLnmKkiFZRKjuZCOIHI2jOJCtiTgnM1BPfZtCIp/3P7lkr+AHcbkZDCBTVTD92w3uZRSWa/HE6COTdywRN5dOE4;20:fVOUOlp4bg3/Gjb88i58o5RQDW7tXibB/UgFs73/fPB4BqsK+3lmuAfu0Ybe9x+S4SljbxgI9RlA234DYmsp1yhJVo9L1IaNlefgzW+j+vnddczaLjY1VYtiiAG3wnpVgCEVNb+RJH6zK5t8D7BA0vzwf0B9u1aLDsPiZZNNwPo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11ddc58c-87a2-4555-d0e7-08d59db1ae56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984CD86ACCCF62E56208BF0FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(39060400002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5a4LAXDFy77Gx41wUbOuFSzfT8EpBxyGIim9ZvdDFjDD59yXmmMVLCuwQKEAEjbtKH10mGOA6JNP3kPDqP/nP9/UQTPeDlgP3CWtbUf/5xL10Jqdn1Gi5VIqeQTgfgsrrdj7SywhW5eYlYvYz63N+UUOxGY+X1exLq4VNDeP69hAx2BdV1kWwvxgbkqlmiAGf3HK/sJgC92pnxIqC5+zPVJFZ5bXSIrru40snNkkBEycj1M7S3KO2xZNCjF/6yTcRslTPPwjH0hV6Wrr2/pf9XZ2jkRtaCU2CkuC8cuvX4lgqyYd68PPY4pkiW+fh5QGZew+RmKPts1b4GLLVniZT9kjzDt5DZbvLTz8U9fbpkZswXBD8Ya9hyZfeUTLHS38K+jyImfzjzTFUGcGDF4/fb72Gjxb9nm/dueXqPLdrXY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ddc58c-87a2-4555-d0e7-08d59db1ae56
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:33.9258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index e67fec3c9856..bc7e63d20523 100644
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
@@ -1864,8 +1866,33 @@ end_instantiate:
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
