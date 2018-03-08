Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488596-2-1121938488131248329
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
    t=1520488596; b=ZZc2vYw9borbe6Dy2ZfAAOBPuIEv0ijRcA5KeeTfGaxjFI0
    mM1ZcdK/jLUVc8LrXMSapkUMjxVb5RYDeRypmN/WZvnT3PhUXmDnlsVeqi/Gfq9m
    2DA/WlbkOBUJ/QOu3d+2PxXLFj7wZ2Hyq5heZ0IrjyTx6gyFHcm8W+X5yqjhMnMx
    zn3YTWPZkT904OL4joau+SCLrmPT24CtE6Q4AjQOVfisojKaidm1BFI3YUITQGTk
    KMJ+ItFRCV9XkgKzNKBEJAsoDSVYoiY6rJID9Z0XDaXeO5Uol2G1FUXWUcG/kjyo
    Lw5XwCTM16BTt9GXU2xJKgvwAr7QJDrwoTz+Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488596; bh=sKkOT2
    B2Xp4LL9JpCaKSctK5+6JDoVXV8HGf421tVY4=; b=vyq1IiG5wAHoNqyevHhw9W
    FmaCLACi0DYjpLe/gB2nZ65ufFjR6NFM+Ox2w5RnCcSK2DOvvsl1y5y5eWWq6mAc
    Sh3T41YV2hk5q1LP3CgenmipoIT0JvET6A0iR7dIdSq5RwYWIKcnHOpolqWczmWo
    5S6b7Z96xvfQWG+Rn0o+tnEcjr/JtpTF/utiP4Cx02Vexc20tEfGCobxjCtC/AmU
    XPJZBKAq47JRBlLIWsakINBvGyQrC/TvXS4Z3E99H9yy7NeyDVlFOHbTpogln2Hj
    3BMcINEDuBceH3qlJf8ebDe80/BKQN41xHZ2ivp4ncmId3O2iTiAPJ9JQlP4qLyQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F5hSUYoX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F5hSUYoX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966115AbeCHF4W (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:56:22 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966031AbeCHFDc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 140/190] pNFS: Fix a deadlock when coalescing
 writes and returning the layout
Thread-Topic: [PATCH AUTOSEL for 4.9 140/190] pNFS: Fix a deadlock when
 coalescing writes and returning the layout
Thread-Index: AQHTtppL1tp0wOts4UmRJk77IvA1eg==
Date: Thu, 8 Mar 2018 04:59:53 +0000
Message-ID: <20180308045810.8041-140-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:7wkmLQeGBN3XeRdhzj2ZlxGyyqsgWJhB5lLgMvU9zCcVyzm4V1Ya7OsLvnfmu2YvV5olEgtKCZbhAk9Okhoe7TZd+zWxnsX2Mtn+iIACacRXZvxoYjDxgBuPrVrBZducuo0ShJ03LEW1C0VwnWNBAJEJgtTgXlZiH7BLar/jGq8sifyxpkn6A7gH0/ZTcyyYKlOBzR5DKkFyecToCLOVtJT/U238CjLTXSLAyredQz4zb1br2+goqgj11MuxpLuW;20:TbwZ7BCRsZJsVcS7GRLnn9wyB/6ZUBNwuGojZx/K9aN3l6nYPY3hF1/6ZijAKhhfZInd/nba5++XtDpzDjf4DCULNxXMzavsd9VFV3PZiuOpOzhEGQyCVvHqGqkp4PAHVJu21ncYDz2+h5oFMm5jndhBOA4nIKBgQ7loBpjSOnk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f10ab73-01b1-42eb-abbe-08d584b1e86f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133801486C2C86106DDCBFFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dajPvQfMMg7lW+nUvErht120Rt4VLsOcr98Aufw8qGaSMLwysmFc6KhMlFL46T0BTSG8xHaLyzTadZGPLnO7wg8ACllR4sqyFDv+BWDM1lSErLthaLrcF8TVfs4ty4llOszMFCZWa4FlgCxMZKt+8KKaCmU74pIycQFPblA0QdaGH7wmw9O3ilkXITQmb4IbiLv8XEoVM4ZHm1CCqG86fkdgFl+kP1vwyc6mL7+3L2ZdZtmp1ZsgRfsj7lyOdnATeWNOydEbbDK82SYicB0Vozd099gV2LrtRrvL0dILFEub/4v4YTRinifz9HdVTkMfh9Gisf0sJ8lBu8w+UXibtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f10ab73-01b1-42eb-abbe-08d584b1e86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:53.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 61f454e30c18a28924e96be12592c0d5e24bcc81 ]

Consider the following deadlock:

Process P1	Process P2		Process P3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
					lock_page(page)

		lseg =3D pnfs_update_layout(inode)

lo =3D NFS_I(inode)->layout
pnfs_error_mark_layout_for_return(lo)

		lock_page(page)

					lseg =3D pnfs_update_layout(inode)

In this scenario,
- P1 has declared the layout to be in error, but P2 holds a reference to
  a layout segment on that inode, so the layoutreturn is deferred.
- P2 is waiting for a page lock held by P3.
- P3 is asking for a new layout segment, but is blocked waiting
  for the layoutreturn.

The fix is to ensure that pnfs_error_mark_layout_for_return() does
not set the NFS_LAYOUT_RETURN flag, which blocks P3. Instead, we allow
the latter to call LAYOUTGET so that it can make progress and unblock
P2.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/pnfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index e9a697e9d292..0e008db16b16 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1953,8 +1953,6 @@ void pnfs_error_mark_layout_for_return(struct inode *=
inode,
=20
 	spin_lock(&inode->i_lock);
 	pnfs_set_plh_return_info(lo, range.iomode, 0);
-	/* Block LAYOUTGET */
-	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	/*
 	 * mark all matching lsegs so that we are sure to have no live
 	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
--=20
2.14.1
