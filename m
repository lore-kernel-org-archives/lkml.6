Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E1CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881CB206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Oaa9ewt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881CB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeGUMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:47:54 -0400
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:52496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeGUMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG+1htTBN5zqLFac2PF3lpLREiFfE3uodhHNEgajJog=;
 b=Oaa9ewt45epFTvdjtfZK/+4d9t7FfHKES86Xohow88kkkfrSjggZz0CoARoIMjqOkgv4x6Q5ugNCfqULMRzLSSIpnThfINEMininD2wW0QliEUAf414owpttPb28oY1tqdIzboWHVUvMlfCvrWK1Zkp6IpEvmk0pKa+6POIst0E=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2445.eurprd05.prod.outlook.com (10.168.136.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Sat, 21 Jul 2018 11:55:21 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.018; Sat, 21 Jul 2018
 11:55:21 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "digetx@gmail.com" <digetx@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Topic: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Index: AQHUIABUe+tvL+Nfh0CxF11WAEwB4qSYBuQAgAAEKYCAAWcSgIAAFtAAgAAKdIA=
Date:   Sat, 21 Jul 2018 11:55:21 +0000
Message-ID: <1532174119.19673.24.camel@toradex.com>
References: <20180720080424.31505-1-marcel@ziswiler.com>
         <1532089865.19673.13.camel@toradex.com>
         <20180721095615.GG16228@sirena.org.uk> <8512069.csTsg4TRIJ@dimapc>
In-Reply-To: <8512069.csTsg4TRIJ@dimapc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2445;6:pFwfCVXJLbZHAvlZeQXmkIyBuHLDyLpJCJbMW+WI9xsFzOmrqsPCBM/ObqCgk1q87lkWnQe07T/YfweTEfJSONTi8XJkNNpTy7tjUE/WFsAHRWaPEYD2hsjl204YZnikWxhnLHxRvwsOpwu+6IW/2swgS8xwbl8YnOHkPQZzukClB7hXG02JI/LaqJ/UgfttzrkdGb0dfVKbEMcyNCwA6nm41yTXa+vtmnUyyLMOD5eJ/Bt3Kj2vufPShqLP/XidL9NZd7tVnoXOckIaIDFdd9SoxTjtkHdQuPCk400+vGF0g/vpsn27QaNVOuE1vNW4J9HGvtsGzwd0t+oo7EndipJ6qZzDYZ9LMX6tbUuqiH07de0xtj1gMswqSXe3XWEVtGJm/MT1asiqfTkIvwUhvPYcGJ0HqVCEHlGkODPfjgDlzKSX1n1M7iRf0wGodJXTTHV/Dnd4TaYZjLsiU3Z3Ig==;5:E6bVjkpIsNpOllY+LhfUynDLFmZdpelfdqO1mK1/qs+WqFH2Wzs6XKfeKcXTbb/ibDmqEfN99L8UlBJZeBMRIdXzSozV2cJfgTZy/r4A6KoHrdAZOAgEu+Kb0rEpEQCUclp5pR8FFExyQB2JEbDRPf4Gc8hLJ7UJQgfNyFmGgeU=;7:hIbZ+tManwaDjBkXvakTqhgC4Q6M6V6mYXt3cOyJVwE3sE58HdSilJA7SBdVvqOwHU+Zm7wKggzWTGAinoIeHtxS9RwK1/RxGUKjptm6Hag4I/gFErzEDUbWpBML2N3ut5X8duOYodsYfoNY4a/BPcWqG9R8iXw+0bnPRuIpbQAjtsODgoVHC7yTX4jw0YRilPP5OHtd0PaHHLnvtdF5qhavE+ggq9S++ktyHUN4+b1FVX+QEuQM4iP+PG1foyZN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc703465-6f57-4cbf-a793-08d5ef00d608
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2445;
x-ms-traffictypediagnostic: VI1PR0501MB2445:
x-microsoft-antispam-prvs: <VI1PR0501MB24459310BA1C525D5555C6F2FB500@VI1PR0501MB2445.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2445;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2445;
x-forefront-prvs: 074040B844
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39840400004)(346002)(376002)(136003)(199004)(189003)(81156014)(66066001)(6116002)(3846002)(7416002)(2900100001)(5250100002)(2501003)(26005)(106356001)(54906003)(102836004)(186003)(36756003)(486006)(6506007)(256004)(446003)(44832011)(316002)(110136005)(5660300001)(11346002)(76176011)(105586002)(476003)(2616005)(93886005)(6436002)(14454004)(86362001)(305945005)(6512007)(99286004)(229853002)(7736002)(97736004)(478600001)(6486002)(39060400002)(6246003)(68736007)(53936002)(4326008)(81166006)(8676002)(2906002)(103116003)(25786009)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2445;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EMBP08qcEW8KTdMlHw4Y33EguhZ27v6sHbHP+34/HWSOg9z0M4r/0K/bfe/vQrwfJxWFB6MJ4tkqOa+tPSSqDWXVnwj4xJplYc4p0K8DjJet/Xz/upyaW5Ux1oXSe9Q6v+LixM5FrZfSmi86fglRtsHumZPnG+4n3ktpUA7i0n3DhKM3xzyLI6Cu+0rVTwvxWIz512iCSgQrt1CRxzK2Rzx5x6uNsWa6e5sVxb5xEfhkcqese2H+iq7RdXZaD1D3j60F6xi3IBxqiBRAfBn4njUCqkfYpDiTwbDYhUD6Pw0CLASzfw349suYmRnFWbsSNnZwvq32qxGwoejg4WuWVklyFXQaDjbz6Nj3ypZzpWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <060046D172331743B5FFEB9B19DD20B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc703465-6f57-4cbf-a793-08d5ef00d608
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2018 11:55:21.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTA3LTIxIGF0IDE0OjE3ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IE9uIFNhdHVyZGF5LCAyMSBKdWx5IDIwMTggMTI6NTY6MTUgTVNLIE1hcmsgQnJvd24gd3Jv
dGU6DQo+ID4gT24gRnJpLCBKdWwgMjAsIDIwMTggYXQgMTI6MzE6MDdQTSArMDAwMCwgTWFyY2Vs
IFppc3dpbGVyIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAyMDE4LTA3LTIwIGF0IDEzOjE2ICswMTAw
LCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+ID4gPiA+ICAJYWM5Ny0+c3luY19ncGlvID0gb2ZfZ2V0
X25hbWVkX2dwaW8ocGRldi0NCj4gPiA+ID4gPiA+ZGV2Lm9mX25vZGUsDQo+ID4gPiA+ID4gIAkN
Cj4gPiA+ID4gPiAgCQkJCQkgICAgIm52aWRpYSxjb2RlYy0NCj4gPiA+ID4gPiBzeW5jLQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IGdwaW8iLCAwKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgCWlm
ICghZ3Bpb19pc192YWxpZChhYzk3LT5zeW5jX2dwaW8pKSB7DQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAibm8gY29kZWMtc3luYyBHUElPDQo+ID4gPiA+ID4g
c3VwcGxpZWRcbiIpOw0KPiA+ID4gPiA+ICsJCXJldCA9IGFjOTctPnN5bmNfZ3BpbzsNCj4gPiA+
ID4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBjb2RlYy1zeW5jIEdQSU8NCj4gPiA+ID4g
PiBzdXBwbGllZDoNCj4gPiA+ID4gPiAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiAgCQlnb3RvIGVycl9jbGtfcHV0Ow0KPiA+ID4gPiA+ICAJDQo+ID4gPiA+ID4gIAl9DQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGlzIGlzbid0IHJlcG9ydGluZyBhbiBlcnJvciBjb2RlIGFzc29jaWF0
ZWQgd2l0aCB0aGUgYXR0ZW1wdA0KPiA+ID4gPiB0bw0KPiA+ID4gPiBmaW5kIGENCj4gPiA+ID4g
Y29kZWMtc3luYyBHUElPLCBpdCdzIHRoZSByZXN1bHQgb2Ygc29tZSBvdGhlciBvcGVyYXRpb24u
DQo+ID4gPiANCj4gPiA+IFdoYXQgZXhhY3RseSBpcyB0aGVuIHRoZSBvZl9nZXRfbmFtZWRfZ3Bp
bygpIGFib3ZlIHBsZWFzZSBkb2luZw0KPiA+ID4gaWYNCj4gPiA+IG5vdCBnZXR0aW5nIHRoZSBj
b2RlYyBzeW5jIEdQSU8/IEkgYW0gbm90IGZvbGxvd2luZyB5b3UsIHNvcnJ5Lg0KPiA+IA0KPiA+
IEl0J3Mgbm90IGluIGFueSB3YXkgaW52b2x2ZWQgaW4gc2V0dGluZyB0aGUgdmFsdWUgb2YgcmV0
LCB3aGF0ZXZlcg0KPiA+IHZhbHVlDQo+ID4gdGhhdCBoYXMgaXQncyBub3RoaW5nIHRvIGRvIHdp
dGggdGhhdCBvcGVyYXRpb24uDQo+IA0KPiBUaGUgY29tbWVudCB0byBncGlvX2lzX3ZhbGlkKCkg
c2F5cyB0aGF0IGl0ICJSZXR1cm5zIEdQSU8gbnVtYmVyIHRvDQo+IHVzZSB3aXRoIA0KPiBMaW51
eCBnZW5lcmljIEdQSU8gQVBJLCBvciBvbmUgb2YgdGhlIGVycm5vIHZhbHVlIG9uIHRoZSBlcnJv
cg0KPiBjb25kaXRpb24iLiANCj4gQ29tbWVudCBkb2Vzbid0IGV4cGxpY2l0bHkgc3RhdGVzIHRo
YXQgdGhlIHJldHVybmVkIEdQSU8gbnVtYmVyIGlzDQo+IGFsd2F5cyANCj4gdmFsaWQsIGJ1dCBp
dCBpcyBraW5kYSBpbXBsaWVkLg0KDQpEbyB5b3UgbWVhbiBJIHNob3VsZCBiZSBhc3NpZ25pbmcg
dGhlIHJldHVybiB2YWx1ZSBvZiBncGlvX2lzX3ZhbGlkKCkNCnRvIHJldCBhbmQgdXNlIHRoYXQg
aW5zdGVhZD8=
