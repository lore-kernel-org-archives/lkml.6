Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233319-2-12197502292274562011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233318; b=YmKgePkgw/U2c9IkIqH3iSOsfr/J9tCkTjd0w9LT1P8TwOuxAY
    FeQ5fjyPfPa6eS5YnBmdKKeMCxh+UVPBzOXvzHg5DTSyObX3O5xL7+say2s42dMR
    8aLwv2beMDwe54U3uT7oSfpcsGt92BiQeCYf4ghsWIp5ABxIMRVg5spLwFg1S5sX
    XYmtDUNFHy9Z1EZiHpHMnH1TpezG8KOJVxQQf/7xbLy7k01rcZSbZ//aPXMY11MN
    VkZpXSKUL5PIc8sFRwyAOAIK9baoLpqBPtKRNOiHf3w5XOfHsZaHu89RQwWx06+q
    2VK27HdNiehst/ioAj/FnBq0Wf99I1Rn+cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233318; bh=15sbMWLtcu
    ffJKQoULtixh+kYoymTwmogK2MBxtOI6g=; b=K47ULEmzmZOb1+X9H9twmyjr7X
    5+dWXy5BiSAT4wFNBfv1ItcWaSLxN9ZcvbmOWd+wGZ27PXYnHEmZCLfyvLQl/dtb
    brJ9rtPCXaxn3TQ7FHYBlmvLH17IX90SN9BS/QcZKD/e+Tr1T0XarzbYOQJX1fyL
    Lz5RDxOpoORCvo7nNPgY9808cci+kGRn/kLApbs910PMLTZqe92QczBU78SoYt8I
    hdRBuAGMaFsAQiNgGcdFiDNeP/46WE3ZGx4yAnScEUtvy1j2SC8lNM5sYufN1JPa
    QQ+Aty6uI+69Xm3e4N9BP8DnS1RZPBE7pLwQv52B6Ced842hXlsAL+hhm5vA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bUso4Yv5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bUso4Yv5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLdO1d7zta6cL2LEbG/3QSMK7R36jlY/MT/+l7cDNMD4h9uM7IsBOiw1oK55lsb7T+CNUcw3PIBPWFLR4By+ilo+AtK0rosVZsUMFQKWNN9plfTzr8n/
    i6uJry7PeG4/E45OTK/l4aB3UyjmMxHepKIVSELGb9m9uM74bAnG0zPz9m4roFPHJV1KcJNIHvnlbWBpmDw7JOrmJL7iNXTUANg8+eH1sNz0kejvo5iQp8KS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=Do2tkfnwJekc5ZQHZQQA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeDIAVz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:55 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753163AbeDIAVy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 186/189] perf test: Fix test
 trace+probe_libc_inet_pton.sh for s390x
Thread-Topic: [PATCH AUTOSEL for 4.15 186/189] perf test: Fix test
 trace+probe_libc_inet_pton.sh for s390x
Thread-Index: AQHTz5hknvSra5ShM06s8q3FJMI0rQ==
Date: Mon, 9 Apr 2018 00:19:15 +0000
Message-ID: <20180409001637.162453-186-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:Od6eFKTM7WuqPsWM53psgQJ8KPyqhRrRH7JSB5rQS7JknuClG308N6MNUUVz+xEbP++5ZLT7Ou/QF6ORth81Nkzbhkpcu91cMbj1d4KT7S3mw3rprh9l41lQ6KO7mWMOWzQa8Rjjhg/lNHpkXmfXd+IzYrc9taJuKz2RNBfG0z4K0hQuqdmtiOZ+eWNqi6Y1iRqF9FVAkTzZcXW/5Dg/hJTSZgYeJj+vTmziCXjjs2BzeyoHRxi+M9C+MUxQsJuL;20:Wf6rxJVd5Lw/kCfq0bUbVL51HO8uH4gHLs8SN+bMk6I7sWvpTadVk35BiagrBEwtKwd1VzHqLWaWHpsGh5RpdCjKXdZZINs3p8hv6fm9lps2y5GxI/f8ULNixtV4Y9J2ycDnGrT5Oj2dL6lMAfeYhhIsTZuOr+xnoODwFiML5+k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f529da2a-6e0d-4e18-ed11-08d59dafe455
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093601567D68B3DBFCE6DF42FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vI81/3Y5w22kjJsK5T2EYZpuDas8/zC0C4Ekyu+9bShIAhePAeuxEYA4fhUmEQMQix+hv2TCLqwe+K6THSe9LWiBj7Mx3U0tRumEmFxo8NgSf+NcVtS1SwvurEp6j1o7GtgD17jEh4quvemyjuu4nYzJUJBbhkGRpKJiWKdMeO6KT61rKqE3Q/Jss2jmTWPjHnXFQFgb0Zb0TC6K8fjNhC07/YCBGQt4SHRLvwHd+HuZF8lv9yELMXhJZJNkcBwljH3WuMDvYWUCW/byI5YXMmNfMHaX7yJbpgdhd4g6YqEQ3xHWGoS9YImpSyhaYHfGF4mA01W0H9q9PZdFrWyGZBtYzicHLwglIdKmt6Uu8HzCtESSQewssn7FTA3u293KK1oWP1PjnjJ8PRgRrUFm83TGDgNVSOaZEpFWXcTSyY8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f529da2a-6e0d-4e18-ed11-08d59dafe455
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:15.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 7a92453620d42c3a5fea94a864dc6aa04c262b93 ]

