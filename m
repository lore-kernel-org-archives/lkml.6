Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4DEC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE381205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iNYP2Yjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE381205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeIBRaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:09 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIBRaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u1hg6X/vGlgJDPnTHk/hbvSylMP3zQo6Fnv3aFNKpY=;
 b=iNYP2Yjt8LzEAUgm/C4hVQuwqR+5gzApkGnKp5b6exLgDCRhG7B0u8mqt2FGJTScrQms4LBiJ3JrIx1+R6vCapijzuGfpVzJO2M4tEczMhgsp0ABznN+xmY7XYqHgrmYFGUUiFzqoFAyow5YXdwuf5Sf4NlaUGcVxdbAfEPghSw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/62] perf tools: Allow overriding MAX_NR_CPUS at
 compile time
Thread-Topic: [PATCH AUTOSEL 4.9 14/62] perf tools: Allow overriding
 MAX_NR_CPUS at compile time
Thread-Index: AQHUQr7bsZZviWzFUEOOE8KsfHiI2g==
Date:   Sun, 2 Sep 2018 13:14:19 +0000
Message-ID: <20180902131411.183978-4-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:A02mgKkRT+nsgjMhSoeLapYw/tkHAMsjY/3Dd9YXoWYoc0QGAkJLqFApog0L7In/s2C2ZDK9A7ubYx/PTQuoLi8WfRzn6D1PIzky0jltaYJQy6neSf6GHMzlY1mwDyBWNC2fKP9nPma8e08ntJycLlJLh0/dSLGVmoHYmIYjci17bDZUT+8F6lVEQfvXKEtTrFASII+JmKybKiR0be3lsqwWklPZYGvJbh5QXAx6QXBMN9asnB4OQ4V+lVSXwJza2pWOHPMZuTtMcM0qemqNDEtmsA9ASYg1IhP60gxq6Wm3qzKy4Wgwjd4MEhRS3wxu0Gs41EqW9UQFCsZA1hT8mbItowaPTIp5QkI/xwKgj/0R/9T4MAQe5K8TWCWmnPU6E+dnEQ/LvaJdL7ZVS/IdXLwDRkVPnxKV3wpjUNpNBSVpt3WctGq+K44zfSNoCPTd8JrQ8z++uZGl9OOsk/X8zw==;5:8cFu0fhnGy0lyQoEOx5H8ZeqlZktnnuD0fwPhx7pw98gGZHI4OdZek269AeICQqTYoO7awMeG0rVW60Rug8s8QGjdo/b1LfecHuLdfu3zu1YG8ddgnTU2wWaMnC1T2jWVXXbjLmyglehL7QMkFqjby6Unsh/jE2G5tAqxyNKgys=;7:jHsUIJzYmP+l7TSqQZtJxYGdVmudzLwUr/zZr4LLOBCjk6uXmOQdBcn1YO0h4oq/gC9yxg+Y8Thij7qtbns36qPOtbPw+UjUZAbUtmlLCEPd5eyVUywrurHafH6mpVJhmaqRqHaSZPArzK+pgGo5kgN21Pjl0rFpUfhsfdkeSn/GI5GnDQJCKl/7wxv/XmHOAQZTSbA2DTnQFwnN+wdMHHI8BzjtgpSa1JQxBnfzWm4eBMw2Owo4rKIs4I9+XjUL
x-ms-office365-filtering-correlation-id: 8e5f2a9d-9a6e-43a0-6ab8-08d610d5fdfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012045B7F82FD106C0817E6BFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(966005)(5250100002)(22452003)(97736004)(6306002)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(551934003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S3YyHMEoLtxmkzyNYRC+2ZpozGGjCDwUBEdzFhbd6ggx2N34OzGlfCp6YmmE1bGwRbYQxXGJXPPHQxTjVu22xg8Yz97KQ+2S2VqywMp+s5em9Zzom+8sX7Xo27ZTOKy+nffbarPKqkxZ5ZrRS2PRqOoJNnjYK04Yn6GOWp2ULTj2RstbDGHFWJOKVjcMeK+X+nif1ryBXYi0u8zt6pOBVRfRm9rFs+KHpKfk+w1vD14u7T/fXglH2q32LoCCUR8xNGFMn0IFCwOFgj2PmbQkREvv2FgJe1xUrYqIR4480cBJvMyXgJHVcXMY2qOUpn+FEzhbZ0V4ZGZJL9I5J+vXYgJx8Vf1lqNxy88aw4YACd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5f2a9d-9a6e-43a0-6ab8-08d610d5fdfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:19.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 9a0236a4cf95..8f8d895d5b74 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -22,7 +22,9 @@ static inline unsigned long long rdclock(void)
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
