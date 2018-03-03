Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122168-2-6236798856104358785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122167; b=QAmmYi1xoxcDDAIB/lPLe2wQgmlWLOKlPCoAXXGXOekAbPd
    TiBTSGSpdbLOQmLgDpGTxu2aGwxbLjbzgNigDacsMLWPG09csetYDsTZ1LdxaTeN
    AremWvcTjp87FTUsfvSCgzy2iqxOBKzmQ9d9pdjrOa/tw3n71FihR7+XuzCQIrE8
    L9pzbJgIjwSUg4asmT1ArgW91ZqlLp8JNWX5M3fzhARrqP0/kUAtqIUXxiX3kS6T
    fo3etK2+qGd9bahnygsMYCGEZWMsAVxoZle/+AMSwMfq5b5RsaF3rCnvF9tBwrEx
    UrEmtwb+fzRWTUCsHnhazevL3/M33irsCiSlBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122167; bh=j44pM6
    1z3oeH9X2JaDb1QBvjybGBhmoZvTcShHDlar8=; b=BFasyr5aH+dO2RsEYw/+t7
    4e+AH3z/XNRIDcC4KKTKrrHPV8e89Wwz3kH8T/YDwP0ScIGM7yCeym2rI6ZCeeep
    JuddCJFZT++q6sjDZL7CDJreZ8+N42hCmbdn7cdTb9pTniJnEpBhV/TiPiIynILY
    G6233jweujuPDntTVvN9de6NEseIWJWJpu/jGal9OoiVlvIpbPKqUPBILhrFpOKO
    JfoGx8x4aRC2S+3P2ygtPhK013mVvVT5K1T0ArpOEAr8Ux69Yb6P4mLAbnAiEtG/
    58obf2VTieqPz95UxUX0SykHOxupFbq+iq8CCc/eSrcwbGfsO5/86FsXOr4q5IkA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GxmiucXE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GxmiucXE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933074AbeCDAJN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:09:13 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933206AbeCCWbC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <rric@kernel.org>,
        Vince Weaver <vince@deater.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 004/219] perf stat: Issue a HW watchdog
 disable hint
Thread-Topic: [PATCH AUTOSEL for 4.9 004/219] perf stat: Issue a HW watchdog
 disable hint
Thread-Index: AQHTsz7h/MfpF6u2o0uOkW0d2hsIpQ==
Date: Sat, 3 Mar 2018 22:27:57 +0000
Message-ID: <20180303222716.26640-4-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:tkb/6K7ryIKGuD469CBGtST3rRw28R2E/lycVFks0oBjW5EY23SXV4qhRLQndc/PfiZ7263Ej4F2Unmca4d7MaTaaRQ5aWvY4WyqKDaWB8vjNBjx1Abxd9uHsPEdOwTLUgpfD2nxZXnoG4PGvGAQmtArRXGpp95gqOUvnRK0JgD5JwvhO4GXewiG7ZuyKjsuRaPp94DHtkWIZPobflrEhdUF/YGEGdCzoEbQkVyYpg/zXbMs14JLTC+mCYVPM3Estmb33tKLaKDwhjrlM1VStv6p9si7z6lHUGS2hm61R4RooAsIfaYz/Njx2saqL+QYPoOF9jEz2gcM8kTYFqr3ZjCIFjnpW+z/XiJfhIu7FudM8HCTTX3F8ArrCnsoqqwL;5:Lov4ZwXrbiapR3QnC5xv7llwMg7HbxmodCgDftcPYf/wTQ18ueagXURmD9Md4sbhYqc6trwfbTDJROFvL/hmxBGIeZt8NGN8NPWJTDCOHlJzzWF37DeDrywihWBpMs98y2J8QcI0XQdwp1ljtaruQ6PPsQa4EMVTxxxv5VJQz/Y=;24:u7gjodkBAMTQnRC1qjgdiUAxklMj4sDzxGt048GqprTNAVGTWJ1KHm9dRTXyEYNsnKvNxz7POgJNwZxYvCRDqSIXV8HlIMPvVVeSqoKj/34=;7:StYKiA43vBLsKf44PUGM5uCTH7Ow/OR/vIpnriJNZveOtZssPN1pfQ5StQCjCaZndZqaUBAbVF5MSZxl5zV8m1wnKAP1K4i7LTmLZIStx0Vb6aUWOzBCkbGpwpCTsiKaJahvvXUx/3Eajyq165TcAZF3HTGHoMFiw7ZhrDHxkNDuPyHFTfb5jUt9LvNWMBmQP7FfBWjuXskhIz0xyqaN5bACMknOpjWVj6mS9dAX41CwIKRbZAny3Y2j7crBWBaz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd630893-078f-4186-6f82-08d581566f99
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09707D19A9DFAE2ED89EC2B6FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LvV7jCK5qGsjdaSfa6fdCa2XRkuArWXtoZCIU7Gwgwnk2qg4/0inG6G6cntGXa0IXC4ghjlaGoX7bWJzuEWD2HIJE8IQZQceOpb1Jj7J+zl6Y68wim9xIzudG3ZtQ9aDUEVOD5bKXofqqlKP6Pk6HANXqjsi/beNJ+vfb0lsOso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd630893-078f-4186-6f82-08d581566f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:57.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

