Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498097-2-12980327017546058499
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498097; b=Hd15fls9ITSyoaLd6sggUVBqQaK29yGHGLZvDzUuVPZ1Ojc
    RE/eQZ40zCBO7AnyNbvE9rE8C3hbhgd8Ts6GZgmz+gDPo7ZMmUWyi0zY5Ehx2wab
    IlvirwKdIDF8in/b1l6noca2pU6Fb2PEesKhIsjiJd/4BeWNXpPBzcv7NWjwMOud
    1bJsMu1WouokvOhFE7WAKHaHdLqQxJ/9P8dyTqmdtU7MR1cajDh7izd8brJvyvMx
    sEG1oQILC0Ll7qv+ooBkqi38DzsLjfgFZkAWi62sR44hiLOmVHp9RChQ4yddLYDx
    ER24lM0kEJRs08QLmIYJId8Y0pC1xCR8ivvVCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498097; bh=AwoIcu
    NrHPfNdtyTT2i3dmmN7ZoAtiEB9Iu8VZY8Dpc=; b=E9nyZ3/BsqaQXzckEwtAqj
    M4Dl74Jk9bRTlEcNjfHfbD5fYkuICvsWGu9D/z+nUVQGySliljpI4nV0XMULRg/i
    Vz/1f8A/yGCx/bES9R8eMgPMx6HQ315g/42+HGI1PfvzJKdcx6G0GAtq4ziKT6aT
    +f8SV+wRw/5q2Iz3mb/A30+XAI2XA0j087XSdiRsN7tzO37pVP6AOati/H7+0Uec
    6TXnTplMpC3hNaT8eQNbX9+YQFV/h34VPMjBkVVts+32vGoJZURGuwfwBwtumTc0
    hzv+BzuPeECXx8EKld3q5lyFI87wcTeRUJt6cjnWufIqs2svG6RPHzshh1r1NXAA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJZlo6AG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtudegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJZlo6AG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtudegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbeCSPtQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:16 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:38940
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933855AbeCSPs6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 065/124] perf report: Fix a no annotate
 browser displayed issue
Thread-Topic: [PATCH AUTOSEL for 4.15 065/124] perf report: Fix a no annotate
 browser displayed issue
Thread-Index: AQHTv5mu+smBbtg5GE+h/A64dYLJSA==
Date: Mon, 19 Mar 2018 15:48:10 +0000
Message-ID: <20180319154645.11350-65-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:nrgJUfn25LDIAybVUmJJgclgbtIfFG5xhulZQJxRnvrksdwilEMw+geSHFodZJz1I9TWCxRn09jQ8ddF111o0459CQThCggZxdZrZZ6twsL+HNg2ZjNPryK7K24kAGdsV8Oh+C8IYX2WFU+7tWPrloX/DftUgD6iCJzmnGzQ2iKCDonXAN3zGia93hQNAy3/R04d0zchODeIPi3QlvbBEE9JNbbH3gOeYAoL70+SAFzJ7IawQ514Z3sLy/YaZUJz;20:u9vv0IrpnuaOOVo/zKN8KAfernE6rd4YhIqlyrYfete2oHtFNE9Fv09/JxKER1x/lFE70S1l+bmQyuSRh9Nf6+5BWyINW8Vkm6or4izJ0CjmxrMtZXuCfUpOs5vJ98XHcbi/W5L+pnnYC+f3y2N/BzL1Lh+Jr2QvrxCwaMOoMVk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52be4894-81bc-47de-d5a2-08d58db0e9a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936FCECDD2664EE29FB6265FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(966005)(54906003)(110136005)(105586002)(6306002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: xyxud2dsaSzjDHFbZwYoNMtvaKPFDeoLhwWP6loV1BS/qwP804HVVA9Aft89m40gHdyUUuvWRZbYyRVNOHhGdjIooeHWfkHVc01PfJKtuEeamPqGPkt6DwRP+j0Ro0WGO7CICucfWooEpWb96p9lps8cdksYiEA8n3ICWGqZ1aqO2EJ1vzWeOMFMlJwKDr7QYiMMC3hHdb0HhnBkNGm7mcVfcDSPda950VDVoNfaAFrWKeDmID5PzvrA1NBakmmvv6HDROPtbQ+/Mxk64L+ch6CnyVtJrJ1TB3c1egc1illl/YsRLQSjQ1IvIvyX0fMQxryLRYCpIUYfaWN52lwAtw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52be4894-81bc-47de-d5a2-08d58db0e9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:10.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jin Yao <yao.jin@linux.intel.com>

[ Upstream commit 40c39e3046411f84bab82f66783ff3593e2bcd9b ]

When enabling '-b' option in perf record, for example,

  perf record -b ...
  perf report

and then browsing the annotate browser from perf report (press 'A'), it
would fail (annotate browser can't be displayed).

It's because the '.add_entry_cb' op of struct report is overwritten by
hist_iter__branch_callback() in builtin-report.c. But this function doesn't=
 do
something like mapping symbols and sources. So next, do_annotate() will ret=
urn
directly.

        notes =3D symbol__annotation(act->ms.sym);
        if (!notes->src)
                return 0;

This patch adds the lost code to hist_iter__branch_callback (refer to
hist_iter__report_callback).

v2:

Fix a crash bug when perform 'perf report --stdio'.

The reason is that we init the symbol annotation only in browser mode, it
doesn't allocate/init resources for stdio mode.

So now in hist_iter__branch_callback(), it will return directly if it's not=
 in
browser mode.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1514284963-18587-1-git-send-email-yao.jin@li=
nux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-report.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index af5dd038195e..0551a69bd4a5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -162,12 +162,28 @@ static int hist_iter__branch_callback(struct hist_ent=
ry_iter *iter,
 	struct hist_entry *he =3D iter->he;
 	struct report *rep =3D arg;
 	struct branch_info *bi;
+	struct perf_sample *sample =3D iter->sample;
+	struct perf_evsel *evsel =3D iter->evsel;
+	int err;
+
+	if (!ui__has_annotation())
+		return 0;
+
+	hist__account_cycles(sample->branch_stack, al, sample,
+			     rep->nonany_branch_mode);
=20
 	bi =3D he->branch_info;
+	err =3D addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	if (err)
+		goto out;
+
+	err =3D addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
=20
-	return 0;
+out:
+	return err;
 }
=20
 static int process_sample_event(struct perf_tool *tool,
--=20
2.14.1
