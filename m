Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116448-5-12623980934123250553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116448; b=aON2O6hheFuGzxK1SI2+oxbWdm8X8BpEZcIBA8sPoktV/re
    EQ83MDcldM2Wi3nryfmBpRActfC61e/X/gRzKg8hQgjkuR58hn8+/0sd5dYMN+Jy
    Qkl2RamNS3AHnbeZbsj5U7YdmDgMLCdH0fZbHT9AL0eom6n8v0ZvUwDCOBy9v700
    HNRtto81DSk/DP0D3XgTCAlHunfwTPXylg4goa6CdwbMvJMRR0BCfEhEEQJ0Mlgq
    /XQgvaJRBWevXIXTSotyvApGNZPeKLHr/P33zt0UPEoebjb1Vm8ciKQ+j1iumPRf
    pMyh6kOBTCfAMF20zBUQpJdK7i3DTy4siZb67/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116448; bh=HWebjv
    2NWRDGfH9+TmPIxmVN+rSyQB0QdBFdvygzIHQ=; b=n8CmGUI4OVP07kLu6LIGWu
    Nim7Jyz7LsgoK3NXEA1MFNpeI5qnOcbz8nFthChVTkK0OCFxblcSkVyZywFBDTCR
    +zRZl3qNr7w6dHHcaV+xKUqetny7iRJJqnZ+AuZSoYCubzuIHTS+DQeqnRmCNUNw
    /+nqhqmB9wMasvkKyT7UxdoWzfFPsg1uSwaWq5YzwLg5W4AGT7dr1adMHyojbm5x
    MtUvdXieC0rz3BLDlvwmqpRghZUP9Pk02pzc1j8rbQde5F++vXJW9GFL/AlDNJMA
    HpaRw+F2UnjVYbVJdc3OdpEG5put9AdU1gfMXniPgv74+x9xZOAy0sRfncw2nRjA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1Z4avhw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1Z4avhw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeCCWdY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:24 -0500
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:24760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933750AbeCCWdU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 085/219] f2fs: relax node version check for
 victim data in gc
Thread-Topic: [PATCH AUTOSEL for 4.9 085/219] f2fs: relax node version check
 for victim data in gc
Thread-Index: AQHTsz79pQcrRuTEJk2OK0zmav35Aw==
Date: Sat, 3 Mar 2018 22:28:45 +0000
Message-ID: <20180303222716.26640-85-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:LjoG2Kb/XDPVLcusbpTdOV6BEwkzSXmZh/Q76Y2hvcCQY4ESRQaYY7OIkyVciiAzNNb+gHjC7vGVYIf1jwxv2ZTGI2AIf/NXVGVzRehH6U2KN5JKJBT5F1bACz/nuaoss2Wk5NioQ/EVS2wp59Xd7Nx+aLm6PZyu+wRJUAkLyp3O/NjaX46eOF1EW15CpoDmeE5BbG8cdix6jNxMmnZ3sGyRL/rBbvF3zXT36SGuBHPAqNuWC5KpIt37OHUnXFhe
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32abd44d-3200-45f4-011c-08d58156c289
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109768082E42172778C6CC07FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8icNgFWUFdcVeRLaiQVn/opKs5r/5om/9M3rQjsAI8rpf74aIckjzVuxRxAZJbzI1aCK/6i43xnHX7UzLr/CN+8a7uawnEStKWJYPLHLeOtQp7sVAI7UJoJJ5vj3efQfLQBlYusQO8md7XlLQXA2ZITyHV7oznXZL9hWS8S2XIk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32abd44d-3200-45f4-011c-08d58156c289
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:45.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit c13ff37e359bb3eacf4e1760dcea8d9760aa7459 ]

- has_not_enough_free_secs
node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104

          - f2fs_gc
             - get_victim_by_default
alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1

                - do_garbage_collect
start_segno 3976, end_segno 3977   type 0

                  - is_alive
nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0

                   - gc_data_segment 766, segno 3976, block 512/426 not ali=
ve

So, this patch fixes subtle corrupted case where node version does not matc=
h
to summary version which results in infinite loop by gc.

Reported-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 34a69e7ed90b..17ab23f64bba 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -538,8 +538,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct =
f2fs_summary *sum,
 	get_node_info(sbi, nid, dni);
=20
 	if (sum->version !=3D dni->version) {
-		f2fs_put_page(node_page, 1);
-		return false;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: valid data with mismatched node version.",
+				__func__);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
=20
 	*nofs =3D ofs_of_node(node_page);
--=20
2.14.1
