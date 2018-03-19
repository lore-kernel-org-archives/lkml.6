Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494403-2-6104952529970215908
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
    t=1521494402; b=h9x5iUWdS2YZxynnrT9olLXrcQi7h8jch6u1U5tXppBEXSp
    lp5hk/9E5/QUERnJGH7NVwmC33Dv8VQeorvHMjZZSpOLQn5JBi6ISew+mz4TfI8Y
    uPBFdcJZkwJFaeOcNULVwwD6JF7Hiy7sNQoeMfOAhDGdnjYk8mnzFwbtSYOLD20S
    2W7HO67n/I6r3xg0rHNkyOk5cCBhKWIJcN4jm9hY2iU7cngDmHPK1zPmNRlVHm52
    tAqgX5oz5U/ZiFwqe1MP82gm3lzQFDBKv+a0QOEJuQUWre6Hxt1mywfsPmW01Bw8
    htbLNEc/3WjNIFYZB65HHu79Xzf+q4nPd9ZAEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494402; bh=ESEmVc
    YWMrEZwY1E1LWwaTy9i2QND+nIfz5ZO4ocUOU=; b=JGDaeC4lNwRJyYit15Nv2N
    P4X0/t0qYbp3oedOzXnEWwZWZ4wZOsUKX+Gig7waDnzsAKET9DDHWpdDXsHOPAHF
    bM6h4p7j9QVxzrrqWgdCUnsejdvIjVCfhtpt0kC73Y2RPxGFMpQQNiWDiKvVduzV
    +q4QjGnOUg6Ib18txYNrwVO6/awmdNhMRVPTChghCmT8TH/jMZx/IkvZ2Ym0ujl/
    CKijO6D6yMC5dXoYqMeNmG34KkU0Ty9HKLRRo3bO9BodoBjrYxuByzlvl1I63LMy
    nI9pJxtb2gEhK6lP5SyHac7sdEJyj7E7Wy7P2NSJPyF/6FRy9dddqxztGNR3cluw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GTOcMvA/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefleeludenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GTOcMvA/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefleeludenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeCSVTh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:19:37 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:44079
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934906AbeCSQA4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yao Jin <yao.jin@linux.intel.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 102/281] perf report: Fix off-by-one for
 non-activation frames
Thread-Topic: [PATCH AUTOSEL for 4.9 102/281] perf report: Fix off-by-one for
 non-activation frames
