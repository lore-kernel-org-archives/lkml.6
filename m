Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234543-2-7302661085776750627
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
    1523234542; b=R2+MQVy8vDEafDuMmnOHrWCEGmIW5uV8+X5/5porpmFazebtNL
    yWw5kp+ryQuLb31ylWzA+vl/hHS6Nsx3/ozR/KHDDerARWkux0pkPLkABCa73utU
    0XCURMZ4kRubETfIexPsxTXwSU2sr+HodoBUnoXs9jG8Vosd1p1n9AV3obLoiprH
    LaTnDQZipk/+nHkEQcOzCh0qM9Av5iCKA8d54W6qJZVSh0Uww5C98gpjL/7uWtUH
    X6t+quFDlqWkXGQr4olI7OW4N2RJa3/BLVJEMdRZqWT7wp1Sm6nSip58aBbFkhR5
    HdOh/Jsz/wecsHq83VliWr/5LidLkyAGkpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234542; bh=M72YPajVK6
    3R2NYPwRgT+pqDmpk/ZAPSSDPXXv3XkEs=; b=XR8LcmOwUogb7lpfuj3qF0ZO/a
    b+/AaqpmQqBJu7vSCojYMlNXX6KPG6KMcepaEVGxzZvxZrkknUeavlHuJwOsUeDF
    sjE+W/y5ZsVD5rXPFXmfyiHx4r/JUilpSPoG1gXh9tTiydNgIGyPYBEBlqJO2q1U
    nB3AAdIucZI3+Sv5TgYSB8DyeNjPVJioJ382tcf0k0q2/QnSjSZ16qJBHcjMnBMM
    YsO57NDM7FZsOODg/jju6TxkONqZHyd+YeDr+Q4taQlnPZvfrJkQKbxmxFLV9lxj
    q9M3jl9Y3X9rZYfbwrfYcStTYQVBsNFoUIf/AtKW24rxjiLiFja3erEeV+xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lQ5c91NH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lQ5c91NH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbapCWdwbEbTk9sqbSRkjEsKZRYNTwRCymqJ0FV3VSoE8BYZq2xTFX8ktEPph9i5i8Yhdd6ZUoUfXeuZLYv19dTCgVgcT0ddEfOrdUEEOuW0H6TbiwC
    24QEuIW6KND1Zrf9SxPoCenGsiIpWv7vddGCc0zIGtkJrXhsmiNl/qlB0fSO5JhPeeWVCDI7JE7GWZmVtBL6IMxLXYxlxMkaX0ekVPF1KQtLBeYTiTR/dhFj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=GcyzOjIWAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=NufY4J3AAAAA:8 a=1XWaLZrsAAAA:8 a=nrACCIEEAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=uHNeC5YgsMNH8n1iQxQA:9 a=wPNLvfGTeEIA:10
    a=K5Pz1n7aZbAA:10 a=DaFyWFqZkG0A:10 a=5QuTyhz7_sIA:10
    a=hQL3dl6oAZ8NdCsdz28n:22 a=AjGcO6oz07-iQ99wixmX:22 a=TPcZfFuj8SYsoCJAFAiX:22
    a=LP-oT3CeHzb3Kpa8nOvR:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbeDIAmT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:19 -0400
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:31513
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753392AbeDIAmR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chris Salls <salls@cs.ucsb.edu>,
        Christopher Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 084/101] mm/mempolicy: fix the check of
 nodemask from user
Thread-Topic: [PATCH AUTOSEL for 3.18 084/101] mm/mempolicy: fix the check of
 nodemask from user
Thread-Index: AQHTz5uHr7BwhbTQ902PL5ps+D6RVQ==
Date: Mon, 9 Apr 2018 00:41:42 +0000
Message-ID: <20180409004042.164920-34-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:cSqjT55F+hdGWRQU+VQSRg9ylr4TCbwHNn/1V6+0aJs21snXXRcg8y3Dt8KAep2YM4jfyOjqavf9blBXnsoezQUFm9mcXG4VEyDFWPoyE6c3CGwAeWJWItwWXBH8aY8q5Jkq8PvUWCGX2199VuAr2aV95sZ0Nu624lZLnlHIB/r5P2EfYp+jhQE96S/4hzhYA81Z6cm/DBEChxwuhxFPYYVgHpIqrbmdhyMeEqjPvTN+jbwKpVN+XKhkduD+I37o;20:H+sZlZ5XGvUgmXt58htPgGbISSXuzcKWAzr50eMznnsuzg8sgGSQtHuigT2SN76RsIIlXnUmHvtGq/KIgma4IT9+bQ0+KTaY3Bt2mlLrWTAy8jDoip+dLEE3Tvu3Z8LHcNJv1hpU7ECSrtTOC98Yyo4M+wvVtLdsmPC1mUTfg5E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff3d2a97-a18a-499e-61e1-08d59db2bc9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062ECE9758E8A80B0566648FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(7416002)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(53376002)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nbBhm40JMzPu8AUseMnXTOclMIY3URToGq+ygesd6qACq+cIhOKWKcF6E06vpjD2mFzfBMBGgPiOrjlsne4shmeOpEFYga+7I6zbOOjfSxaPk6ysfkRqiJIKIKDQTZMaSfhI9TEU12Ibj+siK+PbC7TX2NUjvW7eqlHnwUK23HtQxHyvJYPr45GwCv/tXB7PmGc8XDZ8/MiEPA0Csa4jw1sn72n1qfQxO2aourZBI05Vgf/2Ccn1n1kKay6vcDj7H0DwBPhKwswczIjk/Cs/LotUPWZGAwB7Dv62EgL2xdvXdqCig3N9Tx7i95SP6PfJVt9251aHxVAa/dijdxbvllReEtOO/lQ5dx5rRX7VXc4dfqEPmj6tureJeXtTfygIZE66KOSkGjTZQrfUM9MxT8C1G6Y3Pg/qRVdnrIjeANM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d2a97-a18a-499e-61e1-08d59db2bc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:42.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yisheng Xie <xieyisheng1@huawei.com>

