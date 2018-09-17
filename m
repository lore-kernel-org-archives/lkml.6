Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F20FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hsx2UJ5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F9B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeIQI02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:28 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbeIQI01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLgWLJU7s+8VgBeCkW+BaVVaqH8sPGsCP5EYEiadQY8=;
 b=hsx2UJ5S9ocJwonW1nhxzRBkjEazgbpmCUXABJHrwlZjQzdSc1xeiwTdBYHDWBUjS3EWC4engX6qcZaJEEx2XwqcPXAcUzA2idI8AytN7SacklgX7GpwPv6DhCEn+QGDMKnD1W6u5sdEIOc+CW3V/P+x7hcniMNgJJ5Fl2u0hRI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 043/136] x86/tsc: Add missing header to tsc_msr.c
Thread-Topic: [PATCH AUTOSEL 4.18 043/136] x86/tsc: Add missing header to
 tsc_msr.c
Thread-Index: AQHUTjKder/EociWnEm+lCA88D0ryg==
Date:   Mon, 17 Sep 2018 03:00:39 +0000
Message-ID: <20180917030006.245495-43-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:4jmcMMoc7DDwUfzxhEPiVji2w5Ju/Iw4z1xdTXAp6MTZoAO7SPYL8EwLBuTE/j7YYW9W/CqtAMWNgaK9EW6+7uLSkE80C5I40UxjwpooEoi4sh9IeG3AGjooXBIQ3hvnlMzJJNdm3cuZvQNa3NRJhR/XL/TqI9aSRfkCP0PrC93TbjnWt1IloBDdMUax44rlXllvBVzE/A/ixuJuyiQF0alczmhm2DztqlKKsfsixptHV+zo+js6BGDGYfDcmnF1F4xwAqj+m/YzHQb875tZWBNRnWMM1UoNmPaEEsZHSa4b0+0LrNhECBHOFjDFlCYVRfHTG4+dbEnFhhp1VBLKmnetI2rtAM2UyZUutHBzRQCvFHNG5Mp1phmReeqKFmZdui3QGvK+UBsC3mbH3sMKYG94l6MHJScEFDyE5x9umPWv9wVZj/OcjW6oH389qPUPNCOODqn/AIhmk6kjSaSrjA==;5:uMH/1306HGnCpZJAXltCYkpu9IS/TDj53RLGmTp6aTDpPdkCOIs1QMT+SbOsfXXZZxM+6XPEKz+Xt1OZtv7IovZ8YF+IGK75QOJp3RBJjr4nQ4tMmxXrCnOzg2iCyO7V/Zx8eMsbGMduqgJXBo+mPxGdL2Wj72nW/l3J+qS/Bg0=;7:YIrdbwXBcELF0VVJKzCuo/gmPJGg1xUaiqoVYTbarocGmOcl7W3hEF6x6BsQ/gYIGtsg9DaON40Cqy2bO+QwvmXSTD7jZLDpp0UDsNO8Mjgfdc9ZNhpY26N4t/BOz3PoxQof1NayjJYJZDg54D3O1SWemgtNnh8JO/SdLuwRNg3X6RittV1aGANn19NKW05tGQAjURh7DlGOQrgvnSJhJ+6TPxJHO/XipUsqzjRJUaWJLduxlpV2m0gyHlqLK103
x-ms-office365-filtering-correlation-id: 244a8662-fcd2-4347-1f3d-08d61c49d1b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016781C779A2F46A6DE0428BFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(6306002)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(966005)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YFzCVFUd7y9xZREQEW/oKKKg8d7a7lnod82v3vcvyR3ojuq+2Og2fYghWue5fBw+sL301aLf9ZfW8vdYpWVIweA8Zv+qqWmH2mh9+LcViQntTG7zE0crrOetNRkmG3kTSfpiuVJQLHNvHD6EbsO+Uibsg6Zi46poO8zFlJzTVu5wmuvjZmX8YYWsbITTLvtGVlzepg+gX/hHyTQIIA71sih6HPwcrL3StY8hj2fnHKKymYUfqNusQEyAS7EjPFyEOffxVBtIekYQzKUlYBg6+rK3jrYX7PVz7qN0RmDOQzht2kponMqFXrXT6RZMO46zFfk57aKSQUkoZFlIhkMmyrPlZm7zkS0d5p7Df2h1nTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D9F2435B5608347AF49AA7C6B78A2FF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a8662-fcd2-4347-1f3d-08d61c49d1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:39.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
