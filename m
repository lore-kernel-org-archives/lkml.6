Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497897-2-602728196574462569
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
    t=1521497896; b=bdwMSm4Xk1LkyDyewfjqZQUfr/j+XAUI6BqwOppwV9sDQpE
    q8a+EYLP2HqYhbXfb+wDoYVFovqzsXtR+/cfSTrqi2AdIl27sbO0iGi4KjLOPPiS
    G8JAEKHdN+ro5QAXPbPQZti4oKA9nSTH6gITQM7SaDPNrz0oZ1TakVY46VB4puL9
    zt6f0/EF25TYVXkH1SMGKOT9Icp9WNKugHoQ8PiMjv1/rPHYRP4kiA1qOnE/b14K
    uhHfNlvdxOj0I5L5vFEfNOzHYtQqxgAdstQpZESMyOzU/7h4JGMhmBk5/ZnZCdOG
    zyhAkE/FiNfekOfO5qLhv/aG52+hM+8KvfhEfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497896; bh=1zCksd
    3A0q/gTbQfMWW/eIwTvhXBcEJh/jeX+vVH2I4=; b=oXqLdP728qAgHPz11huBKF
    CjRCRDLOjRuRqjskFYtNEfYFORRH3SJEFI5ZY3sed+AjzZ14qdSxHukeSqv9WCYx
    rKmV+Eyg0c3NantLyVyUqqGRmRqxd3fKLFrlHXCB/AHcag2UUg61N0Fe2nojeD4o
    DZLtzPWgBqkMJ3puvHnmGpuoOOfXZJdSLzlFvezlUj35GRnGfU7Uj9C8zNKPUcaY
    agMmgzRdAG1PgRtnuROGDg4Ikncw7pqWUloYSv42bCinJyObzPSQ5oukLiwrW5gS
    zlUo2KEOR671Tt6frahcqruKdpY6JioYzLunADb+y4WGDXNzlBHM2TWj9QJFfQdA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jgyAA1Li x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeitdenucevlhhushhtvghrufhiiigvpeehtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jgyAA1Li x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeeitdenucevlhhushhtvghrufhiiigvpeehtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032462AbeCSWRY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:17:24 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:20557
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934004AbeCSPtr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 095/124] xfs: harden directory integrity
 checks some more
Thread-Topic: [PATCH AUTOSEL for 4.15 095/124] xfs: harden directory integrity
 checks some more
Thread-Index: AQHTv5nDCcc2Q+izFUeBT3uIALiSTA==
Date: Mon, 19 Mar 2018 15:48:45 +0000
Message-ID: <20180319154645.11350-95-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:FBD7K2D9Vr7vyptoHn5DCMUfQqfoDFdOyB8YcS9oYh5QWR4YCD3XbAYJS+CAPrsMEamUutMUTjXWyr0NyBPhEYj2j09nRiD5g8pWvtJS9jGcQr5RDKddFMfQzmrw0Bbu+UntuFdmZxggo0Urwyn7cT1mW0scxQtfRAnYDdMm00BMKWEbQVR2yAx9/3t87LQ3SzS/0vN7IDPjfEhEVvvOwPgMZbK2pAzGUHxWTMJylwWAYS/6e0Y2ceiliTLCIYth;20:PUv7lEqQYyA65zuGz+JG6EBl6QQ1tqbRTDPWwNMv2zUpHd7NE21MupkUZAV05wLSjQYgG4+rKLEOlWCvFucHwd+Nf+Zfufe5b6klhk5FwAD+7dDEhMJxwzYTkJEw4n835J8MOq72f7p4jlCB/s9c7l42xnxKTWmWHeiFnNdn5iE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63aa3423-c2b6-422c-2fcd-08d58db105cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981DFBE1D7D22CAE41E47E9FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QoxWb8z2waAC83hN9kffsr64YfH9rkN7K8lu6C22HkTBD85CoJMqOok5EJgYwYlpOlOcCU+u7XmwYJKpNkSX1zRzdX3rMW5zgAyU4c0erP5pbAdUo9zUKpruwVc4gu92srCFkp82Xk+ZWUeGCwp+Z2zrbwCzr3JX2wB9eGcw54Iq4zHuatrCyLKN+6DnAhSBaqgeAqFXhKZkGsCVd+XzGyQ7zogDm+2w++y3ESfoXTzJrr8cEzTh/381aEU6vcDn+heIFI7vvw6Xb4QZFT3p+fvpDMT3WDKQ8Jzf3YG9uy2Qp/PHsl11Axa4qTOLbk3fgMcfJDhgnizzBhZHdNSHpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa3423-c2b6-422c-2fcd-08d58db105cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:45.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Darrick J. Wong" <darrick.wong@oracle.com>

[ Upstream commit 46c59736d8090e602f960aeaf1c6b8292151bf38 ]

If a malicious filesystem image contains a block+ format directory
wherein the directory inode's core.mode is set such that
S_ISDIR(core.mode) =3D=3D 0, and if there are subdirectories of the
corrupted directory, an attempt to traverse up the directory tree will
crash the kernel in __xfs_dir3_data_check.  Running the online scrub's
parent checks will tend to do this.

The crash occurs because the directory inode's d_ops get set to
xfs_dir[23]_nondir_ops (it's not a directory) but the parent pointer
scrubber's indiscriminate call to xfs_readdir proceeds past the ASSERT
if we have non fatal asserts configured.

Fix the null pointer dereference crash in __xfs_dir3_data_check by
looking for S_ISDIR or wrong d_ops; and teach the parent scrubber
to bail out if it is fed a non-directory "parent".

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/libxfs/xfs_dir2_data.c | 8 ++++++++
 fs/xfs/scrub/parent.c         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_data.c b/fs/xfs/libxfs/xfs_dir2_data.c
index 8727a43115ef..700acc43289b 100644
--- a/fs/xfs/libxfs/xfs_dir2_data.c
+++ b/fs/xfs/libxfs/xfs_dir2_data.c
@@ -73,6 +73,14 @@ __xfs_dir3_data_check(
 	 */
 	ops =3D xfs_dir_get_ops(mp, dp);
=20
+	/*
+	 * If this isn't a directory, or we don't get handed the dir ops,
+	 * something is seriously wrong.  Bail out.
+	 */
+	if ((dp && !S_ISDIR(VFS_I(dp)->i_mode)) ||
+	    ops !=3D xfs_dir_get_ops(mp, NULL))
+		return __this_address;
+
 	hdr =3D bp->b_addr;
 	p =3D (char *)ops->data_entry_p(hdr);
=20
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 63a25334fc83..b4d2f8406d22 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -171,7 +171,7 @@ xfs_scrub_parent_validate(
 	error =3D xfs_iget(mp, sc->tp, dnum, 0, 0, &dp);
 	if (!xfs_scrub_fblock_process_error(sc, XFS_DATA_FORK, 0, &error))
 		goto out;
-	if (dp =3D=3D sc->ip) {
+	if (dp =3D=3D sc->ip || !S_ISDIR(VFS_I(dp)->i_mode)) {
 		xfs_scrub_fblock_set_corrupt(sc, XFS_DATA_FORK, 0);
 		goto out_rele;
 	}
--=20
2.14.1
