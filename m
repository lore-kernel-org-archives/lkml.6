Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245727-2-1307891176159501349
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
    1523245726; b=poso7gvBAyFncIU/uZ2FLj9O7JD0ADhPyQCTfK84SmzLe60DAD
    F7hNKQItVCEtmGjW56KQc2XrTf+nuDno4gbtbYGeYroTJeG1A4N5P+pT7OgxErHk
    tB0pGFeZ2whmmEWnMzCPu3/uzlqNzzKK3BndMkN/99hunt3dHZuGSvmRK9H/mcTl
    4JN+Q0fb3t1DBeAZMllpX/VUS5RAqNncW5EDNPCip4BrM8WIbUvB5bfHn7WCFAoZ
    5ccRmxWb+tYjyREI6oTBAXBrSSRZj67ViVPpYShsE7IkjY6UxTle2hn9gIlCjwHh
    +IwVIxcwb8VQfXKj0avnLc/JIQnAIVDPdGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245726; bh=27B7802sNC
    4EQbSenSkfAM/I14IYJxN/zup4CX715ic=; b=f6ShNJYXZM3CIxe07mzjjboYk/
    gauHWcWDcuHJyoLF+KaaiUhzNliy7PF3rGFJylV30EtcxNTwju0syVKdP1QQ4Rah
    Mlp1LL4jd8/TW6wVoz8ViTDwE1eDUCKj1C1+M+mFqnmspoZkdaffRBO3CBJjCFnO
    +aHLqOocZbDfHegXYsNO7gaaCHC2K34Yr2o2hcsLWX65UHBtZVEzADLfolfuo01E
    U2P81WtBAyA2BFqGR+OgD7K0kwTUSzhHwnVrveBSNMHIBmvw9x48jArp0E34686C
    y7kjxqq0XFa0KfLblP6XEc55q0kZxHeLbIg/nMGy9PPrmfbsajUtJF0nvtdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hiKxYUND x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hiKxYUND x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOnFJxxUzyRfHGFQVKkhG2Zb4RFHGW0v3mFY1UYj9Y+eumVtXl44ankcG4yuujv/wfRbjwFgXROtTuWp6w1p9hCmUvt45UMFYafeZW0I5wLYPnhzxPgB
    5tcaO7KZGQUAlrOsA+N075Ho2XBvWnT09dpXYP/XAXUF0MrX/555pYHOB71rB7WuOOnV3prw6KUDH+DOE0USUv8rP79WkpUifqlevt0LDo8HIfXt/wTD5PMr
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1754120AbeDIAUF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:05 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:14464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754086AbeDIATg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:36 -0400
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
Subject: [PATCH AUTOSEL for 4.15 119/189] mm/mempolicy: fix the check of
 nodemask from user
Thread-Topic: [PATCH AUTOSEL for 4.15 119/189] mm/mempolicy: fix the check of
 nodemask from user
Thread-Index: AQHTz5hEdrIUHJlEB0SZGQQcdUQvhQ==
Date: Mon, 9 Apr 2018 00:18:20 +0000
Message-ID: <20180409001637.162453-119-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:IvHhpNzTn2H3UnMBhXL6G4uPQgDTBZJsbVnFLSS9VJDja79q60yERg5E9MJlKtkpKYnesJjCdo9ttalIf4KtVA9F1QCaOD5Idq9sB6Z406HVYk6TimPjx7xQeGXYkpJ2KoK+t69rqKHlVrLWmq3HtUFl8IM9imHivl9hjnt76XJQ76e+UOK0iSGc1gJJa9NaTHfv72NRVRzB7NpIQSqwv13DVFoNKfjURi2N2hW1A0dTH+tMUNR0DX8Q7GJ5ndyO;20:R55hgEJDQOoL5fqtXpzPIzl+4onIl7Rht4bCQpK33q/3zpgLO2vUi9x0Sx5O4y+4rJC8fOTvGobHaOxMam8FnOYazzE1ixoB5+7fs9TfH5xUlNsUH6Q+25XS9CwRVybyB6s5LbXAWysx1YMuz2mnYlFSH+KxWDA/6F0CEIuO0fQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b266a3b7-b6d7-465a-80fa-08d59daf8fa1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726D79655D596176CB2ABA1FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(53376002)(107886003)(2906002)(966005)(86362001)(76176011)(7416002)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tsklyvTCk5FXBCS+sH9pyYtwzpkR8no/reoFlMcNd/5KBAW3qj7OwA6NnLGPtQFGTITuYdv4u/8HF8LSWKATCf9jRuI+f4qPW07YJcYv0r2LAV+DPTx1jFRNvGlapMFoYxIs78zMT5ozZ4UfTnQoOnnr28d+TYLXASz6UNE1uR7CnT319fOyoEggM4oSeDdXLqNHKYmKDg7NUsO6O5//bZ7uilQK8OL2sL9gnkULVRUypUlB065sPQUzcSTVEQZ8LBKdFOb9GjPXnbHpJ+pY1NQeEEt1axtV2loirsAkbvP+DeT1Ll6fe5I0joLIsXPDZmxeuIPRS8r7ixMZhKJ8luQ+/SSixIO8SUAo7g3zfNz0jzx2uIVB0xL6/BX8WwD2NTzFK9Qh1UVNL8L3cl5wTtDcKlgux3k4t1O7sk4wy7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b266a3b7-b6d7-465a-80fa-08d59daf8fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:20.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index 4ce44d3ff03d..c9b807eca74c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1263,6 +1263,7 @@ static int get_nodes(nodemask_t *nodes, const unsigne=
d long __user *nmask,
 		     unsigned long maxnode)
 {
 	unsigned long k;
+	unsigned long t;
 	unsigned long nlongs;
 	unsigned long endmask;
=20
@@ -1279,13 +1280,19 @@ static int get_nodes(nodemask_t *nodes, const unsig=
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
@@ -1298,6 +1305,16 @@ static int get_nodes(nodemask_t *nodes, const unsign=
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
