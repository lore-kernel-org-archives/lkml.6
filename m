Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D48ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A0620693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="enn5m1fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A0620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeIQIip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:38:45 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730581AbeIQIc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQr/yfEXA3G9cFb1v88yGqG1kXzQcF9MvvjHy3ZfuwY=;
 b=enn5m1fG/XEPKbZGb63a/pG+JCJdqJnTc5ceh3LuMbjA9wT2OBnlcXIfxPdUl/qUkAlq3L+4ra8rrvQAXPO/6jPV060xAIm4IPl5nZoyp9mfMCFczVV431fnrBF84CpG0v7ik3GpbBmZoJlTg25gKbWDLkh2pFLrtUZg42uSZks=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/43] x86/tsc: Add missing header to tsc_msr.c
Thread-Topic: [PATCH AUTOSEL 4.4 15/43] x86/tsc: Add missing header to
 tsc_msr.c
Thread-Index: AQHUTjM354DdW7SdQUuYGAYYsS/L8A==
Date:   Mon, 17 Sep 2018 03:04:57 +0000
Message-ID: <20180917030445.484-15-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:jlsIPRbJWdcFKFGvQzu+sipphZhqWEMT+rmfZ2aQRBAsy1U/GrodHJdGrD8ggWGM9L+DQW9J6fYdKdd9r46HVX5FpSa8vH4TMQp8ea5Se6HmgyWangOzk0hbjOTIXPitP8CDKIwg6L9zHIvGpGvCwRA9ox1flu0fFzC1gcb7kMNKSdLRN9zOqNpz8f+BM6cMhCwOMd+Esv0YZZUJgXHEWWmGmOpsfbGEuj/0GGCgcdOxLXvdshwnVbmXf/qGv73J8/R+u/ANVJ+iaOKIlfmxi8Ucl+BD22y5fPZ8SAqrc2vO1F7pPmiO4CM6Isiubx16EUhDZXjuSvu4yexCBmDCQRGPgAeYHPwgMc5atS59H+gKlFDctp/mr+DdqoblldjGYFesP4BJRDDK/waVCvT7iEEVOG38XUln4c9PowubyIyWRQPvtckr43LWX8eYRgjaKxhmQUkL6wQRxq+/DVlzPA==;5:VtCEZdnrE/WwGbNRMfhuMHRNZ7GtGrioa4xCA01yRZ1/RrppFgcI77gSuQ0LyK/Fy2OuM1ITjGzUcKexR8gogNZxVk5Ra/aby1CzH72SVYXirTvvOGN/bAJznsGtOFiZgYT9u7pyVVCRPQpi9pQOuqDe2rsknPi0Sa+38BMUeso=;7:C7ajo8dd8veK/4LemXBlfFgsLGS7NK3Kd8BLwPA8v4c2ZLdljmz/sgdHhCNc8D15c6R329xjUFAFymnQ2N53HvZXNTq/nmkSq9uXHDR94tbhk0OcBMKSBNfCudcJ3QNoj9fwRxSROrCxAvudvvEfbV+FTD85bcvRXFYOMRWRLPeZamk4aHP2Qb6lzdQQyKMM84cpmtN53Ip6xElIDQbb2SBEeboRZ47pcV/bfvEVLoXUNi6lb3t1txRk1hmEPxXn
x-ms-office365-filtering-correlation-id: b44d05cd-8760-424f-8f09-08d61c4aa689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB074207CE3881E1A0C7D74214FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(6306002)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(966005)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bBnLMfRWmfa2tOWfZP1LdUJcETnV+kIkWagVpB1imIjX5bHtr8gFzgVcjkozXnPJKNMKxrCYUX7iGMKNsX6hqFYK5zrXhVXx1EGFp8gkRzJDnTQGk3H8LXyQfraSTFV6eeIKoWhahhQWDe8Hv/JTKvzPrw1olUEnv9LlXELWqHcinmDrBWCz169Cwdi3LKgREz9IOoMfRObzVwq4keILylIsUXZq2b4L3cD7fEyS3KhmqG9M4EfMxPYAJ94N0fpUiRXQLAOMiDi0lIBMx1u20NYfcoyhbdiqTrypkAgoQJFThtjmJ6IhWt2iuvCobH+D/TpjvTY9hcuTts6GyJglKhs4QI0KSCSEyNXU2te19Hs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <45944D6F5024714CBFD62F65A1C152DD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d05cd-8760-424f-8f09-08d61c4aa689
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:57.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
bC90c2NfbXNyLmMNCmluZGV4IDZhYTBmNGQ5ZWVhNi4uMGUzN2UzNjliM2EwIDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL3RzY19t
c3IuYw0KQEAgLTIxLDYgKzIxLDcgQEANCiAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQogI2luY2x1
ZGUgPGFzbS9hcGljLmg+DQogI2luY2x1ZGUgPGFzbS9wYXJhbS5oPg0KKyNpbmNsdWRlIDxhc20v
dHNjLmg+DQogDQogLyogQ1BVIHJlZmVyZW5jZSBjbG9jayBmcmVxdWVuY3k6IGluIEtIeiAqLw0K
ICNkZWZpbmUgRlJFUV84MwkJODMyMDANCi0tIA0KMi4xNy4xDQo=
