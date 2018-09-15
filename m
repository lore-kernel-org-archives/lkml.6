Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA45ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BE620866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l/INTeQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BE620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeIPErp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:47:45 -0400
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:4640
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725199AbeIPErp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rObbNmb7wLJlq45mPhvmc4V5KAP67KEjkESFiNGm8I=;
 b=l/INTeQMvnV7L0XSwC1PVeY7zmFjlimkH20dyUdu6W4+qO7+Fi12reFqCB/++WjebF5ngtJo0KJa3h6kv/t2FDtYqCgC2oKnU0DUZW6wawSVyFkoI0fzVWY/fYxAprU1SIrnARMpQPHQcKYTJWCk4BYDhR5NZRh9gyglHOkve5g=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 23:26:54 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1164.014; Sat, 15 Sep 2018
 23:26:53 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: RE: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Thread-Topic: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Thread-Index: AQHUQDbK9F6DjBHRQ0uTA2wSQ09K8aTyFAUA
Date:   Sat, 15 Sep 2018 23:26:53 +0000
Message-ID: <CY4PR21MB0773BB754D1B949C43B591FCDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
In-Reply-To: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-15T23:26:51.6752990Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:HtwrRZWgPe6hqER0eRD9biqahICxbVxRgxVfDX0mCy8RD6g9SH9mfdL7slhZSFfgUiH3bhqAkPd9wzVVNdwGLjp390UvqzQEDhW4vDB3Syz6iBQiXEPrnzenvOx3jGiVOs1jRx4qQuRDIJeCr+BiCpZxTEWNrBzMbGvI0CcHC1Whr+4b0v0WMkDiMOtN3YOgUIVAll/li4perZcWOO48Z8XO+kEc48zV8Ycs0NVzYMDR7jA99Dmug0RMZ1faSVhhcondY2kWwfhz3zoN5lcEDOV+u1MnAaVPCrvOZR6XAQL/XIt2DPG3gQk+fn7MiCJ3an6s/PJCzVcWkSgna6W/P3McmyjZp6Ih5ZXTp0gzQkb+h44iDR1ficy4spRGnX1gkia/YU4WLgB/1S6wIkEt0u90gOEdmGBR3LKdOoYvefYIQvwSd7UiC/ODrrdxKnWbOGlL5Rn4qt6F5cI0iGPcYA==;5:W1CHX0jzFPmuXMViOKH66jeXI5f6MRH82TkpY6+1XnNS+Y+CA8QxgZAGToy05RggcXyEvi3BUL41On6P6iL+ikY3hNdWQ3bF3fSkxBwSAjCUQdeBKHH45LYjYJ5P0+0RZi2IXujw/5qLJkN8saYcssVX3XvOJQXr2dMqmFZRSyk=;7:cCOB7AQxLx5OwrEDvB9f4DIFo8DE6q6XN/01v0EuSPYEgb8Rw9qLmjOW30rbeBanm+tSy4essbwoORRAg9tCFn2IR3CkN/WDvaB0JKjyk4XG4tifRja2BOxmP4/sM8se6+Mt9pgnzXApnacbDSNlG4J8bFKxitC7fkzKz6552mpr+r6H3w1HL8NaUKGYmjs+F/WEZ6n85YGswlAJavOeoNI747awF3Bx7G1tHNAC/tTyVX4FspQMBsf055XeBBoy
x-ms-office365-filtering-correlation-id: 9d438cc1-31fe-4ed0-3f3f-08d61b62b8bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07425FA2551E60BD4A3923D2DC180@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(86612001)(110136005)(54906003)(486006)(6506007)(33656002)(2900100001)(81166006)(81156014)(86362001)(316002)(99286004)(6636002)(74316002)(4326008)(256004)(7736002)(305945005)(11346002)(476003)(10290500003)(22452003)(72206003)(14454004)(6246003)(68736007)(446003)(478600001)(9686003)(97736004)(53936002)(25786009)(26005)(1511001)(8936002)(5250100002)(3846002)(6346003)(6116002)(102836004)(5660300001)(186003)(10090500001)(8990500004)(76176011)(7696005)(55016002)(106356001)(105586002)(8676002)(66066001)(229853002)(6436002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: LFFPXGsGwWLoydtGb3qIQMZd/839LVMtmQUN38BKW1L72UEIT2sbpQS9w+mzeGzSRuME6vjGX9+wfcUmpOdXwvUliCbQz3UUJOvRmOtL1aDN+3R0/7ecQNnR5pCT4w0PIN2vvtLzojtvrfXreVhoeiiVNJskrJPuv1vx6/i05MoS5XJyU4x5WcYxe2hNneDxZgZWoNbgs/8+9Kr0rptr2ImxaRt9dpgTJB50ruHfRUiZEzifz+YipY2sjRdOWDQ2j3PvGPRxJkdgdRjhDHxss+a9JIBg4r9Ex5XgWHRDHR/dKZ5+qLta435pP0Rm5mEpOj605DIPpebcmbNJIjl8JDn6RHFluBdJ6USEk0jH56k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d438cc1-31fe-4ed0-3f3f-08d61b62b8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 23:26:53.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yICAgU2VudDogVGh1cnNkYXksIEF1Z3VzdCAz
MCwgMjAxOCAxMjo1NSBBTQ0KPiANCj4gT24gIVJUIHRoZSBoZWFkZXIgZmlsZSBnZXRfaXJxX3Jl
Z3MoKSBnZXRzIHB1bGxlZCBpbiB2aWEgb3RoZXIgaGVhZGVyIGZpbGVzLiBPbg0KPiBSVCBpdCBk
b2VzIG5vdCBhbmQgdGhlIGJ1aWxkIGZhaWxzOg0KPiANCj4gICAgIGRyaXZlcnMvaHYvdm1idXNf
ZHJ2LmM6OTc1IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdldF9pcnFfcmVn
c+KAmSBbLQ0KPiBXZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ICAgICBk
cml2ZXJzL2h2L2h2LmM6MTE1IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdl
dF9pcnFfcmVnc+KAmSBbLVdlcnJvcj1pbXBsaWNpdC0NCj4gZnVuY3Rpb24tZGVjbGFyYXRpb25d
DQo+IA0KPiBBZGQgdGhlIGhlYWRlciBmaWxlIGZvciBnZXRfaXJxX3JlZ3MoKSBpbiBhIGNvbW1v
biBoZWFkZXIgc28gaXQgdXNlZCBieQ0KPiB2bWJ1c19kcnYuYyBieSBodi5jIGZvciB0aGVpciBn
ZXRfaXJxX3JlZ3MoKSB1c2FnZS4NCj4gDQoNCmdldF9pcnFfcmVncygpIGlzIG5vdCB1c2VkIGV4
cGxpY2l0bHkgaW4gZWl0aGVyIHZtYnVzX2Rydi5jIG9yIGluIGh2LmMuICBBbmQgSQ0KY291bGRu
J3QgbWFrZSB0aGUgbGluZSBudW1iZXJzIGluIHRoZSBlcnJvcnMgYWJvdmUgbGluZSB1cCB3aXRo
IGFueXRoaW5nDQppbiB0aGUgc291cmNlIGNvZGUgdGhhdCBtaWdodCBiZSBpbXBsaWNpdGx5IHVz
aW5nIGdldF9pcnFfcmVncygpLiAgSXMgaXQgdGhlDQpjYWxscyB0byBhZGRfaW50ZXJydXB0X3Jh
bmRvbW5lc3MoKT8gICBEaWQgeW91IGZpZ3VyZSBvdXQNCmV4YWN0bHkgd2hhdCBsaW5lIG9mIGNv
ZGUgaXMgY2F1c2luZyB0aGUgY29tcGlsZSBlcnJvcj8NCg0KSSdtIHdvbmRlcmluZyB3aGV0aGVy
IGFkZGluZyB0aGUgI2luY2x1ZGUgb2YgaXJxLmggaW50byBoeXBlcnZfdm1idXMuaA0KaXMgcmVh
bGx5IHRoZSByaWdodCBzb2x1dGlvbi4gIE1vcmUgY29ycmVjdCBtaWdodCBiZSB0byBoYXZlIHRo
ZSBmaWxlIHdoZXJlDQpnZXRfaXJxX3JlZ3MoKSBpcyBhY3R1YWxseSB1c2VkIHRvICNpbmNsdWRl
IGlycV9yZWdzLmguDQoNCk1pY2hhZWwNCg==
