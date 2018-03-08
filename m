Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488975-2-14775400160793406311
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
    t=1520488974; b=JJruJCDPzkdutetT0qi6UgYcJBm3MPRvzHuu/nXRkIuRDwG
    CeSKRolamlGpRrWLW+PEZJkv8yFD58XhK0UtTP4Wen73WWu15RmiD25RdhsXgjAC
    jZsM50G3KqorH1rW+mwtcLISpBZ/jRUN9A3auWEGiPzDjKLG5KIw2shFTaqi+j58
    +hrug7/LlTExOETFQlWCn2XaZRS8b+uj+DBX1PrTDd5aukFaAQ5rxq8GfGsdwk3Z
    Z8DA4DXM2RXGdRpPXxJk55O7NKNDiBTmGs1v8f8g4FNxwUu/ZZJ/Y8Fw7EuaWpg2
    r2HJ/+kUmZS9Z79LuswRsNeQ8OCTpOnOq912Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488974; bh=rbbF+O
    lYlFVj01fcVFwbs4rsy7+1eEUw+ih4vxOm/90=; b=IuDgprkgOm+1kJ4/0+eg2T
    ZV9rz/LCuJccgOK7tsdcH/jWdlHlBSBvBvQCqhYj/Iayxwdfsk1LHNCZ0QLGV4BY
    gzTPUg+C1g5FQM2qaTsHCWlLRXPW4vklNT0jMhAi40tBvp4/m1VnQpWp4UuUItIc
    81dDmOjEljBeXQpZBu51C2sJrrLyiOgCx3sg7qgbiD0PKb6tRI4lr6avuWHOLUXP
    +e3d9eFoLvstDguDuw3Xq+89da1TpVB+ltGmMs+zZ3rU5f3p52+8DvVyPdlrku84
    Jjrw1fMAag4rwLJnnSW52yGLtT2FGNzYw8xfBAA+XQoLisJ5rRVsrHAemLrNgC5g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RUEyt90P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RUEyt90P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935284AbeCHGCk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:02:40 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755374AbeCHFCe (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 119/190] jbd2: Fix lockdep splat with
 generic/270 test
Thread-Topic: [PATCH AUTOSEL for 4.9 119/190] jbd2: Fix lockdep splat with
 generic/270 test
Thread-Index: AQHTtppGulXPGcEk0k2MIdGLrnFTDw==
Date: Thu, 8 Mar 2018 04:59:44 +0000
Message-ID: <20180308045810.8041-119-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:bznYK2pWEbEfSm9AVxSn6X3tchqiVgIkcJmMsmA18MpPQYVvAHwnHl5EWNZ60e/OoRPaz3BFr0PYb7ey/dJ10PdAptdvUBgOTAu98jeFKvHg1oqNF08zszCwLGprkw0Nyvh9sBCVehvVmWZEOhirjvFdEDrmxwBfd39NRQbpKeP98seioOq5QPgyVIr8qPDYBFfXWPZduwtykn1HenK5yTZ9J6a0k3IBnx/plv1h5aOn/82dDEri+Tb0soAs+VAy;20:VQKdWH4GOOazHyv6Z9AuXZT/qrgcYirX4tcJqYzpZh6icDMTdjT11csNoEMKPh6TF6TJnTLjI9GEqehhuPKVtdgmdJhxdbTuQYsaFhxwh77ujxqxbE0ZDIS/1E2X3iMD7wtRaZ/qxe2xJO8iH3TpU7VoRKuUoDAUBytcFFOry2M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d709083-838b-4f8d-c4ce-08d584b1c55e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099723393F47792EC0185A67FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(43544003)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(551934003)(6436002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Bl55tzUdKeMnu2ntCqMd8JUJQ7qoREnMIb2FKIQvnI0Z2yilx/LZ1NIof2jIHZavHnZRPsJql0hBNj6paj/NZpE+FrZgUTGd8brj/7tiXBe09qaZsSVf/HTgEBbyIRXKsEZ/N/dQkG5ZQGOUAJB+EGuMRKqnjGjR6EI7Zz9L6BsRR00nVY22Bh+Aq82If9JqIjlmzl4R7dsVqTjjyzZop+O9DfRtRNFk2++hTJ7hjKUqegk59FEr4me1r9s4czJKikvIMFrNZBtMp8ibLHzqJVwrkNITRFkMtOAx1qyDn71oXyvB33tIGdq7u0KEqmE61pb57Qci5AnEUYhRZDMB8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d709083-838b-4f8d-c4ce-08d584b1c55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:44.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Kara <jack@suse.cz>

[ Upstream commit c52c47e4b4fbe4284602fc2ccbfc4a4d8dc05b49 ]

I've hit a lockdep splat with generic/270 test complaining that:

3216.fsstress.b/3533 is trying to acquire lock:
 (jbd2_handle){++++..}, at: [<ffffffff813152e0>] jbd2_log_wait_commit+0x0/0=
x150

but task is already holding lock:
 (jbd2_handle){++++..}, at: [<ffffffff8130bd3b>] start_this_handle+0x35b/0x=
850

The underlying problem is that jbd2_journal_force_commit_nested()
(called from ext4_should_retry_alloc()) may get called while a
transaction handle is started. In such case it takes care to not wait
for commit of the running transaction (which would deadlock) but only
for a commit of a transaction that is already committing (which is safe
as that doesn't wait for any filesystem locks).

In fact there are also other callers of jbd2_log_wait_commit() that take
care to pass tid of a transaction that is already committing and for
those cases, the lockdep instrumentation is too restrictive and leading
to false positive reports. Fix the problem by calling
jbd2_might_wait_for_commit() from jbd2_log_wait_commit() only if the
transaction isn't already committing.

Fixes: 1eaa566d368b214d99cbb973647c1b0b8102a9ae
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/jbd2/journal.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 7d4b557f1962..047c8ef620fe 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -691,8 +691,21 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid=
)
 {
 	int err =3D 0;
=20
-	jbd2_might_wait_for_commit(journal);
 	read_lock(&journal->j_state_lock);
+#ifdef CONFIG_PROVE_LOCKING
+	/*
+	 * Some callers make sure transaction is already committing and in that
+	 * case we cannot block on open handles anymore. So don't warn in that
+	 * case.
+	 */
+	if (tid_gt(tid, journal->j_commit_sequence) &&
+	    (!journal->j_committing_transaction ||
+	     journal->j_committing_transaction->t_tid !=3D tid)) {
+		read_unlock(&journal->j_state_lock);
+		jbd2_might_wait_for_commit(journal);
+		read_lock(&journal->j_state_lock);
+	}
+#endif
 #ifdef CONFIG_JBD2_DEBUG
 	if (!tid_geq(journal->j_commit_request, tid)) {
 		printk(KERN_ERR
--=20
2.14.1
