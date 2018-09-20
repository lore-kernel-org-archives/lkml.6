Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFA621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ohyjwtFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFA621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbeITI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:27 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387539AbeITI31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOXqc7SGQZ9fMArXyy4XPd4j1NYdKGKPrlQH0lynAV0=;
 b=ohyjwtFXXZBx8NA6hKdwC6+JvYjF8F15ZaM7+5UR+T2SRDgzDTheAyvb1jBvtOeiqS77uWHF7KGau4BRJAlS7rouMhbseg8Q3ab9u7846Br6CIAjv+7ycR+uYYjwri9X0GDGPBlCCqj5DKvBDV/6lrR3JM0TyYCK6TPKY1RDt20=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/56] tools: bpftool: return from
 do_event_pipe() on bad arguments
Thread-Topic: [PATCH AUTOSEL 4.18 33/56] tools: bpftool: return from
 do_event_pipe() on bad arguments
Thread-Index: AQHUUIxS2aE5z43I9kqK3cXDyHN5CA==
Date:   Thu, 20 Sep 2018 02:47:50 +0000
Message-ID: <20180920024716.58490-33-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:OD+WG/OAMBkGjrQgiyun3Ane1qJ6PyoxpjkzTNO5U374RgUkgUPS2f5HmdaXwlpH1O2EWL0bvXdvQcn+vGdDHti12qH+HdL8EhV24/0ZQwWEA0smXwaU+3DMix1c0iGnXOhNLQnWcVYB1rdtjXoIKmcnPfIabXK+r1In54RJJL04doW/ZpCGC5xG/GMpcArfwYSTy5gjA5Qre+Lv3NXZW1Cl++4WivnRhbTvJMVAyOuRnf1qt/Tzcb1syVqgjyRoRF6Pho2y2kmeDZzHgeRVcU1DFBTlTQtiWnwR1vOuWhfyqxICtIAw/kvNnVhGrWfKwMsjuPVD5zvs0SxwXJyKq+DNIsEfH3CPUx+vj5EMHF9eom5VBt2xLmzsjAOhcrYipH3eruUYJujZAVGh47Mo4Laoc3Wk1NxeCVIqv+ILBjwl0WgimtZCCQua7TAaz8fYvlGfD/wLhDwsQwGgVFBTsA==;5:526Iln9gfx9h2HD+w3xkMjkOfipYzSnDUVD6VjQSDkaUWoBxSLxeXPyYim5PzKRo+L9XEa7ttY9rHSk1BBN+nLlw+TYZ6G05jfd8FuiaWJpk/P7jhhYydtK/3QwzQQKPWCgtKnkKwqPoWQq78yOMO5uehKns9YJ3UAJk+j3DPHs=;7:yza5Ypvv5MZFYOEMLYs6M3gwOqpwBlmelTAcIJtZnDAicXoVpgvN98iPSktvtiuYO4mICpHUn8bV93QVfR9dYAH3tr/MKfFsSNu0yB6Lbp0vYfD3dOlVjAz37kEjwgeabs1kE5QjuF8IhBC83gfsK/n3OBWqy6FC6mG0Gi68jbJVVIAR2zEzEKnBcBLocp26//7m6/KgjgVTcUXmuhKPY+sqUohtxJnmd7Z2FqMqtKRr30/5cAEl3N+WtEJ2aD3S
x-ms-office365-filtering-correlation-id: fcadcf89-bb7d-4ed7-c3d1-08d61ea386b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016596292BEBA3C0D308E615FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(39060400002)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jCxE4KyPbM792YcXLaIH+fOB+MafZRTLHHX3Aqf7KYsBaOGeNJb5whQHvqgCIpCAuV3Uher1+dj7Jn8lPz+lLSN6U9siINVjgHEwSuwZ7VlnOTYUNbUGRlCKB1nYuZxYlEQbuNfSRXsZ04I6ForzguAiLKXOcmZCDQTWaPG8DefziuK3JxGBbsG54ZRdcrzzA4fi5LeUqLw59+yOoyJPmvTgbEnF/PZ9E/dD+lrXGetpBZQoSjjIoSxKyd5vW2FB/cMK7AEZRseB30rWFtloGaWmsWVwJSLApHxZ/osKyRDr9XaHUhTJkWvVD0NWw86c2J7GPxm9//A+4H1yKeR5hvvxAleDNC7uH86Xzd6TBd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcadcf89-bb7d-4ed7-c3d1-08d61ea386b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:50.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit 785e76d7a2051a9e28b9134d5388a45b16f5eb72 ]

When command line parsing fails in the while loop in do_event_pipe()
because the number of arguments is incorrect or because the keyword is
unknown, an error message is displayed, but bpftool remains stuck in
the loop. Make sure we exit the loop upon failure.

Fixes: f412eed9dfde ("tools: bpftool: add simple perf event output reader")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/bpf/bpftool/map_perf_ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf=
_ring.c
index 1832100d1b27..6d41323be291 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -194,8 +194,10 @@ int do_event_pipe(int argc, char **argv)
 	}
=20
 	while (argc) {
-		if (argc < 2)
+		if (argc < 2) {
 			BAD_ARG();
+			goto err_close_map;
+		}
=20
 		if (is_prefix(*argv, "cpu")) {
 			char *endptr;
@@ -221,6 +223,7 @@ int do_event_pipe(int argc, char **argv)
 			NEXT_ARG();
 		} else {
 			BAD_ARG();
+			goto err_close_map;
 		}
=20
 		do_all =3D false;
--=20
2.17.1
