Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E56C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9692086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fTBR05Hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9692086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeIXQSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:18:04 -0400
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:42347
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeIXQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukexJfJ/pOkg/WqIOhv5XL/E/gmsVf8rfVZH7ckiqpI=;
 b=fTBR05HnsEOMTZYP14Skxl+ty656tCDODuL6GY1653yv2eUzz5GFzLOTLS0lmqmY2Kkp9bFx5gDrGNxZcaDSXkbsvEqgQUfO/tnkmXFR+FEzCgpkQ7JRIaNes9yFGSLJwF3AG7sRU999KXM52w75UghxxtYquNS+lxMtaPlgOZs=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4492.namprd02.prod.outlook.com (20.176.107.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 24 Sep 2018 10:16:27 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 10:16:26 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUTpJW1XQNYRxn3kWgpPIZoEhCVaT1rMEAgAFj0DCAAGaLgIAAI+zggALc1YCAAAJJAIAEx3DA
Date:   Mon, 24 Sep 2018 10:16:26 +0000
Message-ID: <DM6PR02MB5227592B66080409835C6CBDC1170@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180921090721.GB30439@nazgul.tnic> <20180921091532.GC30439@nazgul.tnic>
In-Reply-To: <20180921091532.GC30439@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4492;6:EltyyWMem5Woj2Eae2GA+AlhUdsR+/uOX0K2xzQHe8dkKCqg6ph2x5lp0oXLMCzCoLGwDCVaTDn4mX1QjbYGiUdpdF0AbyG51ndgR5OTTdH38RYjtVKBP8b8TP7TA0T1ochXN3ivJVDXSSE9u+6UIOtPQlfhbHYrjwCauM/c3kBCiVxh9Gc6BLt8B6xWN/SYFw+joYv286tXyS5lwP6Ts49EzDCvwDKpofq32a5xRr5M/GLxHDZwIoGaGDDa8VrQ+hU62blVkY+/gq6FR78Ok32CA/HnDJX28/4ulLRR9oopbVHAB30zf1lsqoZVN1q1berdyuPcaTtDwI2D5Fq+GGbQ5PV0ym9f+NgKUEYz5qOng6Vi/keJCsphJhcCBgV3hRbEu2wwAasueoYllrxgoWtV+vzotvsWFhBL1NnfU8g/AIIJUZd4sTeibm+MpGaQNbe7H22eguK9i3uWW93ngw==;5:Vp+6VaQEtVu3YoqWasn3qZDTrL1M9Y4z9O9y2eHMkjO2GsErIAWS0QC+waPPY0Km2SkAHCSfU78eV4jJJd69flXOdtotBmT2Ry9dIst1jQeBOMWm04z9e78QoLLAKk/jsOC1aVndMPyFAh/WRtOLmVvVcU4kPUN1ngSLKj/j90A=;7:4HHIDjR2/9pPFYVPgF0mwFRkuxh1DOQJwo7Dysk2t/kuwdVgSEHPCinr55d3GYB7d8o+C3umdhIuXyzI437iOuAn5L+xV9OMJIsF1MPodZUJL0eggXkpJ24ADexaZqS+FBxDCgtVnlJESn8Qsd9HLiDVgo18A4MuBU7LYIkCEXky+0cAiHKI1fY2SckoEnKYxSjssad3rov+tKsZBU0kQG3qwxtacA4udysMw/LSc88Ha+wHmJu9ImUGvHfQwmDM
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(13464003)(51914003)(7736002)(55016002)(6246003)(4326008)(99286004)(74316002)(9686003)(305945005)(93886005)(25786009)(186003)(53936002)(81156014)(54906003)(81166006)(229853002)(6916009)(8676002)(316002)(66066001)(26005)(8936002)(33656002)(7416002)(86362001)(478600001)(71200400001)(71190400001)(3846002)(6116002)(5660300001)(6436002)(446003)(68736007)(11346002)(7696005)(476003)(6506007)(2900100001)(76176011)(106356001)(486006)(105586002)(2906002)(53546011)(102836004)(72206003)(256004)(14454004)(97736004)(14444005)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4492;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 707a9b07-b92b-47d0-302e-08d62206c99f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4492;
x-ms-traffictypediagnostic: DM6PR02MB4492:
x-microsoft-antispam-prvs: <DM6PR02MB449241BB6D60E005518B23EFC1170@DM6PR02MB4492.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(185117386973197)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4492;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4492;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OHGGdl5QfHN58eeR0AWX3ZUZn4Esudhnxwv4LOaC/ct08w5Sz9Bjf5p1psC+frySHQdzBoSJzfpNa/vuY/nqq0xEdO3wcdj4x3orBgjRBnKAeE983LnBbwvvX2q6KueBBWqiJtn+YvT9YjpgKMoWqp8R9ketdV6J/Xf3p1Pn2ltfGYR+HAdGv8Ej6VRbmV+VxRY4VCI+y2KyWN4Hwx9ZtczFGYejyjxqhJ4Cs6IotNBPnIS2KA0FQGVHwGGmsPz8netJE5hxtn+Ey5FwWBujXqMB2y0ogu5I3Y2Ix8ng/AnN3QqOLCv6KytEOihG5yKZ1wLZn0ccMUhvAgUMOJJMYtidsOLKmcFqOV+HN3iQCQ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a9b07-b92b-47d0-302e-08d62206c99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 10:16:26.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVd
DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIxLCAyMDE4IDI6NDYgUE0NCj4gVG86IE1hbmlz
aCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsg
bWFyay5ydXRsYW5kQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gTWljaGFsIFNpbWVr
IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsZW95YW5nLmxpQG54cC5jb207DQo+IHN1ZGVlcC5ob2xs
YUBhcm0uY29tOyBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZWRhY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY3IDIvN10gZWRhYzogc3lucHM6IEFkZCBwbGF0Zm9ybSBzcGVj
aWZpYyBzdHJ1Y3R1cmVzIGZvcg0KPiBkZHJjIGNvbnRyb2xsZXINCj4gDQo+IFRoZXJlJ3MgbW9y
ZToNCj4gDQo+IEkgc2FpZDoNCj4gDQo+ID4gPiBAQCAtMzcwLDEyICszOTgsMTIgQEAgc3RhdGlj
IGludCBzeW5wc19lZGFjX2luaXRfY3Nyb3dzKHN0cnVjdA0KPiA+ID4gbWVtX2N0bF9pbmZvICpt
Y2kpDQo+IA0KPiA+IFRoYXQgZnVuY3Rpb24gcmV0dXJucyAwIHVuY29uZGl0aW9uYWxseS4gTWFr
ZSBpdCBhIHZvaWQgaW4gYSBwcmVwYXRjaC4NCj4gDQo+IEJ1dCB5b3UndmUgbHVtcGVkIHRoaXMg
Y2hhbmdlIHRvZ2V0aGVyIHdpdGggYSBidW5jaCBtb3JlLiBNYXliZSBteSByZXF1ZXN0DQo+IHdh
c24ndCBjbGVhciBzbyBsZXQgbWUgcmVwaHJhc2UgaXQ6DQo+IA0KPiBUaGF0IGZ1bmN0aW9uIHJl
dHVybnMgMCB1bmNvbmRpdGlvbmFsbHkuIE1ha2UgaXQgYSB2b2lkIGluIGEgKnNlcGFyYXRlKg0K
PiBwcmVwYXRjaC4NCj4gDQo+IE9rPw0KWWVzLCBva2F5LiDwn5iKIEkgd2lsbCBrZWVwIGl0IGlu
IGEgc2VwYXJhdGUgcHJlcGF0Y2ggaW4gdjguIA0KDQpUaGFua3MsDQpNYW5pc2gNCg==
