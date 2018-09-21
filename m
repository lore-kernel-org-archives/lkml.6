Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F5ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E014A21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="QJB7Wwdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014A21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbeIVAXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:23:47 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:30642
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391156AbeIVAXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIAgWMUgyAiSQLFolZxAd/WynW/EsZ9Fkrl0EJtNrSc=;
 b=QJB7WwdhIVputeqSui6LCEt1fis7RHdwWltojPQX/82kgebIITMfYN1e5bdPP+sJWfQDxrQjbdqu2YzO5lYv4kfVwLqoj0n8NsSSxz26O/EvBhrllJ7h4u/vCd37HAYmf3m77kPwQWqdYHEMs7E3XAEH0diOOC0OJ9Z8K4Qc8b4=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3740.namprd06.prod.outlook.com (10.167.236.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Fri, 21 Sep 2018 18:33:36 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48%4]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 18:33:36 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "swboyd@chromium.org" <swboyd@chromium.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Thread-Topic: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Thread-Index: AQHUUTNODNf0y51mcE6CV+a3wfMT0KT6/0+AgAACQ4CAAA8+AA==
Date:   Fri, 21 Sep 2018 18:33:36 +0000
Message-ID: <1537554816.7736.32.camel@impinj.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
         <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
         <20180921173903.GH20825@sirena.org.uk>