[ Upstream commit 56521e7a02b7b84a5e72691a1fb15570e6055545 ]

As Xiaojun reported the ltp of migrate_pages01 will fail on arm64 system
which has 4 nodes[0...3], all have memory and CONFIG_NODES_SHIFT=3D2:

  migrate_pages01    0  TINFO  :  test_invalid_nodes
  migrate_pages01   14  TFAIL  :  migrate_pages_common.c:45: unexpected fai=
lure - returned value =3D 0, expected: -1
  migrate_pages01   15  TFAIL  :  migrate_pages_common.c:55: call succeeded=
 unexpectedly

In this case the test_invalid_nodes of migrate_pages01 will call:
SYSC_migrate_pages as:

  migrate_pages(0, , {0x0000000000000001}, 64, , {0x0000000000000010}, 64) =
=3D 0

The new nodes specifies one or more node IDs that are greater than the
maximum supported node ID, however, the errno is not set to EINVAL as
expected.

As man pages of set_mempolicy[1], mbind[2], and migrate_pages[3]
mentioned, when nodemask specifies one or more node IDs that are greater
than the maximum supported node ID, the errno should set to EINVAL.
However, get_nodes only check whether the part of bits
[BITS_PER_LONG*BITS_TO_LONGS(MAX_NUMNODES), maxnode) is zero or not, and
remain [MAX_NUMNODES, BITS_PER_LONG*BITS_TO_LONGS(MAX_NUMNODES)
unchecked.

This patch is to check the bits of [MAX_NUMNODES, maxnode) in get_nodes
to let migrate_pages set the errno to EINVAL when nodemask specifies one
or more node IDs that are greater than the maximum supported node ID,
which follows the manpage's guide.

[1] http://man7.org/linux/man-pages/man2/set_mempolicy.2.html
[2] http://man7.org/linux/man-pages/man2/mbind.2.html
[3] http://man7.org/linux/man-pages/man2/migrate_pages.2.html

Link: http://lkml.kernel.org/r/1510882624-44342-3-git-send-email-xieyisheng=
1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Reported-by: Tan Xiaojun <tanxiaojun@huawei.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chris Salls <salls@cs.ucsb.edu>
Cc: Christopher Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/mempolicy.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d326955b4d05..3cd93e8c9c43 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1286,6 +1286,7 @@ static int get_nodes(nodemask_t *nodes, const unsigne=
d long __user *nmask,
 		     unsigned long maxnode)
 {
 	unsigned long k;
+	unsigned long t;
 	unsigned long nlongs;
 	unsigned long endmask;
=20
@@ -1302,13 +1303,19 @@ static int get_nodes(nodemask_t *nodes, const unsig=
ned long __user *nmask,
 	else
 		endmask =3D (1UL << (maxnode % BITS_PER_LONG)) - 1;
=20
-	/* When the user specified more nodes than supported just check
-	   if the non supported part is all zero. */
+	/*
+	 * When the user specified more nodes than supported just check
+	 * if the non supported part is all zero.
+	 *
+	 * If maxnode have more longs than MAX_NUMNODES, check
+	 * the bits in that area first. And then go through to
+	 * check the rest bits which equal or bigger than MAX_NUMNODES.
+	 * Otherwise, just check bits [MAX_NUMNODES, maxnode).
+	 */
 	if (nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
 		if (nlongs > PAGE_SIZE/sizeof(long))
 			return -EINVAL;
 		for (k =3D BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
-			unsigned long t;
 			if (get_user(t, nmask + k))
 				return -EFAULT;
 			if (k =3D=3D nlongs - 1) {
@@ -1321,6 +1328,16 @@ static int get_nodes(nodemask_t *nodes, const unsign=
ed long __user *nmask,
 		endmask =3D ~0UL;
 	}
=20
+	if (maxnode > MAX_NUMNODES && MAX_NUMNODES % BITS_PER_LONG !=3D 0) {
+		unsigned long valid_mask =3D endmask;
+
+		valid_mask &=3D ~((1UL << (MAX_NUMNODES % BITS_PER_LONG)) - 1);
+		if (get_user(t, nmask + nlongs - 1))
+			return -EFAULT;
+		if (t & valid_mask)
+			return -EINVAL;
+	}
+
 	if (copy_from_user(nodes_addr(*nodes), nmask, nlongs*sizeof(unsigned long=
)))
 		return -EFAULT;
 	nodes_addr(*nodes)[nlongs-1] &=3D endmask;
--=20
2.15.1
