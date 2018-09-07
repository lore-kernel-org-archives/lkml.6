Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8BAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2042083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yz/KF6fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2042083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeIGFQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:59 -0400
Received: from mail-eopbgr690113.outbound.protection.outlook.com ([40.107.69.113]:45032
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729124AbeIGFQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv8rA5KfIT8j9vl/LMDR/9kK0x8+VWepW/W8JRNWRXA=;
 b=Yz/KF6fjDVxhIS6ww8957/+hYT8GjfDeivgFwZe00YDv9muOBLC5QlZG4YiqcEuh2pRAXbFiqgdcJoi/AdmK/UdiiDq72Y8GNC/KNNu0Y3jv5K9mkti6Gc4uHmneYutRQfcGf1kZUHbbf32GO41vUkbasPA54xCkcutLPRWaWZU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 40/88] perf tests: Fix
 record+probe_libc_inet_pton.sh when event exists
Thread-Topic: [PATCH AUTOSEL 4.18 40/88] perf tests: Fix
 record+probe_libc_inet_pton.sh when event exists
Thread-Index: AQHURkLMLWwzGvn/4keA/Ryg8OIL1A==
Date:   Fri, 7 Sep 2018 00:36:22 +0000
Message-ID: <20180907003547.57567-40-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:ID/+cYLxCwfaKc8Y3Ou5d9IrkCvMoe2bGYRTOvVytRbl6NjpNWBCI3pxdCJ4zzHw4cQuVcwklK3OpYF6Lingry3gDJJLk5F6dHWDLDC2cymFAbzuViqDJTcRDkiIXQL4tWFXj/JZrb1SWOZ36ampxqQdi8Ichi4YzX33rIs4EwIUDUJBNMW4xNr4KS6X93IQwCncPzNEXSYka2lyMAfbF1275zbu58BGZuK+ftXT3EA+bqOa9kQFZ86l65XYeKxlIqpKbP04CZuKMMjnGV79GWCS5w0xpjG+/ZV8vTbQZJTcbT71UOFJt4bbSElyBuCkcerMRHt5pYh/+G609Grvo62XMm70dEucZN+jwUebQg6tQ2ffWdTipzyfxSPdKi+0+kPFMrFYZvLPwJhfNkV3P8PhoUVnShHM02ymPP8OBixrV6tnCrk+hzvBIXT7t7XckQA7vwZ6s8exMJh6m4NxFQ==;5:VdwPB2jrt/FKMSpeJua3ozOd989438knpfGv7TAdq/OBHNl6Z01vQ50b9wUWGs2zlx4usizjJ0y2K1NIVaeJQHT61kBD+C0JWk9mWGdMOyPJBvNwZnPu0Dw3wlquFzHK2MJyB24j2fvRd0+js2r6+LHkcunrzCrkBHzn05ok0H4=;7:0hpup3J3IGnp65SREevd+lY0o1WMQsS/Hr7sCNsIuHBd+Ypb9254j9WOkqdr4K9/F4Rg9PnQKt6hEkcX2fwVz+7okqr/z0WrabpfpZWWlL2BzX8HSqf2VpM2E61dsLI/D4G/fysbtSkWi44LFWc+Ne+UN5OgiJ44W0c+YTJSabNPNpYExro15ikdTKlJdjBifwuib7B4Okyjh/yyWAYZtOp/eRZscXVwvlnpc8R00NmzdfIUtxYJeL0I+A+ZbF0K
x-ms-office365-filtering-correlation-id: 527b50c6-f9e7-4610-7f9f-08d61459ffa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773F9539CAC4B8D50C3B2E0FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0WOZYpLRhZMvU/PeNks99nMAUv+37q5hcLMxt9hxshctGqcqX8PwVNtsIjDOHPKikMlb0Wid7/ao/i2UgB+xUL9guiIPRXHfrfRX9Y8K1JtJn5I2EYui+9DFfXQ/9B4gP8VFJqcgf/77JCx27ZYf4GXpTxvoWQzQhBv/RjxmSRm/ETg1VhrfwWzcbzNJywtV3SHwhIo1p/WYGr3RZtJHpRu4s+wsveXYib0DFYg0/fKsw9kkYgtDHcxDkGtd9WSOfSE5QTm1RfzLtlNNi/mVgaKSx/9Q6IZnGqmzUIG3uvbwsd+ScBVAxgR2uhW7I3D5kfTjBjc88f4SvlFEpDb/oXSkLBQO6NvHbxZ76m0cI5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527b50c6-f9e7-4610-7f9f-08d61459ffa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:22.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 60089e42d38438772e2f83334e3e5b7497009366 ]

