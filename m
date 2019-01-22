Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01298C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB38621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="igZNqDhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfAVJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:13:35 -0500
Received: from mail-eopbgr50104.outbound.protection.outlook.com ([40.107.5.104]:60032
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbfAVJNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmb3A02+ZjjJtdmi90Rjz1PshoJlRtXFMWFtsJh9Y9o=;
 b=igZNqDhUcAND/4rQifVQOBHsDJXEmfnNpWrgHpZiMRCCF+FVSCEsnklYmnoiZma7HoxvxtU+hSbRbfmCjAxGzJ90RusT1QOjxQAgpftErlBndvJKH4lPLjQQZUWZuAKYZzBvx5is7NvOzh0AJVm9EOeqCgXUIkv1OHt2cqHoOus=
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com (10.169.131.25) by
 VI1PR0201MB2159.eurprd02.prod.outlook.com (10.169.131.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 09:13:26 +0000
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::bc28:97f7:c6b4:d9ad]) by VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::bc28:97f7:c6b4:d9ad%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:13:26 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Alok Chauhan <alokc@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
CC:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Thread-Topic: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Thread-Index: AQHUshySNF7nn4UUwUqnfVFdV5jusKW7ATCA
Date:   Tue, 22 Jan 2019 09:13:26 +0000
Message-ID: <d44cdb5e-2408-493c-3f86-db97c224dc3f@axentia.se>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR09CA0050.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::18) To VI1PR0201MB2112.eurprd02.prod.outlook.com
 (2603:10a6:800:24::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2159;6:H+NuYPaCF/33U79D64CGj9k3ChLCbOy5FlFNy0mH0kyYOOctdopEPL7wiy8fb18HOWB03ajGLAfi06CVa5OnhHWsH4mjEuSxcVgADp1csOzznLlg7q7rGWDpF5GbJXjr/ooQBv4hqoIWX4AyiGmLn5PxlTkXEEBhVSK/sCSuzj8w/2ozJDQQ3Bw3wxKboIRJMyok2ScCaN5OEN5EoUQ7OGV/x94GzO1osoRBgi0EWrYXZUSvymoLNDWstuuzfieVKeNT2ht2ASsEJXw1gfFvJ5uqENO0WRlpGZ1xSSTlAKsuI1gaFtTZxhvOVm9qxABpXsKCOWp9NOxn2EhfafQJxnDH/JoeWyaNU69qdW8g1Qt+wG72iFMjKvmVH7u9wlAT0IrzkBHe1/BaYfzFhar0tJyhTE4fLWrrxM1vj528z1Z+tUGq68xE/ppfTWSyofHXkU7V4wJnhP48rLcyxHo3XQ==;5:YFpkzEudWQs6n1LyFUW5GSgPaoKAqyot2SwpvIb1uRtmDfk110phJXREw0ZnWZ6CwptIOXAUwN8b7JqnHZOmPVeOjj17mRUSbjP+mW/zf0e1k1u2No14jA+VUNnu3vYvsWMuur/VJ6zCOIYWEEf4hHcFP/q6w3fNFieo170QUFH0TeEelEqDHEtgNuL0pe5WxM9cToyOm/Pk4/JZdEjJhw==;7:Pv2zS9FdlSbcdLJw6Zf44x6X9jtslrHREMrX6XnyvdOMwv5FDzcVCIIYRLPiOVf5pld1Pzw6ArubZwiF6NimNL3d0JyI6Z/XyAD29/5RgA+HgZG9msjoiC0Ri2jvDB/w3tUNuhuNrV/qRpiHNnlKpA==
x-ms-office365-filtering-correlation-id: eb0a71f8-eb02-4422-f30f-08d68049ddff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2159;
x-ms-traffictypediagnostic: VI1PR0201MB2159:
x-microsoft-antispam-prvs: <VI1PR0201MB21593EA7802AADD6E98093A9BC980@VI1PR0201MB2159.eurprd02.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39830400003)(396003)(136003)(199004)(189003)(81156014)(446003)(64126003)(36756003)(76176011)(81166006)(66066001)(65806001)(65956001)(71200400001)(53936002)(25786009)(68736007)(508600001)(11346002)(71190400001)(256004)(6512007)(4744005)(186003)(52116002)(2616005)(8936002)(99286004)(26005)(2906002)(74482002)(53546011)(476003)(386003)(6506007)(65826007)(486006)(86362001)(106356001)(6116002)(105586002)(14454004)(6486002)(97736004)(316002)(2501003)(102836004)(305945005)(7736002)(58126008)(8676002)(6246003)(31696002)(54906003)(31686004)(7416002)(229853002)(2201001)(3846002)(110136005)(4326008)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2159;H:VI1PR0201MB2112.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VoLJXvmpdKzaEU/VfyF2fnfnBNAAHdqMkl+dZuTA5sl77K77HOvmom3ym1DYudvJfhtatrg2C8H7uD9v16QGuw64Qau/trG2dgb34fwfrqdshmQx9agxe6BmUzroi4zr2lfKSBMfJ55/wsLQYU/lMAr5wCXgqRcSRLdtrGU0wISL63pOI6bAX6wXiUVsUzSZ9xvJ7xsJJf4Gdb2xq4p2CuIi1pV8bMb6X9GM1ZaMvBXFKxjak/q+Csk/FMzXuNkij+41e+AKrxIVl/AvRxJO8ehs+jbun69X4D6dR6j0PaoxzJH4zZECkJvgFFsaqapFkHzhDvby3oYJJpthtuY2frfmyQHbn16lnFU8hz3OdSGQXv37OVDygKpmnPfG0+esnCuqVVewaTqj8COlGiT6xbsu+BOiUNRuy0GjD/+O1qg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C38BDEC1F2845543840C4E8294DB0415@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0a71f8-eb02-4422-f30f-08d68049ddff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:13:25.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0yMiAwNzozMywgQWxvayBDaGF1aGFuIHdyb3RlOg0KPiBHZXQgdGhlIGludGVy
Y29ubmVjdCBwYXRocyBmb3IgSTJDIGJhc2VkIFNlcmlhbCBFbmdpbmUgZGV2aWNlDQo+IGFuZCB2
b3RlIGFjY29yZGluZ2x5IGJhc2VkIG9uIG1heGltdW0gc3VwcG9ydGVkIEkyQyBmcmVxdWVuY3ku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbG9rIENoYXVoYW4gPGFsb2tjQGNvZGVhdXJvcmEub3Jn
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcWNvbS1nZW5pLmMgfCAxMyArKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcWNvbS1nZW5pLmMgYi9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLXFjb20tZ2VuaS5jDQo+IGluZGV4IGRiMDc1YmMuLmU4ZmU2M2EgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcWNvbS1nZW5pLmMNCj4gKysrIGIvZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1xY29tLWdlbmkuYw0KPiBAQCAtMTQsNiArMTQsNyBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9xY29tLWdl
bmktc2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L2ludGVyY29ubmVjdC5oPg0KDQpQbGVhc2Uga2VlcCB0aGUgaW5jbHVkZXMgc29ydGVkLiBQ
cm9iYWJseSBhcHBsaWVzIGZvciB0aGUgb3RoZXIgcGF0Y2hlcw0KaW4gdGhlIHNlcmllcyBhcyB3
ZWxsPw0KDQpDaGVlcnMsDQpQZXRlcg0K
