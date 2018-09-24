Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1716C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28852208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FGGvQOMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28852208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeIYD0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:26:38 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:4160
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728192AbeIYD0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nINBNNZtEb858PedDWfOYMt1uhkeaRiS4qG4Eir9x/Y=;
 b=FGGvQOMJELqT9CbVGoabQ3rqsnK/Tt4fWutcILn77PJa71tcRRWNnHK/iZhwvS69FFuufRuiTCUYmzO29ohWnpdiSdXbVxf9mlp0/psT73aRUauqINmCOWvgPzNF3rPRzWU9NnsOxDzaKTPUz1p8ulAVIZQzi6UNTer836v5B5E=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1899.namprd12.prod.outlook.com (10.175.88.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 21:22:24 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3dd3:8627:430e:c3d3%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 21:22:24 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Thread-Topic: [PATCH] crypto: ccp: Remove forward declaration
Thread-Index: AQHUVCu+pP0dlJnsRUaui4HOI4H1AaT/eo2AgABaDgCAABxrgA==
Date:   Mon, 24 Sep 2018 21:22:24 +0000
Message-ID: <9cbc1f67-719e-de75-8b0c-2de4da71b2f8@amd.com>
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
 <20180924194040.GA17672@flashbox>
In-Reply-To: <20180924194040.GA17672@flashbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:3:9a::21) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1899;20:fIGBQVAN22VQcTs0PRREpTTnmPSX6UfOk7lUsr5DkCfosXC5wL2/0cxVkQrMFz79RjInxIFcWEonRAOBq9NTXMea2lgWzEto8O5qTRcSK76VjhUv5OsddsI3AiGXXztN402Y56sarO8p5bq9xqXfaoQFoKHCVJJJ66BfxckSNNv+A5/BL5XlYoQXhyul5GjzaDPDd24EbRqL5iJw1TK5EyH7yCWTQWZp1VlsarxGa7jFeZO4RP7/K7y219SdjoHM
x-ms-office365-filtering-correlation-id: 00eb5326-fd83-488f-10e9-08d62263d210
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1899;
x-ms-traffictypediagnostic: DM5PR12MB1899:
x-microsoft-antispam-prvs: <DM5PR12MB1899E171FF3246F9F40A9584FD170@DM5PR12MB1899.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB1899;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1899;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(26005)(31686004)(14454004)(486006)(72206003)(305945005)(8936002)(316002)(6246003)(2900100001)(446003)(52116002)(14444005)(256004)(478600001)(81156014)(81166006)(97736004)(476003)(53936002)(229853002)(105586002)(39060400002)(186003)(7736002)(54906003)(99286004)(5250100002)(6512007)(68736007)(6506007)(1411001)(6486002)(6436002)(5660300001)(11346002)(25786009)(36756003)(66066001)(6116002)(3846002)(2616005)(102836004)(31696002)(2906002)(106356001)(6916009)(71200400001)(71190400001)(76176011)(4326008)(53546011)(8676002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1899;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n9/vbx/oqNg6SfgRfrgaXmuk74kHMIKSjlPHxTySAKFhxASHwM2RtWYBIsnpeqx5JR0gvfs+oJDZofDmuaG52GNrKnqJ/aMlBl+a4TgZ1dNs5yiU0P4XJNO7P/qFwM8f+RVR0cRSabz6EVTCk/5d1lnGSd+/6ozqeV1FY4eYV6BAZSZ4XE1diQKPTXlgnlWxX3Y71bEHox/SmevV1UaQszv+yOFRNsp1u1KS07OOrtuF5x2xD6zY+nmZpMqRFina961Z5A4L0B/KIbOdTIM5wnKjSk2GNfQKNQPMHWnbd6HmAKPihnlGtb7ZlcfjlEgVLmjmisrl8uO10mM4BMj+vxpQNhgFVvfC+yT+hn6BKMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9155C1445D2E374C802DF4A1D4E2CB16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb5326-fd83-488f-10e9-08d62263d210
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 21:22:24.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjQvMjAxOCAwMjo0MCBQTSwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+IE9uIE1v
biwgU2VwIDI0LCAyMDE4IGF0IDA3OjE4OjIzUE0gKzAwMDAsIEdhcnkgUiBIb29rIHdyb3RlOg0K
Pj4gT24gMDkvMjQvMjAxOCAxMjoyNiBQTSwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+Pj4g
Q2xhbmcgZW1pdHMgYSB3YXJuaW5nIGFib3V0IHRoaXMgY29uc3RydWN0Og0KPj4+DQo+Pj4gZHJp
dmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmM6MzY6MzY6IHdhcm5pbmc6IHRlbnRhdGl2ZSBh
cnJheQ0KPj4+IGRlZmluaXRpb24gYXNzdW1lZCB0byBoYXZlIG9uZSBlbGVtZW50DQo+Pj4gc3Rh
dGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBzcF9hY3BpX21hdGNoW107DQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4+PiAxIHdhcm5pbmcgZ2VuZXJh
dGVkLg0KPj4+DQo+Pj4gSnVzdCByZW1vdmUgdGhlIGZvcndhcmQgZGVjbGFyYXRpb25zIGFuZCBt
b3ZlIHRoZSBpbml0aWFsaXphdGlvbnMgdXANCj4+PiBzbyB0aGF0IHRoZXkgY2FuIGJlIHVzZWQg
aW4gc3BfZ2V0X29mX3ZlcnNpb24gYW5kIHNwX2dldF9hY3BpX3ZlcnNpb24uDQo+Pg0KPj4gSSdt
IG5vdCBnb2luZyB0byBvdXQgYW5kIG91dCBvYmplY3QgdG8gdGhpcyBqdXN0IHlldC4NCj4+DQo+
PiBJIGFtIG5vdCBhIGNsYW5nIGV4cGVydC4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBhIG1ha2Ug
Y29tbWFuZCB0aGF0DQo+PiB3b3VsZCBleHBsYWluIGhvdyB5b3UgcHJlY2lwaXRhdGVkIHRoaXMg
Y29tcGxhaW50Pw0KPj4NCj4gDQo+IEhpIEdhcnksDQo+IA0KPiBJIGNhbiBwcm9kdWNlIHRoZSB3
YXJuaW5nIHdpdGggQ2xhbmcgNi4wIHVzaW5nIHRoZSBmb2xsb3dpbmcgc2V0IG9mDQo+IGNvbW1h
bmRzOg0KPiANCj4gbWFrZSBBUkNIPWFybTY0IENDPWNsYW5nIENST1NTX0NPTVBJTEU9YWFyY2g2
NC1saW51eC1nbnUtIGFsbHllc2NvbmZpZw0KPiAuL3NjcmlwdHMvY29uZmlnIC1kIENPTkZJR19D
UFVfQklHX0VORElBTg0KPiBtYWtlIEFSQ0g9YXJtNjQgQ0M9Y2xhbmcgQ1JPU1NfQ09NUElMRT1h
YXJjaDY0LWxpbnV4LWdudS0gb2xkZGVmY29uZmlnDQo+IG1ha2UgQVJDSD1hcm02NCBDQz1jbGFu
ZyBDUk9TU19DT01QSUxFPWFhcmNoNjQtbGludXgtZ251LSBkcml2ZXJzL2NyeXB0by9jY3Avc3At
cGxhdGZvcm0ubw0KDQpObywgSSJtIG5vdCBnZXR0aW5nIGEgd2FybmluZyBvbiBteSBzeXN0ZW0u
IEkgZ2V0IHRoaXM6DQoNCmdob29rQHRhb3M6fi9zcmMvY3J5cHRvZGV2LTIuNi9zcmMkIG1ha2Ug
QVJDSD1hcm02NCBDQz1jbGFuZyANCkNST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIENG
TEFHUz0tdg0KYXJjaC9hcm02NC9NYWtlZmlsZToyNzogbGQgZG9lcyBub3Qgc3VwcG9ydCAtLWZp
eC1jb3J0ZXgtYTUzLTg0MzQxOTsgDQprZXJuZWwgbWF5IGJlIHN1c2NlcHRpYmxlIHRvIGVycmF0
dW0NCmFyY2gvYXJtNjQvTWFrZWZpbGU6NDA6IExTRSBhdG9taWNzIG5vdCBzdXBwb3J0ZWQgYnkg
YmludXRpbHMNCmFyY2gvYXJtNjQvTWFrZWZpbGU6NDg6IERldGVjdGVkIGFzc2VtYmxlciB3aXRo
IGJyb2tlbiAuaW5zdDsgDQpkaXNhc3NlbWJseSB3aWxsIGJlIHVucmVsaWFibGUNCiAgIENBTEwg
ICAgc2NyaXB0cy9jaGVja3N5c2NhbGxzLnNoDQogICBWRFNPQSAgIGFyY2gvYXJtNjQva2VybmVs
L3Zkc28vZ2V0dGltZW9mZGF5Lm8NCmFyY2gvYXJtNjQva2VybmVsL3Zkc28vZ2V0dGltZW9mZGF5
LlM6IEFzc2VtYmxlciBtZXNzYWdlczoNCmFyY2gvYXJtNjQva2VybmVsL3Zkc28vZ2V0dGltZW9m
ZGF5LlM6Mjg6IEVycm9yOiBubyBzdWNoIGluc3RydWN0aW9uOiANCmB2ZHNvX2RhdGEgLnJlcSB4
NicNCmFyY2gvYXJtNjQva2VybmVsL3Zkc28vZ2V0dGltZW9mZGF5LlM6Mjk6IEVycm9yOiBubyBz
dWNoIGluc3RydWN0aW9uOiANCmBzZXFjbnQgLnJlcSB3NycNCmFyY2gvYXJtNjQva2VybmVsL3Zk
c28vZ2V0dGltZW9mZGF5LlM6MzA6IEVycm9yOiBubyBzdWNoIGluc3RydWN0aW9uOiANCmB3X3Rt
cCAucmVxIHc4Jw0KLi4uDQoNClRoZSBvbmx5IHJlYXNvbiBJIGJyaW5nIHRoaXMgdXAgaXMgdGhh
dCBpdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGJlIGFibGUgDQp0byByZWNyZWF0ZSByZXN1bHRzLiBJ
IGZpZ3VyZSBJJ20gbm90IHNldCB1cCBmb3IgdGhpcy4NCg0KVGhhdCBzYWlkLi4uIHBsZWFzZSBz
ZWUgbXkgcmVzcG9uc2UgdG8gTmljay4NCg==
