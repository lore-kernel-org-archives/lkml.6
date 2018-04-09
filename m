Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246409-2-954186791537290845
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
    1523246407; b=T80hf1tFmePflF3Col6C7r1UGlaDbU5dpqasdWt1Qiotm9lsar
    z/MAa7/w0ETAYpwcFAuixE1r0DE2p7OIBa8QeNtdK8K9L25oaZjBsTE00RxfUzRy
    4p1GdwRj/dCcGV7t6HVXFNCmCTW+um7ETXRPBp3B4Zoqeak46QQutC+KkTO6mZlg
    cj29UNDs/yv06d8JJ93b186PI/7KjFEJc5Nq5fY5Y2SmPfSFNt22oUv1savngCJP
    hxFgpmK3L5Uqm4Vt8+zI91C/zSIdlsHm81DhgGYL3b9TVaXdzfZAH9t8jAZ9Nu9G
    K5+IvlH5uTxu3joqxFl1W9G2ITr6UX9zf2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246407; bh=PQcMaHWfaA
    GoMC01iP8lHBtN0gbOPnU+tbZF+ku6WA4=; b=TipBHWCYtQ6DjQqWD39nyqHZVR
    vLdiES/BWaeOp+4HDpVPRV8hOW3p+r9/EHihLPsi1VB2DWLfi6FxZ1l7PVZUGyFx
    5b2Puyq6aymOVZkIzIhFS57pMY5GYbZgktxVTxC4f1xlnVxcyUhbHnZuHpopoO0o
    zEzYl1wrsyj51YsrLjcxXzUGDTJcZwAvVOk4tk1F5eq+ZpdmKuiHNpureHz0+jNn
    U6b0lJZu6bJMLe9vA+x2rdGwrLfqXatm4uul2w74yP0rdLOrkc9bEjU+C8mnM18X
    sBESkg7CfVOo+Tq9ugQyjDJKTOFB8T6xOrlu/qB25Yh6jFLimQYyCdx5bqMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QiONMtyB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QiONMtyB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBD6X+uiMlMGpHWIovxPGi8wcCYldNnI0+1hGrKoqbll9bWLNY//KEbocaH8UKoJ00zZ/6JpWf70WPLZQ5LZPu63aDEckoZVG4XagXEDhATczeB2g3ir
    vDNyKKYrgkd9a9oMROK4/EkCQefJdppC1xZpgKNJ7TK+nJoDeTA7w3cDlpDpD4X5+50hivy/c78kkfLfS9WHz8bbkhe4o5bxLqw9JROpnTSDjdd0Cmo9O+a3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=BLFmf6ASAAAA:8 a=FOH2dFAWAAAA:8
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=tDy0FKqA7Mug1Dnmm1sA:9
    a=LTB1CHobwV3oVk2y:21 a=bp23uTJJbwDivF6A:21 a=wPNLvfGTeEIA:10
    a=CO9zRrxQzJsrzgl5TAGA:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeDIEAC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:00:02 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:30557
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753612AbeDIASe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 065/189] Btrfs: fix unexpected EEXIST from
 btrfs_get_extent
Thread-Topic: [PATCH AUTOSEL for 4.15 065/189] Btrfs: fix unexpected EEXIST
 from btrfs_get_extent
Thread-Index: AQHTz5gpzyPVa1AUcUiC6yUQDG6naQ==
Date: Mon, 9 Apr 2018 00:17:36 +0000
Message-ID: <20180409001637.162453-65-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:1Lf5kicoHToU6xfbBG5q2Z+hkE0jJxtCvcsvSk1Claf0CovOjOQNDw8E8ZrPmX30jhdcHe1VCTcDmRpLlFtF7uMY+mssQnZn+lVbsmGoU5fuPe8P2QahD0iTnnoUKb6ZWlQdUq2qnJUh3nYHUG8edyqGK3Mw1XdsRyl1NiFwxf52MMzLuiBrd32FLVJQlcjyhZUvUsdSYIMlB04iZW7jeIQl3LEtntdgCfk21QQQAnPiyrZr4K+f29/4VzFMxBQD;20:zub7FMmnhR5CenQ5M3SX6I6nkEdImT0QZ8H17k9Dor7Uyk+ZQvFPt/eH4iS+HgFKr+mxWGYIIAr5uG6WaoscNGgvR+SodZZQKUmCOshveg2ZWNBS95Eef+aX9zLwhcDghdLcMCyjX62bxLlOfR1jN6PezMhVhiw4w65J3HU8hZA=
X-MS-Office365-Filtering-Correlation-Id: c70b67ec-5718-495c-2731-08d59daf6c07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046D017C0CF86A85E8E5F01FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qx95GmymzvNNQA7h5VuNeG5oxF5LowNzQVrS64j9YnqEmPSsAuGmSRoZ+PJdItOMdg5miBE+I7/wQuJjwuAUI8zqO8nyakyswc0BwMm5aO5S6kJNqzglE++qSiXEKD3JD/fQTo2H36B5khLyAIVvoJ3RCFxLelMtgFq6n1M1WGFbQhqYgA2xFsnw6re7Fi+7UndtgSs/wYNy04zXDGG875u7dcu2OPO16bik4+P5gS9EKD+pqU9WIvDMQV32ivtLoiuEVlAVNPDmfmiinsYDnXhICMjqEeGengUR8tx6IxSA4pU5bQbtkXEOLY0Q3FlIXl1LylCTI1cBQPXI7bXFyau8Oj+TPZc2hqnfnyfTDdY6c8fP2oG2/WtlEUwavFW2ui5IZ3Fk8TXOX70sc5n1uZpKjzyQqNEkELgPqBmY50s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b67ec-5718-495c-2731-08d59daf6c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:36.4620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 18e83ac75bfe67009c4ddcdd581bba8eb16f4030 ]

