Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243907-2-11801014065460318496
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
    1523243906; b=O4oh3n6cmnsRMT+Bem1XxQiuAqVQNqhy89Rz9uvQZnb61gdKgE
    Mve1o6ZDcakU2EEZ92LMskIvh6raP6sKdowB/e8A6ZqJGJzS4RXYo9zQfuc6lI3O
    s69qPc0fNkgV9a8AfrdEpMOOUNoBeeOPg65GJ8Bquun5uPG1uJ4rhBQxvnlNcCdF
    +Zg5raYgCjmtpfHWTCbD1Dj67/uWHgjy+f/NUoNzpZqNiP3yyyeG0v7stde5U2U7
    GbbOrFxDojWGFbKfAb/1yuC8aNjNiqRTqsE8HXhGwJilQwwONNHIiRCFDO4ESGnO
    lkIRfwN0DIO40VZ0QgexqrTW4RV+5i6SLp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243906; bh=h3T8s03CLc
    aBUqU94DredU/6mVTfi4dRYdosap5vhHg=; b=MTwht5svRfFglT5OZ/8mHe0a00
    3RQmFOIaJiTsN2McD0g+RHYk3dwtWhwdQt/4lHNr3zuKEZ0RcgKdAyDXN4LXoM/z
    J5ajZtg1A2JuX7CMTjBsPG7YzOZ7kPCxETTeI5X3h47mBRC0I9A5YlRI3CZLgisz
    GzL4e7qNCGuhV2yVUhDUY77pk0mHU3AMzBKGKAGzNAfYHwsemyWdwvhKsm5qVkLB
    92QFbmxKxPx+29VSmKJsJ3IUB7tpk0i9cSPNm3e2YuTrP6roVUXgend+1sEVl0K9
    W2PPLcvC4dYcd/tGKR33kI3Ltrvdk7ZhuHl5rTlb3YbCi4Zp2MwPqXc2nxIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iGfIQcGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iGfIQcGc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHnKz88jGto5+rktnQSUo0U+E8nBmZ6LmG/hfCPY3bdG3wkGBoTCt0UXCgfoq0iVxsURVnD+aQEZsJnO8AcYnLiToM7/2brAxiyx5RnmWw5otGBN234F
    LPle7QPA2WGQhzyWLUoOpboO1pzognVY/ki1PDnu7JAdkvJ3jILeeKtJ2/OCzb7lsn8uElY87yLFhyPXjBn8R08s3BNXHbxJ9RDbsMbiJgy5LOU197Cp4Q4F
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=BLFmf6ASAAAA:8 a=FOH2dFAWAAAA:8
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=tDy0FKqA7Mug1Dnmm1sA:9
    a=LTB1CHobwV3oVk2y:21 a=bp23uTJJbwDivF6A:21 a=wPNLvfGTeEIA:10
    a=CO9zRrxQzJsrzgl5TAGA:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeDIDSH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:18:07 -0400
Received: from mail-bn3nam01on0095.outbound.protection.outlook.com ([104.47.33.95]:56127
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753924AbeDIAXd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 055/161] Btrfs: fix unexpected EEXIST from
 btrfs_get_extent
Thread-Topic: [PATCH AUTOSEL for 4.14 055/161] Btrfs: fix unexpected EEXIST
 from btrfs_get_extent
Thread-Index: AQHTz5iRCmx8QNbuakOCPYr7rEv2Lg==
Date: Mon, 9 Apr 2018 00:20:31 +0000
Message-ID: <20180409001936.162706-55-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:TNdSUOuABnJx1URCLXlapQ53wQnIqyqtLm5ufGi4m/SChwcqmwglbcGhcw/EBU5xX8ldqJKVSxq906ciKvyVp6K+dViucu7dc6Rhh5sfjFr8EjN0go6WLZreqNsgQlyvZVdTsebrAgrYhfkWxxY8iSlYLcbikZT+JJ9FO9ZMtnoPipcCpG67AF/HrQWkw3yhOZ2vhGb0a4BMm744k17DKeD0KHJSJeVHFVZXgkg+WwvxRFlDQYrjQ0j5HI2W5LMo;20:z7Bld/ePNa57irR4K/0Jrxm/k3MAz9qjF4FthjJ8qaDYHxVOKWJ1VLjR9HFIVPEoIk6R3WIZXAv9J24+7puG1ii+N6W+MlEzC9tuVRI+OWO6EvP4TnUEbF296EmirCumy/P1flpZ2H7w26Ne1wOZEXUb4JsZ6bCemyiXdLrQsaQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72dc1cfa-5c28-4b51-61e3-08d59db01ef6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101464547487714470519AC5FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d4rKjVZ/6RRTK6BHPWeS9UnNDFcr02HaCfDDZdLtZQhGApTFU7n2znhkahvIIs9l4bK5TJaxCr5Gc+xE3CQkA4pJSURlzA1iDRhCZpBpR8Yd+ltvxfysb7K67h7UwBjbowS/9Y0J887D7x8qACNnQ3SQ7SbXjIJ8xUgKrCgyEjjLCwQCjWVya77lh75GOHUHUAgMNVlRm+ecU8zcTRgFBZ1iesI6KW29MWqEFa7GKg3GMNwVs4bW71KUCTcdKMeLiNffAize5dMv3/+ML308HlughNfU0I3Z7300Myu3tQZbfkg3wo+tjf8UH3RM6R93tcRNvpJwGBvHWPhGA64Pnsdzjjm2ksyATyYq1oTi16Y1bxQnIEkW7GldMs09Adh95osk9c9scu4iaxqB8pRw7ciEp3CsNNRmrHoyr5we6Mc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dc1cfa-5c28-4b51-61e3-08d59db01ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:31.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index 59a01a0844c9..bdff397fe9ea 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7234,19 +7234,12 @@ insert:
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
@@ -7258,10 +7251,6 @@ insert:
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