Thread-Index: AQHTv5tSmeKvxBcV7EytYJc7NVnWnQ==
Date: Mon, 19 Mar 2018 15:59:54 +0000
Message-ID: <20180319155742.13731-102-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:eEZH4c8txOkNTraf4YX5d0K4Qi0QCvuKlwl5fgxA/ctSb+mJEDi5MYWswMStCYhd7ZXp4cGTByf1Pr0sUP8oLQh1fyT/P4AdHXlyJjuHiXUUZA9XYewpWOqzMSqjHigQYYQEaXoHqBUb3hWe9Q8LB3CT2LYBAjkB1HJQZqqAsHrpCS8ifPcl3DJp2g+UrYLTxsqKIlhbenn76qq/ZnvoP08NQpDnQfeqh0UxCFjEL6anrMiHmypccT0/DwRrBJdC;20:PmqfDMC6eIpHg0C6LptOQaiPKBg0b49L2RHolIfUQUUd38FdaGWj35ewMm2YqMdPb6ubm2+cZ/OV/UqPX0O324V0eyz48l72/tE0nUNr4n64J6Y2/7AvuhOny+lt/aCXCXLzynxQShkjkaPiVt0wd1A7nk+kp6SekaJ1mRSFg7A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80e32460-554c-4429-08de-08d58db2933e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031F209B81B02AC8AD68BE6FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(288314003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(966005)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(7416002)(1076002)(81156014)(6486002)(81166006)(6306002)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: N8LgNrAbptCEWM6O6jTyj688gqgGkVhh5LLBg2LH2THCKSg3ebrjsZ+gdP96ReyntrSYUzXttBhAIzpBSaTOJomUhwmIdeW9NcV2LLtaSABuRduoA4TteS4LACsStsQtal6ZUN9vjExEEoy4/YRr5POFbsftokijCHESB2XcOYTjozTGvJXH+VU5tppWnFAMsSVv9ZLVcvm9MR64JHKnDfnKIakIR/wNKrG3Ryr80TMmFHOptgzroTeCpmDuuFb5+71Vn1IRGhFgxv2V/PGZK5HMVOa0607ooJMWeBwpG4BxdlZtlEtGMgjBjc8YAuCK4XEDReARJ9tGYN4iK1d0Vg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e32460-554c-4429-08de-08d58db2933e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:54.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Milian Wolff <milian.wolff@kdab.com>

[ Upstream commit 1982ad48fc82c284a5cc55697a012d3357e84d01 ]

As the documentation for dwfl_frame_pc says, frames that
are no activation frames need to have their program counter
decremented by one to properly find the function of the caller.

This fixes many cases where perf report currently attributes
the cost to the next line. I.e. I have code like this:

~~~~~~~~~~~~~~~
  #include <thread>
  #include <chrono>

  using namespace std;

  int main()
  {
    this_thread::sleep_for(chrono::milliseconds(1000));
    this_thread::sleep_for(chrono::milliseconds(100));
    this_thread::sleep_for(chrono::milliseconds(10));

    return 0;
  }
~~~~~~~~~~~~~~~

Now compile and record it:

~~~~~~~~~~~~~~~
  g++ -std=3Dc++11 -g -O2 test.cpp
  echo 1 | sudo tee /proc/sys/kernel/sched_schedstats
  perf record \
    --event sched:sched_stat_sleep \
    --event sched:sched_process_exit \
    --event sched:sched_switch --call-graph=3Ddwarf \
    --output perf.data.raw \
    ./a.out
  echo 0 | sudo tee /proc/sys/kernel/sched_schedstats
  perf inject --sched-stat --input perf.data.raw --output perf.data
~~~~~~~~~~~~~~~

Before this patch, the report clearly shows the off-by-one issue.
Most notably, the last sleep invocation is incorrectly attributed
to the "return 0;" line:

~~~~~~~~~~~~~~~
  Overhead  Source:Line
  ........  ...........

   100.00%  core.c:0
            |
            ---__schedule core.c:0
               schedule
               do_nanosleep hrtimer.c:0
               hrtimer_nanosleep
               sys_nanosleep
               entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
               __nanosleep_nocancel .:0
               std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > th=
read:323
               |
               |--90.08%--main test.cpp:9
               |          __libc_start_main
               |          _start
               |
               |--9.01%--main test.cpp:10
               |          __libc_start_main
               |          _start
               |
                --0.91%--main test.cpp:13
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~

With this patch here applied, the issue is fixed. The report becomes
much more usable:

~~~~~~~~~~~~~~~
  Overhead  Source:Line
  ........  ...........

   100.00%  core.c:0
            |
            ---__schedule core.c:0
               schedule
               do_nanosleep hrtimer.c:0
               hrtimer_nanosleep
               sys_nanosleep
               entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
               __nanosleep_nocancel .:0
               std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > th=
read:323
               |
               |--90.08%--main test.cpp:8
               |          __libc_start_main
               |          _start
               |
               |--9.01%--main test.cpp:9
               |          __libc_start_main
               |          _start
               |
                --0.91%--main test.cpp:10
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~

Similarly it works for signal frames:

~~~~~~~~~~~~~~~
  __noinline void bar(void)
  {
    volatile long cnt =3D 0;

    for (cnt =3D 0; cnt < 100000000; cnt++);
  }

  __noinline void foo(void)
  {
    bar();
  }

  void sig_handler(int sig)
  {
    foo();
  }

  int main(void)
  {
    signal(SIGUSR1, sig_handler);
    raise(SIGUSR1);

    foo();
    return 0;
  }
~~~~~~~~~~~~~~~~

Before, the report wrongly points to `signal.c:29` after raise():

~~~~~~~~~~~~~~~~
  $ perf report --stdio --no-children -g srcline -s srcline
  ...
   100.00%  signal.c:11
            |
            ---bar signal.c:11
               |
               |--50.49%--main signal.c:29
               |          __libc_start_main
               |          _start
               |
                --49.51%--0x33a8f
                          raise .:0
                          main signal.c:29
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~~

With this patch in, the issue is fixed and we instead get:

~~~~~~~~~~~~~~~~
   100.00%  signal   signal            [.] bar
            |
            ---bar signal.c:11
               |
               |--50.49%--main signal.c:29
               |          __libc_start_main
               |          _start
               |
                --49.51%--0x33a8f
                          raise .:0
                          main signal.c:27
                          __libc_start_main
                          _start
~~~~~~~~~~~~~~~~

Note how this patch fixes this issue for both unwinding methods, i.e.
both dwfl and libunwind. The former case is straight-forward thanks
to dwfl_frame_pc(). For libunwind, we replace the functionality via
unw_is_signal_frame() for any but the very first frame.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170524062129.32529-4-namhyung@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/unwind-libdw.c           |  6 +++++-
 tools/perf/util/unwind-libunwind-local.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.=
c
index 783a53fb7a4e..7c4defce0115 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -167,12 +167,16 @@ frame_callback(Dwfl_Frame *state, void *arg)
 {
 	struct unwind_info *ui =3D arg;
 	Dwarf_Addr pc;
+	bool isactivation;
=20
-	if (!dwfl_frame_pc(state, &pc, NULL)) {
+	if (!dwfl_frame_pc(state, &pc, &isactivation)) {
 		pr_err("%s", dwfl_errmsg(-1));
 		return DWARF_CB_ABORT;
 	}
=20
+	if (!isactivation)
+		--pc;
+
 	return entry(pc, ui) || !(--ui->max_stack) ?
 	       DWARF_CB_ABORT : DWARF_CB_OK;
 }
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unw=
ind-libunwind-local.c
index 20c2e5743903..120383494ff2 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -646,6 +646,17 @@ static int get_entries(struct unwind_info *ui, unwind_=
entry_cb_t cb,
=20
 		while (!ret && (unw_step(&c) > 0) && i < max_stack) {
 			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
+
+			/*
+			 * Decrement the IP for any non-activation frames.
+			 * this is required to properly find the srcline
+			 * for caller frames.
+			 * See also the documentation for dwfl_frame_pc(),
+			 * which this code tries to replicate.
+			 */
+			if (unw_is_signal_frame(&c) <=3D 0)
+				--ips[i];
+
 			++i;
 		}
=20
--=20
2.14.1
