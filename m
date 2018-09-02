Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A72C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680D2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CdbdNkj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8680D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeIBRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:50:09 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbeIBRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0BkPsaqH9Vpzf1Cb0smMZKZ1t/Zg07GYy0fZRVxiSI=;
 b=CdbdNkj/xQ3G2yDcsfhd2YR17g55dx3VUkCRmQp4Ryz9ZfaN+4i4dK4htOSZVerG8SxHURYFi9q9QjmW3iX6QNuXxb99Nn7Z1/NGCzI9CUQy8tzNLhena3xhMTlgCe0XgDgjk5EGt7la1kE1TWB88rfNzDC5bkSyxVgvSzcP/ZE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 044/131] perf tools: Allow overriding MAX_NR_CPUS
 at compile time
Thread-Topic: [PATCH AUTOSEL 4.18 044/131] perf tools: Allow overriding
 MAX_NR_CPUS at compile time
Thread-Index: AQHUQr1oWypYLum520mCi1Wa3D9OCA==
Date:   Sun, 2 Sep 2018 13:03:56 +0000
Message-ID: <20180902064601.183036-44-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:PJXTWEPIVFnWQCUiw6H/bddOYady/spg2InxOdIZDyOoHzpEufNQQ6meb1XsaMTlxTEEVd/8lMPHOBB0/8WIyG4Dtl0OdxKTErGMNpe3YXE+ZPRKCIinfwRIRNf4NP2o4tMZZF4YX9v6F1bKF8i5m3pza+5owIYeYNRxjocnt0kRrImQ/zKHOBhT0rbxqVFbJXsT6/pWz8uRHGrGt7zr7HzP2/okj6AsEHG/m2otYS3b7vT2bs4GD8DzlfPIM0ee4/uL0xLiN/HkxsQ8040cgt78JOIpUh9IyrSB7sXc+NjjMf7fZlk1aIxwNbtEtGatr+55cu8F/nxV4RPE6fWdir+nCCSjNDpYku4LMguHZ1pLbhyFnWYvd+OCfLW/bCIJwd/eskT9Sb6JkzED0dKhSWy8CSrK3ttPJyofJuzw9w1Fcwa0IsyJloeuqjVhIul0MC8b16UezkW9f63EHDu4Qg==;5:IulwZ5nHV0mcA6ogZjfU6agZbDW7yEbPaK0/1ZYu9MEB98IfwyZEPjT9Qw9A/OuiSZtLdNhyhItmnU0+IOUYrG9lsPQ+kiTFnalVAPeJB4XF1RiHK7Css/2d8/3yf+ISg2PzJZwR7QYq6ntq8oUcy1mXEHEbDBRKvPWr31d8xek=;7:vMIjy1PL6BwwvWuFdWKjYeCUExWME1nL+u4I0kcq52NjPulQqv5K4jDu8WM7TTCRAYrFFWq40Dpxucy/N9RwqGtml1JYbLogb50+E5ErSkk0AJG9BDImDBbyUVPTkphOwpBLLH/Nu1gEaXqez0/Ewj1JYveIp/BjTXzyjcr8L0lz16vx7q3R5R2zAxqqeK1Ot262RdDWI7la+MzGyLGhcf+rm9yz0693yyLYf5OYX6iu5uKS7Zf+433tZomgG2r+
x-ms-office365-filtering-correlation-id: e002f77c-5fe5-4d46-7fbf-08d610d493f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013589D2AD96160BF4BA084BFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(6306002)(2616005)(6512007)(966005)(476003)(446003)(11346002)(36756003)(486006)(106356001)(551934003)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bcjV2eqF6sBfjL6HtzKwnJxEeO9SUgAJJqcydBhFyRW4IIGvXavoZjfjJ00Jx9HBwMXthwLw2qTaM8xmV9AtCXZsBiOJT701Ooe/TVmSA3LAnh+dxnoaN3u+Tg0ufbJx5GgFr+6excbU8IU720pCM8dsp8cR9QLNk66/IT/ycYZLYuhoqfrMeez2aQ1MQSsXPI/ikvQhyDXgVGyRUCm5PqV1sItMP7PlxZCqbGI5/a/SoapunEGiNhA4K1umFxD2/BHz/3UuVj0IEMaEptrwA1ALqppopE/yy6hAesA+VeNI+2q0lhkRMPCmCvY7cf8ye+3U/6IFV+Q4FlIQFRSj0FW16ICWY+hbsNq/XuPnNUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e002f77c-5fe5-4d46-7fbf-08d610d493f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:56.5940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 21b8732eb4479b579bda9ee38e62b2c312c2a0e5 ]

After update of kernel, the perf tool doesn't run anymore on my 32MB RAM
powerpc board, but still runs on a 128MB RAM board:

  ~# strace perf
  execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) =3D -1 ENOMEM (Cannot=
 allocate memory)
  --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSI_KERNEL, si_addr=3D0} ---
  +++ killed by SIGSEGV +++
  Segmentation fault

objdump -x shows that .bss section has a huge size of 24Mbytes:

 27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3

With especially the following objects having quite big size:

  10205f80 l     O .bss	00140000     runtime_cycles_stats
  10345f80 l     O .bss	00140000     runtime_stalled_cycles_front_stats
  10485f80 l     O .bss	00140000     runtime_stalled_cycles_back_stats
  105c5f80 l     O .bss	00140000     runtime_branches_stats
  10705f80 l     O .bss	00140000     runtime_cacherefs_stats
  10845f80 l     O .bss	00140000     runtime_l1_dcache_stats
  10985f80 l     O .bss	00140000     runtime_l1_icache_stats
  10ac5f80 l     O .bss	00140000     runtime_ll_cache_stats
  10c05f80 l     O .bss	00140000     runtime_itlb_cache_stats
  10d45f80 l     O .bss	00140000     runtime_dtlb_cache_stats
  10e85f80 l     O .bss	00140000     runtime_cycles_in_tx_stats
  10fc5f80 l     O .bss	00140000     runtime_transaction_stats
  11105f80 l     O .bss	00140000     runtime_elision_stats
  11245f80 l     O .bss	00140000     runtime_topdown_total_slots
  11385f80 l     O .bss	00140000     runtime_topdown_slots_retired
  114c5f80 l     O .bss	00140000     runtime_topdown_slots_issued
  11605f80 l     O .bss	00140000     runtime_topdown_fetch_bubbles
  11745f80 l     O .bss	00140000     runtime_topdown_recovery_bubbles

This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
to 1024"), because many tables are sized with MAX_NR_CPUS

This patch gives the opportunity to redefine MAX_NR_CPUS via

  $ make EXTRA_CFLAGS=3D-DMAX_NR_CPUS=3D1

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170922112043.8349468C57@po15668-vm-win7.id=
si0.si.c-s.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/perf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d215714f48df..21bf7f5a3cf5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -25,7 +25,9 @@ static inline unsigned long long rdclock(void)
 	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
 }
=20
+#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			1024
+#endif
=20
 extern const char *input_name;
 extern bool perf_host, perf_guest;
--=20
2.17.1
