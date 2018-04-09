Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245547-2-6974612025895773277
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
    1523245546; b=WUtfGd142N3f4GDccdG3VxVuBA7Ma/peWR+JmV4hpzhIGNxi9r
    QhopnpuC3ojlxyBW/4C48/1HBWYN6CjBinL1yxc2xlEVkMXaX7u5t+VQxUz9AXe/
    M68FPtcgglZyNdMRoAvJKHrPOIZgR8E9NOr/wcQyE8U5KnsYs03rNnKqkqtbMKZu
    OsgwFJVntB0+/niFMCuD9wSrJhBaAGSKjc0z8Hj1YntHRwzfEmsaW29jILEwzoLS
    IsR2pV68iH0aWf9V87d+p2PQe/3xz4YyFb2tjR2d1HG/DTZh4C9tUuRiNgch48UW
    oiq0GywEAN3EhHeoLTSrTLzMfg6fHkp/AQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245546; bh=8qJChQNOr7
    zfAb5JSIZiK1DKyBWzwtbYCXB2Ys9j9jE=; b=YuQHQwo1ElzOkQwqs4c71O56/Q
    /wenI7mybJTv7P65KImQdTPVVRy03yOhWMr1jimn/0pT51F9/r29bBAj/WeT3IRc
    YAwt421k1LYq0c0trzoF6gbVMfbzprm9KduRY+O8sxXBhzqERQf+nnks1r73GmcZ
    DCZtFGffNAPEv97zSLKYibBAozv0zoiboCQYF5zFdQpJfA8a8Ulh5ubJbVS8UVpF
    fbij1/4lfzAusA5RyYUFy4zL2SKGRiemRrdFJvNnZ3VL9GfcLNBwVuVPM/1mpcki
    dfOZb84X+WkafcLH8c76IY15xA+nzMyNnlaf1/iwKnmjRJKGSyBA030kUEPA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cAqVXUoV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cAqVXUoV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8FnBiSt/VuZiEXCVcgJaJtDrwNl9VEp0Of5Vu6OlUBla7+Q1hx1c0Ri9p2/82PsHz8VWqtkD72Se6/XJ4a9bOjBPjxF/Atq5s5ZLKosjtVOxsei+QZ
    k8IovPakFtLJ2qfjFP2eg3EebVNjomNsy290gdlNAYrT4y7LwolwOECrx3E679+0ajUTCpM1opJ2KOAjBGRnUkWVI//0/31CwiTbmYPFGw5pzftz+cwvcnAx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8
    a=J1Y8HTJGAAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8 a=eSjN4-7_EL5uPVLO8hIA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDIDoa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:44:30 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:10471
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752944AbeDIAUW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 137/189] netfilter: x_tables: make allocation
 less aggressive
Thread-Topic: [PATCH AUTOSEL for 4.15 137/189] netfilter: x_tables: make
 allocation less aggressive
Thread-Index: AQHTz5hO6sFR++IwKEWANN1bk69UMw==
Date: Mon, 9 Apr 2018 00:18:37 +0000
Message-ID: <20180409001637.162453-137-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:tFEgQ3/Re2qZRmX1pQKT+9zdxhzT9F2brpAlOI3EvfBafaFfFPZS0VrQo7R4qh1R5x8wcOkVvc0jKMDDnZ+x0v1IAgniskHKxzGvDiz8H01fR4lcgTCDjEnQ4ZV41C2/c6vX+aHrtOtJnk7f+RDeWPo2HqLcd1A9fFltVvTnTVAKVo012Y3Niekg0uwtBG5hEomOcVnA2zvCGeLC6TAiqditi1RMRRZDXkEJ6eZRdu4oL3kIA9AmjqJGIILnX3Zt;20:h/g5v9Zfd3GJGR3aChNV/lczhnzP/Yvr8U9HYy9bSAZ33Q+ufmUTb+x6dTH3SH84AdmCHlo0Stcd93ZbmUkTw09PODA2NX6z3+K1U+85de4/TPd4ZToeMoadIVWrKBQs3DeivcFU9/9C9Lja3MG+9USsoG9UtZh/xf6U4Y6LP7E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a53906fb-2ff7-4b1d-7c2e-08d59dafab16
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110CA799B171748D87CF312FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y+sZFDBTjHcwxhbwQNbu+58y9i7lNHl/KeZbgxXfU+mMfXKOt6UVt4i7GukGBL9jrIEL+uu14rfd8L1grrK5zdXbMO8V8tlMwHK5GAIO8H2N1B1DUbQQLFQ6z1iwdyysABslz5oBSoRPPUZ32dKh6G4BKjb+Z2qiiySZDEGtYlin7AURahL+1dVmQyk7FRJrIi0zusmwJ+DIc8CmXQKGqO9cbwN+dwUIgm3fqDStttzEiyG2vWDTEHPhPZ7MwufPsAxDphXlFDRcvkOX0DPBG9nNc1hXsWXuo0zkgi8Qr4dl4dLpABKHRcVJQxkOP4InH+8cPercYMVBwi640g5jHsvFGz7q7AqC/aWM9n0bxBJlSwLyLoxbmoqu965G7edXn5nYTW/4dRHlXmkbM4nRhs7S3bE/MaOsCU2HNzVgLWU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53906fb-2ff7-4b1d-7c2e-08d59dafab16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:37.7690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index d7070d18db20..d4442aa8fd54 100644
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
