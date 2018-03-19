Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475634-2-5918544114238046532
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
    t=1521475633; b=GKmFscA60FB87OZNpgQrwyZOa8cvvwno12cfTcqjMUs7Hf0
    6iqMs2bGE1c9vG7iDg2FSJfpcPvdg72Kq50MOycsFFzm0OIwuuu/KP6IAd8SzUFE
    e3K8Z5lSE8tI+TjN1+4pDpbpEnK1cBSUCbiNjyKB3BoYpBVrqUz/iHSXYpDLO1Rx
    Qw0Lr1WPERkWY0TdoQL/mn2JX4BlTQLkWdYblm6YNxFWPQn+p+Dygi3jUxdOxZOM
    kP2c+CecdvhvTcc9Y+xLY9UZID5nZ8AzqjWnqf91bxAuj+wgDkkQUtboL3J7BL1l
    Sw63hSlGavp7u6DLK2TWZuZY7WFatsd5HTp72MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475633; bh=ca6b7B
    vX9JKkBnIeHyH8ugqpK5cnChcIb2Ll4ccm/C0=; b=baGvZHXYK7O33GD/1WK4UF
    aGoutNjmmcdi0zme66bRd/Pj1g40jxJ0tWew32kOZw3LHdeQMMdwaSVIHHV4HrFL
    PwnY4nyf47dUwHZvlRP6uYUxuHEPP4nzI9IrppHvx56IZpwPgmBJUM0I61hYA2Sp
    l6st7HA+VFllMNETyUkRzHDr3u5pC3airQiio/ZG4GI5T7Mzcm2n6GKs5ci23ABi
    8DYedh256M723RFTjDkM+J+UnpS4bL5jjcqgxXLsgzfmaGvzudqFBPzIG4EOKhEc
    0GKHp4xrASIhzKmakZO+bRUfP8FBHskN5L8ZD4TVm0ZD9oz6FTXv1JGl5T7iwRrw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jVxnFnes x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleejudenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jVxnFnes x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleejudenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966055AbeCSQHC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:02 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966065AbeCSQGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:50 -0400
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
Subject: [PATCH AUTOSEL for 4.4 016/167] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Topic: [PATCH AUTOSEL for 4.4 016/167] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Index: AQHTv5whIYVhVopSOkGIfL7hAX/InA==
Date: Mon, 19 Mar 2018 16:05:41 +0000
Message-ID: <20180319160513.16384-16-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:3ncTj/KZBe9rl9XOsCV69/4jdXxvFvKAmMxF4DbJUdb/XxE3fEHVfNhA4kz/Op577yyc9j0EBx/jx9+7ZlPo/cSKgMzXSDk2huBsxzUcXyPDnXXxRwduoRCmdm7JmrlMhlkQ5vphj0Tdn2xHjXLZSSsMCoZB6V5UxW0R7ekurGZwUnmZbh4FcNp11VS7Ni7Yu4WUT8EcIi1o64WUCIsOyj50xz1FhXN8sKXpHOeziJp/Zj7sE0OFaau1LaO85AcD;20:GwY2/QMbxibNYdLwrbG7IrCQNHtAOo2EZ8efZKYUcJv3xq0lEwBDxbITtofE0q7tDHKCTHrsMI4PuvD8OYmA+9EBk+PxHmTXZT9LO5pTVvIulx9nSV/A2Ur0al4YScTRSltvEflYQ8s5ixQBSZx1tb7PeX9S7xJOGhSl6zXEjEs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 256c58ad-4d8d-41fb-365e-08d58db36b05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10938DD468356EDAAE94984FFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(230824228335337)(28532068793085)(89211679590171)(42068640409301)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(966005)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(6306002)(8676002)(3846002)(3280700002)(6116002)(7416002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: cHIpSHExcMYCXg271ID6xJZqH0WjCCw+Rrw2xJ4XnSlbbMtSzsGXYK70qTUz1wYs1kgqRq3U5VGOmT20ne9z7FigOrd46bl4B7RtuoOTcgWqij3mK0nrthUUDFcRMgm0N/iJYZPCHlU77WMKimK0LOevwPiqSNZrD63ds3Gqe2b1cSRJnXc1vlrI5QCnNTGg8WlbUqZT3P9OHbvaactI+ef4nNqRzPPrq7eRmt9Mp1lxVRgkNtd43x5o35rAI8cCRAucd6pwYtjnlNmgTjZWwNHrpiQXw3uH0ABi+D9m1yBAEpOcnQgsABcSMSKzr0Ghw9jANinB3xrocelwUzvqWA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256c58ad-4d8d-41fb-365e-08d58db36b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:41.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
index b17263be9082..5fe7cdb6d05f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -322,8 +322,10 @@ struct pid *alloc_pid(struct pid_namespace *ns)
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
