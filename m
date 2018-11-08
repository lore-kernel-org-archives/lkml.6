Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB9C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3788A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pWDp2+Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3788A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKHRvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:51:44 -0500
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:23551
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeKHRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8BETBakShZbidYjgWtnruhBaH6F1KxtmVak/z8i6Lw=;
 b=pWDp2+IsPu7Ygtz54oZGTaAhECjVoeM+c9PKteBTmNn5Lcj9gXO5wIR4IYcO7HFhuZn+pwFUVMkmLcpFl4lhsJWMlmiirxZh+gyhsUxbm9nqSdzWjhTIALFGcYibLGn9CNWbb6OHDAc8GxN9jDBJxWB0rvlHqxXaD6lCEMsow50=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1283.namprd12.prod.outlook.com (10.168.227.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Thu, 8 Nov 2018 08:17:21 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 08:17:21 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
Thread-Topic: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
Thread-Index: AQHUdweDmP98qIjmZEK1yRPFrhF9GKVFiNqA
Date:   Thu, 8 Nov 2018 08:17:21 +0000
Message-ID: <99a59a71-6bdc-7822-7a4e-91ea040235d0@amd.com>
References: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM5PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:206:1::35) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1283;20:661o+cBAwB85Eb+gOmcTib6j0HHbyIyTNgYf5Lb20z4HRZtPbexY4RzVBgjmPbk35roL1L70EGLpkB089iImWZ68ET/aCA1qnqyyYDx48DG4XoKKoCZObKrvkpGl3Fx2Bl89NTfsX5tB9YmvDnW7x+qxk1Bgw8WZiCMn9H83gjVkH+zaegR1liIPVElG3u4N1JOXwPCJtscOoT445lyyqm7Jr1HM5gRq7xnfZTIZFCE4gzwDlUOodeJimUcbyaXX
x-ms-office365-filtering-correlation-id: 10b63d56-3f63-415a-d1f0-08d645529b35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1283;
x-ms-traffictypediagnostic: BN6PR12MB1283:
x-microsoft-antispam-prvs: <BN6PR12MB1283322ADF761229903EABC583C50@BN6PR12MB1283.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1283;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1283;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(68736007)(14444005)(81166006)(31686004)(6512007)(102836004)(36756003)(31696002)(478600001)(86362001)(6246003)(53936002)(81156014)(8676002)(11346002)(256004)(105586002)(106356001)(386003)(72206003)(6506007)(99286004)(71190400001)(71200400001)(14454004)(65956001)(229853002)(65806001)(52116002)(5660300001)(6436002)(66574009)(65826007)(64126003)(6486002)(58126008)(6116002)(76176011)(97736004)(316002)(186003)(7736002)(305945005)(446003)(8936002)(2900100001)(54906003)(476003)(2616005)(2906002)(486006)(25786009)(110136005)(4326008)(46003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1283;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ACw7cPXddHxhgT6BGc6J82ZWusy8Z+EtUhmkK7ZHgnrGv8STAKJav/xyO/7yqWOvGwfpa4moRdpET30miCub4FJ4O1RIpZs5u9eKagoKVRgfoeboC4Fh+zyn8NQGXWZlL/eQlT5JlFDl3A82L+1H4vSA0905gRNtuK5bLRaWZwIdRGFEoE5J3vX3gVjEa+djfQlQsasCyQKm1JabazGRYzHUxE0Mo4BXg+hmv6PBtAylRUDxJwVKDanTKghxN81JqGFmwDdXIaddcxzkCVG/bWpj8lXDlWK82XchmshyZpf/HwaSvlGlXjZyXcvIg4NtXXOf9JkEr653ywgvUGFo/aSvJ4tKQ0QqEhElkx1HuEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1319DA0D116AB74F9931918B79CCC6C5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b63d56-3f63-415a-d1f0-08d645529b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 08:17:21.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTEuMTggdW0gMDM6MTUgc2NocmllYiBZdWVIYWliaW5nOg0KPiBGaXhlcyBnY2MgJy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6DQo+DQo+IGRyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2V4ZWNidWZfdXRpbC5jOiBJbiBmdW5jdGlvbiAndHRtX2V1X2ZlbmNlX2J1ZmZlcl9v
YmplY3RzJzoNCj4gZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fZXhlY2J1Zl91dGlsLmM6MTkwOjI0
OiB3YXJuaW5nOg0KPiAgIHZhcmlhYmxlICdkcml2ZXInIHNldCBidXQgbm90IHVzZWQgWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+DQo+IEl0IG5vdCB1c2VkIGFueSBtb3JlIGFmdGVyDQo+
IGNvbW1pdCBmMmMyNGI4M2FlOTAgKCJkcm0vdHRtOiBmbGlwIHRoZSBzd2l0Y2gsIGFuZCBjb252
ZXJ0IHRvIGRtYV9mZW5jZSIpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhh
aWJpbmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gYW5kIGdvaW5nIHRvIA0KcHVzaCBpdCBpbnRvIG91ciBpbnRl
cm5hbCBicmFuY2ggZm9yIHVwc3RyZWFtaW5nLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX2V4ZWNidWZfdXRpbC5jIHwgMiAtLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fZXhl
Y2J1Zl91dGlsLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9leGVjYnVmX3V0aWwuYw0KPiBp
bmRleCBlNDkzZWRiLi5lZmEwMDVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9leGVjYnVmX3V0aWwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9leGVj
YnVmX3V0aWwuYw0KPiBAQCAtMTg3LDE0ICsxODcsMTIgQEAgdm9pZCB0dG1fZXVfZmVuY2VfYnVm
ZmVyX29iamVjdHMoc3RydWN0IHd3X2FjcXVpcmVfY3R4ICp0aWNrZXQsDQo+ICAgCXN0cnVjdCB0
dG1fYnVmZmVyX29iamVjdCAqYm87DQo+ICAgCXN0cnVjdCB0dG1fYm9fZ2xvYmFsICpnbG9iOw0K
PiAgIAlzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldjsNCj4gLQlzdHJ1Y3QgdHRtX2JvX2RyaXZl
ciAqZHJpdmVyOw0KPiAgIA0KPiAgIAlpZiAobGlzdF9lbXB0eShsaXN0KSkNCj4gICAJCXJldHVy
bjsNCj4gICANCj4gICAJYm8gPSBsaXN0X2ZpcnN0X2VudHJ5KGxpc3QsIHN0cnVjdCB0dG1fdmFs
aWRhdGVfYnVmZmVyLCBoZWFkKS0+Ym87DQo+ICAgCWJkZXYgPSBiby0+YmRldjsNCj4gLQlkcml2
ZXIgPSBiZGV2LT5kcml2ZXI7DQo+ICAgCWdsb2IgPSBiby0+YmRldi0+Z2xvYjsNCj4gICANCj4g
ICAJc3Bpbl9sb2NrKCZnbG9iLT5scnVfbG9jayk7DQo+DQo+DQo+DQoNCg==
