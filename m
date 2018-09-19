Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5512ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E85E2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FrjLloV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E85E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeISTS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:18:56 -0400
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:28496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730967AbeISTS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CKpAnVS8l4UvdZMHCPXEuzh4rXiFCpQBeZOMEHWP34=;
 b=FrjLloV4MGxia5JBck1yjCwlaH6WZjdzsWhq9PfFppWBI0C3Hgow71NronCci7B8WY8oNL+RdOxuaUXBxBTe24jC8wAahIw5vMxvn38u19bP8qlKlXCrxotjpDJENh/hg9Zf3c6EE9TvDFsAweoIiS9444SpgyorjKCOo/Rez+Q=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1900.namprd12.prod.outlook.com (10.175.88.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:40:53 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::891b:95e5:59d9:fcf]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::891b:95e5:59d9:fcf%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:40:53 +0000
From:   Gary R Hook <ghook@amd.com>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Dan Carpenter <Dan.Carpenter@oracle.com>
Subject: Re: [PATCH 1/2] Fix static checker warning
Thread-Topic: [PATCH 1/2] Fix static checker warning
Thread-Index: AQHUTHrd4EGmpndo9E2kPbMvT9vxXaT3o7KA
Date:   Wed, 19 Sep 2018 13:40:53 +0000
Message-ID: <8dfca0f4-6639-3444-148f-eb0b0817fec6@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:300:94::27) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [47.220.174.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1900;20:jmVb9iO/486OfATaBtFr0fQUjTmAf+GJSGPgWUv4A0LWqvcu5XH6iXNYMEUAgQWGNcUJRcBzSTCUBaKNEsdAifumPsU/FGk/ISuv4CKXN16Xnq7cX1em/4PFsokpHSL5WTVDH5VtNFZx22nrv1XC5bdM1xg73hqAfZuGPlAzaJ+Xtxo0eLihcrZrD4cecZaMbiJIn+UbylXqdAMARqt62xIoJsaYKTEOtS3Mp06fpuCOd8ZAXOaWcokETDtt13he
x-ms-office365-filtering-correlation-id: 52db7645-1059-40ba-445a-08d61e35849b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1900;
x-ms-traffictypediagnostic: DM5PR12MB1900:
x-microsoft-antispam-prvs: <DM5PR12MB190050A60819071494F87FECFD1C0@DM5PR12MB1900.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:DM5PR12MB1900;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1900;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(6506007)(106356001)(8676002)(2906002)(2900100001)(229853002)(8936002)(81156014)(305945005)(6436002)(81166006)(25786009)(4326008)(53936002)(7736002)(6512007)(31686004)(36756003)(5660300001)(6246003)(6116002)(68736007)(66066001)(478600001)(3846002)(6486002)(97736004)(105586002)(486006)(256004)(72206003)(5250100002)(2501003)(14454004)(446003)(476003)(54906003)(110136005)(2201001)(53546011)(31696002)(26005)(14444005)(316002)(2616005)(386003)(99286004)(76176011)(102836004)(52116002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1900;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xCcAxviS1qnRaooe6aEpfBIkjuwJu81elMa47VH3xbNPK5j77GbvYQEI5kAfhsiKMpCReZFOGDCuO5Pi/opuCcESLY4wm9zzedCmRqEteaBBE1QxWC8+hDjLv38WCMeLiRPCoM6RpMynnMgsy4wdyfjitLdiy/uRAIkVqz0zGyBIj0UxE0zMqKaGUcCPrVfQKHFrcL7oU/8y6+zlIXy6ZzbxbLt5ogVBM0QdY3QAocZCCKhpP2l8JPV+/J3ByPdi0VxoqRIkZayrillh2xkgNdIWrmxkgNQ0htiI4so9gm44P+Clr10w5c6LrbnTPVOlnFlKad0zdpKfRYlNA44ZL48hbTYu8qmqLo+9a8EQgek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B459037630B75D43A2C089B6DDD7A5F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db7645-1059-40ba-445a-08d61e35849b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:40:53.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMTQvMjAxOCAwNTozMiBQTSwgSmFuYWthcmFqYW4gTmF0YXJhamFuIHdyb3RlOg0KPiBV
bmRlciBjZXJ0YWluIGNvbmZpZ3VyYXRpb24gU0VWIGZ1bmN0aW9ucyBjYW4gYmUgZGVmaW5lZCBh
cyBuby1vcC4NCj4gSW4gc3VjaCBhIGNhc2UgZXJyb3IgY2FuIGJlIHVuaW5pdGlhbGl6ZWQuDQo+
IA0KPiBJbml0aWFsaXplIHRoZSB2YXJpYWJsZSB0byAwLg0KPiANCj4gQ2M6IERhbiBDYXJwZW50
ZXIgPERhbi5DYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50
ZXIgPERhbi5DYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFuYWthcmFq
YW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNvbT4NCg0KQWNrZWQtYnk6
IEdhcnkgUiBIb29rIDxnYXJ5Lmhvb2tAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2Ny
eXB0by9jY3AvcHNwLWRldi5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2Nj
cC9wc3AtZGV2LmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5jDQo+IGluZGV4IDcyNzkw
ZDguLmY1NDFlNjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9wc3AtZGV2LmMN
Cj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL3BzcC1kZXYuYw0KPiBAQCAtNDIzLDcgKzQyMyw3
IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHBzcF9jb3B5X3VzZXJfYmxvYik7DQo+ICAgc3RhdGljIGlu
dCBzZXZfZ2V0X2FwaV92ZXJzaW9uKHZvaWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qgc2V2X3VzZXJf
ZGF0YV9zdGF0dXMgKnN0YXR1czsNCj4gLQlpbnQgZXJyb3IsIHJldDsNCj4gKwlpbnQgZXJyb3Ig
PSAwLCByZXQ7DQo+ICAgDQo+ICAgCXN0YXR1cyA9ICZwc3BfbWFzdGVyLT5zdGF0dXNfY21kX2J1
ZjsNCj4gICAJcmV0ID0gc2V2X3BsYXRmb3JtX3N0YXR1cyhzdGF0dXMsICZlcnJvcik7DQo+IA0K
DQo=
