Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E20CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F059206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="LIzhtpxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F059206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbeIYA1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:27:14 -0400
Received: from mail-eopbgr720100.outbound.protection.outlook.com ([40.107.72.100]:11680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeIYA1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV8KPf9jtimxqFyqEcG/IrAu/4m3rPAkRvWFrC0AxGU=;
 b=LIzhtpxjrYPbEyHdqqo8mFZEXHCU299Z7LCL4BaVuAsJCELlhrocAz1EdQSaicZkUs/S8bKRuCMl5RAMudLVLmgxNmIX4sQYLDMO5D3YuRnNRRYaq/Cg5ojeHUDisz9bU0sXBoIhI/9wyme/NTkLrfZ1JznRL64e54/K92tlD/k=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3740.namprd06.prod.outlook.com (10.167.236.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 24 Sep 2018 18:23:44 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 18:23:44 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Thread-Topic: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Thread-Index: AQHUUTNODNf0y51mcE6CV+a3wfMT0KT6/0+AgAACmACAABDPAIAAAv4AgAIngACAAnQfAIAAE7mA
Date:   Mon, 24 Sep 2018 18:23:44 +0000
Message-ID: <1537813423.7736.46.camel@impinj.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
         <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
         <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
         <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
         <20180921185106.GJ20825@sirena.org.uk>
         <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
         <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3740;6:2VcwN+paud4uL9vHOfBuEY2Ap0FY3BSVCInL1IEGX39Z+WcQPDjFW1VqDosjXfI77ywTuBMf44g0hbglMWvc7n9jPqderWcD9zfpGfTv47GFz5GhPtciXTULKYvl/DW8ADhVtVN79aiw6bwc5VbzueDMb0nZzRTryoIXHCLeYHKWsQ6XhWHENYAkS4l6yq1xTiXnmFAPGEGm4A7spFzQ6D3qP1A/1w22BXK+oVQTpCOxA7kEfl+6yiu1pnmth9qJTrSlK2x4d9Ue0ya64l1FcelcHjQOckVEElr1gk/PlfU5QpjgqkncD894piTZOzzGX+dP90fXbTor079Zvl8kdbAtLIa8SHClUjiJXnokGa4H+9IorB7quIDpzY6wyoJx3N3D7Mw715ccNkAgub7ErnZ/rEnq6ENbw8L/d3m1B4TEpM3IcPOiR0lq+zw3mTQOrvs3UJAkcmRdAlvaj9Su4g==;5:erdaXjz70tVZFZcz4jzqsOsCHcqPp+iR2H3mAJCwfiDbUtVCW2AYyR2Jr7yPI9nAZ5/meS+YAzhTMY4WGG0oJ+bqOdEThq1ZOUROAtbL2r4vNOnJXzQdnOiPVAP5pSk923B9mHK9W0HK4KiQIhJkTovTMWBd6Nzgpmy6mWNsfsI=;7:64KRMGHsoFgZz6xECBI6pPa6Qmq7qthDRHLGJQ6qW4iHMMgzH0XnZ7XyRM4ZSPLpJEXLU7aXflbPz6PWr0hVVZM4QoJRAWSXdzCMiUZWWG7DgP9ZxlG7ROemtZFPFKbD4bC0TP91ZRuwkRr6iL6eJCy1o7uF42n1D/5mIwK4cjd2ZrcFUVqowdPnqYzLQv1kVf+OIJdVq/UbSGS8dJswmGsc3PX7+Yol1RTp8kc1ZyKjVQ0cKVzwDXLOWKOhGfXT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8072f5cc-427e-425d-805f-08d6224adcad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3740;
x-ms-traffictypediagnostic: MWHPR0601MB3740:
x-microsoft-antispam-prvs: <MWHPR0601MB37407A381AB23A3913953D6FD3170@MWHPR0601MB3740.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149066)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR0601MB3740;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3740;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39850400004)(199004)(189003)(102836004)(71190400001)(26005)(6246003)(186003)(4326008)(68736007)(6486002)(229853002)(2906002)(76176011)(256004)(105586002)(3846002)(54906003)(99286004)(53936002)(71200400001)(6116002)(6506007)(6512007)(6436002)(86362001)(316002)(93886005)(106356001)(110136005)(81156014)(11346002)(2616005)(81166006)(7736002)(305945005)(66066001)(7416002)(97736004)(476003)(446003)(5660300001)(2900100001)(486006)(2501003)(8676002)(5250100002)(36756003)(14454004)(8936002)(478600001)(103116003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3740;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sRuVe8UhMZxT7g6KyhQpOMMYXgKk5RrtbM/FqciIkTPDRAImQ6oCA3fhpZDuSxGMerzE1oHbGge8eo+AxlmwWASD4xKV/Ok/BeoqOdKu+bTs72S7bgC+YSb70mnyObXcmwEYZ382z6TqpmvMJPXM29NgS2PIVCT54LRfEU1vjmaoU+vB7KiwHhD3TNBhcHh8ABTGEGBQKUnbe6+Uh8jxdQjK2dweqzsYZJlQgo8Phb0xvY+Q2HCknPypYMnRuNyW2Ub+SAPmzki4xdiV5yZKvOKCW0VTxVrzr/55VdYpmptpHUebMWeNvEA6KRVmM9hanI5WIde3TPX2eHNmcaLHHhtyJkKuKUPMFqMXQVKiF/k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AF0BC883287046BC1C614F192BC19F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8072f5cc-427e-425d-805f-08d6224adcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 18:23:44.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTI0IGF0IDEwOjEzIC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiBJSVVDIHByZXZpb3VzIHN1Z2dlc3Rpb25zIGFib3V0IGp1c3QgbmFtaW5nIGl0IGJhc2VkIG9u
IHRoZSBmaXJzdCBTb0MNCj4gd2FzIGR1ZSB0byB0aGUgZGlmZmljdWx0eSBvZiBjb21pbmcgdXAg
d2l0aCBhIGdvb2QgZ2VuZXJpYyBuYW1lIHRvDQo+IGdpdmUgc29tZXRoaW5nLiAgRm9yIGluc3Rh
bmNlIHlvdSBkZWZpbml0ZWx5IHdvdWxkbid0IHdhbnQgdG8gbmFtZSBpdA0KPiAicWNvbS1xc3Bp
LXNkbTh4eCIgYmVjYXVzZSB5b3UgaGF2ZSBubyBpZGVhIHdoYXQgZnV0dXJlIFNvQ3Mgd2lsbCBi
ZQ0KPiBudW1iZXJlZC4NCg0KQW5kIHRoZSBoeXBvdGhldGljYWwgc2RtODk5IG1pZ2h0IHVzZSBh
IG5vbi1jb21wYXRpYmxlIGRldmljZSB0aGF0IHVzZXMNCmEgZGlmZmVyZW50IGRyaXZlciwgYW5k
IHRoYXQgcmVhbGx5IG1ha2VzICJxY29tLXFzcGktc2RtOHh4IiBsb29rIGR1bWIuDQoNCj4gDQo+
IEluIHRoZSBjYXNlIGhlcmUgY2FsbGluZyBpdCAicWNvbSxxc3BpLXYxIiBpcyBiZXR0ZXIgdGhh
biB0aGF0IGFuZCBpZg0KPiBSb2IgZ2l2ZXMgdGhlIHRodW1icyB1cCB0aGVuIEkgd29uJ3Qgb2Jq
ZWN0IHRvIGl0LiAgSW4gZ2VuZXJhbCB0aG91Z2gNCj4gbG9va2luZyBhdCBvdGhlciBkZXZpY2Ug
dHJlZSBiaW5kaW5ncyB0aGlzIGRvZXNuJ3Qgc2VlbSBsaWtlIGEgdGhpbmcNCj4gY29tbW9ubHkg
ZG9uZS4gIFBlcmhhcHMgaWYgd2UgZGVjaWRlIGl0J3MgdXNlZnVsIGhlcmUgd2Ugc2hvdWxkIHN0
YXJ0DQo+IHN1Z2dlc3RpbmcgaXQgZXZlcnl3aGVyZS4uLg0KDQpJdCB3b3VsZCBoZWxwIGlmIHRo
ZSBwcm9ncmFtbWluZyBtb2RlbCBvciBJUCBjb3JlIG5hbWUgb3Igd2hhdGV2ZXIgdGhpcw0KaXMg
dXNpbmcgd2FzIG1lbnRpb25lZCBpbiB0aGUgcHVibGljIHJlZmVyZW5jZSBtYW51YWwgZm9yIHRo
ZSBTb0MuIA0KVGhlbiBpcyBhIGxvdCBtb3JlIGNsZWFyIHRoYXQgYSBudW1iZXIgb2YgZGlmZmVy
ZW50IFNvQ3MgYWxsIGhhdmUgdGhlDQpzYW1lIHF1YWQgc3BpIGNvbnRyb2xsZXIgaW5zaWRlIHRo
ZW0uDQoNClVzdWFsbHkgaXQncyBub3QgbGlrZSB0aGF0LiAgVGhlIFJNcyBqdXN0IHNheSwgIml0
J3MgZ290IGEgU1BJIG1hc3Rlcg0Kd2l0aCB0aGVzZSByZWdpc3RlcnMuIiAgV2hhdCBTb0NzIHVz
ZSB0aGUgc2FtZSBJUCBtb2R1bGUsIHdoaWNoDQpkaWZmZXJlbnQ/ICBXaGVuIGRpZCB0aGV5IG1h
a2UgYSBuZXcgdmVyc2lvbj8gIFRoZSBzaWxpY29uIHZlbmRvcnMNCmRvbid0IHRlbGwgeW91IHRo
aXMuICBTbyBhbnkgbmFtZSB3ZSBtYWtlIHVwIGZvciB0aGUgSVAgbW9kdWxlIGxpa2VseQ0KZG9l
c24ndCBtYXRjaCByZWFsaXR5Lg0K
