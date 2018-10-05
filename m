Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F566C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F311C206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F1EjHOZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJEThb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:37:31 -0400
Received: from mail-he1eur01on0069.outbound.protection.outlook.com ([104.47.0.69]:19072
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbeJETha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1VgpMvlbzLlmb8RRJD91PT/sIfRzJfEvnTnhkIj+LA=;
 b=F1EjHOZnDLvpmirNjkLBPRN5gO/diab5p0Gc5p9ijV67VzCUJXXFYnXy5QjorwK56FlRqN3GPjdZBc+TS5bLxgtujI4Iz9S5XcMejG0XEAHBprp6zgP+OcO9xYpoUfw29Fphjpbfv6sHe1HR+xY9Eip7kKb4Sz0r5bLbgXqlLLM=
Received: from HE1PR08MB2923.eurprd08.prod.outlook.com (10.170.245.152) by
 HE1PR08MB1132.eurprd08.prod.outlook.com (10.166.87.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Fri, 5 Oct 2018 12:38:08 +0000
Received: from HE1PR08MB2923.eurprd08.prod.outlook.com
 ([fe80::f56f:6527:cd12:9a1f]) by HE1PR08MB2923.eurprd08.prod.outlook.com
 ([fe80::f56f:6527:cd12:9a1f%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 12:38:08 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/arm/malidp: remove set but not used variable
 'afbc_superblock_size'
Thread-Topic: [PATCH -next] drm/arm/malidp: remove set but not used variable
 'afbc_superblock_size'
Thread-Index: AQHUXKhEKDCQ3r1BYkWclw6zYkyGEg==
Date:   Fri, 5 Oct 2018 12:38:08 +0000
Message-ID: <20181005123805.GE1156@e110455-lin.cambridge.arm.com>
References: <1538737393-112861-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538737393-112861-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: DB6PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:6:2::41) To HE1PR08MB2923.eurprd08.prod.outlook.com
 (2603:10a6:7:30::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Liviu.Dudau@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB1132;6:FcBMPekWRnmWRmMKfszEWpd3scIxN20fDuQQm5O3HInkjLCQuHjRKu8ABO6wc+OOrBzYApkpoDRNuJ9pRaH8hDxUPaXcMcwgZCDrj6N3WWZBNisGLfG248iu+r7ADqXSjLcysGRmIs7iMiieL1Cmon6jVOb7QK2ilOnAdJhOGCseJnYi6rnA87YFX1JEpG7BKCgcY1ClhgXkfpKchZwc7MUg/XxZKBbZEUpDCJKaz2QrRkXoG5PMebJ2GNauZHBrX2zAWLlsl3CpM8exUQep2/E1pgUi0Z93z63prGni1E21HkPXhwCmsb+7f5W6AUj86EGgT65UpSkrLgbyqCMfmCasXZVP13ThIXg4l93UVDBqHa4IxuL6g+1yRUrlTfaDwxaBT2H+dwo+tP2RqnGy2FG0XH1/A5OLeshwVsJU4HSNwGsT1B38fr4USuxalCc1PHpm3vV/zbM0QXuudZY/YQ==;5:QyCl8XsAA2MJI6fk1iCS+qpucwZR14TwVw80UARmApXDQzxHBP7D8W4CAeN4VyL8uUnGug8S9p4QNDpOlp04K6gqfsoGKYwmeELhuRoAJ0WvBUpo6XtOiFaWDXt1VGeKKka8iAcx5b7McCwVOmKpnHnryepxRBcT0XnYweKx52E=;7:BxMzVkiQMmkz2jUIDcHebeWwFcR8Q7UipgLTYZbzzeTJlkgVoOZUGeQG4oc8IhMMHzgurv43Eedj6h09MjvQswAeLK6FnY4zC/oH/Yg6nG+Vp9oB8CXjrjmzFHrWRjKuFi9kAVRko39+kAS+g/NbnvADxrIPjmE4Ahb5M3K3cqlxGvSceDhlr01F4ANhTmuTjXZ203vvmmAOJTP/lPZZbYjZKMfHkCsih1Aiwb4yWzoMDA7an317nCqB+7uoHygW
x-ms-office365-filtering-correlation-id: c8d39464-6a40-4c0b-3e9e-08d62abf6734
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB1132;
x-ms-traffictypediagnostic: HE1PR08MB1132:
x-microsoft-antispam-prvs: <HE1PR08MB1132E1073F9D34F3D5DC677BEBEB0@HE1PR08MB1132.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HE1PR08MB1132;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB1132;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(40434004)(4326008)(25786009)(102836004)(229853002)(8936002)(7736002)(5660300001)(305945005)(6436002)(5250100002)(14454004)(6486002)(3846002)(6116002)(53936002)(68736007)(478600001)(33656002)(72206003)(186003)(26005)(6512007)(1076002)(6916009)(81156014)(81166006)(8676002)(2900100001)(14444005)(6506007)(386003)(52116002)(97736004)(2906002)(76176011)(71190400001)(71200400001)(44832011)(11346002)(446003)(476003)(486006)(256004)(5024004)(66066001)(106356001)(105586002)(6246003)(54906003)(575784001)(316002)(86362001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB1132;H:HE1PR08MB2923.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fG9Nd1X/DnJpyWMmLXZGGVJS1+FmSH+U1pUj2kpcqrzW+M1hcIx0Nv8ruVSyUVe6jzmpFxxFkONTmKatBl8+llgJ/5thJlUncXiHA4UcN9RTMNkIsOq/7Wu43Xehzd9iuUoAu+radpjpC/vWVoZRCQ6boyfL873zne7yR1hwWM1sGcJoDs9EYlbQ4IFMLcvBBq9XD35S+ano3z/bMX7/vr2RaRBMGYey5uwhZz5KqsS1mekdAwJ29i0L6TEPEn8oUDVj+dAmRCdvgzh2tWA24ih7l4VqiU4X9jCZkce86VP5AUiW7XkTWZRSUlmwv2DAXoqguawtv3/rs9c8H6n4t93fV8TeERQj9d9lfPkvA1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEF2CAF3BA186241A4923ACAF7B89F30@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d39464-6a40-4c0b-3e9e-08d62abf6734
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 12:38:08.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB1132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20181005123808.Cj8Mjg53GIspRWYQunIpup_QO7Cphp6dbzt7w-ryuM4@z>

T24gRnJpLCBPY3QgMDUsIDIwMTggYXQgMTE6MDM6MTNBTSArMDAwMCwgWXVlSGFpYmluZyB3cm90
ZToNCj4gRml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOg0KPg0K
PiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9kcnYuYzogSW4gZnVuY3Rpb24gJ21hbGlkcF92
ZXJpZnlfYWZiY19mcmFtZWJ1ZmZlcl9zaXplJzoNCj4gZHJpdmVycy9ncHUvZHJtL2FybS9tYWxp
ZHBfZHJ2LmM6MzE4OjY6IHdhcm5pbmc6DQo+ICB2YXJpYWJsZSAnYWZiY19zdXBlcmJsb2NrX3Np
emUnIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+ICAgdTMy
IGFmYmNfc3VwZXJibG9ja19zaXplID0gMCwgYWZiY19zdXBlcmJsb2NrX2hlaWdodCA9IDA7DQo+
DQo+IEl0IG5ldmVyIHVzZWQgc2luY2UgYmUgaW50cm9kdWNlZCBpbg0KPiBjb21taXQgM2RhZTFj
MDkxOWQ4ICgiZHJtL2FybS9tYWxpZHA6IEltcGxlbWVudGVkIHRoZSBzaXplIHZhbGlkYXRpb24g
Zm9yIEFGQkMgZnJhbWVidWZmZXJzIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8
eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hcm0vbWFs
aWRwX2Rydi5jIHwgNSArLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9tYWxp
ZHBfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9kcnYuYw0KPiBpbmRleCA5MDIx
NDg1Li4xYjBlZGU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9k
cnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9kcnYuYw0KPiBAQCAtMzE1
LDcgKzMxNSw3IEBAIHN0YXRpYyB2b2lkIG1hbGlkcF9hdG9taWNfY29tbWl0X3RhaWwoc3RydWN0
IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KPiAgaW50IG5fc3VwZXJibG9ja3MgPSAwOw0KPiAg
Y29uc3Qgc3RydWN0IGRybV9mb3JtYXRfaW5mbyAqaW5mbzsNCj4gIHN0cnVjdCBkcm1fZ2VtX29i
amVjdCAqb2JqcyA9IE5VTEw7DQo+IC11MzIgYWZiY19zdXBlcmJsb2NrX3NpemUgPSAwLCBhZmJj
X3N1cGVyYmxvY2tfaGVpZ2h0ID0gMDsNCj4gK3UzMiBhZmJjX3N1cGVyYmxvY2tfaGVpZ2h0ID0g
MDsNCj4gIHUzMiBhZmJjX3N1cGVyYmxvY2tfd2lkdGggPSAwLCBhZmJjX3NpemUgPSAwOw0KPg0K
PiAgc3dpdGNoIChtb2RlX2NtZC0+bW9kaWZpZXJbMF0gJiBBRkJDX0ZPUk1BVF9NT0RfQkxPQ0tf
U0laRV9NQVNLKSB7DQo+IEBAIC0zMzMsOSArMzMzLDYgQEAgc3RhdGljIHZvaWQgbWFsaWRwX2F0
b21pY19jb21taXRfdGFpbChzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpDQo+ICBuX3N1
cGVyYmxvY2tzID0gKG1vZGVfY21kLT53aWR0aCAvIGFmYmNfc3VwZXJibG9ja193aWR0aCkgKg0K
PiAgKG1vZGVfY21kLT5oZWlnaHQgLyBhZmJjX3N1cGVyYmxvY2tfaGVpZ2h0KTsNCj4NCj4gLWFm
YmNfc3VwZXJibG9ja19zaXplID0gaW5mby0+Y3BwWzBdICogYWZiY19zdXBlcmJsb2NrX3dpZHRo
ICoNCj4gLWFmYmNfc3VwZXJibG9ja19oZWlnaHQ7DQo+IC0NCg0KQWgsIHRoYXQgZG9lc24ndCBs
b29rIHJpZ2h0LCBpdCBzZWVtcyBzb21lIGNvZGUgd2FzIGRyb3BwZWQgb3V0IG9mIHRoZQ0KdXBz
dHJlYW0gcGF0Y2guIEkgd2lsbCBzZW5kIGEgZml4IGZvciBpdCBub3cuDQoNCkJlc3QgcmVnYXJk
cywNCkxpdml1DQoNCj4gIGFmYmNfc2l6ZSA9IEFMSUdOKG5fc3VwZXJibG9ja3MgKiBBRkJDX0hF
QURFUl9TSVpFLCAxMjgpOw0KPg0KPiAgaWYgKG1vZGVfY21kLT53aWR0aCAqIGluZm8tPmNwcFsw
XSAhPSBtb2RlX2NtZC0+cGl0Y2hlc1swXSkgew0KPg0KDQotLQ0KPT09PT09PT09PT09PT09PT09
PT0NCnwgSSB3b3VsZCBsaWtlIHRvIHwNCnwgZml4IHRoZSB3b3JsZCwgIHwNCnwgYnV0IHRoZXkn
cmUgbm90IHwNCnwgZ2l2aW5nIG1lIHRoZSAgIHwNCiBcIHNvdXJjZSBjb2RlISAgLw0KICAtLS0t
LS0tLS0tLS0tLS0NCiAgICDCr1xfKOODhClfL8KvDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29u
dGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwg
YW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90
IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFu
eSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVt
LiBUaGFuayB5b3UuDQo=
