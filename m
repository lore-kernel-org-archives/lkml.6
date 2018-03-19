Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499298-5-16591822717446687594
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
    t=1521499298; b=WlefmVJZrCHuvMfIsUyOfcWmHUZWeo5B03C0ww0S1dmxh/0
    MJvwp4vazjZXCzqkOcUGnbi6RP/qyjsttBeOagMSzdtOCnPcdkrPXA6+OpfrQa80
    saLyRAeUMRdKxUVJIpMdT+VfAOLd5LA7Wu9uBrWXGntcWeNMdCvqYGzLONNPhrtn
    yj9HwVqy9nWrbnHQQaky6Cxwj+dil8y3UJ5LcFsA2HZH3TRIH0JfxnbqjQ1zvoVt
    r6zvW9/u4WIw3NtM2NSXS9aBKAPkROopAZCgxbmrGFQKmHga0OmsKOaz0AVv980l
    Hpt9F428+ThfGbvnQRz9s60j+sSgUGwz5Ox4a8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499298; bh=fyYNte
    WC4K53uOydFeFCzwe2OtiCFm3+5spZrAHnitE=; b=EeFLyRfCTDgff4Sc/anx63
    QQI2iHB0/oW4pPJLib9rikArtRhact4R1DfS4/I9p5O/3qO4saCmZHKrmRgIdAhK
    /kbD0EYaPegw+8snFcNJXJY1BYDUVjV5wSW8tQw8sia+tHlcte+xxsKhrlb2Y89n
    OmPshHsIxLaO9nWYMpLNyLiJYIkyKDoXEiq89/jRvLLlxKl+wkPLXQ7qgZD9WBVl
    QPrR9NeXM/Perm3SnQyNNIJJ6MR7K8xu+n70f5cyJIiLlcbhXK4Jko3ZeIRhyz1+
    Lo5eHc0/fr6EKqN1EIWUZ3SSbNf7qkJHfKlZHkVh7yHbEZ4/v884xMIctcgOu11g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mvm9jMi5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeljeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mvm9jMi5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeljeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeCSWlQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:41:16 -0400
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com ([104.47.37.128]:6976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932767AbeCSPrS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mengting Zhang <zhangmengting@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 012/124] perf evsel: Enable
 ignore_missing_thread for pid option
Thread-Topic: [PATCH AUTOSEL for 4.15 012/124] perf evsel: Enable
 ignore_missing_thread for pid option
Thread-Index: AQHTv5mKcROkR4eFPEmkdYp0hH0qPQ==
Date: Mon, 19 Mar 2018 15:47:10 +0000
Message-ID: <20180319154645.11350-12-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:PXA7XzhRynRq6g4w2Uw5Dfr1FWpH7MPlODHGnmaq87IyM4yDTXm41Ds8IwrqOfvgBCQLM3WiFDQC/fGdULnUy/mnXDQkUS4hNHHYWcv71/diOOV9mLS4EZ3P8WRDAfxzmUhN5Eiw/Ky08Qq+d99a0ZAeKq/n4vCF2+h3+TQAL5Sxpb47KySWxwLw4zfhTQVIyC1Xe0f0c8SJnT/STSoH4Xgm6dJE6pCXoXH/AO+y5joJHftAaGPOc+wUwMWD//FW;20:YLYXr3KDIGYaTTBSr4RGtSVQlmUyjEqilY1SE2C8R3lPWGi0F7o1OBYe15NV7KokC2DP/J6EOYB+zroRgbMwi803g7zMmEP7LpmBKp6/EsEofBeGbxfdnNRkURTG5oZSE8bCtMWxpaPmDSqjPa1wiH93uhiNeTky9EuS0ekLQks=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe3aed4c-998d-4eed-e643-08d58db0adee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013A03F41190388D5B5EE7AFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(72170088055959)(89211679590171)(50582790962513)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(966005)(86362001)(575784001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6306002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ByUiCcJid1n6DUs8HAMDEhCqdUVl+xmTY72lI2aZ8nPmPxP5bPNh9zaAe8EwLqfjhp2yaVJqbj/RdT0tVmVAAcnP6kEN8QMgBv0GtgjYJys7Q9ZgKo4JXoGS50omu9WVPPtcTVVvdpePxYcBIpG9NA0jPwu+D7dx90pD2CD4P0z/H5kWFs8tKW09hXLKwLeKVVwJkLHajDhXeYcVdVykRmXum+r08akXhIXW3xI4nJS5Noj4c7AAwkWTFClBQUjOj4xFrRjB5/ssZly+B2CsGyimmZCKcOH96bNn6GoQBe8W4L/o2yCol9xwtGQWJbqRJ8VQlW0pJ+3kmSS03WDT1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3aed4c-998d-4eed-e643-08d58db0adee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:10.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mengting Zhang <zhangmengting@huawei.com>

[ Upstream commit ca8000684ec4e66f965e1f9547a3c6cb834154ca ]

While monitoring a multithread process with pid option, perf sometimes
may return sys_perf_event_open failure with 3(No such process) if any of
the process's threads die before we open the event. However, we want
perf continue monitoring the remaining threads and do not exit with
error.

