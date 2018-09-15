Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01835ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A165720866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U01ePv6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A165720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeIOG73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:29 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725744AbeIOGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHoTLXRWrGm1y1nRbAJBJGMDjMQNVQU9tsckjJFJzGg=;
 b=U01ePv6rzmTbSTslw/6Ij8Tum2sOPle9yFe3jPy7kejzU61JtfKnwGeqGBrBaLbG0skMMU+ebWPehrRW+1ZeWWAuETosRxToQ4FHa/5jOBrlDW/b5REeOPuiR/Rx7Par4Q/cpfhQFfMxPRM47w4Llw6O6+eu3pioCVtZMnLW+48=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 39/57] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Topic: [PATCH AUTOSEL 4.14 39/57] gpiolib: Mark gpio_suffixes array
 with __maybe_unused
Thread-Index: AQHUTJQGnuIjH7W1UkqHvnNq5u8kXA==
Date:   Sat, 15 Sep 2018 01:32:54 +0000
Message-ID: <20180915013223.179909-39-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:QuGCoXZi8FD+EQpYg3nN0x0zesplnaCgf4YW5SO3oxR/OmvHCbap5Z/0QhhH2EWhUuXb3QugmnGwO2qbwxUmM1I/zoSASyxlNaFLuRpD65AtJVn9TSgkljhmVYOjlhxviadeJPOW4ASxVJxH6s10L8ZvXe3QR5Y6c9B306jT2mlZRVtgq52hjHEEz8s+zCDv0EI9yzYga7rCANURJYewGL/u3kHKt48sLPtQrqXVLXHgEC02MvrUGrqOO4CFYaqtjVRSO8z4Ox6gZ+G9FE0/2FbVd2TjYbhxF+FTB/q+WnEwpRj/vRsWUvVMex5p2l9K5MTZHxbTUVCDNWTOk3Sd3w8NjAMiaiGMVaVb5a4kzVUumwkkufhfOJYTcIQMqrN8ifgVfk7chT+0MTbplyPjWvI80pHCq7FzG0tHRXtovX50aUrcUYB3zpBevMdok/rLSlWqfUq28ZtmVBbUYOckag==;5:9W9L7hveHNHHzl2tbpXjhR7o+li/7H6bNbiBCUYTbBhx0pmk6pC0SykjvCtqWjxMgdjyMIDFkddVTw19DFSz9iyJKsh1Xa514V+QzPOm832p+Z+BVrLp3rFAQw8R0u9Uqp5l2USexpWt60AnH22wd6baR2gY7wvSeiyHDzCqJm4=;7:mHFKVSlcICLJGB66prGwjWi9tV/7mRo7BkvDg3/CnpV3IigyT9hT5ew3GLqjnRCTbFPuxgHVCBNFr4DFdJENtsTA34RM97zrd3gDQGMbcR6wSzFlr0sqwBSfWzDsTAYIOUHyDCx+IXQXjU/R7cXHHlZKkf2mHaUZ2Fg+cfhESbpty1Ul8QH5F0mr1QQoDwuAMt8SdP3IDqsYOKRd0B1dcYJtg9IvwC0snqr1s/4tTZqpDdW0tB5sX5siPw3e5W6K
x-ms-office365-filtering-correlation-id: c69c9f52-6336-4cd3-3885-08d61aab391d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471C579152B06CAD9AE676FFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qKUn/VC0R/0AT52jtdOdKAWJd6oMdQ/KHgj1/axnTn54pHXWxD7qNo7hWBEdBGn+2ha6t/5CuArzfJ5F7uR6GQ9SiYtqZwrJcPwG21IA8X52YDzYZEiaFJi6GoKXWETd/9oru2IZZpfjo3yI6t1ofoBiShV1X24J7DCEJnLWFdR6/kP4s2xuA7rNmxV27b81IpP8AuHaXywVfDHqBuqr2zaBzaDMzUF2RPAbHK54sns6iNOZmTx7X66tYN+amMjB/SAo8J4oh+ZVRyrEwf3OmPYziyvnU8uyzeoViTH3n7HVDxlfjhqrEq55OnSdwIlrWkw9SaY0J6MYYVawE0Pa9hZ4JseJAgqmQqWXATpMTQc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F844DC9064C7494C802FAD475A6556C1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c9f52-6336-4cd3-3885-08d61aab391d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:54.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
by9ncGlvbGliLmggYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5oDQppbmRleCAzZDRkMDYzNGM5ZGQu
LjdhM2Q5NjU4ZDc0YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCisrKyBi
L2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCkBAIC04OCw3ICs4OCw3IEBAIHN0cnVjdCBhY3BpX2dw
aW9faW5mbyB7DQogfTsNCiANCiAvKiBncGlvIHN1ZmZpeGVzIHVzZWQgZm9yIEFDUEkgYW5kIGRl
dmljZSB0cmVlIGxvb2t1cCAqLw0KLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZ3Bpb19zdWZm
aXhlc1tdID0geyAiZ3Bpb3MiLCAiZ3BpbyIgfTsNCitzdGF0aWMgX19tYXliZV91bnVzZWQgY29u
c3QgY2hhciAqIGNvbnN0IGdwaW9fc3VmZml4ZXNbXSA9IHsgImdwaW9zIiwgImdwaW8iIH07DQog
DQogI2lmZGVmIENPTkZJR19PRl9HUElPDQogc3RydWN0IGdwaW9fZGVzYyAqb2ZfZmluZF9ncGlv
KHN0cnVjdCBkZXZpY2UgKmRldiwNCi0tIA0KMi4xNy4xDQo=
