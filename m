Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CCECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4606F21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NM8pRAc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4606F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeIOG4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:11 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:43118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbeIOGvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yI38rApRBORXpFNRHatC7JBHb1fvcSrXFIL6Yu1/EI=;
 b=NM8pRAc9Hij+sZ3gRBJU7CNyRRvXNGwh3v6wCKvY0JfkQLmsoMOFCoMjMUZVXMy7VzWLhD18yPqhg8SQnt7N12ELx8V7+c7F7SlbrxGKzsBjLvz6ob2a2a3S+6WYwNL9o85aiY57GlV6PPqYQMr62v8b4INxdaiq+kATgsZAQ2E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 21/34] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Topic: [PATCH AUTOSEL 4.9 21/34] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Index: AQHUTJREB67IwLwSJ0aIx+O68QYpQw==
Date:   Sat, 15 Sep 2018 01:34:38 +0000
Message-ID: <20180915013422.180023-21-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:M4yIsulF37gSxpF/aqYBxbLbJlPTyxDXDdoG5c6PenGLLrdkR4LOL+frHGmfhipkfjcK8wqjYNNO0lIco2RZUwxfl3YirSaGm2g7hwrBmh+RqwN1YpO4xYXNyamCHrGNAxt0ggCupPeHV6i+NseDkXHldnXWSIyJM7gZl9n35xZVNwShZXmkptZ8HFFQAPZ4es92q/1T+1CO3grV7ia2zwYebk7RvrGCsHYwO8wNVbwHS3mB+bpIX5iH8gFBTejaNISnYA5hNU5+2PfOauQRMXawUEdmsKP4of1yViTD4E82zv2JYDXlzpvY9HO1umF3vYRJLneVrFX4h4mtqePpkP/sy5naJo2KBMSxEnNZB96QavuIZGhUiyur0HENd3wC+Yjm385kqwxZBlkzcF949ukfhrmXwcojlxZHQdxppwsF3E2cYBnHULzsGS5p3taKhrE4dqPgbXatnDTQvJZL/Q==;5:y7lOzwyxUDS/211hp87KaXjh89JA9KHofhxf7pnXV0/NmoorJYnAGtrXZCRQWUB/5MB0+yTTD1RRDC2Ze0IMZV1FHvbIRdxmhiVbKPPnYeznK1cyzEUSX2IwasAJ5owAMWJcpnXTADMxZnNvECp8sw/qXp1DLful7pbtAa8MSfY=;7:TUUNTT45ODxFfI2o9XL4RnHooqEDbGXE4mrbLeKAEc8Uf1KYitSV4hMreEqK6TsJOYDSF02ndClHRq66x7qcToLk/bT9Qmj3C0w6MmChQ6tPSKU6hiSXVmmWS3+YQVm9vQz5rjS/8syusLoo/3bKQKHZg1RRI55B6SzPFrC83geI5XryUA66UCJcfA6+zISKLwCFuC/mkLi6Nrij7rXmdyeaIJnf+20j6pyO/iD1VVE76tNNmRy2ODTxppZWMMLi
x-ms-office365-filtering-correlation-id: 8ed21e8e-674b-4939-7b33-08d61aab6704
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08234651E124795732E785C0FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Zu8vzuZHdsxXTJ6cJSeTyHxh+n/hChGdIQl5Xp7Ytbmg2vv84J7jXSOsaBiRDdYdEMSAhfpDsEtCRDkGtavqob5oWdXXwyMmLiRsOe+Qqys2ONzJgGinya5O4uU7EhRpjPXXwPY29yV6IAvqLr9bs+Ay/pXV9UG8DU7un4NrYxdCJPEH1amGi25tmVWsCuZvLI6ZjmPxzHiKgzeosu3CQ+FhAo0H3siNdl4WyDDGC7x5nZIuV0lnBsCWVnApbdZaURM1RKa5sTKIT+W3bJ4z2f+ozhxfauVuukPEN/GLh2l8/I6sUk0YP8A7w5DPBwfzr01uRfd7Sb2yzSje5WAHImvipmIXyLx1Ey026ROd5qw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2102C2EB05F36A478A210FA8604E1CD8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed21e8e-674b-4939-7b33-08d61aab6704
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:38.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
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
by9ncGlvbGliLmggYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5oDQppbmRleCAzNDZmYmRhMzkyMjAu
LjZjNGQ3Mjg3MjMwOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCisrKyBi
L2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCkBAIC04NSw3ICs4NSw3IEBAIHN0cnVjdCBhY3BpX2dw
aW9faW5mbyB7DQogfTsNCiANCiAvKiBncGlvIHN1ZmZpeGVzIHVzZWQgZm9yIEFDUEkgYW5kIGRl
dmljZSB0cmVlIGxvb2t1cCAqLw0KLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZ3Bpb19zdWZm
aXhlc1tdID0geyAiZ3Bpb3MiLCAiZ3BpbyIgfTsNCitzdGF0aWMgX19tYXliZV91bnVzZWQgY29u
c3QgY2hhciAqIGNvbnN0IGdwaW9fc3VmZml4ZXNbXSA9IHsgImdwaW9zIiwgImdwaW8iIH07DQog
DQogI2lmZGVmIENPTkZJR19PRl9HUElPDQogc3RydWN0IGdwaW9fZGVzYyAqb2ZfZmluZF9ncGlv
KHN0cnVjdCBkZXZpY2UgKmRldiwNCi0tIA0KMi4xNy4xDQo=
