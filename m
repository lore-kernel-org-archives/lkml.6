Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D202151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4+m80LMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D202151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbeISTMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:12:05 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:39472
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbeISTMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8gkgqZurczRjZ6PL2OJfM0g1P9WBg2PBWYGXi5rioY=;
 b=4+m80LMJ+u+dX9Zdh+cCLStDPVLYjFmCQnTcL0NJdLoOZGlnsiHv0PCadDpFJn6uGaRHBxqtD+WcfZK1Jbw3ThzUqUtSct+d6MeaKgm6FgdTFaKEE9DuDHup3D/r+Ac8c6g3cKlP0yAfdL0ETQ6T379wCXQrGEizpO0B29MfgE8=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4860.namprd02.prod.outlook.com (20.176.111.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:33:59 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:33:58 +0000
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
Thread-Index: AQHUTpJW1XQNYRxn3kWgpPIZoEhCVaT1rMEAgAFj0DCAAGaLgIAAI+zg
Date:   Wed, 19 Sep 2018 13:33:58 +0000
Message-ID: <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
In-Reply-To: <20180919111553.GA9140@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4860;6:i+msnHeZVmYGZgOs5YFHVtKU5QIbFjGFyS3kTOXPv0ERDjsd3BuY2LQN5EluWPkQCW/fEnAXKis9CuucGodY6p+gReAV4sVA/oBMBQeHmMUas7Bfm425jqJoY4S31Bq3JQUBvWqW41KsfCVQEmjgVa0rGB3JLbnzZo9pa02AtD6ofWhJpOTtrtVtadaCxAMFlBB8x8HLWrRNPEHgK/ZPCpgYVvkbnV78fctHUjhXsJ9oCt6pq41mENSoukQFVKJ8xOtGV9vjMjS9fgydAzEDcgGflx39s9GmPiqsMeZ8q37ebmEDn3nXWOhQFAe24hcDQOlT32QU8XLRvSb8LYfi3u7XafDzVy5oD+x04lpyEJpoTJshe+3pS08mrZO3jaSAKI6XanAA+PqMRxqGXM8/OKnOhAaz+HafHxiVVU4OdCPjq//HpYS2c4wcDW++CHiQXWjHWhb17RUhKOeplzVTcQ==;5:Oye27DkO1kS2/l3WVKM/Ph2Ixm9kK/WSwY2FZr0uI8zmpXS95HbKW5D2M70k6PnUFBkDlSukXvJhtT88QNx1+1y1QzN39vU2YMpCK1iUb0Pb3orRoTNr1QrYoVy5AXNHuao7eG5OQ2LGt4Z9Oe1iAa8bshY2OLVvDZYe0DbcRTw=;7:Srcf/pnpo1/J5cxjsAInpnQ87fqw0snpBeep5SOU+4JX1GygcJMIN2+cR83qJYBCmvsnZKT/qtvVx52fxh4x9QW0Rd4UQBnhxYNOP3J0Ke62ydZlBppgg8aWaamMdYHp+uqyKMW27CIs3yzesbLX4ChWQcJ6sJexbpzN5pEzHPqf4qs7l+CfIcaJJzt/JK8nKfC+yELeCNsepJSvKfXo81xkCsbA1pFbPtLMsBFLw5afha6OP+lguKPMX8zozbwa
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39850400004)(13464003)(199004)(189003)(186003)(446003)(33656002)(476003)(86362001)(93886005)(54906003)(256004)(97736004)(6116002)(3846002)(99286004)(2906002)(486006)(316002)(5660300001)(6916009)(5250100002)(105586002)(66066001)(7696005)(76176011)(106356001)(14454004)(26005)(72206003)(2900100001)(6436002)(55016002)(11346002)(53546011)(305945005)(53936002)(8676002)(9686003)(6506007)(7736002)(74316002)(229853002)(102836004)(81166006)(25786009)(7416002)(4326008)(68736007)(478600001)(8936002)(81156014)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4860;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d8f7d04c-6f20-460f-c9d1-08d61e348dd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4860;
x-ms-traffictypediagnostic: DM6PR02MB4860:
x-microsoft-antispam-prvs: <DM6PR02MB4860453F55051C778B379290C11C0@DM6PR02MB4860.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DM6PR02MB4860;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4860;
x-forefront-prvs: 0800C0C167
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bCYPN8z1ieATun/bDidjdEHLFlpVOqmYoYfgos3EaY035XZ5GWMn3H2w0997VW00JuIuQstrUfUbRZNbREd53pW3U7YVfbd+PgkmHMutV2SU992INid/l38tzKM30hj/9BM9ujTjGkwGlRpt5C2fzZGTKuniCW5ww+fwiVwkxX9tpwSVU6UjAKdc0mtFlVtOXnHYqrkDUkrIal6LCoXi7vUyG6Aa0WVt4a42PmKUFxqI6dcx4xX0W/ekef+OXxllCVT+w14RUE61x5iIvvijdkKgkhcwgqdS2Dhnq4eXOni97wxsAKcIbwRrCC8n1FIcOG/o85f4eAf9OT0SE9hF7C1zIV83NfXjUNIEHbsVyLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f7d04c-6f20-460f-c9d1-08d61e348dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:33:58.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNs
YXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAxOSwgMjAxOCA0OjQ2IFBNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlu
eC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBt
Y2hlaGFiQGtlcm5lbC5vcmc7DQo+IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsg
bGVveWFuZy5saUBueHAuY29tOw0KPiBzdWRlZXAuaG9sbGFAYXJtLmNvbTsgYW1pdC5rdWNoZXJp
YUBsaW5hcm8ub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAy
LzddIGVkYWM6IHN5bnBzOiBBZGQgcGxhdGZvcm0gc3BlY2lmaWMgc3RydWN0dXJlcyBmb3INCj4g
ZGRyYyBjb250cm9sbGVyDQo+IA0KPiBPbiBXZWQsIFNlcCAxOSwgMjAxOCBhdCAwNToxNDo1MUFN
ICswMDAwLCBNYW5pc2ggTmFyYW5pIHdyb3RlOg0KPiA+ID4gU28gSSdtIGdvaW5nIHRvIHN0b3Ag
cmV2aWV3aW5nIHRoaXMgcGF0Y2hzZXQgdW50aWwgeW91IGdvIHRocm91Z2gNCj4gPiA+IHRoZSBv
bGQgcmV2aWV3IHJvdW5kIGFnYWluIGFuZCBtYWtlIHN1cmUgeW91J3ZlIGluY29ycG9yYXRlZCAq
YWxsKg0KPiA+ID4gcmV2aWV3IGZlZWRiYWNrIGFuZCBoYXZlbid0IGZvcmdvdHRlbiBzb21lLCBs
aWtlIHRoZSBvbmUgYWJvdmUuDQo+ID4gPg0KPiA+IE9rYXksIEkgd2lsbCBkb3VibGUgY2hlY2sg
YWdhaW4gZm9yIHRoZSBjb21tZW50cyBmcm9tIHByZXZpb3VzIHJldmlldw0KPiA+IGFuZCByZWN0
aWZ5IHRoZSBzYW1lIGluIHY4LiBDYW4geW91IHBsZWFzZSByZXZpZXcgdGhlIHJlbWFpbmluZw0K
PiA+IHBhdGNoZXMgc28gdGhhdCBJIGNhbiBhY2NvbW1vZGF0ZSBhbnkgY2hhbmdlcyBmb3IgdGhl
bSBpbiB2OD8NCj4gDQo+IFJlYWQgYWdhaW4gd2hhdCBJIHNhaWQ6ICJJJ20gZ29pbmcgdG8gc3Rv
cCByZXZpZXdpbmcgdGhpcyBwYXRjaHNldCB1bnRpbCB5b3UgZ28NCj4gdGhyb3VnaCB0aGUgb2xk
IHJldmlldy4uLiIgWW91IGNhbiBnbyB0aHJvdWdoIHRoZSBvbGQgcmV2aWV3IGFuZCBjaGVjayB5
b3VyIHY3Lg0KPiBJZiB5b3UgaGF2ZW4ndCBtaXNzZWQgYW55dGhpbmcsIGxlbW1lIGtub3cgYW5k
IEknbGwgbG9vayBhdCB0aGUgcmVzdC4NCg0KQXBhcnQgZnJvbSB0aGlzIG9uZSwgSSBoYXZlIGNv
dmVyZWQgYWxsIHRoZSBjb21tZW50cyBmcm9tIHRoZSBwcmV2aW91cyByZXZpZXcuDQoNClRoYW5r
cywNCk1hbmlzaA0K
