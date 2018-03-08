Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486822-2-8748688777383457954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486822; b=pTohAQOzX5ubD8KsfPNXfsqy2+/MHey2gvtrRQYm8dKkGZ9
    /yqsYmP0b4ZN9vo+hKWUvw6GKlYR8E0zYxyg1Ou11lQepgrYvMSqMN5LQh6LAmz/
    eeUCxgmSwmVUT3D2D1L0UHeGAI9+SZu14bSOxDW3Lpkkodv1SzJL/2iiGnPWxpKk
    3QGn+S++FQX53DbKVRhc98lI8IYrFHZTU0WdwvBjQLqWN0sTdcHpfCcT6ZTRaN6F
    FeBlhUHOxhiRlRhePYhVWUsEPlA4EMb8/HAPyLISiEB7C0x/tTergIp7HGyHurx4
    uiLOsg22Qd7VA+Dm3hljNVEycvN9n8fK+L2sTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486822; bh=POiwET
    Djh74v/m2PNCZQH5p770zomzCYW7Vpo6PNxlQ=; b=qBCuNvw9fZtKYE4yIRTmN3
    U01lTCvx5QIIVs6oBxc4AEruYA5mSdHjU0J7+hF5WS+Hwo+fvLWIWnZtOq2OVZ3Q
    E9o954m44+skedkz15Rufj9f+pnhvU3Cw7OqAPPATxyJ8vmdvaOHs5KK1N+VF7Ap
    GQwVv0qKIUe3n/b3oLC/ilhkvxvXCoowZZ6YjbKA6ik9gWuKiCpQnF8Okj6atKWL
    TiSFLyubnMTsLIIhjBOAZ2B8tSfQ8jIoT+6FfSj7dCLDOBB3+QTSE/zQYyzv10fb
    2lV092wwagRaJJx3/KHimTSjs/Pjmjbloik699uC9DZ0YV27SJCdHbNDx1tLt+DA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c9gxhi4r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c9gxhi4r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966600AbeCHF0v (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:26:51 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966543AbeCHFHJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 077/101] perf tests kmod-path: Don't fail if
 compressed modules aren't supported
Thread-Topic: [PATCH AUTOSEL for 4.4 077/101] perf tests kmod-path: Don't fail
 if compressed modules aren't supported
Thread-Index: AQHTtpqbqafBZ9xEQUSUlFdEaQxBBA==
Date: Thu, 8 Mar 2018 05:02:06 +0000
Message-ID: <20180308050023.8548-77-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;20:9WgDj/nqpfYAyPEGhHfihkLI0FT5PBeqhl1+GWigDBBn52rRFrL6IgXzT0iUCJIqeTIohQi/i6Lw3nQ4vtCuqQWJERC5ndfqIhdmkxBYzKKX2bJ7RhRNs5Nalq1ugVuQ3EqT2V2kcQ+AsTbi0D8yj8onUUE/ZhsPNyuuTr59r6w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ff03a31-7578-4d2d-9d29-08d584b26fc6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10169B986ED7882B561DAEDDFBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(966005)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(6306002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tJIPeFqIAEiUihnrkuy9PB3pY8kaqvmDbx87el8l0j95vKlz10LZsKYcVV6cZHh8sTJIJ3upV+TL3RNLZeHqxr2hhBoEJlBD9nylcYTq80aZV0Fit8qc4MTEl9OkVVM0KiArC3KH2T6gplqqZ8qEOjBc47PrcsoZjoUZvQOaqFxfDYbwt/xptAH5NKB9wjJhCYT0VDfMkfSRDFsLfpow4lX7zgymxJFKZvybHO62wfyJzS2aX5xFayBLIh46sQbLch+hd2xrkjsqgTk1OfoHoiJtVmQoCaqym/Tq2ux+eKYBYy0eKcu3KCRcbQambh5ipSKwq754g432YP7DMtmpBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff03a31-7578-4d2d-9d29-08d584b26fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:06.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kim Phillips <kim.phillips@arm.com>

[ Upstream commit 805b151a1afd24414706a7f6ae275fbb9649be74 ]

__kmod_path__parse() uses is_supported_compression() to determine and
parse out compressed module file extensions.  On systems without zlib,
this test fails and __kmod_path__parse() continues to strcmp "ko" with
"gz".  Don't do this on those systems.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3c8a67f50a1e ("perf tools: Add kmod_path__parse function")
Link: http://lkml.kernel.org/r/20170503131402.c66e314460026c80cd787b34@arm.=
com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/kmod-path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 08c433b4bf4f..25e80c02230b 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -60,6 +60,7 @@ int test__kmod_path__parse(void)
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
=20
+#ifdef HAVE_ZLIB_SUPPORT
 	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
 	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
 	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
@@ -95,6 +96,7 @@ int test__kmod_path__parse(void)
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
+#endif
=20
 	/* path            alloc_name  alloc_ext  kmod  comp   name             e=
xt */
 	T("[test_module]", true      , true     , true, false, "[test_module]", N=
ULL);
--=20
2.14.1
