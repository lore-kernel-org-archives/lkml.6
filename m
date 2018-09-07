Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FAAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D9620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bnCizS6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D9620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeIGFPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:08 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729136AbeIGFPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li0ch8fVKRCNBsVVvQD3WHfN2q8ufIdGGs2N8ue3Qmc=;
 b=bnCizS6yVO0HpksjwOpUnEdzHqNTrwHD4S48JJUfho6ZESALqqydVelTQhEy+4rAu8opEQWqEY+QEQQFyKGSYm9V/Hp/ed9UIJMLRvqFlqAzN6TQgbPdGBKZacrZfwpSpjuK8dOW/g7pk4tgYWApBahrmV+ZYdDRNBg69QGpJLw=
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
Subject: [PATCH AUTOSEL 4.18 41/88] perf tests: Fix
 record+probe_libc_inet_pton.sh to ensure cleanups
Thread-Topic: [PATCH AUTOSEL 4.18 41/88] perf tests: Fix
 record+probe_libc_inet_pton.sh to ensure cleanups
Thread-Index: AQHURkLNJttqeWpkskux8V1IiWqHPw==
Date:   Fri, 7 Sep 2018 00:36:23 +0000
Message-ID: <20180907003547.57567-41-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:O5dVHOxErk3rSwTDCjLV0Hnjb2dZkoGJl4hEHAIiKDeH4mRhdIi7kb4l654UGtZJl9TXn2LMa7DPcctxUnwPcumUXfVeIuHy3Cu0zPCdsvCkz0Ee7IvFn7nyBYpynL2gVZigbP028D/tIaOLccxav3s+sj7bZGftLMAtMzm2WETlKhce28FlfprsyDEM9dJOcE91TxCrvkGld8I2OmWULFYXvg+y93nG+9ZO0So9aTUEt25BG2GqAC0vxn3FXJxUFjZsuMcfWo9HDEROSoHWNv/SRZh4M1/iAxJ+Vl94Rc9T8Sv2ERH90ouHQDsXoeMB+jWP3MO2AiJAF04Cmf92lNBPAIYgAmgCwEFSLYkZoqO/zH0QmXqfjE0My4jGPjBYmVuiIfWx1stmXyDy/xsYpXcp6k4CNgMWgyD371drOvRAUrECdV0bsehBGJVjZNSmiUafpWybhDH2LPi4cv8GWw==;5:5+eH8ChkRhbflX8cOmu5SltkMYf78b3aadihvNe+YU89WW2YyFLF4dUzf3KFVH9iPp7wUC/vkH5EW6wBBtkykza2BiRVzmhQtHOscCRCqq1Q89i76tnWPyzARbgu9PhM5tQf9V2EfQcfT/6bzw3Zezjd0DFG4SQCD1MIuK0w+YU=;7:diPUHXiQgVN5FpJGdLUSUAhuZNX6rqZZ7t4uepXtxHyE71IcYBcFhwNEBX5s7RADCajp65c2hEu1U6Z1hhz1/FC227Ea+M0TxfGcpA/6uMwqc76NaKUG1DvbBbQqiwUC+8UegaMtlotbC6r04diP3D301RRcgrC45MUipKcUQFcrAJBwm7oXWe2FRkW/M/qhMGPlme9fnvZtksKi3lZPecLqTtEHX1JLnDfpXVqLq8hbiIqfWg8ydJu8xDRT2dHn
x-ms-office365-filtering-correlation-id: cd0f2e44-d3d4-4fa9-2094-08d6145a0002
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773FDFD69ACA62B1761B989FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Bhv1l5lc24ewz+pOj5Or/HLYubuQyhekocpaGf20lx62I2WV8RrkPW99PwGR8CO3PUNxf5hYJHL4txeZFr257D+7j1i+V2BGuba+EsmIuX3e8bfr8fG//juxUQZEuBbM6c/OFvNk1a7cxLE66JaJqMnxZq7sssVaBjH/6Ed0885MbFCBiSQMKrD258Yn9rrmw5+dAyePhW6XbFnFfZ3Yuu+T0wA5F3dPWadEMuE2ZE67xMEwMNd/qbVVCKDJ+nk+9cA10YRVLcKbMdVRpEXLtezl2vcqFq3iJs1Dii2SyBYuteW6AFohHHZCy6Wyxow1AJM+do0dEBeRHj5SdZNiS1J/eTHZ43ExNuIR9ppzpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0f2e44-d3d4-4fa9-2094-08d6145a0002
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:23.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 83e3b6d73e66a10088f362b08b99c36fec3a14e7 ]

If there is a mismatch in the perf script output, this test fails and
exits before the event and temporary files created during its execution
are cleaned up.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 18655
  ping 18674 [013] 24511.496995: probe_libc:inet_pton: (7fffa6b423b0)
  7fffa6b423b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  FAIL: expected backtrace entry "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(=
/usr/lib64/power8/libc-2.26.so\)$" got "7fffa6af90dc gaih_inet.constprop.7+=
0xf4c (/usr/lib64/power8/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # ls /tmp/expected.* /tmp/perf.data.* /tmp/perf.script.*

  /tmp/expected.u31  /tmp/perf.data.Pki  /tmp/perf.script.Bhs

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/p=
ower8/libc-2.26.so)

Cleanup of the event and the temporary files are now ensured by allowing
the cleanup code to be executed even if the lines from the backtrace do
not match their expected patterns instead of simply exiting from the
point of failure.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.153=
0724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/=
perf/tests/shell/record+probe_libc_inet_pton.sh
index 09f41f503136..3013ac8f83d0 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -65,7 +65,7 @@ trace_libc_inet_pton_backtrace() {
 		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" =
"$line"
-			exit 1
+			return 1
 		fi
 	done
=20
--=20
2.17.1
