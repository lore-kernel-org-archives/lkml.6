Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489956-2-16412742116398318877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489955; b=Ie5AdP2h5mIMoplvPCwc9L6ExTwogp/LhzekzkPi1QB+9+v
    YQn7RW4sh7GfJZ7rnMUZyeF6k2xO0bYvVowH27FASSdPxcXGBw3KsSbjikoq3f4k
    tIzkBUgchO0KfBL7w9qhvEshTjvIZZtgSIoGBKxOxqsH5VHpUEKLhxMgJs8ATZys
    q24Qo11iCncweG5poae/g61XVpGkFAN8vxBLotUmHcr9Vf3lt0HnabBoDvUSgT5o
    R1yhAZeks0ylWvvAN/ccXiv5zeLUJTEmxCBMhB2HQf6rzcG+XwvdjWJQ2Y7d+pk3
    JrYpMDjZDs3lAcN20iEo0z3V3Vf8tEHecl9YKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489955; bh=oH4LsO
    AmspJVjPzPk6dpRUv51ijzAHFn7LyKdJ+h4NI=; b=vuGcnLDJEzCswAK33xgkm3
    dpovtofD063jYDBP2nUdqCqdmBUsbYKe/J7eYDQYN+MqA8RiWZOENZZBB+g/P173
    dZrWHB6neJ85bpNq0QEIGuDa+uhxs70lgwRwGPJ0ytD5Gm/yVlqq77qtAPR7VWp0
    4V1+HRsRpW/1hkdYXTuFZxGA2BmYUAKBjrry0T6Xc31fuL2c7Z1PrKpnZtrLA3Ck
    J7zVo/G+vWQzZIi9wQ72JC5NOCa3wb+dI0uJHkXZWtysSUHdLZM4HUTXGf5bmR4i
    /3okZcd5MKwhg8I1mjRTfOT5q3+fmD3hiqOT8nbPqnYlMu+opKj0EOUG5b1iCFQQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KN92rrBQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KN92rrBQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965713AbeCHGS5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:18:57 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965609AbeCHFBA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 057/190] NFS: Fix missing pg_cleanup after
 nfs_pageio_cond_complete()
Thread-Topic: [PATCH AUTOSEL for 4.9 057/190] NFS: Fix missing pg_cleanup
 after nfs_pageio_cond_complete()
Thread-Index: AQHTtpo1Uc15lWLtiUG0KddXqEGW0g==
Date: Thu, 8 Mar 2018 04:59:17 +0000
Message-ID: <20180308045810.8041-57-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;20:mPNDLH5KidfoEWtmC2WYJjcrJ4TVq1VvND4Zrh0nt6aM7x/0yOOw+YnRrBqWxC/N7esyd/yGd4k2mWeXsGI0sYI+gHPqQx8maQNS/wCktoLeReQa9VTyPppI9WLr6T59UH9Eb6hmUFMKH4767b3f2/Ue/0ZeB08FwtmM1eQbrOI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70f8d958-2c82-4a89-e9fb-08d584b18e90
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110922DF118157DF63982210FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gJxSbi9iKhC1j9QgVHORr2NZKG1PI1bSmPmyLe5v4gnIsZhsqqtzgHWtCqTo36KQUZNIqDa5w4ZG0/jebXUAltiM0pp8HqayCH5p4MlnEqhsCPuiPotF4hkA/i4Ssbg19TlhbskoVQr3JZ6gOh2Qw5Ydmq4vTFcT/OZCYL0OFKNUJw5SCILsts1iWOtssxbWNAs/qrUrc1+Aue79PJk99JheelbyHnw1317maWAoRj1jMYL1IKQEGxUC8o+rWEzpwjZwkRx+Di3S0SLayInGm9hgMwNW+yRekz+qF13oB0qaZBmbphM2N8K8ypibqVDBJH0RSpzlQ3q6an6mvRlp+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f8d958-2c82-4a89-e9fb-08d584b18e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:17.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 43b7d964ed30dbca5c83c90cb010985b429ec4f9 ]

Commit a7d42ddb3099727f58366fa006f850a219cce6c8 ("nfs: add mirroring
support to pgio layer") moved pg_cleanup out of the path when there was
non-sequental I/O that needed to be flushed.  The result is that for
layouts that have more than one layout segment per file, the pg_lseg is not
cleared, so we can end up hitting the WARN_ON_ONCE(req_start >=3D seg_end) =
in
pnfs_generic_pg_test since the pg_lseg will be pointing to that
previously-flushed layout segment.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/pagelist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 3d17fc82b9fe..892c88542ebd 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1262,8 +1262,10 @@ void nfs_pageio_cond_complete(struct nfs_pageio_desc=
riptor *desc, pgoff_t index)
 		mirror =3D &desc->pg_mirrors[midx];
 		if (!list_empty(&mirror->pg_list)) {
 			prev =3D nfs_list_entry(mirror->pg_list.prev);
-			if (index !=3D prev->wb_index + 1)
-				nfs_pageio_complete_mirror(desc, midx);
+			if (index !=3D prev->wb_index + 1) {
+				nfs_pageio_complete(desc);
+				break;
+			}
 		}
 	}
 }
--=20
2.14.1
