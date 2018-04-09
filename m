Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243132-2-4024616544340609551
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
    1523243131; b=hLx/tKhzFe17wNRKV07DF2qP63k9xwYkJS7briFPk8hb6OcEqw
    88El624ElX4p5YqvzjbWPa+NXIMn7xbsE74P9B1kSPKKjqogaSg0FzGhxMFOvT9o
    QZHFX23rtz7IMc2vd8wrl+/tX9ontK4007jWMxqZhp6w7iwV7MxAmIy/GRMWGAsD
    9PkD/r6NRTVPuT7zjmnxAxaMkjoyFVxSMVkxyfxvXJLFtK8BWpGYbdDZZadycdUy
    DhozgBMn035yzoJoRElZXnpA32Fn0pbmZjrbkPGjq1q2Z9cOcRDrzwtj3NxaAJ1X
    A9MGfCxNwMZeViN8L1n7vD2ydD7htuR4mq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243131; bh=d4QqrP+n7T
    vCGUCSSYaMb7z8nqbX0v2xrUuNvWKG86s=; b=Jk//m5gHcgCpfswDQ6E4+m8rUl
    mxXeJJiKK1Th5HNHWS2XWnliFfqZ3Mw+2qI2WFL72byebLpjsMrd7NmGwQEEAPoE
    ibE/2sHRGYCBslnKvt+KZvVOFhkUiI31JD53QUNLj4B/j1ZIzCTtLwCNMW8Dyu8f
    NL/M6vXDJNu0o1e5SkjV3vJRs/3ARa1qJT3xiltrydlljVsp+feXriKRPVr4/is+
    gPe7Xnz0i8oWT44WZPPyG79VxwZ64ws89VOEJ9y9nucBKvt/+c99FPdfoX8UXAVO
    qUeI+0vou3+MiY2GXla6yLWzIUQwYW4dRR1fpyg5fL3VBFuKOJWceb2iF5EA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a0ChMfzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a0ChMfzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJulTJw/2/05JOM9XvU7mQlOWNvWaZQqN75a8jcmPWqhSKuRv+xvfm98POsl1S5lkJWwKZJNueSaUDRiJYmL3UjNXfaj1PPmSgJsJ/GIO/GfyzJKyjsa
    lf6WnjDkKNLwIVsfNgVdxU9dzK4+aXQvKHSXk0dfUU1TmCrLS2m9xlsCmQXGj4UjVEyhhw+hgP6VteHBg5feXWCWvfCSD4tbOuzt0oE5GbwjaFupj6F3YSyV
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
        id S1751458AbeDIDF2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:05:28 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932102AbeDIAYn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:43 -0400
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
Subject: [PATCH AUTOSEL for 4.14 100/161] mm/mempolicy: add nodes_empty check
 in SYSC_migrate_pages
Thread-Topic: [PATCH AUTOSEL for 4.14 100/161] mm/mempolicy: add nodes_empty
 check in SYSC_migrate_pages
Thread-Index: AQHTz5iq+RvDn6adlky2u7hm4xIJsw==
Date: Mon, 9 Apr 2018 00:21:12 +0000
Message-ID: <20180409001936.162706-100-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:qBV7lmnzQHcLABxmhYi5AAJQn2eZNNrqmZ/nd/pmZea6EOjeSoa93ysQ/3gOZj51HC6xWRai4fRUIAEoZJm4urDVw7CTMsunwW5iP530nvtCbRObhhfpSrRfFgzhrV9xibufFp6zBf4qqRXGsRGMUJdBCw+BXpvHFugOOign5cqlJ1Fr0EKqqYCs7h7rdGFfeUoccZRpnBmsOINH+6fp7crkG2FJXM3X10pp8h2UGnDWJLFFx4Wt6D8MK7DO2tMx;20:60MhMi8DLWBKhkcFu84pnomMQFzPyhu5W/dWZP0Ipe5UtGPdoadTUrbHm6rfteq6f0kTIrg4ztrXj74e+NYKyoSk50VlROz3c+D5m6rmxl9vBHDozMMKbpzGo8M46MD7iO7xbRiXP9wSUZa509iQMB8mbJRaC4Tyxe1NIKpuGE8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0d60eb2-d6e9-4acc-ffc0-08d59db04940
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983A60259B437716A5E6416FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(7416002)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ePcn+jt/z5BO83ifP+MKGbll1nADtcN68IbtAj+sJmdRGq1X79HJV0R22duPKDJKhUkMgiR1bp/MLljtQYo9tBz9lQ2bZ7SRJpBTHhniu/1kxQ5Q+AxMCxutMxOPwbrkuPRmQp856v6+FUGHAXd6tzS5FzZ4v073JYUg4UPlIArKzGGp/e0vsjL4IH+QCgdeIrZrZnBSX2I2c2fFMgGVOtZt6U5AKk6PdjJOGIv7s7Id5iWQgdWjonCt62q1MnKT+3bnYo4lvzc7eQx/mH2y4kVLtsKG5dfY6zeDhKOxRI3PErai2vKJ4XmfxrjpJOR+XfM7KEkP1SmCJQ02AgopXP8p7M2+IDpyehKxsbi9zheiN+8OqJfdTgU/3eKuOoFuB8Wg9Y3LuB4sNvQkmIa/7B4QIRVNpve6AUTEZUPvODs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d60eb2-d6e9-4acc-ffc0-08d59db04940
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:12.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index 80b67805b51d..2d3077ce50cd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1440,10 +1440,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned=
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
