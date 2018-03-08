Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487520-2-417360043013780729
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
    t=1520487519; b=By8+t8fRxFUX2OV8QtcnI2z0etZ1hUme1C/0JDrCOqnPYwN
    +TOhKOz8b0N/iFT8+k9DcHDtVLryzDB0oUgGDlpE7d9gO1H5nEYGG02nDF1tUwbC
    7220s0uwtZYiEMA+pGMqOz6U4+0Me8P91sZzFSj2YUl7S1m7y10Xf/c65guDpdQz
    3M3NCGq+1JWD3uAU534VM2wTUEB6ADQ/9HnKtf1gm4HbT89PiqCECku+cDbBFX6m
    sbqhwF1ywX481qY3GNINupa/iNGCSbojYn2X96GHD+JwSUb5IPAAh6gfpbNe6zK6
    idwrLWNOVPpYNjL6oMlogwlhk+vOTBUor9bZz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487519; bh=d+O9dp
    T3D3HxOM9VJqyjz5okWl1XuQnCid7qLoyeYSA=; b=XdTqM667HmNJBoOQ0gZ1PQ
    UppSvdkUxR/kv89WKek89f73fO5/TU1c8o4AtHjkAGIKA3drVONTsdRXCPQqxZDY
    /wUGRZL3bmhPIJx+qcZsFLZiqt742qg0l5A6P9szl101uliEDGImv6CumaZ8HkaL
    /19K9VsJyB8Hze7JXLxqK3giJtnOsIGOs918QRPV65BoD69QCyuUlovKOVoz1TdT
    lV63ulNl6wSwFyoXxv1LeMIvl1LRZGB3SlA3xM5ZbP7Dm15lavfYaA30hYd/qzq3
    rNX21A7hvO3K/jfR+5UFp9zXFK+JmacwEpmi29KS5+Z18dTfxqz9mzU/qQ2WVPjw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VyBlN2Hx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VyBlN2Hx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966282AbeCHFFx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:53 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965736AbeCHFFu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 032/101] NFS: Fix missing pg_cleanup after
 nfs_pageio_cond_complete()
Thread-Topic: [PATCH AUTOSEL for 4.4 032/101] NFS: Fix missing pg_cleanup
 after nfs_pageio_cond_complete()
Thread-Index: AQHTtpqJ7shjxF0HGE256G5hn4ABpQ==
Date: Thu, 8 Mar 2018 05:01:37 +0000
Message-ID: <20180308050023.8548-32-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;20:BTYRpUpPY+f9C3ACeh6c+iMpW52KfUZqfixWWgcy5bqp2YE2cRbkrOV6o79lrKmX+9YV0yGsKqv3cZnS0HWRmMPqui/mXAOw6oRV+NPKz6ukdV/cc7cdyNPAKpUcKuMPO+BguhozY5scp1SViCtqnZzwU8A6kksLsQxwsj6MQKs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9d21a5e-18cb-41fd-9d36-08d584b241a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046B92907EA527BF683F7EDFBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: dqRTluPdQZvC7yiUmJh5iOk8XzKYznnS3DDXUYBNCMnyXmbQ22o42WSFmwV2JxILI4G7cDvO2nBOufNNYsCnC6LrE1FctVyrdGAYiDT9M7TRF3unxO3ZYemTZ/QBO0Q6QnfckUmffP7Yt8dlTkTywXCzy+Rt63wXrgLj3Was6PqBlFaV8IUIKBbAtRmB2f37DwAgFE26j2QdbmBSUyLE0bLWRo1fjwml0wVaVEMeVKYw1UKyl0GRP2jILk/75accDZE8pRLGgXlPc3C++ikBoulmAdy4H0y/y5xAg/g9k2Crs5bIQXk9uuVj8p5XKZLT0eNu5kNUnhwFiss/UZo87g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d21a5e-18cb-41fd-9d36-08d584b241a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:37.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 8ebfdd00044b..4bdc2fc86280 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1273,8 +1273,10 @@ void nfs_pageio_cond_complete(struct nfs_pageio_desc=
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