In-Reply-To: <20180921173903.GH20825@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3740;6:njCEcDVEB1H1CuWJhhxlPnxhRFa5Sn7zDRZkSFnPaozJyv5Vg2vD1J6FvVNhWS5xIe+gZQltPyaEiK38iSFvnHLlwCG8xUVfXcEMLwGC7gacjProXPyddJeGo9sPbBweiDmEtXVBFeQ5Ps6QpBF86ghOHmqeLUJEVV/k161MvTWj3DJTunYItFezmJ9fRc3/YhHkjmwb03t12tWqZq0zW/wOgRpdhULeFEfH5NB6r5BeRzn2mrhWkaFzuF9ZDt87UFzL2D11IkpszkFFd7ZMwumXpSzqnLC4XWvHPw0Z8odWs/Vpao617s3KxFZVFRSHa6415nslAj3BMDFDhZvdUptpat6OOdQWjsm7ar8xV0FrBQqD77aweJccWT5iu4iclhpi6613TmeMzka3CmWLlZtQcyHFUy9md4mtuiUeBSA0h2fAkiVieaokDCxPqgxvrd0utV43cgIsJbtKsf/cFg==;5:KkJs9TC8WAi7nDATSTtD791aZPOeLTxQlplS04yoU+Mz0MCUcVU6x+SH3SPOHVTqHb8DpEGSZTDbiDIRDD4UZZiowyY+rlfeUwzhCNjrH4TaHiNl9w4YQKQrRHI3tzebVlit0mom9apJUoCfAeVwDdBrFDG9Ax8khtE4DLmb3Ig=;7:5KAFlakQyFAlPwoOND6XXCN3favJSGKh2v+fxKecwBi41kFcZJzLbx6fbgmi91hI+AqjO82I3ZuPF+5XaaayP06TAuO1vqm07G1GAjDI7zouB+waYlxSqN2vFPUL1s4zVi0eTH/Bnen8ZPDPl+6MdBc0cW2oELibAY/XnN6q+9W87hsvLWrnB9w7KZ9XpHBgLmD9a6HjdNPxhG5GmLq6qYN6JKzpryuC+Xj7LWnwAcG9oWpI0IgBOucVeeN5NHcX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 124d4d6a-0077-486d-6d6f-08d61ff0be81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3740;
x-ms-traffictypediagnostic: MWHPR0601MB3740:
x-microsoft-antispam-prvs: <MWHPR0601MB37401937A42EC7749207F5B1D3120@MWHPR0601MB3740.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR0601MB3740;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3740;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(189003)(199004)(6512007)(105586002)(229853002)(6116002)(54906003)(110136005)(81166006)(97736004)(81156014)(3846002)(6436002)(316002)(86362001)(71190400001)(71200400001)(2906002)(68736007)(6486002)(36756003)(256004)(106356001)(5660300001)(2501003)(476003)(6506007)(446003)(11346002)(2616005)(26005)(6246003)(103116003)(5250100002)(486006)(66066001)(8676002)(7736002)(53936002)(186003)(102836004)(305945005)(99286004)(8936002)(76176011)(478600001)(4326008)(7416002)(14454004)(2900100001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3740;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lrSqg5QBvijD2n/kmHMVAlYcDGjrmQaUHgvGM31PmfiULUIqYbfAhJg4hYVt32NedtA4cRbx3J+Rh9RwaWBhDhDlsSOi8jtEH+KrkygR9nw1jZ8weiGK7+m8yfE2DmgIPa4BYsz/xuj4jZvIL8Wg1TrL3KRIcLhrvmGTzV4N/z1yJUWL175fpkfxUJreuQUBp/eH0CKp/h1cA5sqBP8j788NQSaRAwpkP/aity4IHgndm3+ceodO/QM9plqa5bc7IISwsoHSsSHxsDI4R65sQVq0I74pvK24z1Tc5cJ1E6J4c38dn0i+bsh3rPOOh2H1PdpybxoOufQoPi8gWEsA2/1VLKo4B9gVB0mgstTkaMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C29D7D6EAD95904482E44DC37667CDF1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d4d6a-0077-486d-6d6f-08d61ff0be81
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 18:33:36.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTIxIGF0IDEwOjM5IC0wNzAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIFNlcCAyMSwgMjAxOCBhdCAxMDozMDo1N0FNIC0wNzAwLCBTdGVwaGVuIEJveWQgd3Jv
dGU6DQo+ID4gUXVvdGluZyBSeWFuIENhc2UgKDIwMTgtMDktMjAgMTU6NDA6NTQpDQo+ID4gPiAr
UmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ICstIGNvbXBhdGlibGU6ICBTaG91bGQgY29udGFp
bjoNCj4gPiA+ICsgICAgICAgICAgICAgICAicWNvbSxzZG04NDUtcXNwaSINCj4gPiBEb2VzIHNv
bWVvbmUgaGF2ZSBhIG1vcmUgZ2VuZXJpYyBjb21wYXRpYmxlIHN0cmluZyB0aGF0IGNhbiBiZSBh
ZGRlZA0KPiA+IGhlcmUgdG8gaW5kaWNhdGUgdGhlIHR5cGUgb2YgcXVhZCBTUEkgY29udHJvbGxl
ciB0aGlzIGlzPyBJIHJlYWxseSBkb3VidA0KPiA+IHRoaXMgaXMgYSBvbmUtb2ZmIGhhcmR3YXJl
IGJsb2NrIGZvciB0aGUgc3BlY2lmaWMgU0RNODQ1IFNvQy4gDQo+IA0KPiBUaGUgaWRpb20gZm9y
IERUIGlzIHN1cHBvc2VkIHRvIGJlIHRvIHVzZSBvbmx5IGRldmljZSBzcGVjaWZpYyBuYW1lcw0K
PiB1bmZvcnR1bmF0ZWx5Lg0KDQpCYXNpY2FsbHkgdGhlICJmaXJzdCIgZGV2aWNlIHRoZSBkcml2
ZXIgY2FuIGNvbnRyb2wgaGFzIGl0J3Mgc3BlY2lmaWMNCm5hbWUgdXNlZCBhcyB0aGUgZ2VuZXJp
YyBzdHJpbmcuICBUaGlzIGlzIHVzZWQgaW4gcGxhY2Ugb2Ygc29tZQ0KaW50ZXJuYWwgY29kZW5h
bWUgZm9yIHRoZSBjb3JlLg0KDQpUaGVuIGEgbmV3ZXIgZGV2aWNlIHdpbGwgaGF2ZSAiZm9vLFhZ
WjIwMCIsICJmb28sWFlaMTAwIiBhcyBjb21wYXRpYmxlLA0Kd2hlcmUgdGhlIDEwMCB3YXMgdGhl
IGZpcnN0IGRldmljZSBhbmQgdGhlIDIwMCBpcyBuZXcgb25lLiAgTWF5YmUgdGhlDQpkcml2ZXIg
Y2FyZXMsIG9yIHdpbGwgY2FyZSwgYWJvdXQgd2hhdCBkZXZpY2UgdGhpcyBvciBtYXliZSBpdCBj
YW4NCmRyaXZlIHRoZSBkZXZpY2UgZmluZSB3aXRob3V0IG5lZWRpbmcgdG8ga25vdyBtb3JlIHRo
YW4gdGhlIGdlbmVyaWMuDQoNCg==
