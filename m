Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A51C218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ebxOY1FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfBASok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:44:40 -0500
Received: from mail-eopbgr780079.outbound.protection.outlook.com ([40.107.78.79]:27520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbfBASok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZPsEzV89MSjR+VTWriG9XU0pf0YtNNcJd8IPHgd0+I=;
 b=ebxOY1FL1noftYGS21yivw7NbIt3qu/YczQNUvdNA3pVp+apFXQT0M75Yxs9v3fyxGes7jJALq09el+29ryhIa+u9/1j08ErI1wXHMQQ/8m8mo7Q5e50vUDjH7g77OzTKc+tk1N13qX6Hlw0/xN+fZ6oXxJUnnmvaQiTSbl9g2c=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4951.namprd02.prod.outlook.com (52.135.234.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 18:44:36 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 18:44:36 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Topic: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Index: AQHUuBKpstebeIDlnU+HyCPR79whuqXHmH8AgAIlFZCAASG2gIAAahHA
Date:   Fri, 1 Feb 2019 18:44:36 +0000
Message-ID: <BYAPR02MB5992A4D0347DF535569DBC4EB8920@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
 <20190130101236.GA27201@e107155-lin>
 <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20190201121445.GD10042@e107155-lin>
In-Reply-To: <20190201121445.GD10042@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4951;6:KLOSuhPVsCDj4UkUBnsJYz3GoJICnYBSBX8jbrKbp/7d3BPn+pi6uZOVT5sY1knEgi6DdWazx+Lh/+6BjHkNdDhbzU9Of2hLWTvUj2Tng3sxbNyNSMFQfrgXGAqBPbtcIvWPVP9M93EH9gRC8oOmR5y4NE+KmF3ulLiU/vQozhdZ+T5uyYCenbhTCsSSB0j+rO5gmc5XbIsVOcP3RLc1+yhBh33SnYCNKFiwGGWPHe8PJMtKlS+3CD93NOTmLh85DDpyBO5ArhYYeU6hRfITYxbycvhOA8QFjiJ6O2M2ShCygIWbPyTl71iG0epK4ESKcGpZSQ8vTjAPjQLvdPxevu7Y4tOJ1+iKrmM3ZbF9aLadQMuWnpNyGOuvaG/4FWUDZN/czj+Q7i03sLHvNZcLZMer/YZFQ4GsJbEsxfHc4RXrF6n5gPp59B15lym7/uWNSKncZkBgibF24qV0ZES0Iw==;5:Nfcbfjbsh1NpAn47CV37SM2tOguYSBWa+lwpTge+gCO4ctkbjBRyPPWmkb7cSIgbCjSHVkphXJDIT/gduSz1KHSlXsPTosPjEazFbbS2DRHxUpiyLsjxsDatuZId1RUzvsT3trPtge/A3x8T2sOPbE+ux2Sg/g1/VbZf/bOhKWj2d0/al2msIfmXNmIHl7KXKsZxsoTt7YnZuzZDXYlI9A==;7:QXT59/8M2EAP+b7xm7Tb9p80lSbJcxIOll8NF/FMrXEF5KFFwLS89COOtfsuve1UPATsU7S0TmO+CN6yjpo5++Jm6HNfsM8WgVY+E33qth7gGpR3hX2OXefuM4ByoVXbSkIzOB7vilFIlF2QWsfNTw==
x-ms-office365-filtering-correlation-id: ecac2f8b-18b9-4672-c8db-08d6887550ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4951;
x-ms-traffictypediagnostic: BYAPR02MB4951:
x-microsoft-antispam-prvs: <BYAPR02MB4951CAED4823AFA468FB48CAB8920@BYAPR02MB4951.namprd02.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(13464003)(199004)(189003)(478600001)(72206003)(53936002)(102836004)(53546011)(6506007)(71190400001)(33656002)(7416002)(71200400001)(11346002)(446003)(6116002)(6246003)(9686003)(229853002)(14454004)(3846002)(55016002)(86362001)(6436002)(39060400002)(66066001)(105586002)(4326008)(316002)(74316002)(99286004)(26005)(25786009)(7696005)(2906002)(54906003)(305945005)(7736002)(6916009)(97736004)(8936002)(476003)(14444005)(81156014)(81166006)(8676002)(68736007)(256004)(486006)(186003)(76176011)(93886005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4951;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dfdfNkgMlKFUPRs+FXwE29OxxhauDh8caE6gzs9sxNfegqwKDdr4jmlmw7rUcfVgIzywYAxs4Semgjne4tUaS4d+xfsrjcr97l1fzHKjFAZR7VRVqzBBMXOynjEZAxlZ12HJrDVZsuhWLNQGfMrGETVTGl27DfoJvzfejPS+fgWOBUQqXIwALK/VWA9HoqQeUR4UmVm4RNKgDAcuW912MpPMCPPvTKZCVw5F8dy+KJ9wZY8qdrAGTRUQWnwu89voCHY9P+CjI6bjq9B+6LoRqUd1FyJmwj8vBADE/ePcjkFwlUExAtyraW3qvXsHhd1dJpin01q3opBVUEmYqn6Fq1ml7Rnq/t9UlKAPa0dcsN5Wd8cZPv+Kgadkw3UvIYIHay6MyPzQr4GvT+sHc18dqiIJpjCAd9t5/2WZeGMgt4E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecac2f8b-18b9-4672-c8db-08d6887550ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 18:44:36.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkg
MDEsIDIwMTkgNDoxNSBBTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+
IENjOiBtYXR0aGlhcy5iZ2dAZ21haWwuY29tOyBhbmR5Lmdyb3NzQGxpbmFyby5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBiam9ybi5hbmRlcnNz
b25AbGluYXJvLm9yZzsNCj4gc2Vhbi53YW5nQG1lZGlhdGVrLmNvbTsgbS5zenlwcm93c2tpQHNh
bXN1bmcuY29tOyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IHJvYmgrZHRA
a2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IFJhamFuDQo+IFZhamEgPFJBSkFOVkB4
aWxpbnguY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzNdIGRyaXZlcnM6IHNvYzogeGlsaW54OiBBZGQgWnlu
cU1QIFBNIGRyaXZlcg0KPiANCj4gT24gVGh1LCBKYW4gMzEsIDIwMTkgYXQgMDc6MDE6MDVQTSAr
MDAwMCwgSm9sbHkgU2hhaCB3cm90ZToNCj4gPiA+DQo+ID4gPiBOQUNLLCBpZiB0aGlzIGlzIGZv
ciBzeXN0ZW0gc3VzcGVuZC9yZXNldCA/IFlvdSBjYW4ganVzdCB1c2UgZXhpdGluZw0KPiA+ID4g
c3lzZnMsIG5vIG5lZWQgdG8gY3JlYXRlIFhpbGlueCBzcGVjaWZpYyBuZXcgb25lcy4gTW9yZW92
ZXIgeW91IG5lZWQgdG8NCj4gPiA+IHVzZSBQU0NJIHRvIG1ha2Ugc3VyZSBoaWdoZXIgRUxzIGNh
biBkbyBvcmRlcmx5IHN1c3BlbmQvc2h1dGRvd24uDQo+ID4gPg0KPiA+DQo+ID4gV2UgaGF2ZSBw
b3dlciBvZmYgc3VzcGVuZCBtb2RlIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZXhpc3Rpbmcg
c3lzZnMgYW5kDQo+ID4gaGVuY2UgbmV3IG9uZSBpcyBuZWVkZWQuIFN1c3BlbmQgaXMgaGFuZGxl
ZCB0aHJvdWdoIFBTQ0kgaW50ZXJmYWNlIG9ubHkuDQo+ID4NCj4gDQo+IEkgc2VlIG9ubHkgMiBj
YXNlcyBzdXBwb3J0ZWQgU1VTUEVORF9TWVNURU1fU0hVVERPV04gYW5kDQo+IFNVU1BFTkRfUE9X
RVJfUkVRVUVTVC4gQm90aCBhcmUgYWxyZWFkeSBzdXBwb3J0IHNvIG15IE5BQ0sgc3RpbGwgc3Rh
bmRzLg0KDQpUaGUgMiBjYXNlcyhTVVNQRU5EX1NZU1RFTV9TSFVURE9XTiBhbmQgIFNVU1BFTkRf
UE9XRVJfUkVRVUVTVCApaW4gaXNyIGlzIGZvciByZW1vdGUgc3VzcGVuZC4gIFN5c2ZzIGlzIGZv
ciBzZWxmIHN1c3BlbmQgYW5kIGl0IHN1cHBvcnRzIFBNX1NVU1BFTkRfTU9ERV9TVEQgYW5kIFBN
X1NVU1BFTkRfTU9ERV9QT1dFUl9PRkYocG93ZXIgb2ZmIHN1c3BlbmQpLg0KDQpUaGFua3MsDQpK
b2xseSBTaGFoDQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
