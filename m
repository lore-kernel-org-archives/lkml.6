Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489416-2-9319668509688917867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489415; b=nidCbLkvh85JgAIus5vF+NWD4FFpWmMNfUlMDQE1WgTCFeH
    eXo+MUDBRvtmGasT+hM9ZuPScSWqWY5T/UZJ76u1Q8adbl2A+QxtAqB2PIPwNGZ/
    JZjDrwXp42C1z5bXS6lSjMkd4F5bOTRVBGiynjkzarSgOELnj26w24pfg2RidzIT
    10UNsM4cgv5CoFpk0W++Dvg4YMptLL9vKkPcRDd7/QywH0NEXG9qjsNC2CG+dinT
    Qvl9RnFcR5S3hT6AMQJ0cKPXHESQrRuDN+m+SKfuMxgoraUSuGopIqe1pYMal27z
    pu5WU1eREf5oqu9B4b9KwsPMkqZhm1/ZGhL0yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489415; bh=z17yBj
    LCxCNTSHFlhvh/7/Lx3VbX21TUgk9igdlsook=; b=UakPNez4uWyKKaY4yzDxan
    9ceSmZoSon71Z4uvre9ATCQLlZt6TEoC2BBBmVh5Q9ofGTnSQbaL14qNbrQGhSAT
    33a5F00eTLjW8wtLe9KW4kN3AnrVgcxEKt7ezp3CDRPhj00SsBRF0NQmNx+D3UXF
    Tm9paLSFYoTby09fAFZ8kujvB+/WEXnZ5wc1lQyI4SKs8pFEAkli52TNQZZDd3Am
    I7VsdXTDd2zzIq19RZKXYD79X0TOWETf3bWCOZPBm69k6yE2oUyEHuSqdRiCz6eg
    dposxd81mDmA465b0ZfI+BIbcOlILjfnMZOsUGhFySNOvl8KsK4e/8qYjqPZDDRQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bwqf2NzJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bwqf2NzJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965772AbeCHGKA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:10:00 -0500
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:43648
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751120AbeCHFBm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 087/190] xprtrdma: Cancel refresh worker
 during buffer shutdown
Thread-Topic: [PATCH AUTOSEL for 4.9 087/190] xprtrdma: Cancel refresh worker
 during buffer shutdown
Thread-Index: AQHTtpo97kh07DSdXEaJWWsouCUf8Q==
Date: Thu, 8 Mar 2018 04:59:29 +0000
Message-ID: <20180308045810.8041-87-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:G4G+yCHeLXQZTQeYW6VYvrtIv3RhF+g/V3alDaBhD9BKfV33hhq8eWG6mliPDNLIWpb/OEKuHOlU3zqLMFmj/snjRbxS1qjpurb9Kc4GK0rDScCny8Mh+zUllEp/cl+N/IX2cNJBYAjw1j81DRo6BxC3pKqLIwdc0wY+MyBQEyQ2Lq5h2gcXYyGXXu6suB2kIX4KUrQ6Hg9GT+R38FNMFqpkAfk48urWPXVjbxiOvVZnu3+D5mduvZArM4Pr7Fjv;20:4V54Kv4skUaSXVEeueoNME9oi8VM3ydL2OY6UuHc7Z0//dwMkmiTiRyiANkBJuHItKVKnuC3mYOm/vqcvmtziKCuv6eB26to6cZRxUhU8OZlO1t18120ap3bTqoiGPvKS2zk+U7BT5x4+YfYgGZ5W1OmWcQqMzNmypTY4/PptnA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 101ada5a-80ac-4547-ddff-08d584b1aa3b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09998D27774FAB05C6E26CB0FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7ZLtgSVedj5u2b7dpXJYNGsmM4u2neX1UqDCjQW/IsrN2sWslhW+FmMwOi7ukHjBDQaXHb19Vz/L0d3ctq0pEiwXKfVBpML2rnODSlrroLE3c+io7sFgLMQE3MP2u3/XXAslOqb4uS7QQKEsSe5vckFQwLL/Fya12w0HDRq8zYVKp6aq00ZSa6ewz9AwIp7dSoDM6RjQs0Z+XZNodrO+zdErX/RM3hiS5sVtbTUbgw/YwsOxKfQvjCPs4U5n+VsWK9rEAkzknOC4t+lzIBgpsrSsKB5zlXFJk0KabbESpSRAtXczI337Lq5Ey7fVNQroYiPVNm6N0rBNgN+YCMgbWQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101ada5a-80ac-4547-ddff-08d584b1aa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:29.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9378b274e1eb6925db315e345f48850d2d5d9789 ]

Trying to create MRs while the transport is being torn down can
cause a crash.

Fixes: e2ac236c0b65 ("xprtrdma: Allocate MRs on demand")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/xprtrdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 69502fa68a3c..1a2b1f61ed26 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1054,6 +1054,7 @@ void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
 	cancel_delayed_work_sync(&buf->rb_recovery_worker);
+	cancel_delayed_work_sync(&buf->rb_refresh_worker);
=20
 	while (!list_empty(&buf->rb_recv_bufs)) {
 		struct rpcrdma_rep *rep;
--=20
2.14.1
