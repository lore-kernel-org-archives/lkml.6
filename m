Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489399-2-17967085187560378964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489398; b=WfuJdWy667KgUqV32qG/+chScCgvYpTm4glNpqySHClQBPw
    AhoCr9s4UzNo/DkhuF3CHFoUsJthUfnVZmiVaFsYOlKImB67hseQcKSBLVYl9rXz
    7LnDMGPC4xtl+pNni6BrGQsOHBgYaK+xSQwoQAk5fQIh9F4jBl7eA6BzV/au1wbt
    fj5PXMrmlh4RoALSgffbJUpY4343jM/j/rFCReUBMGBznAfF/ST7SKNFP2uNyyH9
    3TEffW286BE1IGMogzXsa28MTyQPI7Bt/sfX+Lze2R+1vmJEM/V4aSBOIDmCF2bX
    MFqtmtQ1OH0lle2YOanJ7zFbRyoX1P/4Bwxd8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489398; bh=9b8q5+
    9DpJGU6ZPhtnaep2VynH8Suf+4S2RPDkbuF6U=; b=d5n/jcGZxWgaMEPNpaUifI
    PrWoyL+FFoTFrza/9rZKvxnW4vYud4J6zAkCjLNEZCbzww+N7BvUrH7D69esf2Ie
    Kn0kJVVfljqz0TD2kemDUtYSjCpgdVAcDv3WENTJZvfpKhv4Bh1GA+zguQQlO+8m
    tlFMrCIdjyk0XbtecAE0Ysk7xSmiL5GNjEu9sHqvkIbO59sUacQ59f5bHryeVOPF
    f8JRmItvP0HBLWm3XLCBeIiilVluOyqpSimbmshy3Vqs4bswv9lT0MvleU3xAXXF
    TvwXd30ktVbx8I6ad7xW2ZNN835SvtWxpfux2etDC4RmVmJcFD9YnRuOvqbcGT1Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bBHV6EhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bBHV6EhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755359AbeCHFBr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:47 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965404AbeCHFBl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 086/190] pNFS: Fix use after free issues in
 pnfs_do_read()
Thread-Topic: [PATCH AUTOSEL for 4.9 086/190] pNFS: Fix use after free issues
 in pnfs_do_read()
Thread-Index: AQHTtpo9R4tBWTooqU6WbP1D0U6chQ==
Date: Thu, 8 Mar 2018 04:59:29 +0000
Message-ID: <20180308045810.8041-86-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;20:eYdb4M/tmpLPTZy1P4vmc3xf3A3MdwBd1qiPerkTkJ+xgTcwu1y6TUgeGSOpnLcU41nyFf7nGfdk431POmj1KgKscKMvQWYU4TuHyX55neTc10V77/g22QiBYOpqdl5DW4uh4ddh1sT5xspmcAt8J3nnlhFgVDN3LVXkJ5+Ae8E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1709a633-971a-4eff-23a8-08d584b1a9f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999A8ABE7D2893DE5020BF6FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5nf4WnY+Ux1vTkRFSJlJ7OLbLZUEMc+4p1QhvDBjs/htW0XpUz2RobKW8GlRz12wTJm41Fb5BeDDW9TwGGOybTL/hRg9PGjm7ETc0c9d8eYRNQQHvA+Ns9ZVQ96WImV3e9d+lHl4z2IfZwPGeW55MHt50H1ZEGmsEHI7k373pHpweRUmhcXj9vVhQ0TvT7fYfgtJx3F3LeAtejYHGPIAg1YSW2fej7V3PPS/ivfVsMk2ZXyMlLG4OQOzd8XvHshNPYhOqiybrXZYS5qoz/zFo4Ei+99XOrQgQStpyyhajkirLMbSCN9EFlbhRLpEt/1/1dEEVEdbtYRrFJTDMkmyaw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1709a633-971a-4eff-23a8-08d584b1a9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:29.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 6aeafd05eca9bc8ab6b03d7e56d09ffd18190f44 ]

The assumption should be that if the caller returns PNFS_ATTEMPTED, then hd=
r
has been consumed, and so we should not be testing hdr->task.tk_status.
If the caller returns PNFS_TRY_AGAIN, then we need to recoalesce and
free hdr.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/pnfs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b8e44746f761..e9a697e9d292 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2308,10 +2308,20 @@ pnfs_do_read(struct nfs_pageio_descriptor *desc, st=
ruct nfs_pgio_header *hdr)
 	enum pnfs_try_status trypnfs;
=20
 	trypnfs =3D pnfs_try_to_read_data(hdr, call_ops, lseg);
-	if (trypnfs =3D=3D PNFS_TRY_AGAIN)
-		pnfs_read_resend_pnfs(hdr);
-	if (trypnfs =3D=3D PNFS_NOT_ATTEMPTED || hdr->task.tk_status)
+	switch (trypnfs) {
+	case PNFS_NOT_ATTEMPTED:
 		pnfs_read_through_mds(desc, hdr);
+	case PNFS_ATTEMPTED:
+		break;
+	case PNFS_TRY_AGAIN:
+		/* cleanup hdr and prepare to redo pnfs */
+		if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
+			struct nfs_pgio_mirror *mirror =3D nfs_pgio_current_mirror(desc);
+			list_splice_init(&hdr->pages, &mirror->pg_list);
+			mirror->pg_recoalesce =3D 1;
+		}
+		hdr->mds_ops->rpc_release(hdr);
+	}
 }
=20
 static void pnfs_readhdr_free(struct nfs_pgio_header *hdr)
--=20
2.14.1
