Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495988-2-13854359239018298105
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
    t=1521495987; b=Slfs1wn6slciKpMCQvtlEQyIHdLcKF4J1+elWthyfJDwLbj
    OiogwH1qjOXnXP1WX1FomV6GsF1IjJ0B1XnkNmxTAfwy47jx9H0Frz4Ndz7jlDJY
    K3AjZLrbzpqfEc35QzLiCIcKRSbSNrT0GsnMRnA1DCiZTYRx7HuL1Lk38IfWgBfM
    TUbt6bV32dNsHEVh3iHKdsKnQzQ5jqQG0Wiomedfk8t9f9+sFJ5cpD0pja0mbptk
    NlXCMjwH58kmDF+VY4jCmMfF9uJBZhibjo7f+Ob/8cf4lO4wHQcpC18FJw2tk9H4
    b9eOeRyGU9DrNTsnKyidnEeIGRUtaDsTZ7dFAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495987; bh=6/qFMd
    HPKaatDCXW+3/0ejeD+ev0e6pycYc4tyq2CNs=; b=nJHhZVDK+VpM/JHnzp49IG
    3qWCy1/PuSwYBthbJlM4pcBAcd+EIdz9k4yX1exhW9ZmeUp718c9ctJEhNISCRbM
    I7N6l9laU73k7bpeTY6jWQqpCJ9y+CWWX168F5oUekM/rDz6PHAwXUV/mt6DBu29
    CggRoJbqSc5zTcVF/ONNnGDEQjFvNgc5AHqOHW/tplggktfENu7+2J4IWWcMGy9w
    vW62UJj/gVaV5bLAyNJxwfPLV2iduRx3TEcmAd10/D+mVD0AFwnKj5LFzIkdFXvt
    R3Egywt4ERb4IiHXpVfpPKdIB9Gh1cxbDjrbVWuaOFvWXUcdWMG6EFogQN+s/4lA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AKHeE5Ew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeejfeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AKHeE5Ew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeejfeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964859AbeCSVpx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:45:53 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:28722
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964923AbeCSP6Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rabin Vincent <rabinv@axis.com>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 027/281] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Topic: [PATCH AUTOSEL for 4.9 027/281] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Index: AQHTv5sbzGS52Zy3OEGrmGq5jd0dOQ==
Date: Mon, 19 Mar 2018 15:58:22 +0000
Message-ID: <20180319155742.13731-27-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:1h8pr4BbO2X9+F6fdQusn5nbG3Q1BpJmrcaGWhOh/Qnt5cQqNp1X0vX7cu/2bnmHrwrKgJ9PZF8y2rXWfewA6K1fU3oBq1G7UJvlkupDCcgJd6/lKl+nWyn0m+0P00mEabshjFLWkoJ06f8Xpjyp9BYujSJvK/UVXAJDIpi3GBhFCg1O3CWTBcU2DPtgRH2mHJqnWTrXcLZP3m4RJ9jr+EKtSnfqUeAGEcNnLP9yZn4niEPi/FESkrYzl8ByIw5P;20:k73Xhjr4ZPVNHlJTirFHKQaECRog6S9g3RHDB0/OQgie6k0yKLD/lFmm0X2N0+1FvhW60DUzQYHqT8kxPiBxMfx6ccc33a9++QXODu7weLZjxIHm+rRnPaphvcxWwqq9mNdlFpRRrMHy06kVUetSSk72Vbq0PhPQpzc2geyiOOg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4be39043-8221-4c83-dc3e-08d58db23e12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015E3325DC06C2261EEFD21FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KhUo2pSK1focaRBH2yQYUQyBxZdeGfyEvP/TOC0fGZbnlwBoMzO8vqac/g67f0+q98tPodmcYVAppdMruBKQ85UgOzlOiT8eNAf312xa2whsgfC5TUAQZLAIkXX+mYXxyYJhcqZcdUPiZi+fuKQHfrEFYe9vkZI/AWErPTwpMyWxArZcwV91L/FDzXNnEa4ro9cZGeGVQM6Hn1XqrDgoaCs2sj9URJ0tN5z0wVIThn17RuBimDA/RLyqvYzCiQFOtI4vQWXHAbpyrBtRGDiaegqx7QvkGHquqVk5h1QH+pHxzHK5W1N7w+QwUNm8Tj5h0DgCdLCXucPx7GgzKE9c9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be39043-8221-4c83-dc3e-08d58db23e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:22.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 02e403af9518..49eeed25f200 100644
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
