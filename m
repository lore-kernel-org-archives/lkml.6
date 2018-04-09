Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238515-2-7942852797956884411
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
    1523238514; b=AuwJiNyHwklgS5nqzPyctjs9ibBq6Z3H9ENkj1vZy76NKTNXd+
    ewvEXUxAbZ5/46PtzdeMWhnAb0fZlLqLOROmrR/8JqdWxMpNnep5mhFQSS2dIwjd
    ShC8ZF4CoPqYIbYYgRKcfijSbaq4mLqAc2Q6B/nA6HImK/1SzYLUGGuQpySZrley
    NTFKVgrOI6V9ITjSaVi1oyotfXh7J8IUY7GuudOhk/WNu+ox3Glbb7rQX8GFSSp9
    i8g/O2JC991Z019wsrTV0oDqa8NecnXkQS7JCl7IgwIbu9nr4sExjz8Qa0Owfa2y
    3AJdEN2cu3UEg/hdIx34nsiJLp8tzpfJRmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238514; bh=O2jhmZ/T+d
    cklhekAf6rrZRhpWv/UgMBtktyj11qbt0=; b=VQEKBlVCD4xa1eBHjPyYO44cOD
    zGUE6kJZhXk1WFCuVQST0kysSjAx2ZaJGpB4gJe4HBvU6kAN5rdcjyHch9I0RHhy
    v+pDfJQfgf/h45nIqe2qfU1PCNW5mKHxu47JsnZ77dOLYIO1aus9T6a0eA5lF5+k
    yq9f4kvBfQAf97L4GCMElojCn8YfIt/4tboRAtuCSJd6BBkEh8LC79lDsPyt6mLf
    OsY5sXifYYYYWTcv0/MP/17tLgccqui/x0wnmRveTCO/BXIlmqxXJeCUfVNw2+0W
    EL02kjBtNW8Mpm+Qjnf1crTGF++TEd6c1UUOLl4Q4W/Jf1A3molM4Rzbc6JQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NO6rHS+l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NO6rHS+l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfITV6+FzeJsTnDwYNJCZGnnw2sWWSlgoBufL5JES7RYcSet76fh5mbPbI4x9qbSVMgfkUxjy7mTigmKI7UyPctk66D1AJIZej530Jp51iJZ+cIfN0OBZ
    syCm5rV2UhOPm6iYa0HO6qcMFH5ouzbYMYHEdnejY7WpcbMsCmUCdBceKTSNFaN7lfTR2BrCF2HXDFFN58WC9JmM6lYuXp1Y8xhFyigaX4l6l1nrAm45C/ge
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=NufY4J3AAAAA:8 a=1XWaLZrsAAAA:8 a=nrACCIEEAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=yuw3B8Qeb1bco88wqkMA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=LP-oT3CeHzb3Kpa8nOvR:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeDIAd7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:59 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932332AbeDIAd5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:57 -0400
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
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 258/293] mm/mempolicy: add nodes_empty check
 in SYSC_migrate_pages
Thread-Topic: [PATCH AUTOSEL for 4.9 258/293] mm/mempolicy: add nodes_empty
 check in SYSC_migrate_pages
Thread-Index: AQHTz5leRHhz6tT4yEObPBlBpkGTAA==
Date: Mon, 9 Apr 2018 00:26:15 +0000
Message-ID: <20180409002239.163177-258-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:P3T8u9rg7FjoqFDAPD+8VJS/ExO6rJ32CasGE3HzkO118+oLd4BUoSJ2zgMOqRofQ1owlNq6KobUM1ZEPC0illrAe9f4lGR+DKI0oNyunS9OGqFdwWg/vqqqGTKI8FD8JsMmsIGMB7cO3nHskt+plbphAz+kjUfZUggJ/y4ZiKqTS8VyN/RHpUUwhKhRl+pUh7yA35z/fjdYM520gkHdnFHXvwmQHW3SdhCGc4Pp0cl92nR/vqhJDgPhvjwZwxFi;20:6mtaS5P6OpSK2OEqyE9zNDurBOEbMqOBUb/tKbrTjZW0+xruAV3sIOoUOHJzQyXz3nYJGrRkyw+rS/WdA/gA/fi22lM917CTEzcVjgZqRJuhoeW2f41W9cVJaCD4M6hN6FgFEsQjJNbaOHpj8AKViDeWRyqqCpX86Pgz8d/YH7A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56961a7d-dcc9-41da-9957-08d59db19236
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806DA2EE555768B0D5DF332FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(7416002)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0QLGEtru15c/KjU1aUc6gXNevTSyzj73u1pQgMpv4oX5MkvXAHmHvsYouIDWs35xiU3iERNpT+1AREyFQhGEPm0eLgoka/e0DDLYIlhKCjyuvspHf7UZLbFJ/Enc9w2fr9P9Jnh3moDVG/GZfWz0+uAT0mfhwoyLivB2cIT+IJays4KK3A6+l1h8uhPZVg0XHvtbggI82f93TmLw8GkP7Qg95hU2afvD0j5uBgOz1YuosIV+bLcr7AkhhKJrbK91xINdDdfSqPTKDlyERSg8dFm53ZACFqOb/nte2bB/hRvGeJ9fwJ5iHxqBMdzk8AopxxTYhzVH2fGiM0a1YgO/ULdyz44hsOnStMVMvWowsKcK4k+e1VSTc9bShu++1cX0se1l63Pb4ucGhUiBinJvc9b1VQU4S2H3h4ME8ySPoSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56961a7d-dcc9-41da-9957-08d59db19236
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:15.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yisheng Xie <xieyisheng1@huawei.com>

[ Upstream commit 0486a38bcc4749808edbc848f1bcf232042770fc ]

As in manpage of migrate_pages, the errno should be set to EINVAL when
none of the node IDs specified by new_nodes are on-line and allowed by
the process's current cpuset context, or none of the specified nodes
contain memory.  However, when test by following case:

	new_nodes =3D 0;
	old_nodes =3D 0xf;
	ret =3D migrate_pages(pid, old_nodes, new_nodes, MAX);

The ret will be 0 and no errno is set.  As the new_nodes is empty, we
should expect EINVAL as documented.

To fix the case like above, this patch check whether target nodes AND
current task_nodes is empty, and then check whether AND
node_states[N_MEMORY] is empty.

Link: http://lkml.kernel.org/r/1510882624-44342-4-git-send-email-xieyisheng=
1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chris Salls <salls@cs.ucsb.edu>
Cc: Christopher Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/mempolicy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 92f92f477304..c779a12f1ff8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1442,10 +1442,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned=
 long, maxnode,
 		goto out_put;
 	}
=20
-	if (!nodes_subset(*new, node_states[N_MEMORY])) {
-		err =3D -EINVAL;
+	task_nodes =3D cpuset_mems_allowed(current);
+	nodes_and(*new, *new, task_nodes);
+	if (nodes_empty(*new))
+		goto out_put;
+
+	nodes_and(*new, *new, node_states[N_MEMORY]);
+	if (nodes_empty(*new))
 		goto out_put;
-	}
=20
 	err =3D security_task_movememory(task);
 	if (err)
--=20
2.15.1
