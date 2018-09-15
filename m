Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34514ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D12208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TEHqcgyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D12208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeIOGsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:02 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728637AbeIOGsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW3yH/mHOAVSmNjFRWunxBDAOutyOdQoWJtaQhFO/Gc=;
 b=TEHqcgyceLkRPqhhJjMdCQ55RnUC3G4I9I4FP0HWpXyaVvdhnEvaVpblcOwPyMYVEkcZUMcuYgrBTRrwTMQyv3jjC3f5kZpKfGNQv5nAAz2iPN/4/h1BHCT4SurqC8Rl9fTTLyLQglXFt6L1IE45sbtLB5pomeMkRaYcywsU6TU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 58/92] gpiolib: Mark gpio_suffixes array with
 __maybe_unused
Thread-Topic: [PATCH AUTOSEL 4.18 58/92] gpiolib: Mark gpio_suffixes array
 with __maybe_unused
Thread-Index: AQHUTJOwrLaXkv3i2kKZombask5GNg==
Date:   Sat, 15 Sep 2018 01:30:30 +0000
Message-ID: <20180915012944.179481-57-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:E587UVNQrj8Dy/4zo0N05BuT2Mz2vdXmNR8l9jBWC8TUV/Sgu3JT4jI13Ga+rCwK5r17HMCYU94pjNVhFOUuHgNRJp3n6vgKCoqdu1AhN7OxtLEthMCediiDSMdLX6CNfl9Kge6WUMC3obyNAUlwXPNRGzS4mv6ZdO+dFc4lHkzYUYc2wYDtpFivS6b6evbkLZr6/OPgAJnXfDgXnVy7j4Bd1aoVtbGhRmVgiyiNiEmXKUKQY9INQZLf4Nt5TDxJOmJxC/OFVn3V3Zdc+ynSubA2iGxpJHU19SoQj8plziRJpRNsz7nojrYAovuHcady0V3mtTZeCgj6hX90c5xTuDwt4tJ6KGa/FLqt59JrSkMJrcQAf2DoNGdbaTbbms1/tDUY6CuRnFc3V4KMfCqf9aSY0k2KgUnvrja69KX/uJOjvLdrazzkXwDAGQWoR3vZwMHbHdTKVn4LId6BfKzaKQ==;5:BybCv3es9L7DlogfJR51uWkUxk5TFj37EaoOSldDSfQD4Q5D1By1aNs9ohnGJ/jew2Mmoo/0mr7+bSM2CBEBrgnbbA0pZh3wy3o5oWh8uUoRk6ChUfPfi1GvUANE0dUF7C3oZMpPAP7H2PE2NKZh4m8O+ChAeotM687x7wIjqaQ=;7:EuJ64waBlNcg3QNNXUPQPgDMkYawIUCyOqlqH28KQisa0e3sxb+Xtp3pf21tczzKY8J5zi+yEj0FbQu3B9olMzkIonV/z0e6ZtVRTXpoEbnCAxlsIwh9azJycHaNt5ChdCUrNxNqe8K6N3qWuwnDKi3H06kep3I+gwR9i3cBmvDIq4hltvQnTAwdK5ATePkJiMiup7R2cRd8VwOhBye/kHdMbQccQ4dyoUkQGjzIX6ib104tlC5qCLRc7dyo2tNG
x-ms-office365-filtering-correlation-id: 0bff3592-6a1a-4fc3-f13a-08d61aaae316
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB074136AEF6CA8C64C91C2F0EFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CWZKHm/4jPLKos8ssVhOHIeyzZM0Eoo7YHpuox5Fwf7A1vXmZSJ3Jhl4dOc8wYi7CGSM8hkn+1GMDoU8aKz7eQLJMSc+RQG0lFrto0K23zf9iJi4uMTiv5hDZe0WODKoOfueD3iCP1zjFqZZ51jkDZfc5Wc1vZuB+IVf74kYCNoXfU7LQHEWi8TzlbPiGF3RlGs/O9aW/jNDNn2gGZKEvaE+hK4knOZsKL3YL0cbSLFmr2CI492EM5LZ6ETA9ztAY89U+e94bmXjs7xqXU7DkeRN+M6dnyRt4gTX1jGRFTEKmicvYXGevhzQYgaRzCsHWzqQbL36SHah0rWhhHEhFTmyMLx9qiBhes80i5r6NAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEB61A1E4915D843992F658887676D9F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bff3592-6a1a-4fc3-f13a-08d61aaae316
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:30.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
by9ncGlvbGliLmggYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5oDQppbmRleCAxYThlMjAzNjM4NjEu
LmE3ZTQ5ZmVmNzNkNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCisrKyBi
L2RyaXZlcnMvZ3Bpby9ncGlvbGliLmgNCkBAIC05Miw3ICs5Miw3IEBAIHN0cnVjdCBhY3BpX2dw
aW9faW5mbyB7DQogfTsNCiANCiAvKiBncGlvIHN1ZmZpeGVzIHVzZWQgZm9yIEFDUEkgYW5kIGRl
dmljZSB0cmVlIGxvb2t1cCAqLw0KLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZ3Bpb19zdWZm
aXhlc1tdID0geyAiZ3Bpb3MiLCAiZ3BpbyIgfTsNCitzdGF0aWMgX19tYXliZV91bnVzZWQgY29u
c3QgY2hhciAqIGNvbnN0IGdwaW9fc3VmZml4ZXNbXSA9IHsgImdwaW9zIiwgImdwaW8iIH07DQog
DQogI2lmZGVmIENPTkZJR19PRl9HUElPDQogc3RydWN0IGdwaW9fZGVzYyAqb2ZfZmluZF9ncGlv
KHN0cnVjdCBkZXZpY2UgKmRldiwNCi0tIA0KMi4xNy4xDQo=
