Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED3C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A62075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aPRgP+iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5A62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeIGFhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:46 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbeIGFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkkhj2Ld/IAK/+PIUo23XnfpqXFSWLJBlhwmWU+i7fQ=;
 b=aPRgP+ivl+mB1lXBw5ShlNbR9F6bPo3+OTS+8Is6VKvezeJld2VKCYWZit36tw52h3muxC6cSSdAI8wmwpuvMZOLg4eB84yqvj9XVXJETr35JIliX3AJXjNC8O+j2FJqkiQ0XfY8bX0wCk7IdvW/iIQvgoDv/flomSxa4LMhyOs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 36/88] perf tools: Synthesize GROUP_DESC feature
 in pipe mode
Thread-Topic: [PATCH AUTOSEL 4.18 36/88] perf tools: Synthesize GROUP_DESC
 feature in pipe mode
Thread-Index: AQHURkLKt9QZwAkpjU+MAL5aLZNQGg==
Date:   Fri, 7 Sep 2018 00:36:18 +0000
Message-ID: <20180907003547.57567-36-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:eLxXfIv1IU8V/G4WL98GWMX8aYgHp9/xvSq8IIvE32Mg4oiU0wDQGMtxGfZsgzmAbhqY7wFzzPzLZqKKTL/kdE+qYPcg5ILlciPycLHLYCWibJg6n0rVjzgITSo+Pp/2VxiS7SnS49E3Ctp65fiisinYgINbxZgERsQt0ZwnyDO9qrZZ4URhJc2TuaigBLbWANyaZkQ7jheve1iZVKEcNIRIaU2ueEvox3jSEw7V07T28JV3dH8WmwI3tHahHSyWjMbofUOFfFHnTom92m1Al+uC8QhfJDcChg65WBp2QD89v0Zc46SLI+1DcwA4mAfOqxgI/2zjUximfWt0sCEEhx9KdIwJ/1fQAcsuY2yH5KglfLLAPbSkICwaFc7mLm9M2tIhprsP2eVxF6ykne2POofzse2aKQeaqLWUfQUxmsoYpdW7k3T5w5MUpalzLtOIlDXhTrYmHpzLlnk4Olj1uQ==;5:Sx0RnT+PHH2cWgClUWvvTN7PxqRch2PVCBC0UM7JTE9JjQMVoenGojcKmOKQGyQgv4+UbGOrq5OV/fbaxkJiNeYCKbZjdNKo6+/ZwaEAC9FFgQZxV4KP3R79BQvAXVHG3y2ZNCv2Tyfa8hdGiCZrC6r2ONDMGN0l4xaIKAWQQU4=;7:hMUYyI4NiOnQSo9TnxSoiH4l7Ki8rH7//Kf267eRVoXCtby2lIM7Os4ZSMejAVL6N68VGXKHmgxGkTJvQENcvoULlrIGRJR8T6ANr7i3iCcZQFMeyMQF6Jjkf50V2PMu/gvjml/BFXwQk0ju4gSjmmeSLvCRmObAI8j1qpGAaBvZObQ4t1ui2T2GMMZnPHTCzj7f1WhjcCrtr+Q91XOb/yQefHgqMRwy8Y5y/bzGCAOtuiINgoDqaS4Uiw7cobEi
x-ms-office365-filtering-correlation-id: d46e0d48-ecf0-4fc8-f4c0-08d61459fe79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773874B9A42FED2C3621377FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(6306002)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(39060400002)(86612001)(97736004)(6512007)(966005)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DxeS/+RYe8xO5/Y4L26aP0FSecMWL5+18pBdmMPmnyO6ly18XrmHe5zKkgshssXPVwm0Kv2bpfXRvEMkejScwC0u0pzul4EWp+uZ1W6GzsCnlm2SGO7Lv+1bCi+meuwWx0jbXEcHVcis3AYEEIWG9awYMeE/3Hyjm6ejLJc8tlPUaq10eTWm+3y9QvGOHgRxW/bpvRF2iKyI8pXfHy+D7qEM8P98nIsWdPDEYZ/uL6ftttegpXcZV5K63mZFoqGyBbukM7Yg+UETReixQCpPHhiUaOG7Y7EwmCX9gvgGM6R/N9hbKTckW3qF6i3lye/80GJB4Z8FN7/eYWB3f2eTS8PpLbJ2zOLr0ap7ZbCodc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46e0d48-ecf0-4fc8-f4c0-08d61459fe79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:18.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit e8fedff1cc729fd227924305152ccc6f580e8c83 ]

Stephan reported, that pipe mode does not carry the group information
and thus the piped report won't display the grouped output for following
command:

  # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf repor=
t

It has no idea about the group setup, so it will display events
separately:

  # Overhead  Command          Shared Object             ...
  # ........  ...............  .......................
  #
       6.71%  swapper          [kernel.kallsyms]
       2.28%  offlineimap      libpython2.7.so.1.0
       0.78%  perf             [kernel.kallsyms]
  ...

Fix GROUP_DESC feature record to be synthesized in pipe mode, so the
report output is grouped if there are groups defined in record:

  #                 Overhead  Command          Shared    ...
  # ........................  ...............  .......
  #
       7.57%   0.16%   0.30%  swapper          [kernel
       1.87%   3.15%   2.46%  offlineimap      libpyth
       1.33%   0.00%   0.00%  perf             [kernel
  ...

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180712135202.14774-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 653ff65aa2c3..5af58aac91ad 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_=
FEATURE] =3D {
 	FEAT_OPR(NUMA_TOPOLOGY,	numa_topology,	true),
 	FEAT_OPN(BRANCH_STACK,	branch_stack,	false),
 	FEAT_OPR(PMU_MAPPINGS,	pmu_mappings,	false),
-	FEAT_OPN(GROUP_DESC,	group_desc,	false),
+	FEAT_OPR(GROUP_DESC,	group_desc,	false),
 	FEAT_OPN(AUXTRACE,	auxtrace,	false),
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
--=20
2.17.1
