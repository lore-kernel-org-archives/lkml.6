Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496082-2-8017639547288453671
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
    t=1521496081; b=aWmfNvLbL0U/VFK9gHTTITeTDnQi72Fbz5hgzm1vsGMVtf4
    4g1uI6ZUByBu6128O9i9MRE9bnH/0im3KEHbdI2oghej1LFmtqoBy4ujLrSgUoqd
    QSJXFH2gBjb3pAuev0PsPctUV1NvrhgmWf1UJZS/k21MCdZ69hrqHCKxNheNlv4/
    0f5nlTvXyN/sxwMXA3y9+qY7t5MvnN4DQvrBFxWGOfcyPmcfPDzoaRvBTV+pdaAG
    QHC8xUjRFltHjUeH8SKHiVmfHkSkK56YkAI9F/ZNe7kemueW+NkJouSqE2Ns2hrW
    Czbdeo4+VBR+aRhx4RW7b51aJHIDRsU3maXrh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496081; bh=62WCR/
    CkvYFOe/o9dmCoatAMa+NzzKRS2jidV22UNzU=; b=tcBhLAECYAdcGixDQrMTKX
    NPmivWrm43Zkuc4OhKzb9bIErXOODRZGkMJzmOZR+pTPZf8GtAP/W6m1vJgWJs8p
    u7FxZeg0pDZApfVhxBmvID3Xk3bdNLQ0SO+j6KfqDE3XzRvGb+tv5SqT/jkNdvMz
    RfqPHyrkC7FjeTM2iXZzJ/0N0jj+aoUz1GvxWbCwm4ksWr85D3yghRbDobt744ON
    Oi9w0JO49FzhgCvIO1L0s+W9KiVcWljiaxXNhTLfJgGH3moRswdWoFsWBGBcH0tJ
    +dUuZmKi3P+5Yv3yXXbGnVWzVBgTUPab8CogNEygJiuW/CcAnpNBceI+jdmmR7kg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MmbUBAwn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelieelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MmbUBAwn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeelieelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeCSVrR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:47:17 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:6596
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934753AbeCSP6S (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:18 -0400
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
Subject: [PATCH AUTOSEL for 4.9 022/281] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Topic: [PATCH AUTOSEL for 4.9 022/281] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Thread-Index: AQHTv5sYD4JpEQ98XUeYudaOqrB6Qw==
Date: Mon, 19 Mar 2018 15:58:16 +0000
Message-ID: <20180319155742.13731-22-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:ohK8rp2MgAnMjrsEiSQg+UjQpQru2jR1DFIc24hVZYTL6hUIONJLQtqbQ/wNu4gWWSbA2rd+FErYWnJvA7AYMbZ045GmXVpr5/i+Ts15Iz5Rp2QQ8Tg6GeCIWTfcXTngy5ZTpmMqno7q6tCzsZzUV3XQywK5d1po8eDWr0Z6UWu7DMyq0FNA1kaGg3IyCP33dp2bhT6+3hp9hZxoVEb+mWspeqewXOapdmYQiVisgd7OBxil24eDeIRbPrBM628v;20:QeUfAO9G0quzgfhJ1Gcvt3HXUnIgmR5lpO1IHqxsn9ivmM9qP0+WJirz2rhvjX/YW3P5/pKPuBLvLLLmk83B9NjqrBoggM0v5VBXWlgNx9lcquwC4/Q4G+WAWYBPaIdUB07EgxiN/luDoG9nBFkjocH1XEiM1bdr9TVgc+6NFnQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96f3e8b6-8894-4b95-2ec8-08d58db23aaa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933DE99194701366750EE82FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(230824228335337)(28532068793085)(89211679590171)(42068640409301)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(7416002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: O+1K180klbXWzDBtDZ9ApYIMcjGvbWHRc10fQCcFCD2KrxN5pZ4hbtSq31ah2p4S2VwEgXWft3ylMaPpx7RfnmMgAGbgQW01dCwW52RmnYAerLdb5xUN7VDaZNhgqBhvMclkaDOJNVAKeItLHd0SRUYkBnLzRQmi0+i5+sWb4I74rWLPiyJvu2nuNGrGkgXL5io83S1usrVXsfmr+Zym2fXxcCjg30FbKjc0me1L/mj0ZjLzK+3v8EfgTVZCXag2carXfdpLi2AlT7waYbJFdXZhs9+cGJwrwLdDyWiUgvToMFDiO7PBMvIOMOboZ5bYPKlgVOdXKxACG9CeI2ly/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f3e8b6-8894-4b95-2ec8-08d58db23aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:16.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 693a64385d59..fa704f88ff8e 100644
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
