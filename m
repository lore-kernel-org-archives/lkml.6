Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490866-2-14539392703280604357
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
    t=1520490865; b=V5hvVc2KEaw6yHRHqH+W+zYpqAR4x1a1F9rPizBsQ0WKpPT
    wEhn/uFKtx6uCJWX5ZJt3jkzvAOsosSJxWcd1e4wMX7yvLYqfLxlLrg6Lqgugc+R
    mpMBCTL7FcZAM/YfFEyeSJYgke1sGmAEg+AFH8QRKJAr2QURfHTydzS+CEFsiIaZ
    pGppNC+2DKEXBNCJQinKWHQkopSb3rtjvxOhsZvovsRB0fMRMtAbVpZlnF3HbOs4
    tFBxeQijAp17J8BEJ05CvaozLVuSI99w4g6/1xbmq5nlH/HUyxD6MmtJQ6MCycx4
    +zgci20ez5c6a0bY/xmKIvUHFTGBXpsmgUjjjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490865; bh=nbsz9Y
    pfmuKK1bdh9acGMoFEz6NfDwXU2kBGlZ6n1U8=; b=Oee0l55gs9XmxEBnoCnZFO
    GULunARyr0PF35puVPcr4ufkOdKvjl2dKgRM/wutFhmPwTkNLC+ju4RzQ7hxSLnP
    LSnkBVoXstNYxRMUoUPuDLq52yPHAAvTyEatbMRReeG6SimTbZSy70wZGFSVjw1i
    s/g128u+L7XaQ5/3WLRkZyUnT+16ve5GXcyR5fER5K2McV0ymswTtuGrkgmaWigR
    xJyKDzyZtLFds//A/sFwCcpnn8oYD5gd10EyNzEBVHPGXs3ovB2e82NbfePAU9Wc
    9e0+nZN6mcg33FK8bOfQfh4uBaaGh1QTd38ZH8sCFJY9y4qC03iaa4c/OrCwI0fw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VcHhVyUu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VcHhVyUu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeCHGeW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:34:22 -0500
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:7440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965466AbeCHE77 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 004/190] perf evsel: Return exact sub event
 which failed with EPERM for wildcards
Thread-Topic: [PATCH AUTOSEL for 4.9 004/190] perf evsel: Return exact sub
 event which failed with EPERM for wildcards
