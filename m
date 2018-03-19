Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478265-2-12219558604487016418
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
    t=1521478264; b=n10MH/3D+OQOxeuqPAA+Y2NsBF5aOf/eDqcW4bROIIcW/My
    vXIsblUbiY12A/QcZmwxAR6KZvP4y8pwFE+e10tyKjsB1lXXkJw79GM+LaFnfMwM
    SvXxlQmJNVqRYbP0a/TV/pLtv0bu+Y+WOwoDsGl94aVT9sq3aHbttFSTqE5Dx58F
    gwE1+yhJpwJwZhBEdN8m7+1utMKzdHdvKqRc9A4UZBNeAWI1gwCq/xdF0foqJ2BG
    QV4PgfK3xfERDUb+5VoA/eAXQNFfAyuFDC1/A5xwxAgJ2G5UCo597hfmNbJqUtXb
    +N2yUoWTL9dUXFFywKO9VdPWI7zj3JbY5G3T0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478264; bh=T64g+L
    EUfPP0yQkWZ6kpZVGMYzZ/Ja4veC7n7oGmSms=; b=ZHDljEvDhbXw0BIRp3fXMc
    1N5y0tO39/TLzSqHrJBDhlNmSTirbxq+/dgSZz4hstFcq7tsi4e6Tk9MjnJI1zF2
    EzaHlc0EzWJGQuMe3sta4k3RQGzwMrb/0v6aLh0pwMOlBiKPYGp3qK8r09WrthjV
    dxxysPM3pLXkGmKW/Emk+LbByHgwWz9SHipHAYRUNYAA0/GoEmMBL+0I+zhSrW2x
    nNhm1wTa2vXlKM2trGzBAjNHL/yI88fay1G2dO23RuZ7IV+BE7llnD1q1YpCDVJK
    LIrXD6osB+VPgCTFLMYnSeeWIRRM0dm5YKbFW6ncKPJXGJxgOcECQU0aQe3QED6Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWsfWnEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejjeeinecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWsfWnEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejjeeinecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935162AbeCSQui (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:50:38 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935161AbeCSQLu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rabin Vincent <rabinv@axis.com>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 012/102] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Topic: [PATCH AUTOSEL for 3.18 012/102] CIFS: silence lockdep splat in
 cifs_relock_file()
Thread-Index: AQHTv5z2cZ0I95BrskGOesjHlcLdYA==
Date: Mon, 19 Mar 2018 16:11:40 +0000
Message-ID: <20180319161117.17833-12-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:S5nVZBALvgOewQpQhWmAj/cdEzPOmpPTxOuh/T6jeVfIdbdXT5IpWviI48NObwEeNLhKyiIDZRBfQMsUEj9aGYmTVMWiFUinZQj/FrVOB6yRlpPeE65igx7iwP/Sorl94YamASh18+p3NXjpu2KyrxtOHXbSqyQT6L5TawPDYL7ZPhPIFJZpxzH34iS8Uer/uhBHa+nAma2TIXHB3qZwYEKnWpMRIBdG4DERgJjTM6brZsR+loV0aQ/1zlL1Fzz+;20:MPxtQKfo1YQOEdMYgp92fhU2wt0tF3thbYOsAY34LlBZJJlhQ/amDABUWsOUrl9rJMhsGS750LkdWuYE+bW3mvHlwIRsrh/JIYRN7u0h120Zlanv+rdVU/B3SL570/Rjzhox8NH/sbV/kRA/QKpYf9HsU0c+1jEQLWdkgIkxq2Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a1f4a65-e30d-4bfb-bcb8-08d58db41972
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984F2E634A032824C0BFD97FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(39060400002)(36756003)(97736004)(6116002)(6486002)(25786009)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CZoz6wGTB7L89qyjz3F2FC4XReDr1dtbDShBlSKgoweJdj30kt/pDUPeUgbQL9m7T1X3kEhaqdm2LgLmianDm8vMJJ4Sy3RDbpCSxFXAd8AuADjrZFKJgArl0GqXfOQLBppFRn2X2CW//WJ+CCTWoK2uXtuDEbFvX32FsrbKjoKu+EzAlk6Lodhlm9fSJOdAst+dKMQ8/Y/qfitm0aG8/iKSvp3nxcEoTbhAvxLHChBGXKLsT2p5DoObRcH6XGtQPEVcS2vjC5hzmo7DGPLtKI/1TuRIX8TS15ljKDzXW/eCgJPX348VIwyN7JjR5aWFENP+Gjp/XQU6vLCoLzIBiw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f4a65-e30d-4bfb-bcb8-08d58db41972
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:40.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 855ad5e6bd22..488dd62fc242 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -583,7 +583,7 @@ cifs_relock_file(struct cifsFileInfo *cfile)
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
