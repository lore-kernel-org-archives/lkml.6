Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480817-2-15615561287278625269
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
    t=1521480817; b=jWMq/ZAsf+ocmaloZRVcY8O6fMqjdoNm4FW9Crr4vdDWSLD
    MUzMbBZu/0Eno3RRE7bPLeYuBaPZYIhl12J3RQWTMdsXUO647gFIHgDKoBzp+DEi
    mFv+TyxlqkDG6BcYqQWZgDMaQEK2BlHerQphRubcExgVkhYyPMO1zuQfZIPQVjy+
    u1eA7NyoBJF4RVUQkArYoVJB7iRkPGqzt7B1vGtpg4QVLaZfD/AObF9zlsTDuZ18
    wcjJUKACgqgYL7wfn0vvuBPb34JaOb4lCxMqKXrI2aPRTxZ/LvF+f2rA3rM34+H1
    skVvcQfg+TQRJrOBf63BZFvAvZve7c5OzxxtWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480817; bh=dFUGdZ
    d3RfQis/20DukBrkbBtFdVwnsTTiVlK7BmgAo=; b=BfLsQAOKkgfG+Xbp4gN+AN
    B4is2WWQOkezdhD8xyjOShjeU5CI2JADTWlPIRkCtWHXDA9opKXSNWSic/rTgaFh
    vVCJBSu9j1Kmv6IogDCiBh8PGbgxrV7uatJlop21bCX4M5+KMbue9xhZQnlr3eLA
    FyXa6+y614ELZt3egtsoq3/5cxj24F/WMSflRTQjCiOeCiUelHVtJTtvoqnXAZTO
    WsAA34kJ7J04t3bXwK+668WTC4mBzHPipu+l5gzpaKjSXrFYkL71C5JdiZafBY/k
    elzhSszqrw2MZernLS5YoSooj5WxWQUDLj9UgI0bwcKqvfC3F1pcv055d8ViYktw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMTsmf/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeekheenucevlhhushhtvghrufhiiigvpeehud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMTsmf/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeekheenucevlhhushhtvghrufhiiigvpeehud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967999AbeCSRdC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:33:02 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966092AbeCSQGz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rabin Vincent <rabinv@axis.com>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 020/167] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Topic: [PATCH AUTOSEL for 4.4 020/167] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Index: AQHTv5wkfhda1ChME02oitAM9cttpw==
Date: Mon, 19 Mar 2018 16:05:46 +0000
Message-ID: <20180319160513.16384-20-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:hD/kPI5wmlLgTZ/ZOd2q8rRU952bmcDcr88MhMAU6dPpM7n6oSUW4yFusLiFXEZCGsfJUMAUijWSX1VmduAN+AY0gMxeINbaU7p38bP6z6xYOi7ubDCuBV4y55n0tu/96qXSB/D5pSXjPLRqJAtlu2kRKgch+708YUAem2NzmKtmerNCMs0gpyZhQF1K55/2H/E5EAnpVR9KfUbIdXtgN9+VUsjY2QteQYhWSKmsCr3I86H/w2jtkiTdiV1Nseat;20:2N0XKbphosSBX97QpKXV5qKSTRGJzFEdjteB8G0oXZXDWPEox+8/dE2n1wmIfdW9y9sPEKhMMQ/D3jTw0+seSbJp5IMJwRDT2bvuDhcdTZc8s4WIg92H6tOYenm6e8bvoCQzSbHxIijQpbdvPvhOFVUL7FSQvqHB48bU7yQrVT4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 249ae30b-6030-4a5f-c437-08d58db36c72
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093D74163A96047390A2B8FFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: K8ozJ3PgnFeeMLANG7xVcyKc9mW49N93fgrXVir+2jqWCHau16F8vFyVks7YAuZ3DlzubGqEILlTP6U5ABKjNn+uKfWiNy+yiSV6/7CQH7MuAmZaZ5dm+nHiEn3MgYBatwMLPHYE3hRdhYDFuXJXdI/AtACsAmg97tqSfE1foSrkBP3a13eQai+RxPvYMwdCoHof5EQmNILRKcl7h7SYDQsesUmnOPbDhWaNaakSsU46zDSwo6N+wgnRckNsmDWBtWHLGDGMqe3sl2SGJVpHQNWxS/rc/i7ID33IjTgyLIfF4pFa4v4sR7JdHcZM+HINFm8HUY+nskACPsf/+5O+0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ae30b-6030-4a5f-c437-08d58db36c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:46.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rabin Vincent <rabinv@axis.com>

[ Upstream commit 560d388950ceda5e7c7cdef7f3d9a8ff297bbf9d ]

cifs_relock_file() can perform a down_write() on the inode's lock_sem even
though it was already performed in cifs_strict_readv().  Lockdep complains
about this.  AFAICS, there is no problem here, and lockdep just needs to be
told that this nesting is OK.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [ INFO: possible recursive locking detected ]
 4.11.0+ #20 Not tainted
 ---------------------------------------------
 cat/701 is trying to acquire lock:
  (&cifsi->lock_sem){++++.+}, at: cifs_reopen_file+0x7a7/0xc00

 but task is already holding lock:
  (&cifsi->lock_sem){++++.+}, at: cifs_strict_readv+0x177/0x310

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&cifsi->lock_sem);
   lock(&cifsi->lock_sem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by cat/701:
  #0:  (&cifsi->lock_sem){++++.+}, at: cifs_strict_readv+0x177/0x310

 stack backtrace:
 CPU: 0 PID: 701 Comm: cat Not tainted 4.11.0+ #20
 Call Trace:
  dump_stack+0x85/0xc2
  __lock_acquire+0x17dd/0x2260
  ? trace_hardirqs_on_thunk+0x1a/0x1c
  ? preempt_schedule_irq+0x6b/0x80
  lock_acquire+0xcc/0x260
  ? lock_acquire+0xcc/0x260
  ? cifs_reopen_file+0x7a7/0xc00
  down_read+0x2d/0x70
  ? cifs_reopen_file+0x7a7/0xc00
  cifs_reopen_file+0x7a7/0xc00
  ? printk+0x43/0x4b
  cifs_readpage_worker+0x327/0x8a0
  cifs_readpage+0x8c/0x2a0
  generic_file_read_iter+0x692/0xd00
  cifs_strict_readv+0x29f/0x310
  generic_file_splice_read+0x11c/0x1c0
  do_splice_to+0xa5/0xc0
  splice_direct_to_actor+0xfa/0x350
  ? generic_pipe_buf_nosteal+0x10/0x10
  do_splice_direct+0xb5/0xe0
  do_sendfile+0x278/0x3a0
  SyS_sendfile64+0xc4/0xe0
  entry_SYSCALL_64_fastpath+0x1f/0xbe

Signed-off-by: Rabin Vincent <rabinv@axis.com>
Acked-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 744be3c146f5..0141aba9eca6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -589,7 +589,7 @@ cifs_relock_file(struct cifsFileInfo *cfile)
 	struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
 	int rc =3D 0;
=20
-	down_read(&cinode->lock_sem);
+	down_read_nested(&cinode->lock_sem, SINGLE_DEPTH_NESTING);
 	if (cinode->can_cache_brlcks) {
 		/* can cache locks - no need to relock */
 		up_read(&cinode->lock_sem);
--=20
2.14.1