On Intel test case trace+probe_libc_inet_pton.sh succeeds and the
output is:

[root@f27 perf]# ./perf trace --no-syscalls
                  -e probe_libc:inet_pton/max-stack=3D3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.037 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.037/0.037/0.037/0.000 ms
     0.000 probe_libc:inet_pton:(7fa40ac618a0))
              __GI___inet_pton (/usr/lib64/libc-2.26.so)
              getaddrinfo (/usr/lib64/libc-2.26.so)
              main (/usr/bin/ping)

The kernel stack unwinder is used, it is specified implicitly
as call-graph=3Dfp (frame pointer).

On s390x only dwarf is available for stack unwinding. It is also
done in user space. This requires different parameter setup
and result checking for s390x and Intel.

This patch adds separate perf trace setup and result checking
for Intel and s390x. On s390x specify this command line to
get a call-graph and handle the different call graph result
checking:

[root@s35lp76 perf]# ./perf trace --no-syscalls
	-e probe_libc:inet_pton/call-graph=3Ddwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.041 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.041/0.041/0.041/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb9942060))
            __GI___inet_pton (/usr/lib64/libc-2.26.so)
            gaih_inet (inlined)
            __GI_getaddrinfo (inlined)
            main (/usr/bin/ping)
            __libc_start_main (/usr/lib64/libc-2.26.so)
            _start (/usr/bin/ping)
[root@s35lp76 perf]#

Before:
[root@s8360047 perf]# ./perf test -vv 58
58: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 26349
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.079 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.079/0.079/0.079/0.000 ms
0.000 probe_libc:inet_pton:(3ff925c2060))
test child finished with -1
 ---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@s8360047 perf]#

After:
[root@s35lp76 perf]# ./perf test -vv 57
57: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 38708
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.038 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.038/0.038/0.038/0.000 ms
0.000 probe_libc:inet_pton:(3ff87342060))
__GI___inet_pton (/usr/lib64/libc-2.26.so)
gaih_inet (inlined)
__GI_getaddrinfo (inlined)
main (/usr/bin/ping)
__libc_start_main (/usr/lib64/libc-2.26.so)
_start (/usr/bin/ping)
test child finished with 0
 ---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@s35lp76 perf]#

On Intel the test case runs unchanged and succeeds.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117083831.101001-1-tmricht@linux.vnet.i=
bm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 23 +++++++++++++++++-=
----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/p=
erf/tests/shell/trace+probe_libc_inet_pton.sh
index 8b3da21a08f1..c446c894b297 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]=3D"rtt min.*"
 	expected[5]=3D"[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit=
:]]+\)"
 	expected[6]=3D".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]=3D"getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=3D".*\(.*/bin/ping.*\)$"
-
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3D3/ ping -6 -=
c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	case "$(uname -m)" in
+	s390x)
+		eventattr=3D'call-graph=3Ddwarf'
+		expected[7]=3D"gaih_inet[[:space:]]\(inlined\)$"
+		expected[8]=3D"__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[9]=3D"main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[10]=3D"__libc_start_main[[:space:]]\($libc\)$"
+		expected[11]=3D"_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr=3D'max-stack=3D3'
+		expected[7]=3D"getaddrinfo[[:space:]]\($libc\)$"
+		expected[8]=3D".*\(.*/bin/ping.*\)$"
+		;;
+	esac
+
+	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1=
 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -33,7 +46,7 @@ trace_libc_inet_pton_backtrace() {
 			exit 1
 		fi
 		let idx+=3D1
-		[ $idx -eq 9 ] && break
+		[ -z "${expected[$idx]}" ] && break
 	done
 }
=20
--=20
2.15.1
