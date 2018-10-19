Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48805ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B252087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="jr+5tT6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B252087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJSX7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:59:25 -0400
Received: from mail-eopbgr700126.outbound.protection.outlook.com ([40.107.70.126]:10560
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbeJSX7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjmb2tpdGnYa8aD6oZxiW4IPov/vV6o2/u6QCDnShPY=;
 b=jr+5tT6v32Sc2r0LaeeB0gjXyRs5cZwon/TC971vMXGaSXJ1LT2WQPi5rXOmybAxO+OZE4cER/q9LgmG88+wlMBnORAB7ywKjl95LsH4Zei738rtMaBVKGm/gMvQNYJ2YOV8xAFY0CEE5prUJdzOk6BdqjrnUbRbkkp8/GHU2Uk=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2448.namprd13.prod.outlook.com (52.135.95.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.18; Fri, 19 Oct 2018 15:52:37 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475%3]) with mapi id 15.20.1273.012; Fri, 19 Oct 2018
 15:52:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Topic: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Thread-Index: AQHUZ6Y0R00wjCb1DkumOvVKjG/0GKUmuDWA
Date:   Fri, 19 Oct 2018 15:52:37 +0000
Message-ID: <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
         <20181019122049.27121-5-mszeredi@redhat.com>
In-Reply-To: <20181019122049.27121-5-mszeredi@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2448;6:oN3cywHTRksD5U9oTNAgTuJYUHklds7jeUfdtXx3NC6rV2EodpDVjDQfc75WWCogJOJb1qwsw6vHRDIopWniikr5bXSVRmU6AiGvMie+1zsvOd5dCFEbtiBHh9tEaYdVyTSTbFxGxBDaALkvhc7f26fz8S1Gbz95pOyPSNm4gQ3AnmcFqIhvp6eszEucUS/ZZemIbNSUP08MNZyULWJW1gxp0gzc9e96GmAVLuvaHHAREuaZpjufV8JNWKSsR3MS8c+DNwhHf9tDc0fcGoG1HsiugN7JTN7OdgZOr0OQ2I07cQe+pLOUWKVrhnD4t1WYrx6MXqQfX6p5iIXP+TLlL5TcwmXVwHRqtej2eiqzYSpYR79WsuaAQesoy+dZ7ErvdAReh0eYEofyro4M6oshXnZVhBr0eMAH97HlKhKzQFistKwvZTwn2qNTnS6VSVcyyPBOHloJZu5J7tW0LqGxDQ==;5:FlbRzVYOA6eA1kRsS7jQ0/s3xrNSng0yJjXNheb4biTak89vCyJceViblE3uwTLxp/pSwih5aeRtHvC8ZdmJsd5qYvWnIdGY9NXhLovwzQ3BpoeVs/Vx+UJpCTbB3dIUJTcZEoAIgJ0mZPmmFbn/B/FSoS6m5t4pQFSynUztpMY=;7:iGCc36UT/1Vu9Cbs6em1+r1IiHasF/+H8/HAhaskB+jOjpUl4I1X+wuPq1gwBive4YoMCfrN+tUVCGQ42ljfkUjzNC1yA4TOwdgD3F8TCoAZtkXQBxBbYPfv3sYxyCVSgW17cYB5E9DpbjHZR62f0z8dBZwVBHReqCC6tPBHrlLlhzwc0VzZtmvbg4XfcSg2gn0r9KTO0RIxQN0ziVsVvhUuQwiiFeKcq/dCl3oAM3egRL2xpYtsPhmueH8GsrCY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 963e921d-c53e-4db0-19d4-08d635dae4ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2448;
x-ms-traffictypediagnostic: SN6PR13MB2448:
x-microsoft-antispam-prvs: <SN6PR13MB2448F82192E3306D9FB63D92B8F90@SN6PR13MB2448.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR13MB2448;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2448;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(316002)(476003)(54906003)(76176011)(86362001)(478600001)(6506007)(6486002)(25786009)(9686003)(110136005)(6246003)(4326008)(2906002)(8936002)(36756003)(14454004)(97736004)(105586002)(229853002)(7736002)(256004)(66066001)(3846002)(305945005)(186003)(81156014)(6116002)(5660300001)(2900100001)(5250100002)(81166006)(118296001)(6346003)(2501003)(53936002)(102836004)(8676002)(4001150100001)(6436002)(39060400002)(11346002)(486006)(6512007)(446003)(71200400001)(68736007)(99286004)(33896004)(106356001)(26005)(14444005)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2448;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-microsoft-antispam-message-info: W5F9kBL8xi4UCbxDUIFl1amjz4yxt6R0KV2VNW4lhSk490/6fJ3yCEvAu/TRkOUjY7j7TXea/E9l4hgX8s9FJ1XbBN6jAIaEP4OxQCjGWaF7Iz5lR9vyZQrBFp60z3YhUrFcvMJdDN/ai42W0wzTJEnkvMQa4NRaczoUVLR5NLKVjmlBXIO9sPAQ6zXX8yZVCG79qSewbvJISdiz0+aXZfUhTqShET/wcvGlbDig/e0+8Rg1Fxgd7EIQWWJHZqToKAHV0COsmzyXJeWxEYYEaOMXHarzEDj0G4NLYdMVPlYAylyOK8W4AK+FzN3D9WdB5eAiVhDzXv21nELGUg/ksTeOFWIFHr947NPr7vQrsm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <97C3A830F271724381B095718B2197D2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963e921d-c53e-4db0-19d4-08d635dae4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 15:52:37.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTE5IGF0IDE0OjIwICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gQXMgcGVyIHN0YXR4KDIpIG1hbiBwYWdlIG9ubHkgY2xlYXIgb3V0IGZsYWdzIHRoYXQgYXJl
IHVuc3VwcG9ydGVkIGJ5DQo+IHRoZQ0KPiBmcyBvciBoYXZlIGFuIHVucmVwcmVzZW50YWJsZSB2
YWx1ZS4gIEF0aW1lIGlzIHN1cHBvcnRlZCBieSBORlMgYXMNCj4gbG9uZyBhcw0KPiBpdCdzIHN1
cHBvcnRlZCBvbiB0aGUgc2VydmVyLg0KPiANCj4gU28gdGhlIFNUQVRYX0FUSU1FIGZsYWcgc2hv
dWxkIG5vdCBiZSBjbGVhcmVkIGluIHRoZSByZXN1bHRfbWFzayBpZg0KPiB0aGUNCj4gb3BlcmF0
aW9uIHdhcyByZXF1ZXN0ZWQgb24gYSBNTlRfTk9BVElNRSBvciBNTlRfTk9ESVJBVElNRSBtb3Vu
dC4NCj4gDQo+IFRoaXMgcGF0Y2ggZG9lc24ndCBjaGFuZ2UgdGhlIHJldmFsaWRhdGlvbiBhbGdv
cml0aG0gaW4gYW55IHdheSwganVzdA0KPiB0aGUNCj4gY2xlYXJpbmcgb2YgZmxhZ3MgaW4gc3Rh
dC0+cmVzdWx0X21hc2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtsb3MgU3plcmVkaSA8bXN6
ZXJlZGlAcmVkaGF0LmNvbT4NCj4gRml4ZXM6IDljY2VlOTQwYmQ1YiAoIlN1cHBvcnQgc3RhdHgo
KSBtYXNrIGFuZCBxdWVyeSBmbGFncw0KPiBwYXJhbWV0ZXJzIikNCj4gQ2M6IFRyb25kIE15a2xl
YnVzdCA8dHJvbmQubXlrbGVidXN0QHByaW1hcnlkYXRhLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMv
aW5vZGUuYyB8IDUgKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9p
bm9kZS5jDQo+IGluZGV4IGI2NWFlZTQ4MWQxMy4uMzRiYjNlNTkxNzA5IDEwMDY0NA0KPiAtLS0g
YS9mcy9uZnMvaW5vZGUuYw0KPiArKysgYi9mcy9uZnMvaW5vZGUuYw0KPiBAQCAtODExLDcgKzgx
MSw3IEBAIGludCBuZnNfZ2V0YXR0cihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgc3RydWN0DQo+
IGtzdGF0ICpzdGF0LA0KPiAgCWlmICghKHJlcXVlc3RfbWFzayAmDQo+IChTVEFUWF9NT0RFfFNU
QVRYX05MSU5LfFNUQVRYX0FUSU1FfFNUQVRYX0NUSU1FfA0KPiAgCQkJCQlTVEFUWF9NVElNRXxT
VEFUWF9VSUR8U1RBVFhfR0lEDQo+IHwNCj4gIAkJCQkJU1RBVFhfU0laRXxTVEFUWF9CTE9DS1Mp
KSkNCj4gLQkJZ290byBvdXRfbm9fcmV2YWxpZGF0ZTsNCj4gKwkJZ290byBvdXRfbm9fdXBkYXRl
Ow0KPiAgDQo+ICAJLyogQ2hlY2sgd2hldGhlciB0aGUgY2FjaGVkIGF0dHJpYnV0ZXMgYXJlIHN0
YWxlICovDQo+ICAJZG9fdXBkYXRlIHw9IGZvcmNlX3N5bmMgfHwgbmZzX2F0dHJpYnV0ZV9jYWNo
ZV9leHBpcmVkKGlub2RlKTsNCj4gQEAgLTgzMyw5ICs4MzMsNiBAQCBpbnQgbmZzX2dldGF0dHIo
Y29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIHN0cnVjdA0KPiBrc3RhdCAqc3RhdCwNCj4gIAkJCWdv
dG8gb3V0Ow0KPiAgCX0gZWxzZQ0KPiAgCQluZnNfcmVhZGRpcnBsdXNfcGFyZW50X2NhY2hlX2hp
dChwYXRoLT5kZW50cnkpOw0KPiAtb3V0X25vX3JldmFsaWRhdGU6DQo+IC0JLyogT25seSByZXR1
cm4gYXR0cmlidXRlcyB0aGF0IHdlcmUgcmV2YWxpZGF0ZWQuICovDQo+IC0Jc3RhdC0+cmVzdWx0
X21hc2sgJj0gcmVxdWVzdF9tYXNrOw0KPiAgb3V0X25vX3VwZGF0ZToNCj4gIAlnZW5lcmljX2Zp
bGxhdHRyKGlub2RlLCBzdGF0KTsNCj4gIAlzdGF0LT5pbm8gPSBuZnNfY29tcGF0X3VzZXJfaW5v
NjQoTkZTX0ZJTEVJRChpbm9kZSkpOw0KDQpOQUNLLg0KDQpXaGVuIHdlIGRvbid0IHJldmFsaWRh
dGUgdGhlIGF0dHJpYnV0ZSwgdGhlbiB0aGUgY29udGVudCBvZiB0aGUgZmllbGQNCmNvbnRhaW5z
IGp1bmsgdmFsdWVzLiBUaGUgYWJvdmUgY29kZSBpcyB2ZXJ5IGludGVudGlvbmFsLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
