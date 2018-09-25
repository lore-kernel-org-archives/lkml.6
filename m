Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ACB20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yiEPUddc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ACB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIZEmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:42:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26978 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:42:18 -0400
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="21335634"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 15:32:33 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 25 Sep 2018 15:32:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4RsjJhQehVHBuliSbpiY8IHXGwGTnlumpcyOsf7EIw=;
 b=yiEPUddchGzQA1Q7kkJUg0fl0cOV1smqrNVG6hE+fuedQTMEqEELyQbdIuTRvMTVRAcCIm+NXSYq+u43o5Bu1IkAr4OMYgQ8Br/T1izLZ6M8JbAmz981ybagvVtsU1NIArjbYywNEcarcBKyO1VDR/jMdNwdTPZjdmYZh3PvCkQ=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2132.namprd11.prod.outlook.com (10.174.112.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Tue, 25 Sep 2018 22:32:24 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235%11]) with mapi id 15.20.1143.019; Tue, 25 Sep
 2018 22:32:24 +0000
From:   <Woojung.Huh@microchip.com>
To:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <steve.glendinning@shawell.net>, <keescook@chromium.org>,
        <akurz@blala.de>, <hayeswang@realtek.com>,
        <kai.heng.feng@canonical.com>, <grundler@chromium.org>,
        <zhongjiang@huawei.com>, <bigeasy@linutronix.de>,
        <ran.wang_1@nxp.com>, <edumazet@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Topic: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Index: AQHUVElSRngOMbMRpUm9i69iXavPIaUBPgVggAADLYCAAADmgIAAEn0AgAA/Q7A=
Date:   Tue, 25 Sep 2018 22:32:24 +0000
Message-ID: <BN6PR1101MB213010C5A5C888C539A9938EE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180924205420.31309-4-f.fainelli@gmail.com>
 <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <f791e4b6-7493-b54b-a88f-47d0ef4a3409@gmail.com>
 <BN6PR1101MB2130D18F03C79BC1E54C9FBAE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <8de18c23-d846-cbb4-c852-9b7d97a95c11@gmail.com>
In-Reply-To: <8de18c23-d846-cbb4-c852-9b7d97a95c11@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2132;6:9hlb9XZpH4wdv6S2Yw0brpDXwwEy7cIQn13MbQRbNubo8APO66uVkmeY6PChiEYVQd1pk1vc/Q8nru5Zj8RKG5esYkrxibaImUNxp5MibG4IfXZna+LzxhAtUht2xpoZa/QxU6eFotEpeSaJaroZqy1JElxTAA3ReVO5o4TnthawST34COvsE0GLWSSxfJQUqmKr1TBpzIp57y/TYKgq0uGJf89hNt/ASsfFSsPPvIr/G76UVHCsYKEGdilH19UaXtK8FXj0+FFjXmahm7k9bWrj8gedaw5AZhFzgU4ExtXNdMrrTiz3fsjEpqc5PKT+tO6ITMFiPDwFxJQuVhb7oA1+cc38K9otH3MUAmOmyR847JehNaQF+P1f5NzBo49ke2JhXf/44GQa/6r/yB+j1m6q533D9hAR2qB4gy2IdQ2feMSmaDiLwxdTQXg768fhwKbI6Yy7yjgEAUhDMNkGdw==;5:5yczePNwYz3bdii98gg5725LmFXmD0ZLpoA9ZW7BwYU/QKWqmcIMBAfz5wTYS1QA9E1yuBWsEp9VNaGXlPAB9ZACpt69PUWnpR+nxHCoiQrMMXlGuL1u9eZatTA8CKBrvq8h/GdUH3lGoo+/CPj/HOm7anHepfCsimosxgR7JiI=;7:8GcVwRZNz5HcWHCoarO2ygmjl4DcZMvqVPppfr9L0VnMfOJ3whVUG0hE4s+TjLJFTJTHv8RiLH/hRgE8J32NpdypOQqWGva6Vz5pU+4UwufSY0w4HbFU/xdSBHjMUk8M3hxEWXgSmeLnHE1SUfsADXWMKbCrbeaJbZt3kIavmRg/XSSvPi3i4ol32iP6gEbGdOOnMxwG6q8SYmbnp33li4cbegFjzz5ZLHh4UEW3jegC1VDcPveUHVHSJaQKMmSQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a926ba24-9b24-4749-bbd1-08d62336c435
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2132;
x-ms-traffictypediagnostic: BN6PR1101MB2132:
x-ld-processed: 3f4057f3-b418-4d4e-ba84-d55b4e897d88,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB213283542D0FA05829F8F1A6E7160@BN6PR1101MB2132.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BN6PR1101MB2132;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2132;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(97736004)(2906002)(106356001)(71190400001)(76176011)(71200400001)(7736002)(305945005)(229853002)(11346002)(93886005)(446003)(476003)(5250100002)(8936002)(8676002)(6436002)(34290500001)(478600001)(105586002)(74316002)(86362001)(7696005)(486006)(2501003)(72206003)(68736007)(7416002)(5660300001)(316002)(6506007)(4326008)(6246003)(14454004)(55016002)(186003)(26005)(66066001)(25786009)(3846002)(53936002)(81166006)(81156014)(102836004)(256004)(558084003)(99286004)(110136005)(2900100001)(54906003)(33656002)(9686003)(6116002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2132;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T3ApQBTgxT6Z5ue27PnyBxyk4ugAXGR3nWZh74jocqke82QkjxWquBCPtZ6WONCZ2dNdqpye82nbAxMiyLfCjVRBK0olJsP9I1TPAMajamXdU26q+JHAzpHhPsSCTpMVMpidA3m/m+By2h2jAIW0AzK8jIwgoQV7BsJDGl+GDgNa7ROAsPo4EU+Sx8j5LTO4GU+f2a/d5Y+HQfgCKwzA7DLBxwRB54TqxFFQrNCoywBjtEHctpB4z8zJmwjW7I0hXupKCkOBRXakcXH2dXnoxWfjd6eN8KdBug2KsPgQ7rBPeKBv/bvM/aK6tXELSAL3EQNt3MqXXZtFiMfnbL3Bjtgw9rq394B+YQdST9uC3kg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a926ba24-9b24-4749-bbd1-08d62336c435
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 22:32:24.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2132
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmxvcmlhbiwNCg0KPiBAQCAtMTQwMSwxOSArMTQwMSwxMCBAQCBzdGF0aWMgaW50IGxhbjc4
eHhfc2V0X3dvbChzdHJ1Y3QgbmV0X2RldmljZQ0KLi4uDQo+ICsgICAgICAgaWYgKHBkYXRhLT53
b2wgJiB+V0FLRV9BTEwpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCklmIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHksIGl0IG5lZWRzIHRvIGNoZWNrIGFnYWludCAid29sLT53b2xv
cHRzIiB0aGFuIHBkYXRhLT53b2wuDQoNCj4gKw0KPiArICAgICAgIHBkYXRhLT53b2wgPSB3b2wt
PndvbG9wdHM7DQoNClRoYW5rcy4NCldvb2p1bmcNCg==
