Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242374-2-8540482399329334310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242373; b=aCUknYRlFAgWgzF4OTUN3+iUnozFsoziaEhhrzhkpAVwJ59tfO
    ZrPnMU/ihA24W05I8Hew9kYZjmjHTePEgFPldIbFh+8Pvd7apXaiDk8bAY7LeKVF
    g9F97DfYdUkrdFYsuXwGKdxi6RH6tdXk+I4d/67FGx1Gy0M4qEjbg8fJJcSjm4L5
    18HRRkY+rvh5uNB3pDMbnVY2PXvBKvadoG0C/2LKOjAXjhothr4YSuOba/Lrhs29
    lRbBAqHF25xR4PvxlxfTZcOlfmUdcZcXJsj7y+Gv9rE7LlxMbzycL17KQ448mwdb
    2AI/qOl0VIg5lt1fyeSHs/aHBPLCpn0GKaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242373; bh=cCnloacirn
    TO63n7637IC4maQHShzguVFdol71LWx0A=; b=b2VOoEqeUGbCfFC1QYKz6kEClj
    YBpb7lKcg/aPcC4naqDiNnSJw+dtOiqXXDf/0QgwnMAh2aH38QOwnqNTzIagiGyi
    qwYYxbIHeiRKf2ooRgcT1VvK1HSulRol0rvhUk4d+noicwtreOG5RsiFXtI5LocJ
    CkSEi7if27N6jJcDnIQ7xJ6/7ghuAAekdlSKxFzbawxMBTh7O+b8+hJrcWEKFza7
    gOs3UHd6zygoKLzclNdQQuUQfnn7WiLc+B2lS/yyNGzE6m3mShwLhy2U8kYZuJ6X
    GFJeRq7aNwQGmCGL8Xwi7r58iEt0IMp9wp0db6sybTLr2/naDrwXcKOghnVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD4hFCcB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD4hFCcB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJQvF5ocWp0lRLF+oMJGKsGhmtEYncGSQnnwCuahR/+YiNMY9uTWCVPFC/icznV7Eo62OV/LIWR7KkS+TsFPWqRCyma3DoDCWrdCclJvKEosmWafkBhz
    +i7Ah2tRK1++BVlFf3fj+3d3QiJENX2neEXse7+ZPxl/lKTooG7SfYu64TEeT6Y9pu8XfWuZiUoYl99/91hT9Jf5vfC8g3oxB1lzDqQkujwG82X+hbP9lfJT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=Do2tkfnwJekc5ZQHZQQA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeDICwh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:52:37 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755334AbeDIA0a (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 158/161] perf test: Fix test
 trace+probe_libc_inet_pton.sh for s390x
Thread-Topic: [PATCH AUTOSEL for 4.14 158/161] perf test: Fix test
 trace+probe_libc_inet_pton.sh for s390x
Thread-Index: AQHTz5jJ3SW2QTuJ30OozEmzRJx4GQ==
Date: Mon, 9 Apr 2018 00:22:04 +0000
Message-ID: <20180409001936.162706-158-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:QzXXYGbSMSLC+pdd/oQZ/iq36g8jhmD5jllfYtLfH734eoTb6xyvBR0XzqBmmCw1H43zFoUKq7uhPyDRDa4vqXDul7PYkiKo/ZFVoVmg/G1zScS44Yp00J7NwIinAEiVPPEIPVAfC3ZJPB5d6/Ao+dsWgYqLVhSPX8M7qRFx65yhq4uIBOyrhHITp1nZhwGNLrCromWb3OG1PJnOeH/wh6Gf1UiS+SM+UXX8fnQ1pyecviJp3FivdL3fIe8/UBrK;20:1Vz+AWK51NOv02kNsfg+ui2hS+z1AWhh1hmw//jVFWVLn0OT4C5CTcscsDk/Wwq1KHwH+hHslrBvj/NLublnmqKD/0buTHYAyeU3+Ar+YXUP2EcgMxh8pDKas//t6z+0AOcKSUSRRyDpSBP2iVXkcyIi51LsYxuQPNiTePRY8zE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0442376-b018-4494-fa97-08d59db0881b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10153562289A9648874D1A5AFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PPir0FnjfB9TMIiN9NWv12NFcTTeIEUvxWrMpZAafNwgUz3/3nuE2GyDdUe8oDURbXul+UIn7amRAV5hnwwMoNdY0hI09zGGUcVBOMvtvpZUlzxEN3RDsPDa+Hf/ONCtBC2aSX1qQMRfX7ARoRRPMw1LHTn/yX1xyAJtnP5NJoCM962gEkz6rtQ9ojK1065xoLavoalYb5ohNUwwS7rMaViv9xSdx1Kn7K6RZUGuEQ/wSnSXmT7lmxI7ilbFojh2JmoOUzdcw9iVOIb2ZvFu3R2m8JaCRG8+uBC/p8mE3p0ZPAy5i3nUu5Vqybl+V5jIiNvQDrlV02l+m94TOf0GapQ3IzgSlmOo2SiK+M82S7fmgYUEFxEpdpfkuKF3iA2/7d0U4yi2tEmwTpteOs9/akfo6mbm+xHBHKbk53uF7FQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0442376-b018-4494-fa97-08d59db0881b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:04.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh  | 21 +++++++++++++++++=
----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/p=
erf/tests/shell/trace+probe_libc_inet_pton.sh
index 7a84d73324e3..a2f757da49d9 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]=3D"rtt min.*"
 	expected[5]=3D"[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit=
:]]+\)"
 	expected[6]=3D".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]=3D"getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=3D".*\(.*/bin/ping.*\)$"
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
=20
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3D3/ ping -6 -=
c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
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
