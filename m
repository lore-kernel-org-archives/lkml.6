Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C105C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BF72146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CMiNcpft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfBHR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:29:21 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:29143 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfBHR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:29:20 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dbc6a0000>; Sat, 09 Feb 2019 01:29:14 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:29:14 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 09:29:14 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:29:13 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.58) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 17:29:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3462.namprd12.prod.outlook.com (20.178.196.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 17:29:09 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:29:09 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUv829t7ouq5xahU+WuWRXTJjcy6XWHr8AgAAA/ACAAAGHIIAABIiAgAABPkA=
Date:   Fri, 8 Feb 2019 17:29:09 +0000
Message-ID: <BYAPR12MB33984E76B8BE19ED0CB0BE17C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
In-Reply-To: <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3462;6:1xUB4RGWj3uPEiFIm3O5AYDygqLeiXvaixSEsxzoRCJzgThgwJmGqp8cnFB9dAFKPc6DBNAe7JIckTyOb3sinj5wVAG8XcAh/0eirquu6KdO8rWMHjhuoB6phl5vZ4lefCbFR97ZLcr504BOn6l+kLdq03SLSbuk4JScPEm+uM0t2AKY7c9Iad6jfQ6bp1W/un3Edkbwvv+t8e4SdUWXJ9FukV9DTfAJ3dnQJpD1u6TZ6ucHT5658S6TM7ZODBuNVK+P75rM72eYloqLwMf1Pz8AQjv429zOJuLmRyXiRV4njNTm2LpVInHQOijRCpnpkd8SdUuFsvaGl3WQFZ05hkdbY0BpHPV0jsI/RlaIIJSkCGB8J7qaWTNU2JbqbZtBii9KjL+Auks1FnFrACzCTZYOHlPHbYcCX4p6dyyflZEgRmwmffH7JOOFftptzgNvtdkyCqJWxORl6AmECE6eHA==;5:y4ksH2vEyARavpGN+r65Az9N80z+fm0zn/r2vx4/E6uqgvuXG9gflTGGfew1wPN/Uu9cm/Ojr54imydUM7zUL6bZ5UB4GcMdLQsxxauq1sfGFQSU9q5XvCmXHH3dUrgPHDUatTn3ylULNsGQUR2+NcUPaik6cNfRUoW/Bnfu8ZCIQqogejPTf7wUd3LV44Q2uYj3Z2sF9g3vP5wFse5JGw==;7:04qZB4fmT/heYz8VcuT65GOPQXMPN6lUDB5qBz4jWp18dJ3o6Fe2P06lkRHNa1nJwxRk0vC4GI025UPJvzjlpGkv3ByWZVxN7Hj8HhYZ6lrbYAC9yoIik0FR72UV0IIyjPxrkr33iUU5zoYUBLPWQw==
x-ms-office365-filtering-correlation-id: 2039b97f-d00e-40c2-5883-08d68deaef5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3462;
x-ms-traffictypediagnostic: BYAPR12MB3462:
x-microsoft-antispam-prvs: <BYAPR12MB346294F8A8F7A7FE85F189C6C2690@BYAPR12MB3462.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(476003)(256004)(68736007)(6506007)(14444005)(305945005)(8676002)(71200400001)(7736002)(9686003)(3846002)(486006)(446003)(6116002)(81166006)(71190400001)(11346002)(81156014)(97736004)(2501003)(93886005)(6636002)(33656002)(186003)(74316002)(229853002)(99286004)(7696005)(66066001)(316002)(106356001)(105586002)(86362001)(110136005)(54906003)(76176011)(4326008)(8936002)(53936002)(25786009)(102836004)(6246003)(26005)(14454004)(2906002)(55016002)(478600001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3462;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lkvMnqSZzJWz3b41lMi7LEFGXoDXOCLgunerq8RLFR6s04/lhG+OnCQTn849A7LORkeejgGSSoHfZ2eQX8JUx5BsCWr3hchhWKJv3mNyLNwNAY0kyFw8ec597CgKlUTrXXkodlYggRlOwJvDHtDxaQAEU1uiLNoQAl3wiK9fMCf1TZDr2+Qyjr/nGS432rd6p88bYZB0iJLfL5GWTX3+j0MkNqr2nJhig8VRam82oGo84Gg0gI6YFRRb5pE8pYWYV9ZWNE0MWs73/c8IdBbr0bwwKzf81qKOOshmtVjs+kG7mutGNBWD+9LkQojdx0Lk4wh44mlboVq+6M6xaLvmB5mAcPI+V23J6StS03cZ7a3aoUMuqc/3iAiU3foqQVKOXyEwo+lwBNoLeaqDX1gAmCsAtqwxg580Eo/znCJgqeU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2039b97f-d00e-40c2-5883-08d68deaef5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:29:09.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549646955; bh=7qoXk9wVaZazPKlHqS8SLFwn1TXTEE5af1secHnxfHs=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=CMiNcpftfpIPHAl1r/rfH/jvzRmP1GPK784ZBUUEvJGJ3oT7X/xJXQvdaQPIvxq/w
         sMgMXylogSaTCk0wCKjaVp8rm98lwg0yMAk/7CdeYAn7eubIKYnbf6MqcMOYCXACqD
         pUBcv365AdgRO2NiV22xUd88EA1p8VKokLMT+mmDg7RHnBLLdSFqV4AB+t5lcdA2XC
         zq3hI+TPdoayAOLZylWxGjCg1yqqrnivXdO7SreLcBD8ipR96JufjeP6GBYqhNHBkP
         FQxwVI1bUZQ34sSArIUiRGEpcV6iwhYdGxI+3KbrweSCSDaRLCJ9xDyAZSZ3sOrRBG
         TqJJRJGOpGznQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gDQo+ID4+IEknbSBzdGlsbCBhbHNvIHN1Z2dlc3RpbmcgdG8gc3F1YXNoICJmaXggbWF4
aW11bSB0cmFuc2ZlciBzaXplIiBpbnRvIHRoaXMgcGF0Y2ggYmVjYXVzZSBpdCBpcyByZWFsbHkg
cGFydCBvZiBETUEtc3VwcG9ydCBlbmFibGluZy4NCj4gPiANCj4gPiBNYXggdHJhbnNmZXIgbGVu
Z3RoIGxpbWl0cyBhcHBseSB0byBQSU8gYWxzbyBidXQgZm9yIERNQSBpdHMgbW9yZSBuZWVkZWQg
dG8gcHJldmVudCBjcmFzaC4NCj4gPiBTbyBoYWQgdGhpcyBhcyBwYXRjaCBiZWZvcmUgRE1BIGFz
IGl0cyBhcHBsaWNhYmxlIGZvciBib3RoIERNQSAmIFBJTy4NCj4NCj4gT2gsIHNvIHRoZSBwYWNr
ZXRfaGVhZGVyIHNpemUgYWxzbyBzaGFsbCBiZSBleGNsdWRlZCBmb3IgdGhlIFBJTyBhcyB3ZWxs
LCByZWFsbHk/IEl0IGxvb2tlZCB0byBtZSB0aGF0IFBJTyBkb2Vzbid0IGhhdmUgdGhhdCByZXN0
cmljdGlvbiBhbmQgd2Ugb25seSBuZWVkIHRvIGV4Y2x1ZGUgdGhlIGhlYWRlciBzaXplIGZvciBE
TUEuLg0KPg0KPiA+IFdlIGV4Y2hhbmdlZCBvbiB0aGlzIHllc3RlcmRheSwgc28gdGhvdWdodCB0
aGUgcmVhc29uIHlvdSB3YW50IHRvIHNxdWFzaCBzZXBhcmF0ZSBwYXRjaCBhbmQgaW5jbHVkZSBp
biB0aGlzIGlzIGR1ZSB0byBtYXggbXNnIGxlbiBsaW1pdCBhbmQgd2hlbiBtb3ZlZCBpbnRvIGh3
IGZlYXR1cmUuDQo+DQo+IElmIFBJTyBsaW1pdHMgYXJlIGluY29ycmVjdCwgdGhlbiBpdCdzIGFi
c29sdXRlbHkgZmluZSB0byBkbyBpdCBpbiB0aGUgc2VwYXJhdGUgcGF0Y2guIEkgcHJvYmFibHkg
anVzdCBtaXN1bmRlcnN0b29kIHlvdXIgcG9pbnQuDQo+DQo+ID4gU29ycnkgc2hvdWxkIGhhdmUg
dmVyaWZpZWQgYmVmb3JlIHNlbmRpbmcuIFBsZWFzZSBjb25maXJtIGlmIEkgbGVhdmUgbWF4IHRy
YW5zZmVyIGFzIHNlcGFyYXRlIHBhdGNoIG9yIGFkZCB0byB0aGlzIERNQSBzdXBwb3J0LiBXaWxs
IHVwZGF0ZSBhbG9uZyB3aXRoIGRtYSBidWYgc2l6ZSBmaXguDQo+ID4gDQo+ID4gQnV0IG1heCB0
cmFuc2ZlciBsaW1pdCBhcHBsaWVkIHRvIFBJTyBhbHNvIGFuZCB0aGF04oCZcyB3aHkgYWRkZWQg
aXQgYmVmb3JlIERNQSBwYXRjaCB0byBzaG93IGl0cyBkZXBlbmRlbmN5DQo+ID4gDQo+DQo+IEFu
ZCB0aGVuIHlvdSBuZWVkIHRvIGV4cGxpY2l0bHkgdGVsbCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
dGhhdCBQSU8gbGltaXRzIGFyZSBpbmNvcnJlY3QuDQpDb21taXQgbWVzc2FnZSBzYXlzIFRlZ3Jh
IEkyQyBtYXggbGltaXQgcGVyIHBhY2tldHMgdHJhbnNmZXIgbWVhbmluZyB0aGF04oCZcyBpbnRl
cmZhY2UgdHJhbnNmZXIgbGltaXQgc28gYXBwbGllcyB0byBib3RoIFBJTyAmIERNQS4NCldpbGwg
YWRkIGV4cGxpY2l0bHkgaW5kaWNhdGluZyBhcHBsaWNhYmxlIGZvciBib3RoIFBJTyAmIERNQSB0
byBiZSBtb3JlIGNsZWFyDQoNCj4NCj4gSXQgYWxzbyBwcm9iYWJseSB3b3J0aCB0byBhZGQgYSBz
dGFibGUtdGFnIHRvIHRoZSBjb21taXQgbWVzc2FnZSB0byByZXF1ZXN0IGJhY2twb3J0aW5nIG9m
IHRoZSBsaW1pdHMtZml4aW5nIHBhdGNoIHRvIHRoZSBzdGFibGUga2VybmVsczoNCj4NCj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQpTb3JyeSBJIGFtIG5ldyB0byB1cHN0cmVhbSBz
dWJtaXNzaW9ucy4gQnkgYWRkaW5nIHN0YWJsZS10YWcgdG8gY29tbWl0IG1lc3NhZ2UsIGRvIHlv
dSBtZWFuIGV4cGxpY2l0bHkgbWVudGlvbmluZyB0aGlzIHBhdGNoIGFwcGxpY2FibGUgdG8gb2xk
IGtlcm5lbCBhbmQgYWRkaW5nIGluIHBhdGNoIENDIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc/DQoN
Cg==
