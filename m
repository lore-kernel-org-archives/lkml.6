Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036BE218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TedMevzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbeLTVBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:01:25 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15232 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeLTVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:01:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1c031c0000>; Thu, 20 Dec 2018 13:01:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Dec 2018 13:01:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Dec 2018 13:01:22 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 20 Dec
 2018 21:01:22 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.56) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 20 Dec 2018 21:01:22 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7SPR01MB0016.namprd12.prod.outlook.com (20.176.178.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Thu, 20 Dec 2018 21:01:19 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::256c:731a:631d:8502]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::256c:731a:631d:8502%5]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 21:01:18 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
Thread-Topic: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
Thread-Index: AQHUl/SAyzUCz4c1L0eNF2Tnbxe+hqWHkbUAgACCYHA=
Date:   Thu, 20 Dec 2018 21:01:18 +0000
Message-ID: <BN7PR12MB2836A1467A21CAE50125727AC2BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
 <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
 <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
In-Reply-To: <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7SPR01MB0016;6:tcDYYPGA5C7Ik+mSd8rTZgV/I0Yu95xPcEzjbHfYbGF4+pqeAuDYu2cKQJHQII1eZk0F7kI63G6GS/uM1RBnNW65SlPizdu1Tqqiu2LmRFu9n9lRkUemSvgYKEzN4WTgBV1m9rWkquwSEUB2mK497jZ9qXg6SlzNexcjdwX5FVUZ6p869gkhycYKN58xByQk8AUJLhmeg7in6wPNyTeD1/fTXSW6xcReQlP4QW3wMIC0tlzSuGlc/vdjhPjwuEnpQA9Ir3aJndm2u4esNItwSbCv001OOb5mMOc8Im6997esIDlioVdFrHT6MFi7k/sHLT4ze7EaLvgnNcFXOKECp29Owkm/3bPLH75bQJvnaLqWnjQmaSV0/qpXuySym5RB/QsLbNN8TnXuIskYqSJ48qo0awH15ilhCGNWspPXa0waOjQ21UvaS16GBHHAtME9y5C8Raavilysp1mUc6yjUw==;5:qGHWqlnr975uCwHg0tsOSuOzqwHPXbrRcXxtFYufgZzu4r7Z0xOXh9Ab5t/AGtkHGtTLY4OLso4LIgTcGSlc1dCwYkp4/jvYlpgfPbiJ0eKHdlpFWqdmi5xqy+FSJVZxpuX8+W/4rif+mI+nQkHF/gidPkPJgzwwb4adYl45EVQ=;7:lYm2lB3of6RxBe93y2OMWj5G+iqXSDa9rm9eRFwsf+xQzTjK2L4trixxbFQTCYdkdYGQGaZMKDX7FZ9r3qEN/y0mmS817AZ8AjLJs9GJPnvhHlBSUF6DZWihXXFZzeZZ/bfmcT4nrvvdnruLTgFmHQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(102836004)(6506007)(74316002)(33656002)(5660300001)(7696005)(229853002)(76176011)(39060400002)(345774005)(53936002)(6246003)(25786009)(105586002)(106356001)(2906002)(4326008)(71200400001)(71190400001)(68736007)(186003)(26005)(478600001)(6116002)(55016002)(446003)(476003)(9686003)(14454004)(316002)(11346002)(97736004)(486006)(8676002)(256004)(14444005)(3846002)(2501003)(110136005)(6436002)(7736002)(305945005)(8936002)(66066001)(99286004)(81166006)(81156014)(54906003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7SPR01MB0016;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: a90ce912-5497-4c28-d03f-08d666be49db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7SPR01MB0016;
x-ms-traffictypediagnostic: BN7SPR01MB0016:
x-microsoft-antispam-prvs: <BN7SPR01MB00161F2C3242419B3C6287ABC2BF0@BN7SPR01MB0016.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7SPR01MB0016;BCL:0;PCL:0;RULEID:;SRVR:BN7SPR01MB0016;
x-forefront-prvs: 0892FA9A88
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b+0EQ2IWIppwApIti2X8cJd+Wg6LZpsUvbl/LrevmFScaLD5Jv0QdgHWGBZ7wmNG2H7D6kHb4/gko9M1/SRa2/0HYsQ6dO23BYDjkCET9KKXAkAwfsyEXp+/UCQYHmHCgg/MT/xksnHCfLyp/HIIbhsRXuCdJAbCaEEpl6EjSeslYXPytLPDD+YTcW9Ht5sxc+B/qrgMGgGlloJGdtjWmd5JieIq+C6zL3t0hWBWauv92/yQHisYwq6+r7/dA2jyNxMsxaAYGi9tPZsx1vnnleXKaHgo4JHUfMYTc2jPkdR0fEp4dfFM7wtxp+/+vwYT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a90ce912-5497-4c28-d03f-08d666be49db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 21:01:18.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7SPR01MB0016
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545339676; bh=jSm8FigE9Ksb9Fqi9G3gPq8HPEMoPfbOCpPelWZzT7o=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
         x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=TedMevzo6MrGuCJPBwYFd4g1iqjZoqo+OQcSsAtLJh5PC+wj464661H8B2B8kG3j9
         SUo/2RzrRt4UKP31B9naIbqVU2Oasnbw5k2ivdkFHAhdDJwP5SRA9BbnTT83r6jb3m
         tjOZ1GPDGcbBQqeQqfeFA7nYI6fhp1bxumZGngr+lHGrdyk/acyBvG39KfBOEP9nkp
         SwBCz9MS1okdIR6+fvFO1qqwgwVK8OxHjQnO/HqVb7HbQ2sEvlQz343MGFXNTzX2/4
         QlbjNwTPMmlD5rOCprpKvmkm0YuxlgLSaZqdLAClhfXBqQAz4ixmeO6OqOgC8CNcgW
         AETXXGUxc6hgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBUaGlzIGRvZXNu
J3Qgc2VlbSB0byByZWxhdGUgdG8gdGhlIGhvc3QgY29udHJvbGxlciBpbXBsZW1lbnRhdGlvbi4g
IA0KPiAiVGhlIGRldmljZSIgbWVhbnMgdGhlIGVNTUMuDQoNClllcywgc2V0dGluZyBibG9jayBz
aXplIG9mIDUxMkIgYmVmb3JlIGVuYWJsaW5nIGNvbW1hbmQgcXVldWUgaXMgYSBkZXZpY2Ugc3Bl
Y2lmaWMgDQpyZXF1aXJlbWVudCBub3QgaG9zdCBzcGVjaWZpYy4gU28gdGhvdWdodCB0byB1cGRh
dGUgaW4gY3FoY2kgZHJpdmVyIHRvIGZvbGxvdyB0aGlzIA0KZGV2aWNlIHNwZWNpZmljIHNlcXVl
bmNlIHJlcXVpcmVtZW50LiBUaGlzIGFsc28gc2VydmVzIHRlZ3JhIHNkaGNpIGhvc3Qgc3RyaWN0
bHkNCmZvbGxvd2luZyB0aGlzIGRldmljZSBzcGVjaWZpYyByZXF1aXJlbWVudC4NCg0KPiBXZSBk
b24ndCB3YW50IHRvIGRpc2FibGUgYW5kIHJlLWVuYWJsZSBpbiB0aGUgcmVxdWVzdCBmdW5jdGlv
biwNCj4gc28gdGhhdCBjaGFuZ2UgaXMgbm90IGdvb2QgZm9yIGNvbnRyb2xsZXJzIHRoYXQgZG9u
J3QgaGF2ZSB5b3VyIHByb2JsZW0uDQo+IEFub3RoZXIgdGhpbmcgdG8gY29uc2lkZXIgaXMgdGhh
dCB0aGUgYmxvY2sgc2l6ZSByZWdpc3RlciBtYXkgbm90IG5lZWQgdG8gYmUgY2hhbmdlZA0KPiAt
IGZvciBleGFtcGxlIHdoZW4gY3FoY2kgaXMgaGFsdGVkIHRvIGFsbG93IGEgbWFudWFsIGRpc2Nh
cmQsIHRoZSBibG9jayBzaXplIHJlZ2lzdGVyIGlzDQo+IG5vdCB1cGRhdGVkLCBzbyBJIHdvdWxk
IGV4cGVjdCBpdHMgdmFsdWUgdG8gYmUgdW5jaGFuZ2VkLg0KDQpPbmNlIGJsb2NrIHNpemUgaXMg
c2V0IHByaW9yIHRvIGVuYWJsaW5nIENRRSwgaXQgc3RheXMgc2FtZSB0aWxsIGNvbW1hbmQgcXVl
dWUgaXMgDQpkaXNhYmxlZCBhbmQgSSBkb27igJl0IHRoaW5rIGl0IG5lZWRzIHJlY29uZmlndXJh
dGlvbi4NCg0KPiBUaGVyZSBhcmUgd2F5cyB5b3UgY2FuIHNvbHZlIHRoaXMgaW4geW91ciBkcml2
ZXIuICANCj4gWW91IGNvdWxkIGxvb2sgYXQgdXNpbmcgU0RIQ0kgSS9PIGFjY2Vzc29ycywgYW5k
L29yIGltcGxlbWVudCB5b3VyIG93biAtPmVuYWJsZSgpIA0KPiBpbnN0ZWFkIG9mIGNhbGxpbmcg
c2RoY2lfY3FlX2VuYWJsZSgpIGRpcmVjdGx5LiAgV291bGQgdGhhdCBiZSBmZWFzaWJsZT8NCg0K
U3VyZSwgd2lsbCBwcm92aWRlIHVwZGF0ZWQgcGF0Y2ggdGhhdCB0YWtlcyBjYXJlIG9mIHRoaXMg
aW5zaWRlIHRlZ3JhIHNkaGNpIGhvc3Qgb25jZSB5b3UgDQpjb25maXJtIHRoYXQgd2UgZG9u4oCZ
dCBwbGFuIHRvIGZpeCB0aGlzIGRldmljZSBzcGVjaWZpYyBzZXF1ZW5jZSByZXF1aXJlbWVudCBp
biBjcWhjaSBkcml2ZXIuDQoNCi1Tb3dqYW55YQ0KIA0K
