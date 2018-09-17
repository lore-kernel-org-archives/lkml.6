Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86507ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0DE214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jnb8x+Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0DE214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeIQI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:14 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbeIQI3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLgWLJU7s+8VgBeCkW+BaVVaqH8sPGsCP5EYEiadQY8=;
 b=jnb8x+Zq6Y6/T9UrNZheld3fd8H24NuiGa1O4nIU8wfUQSshcXfI+QJLYX/KX7tpPn4sWisTiyLAyvVhXnPS/4ZD6KiGEqEpc3S2LYqcChriSf3qkIT3/bHfgnuUtSLMI/zSesDtvCw5dQU4MCs3pFBRDcEmJOwb51yx2F2lsY8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/87] x86/tsc: Add missing header to tsc_msr.c
Thread-Topic: [PATCH AUTOSEL 4.14 30/87] x86/tsc: Add missing header to
 tsc_msr.c
Thread-Index: AQHUTjLmpIQarCDNdEiAlDTWIqaJwQ==
Date:   Mon, 17 Sep 2018 03:02:42 +0000
Message-ID: <20180917030220.245686-30-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:8aT1xY27sqrFNpSjdjJiU/iwV6kj+QWCbSDT1koqTbIjfSAZtsbgUjtr2QZztyFDt6SCg7+INllCFiCASG46PfbLjOaXw1p92wbaPT8x+XYRVJLSAA/zc6qe1tklKQNbhf13nMJURMw6S0hUZeyNdNEcUaeY2uwhmUnt5aaE4PAO2fSt9j7p5c1AcjKEYw1iCtv+StoreWWiGy0cKAk+z7ugoCgUjVi+l8nSG2OJVQqp2no0aD5cj8ZrJBRZLoI4wfhmL6DLILtdf8yg1W+aNY4D9h4kxbRwymKU5jMQBbGrKfFBREO+LHlEzq5eClHuWFGMfLchcdLyrFAPt2iJ39WApSs8sjmUoEKn/QLk7oXD7ye4pamB+sInr7DFjWQeG1v5iFwkCTL2a9WFdeJ3Y0Y+uCo1YCa6c6rQH+8nGVELO84MfcdakbKd40OyY5GwNuhS5M8kT03j9GpFV3x3JA==;5:YDkLHOT3KeMzH8DMFl2ol059YAgdhOtbn+6LXAi0fy13ioeLRQABu9Q6CuA7vGQfhw0IdDtE8kvgQVy2h5XUGgoJ8t07OzfcWkEMB4N/Yr3OUn+6RZqB2Vi4gBu6Q80YJOe1cHFyxUoDxVC2ynQiuuyoTObrWjFSYJwjGf/eAco=;7:u7P/aPzTWrwtPeopok6/kfVAQ4RxfZkz8qj1rtKDtQKzMBGbIRuYZG1BqiiKIJ9J7g+wJlsQLkEgccu/0K+rlXG0cqvwH/OFeNbdXpi4n7htTXwXfwPwA6wyBiRavR6cZEtvjgv9oKZl00mFpcZk5BhxDXQlS0zWMKoT41DAnHMP1W5WE0yvVYGNc0tG4ku47NipewVhNAO0Eykxo7vMITMfYpPS2kviz2zHaObovf7kv7HxU7w08/vXqQbvMqOY
x-ms-office365-filtering-correlation-id: 3d02a5a4-736f-492d-9caa-08d61c4a2bd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470893644F39E62E4A17E75FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(966005)(6306002)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FJv5WDeywQZkbO9v1ri8JlTBD24yznVBe1AOojTUOy5x67o+TIOn8l7vWyHFE5cud7zo674rZqg+9cDaBlWvGKAQBxoahD9nKos+kqICCUdM0FdSs3bqI4VSa/rkb6PcpWecL0a0Jxo3GSZ5tAYrRKXXh+IZJxhSqZPDdR+Zea/cd0Iqf0mlyrKF7JM+E5foB/2tKpTlLlUURuGhpjprEJ8XeAUbicl/kmhLQtoA56IxyygW1ABQCzzBvMK53Cy0dq12fWpFyAzNEiuvaoqhlvgfbcTGYS5HjNjriI/6YhNYcTq2d2OdqUVEhATxPeBkyJ0Drsfk09Ld4ZR76u9awPsHyDjnHGprSrOOwlB3Ouw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C39082BA87A6D4B84BA086B25F4A687@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d02a5a4-736f-492d-9caa-08d61c4a2bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:42.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
DQoNClsgVXBzdHJlYW0gY29tbWl0IGRiZDBmYmM3NmM3N2RhYWMwOGRkZDI0NWFmZGNiYWRlMGQ1
MDZlMTkgXQ0KDQpBZGQgYSBtaXNzaW5nIGhlYWRlciBvdGhlcndpc2UgY29tcGlsZXIgd2FybnMg
YWJvdXQgbWlzc2VkIHByb3RvdHlwZToNCg0KQ0MgICAgICBhcmNoL3g4Ni9rZXJuZWwvdHNjX21z
ci5vDQphcmNoL3g4Ni9rZXJuZWwvdHNjX21zci5jOjczOjE1OiB3YXJuaW5nOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yIOKAmGNwdV9raHpfZnJvbV9tc3LigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQ0KICAgdW5zaWduZWQgbG9uZyBjcHVfa2h6X2Zyb21fbXNyKHZvaWQpDQogICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiAiSC4gUGV0ZXIgQW52aW4iIDxo
cGFAenl0b3IuY29tPg0KQ2M6IFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBvcmFjbGUu
Y29tPg0KTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE4MDYyOTE5MzExMy44NDQy
NS00LWFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbQ0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYv
a2VybmVsL3RzY19tc3IuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYyBiL2FyY2gveDg2L2tlcm5l
bC90c2NfbXNyLmMNCmluZGV4IDE5YWZkYmQ3ZDBhNy4uNTUzMmQxYmU3Njg3IDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL3RzY19t
c3IuYw0KQEAgLTEyLDYgKzEyLDcgQEANCiAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQogI2luY2x1
ZGUgPGFzbS9hcGljLmg+DQogI2luY2x1ZGUgPGFzbS9wYXJhbS5oPg0KKyNpbmNsdWRlIDxhc20v
dHNjLmg+DQogDQogI2RlZmluZSBNQVhfTlVNX0ZSRVFTCTkNCiANCi0tIA0KMi4xNy4xDQo=
