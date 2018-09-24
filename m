Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A62098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QVzd14a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701A62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeIXUv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:28 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:35136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732197AbeIXUv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVfk6CPTrSRAZv50tErZhCli+PqXSrptk4hKM8b1rms=;
 b=QVzd14a+1qsg6BGUl71IxY0P8okd3dC3qG1ztiwYWCZ2gTbi9qonAjcMbR0LD619fvJ4gVOnbVp7cRyjh852G6vPTVGYMJIChJHcT7BAJestUMuYPKZMygGVFOMAov1CUBKEWs9TSiUEMAOMZzkGb4jds64vCgZ2liQXqvzWHWc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/76] tc-testing: add test-cases for numeric and
 invalid control action
Thread-Topic: [PATCH AUTOSEL 4.18 35/76] tc-testing: add test-cases for
 numeric and invalid control action
Thread-Index: AQHUVBWkHKTB/oKb0E6RjiqPOMt9Zw==
Date:   Mon, 24 Sep 2018 14:48:22 +0000
Message-ID: <20180924144751.164410-34-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:1MGfDTZhSB0OT9eSu6RjZEg1+MSqyl+4PbV9altlevyVTPyf2on835RZYAPIMO2MUXbCfes1YVe2b8Oz8nWeCyuaBPuK8kzfxKp9s1WJ8Np9/9lflIulsEssi/ICUtIOWXqf6tfNlRFN7hYYhl5pvSBRElhOMp8MelJovgEC5mvsfbHyPtrRhzIpC9FhO8prxMCEFOZXxeH/mVs/TP25ojigFZ4zP6G7bCJ1upYK7m4iCwqCWhzgTvsLJjRnUhx9E8W1CCNqE/0egTXQWgtElme6+zmbxyhFClfHHB52Ef/7lJhiyMS8G3eunBgE0I0/syHF+qA+b3tdBnNFnc7xUmrrpCFd+VqI+rUGOVW9o5IGHpN8U8LxPsUxGJOt+gThAQHBGLd0CSly70JHQI6cld2N2JsMPd4lM3hS1kwqpTX9EiKj9cbihocx2cetUBCpUVy3EEg3XBR6e8mioF9nfQ==;5:SXS2kl37xtg7EhpS+CJeS1IVQm8IvirXAcAOH+rDOqHh4zMYeHf+RHuEH92LRu+cOT9TDVlbZisyqLcf4sZTUOMDk/27RgzJQhRWrH2voMVodtYutOLuyJQ8Lhl719DYg1bwsAENT2qSUl8Wy/qbr49iCyr4dYCddDq7iFD0CcM=;7:8hT3Wt5E/Z0YhrsJG6yVVyWnza9ws6F4LrsQA7QwXY+Nvjvbuc3A9rhIkYme0AhPKHOT3DMaDaAdK1vW4wg6F7LsJ5092uEE4zl/PAeliQMNNY32Kf0/ZE+DmXKSAEZczpGIK3v5KWUm3icptxgkRMfe5SGmuqg1ZS60HyLEyAfWDT21LNa31r9ylV/2rkN+nJVwYunWcFPuDsjbmJ1BGKjCFZnxNHiLY4qJhQ3tyC9oxezFvX1rnLxyurP4Af5/
x-ms-office365-filtering-correlation-id: 91198cf0-6918-4382-1ffc-08d6222cd839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855E1AE1E9C7A51B0F9C8E3FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cVCvWL3Jn81aTGJHUiUli59frpq/9T8BX0rE1y7xQhzzkXOPduL8PQgvUf5Pl/UIIlaVvlV7Sc0SUJLoH2lyCe2Ah3sT3p2jyJKXOFumXV9pXM5Bqm42ngouD57XM+74tVhSCnemXbJi/5mWlPuKd/SdMI8cr7hRliVj6P2WNFeRewFQTiPLAQ/Bq+MxoBzYn4ZYlo5mhEx2xbm48ZRk0kl+46lKfNfwyEC2jKjCuAOJqy8ksdYSOwN/F1NLchzgjXpWPXAfRuV0LDGXMfsaxJSQVYauwZFEsZXUXAgklUrJOoTpiDHS6zDIClVUP+8x0xWyNm7lBHhylK6WDcX4p5kNaBgwzLiJhDsZ4ZNMywI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91198cf0-6918-4382-1ffc-08d6222cd839
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:22.6939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 25a8238f4cc8425d4aade4f9041be468d0e8aa2e ]

Only the police action allows us to specify an arbitrary numeric value
for the control action. This change introduces an explicit test case
for the above feature and then leverage it for testing the kernel behavior
for invalid control actions (reject).

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../tc-testing/tc-tests/actions/police.json   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/police.jso=
n b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
index f03763d81617..30f9b54bd666 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
@@ -312,6 +312,54 @@
             "$TC actions flush action police"
         ]
     },
+    {
+        "id": "6aaf",
+        "name": "Add police actions with conform-exceed control pass/pipe =
[with numeric values]",
+        "category": [
+            "actions",
+            "police"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action police",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action police rate 3mbit burst 25=
0k conform-exceed 0/3 index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions get action police index 1",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 3Mbit burst=
 250Kb mtu 2Kb action pass/pipe",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action police"
+        ]
+    },
+    {
+        "id": "29b1",
+        "name": "Add police actions with conform-exceed control <invalid>/=
drop",
+        "category": [
+            "actions",
+            "police"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action police",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action police rate 3mbit burst 25=
0k conform-exceed 10/drop index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC actions ls action police",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 3Mbit burst=
 250Kb mtu 2Kb action ",
+        "matchCount": "0",
+        "teardown": [
+            "$TC actions flush action police"
+        ]
+    },
     {
         "id": "c26f",
         "name": "Add police action with invalid peakrate value",
--=20
2.17.1