If the event 'probe_libc:inet_pton' already exists, this test fails and
deletes the existing event before exiting. This will then pass for any
subsequent executions.

Instead of skipping to deleting the existing event because of failing to
add a new event, a duplicate event is now created and the script
continues with the usual checks. Only the new duplicate event that is
created at the beginning of the test is deleted as a part of the
cleanups in the end. All existing events remain as it is.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf probe -x /usr/lib64/power8/libc-2.26.so -a inet_pton

  Added new event:
    probe_libc:inet_pton (on inet_pton in /usr/lib64/power8/libc-2.26.so)

Before:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 21302
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # perf probe --list

After:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 21490
  ping 21513 [035] 39357.565561: probe_libc:inet_pton_1: (7fffa4c623b0)
  7fffa4c623b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa4c190dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  7fffa4c19c4c getaddrinfo+0x15c (/usr/lib64/power8/libc-2.26.so)
  111d93c20 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/p=
ower8/libc-2.26.so)

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/e11fecff96e6cf4c65cdbd9012463513d7b8356c.153=
0724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/=
perf/tests/shell/record+probe_libc_inet_pton.sh
index 1220e5e052bb..09f41f503136 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -13,11 +13,24 @@
 libc=3D$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](=
\/.*)/\1/g')
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
=20
+event_pattern=3D'probe_libc:inet_pton(\_[[:digit:]]+)?'
+
+add_libc_inet_pton_event() {
+
+	event_name=3D$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | he=
ad -n -5 | \
+			grep -P -o "$event_pattern(?=3D[[:space:]]\(on inet_pton in $libc\))")
+
+	if [ $? -ne 0 -o -z "$event_name" ] ; then
+		printf "FAIL: could not add event\n"
+		return 1
+	fi
+}
+
 trace_libc_inet_pton_backtrace() {
=20
 	expected=3D`mktemp -u /tmp/expected.XXX`
=20
-	echo "ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)" > $expecte=
d
+	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expe=
cted
 	case "$(uname -m)" in
 	s390x)
@@ -41,7 +54,7 @@ trace_libc_inet_pton_backtrace() {
=20
 	perf_data=3D`mktemp -u /tmp/perf.data.XXX`
 	perf_script=3D`mktemp -u /tmp/perf.script.XXX`
-	perf record -e probe_libc:inet_pton/$eventattr/ -o $perf_data ping -6 -c =
1 ::1 > /dev/null 2>&1
+	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /=
dev/null 2>&1
 	perf script -i $perf_data > $perf_script
=20
 	exec 3<$perf_script
@@ -62,13 +75,20 @@ trace_libc_inet_pton_backtrace() {
 	# even if the perf script output does not match.
 }
=20
+delete_libc_inet_pton_event() {
+
+	if [ -n "$event_name" ] ; then
+		perf probe -q -d $event_name
+	fi
+}
+
 # Check for IPv6 interface existence
 ip a sh lo | fgrep -q inet6 || exit 2
=20
 skip_if_no_perf_probe && \
-perf probe -q $libc inet_pton && \
+add_libc_inet_pton_event && \
 trace_libc_inet_pton_backtrace
 err=3D$?
 rm -f ${perf_data} ${perf_script} ${expected}
-perf probe -q -d probe_libc:inet_pton
+delete_libc_inet_pton_event
 exit $err
--=20
2.17.1
