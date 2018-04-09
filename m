Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233206-2-998175909278347703
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
    1523233205; b=F7UwCK88TSe96uaoakCQ69P5zt0tAkW8iaHhYnHvMzal1tKO+l
    WVAMrP0PgSQgjDPK7mS40yA1XQadup8gJe3GaJPDsYQcg0qRNUZV8nxlmOQGWO95
    cz74OQkzkxYYudXBYVMvtJFSTW1quNblcsy1MBpqeAkF6FxnuV4dRlsSTH7Ebc8t
    ysFEajfNjfCpKYkhgH0fbP1Fh2XIdIAX8pYtMpq0Ya/Y961oFCmLQRUyV0gLJOMo
    +hX0SA6G9nID973sHYAQxtelBhaXqmBPJPXGXXo/8IyaoKgQgNouUA2HSdNQ2GzK
    fpj1tON4IaPfghB1+VHDlmRoFS9yX8ScoD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233205; bh=FghhgUvVek
    exXSO2GfpRkgAPcqmjpiVGg3m0jwST2yk=; b=WD1a1vuR8CELAOtNq3vx8ZwFJW
    74LJcVChRBODBskBkcRQcu9CJ/lvEACfZUJexui05hGM9A+dKmgYxc+cMjd2aufK
    Q7e5osHHFzIHgyU/BKKmPt9Vkkx1Ony/x1fFWeHIk0Yq36SQmMluKB1HzAGZIo2L
    iWs8W1msRXmBy6pe65wydp1Fv6VC1mh1QDntj/jhjkBjCM4nwlA+Afmi4WQ/aMQP
    lz3mZE0PBg9JPl6OmcvINe60pyGvWgrMRLzbSYRRJgfI9uN1duGUX9ZA1u/XK+j5
    TuhSLkAjTiyWAoWgX7QVFDz2wpDFh4gj6l0m0S6mOkuU69RaqboTZyOipLkA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWwTrtb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWwTrtb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMPpn25XNljzipwSh98yqNlZLlvzUmFrMeUeaN4/F8+TWVYJMeiHZxwCUr9puSBPRDV3NPmYyYh27K57z9H0/EQlxNZ0AlE1FBgIi9n74jCJckbgsjOY
    uOe3s91pIXp6XdtV29SLjlMR1Fx5DVYcIPw7m5qMPFDTxzGRwcjiVVO3oEauM++StDWw4pH3fLLj5zL2yKiCV5k6XZzhb0/0sIcTRwRPQZn3KPe0u08PJwfH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1754103AbeDIATu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:50 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754087AbeDIATg (ORCPT <rfc822;stable@vger.kernel.org>);
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
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 120/189] mm/mempolicy: add nodes_empty check
 in SYSC_migrate_pages
Thread-Topic: [PATCH AUTOSEL for 4.15 120/189] mm/mempolicy: add nodes_empty
 check in SYSC_migrate_pages
Thread-Index: AQHTz5hEPrB6lLYRukm84/AcHaLVcA==
Date: Mon, 9 Apr 2018 00:18:21 +0000
Message-ID: <20180409001637.162453-120-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:Iu3rpKHF0JIUxtOoI2EdH+TyZhWHNs1uhWQwneMKiUsWJxdn5pi7h48+1a8Bw3zjjNZ6hZsqyB8NMCbL6y9ly5ORf1lX8tGUsvcGRl8sHrkkQzWAmsmY5/bpPMTiJiDmhS8TBwXNfAs2mkMaKAAVONYYHeCn07JyvtMAGX1dtmy0bK43u0rjp2Tu/4uojh3jx6RnIFJn5w9uMkj0SitOIsZufOgZ29J4eb0lrOUnYsKMqDRPsLyeZqqGTWZafrKq;20:SsgfdCfRPgiclsaEdNglF/qisZ/NhCEEqh6W5tGEmj4bPlmfWE5lTQCKM6sbaZZS0zHGc3SP8XwKv66tiF1Jb4zmcZDbUAa+AR+m2fVkzCrJt7VN3uQp6EJBpGe7yxnOur7lCzcPPp1iVmHA9p0vSFZU5Juiwchu31l8xydy2jM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22d1f294-2c4f-4a2d-de52-08d59daf9000
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C9B671D82296A19CC7F4FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(7416002)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vIsHqdCRek35WEkPM8LbPGrKcIehTRoCr2xYMwF3sLQ82EkyaTUhP5FvD0rjWuTvB6W/qHe47Q2oljf77JjqwnDISt04sTWpoZUOnRZNBmb5WmR9MsGCf9YBhDCkpVQzHOP+2d3jfLEl86JbWPpD1GWbLpMCZi8yq8DuXIS8CoGJJVx/36raH/s/BG89n9qubZLk5n/Cyk00ggrkmah5n+RNtar/mYpzZvLmtJLzr76tB6TYd2ZO2ibQNMmbKwCFdbRs9VPFILy3z9dUjikf6zODSUVtjia6/Q8NaV1QqtN3TFmUCWILGcrJhquTkdlb6po20CbVr/R+b9WG8YHpQf4iKqfTYaiY/iFEQOWoAsDnsaQUmxVJxBhMdhmzsZ6poaf82Y3hmehZOlLHL3vMWRIAd+WR6LGSD+gh+YKIu0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d1f294-2c4f-4a2d-de52-08d59daf9000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:21.8648
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
index c9b807eca74c..277b6454954e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1435,10 +1435,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned=
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
