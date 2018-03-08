Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488655-2-16018274214669094297
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
    t=1520488654; b=VqQo4o/GrpYlnJ6OTnoAdX3jAdCsMIPT2EMWcvaE35Rz8G0
    rkTbHrRUi/yGdV/wt3qHT7I0DocWNVv6ZB9aYyFH1OQqyCLynhA2LD73s5nuJlKp
    i0V/I4w9wDKB6By5F4B5rXkllZkYKJaTUqNJAy1ftnax1bxXzvhfXyADb6jy8f5w
    drKALSxGekXlpTmAAme73yIE4TF3BwXYL8z65phvlYkhSEOsJuVshjHpQBTFcZ3b
    ZB+H9LbNaiXMbRSwhJOY8qQWlaRS9Go7h/zQNXVexykVmIh9rJC7zpSjLZWXPL+k
    0IjDaEZ6a0kVRxle96+jtShmLxQh2gTihYqtpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488654; bh=gfu6mw
    uEmQMBn1edDXDFfiJVD2lwwnt96CE/gAglf2U=; b=in7PJlzye2LA97wj6IfMOH
    F0tVBkmfGCx6ZX84/1/TlwK0fEDQQOvY7+3MG95Ffhfj+KDG9kOjkAUH7VQ/Lo3M
    CnwCoH55cdwabriZ7+3niS71ZcKEXEDmkNPQLUYmTI6KD9F6wGFoTcy0Mmg8oRLX
    u8KmQaKg/0sC1oXJTzLh5oMsJ7RFwGto/ypTWtCfvg64SC6Mi467b6g+r63Q15it
    lIJiSnPrBCSe1rXDUTOtG5uBz+9QEODZhgPrAvDQU+9PKpw3SEsjtzRk041URA7c
    0gb4SudRLngGPeGTILrM7JsXs1tSVIDzxO3+aDJ8+9hjZrLYp0OA/QBFjshDBUBQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NtIO2ShZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NtIO2ShZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965786AbeCHF4q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:56:46 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966028AbeCHFDb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 150/190] perf tests kmod-path: Don't fail if
 compressed modules aren't supported
Thread-Topic: [PATCH AUTOSEL for 4.9 150/190] perf tests kmod-path: Don't fail
 if compressed modules aren't supported
Thread-Index: AQHTtppOLy3uSm9yykGfiFtYH4dtyA==
Date: Thu, 8 Mar 2018 04:59:58 +0000
Message-ID: <20180308045810.8041-150-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;20:ad6OiCAg7v+Zjz//PXv8p0U/tb6bdjFVoWwfwiw6kSDHBP8Sd2/HtboXkjv/wC28hbcGuGmD8oi3qHBWeglGNWjo24KPmXDD6Vle/QbmEhjhfyQhRQnhh6GLAlwculC+EgDJ4IE/I2y3IDiMw71wj+nMHyGi+/dWxjhoQvWqxFA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdf6f3fe-ea82-4948-974b-08d584b1eb28
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09026AFA48DE81318716EF50FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8AW4bng57NZKy/rsLX9M7wYkSYVakzB/wd3Gu9W8EjBhUgwmURrf8sVGag2Y5ZUakR20WhWdonxrpiC4hgJIu33cD4sXBD5icNO6MKC5syC3sGijc+a1eQ3JzScJMjG1b8M5ASj6CK0SGoTfcF36krWIAjVH0jHZxJG9OV6Vnzgkh5q4J1pBIemAcjY0Ic0q0xy9RzUPDh0AsiLVnSkl+ON0pQzmO8wNWX8+XRlO9IF7oeSPx2b9xfkbEVHAq73uwb6rOykugd/jTezPB7e4pYrit0SCMdhCXrys/eOu6NC4DwaWAFzpwr/bVHMAisCWFDJnrI44U3y89aOJYUSjzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf6f3fe-ea82-4948-974b-08d584b1eb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:58.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 76f41f249944..6cd9e5107f77 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -61,6 +61,7 @@ int test__kmod_path__parse(int subtest __maybe_unused)
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
=20
+#ifdef HAVE_ZLIB_SUPPORT
 	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
 	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
 	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
@@ -96,6 +97,7 @@ int test__kmod_path__parse(int subtest __maybe_unused)
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
