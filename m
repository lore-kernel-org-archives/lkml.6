Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9338EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9D21546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sy4Yb/9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE9D21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeI0LD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:03:56 -0400
Received: from mail-sg2apc01on0129.outbound.protection.outlook.com ([104.47.125.129]:32207
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeI0LDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRR2GKob81jxeLSJhRbSjE3o+S3G9wcNMd2cTr62D6k=;
 b=Sy4Yb/9Lzs2tYy2CqALO0HUFR5En8AtfR9Sowgh3DycffLj0bbH0T3mThQtTNjegRGpPlRyvKlgrRvm3vz5NQOwniedVNRmn+IZ5pWaBKm7dvPRhptpxGQ+HqkjA3rYn22JfHn7sNP/VYzIfvdXmhEmFpKgm88aUuYgouiXY+mU=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Thu, 27 Sep 2018 04:47:33 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 04:47:33 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Topic: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Index: AQHUVhUjI9nGWlGZLUCbqLrddHAAAaUDhZEAgAAIUwA=
Date:   Thu, 27 Sep 2018 04:47:33 +0000
Message-ID: <7f8e4c6d-db61-4e96-2ddd-df429bdaf3f2@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
 <20180927034829.2230-11-Tianyu.Lan@microsoft.com>
 <CY4PR21MB0773A8B3292FA78711E580E7DC140@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0773A8B3292FA78711E580E7DC140@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0129;6:nYG5Unengp5f2/mSX7Y6iYAdARkD2NYiGloVoAvYQoE26UwwCwQVTZCepoc4EQtxeyql8sLKD/VRE4XKM/WUAFU1xafUY3jyHzjQcAXeYavB3WpdWltjqaLnhv8qJSuaDLkmejKjrbgMyOk+z6ITPiDH/1HadLxSubYXlQWTraCcjiJjbnoMVGRs2h/rCcAsS1chANHfw8BEFIGphMmxqQZv3QiUdaC+h9i7m1sxGSY5BvPEPTydQpf8O/If+aLdhGiYb49WrosE3qsVOmHMYfVnQWogJ4SPXSJvvWQtnCtr+o7sX7fAMOFiG/k6vYMXwpueOJ/vqG0LgQlU/MtJbpLZZEQ6JCaE/D3bYKM4hXUBYm+UIx+SjegdDwzEjD/6yfyu72WJQDachijIvVnIEA39TuUE0lAq/sQNgS6385xaI1/oo8OdV7WOrkSbuIjAU1+m1eZ5za/b1iW+0ESeYw==;5:yy4JVvNvX0L+2t4x8/xChshY4r0GyU0v6Ull3xOdaI45EVx/XKh3fvUBq4d/jjlz0dXtdBG+sMpJhlnJb79U6gtjg6ICcgsIQdSQSOpCTfz8Zxw1RNqSWerH8zCpraXt636SOuaEmVM0og7ffTr6SJ3/GYMuIplBP8qFkNUFVHc=;7:h3t4Va0VzADbNvv+wwBJ1ieRRCv3sl0clMWWuZqHzZ/Mvu1aqE4JBk2Rd2lyGPO+rRWOZm1XVkwOcdaOFD8BJerlBVQFn72IcGQq5LIEg/C6lzUIlWxJ7Nrj0wbCayS9oSxbUEji0PcUl981Ni8LqAni5GuWqEeuUlxVvsPCp4qkH8COMsLPg3HWxiwe1UnrJiIHyjMqiOOmC/zZgM3m49abXqk1OYaqYnT8Bt0Uubj3P7eNSEloCIOEGdLmFydJ
x-ms-office365-filtering-correlation-id: 6630dc1f-a082-4326-5439-08d624345736
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0129;
x-ms-traffictypediagnostic: HK0P153MB0129:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB012947FC3555E7CBD2E70C9492140@HK0P153MB0129.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HK0P153MB0129;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0129;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(36756003)(5660300001)(31686004)(305945005)(8936002)(7416002)(3846002)(2906002)(6116002)(256004)(229853002)(316002)(54906003)(110136005)(6486002)(66066001)(97736004)(85306007)(26005)(6506007)(2900100001)(5250100002)(8676002)(6246003)(81156014)(81166006)(68736007)(1511001)(76176011)(476003)(22452003)(6436002)(10090500001)(478600001)(53936002)(34290500001)(10290500003)(71190400001)(71200400001)(2616005)(6512007)(11346002)(72206003)(446003)(4326008)(486006)(106356001)(14454004)(86612001)(86362001)(107886003)(105586002)(102836004)(7736002)(53546011)(31696002)(25786009)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0129;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6F/Hq0XPe1kSrAav/q1LJy3FwccbVnK683t+mFG8/rrw8BwOCM4jd9kImGBHgkxkOdS7xRGBwvH9inCR8+aCKQnpj4ISA2KNz3PElv6lh/YMNi5M/HcTAor2fUjBUw56mVyycHUqFuhtdovrZBl6wWzhIJL+pgqOsJUXINrYLQzHvBxhnvw2fGRjWG+b+1BJEJjAnmZrwUGjdTdhHsdtvJEVN0k5Lz7TtMp1kDoq69gHCowFWG3G3tKB51CqDaW4E64DiU2mO1UfOOkRWfW8BHB87kHL7js54Gn3TqUPijH9jRrXq9sCKvLIdaY7mF1bdkl0o5ZtmI7b7eX2J+WJ8JEMX23x4af/TAZ2zerzP4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <285E71F117A7434EAD8C97B823A76755@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6630dc1f-a082-4326-5439-08d624345736
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 04:47:33.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNy8yMDE4IDEyOjE2IFBNLCBNaWNoYWVsIEtlbGxleSAoRU9TRykgd3JvdGU6DQo+IEZy
b206IFRpYW55dSBMYW4gIFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI2LCAyMDE4IDg6NTAg
UE0NCj4+DQo+PiBIeXBlci1WIHByb3ZpZGVzIEh2Rmx1c2hHdWVzdEFkZHJlc3NMaXN0KCkgaHlw
ZXJjYWxsIHRvIGZsdXNoIEVQVCB0bGINCj4+IHdpdGggc3BlY2lmaWVkIHJhbmdlcy4gVGhpcyBw
YXRjaCBpcyB0byBhZGQgdGhlIGh5cGVyY2FsbCBzdXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IExhbiBUaWFueXUgPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCj4+DQo+IA0KPiBMb29r
cyBnb29kIQ0KPiANCj4gUmV2aWV3ZWQtYnk6ICBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWlj
cm9zb2Z0LmNvbT4NCj4gDQoNClRoYW5rcy4=