[ Upstream commit 02d492e5dcb72c004d213756eb87c9d62a6d76a7 ]

When using perf stat on an AMD F15h system with the default hw events
attributes, some of the events don't get counted:

 Performance counter stats for 'sleep 1':

          0.749208      task-clock (msec)         #    0.001 CPUs utilized
                 1      context-switches          #    0.001 M/sec
                 0      cpu-migrations            #    0.000 K/sec
                54      page-faults               #    0.072 M/sec
         1,122,815      cycles                    #    1.499 GHz
           286,740      stalled-cycles-frontend   #   25.54% frontend cycle=
s idle
     <not counted>      stalled-cycles-backend                             =
           (0.00%)
     ^^^^^^^^^^^^
     <not counted>      instructions                                       =
           (0.00%)
     ^^^^^^^^^^^^
     <not counted>      branches                                           =
           (0.00%)
     <not counted>      branch-misses                                      =
           (0.00%)

       1.001550070 seconds time elapsed

The reason is that we have the HW watchdog consuming one PMU counter and
when perf tries to schedule 6 events on 6 counters and some of those
counters are constrained to only a specific subset of PMCs by the
hardware, the event scheduling fails.

So issue a hint to disable the HW watchdog around a perf stat session.

Committer note:

Testing it...

  # perf stat -d usleep 1

   Performance counter stats for 'usleep 1':

          1.180203      task-clock (msec)         #    0.490 CPUs utilized
                 1      context-switches          #    0.847 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                54      page-faults               #    0.046 M/sec
           184,754      cycles                    #    0.157 GHz
           714,553      instructions              #    3.87  insn per cycle
           154,661      branches                  #  131.046 M/sec
             7,247      branch-misses             #    4.69% of all branche=
s
           219,984      L1-dcache-loads           #  186.395 M/sec
            17,600      L1-dcache-load-misses     #    8.00% of all L1-dcac=
he hits    (90.16%)
     <not counted>      LLC-loads                                          =
           (0.00%)
     <not counted>      LLC-load-misses                                    =
           (0.00%)

       0.002406823 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
  #

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Vince Weaver <vince@deater.net>
Link: http://lkml.kernel.org/r/20170211183218.ijnvb5f7ciyuunx4@pd.tnic
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-stat.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 688dea7cb08f..c241167c76c9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -146,6 +146,7 @@ static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static const char		*output_name;
 static int			output_fd;
+static int			print_free_counters_hint;
=20
 struct perf_stat {
 	bool			 record;
@@ -1109,6 +1110,9 @@ static void printout(int id, int nr, struct perf_evse=
l *counter, double uval,
 			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
 			csv_sep);
=20
+		if (counter->supported)
+			print_free_counters_hint =3D 1;
+
 		fprintf(stat_config.output, "%-*s%s",
 			csv_output ? 0 : unit_width,
 			counter->unit, csv_sep);
@@ -1477,6 +1481,13 @@ static void print_footer(void)
 				avg_stats(&walltime_nsecs_stats));
 	}
 	fprintf(output, "\n\n");
+
+	if (print_free_counters_hint)
+		fprintf(output,
+"Some events weren't counted. Try disabling the NMI watchdog:\n"
+"	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+"	perf stat ...\n"
+"	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 }
=20
 static void print_counters(struct timespec *ts, int argc, const char **arg=
v)
--=20
2.14.1
