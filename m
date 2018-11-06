Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AF02083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="02X9atjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AF02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbeKFUGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:06:48 -0500
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:36992
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387505AbeKFUGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSaj9wBFrTqZgeA37veUq0m5vSig/20xSpW65Sq9KP8=;
 b=02X9atjw2/ocxBUGOeY82zg3t6uDnVXUmbt00L0fWjz1+bNK0NRyF4RfQeTS04Kid3+4YP35FsyoQn9vtvYefONHYS9fGDzPXbTqf8QsXE1Fh14n/gvX0qCdopyY+WqlzAkb461B35WavJqi2hblhNTtOqoKYNYULB2Nk8saY/Y=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4059.namprd02.prod.outlook.com (20.176.75.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 6 Nov 2018 10:42:10 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::7c6d:415e:343a:ed8d]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::7c6d:415e:343a:ed8d%4]) with mapi id 15.20.1294.028; Tue, 6 Nov 2018
 10:42:09 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Thread-Topic: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Thread-Index: AQHUbCkGImIFRcuRaEmaBKZIdJs+DaVCl50AgAAJ/TA=
Date:   Tue, 6 Nov 2018 10:42:09 +0000
Message-ID: <DM6PR02MB52278C1B02960DD084D5A25BC1CB0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <20181106100329.GC13712@zn.tnic>
In-Reply-To: <20181106100329.GC13712@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4059;6:bOwHQi7euuHSVV2QIdLszkccdAhbxF2d9X+aslvhaw0AeV6F24udd4jBcq/0yi0uDBwwwB9AAkSkthEUHwKIk6IB4kQWK92e6P4H3QMNbdJZ4NPOUfSsQSYAE3CpNJFhmXx+vYGiJbLTqqYRnrljpfY0DUm7XIz28G3kWCTRUlWuXUODMvSDzDeNaM2vMhmcbSWlDR9xxL94bnvqtrmBWjzcgQYXTQxH17yWkQBmXTXDXI3FtTyiJ/AttZ/6dwlEWJgPE2mAi3R9iM29jDr+HQZ+m2VbFvr0MO7FTyd4G0U3ErdSYmNurTHnrXYGerJ9R90RKP1sJlrtWnONYVRv2qOsW94MMjyTlRtkmqw27tI63nsTlxV5113UNnrZ64XUwA8FLfr024On39ulevulUCA+W9IFC7HAoBszRfKhAxRgmwNeRbQFuso0NPfvih+mIbfGdW7kOVweTPRotJl3FA==;5:mvFptHVAF5GEHY8J3KQKU+3iwxOv/kFlbrlXG9J96ylrL07WdtxHYMcEfYCw7ain6TgcLnfYZAudFcM10HduoFp4c3PojYLfqq7EQls6M5QkMq9FIWMChZPdlca2Gjk711HRMH+Phkd3ZmweXnMwHs6+teeGbJ+SXPz767BO2C4=;7:eWz7JlSwk038/W03fuYPN4Y1mE/+h+WL96GddX9+hVBxzA7E4RH/erRB1m+s83S5F34IiCgJ6jT7nT/WaKyK9voyIHH/03lJS0q152KTNnmOvxHK2BWPB5hUmF1ormMgEshK+O0vkkzFJ1OIyAkFxQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(13464003)(316002)(76176011)(86362001)(26005)(6506007)(81166006)(81156014)(102836004)(8936002)(53546011)(186003)(14454004)(2906002)(71200400001)(6916009)(71190400001)(8676002)(6246003)(7416002)(446003)(33656002)(305945005)(74316002)(7736002)(11346002)(476003)(486006)(72206003)(66066001)(106356001)(6436002)(7696005)(68736007)(99286004)(966005)(53936002)(55016002)(105586002)(9686003)(5660300001)(4326008)(6306002)(6116002)(25786009)(3846002)(2900100001)(256004)(478600001)(97736004)(54906003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4059;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5d39fd1a-ad0c-444d-4271-08d643d480e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4059;
x-ms-traffictypediagnostic: DM6PR02MB4059:
x-microsoft-antispam-prvs: <DM6PR02MB4059738CEBB7EB2E7BA9BA04C1CB0@DM6PR02MB4059.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(185117386973197)(9452136761055)(258649278758335)(42068640409301)(192813158149592)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4059;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4059;
x-forefront-prvs: 0848C1A6AA
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wO/vfsGl4wJA60KVFtZwZzAmwDaI91SAKAq6vaBk/6fPgs4W5aOmTPi9Simw7g9WB3przU/hB8ilM3SDM0Or0+1Qxhsd9o4+vkP0OAm0WYwVhulXebaVhnqQzPoiAs7ccysgf2kKOB7dLEmpfdfB+BqwVEtiLYHv+/nh7LZwJsoTOQSvU+fBe0ssC00fMyuDHYNbLOy2Zl7mK4HzFuqqiAyEpW8lG9eH9ZEqH5dUrqnLhpxgnrA4Lb1ymQAN32t9UFNrEHkGtf5XMgDDW6gwxw+h4FeKDqRPJ3A7IRH33sdzxIAOZfNxBfET/IFGAIaVMfb1JJyrExwcRMvHUu7+UbHoHa10R9Zkc47rpmW+gq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d39fd1a-ad0c-444d-4271-08d643d480e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 10:42:09.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNs
YXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJl
ciA2LCAyMDE4IDM6MzQgUE0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNv
bT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IE1pY2hh
bCBTaW1law0KPiA8bWljaGFsc0B4aWxpbnguY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOyBhbWl0
Lmt1Y2hlcmlhQGxpbmFyby5vcmc7DQo+IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyBsZW95YW5nLmxp
QG54cC5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAwLzZd
IEVEQUM6IEVuaGFuY2VtZW50cyB0byBTeW5vcHN5cyBFREFDIGRyaXZlcg0KPiANCj4gT24gVGh1
LCBPY3QgMjUsIDIwMTggYXQgMTE6MzY6NTVBTSArMDUzMCwgTWFuaXNoIE5hcmFuaSB3cm90ZToN
Cj4gPiBDaGFuZ2UgaW4gdjEwOg0KPiA+IAktIE1vdmVkIHRoZSBjaGVja2luZyBmb3IgY2VfY250
IGFuZCB1ZV9jbnQgYmVmb3JlIHRoZSByZWFkbCgpIGNhbGwNCj4gPiAJLSBBbGlnbmVkIGFyZ3Vt
ZW50cyBvbiB0aGUgb3BlbmluZyBicmFjZSBpbiBzZXR1cF9pcnEoKQ0KPiA+DQo+ID4gTWFuaXNo
IE5hcmFuaSAoNik6DQo+ID4gICBlZGFjOiBzeW5vcHN5czogQWRkIGVycm9yIGhhbmRsaW5nIGZv
ciBOVUxMIGluIHByb2JlKCkNCj4gPiAgIGR0OiBiaW5kaW5nczogRG9jdW1lbnQgWnlucU1QIERE
UkMgaW4gU3lub3BzeXMgZG9jdW1lbnRhdGlvbg0KPiA+ICAgZWRhYzogc3lub3BzeXM6IEFkZCBt
YWNybyBkZWZpbmVzIGZvciBaeW5xTVAgRERSQw0KPiA+ICAgZWRhYzogc3lub3BzeXM6IEFkZCBF
REFDIEVDQyBzdXBwb3J0IGZvciBaeW5xTVAgRERSQw0KPiA+ICAgYXJtNjQ6IHp5bnFtcDogQWRk
IEREUkMgbm9kZQ0KPiA+ICAgZWRhYzogc3lub3BzeXM6IEFkZCBFcnJvciBJbmplY3Rpb24gc3Vw
cG9ydCBmb3IgWnlucU1QIEREUkMNCj4gPg0KPiA+ICAuLi4vYmluZGluZ3MvbWVtb3J5LWNvbnRy
b2xsZXJzL3N5bm9wc3lzLnR4dCAgICAgICB8ICAyNyArLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL3hpbGlueC96eW5xbXAuZHRzaSAgICAgICAgICAgICB8ICAgNyArDQo+ID4gIGRyaXZlcnMv
ZWRhYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4g
IGRyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgICAgICAgICAgICAgICAgICAgICAgIHwgOTEx
ICsrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDkxOCBpbnNlcnRp
b25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gDQo+IE9rLCBwYXRjaGVzIHB1c2hlZCBoZXJlOg0K
PiANCj4gKG1pbnVzIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMTU0MDQ0NzYyMS0yMjg3MC02
LWdpdC1zZW5kLWVtYWlsLQ0KPiBtYW5pc2gubmFyYW5pQHhpbGlueC5jb20pDQo+IA0KPiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icC9icC5naXQvbG9n
Lz9oPWVkYWMtZm9yLTQuMjEtDQo+IHN5bnBzDQo+IA0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHN1
cHBvcnQuDQoNCj4gUGxlYXNlIHJ1biB0aGlzIG9uIHRoZSBodyBiZWZvcmUgSSBxdWV1ZSBpdCBm
b3IgbGludXgtbmV4dC4NCkkgaGF2ZSB0ZXN0ZWQgdGhpcyBhbmQgdmVyaWZpZWQgYXMgd29ya2lu
ZyBmaW5lIG9uIGhhcmR3YXJlLiBZb3UgY2FuIGdvIGFoZWFkIGFuZCBxdWV1ZSBpdCBmb3IgbGlu
dXgtbmV4dC4NCg0KVGhhbmtzLA0KTWFuaXNoDQo=