Thread-Index: AQHTtpokK1hXevo6wEmZS7N95l9RNA==
Date: Thu, 8 Mar 2018 04:58:48 +0000
Message-ID: <20180308045810.8041-4-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:ei7I2N2O5VPybNN16HAx5sDwqblYgC7kHoBzouXghGAF2TxRKEteCTacWKfrC0kCRokWWV6Ii7YUveI7wwZuVprcg4e8A4JoCbDiQxPCibwh8HmTLBmANKCUZmumbvX/SFNjndkuy2vhM1e79VQjC9e8SWpO/kSY7CcNsdc8EC4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 086bfceb-c402-41ce-947f-08d584b16dab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920F3A5BB2625AE737D6303FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(966005)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(6306002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bmLYOeiAPkmUZSGIVxSqeED5vcP75fNhRc5FqlUW4nDErYbjLqMyQP9uC7Ryl8lBT7veEJf6+dko4I8qBvl0qheley2srKHjKtGwllv2Lj4tSlTLEnuJQdKPJRdyfZhx66YDwSLcdkjtq3WKjrf+dabvQcZW4JwMM9NtwRYasjfVJPOYS9/7a8y8wWe5E6bk3HOrJBxEpl7Vl+oRzcmNNnvl6/RE41tPGO+eIkudME9xU5bm18p4rDAzGV+PvuH/c3VAyfATU9omu3ODB0QQ4kuu71LGLD/FLhMd6lMpFSaX+W8t0lPsy3/GSLuIKiHb3bIz6eDhFZo1ijEyirP7Sw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086bfceb-c402-41ce-947f-08d584b16dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:48.1855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jin Yao <yao.jin@linux.intel.com>

[ Upstream commit 32ccb130f5325abc81b32b1a538390f46e4860f6 ]

The kernel has a special check for a specific irq_vectors trace event.

TRACE_EVENT_PERF_PERM(irq_work_exit,
	is_sampling_event(p_event) ? -EPERM : 0);

The perf-record fails for this irq_vectors event when it is present,
like when using a wildcard:

  root@skl:/tmp# perf record -a -e irq_vectors:* sleep 2
  Error:
  You may not have permission to collect system-wide stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
  which controls use of the performance events system by
  unprivileged users (without CAP_SYS_ADMIN).

  The current value is 2:

    -1: Allow use of (almost) all events by all users
  >=3D 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
  >=3D 1: Disallow CPU event access by users without CAP_SYS_ADMIN
  >=3D 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

  To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

        kernel.perf_event_paranoid =3D -1

This patch prints out the exact sub event that failed with EPERM for
wildcards to help in understanding what went wrong when this event is
present:

After the patch:

  root@skl:/tmp# perf record -a -e irq_vectors:* sleep 2
  Error:
  No permission to enable irq_vectors:irq_work_exit event.

  You may not have permission to collect system-wide stats.
  ......

Committer notes:

So we have a lot of irq_vectors events:

  [root@jouet ~]# perf list irq_vectors:*

  List of pre-defined events (to be used in -e):

    irq_vectors:call_function_entry                    [Tracepoint event]
    irq_vectors:call_function_exit                     [Tracepoint event]
    irq_vectors:call_function_single_entry             [Tracepoint event]
    irq_vectors:call_function_single_exit              [Tracepoint event]
    irq_vectors:deferred_error_apic_entry              [Tracepoint event]
    irq_vectors:deferred_error_apic_exit               [Tracepoint event]
    irq_vectors:error_apic_entry                       [Tracepoint event]
    irq_vectors:error_apic_exit                        [Tracepoint event]
    irq_vectors:irq_work_entry                         [Tracepoint event]
    irq_vectors:irq_work_exit                          [Tracepoint event]
    irq_vectors:local_timer_entry                      [Tracepoint event]
    irq_vectors:local_timer_exit                       [Tracepoint event]
    irq_vectors:reschedule_entry                       [Tracepoint event]
    irq_vectors:reschedule_exit                        [Tracepoint event]
    irq_vectors:spurious_apic_entry                    [Tracepoint event]
    irq_vectors:spurious_apic_exit                     [Tracepoint event]
    irq_vectors:thermal_apic_entry                     [Tracepoint event]
    irq_vectors:thermal_apic_exit                      [Tracepoint event]
    irq_vectors:threshold_apic_entry                   [Tracepoint event]
    irq_vectors:threshold_apic_exit                    [Tracepoint event]
    irq_vectors:x86_platform_ipi_entry                 [Tracepoint event]
    irq_vectors:x86_platform_ipi_exit                  [Tracepoint event]
  #

And some may be sampled:

  [root@jouet ~]# perf record -e irq_vectors:local* sleep 20s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data (2 samples) ]
  [root@jouet ~]# perf report -D | egrep 'stats:|events:'
  Aggregated stats:
             TOTAL events:        155
              MMAP events:        144
              COMM events:          2
              EXIT events:          1
            SAMPLE events:          2
             MMAP2 events:          4
    FINISHED_ROUND events:          1
         TIME_CONV events:          1
  irq_vectors:local_timer_entry stats:
             TOTAL events:          1
            SAMPLE events:          1
  irq_vectors:local_timer_exit stats:
             TOTAL events:          1
            SAMPLE events:          1
  [root@jouet ~]#

But, as shown in the tracepoint definition at the start of this message,
some, like "irq_vectors:irq_work_exit", may not be sampled, just counted,
i.e. if we try to sample, as when using 'perf record', we get an error:

  [root@jouet ~]# perf record -e irq_vectors:irq_work_exit
  Error:
  You may not have permission to collect system-wide stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
<SNIP>

The error message is misleading, this patch will help in pointing out
what is the event causing such an error, but the error message needs
improvement, i.e. we need to figure out a way to check if a tracepoint
is counting only, like this one, when all we can do is to count it with
'perf stat', at most printing the delta using interval printing, as in:

   [root@jouet ~]# perf stat -I 5000 -e irq_vectors:irq_work_*
  #           time             counts unit events
       5.000168871                  0      irq_vectors:irq_work_entry
       5.000168871                  0      irq_vectors:irq_work_exit
      10.000676730                  0      irq_vectors:irq_work_entry
      10.000676730                  0      irq_vectors:irq_work_exit
      15.001122415                  0      irq_vectors:irq_work_entry
      15.001122415                  0      irq_vectors:irq_work_exit
      20.001298051                  0      irq_vectors:irq_work_entry
      20.001298051                  0      irq_vectors:irq_work_exit
      25.001485020                  1      irq_vectors:irq_work_entry
      25.001485020                  1      irq_vectors:irq_work_exit
      30.001658706                  0      irq_vectors:irq_work_entry
      30.001658706                  0      irq_vectors:irq_work_exit
  ^C    32.045711878                  0      irq_vectors:irq_work_entry
      32.045711878                  0      irq_vectors:irq_work_exit

  [root@jouet ~]#

But at least, when we use a wildcard, this patch helps a bit.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1491566932-503-1-git-send-email-yao.jin@linu=
x.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8bc271141d9d..539724c7d30b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2400,11 +2400,17 @@ int perf_evsel__open_strerror(struct perf_evsel *ev=
sel, struct target *target,
 			      int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
+	int printed =3D 0;
=20
 	switch (err) {
 	case EPERM:
 	case EACCES:
-		return scnprintf(msg, size,
+		if (err =3D=3D EPERM)
+			printed =3D scnprintf(msg, size,
+				"No permission to enable %s event.\n\n",
+				perf_evsel__name(evsel));
+
+		return scnprintf(msg + printed, size - printed,
 		 "You may not have permission to collect %sstats.\n\n"
 		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
 		 "which controls use of the performance events system by\n"
--=20
2.14.1
