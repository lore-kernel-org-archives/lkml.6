Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F6CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XKj2Ko26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4B32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeIGFhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:23 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728532AbeIGFPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4Gat9E+DC54EFr9tJTImzW2KYBGINDL0Nqz45xQlEI=;
 b=XKj2Ko26uWM77SZ62i6nJvn5rNXA1VM0GhHZXSpu9Ct/A3uwM69sjP1zYimHVoSbx3MZmzm6tt2EZz97lBnjFTUz5umkolwHTsDe5pqqaIG0sqVAAk7xM9VLRS2KMSAvp6Rh0tcIOMxjfMHJiuTY5qJdI5w7L7tIuQm1kVgQ394=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Maynard Johnson <maynard@us.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/88] perf tests: Fix
 record+probe_libc_inet_pton.sh for powerpc64
Thread-Topic: [PATCH AUTOSEL 4.18 39/88] perf tests: Fix
 record+probe_libc_inet_pton.sh for powerpc64
Thread-Index: AQHURkLMkuVHHNcv9UWsVXP4jYk36g==
Date:   Fri, 7 Sep 2018 00:36:21 +0000
Message-ID: <20180907003547.57567-39-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:kozhLEFjtcYmeyg0nAHZTe8Ot63kKCwqet03DUwjd6UiDXaFv9ReGIkhN7VDDWXhsy2wbIaqkgxiCtQtkSk1zvhoNr6Igl9vclmNgHisOfw+rqXzq1lRqD4dmspV7s1k5WmGi40yteZhzLLloX9slc4v0yjvTLASm8xNCa84dedRomeuNsBFZn/86sZrTNgdNDvA5jeQdJSysVS3ZQ5SemILAD785V2P9Q9AhfUDMaAf1rvncguDXlNqtx9pIeYPfjPiIL+AeAP7weHsmEUnDq6VU1kEzjnznKggZCYHTIa3Yxpl1FU6l5rBeIToMO+oZnzi0UDEOwrfae3yP/RJ2b594OKlObd8aLS8ciyJw8Ntmi/NjxCcJpN2C99XJbiqiuFV0o3FgYQjljYXPBnvn2BglkguLsI1RlezVRWvtttz6ku3WXVoEVFU4AY6swBnGXv4+s+EtIAB9MjwGuU5Pw==;5:D3A9W8ioHOqqZPA44Dj3s2cc9/89a2MlpT3j1fydR9Giz62OOc1Rs2kW9u6FlWa89PVi8xekLGYI9k8ILnX/0ysLEVrCBXTxBMrcfJS3e+wmXIXVNFwSrzGI7iOTXvyBjYb38TsC+AjN8VAdUS7Dl00Z3QGdswJx+qpFnI4iWtw=;7:iUQCaFCuABS+99IU/pEDOv1IOT5N2+145xNFSAgQLYjogWt80nabB824ChsL3HTjWUptd8+TRuCco9TyUV3U3JZXP1UYWHE2+ucGdJYLOaZzGHnznpgt8Zp8v7j0mMQCLTpKuK746pM0j6BjYodP4Dj8F1gJwenfMPw9U/VmCpE06k8SEUQK1fiNDQIQb3XMR7WAO0ZXs5uciCoEBWbl+27/Z5B5moFRUaxv9DhJ8ta2z4w/B4Jd4YE0g2TAwbZT
x-ms-office365-filtering-correlation-id: 7fa6c14c-632c-4354-506d-08d61459ff6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07736D05B1E6BEF5B72E42CBFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301)(274839183919467)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(7416002)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: keBt1WveAHZgZ1sGLmndicn7G6/Cd5hg+fAi26Tlcpa7gatkLYUq9GcNJ9ZU16teU/6ZrNUf4NOE4pv7I4wESqrypjSrgGAurWUxP7H8UociBLOhR+nzs2oySEqNSxiuoot5Exd3EAbpae4+Q2k+JkarxsuDpobe5FznubJudVGfqy9hZIg/dL6AkXYpjMvjsz5qjE/qHSVolEv7nYscBxcelvbZZBkmdNoJAMtiUgQpICIpxnrwpS0iMPHf+TrIJYsbZi4B/c/oEGlR/wYRTbVSKFP5m1NBoCDQhhZXfOfPo8IHU53qIYB6DKSf9z39Gj6x0B+1jeBIVKs0rRa6YwvWQ1qaEJgdTk17GfmLMbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa6c14c-632c-4354-506d-08d61459ff6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:21.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 3eae52f842329a95f8549124079518231c0daba8 ]

For powerpc64, this test currently fails due to a mismatch in the
expected output.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

Before:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 23948
  ping 23965 [003] 71136.075084: probe_libc:inet_pton: (7fff996aaf28)
  7fff996aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  FAIL: expected backtrace entry 2 "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]=
\(/usr/lib64/libc-2.26.so\)$" got "7fff9965fa54 gaih_inet.constprop.7+0xf44=
 (/usr/lib64/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 24638
  ping 24655 [001] 71208.525396: probe_libc:inet_pton: (7fffa245af28)
  7fffa245af28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fffa240fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  7fffa24105b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
  138d52d70 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use =
record")
Link: http://lkml.kernel.org/r/49621ec5f37109f0655e5a8c32287ad68d85a1e5.153=
0724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/=
perf/tests/shell/record+probe_libc_inet_pton.sh
index 94e513e62b34..1220e5e052bb 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -26,6 +26,12 @@ trace_libc_inet_pton_backtrace() {
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"=
 >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
+	ppc64|ppc64le)
+		eventattr=3D'max-stack=3D4'
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		;;
 	*)
 		eventattr=3D'max-stack=3D3'
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
--=20
2.17.1
