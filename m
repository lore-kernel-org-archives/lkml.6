Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243006-2-14296586869255755815
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
    1523243006; b=a4RoLPSR/vA53M30SuQs2OWnT+bSWMpVPFRdtr+xy+vK9a1+dc
    A3r40Bc3w3QeFyOVXcCjuxABxPGmbuHBjVwpNML8qCFBqM7I8NR1AB8ZVGl4W9JZ
    dJU4r4Xw6sqoyKi26WOdwQ0Qy6iSIvS8JiYRqjcsn6iaahTdSs6igmwwiUF6nQEF
    hezPU6v8nc7bK3nPKkhTA++t9KnXWK7kQO0G40qMku0h5Xh29VfrLw72N2o5KZHQ
    O3iAve4KpRjlOFv7lpRflC129xftD6himpW23UAFQlF3LVhTCsw6B7tcBcjAL6ms
    noDaNhiA3SpU77hOjsfVY7iKE8AeV3xktdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243006; bh=kGE917cMCO
    5VRNrgeKAYUWWWKodQ8UVoLLYwsyFhJLo=; b=BFRFaL2mwdhvJdfzK8Q/sixZuZ
    fJlhpk7nwbpjkK19xl5LePERtSMy8uMjiAA3K1owaL7GYHRVqPep92v5nugGybtp
    Jclez4ODjDLLK+DJIv4pZ4HcC+URDHjddJZwt5P8MgNWwbbMlc275F/Z3uBrHI2p
    ljOvQNi4XijYrGyA5JdkVnkr2qwqOUJW7nBCDhJztnjaUvPKvP93r2gViEOFDOIG
    QXAiaj6Zqr1m+/RlRH5sBUn2B5lr+A3d0pUHrmbG/SXZt0UCFWnmlOFPq+a7jE0s
    ZCUMU/dbBn6XI0bujvPPGR2hdi2GQf2BiyIym9M/9XdDe60H8uZyORcYqQaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCSAP2Zx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCSAP2Zx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPXK9T+Ftma25yVjX43+yoRa0647HpiXDc11McX0RqDroeTabS5L/ao6vv3X0RoFjNvGpzCbk7+bnQiGw8m9te7VX81sit+2B1Luvpjy4m406ppSg6G3
    4ltMpSFD0lOd5ovLHaQuclsS7u1YsIotry9xdoA+3h6XJdkg23sneIl8y/7vWyw8H/dajPZfdCgT/1wneZdGkgC+NCIgxobPzUTBO7kRKfh4R4jaZEP834Yu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8
    a=J1Y8HTJGAAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8 a=eSjN4-7_EL5uPVLO8hIA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDIDCt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:02:49 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:39392
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754319AbeDIAZX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 114/161] netfilter: x_tables: make allocation
 less aggressive
Thread-Topic: [PATCH AUTOSEL for 4.14 114/161] netfilter: x_tables: make
 allocation less aggressive
Thread-Index: AQHTz5iygJuu0aDbmkS9msG/Ufx9xA==
Date: Mon, 9 Apr 2018 00:21:26 +0000
Message-ID: <20180409001936.162706-114-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Wt7pwG5K0fpFJPLmDI2AJUlwP5ycllIxKQ5zxS9WxH2vdadeLZU8IW23E188lXv6VdV/tQxmHTKs92O1G0OmlF9R4dI3QtQXpgqCZf4S1MIFqjV8Z+q99azlIuWRxm3pF1Y6kMIZP3YT7ajxSBiMPQ+liVsCTGjRKo0j3c4O0M9EZa8gpLCajbZAFFJSkQN49RR1RBqLf2PjdThoiV9QcXz1bq6709hMQOJYdwz9NzhjZUS2b0/WksUcYdhDLTJy;20:ciPUZXDkvVx6cekjslpTL/5LCiboJt+bFyawS7OtY01CkycFwAC2rTpG7gAtBMmu1jjvIvFQYli72ge9RExzM0A2uY+0g5gLKMMWFKmEP+FQzOcktJNOJAGBUz2uDfOzPSCS6ojIs+Zi3armFR7HWpQtdMBfYrOKg4pkJUMVDmM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e00a39e0-6645-48bc-9ac2-08d59db0612b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09835C439646B6D176063D8BFBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +Z8MXBMcRmRMGA36NXwIefognt1++ZD7xVxYsYcmUJvSGhtwCqLNKUhhGGKS2yLSYjNxZWRP4k5pZ4EIxDZNSfpozMMWQhNhTQ3V3O7aHkSG/+DLDTTkDHVXsyRE/Hbx1/jFodcP1qxq+Fa0p4D79z8XLg6m1yhwZIjJujSMMTVtWJ5GQG4xpxPIcRJbS0bUDV6lVC2IBEOJvbT/jAGgwGCTU7qTNH/B8ziyBCKdKny6xYZTXFwUAck/T6VSwre+B7g1r/3FN8DVZo4kFTKyNk0ReUtIKMPhvLbnuITSYPioEzz8zgCXtWeik1q2mPyhyTiVnWNJEM62HbDS13UDupGyzA1QV0W+kW8rD7QpMWT3Pp/tcliOnjfoQsQBjtGVPBhIYl9Cn0kzLBsoP8iTnM9beHAHPuvSgh8LQilTiNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a39e0-6645-48bc-9ac2-08d59db0612b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:26.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Hocko <mhocko@kernel.org>

[ Upstream commit 0537250fdc6c876ed4cbbe874c739aebef493ee2 ]

syzbot has noticed that xt_alloc_table_info can allocate a lot of memory.
This is an admin only interface but an admin in a namespace is sufficient
as well.  eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc() in
xt_alloc_table_info()") has changed the opencoded kmalloc->vmalloc
fallback into kvmalloc.  It has dropped __GFP_NORETRY on the way because
vmalloc has simply never fully supported __GFP_NORETRY semantic.  This is
still the case because e.g.  page tables backing the vmalloc area are
hardcoded GFP_KERNEL.

Revert back to __GFP_NORETRY as a poors man defence against excessively
large allocation request here.  We will not rule out the OOM killer
completely but __GFP_NORETRY should at least stop the large request in
most cases.

[akpm@linux-foundation.org: coding-style fixes]
Fixes: eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc() in xt_alloc_=
tableLink: http://lkml.kernel.org/r/20180130140104.GE21609@dhcp22.suse.cz
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/x_tables.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 60c92158a2cd..8a4947ff2ebf 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1008,7 +1008,12 @@ struct xt_table_info *xt_alloc_table_info(unsigned i=
nt size)
 	if ((size >> PAGE_SHIFT) + 2 > totalram_pages)
 		return NULL;
=20
-	info =3D kvmalloc(sz, GFP_KERNEL);
+	/* __GFP_NORETRY is not fully supported by kvmalloc but it should
+	 * work reasonably well if sz is too large and bail out rather
+	 * than shoot all processes down before realizing there is nothing
+	 * more to reclaim.
+	 */
+	info =3D kvmalloc(sz, GFP_KERNEL | __GFP_NORETRY);
 	if (!info)
 		return NULL;
=20
--=20
2.15.1
