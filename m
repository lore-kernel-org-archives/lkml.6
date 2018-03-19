Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478170-2-8398467794146140618
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
    t=1521478170; b=nEhb5ztvWajPdTa6jRcolMBFOyzH33XTVvqx+PXn6OFli59
    DcBSl5rFdI1+B82XSa/jojrLR3b5CTg6VW4PjNv7CAYA0QfrZZdnBfUenQwApzri
    hVgweT+vHLsH+yDrCNffJHD0oQuL9jlk9pVuhj1lXM/ZJDb4wdPk4SPydQfF09Gf
    Iq+hz9zG5qlhCfXZt8uzsndrw3TafQisgq+HGRgKQb7Unw3i/ccWn5VikMjxK5Gc
    09nIV8BQ6N93JkT8uqxIq7gt/sbEVS8VhV0+jdpA9L/1jl8+yRRkPWgNJW3QrYzY
    sZkAlfteM5VMzfI8/6d2eAj7I4gycN14XvvMdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478170; bh=jeR/dE
    +PlerTiyKPFtvbeTEn0q7fjcVT2xN3bhVFYK8=; b=II2QqrJPfqE5+nKKIT4UMc
    eTSjEZvLBdRaKA/0ERTgjTeWqQPP0vcR8LLS5njLbKUTejVtRtbT/xg2rZIpFNPB
    wXk0iuMZE8Zrvmdk6elhduvy7p80alkAv5Hs/Z6eEl47GC4XCjXKOkG5Cfoqcw1U
    3z2agxofHGWlgptagBvLcjp2tlptIR6K5GHAZaoN4NmsJgHVtzm3F23Uj5hWQE6V
    yl9x0c5pqUcECbfx8+7JFvWeU5tZD5LgfvW4PQrBOv2aDx2JemnwxiyTGO5aZtrR
    Vh+C9Re3GXQkWLbiXZvU/L5WhHiZIKNNNYLG5ap2Jitbh46CO2rcXp2rWwBHDgdA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C+dfvrmZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeiudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C+dfvrmZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeiudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967481AbeCSQtY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:49:24 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:3838
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935182AbeCSQLw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 009/102] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Topic: [PATCH AUTOSEL for 3.18 009/102] pidns: disable pid allocation
 if pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Index: AQHTv5z0toHMCxEFIUaKYMOlBEMbrg==
Date: Mon, 19 Mar 2018 16:11:35 +0000
Message-ID: <20180319161117.17833-9-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:JGhJMeNGTp4YB34qg1mMkGUF0PjqnOmuPEJ8JWMnjeInTe40musuPJ2UHEL8Y4zB9GmxnL5Yf9qqe6dxne8/tpfR1BwkCpp/XseqiIQkxPO8xbWNfQUWyW3N42DkzZTxQHThfEG9JHnpdmtxWJX6mWXGRYrd9pXnETHtFokp75zxYW2Sxcq3rVjS11VjHYBc9L+gimOxnqPgSDktotyaU25siJMIrTo6z6ohpEIHuXxHdo4wwveW1G62cpn1j8fp;20:BzAfT9VESFbbQXMi/URFtcY6sYdRXStRCCbTz/GTVwc5DGp5Kgm+QWlM69UMs6q47aOV78GrxhKGUAqHQUvz0q1tSRDkhL+f21YnCkneVHrF/EPsOtY3ZEu1DZFsME4zgHrv8tZ+kyJtFPLfL72x3MiQ9B2/QFI9kpUMhZGuN7Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2046808-8176-44b2-de49-08d58db416dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080549938AF97EE76C586752FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(230824228335337)(28532068793085)(89211679590171)(42068640409301)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(7416002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(966005)(316002)(54906003)(4326008)(6306002)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eIzrfeyNMEIbpjytoj04BNTlQl7xTRQ3rfZ1DG4vFXGuUwhX/RrxgeIoo0ZYjvLsb5WDUnWC6DugGbUHsjwMKR+oQ8TLm8wGGHqjwA86q4EFN3fb0pnyPR1eiY0JDjUf8M14gn10kegAhCWeDk7IseI/Y+oruiTo1WEdjlAF3tSw/UOakJVk+S8yAfyzPUN2nJ/jxb6SmO9nZd7f50I4v3ckmJJ1fhpqAOSNQPO6j/x28X15HSAQjF+AS5ng5wlF+Ve93SkueMVGeVfmFnNpaeXyiMbtpJRl6j8fEbVR6f0Y+q7bmMsC5orpEV8esUQ7QZp4SBc40/ETn9oMHFujMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2046808-8176-44b2-de49-08d58db416dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:35.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 8896c23d2ef803f1883fea73117a435925c2b4c4 ]

alloc_pidmap() advances pid_namespace::last_pid.  When first pid
allocation fails, then next created process will have pid 2 and
pid_ns_prepare_proc() won't be called.  So, pid_namespace::proc_mnt will
never be initialized (not to mention that there won't be a child
reaper).

I saw crash stack of such case on kernel 3.10:

    BUG: unable to handle kernel NULL pointer dereference at (null)
    IP: proc_flush_task+0x8f/0x1b0
    Call Trace:
        release_task+0x3f/0x490
        wait_consider_task.part.10+0x7ff/0xb00
        do_wait+0x11f/0x280
        SyS_wait4+0x7d/0x110

We may fix this by restore of last_pid in 0 or by prohibiting of futher
allocations.  Since there was a similar issue in Oleg Nesterov's commit
314a8ad0f18a ("pidns: fix free_pid() to handle the first fork failure").
and it was fixed via prohibiting allocation, let's follow this way, and
do the same.

Link: http://lkml.kernel.org/r/149201021004.4863.6762095011554287922.stgit@=
localhost.localdomain
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Kerrisk <mtk.manpages@googlemail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/pid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 65a386e24811..50ad2e5b2963 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -316,8 +316,10 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	}
=20
 	if (unlikely(is_child_reaper(pid))) {
-		if (pid_ns_prepare_proc(ns))
+		if (pid_ns_prepare_proc(ns)) {
+			disable_pid_allocation(ns);
 			goto out_free;
+		}
 	}
=20
 	get_pid_ns(ns);
--=20
2.14.1