Here, the patch enables perf_evsel::ignore_missing_thread for -p option
to ignore complete failure if any of threads die before we open the event.
But it may still return sys_perf_event_open failure with 22(Invalid) if we
monitors several event groups.

        sys_perf_event_open: pid 28960  cpu 40  group_fd 118202  flags 0x8
        sys_perf_event_open: pid 28961  cpu 40  group_fd 118203  flags 0x8
        WARNING: Ignored open failure for pid 28962
        sys_perf_event_open: pid 28962  cpu 40  group_fd [118203]  flags 0x=
8
        sys_perf_event_open failed, error -22

That is because when we ignore a missing thread, we change the thread_idx
without dealing with its fds, FD(evsel, cpu, thread). Then get_group_fd()
may return a wrong group_fd for the next thread and sys_perf_event_open()
return with 22.

        sys_perf_event_open(){
           ...
           if (group_fd !=3D -1)
               perf_fget_light()//to get corresponding group_leader by grou=
p_fd
           ...
           if (group_leader)
              if (group_leader->ctx->task !=3D ctx->task)//should on the sa=
me task
                   goto err_context
           ...
        }

This patch also fixes this bug by introducing perf_evsel__remove_fd() and
update_fds to allow removing fds for the missing thread.

Changes since v1:
- Change group_fd__remove() into a more genetic way without changing code l=
ogic
- Remove redundant condition

Changes since v2:
- Use a proper function name and add some comment.
- Multiline comment style fixes.

Committer testing:

Before this patch the recently added 'perf stat --per-thread' for system
wide counting would race while enumerating all threads using /proc:

  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]#

When, say, the kernel was being built, so lots of shortlived threads,
after this patch this doesn't happen.

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Cheng Jian <cj.chengjian@huawei.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1513148513-6974-1-git-send-email-zhangmengti=
ng@huawei.com
[ Remove one use 'evlist' alias variable ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-record.c |  4 ++--
 tools/perf/util/evsel.c     | 47 +++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 003255910c05..36b6213884b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1781,8 +1781,8 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
=20
-	/* Enable ignoring missing threads when -u option is defined. */
-	rec->opts.ignore_missing_thread =3D rec->opts.target.uid !=3D UINT_MAX;
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	rec->opts.ignore_missing_thread =3D rec->opts.target.uid !=3D UINT_MAX ||=
 rec->opts.target.pid;
=20
 	err =3D -ENOMEM;
 	if (perf_evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 111b924f0a17..242d345beda4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1597,10 +1597,46 @@ static int __open_attr__fprintf(FILE *fp, const cha=
r *name, const char *val,
 	return fprintf(fp, "  %-32s %s\n", name, val);
 }
=20
+static void perf_evsel__remove_fd(struct perf_evsel *pos,
+				  int nr_cpus, int nr_threads,
+				  int thread_idx)
+{
+	for (int cpu =3D 0; cpu < nr_cpus; cpu++)
+		for (int thread =3D thread_idx; thread < nr_threads - 1; thread++)
+			FD(pos, cpu, thread) =3D FD(pos, cpu, thread + 1);
+}
+
+static int update_fds(struct perf_evsel *evsel,
+		      int nr_cpus, int cpu_idx,
+		      int nr_threads, int thread_idx)
+{
+	struct perf_evsel *pos;
+
+	if (cpu_idx >=3D nr_cpus || thread_idx >=3D nr_threads)
+		return -EINVAL;
+
+	evlist__for_each_entry(evsel->evlist, pos) {
+		nr_cpus =3D pos !=3D evsel ? nr_cpus : cpu_idx;
+
+		perf_evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
+
+		/*
+		 * Since fds for next evsel has not been created,
+		 * there is no need to iterate whole event list.
+		 */
+		if (pos =3D=3D evsel)
+			break;
+	}
+	return 0;
+}
+
 static bool ignore_missing_thread(struct perf_evsel *evsel,
+				  int nr_cpus, int cpu,
 				  struct thread_map *threads,
 				  int thread, int err)
 {
+	pid_t ignore_pid =3D thread_map__pid(threads, thread);
+
 	if (!evsel->ignore_missing_thread)
 		return false;
=20
@@ -1616,11 +1652,18 @@ static bool ignore_missing_thread(struct perf_evsel=
 *evsel,
 	if (threads->nr =3D=3D 1)
 		return false;
=20
+	/*
+	 * We should remove fd for missing_thread first
+	 * because thread_map__remove() will decrease threads->nr.
+	 */
+	if (update_fds(evsel, nr_cpus, cpu, threads->nr, thread))
+		return false;
+
 	if (thread_map__remove(threads, thread))
 		return false;
=20
 	pr_warning("WARNING: Ignored open failure for pid %d\n",
-		   thread_map__pid(threads, thread));
+		   ignore_pid);
 	return true;
 }
=20
@@ -1725,7 +1768,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct=
 cpu_map *cpus,
 			if (fd < 0) {
 				err =3D -errno;
=20
-				if (ignore_missing_thread(evsel, threads, thread, err)) {
+				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err))=
 {
 					/*
 					 * We just removed 1 thread, so take a step
 					 * back on thread index and lower the upper
--=20
2.14.1