This fixes a corner case that is caused by a race of dio write vs dio
read/write.

Here is how the race could happen.

Suppose that no extent map has been loaded into memory yet.
There is a file extent [0, 32K), two jobs are running concurrently
against it, t1 is doing dio write to [8K, 32K) and t2 is doing dio
read from [0, 4K) or [4K, 8K).

t1 goes ahead of t2 and splits em [0, 32K) to em [0K, 8K) and [8K 32K).

------------------------------------------------------
             t1                                t2
      btrfs_get_blocks_direct()         btrfs_get_blocks_direct()
       -> btrfs_get_extent()              -> btrfs_get_extent()
           -> lookup_extent_mapping()
           -> add_extent_mapping()            -> lookup_extent_mapping()
              # load [0, 32K)
       -> btrfs_new_extent_direct()
           -> btrfs_drop_extent_cache()
              # split [0, 32K) and
	      # drop [8K, 32K)
           -> add_extent_mapping()
              # add [8K, 32K)
                                              -> add_extent_mapping()
                                                 # handle -EEXIST when addi=
ng
                                                 # [0, 32K)
------------------------------------------------------
About how t2(dio read/write) runs into -EEXIST:

a) add_extent_mapping() gets -EEXIST for adding em [0, 32k),

b) search_extent_mapping() then returns [0, 8k) as the existing em,
   even though start =3D=3D existing->start, em is [0, 32k) so that
   extent_map_end(em) > extent_map_end(existing), i.e. 32k > 8k,

c) then it goes thru merge_extent_mapping() which tries to add a [8k, 8k)
   (with a length 0) and returns -EEXIST as [8k, 32k) is already in tree,

d) so btrfs_get_extent() ends up returning -EEXIST to dio read/write,
   which is confusing applications.

Here I conclude all the possible situations,
1) start < existing->start

            +-----------+em+-----------+
+--prev---+ |     +-------------+      |
|         | |     |             |      |
+---------+ +     +---+existing++      ++
                +
                |
                +
             start

2) start =3D=3D existing->start

      +------------em------------+
      |     +-------------+      |
      |     |             |      |
      +     +----existing-+      +
            |
            |
            +
         start

3) start > existing->start && start < (existing->start + existing->len)

      +------------em------------+
      |     +-------------+      |
      |     |             |      |
      +     +----existing-+      +
               |
               |
               +
             start

4) start >=3D (existing->start + existing->len)

+-----------+em+-----------+
|     +-------------+      | +--next---+
|     |             |      | |         |
+     +---+existing++      + +---------+
                      +
                      |
                      +
                   start

As we can see, it turns out that if start is within existing em (front
inclusive), then the existing em should be returned as is, otherwise,
we try our best to merge candidate em with sibling ems to form a
larger em (in order to reduce the total number of em).

Reported-by: David Vallender <david.vallender@landmark.co.uk>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/inode.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c04183cc2117..90ae4e25ba3c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7180,19 +7180,12 @@ insert:
 		 * existing will always be non-NULL, since there must be
 		 * extent causing the -EEXIST.
 		 */
-		if (existing->start =3D=3D em->start &&
-		    extent_map_end(existing) >=3D extent_map_end(em) &&
-		    em->block_start =3D=3D existing->block_start) {
-			/*
-			 * The existing extent map already encompasses the
-			 * entire extent map we tried to add.
-			 */
+		if (start >=3D existing->start &&
+		    start < extent_map_end(existing)) {
 			free_extent_map(em);
 			em =3D existing;
 			err =3D 0;
-
-		} else if (start >=3D extent_map_end(existing) ||
-		    start <=3D existing->start) {
+		} else {
 			/*
 			 * The existing extent map is the one nearest to
 			 * the [start, start + len) range which overlaps
@@ -7204,10 +7197,6 @@ insert:
 				free_extent_map(em);
 				em =3D NULL;
 			}
-		} else {
-			free_extent_map(em);
-			em =3D existing;
-			err =3D 0;
 		}
 	}
 	write_unlock(&em_tree->lock);
--=20
2.15.1
