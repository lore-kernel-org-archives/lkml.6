Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC7ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930DC21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BSosh8hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930DC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeIOGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:54:21 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729894AbeIOGw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPJ7YJdezD/1BFYQ1KcJtMSTyKGoctQMqdidw6Dxk+E=;
 b=BSosh8hunAoQYBaJ6SM+Sarw/Ph5DDCyRrpEK+MqsqjasBwFSMYEtJY3pTHjXgqrVgGtnn4Raccr3KINubNibIPqVDtNhjPzpcBPus1sed0wDiH/t1i8bZA2TthFhxtHfAJOwANyhTN6SYTBGiBWik6ckU4jt2e1bzMhkSSlFnA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/20] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Topic: [PATCH AUTOSEL 4.4 13/20] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Index: AQHUTJRYXyibpnTTPk2x1CGq3+DWzA==
Date:   Sat, 15 Sep 2018 01:35:13 +0000
Message-ID: <20180915013502.180110-13-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:pVGyuFIQk3UiZfq+2b40BkdZgcjqUodhirenwbsaI6BiGE/un09Buz6G9H028FHWVf0mXZQMoSy5xw44eMMzarGps2AmE+rnug6ViGq9gA9L/n2Bbe6Kc7JBBWYh7sjVRDCSYjZxprIB9CEo2d2YERaBWqyxy9PmKWJeo+XL5S6l4TlQNhesgkA55QHxQNZuqe8byS8YczLMTVmsDxECOh9+vebiNB1LVi5fz4TI78aoEj5/fIvI3WVnl/WM9csG6aajU+3d0TWNkzUCdtSORWDzg5BK6Ks0PtN6144ezz/0YXmI/QHNGjZK3+5xc9FfjvUgzxW8LuBRBNxlowlF4SrUSEZcSdW43IMF/jqBJuPhvAm2M0zY8kE9pzC2c91hRUeS6n8+A2kFzqGAxixCO1bCThXnMjv+vFbt5gqJxk2Dai6YTzW/mKJARNo8G8mLs1F0wNg4KRgIDDygR37kTQ==;5:rcPiGqB8uNTNz0Gw4SOkc+pUyUPtviwY3+5x11kyY6+K9RHxHwoGGAfAVxHX/p20n2gQLywYKWzIr8C5YhetFu9pW3rym8P34pczMOhzySSIlmw4s1Ijd/ZbJVaCD4abYRg5MIlsBIKlPAELEzx7M7dwWE6Uvqrs6KCcyHjGta4=;7:+tYrGW/AbYL2X4yAvNwXbaLw5CounW0GRayNQeGtLSVdoU+WoQnyUz4JteXMyha9W/pQ9uboLRPQChDna6CzgxDkfaNvQs4wHVLKjOBah+DRsgaSSSWg5pYnWe+BEsIAGmJd3ryhRkf5/yuYjQppwq7DdZ7QrfFglI3zAQaCvweJeZfdRZhmgwlYj5ipampccbShcYT51RZJtY2IUiPjC64Wu7n+Y+duggAXAVybI+JND/dawPC62DPT4fprNx4Z
x-ms-office365-filtering-correlation-id: a556ff17-7488-4a10-5cf6-08d61aab808b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181331ADAB3391516413B92FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vgogSgyfKIjCENqUEH49xtl/jMqJf5lU5g0iV9GSfC+pZERG2smx9iv52t3VkQ4ND8hrH+ntu5LRjhpPTyMercaXfRC2bpd6q6Rniw+wIpa+epPPYc4CVQagJHIo17R8g++I+iMKi0QzxSFMmck1vVitIZZAE2XgX5huYF99kP2KuTxV+NeFWmrE2pTb57nHIJcEE2vcezb4a6BlRhO50wN++IT8Sik0tJf+N6wrYpJEHGjuHr3v6w2UZx0NRzZnGUak5GusQpVHgrVA2/QR0aC05F6RwyMzH146QCxyEbh99b3orv8hYRA2bNoybN6vZ1ZVBq5/jw9hFYzUtxLHXFWqqaGTKpij+zlkH9ApgnM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <247F94C88367334BA519BCC3B19EBF93@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a556ff17-7488-4a10-5cf6-08d61aab808b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:13.0352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
DQoNClsgVXBzdHJlYW0gY29tbWl0IGIyM2VjNTk5MjZmYWYwNWIwYzQzNjgwZDA1NjcxYzQ4NGU4
MTBhYzQgXQ0KDQpTaW5jZSB3ZSBwdXQgc3RhdGljIHZhcmlhYmxlIHRvIGEgaGVhZGVyIGZpbGUg
aXQncyBjb3BpZWQgdG8gZWFjaCBtb2R1bGUNCnRoYXQgaW5jbHVkZXMgdGhlIGhlYWRlci4gQnV0
IG5vdCBhbGwgb2YgdGhlbSBhcmUgYWN0dWFsbHkgdXNlZCBpdC4NCg0KTWFyayBncGlvX3N1ZmZp
eGVzIGFycmF5IHdpdGggX19tYXliZV91bnVzZWQgdG8gaGlkZSBhIGNvbXBpbGVyIHdhcm5pbmc6
DQoNCkluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KZHJpdmVycy9ncGlvL2dwaW9saWItbGVnYWN5LmM6
NjowOg0KZHJpdmVycy9ncGlvL2dwaW9saWIuaDo5NToyNzogd2FybmluZzog4oCYZ3Bpb19zdWZm
aXhlc+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0K
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZ3Bpb19zdWZmaXhlc1tdID0geyAiZ3Bpb3MiLCAi
Z3BpbyIgfTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4NCkluIGZp
bGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwaW8vZ3Bpb2xpYi1kZXZwcm9wLmM6MTc6MDoNCmRy
aXZlcnMvZ3Bpby9ncGlvbGliLmg6OTU6Mjc6IHdhcm5pbmc6IOKAmGdwaW9fc3VmZml4ZXPigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0NCiBzdGF0aWMg
Y29uc3QgY2hhciAqIGNvbnN0IGdwaW9fc3VmZml4ZXNbXSA9IHsgImdwaW9zIiwgImdwaW8iIH07
DQogICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+DQoNClNpZ25lZC1vZmYt
Ynk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncGlvL2dwaW9saWIuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bp
by9ncGlvbGliLmggYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5oDQppbmRleCA5OGFiMDhjMGFhMmQu
LjA3NTQxYzU2NzBlNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCisrKyBi
L2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCkBAIC0zMCw3ICszMCw3IEBAIHN0cnVjdCBhY3BpX2dw
aW9faW5mbyB7DQogfTsNCiANCiAvKiBncGlvIHN1ZmZpeGVzIHVzZWQgZm9yIEFDUEkgYW5kIGRl
dmljZSB0cmVlIGxvb2t1cCAqLw0KLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZ3Bpb19zdWZm
aXhlc1tdID0geyAiZ3Bpb3MiLCAiZ3BpbyIgfTsNCitzdGF0aWMgX19tYXliZV91bnVzZWQgY29u
c3QgY2hhciAqIGNvbnN0IGdwaW9fc3VmZml4ZXNbXSA9IHsgImdwaW9zIiwgImdwaW8iIH07DQog
DQogI2lmZGVmIENPTkZJR19BQ1BJDQogdm9pZCBhY3BpX2dwaW9jaGlwX2FkZChzdHJ1Y3QgZ3Bp
b19jaGlwICpjaGlwKTsNCi0tIA0KMi4xNy4xDQo=
