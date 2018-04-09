Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234801-2-6850897511303326884
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
    1523234800; b=lOMvMBGH/QDnZjW202RYl6d/2f5gobmvEI5yEhSfUeGDJGWQ12
    PV0/PzAtBuLuLOL0WXffq/AJEJ8Cawh+40KZe3u5EcNc4WRZjPtNB5OGakXjisVM
    MJDxsLEvI0j1xWTNYnoqazbvfPcYOdWpprrgRis3gYKt2oOPv20vYP75H+jDvpX2
    q82iAiNTb/SfJ2t0FRYdbXx0vtUmonauZLwiKu5rVMALh+0S/OHbtbbKKX8IXJNh
    2fLrJsnwEkTCzk6HBhkIKHXQiNRIilcbJamBfBzhMRP53gBDxipFmBeql1gO+i8w
    pqZfJFAqobaEDY5IvG/Do09yiampTIVRp1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234800; bh=dGpWlPzB4C
    Q8cvXhXFPV8LSwsVECVI9/pMDw6/tVhUE=; b=urPku7yFFVs0AJoUsO68kE9QBb
    9QTDDdna0pQ+EOcV3Igv2OK7FiHEAUU1qvLLnLhuEvELpe74LPY0GyrDuUiLLwFu
    lDMv/3hfy5iOot5ZLh+xpfCyjADj06rOJIfQstyVijVra00GyGyX/mIhS6Gdt3qa
    T9Dm3wsBoJ721W3Ssy2pyrS+JgEeG9xnICjvFEoWIhBpnDTpReMhfD/T05z0TXmn
    TFqmqX5vsPtGdVvdewmG9kOp4rP3YYR7lzG00nI7/oFVBvVA2GENL+BEFe8zV+n3
    caB5ep+WahaqYAGZbwxlRc/xTdI8P1X0FuKz1MacaLe2xgiWyuMf29iRvpGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTmmMSDL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cTmmMSDL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ8WWPN1Dz0jabg+Ften02twCbQnaBTbAR2fvBiWWUo/AOJEG4uXjA9G2b3X5eSQ2lXoPwR/gJFohX5BX2DukVTBeYbkStHjpaTxdEMRSGwnbMQ6fISd
    huWtr4DLxRSO9VmUSX6fCu5vQjmLjuy66jmYdF77Lv3n9axMGrtaPNDBo3mNSNDX5sCQPhXEzO1Hz3hzSLnPN/iGU+p+m8UR2hOlMXw9M+W1QWrbiyIqRUto
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1756973AbeDIAq2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:46:28 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:10560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756745AbeDIAmT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:19 -0400
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
Subject: [PATCH AUTOSEL for 3.18 085/101] mm/mempolicy: add nodes_empty check
 in SYSC_migrate_pages
Thread-Topic: [PATCH AUTOSEL for 3.18 085/101] mm/mempolicy: add nodes_empty
 check in SYSC_migrate_pages
Thread-Index: AQHTz5uILOkTTj/fN0SVU8hukKCbtg==
Date: Mon, 9 Apr 2018 00:41:43 +0000
Message-ID: <20180409004042.164920-35-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:WnqnhdmXYL0cIUIZ411LtkTlzWj5X8KBYG9BJ/Plbeiw4F5+ncCsZCEDZTy9h0mZDzrWFRsRtcvBBPukJP617wSn6Db/BF2XEsQFCI9+/G8XlRHPD8D4CFplTwV5WdmloGPFuWOp8jMZ/1jQtiWAgaPur2tkbYft/U+6gODySej8JVyRfu8I8Br0V3Q6uuNJNr1F1wIYzX1vW5uPIlufbpR9Bs1vOaWxj5BB2fQSj1A43KxtERnJBWrfSVFl7dsi;20:UL9cZD3+kF9AU45csvB49ZRWJbECkdoIWa6z3MvjnVWCNTNrWvMgRrC8Qw4RNSQeZF7Dc3BAWn9v9SkCGjbi2AcDnJNSMGFHT3pF8zQH22DE2z37sJNIutcTbyaL3T2QR0pnMk6YEtJ19iMYGkVOl2cyHRuTzZMQWrV8KUef9EE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a29b2723-ebc8-4e10-aa5c-08d59db2bd26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106207B95EC176E518650734FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(7416002)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mkQsYyx7CE66VMQeA49pXlZvVl3bIuItk9ALmRiCBEer1xbVmMvXR38WP+mCFiCUDGTtmetOkZknnsI1PWJBn19aekOCbBFpPPnOgzBfqc9ebgVcgxj6mQtxkJkOY/k2uPmoImK0svdD1dvZNxhGn3rWRtuktyVhcLgSz0vUWLdfpRo0LE1wKtH3Pzc3UaO37BPTfImXEKkkZ2Y0Frqq1oUNLSgtdBZLqHvUpKtoKKo8sLZyU7CjOMcf9gpIZkWgx19ZCarTqvJ369StPY9lPWREjpvXfhTApbmCmF1f08dse3kKcpb8QIFuxOJ/4/5f8jrs6sYeBsldjfMvIXWstBB0py1sa2EBfgm47M9LeVqAjnEaYTZL4Rzu9aSFAWPlHo2WbGCPKOJC59LgB8dJ9P6YTO1uAysJgEU9bjsCk38=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29b2723-ebc8-4e10-aa5c-08d59db2bd26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:43.3928
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
index 3cd93e8c9c43..e628b2e71be3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1464,10 +1464,14 @@ SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned=
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
