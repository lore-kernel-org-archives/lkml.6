Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBFC2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=opengear.com header.i=@opengear.com header.b="szHnkwOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBFC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opengear.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbeJ3IGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:06:41 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:53300
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729783AbeJ3IGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2khzyRIuMCg46TFYGZxYMQBZeM+W8xeyUWHPp6Hg4E=;
 b=szHnkwORj1NSFLlxbCCpRUGlLC/NJubpeUYO0AxCyxcmqL9eZyoViGby6VUft6Ju331mcmK/GQchYzTIgFW1U+9O5l8kE3BPi0FDu0FRSFFb8kr8tYYOmK0AVSMNvTgA5TVAUTgrgAZTl+RdGnmH3kFpoB4WJFIyQLdQvw4QwlU=
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com (52.132.130.30) by
 DM5PR1501MB1991.namprd15.prod.outlook.com (52.132.129.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Mon, 29 Oct 2018 23:15:42 +0000
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::ad1b:d831:4d48:1949]) by DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::ad1b:d831:4d48:1949%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 23:15:42 +0000
From:   "Grandbois, Brett" <brett.grandbois@opengear.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Thread-Topic: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Thread-Index: AQHUZOs9cFLja65s+EWijjbFGrgyH6UzTLuAgAOkAAA=
Date:   Mon, 29 Oct 2018 23:15:42 +0000
Message-ID: <a6edf985-0d15-5b2b-a6ba-9cfcd7a67836@opengear.com>
References: <20181016005726.26813-1-brett.grandbois@opengear.com>
 <20181027173945.241e87b2@bbrezillon>
In-Reply-To: <20181027173945.241e87b2@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To DM5PR1501MB2056.namprd15.prod.outlook.com
 (2603:10b6:4:a2::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brett.grandbois@opengear.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [123.209.196.153]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1501MB1991;6:hReje68qNcVXKC0QRTG95nsEHsn8+WCIaW540CM7yOtDBlowunf3haLTZcG23Pc63zHZKXJ5mCh/a4WJW68KH+sEvxacCc1CJeJcS3mE2P2XJRB36/q7vSWOqK9d6upGUBi7GdxHJkhv+vZ4VQQJ7aEqz8SMZmxC5jBCZ3azo9gJrMPcqSrUMTBHlp6W4WEAJfC7pzmgLPq73T6irtFe8WSm/ZslqvZVZMJBiU94mR2Eo7GR5Nl5G6seL6HMcGRxEm2lhEWK0qyEjRb16us18OTfqkHDOYU8152YrLELUnENnRqiEHGOi3ADGeyN4ascpeOofMoPiKXUnZ6tOQF8sDYiurMxMApm3can1caMo833dD0mDmGWA6bsBtydMAw7X+4MzR3hWnK4rxhJLDbMExpVT+8UjNaQiF9uW0g2tcJ21plSl5zVqPAGhIegAkAb8WvhczJaW6pXpFe10PqYEA==;5:gHK6qNQwmj1479bJp0SaqVePBBl/jwnEVtdUi8PKxYqU5KrTsxJmkpsJ2uaTqiXwMwJHbmuxP+ObSBeQqerAcU5eZz7NwbgGC9m/rUih236uY+DrMeMqoxmdYNhfPKamDBGKrcAqo24drPACPn/FiCTzmtbZ8V2uUl7ZAdxDrzY=;7:pDcub8LzCXOM64StlzJTzyJnHitws6XkU6EbgWfrQ//QmVxUZPFYDTtWKzgj6M33mhTFDG1Bj4RRMG8Rd1P7EMmRufXfIpx4QQm201Ze76Gi3HYhhmDZBtB/ANip0nTTvxFEW26aihtGy4ZC4alXrw==
x-ms-office365-filtering-correlation-id: 96e8df21-8ff0-4b1d-d3f6-08d63df47243
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1501MB1991;
x-ms-traffictypediagnostic: DM5PR1501MB1991:
x-microsoft-antispam-prvs: <DM5PR1501MB1991D7B13EB69210E66F552982F30@DM5PR1501MB1991.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR1501MB1991;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1501MB1991;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(396003)(366004)(376002)(136003)(199004)(189003)(71200400001)(71190400001)(6512007)(486006)(186003)(6246003)(6306002)(53936002)(7736002)(305945005)(2906002)(229853002)(4326008)(31696002)(36756003)(97736004)(6436002)(45080400002)(2616005)(106356001)(86362001)(6486002)(476003)(105586002)(25786009)(256004)(31686004)(6916009)(6116002)(68736007)(39060400002)(3846002)(2900100001)(316002)(54906003)(6506007)(52116002)(76176011)(11346002)(26005)(478600001)(81156014)(446003)(99286004)(66066001)(14454004)(8676002)(53546011)(386003)(5250100002)(8936002)(81166006)(102836004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1501MB1991;H:DM5PR1501MB2056.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: opengear.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XlkI0hplVglVw1RwkblAMwxwJWCS2L5UpGMvNavyLS/3FdIEAOPcoqmmNqSu1c1wc/aHIteINmuJaiTML3/6zcH4JTzfLkYkt6UKg/Hdt8JXQnwEZarjCgyPt5UU0lhsDPA1x05onlHPw7O3UXpOY455jfVbGrI4W9CpEPuFEsRpoVzhe1msVavzvs2bJ5OvEfNkQmkCKwNmErgPrcMdxRxw6s2n23r1qUE1sx9orKwu0qQgS0gQWB2WBjDcySgHXGlS0OE9uT5Cx5tllaldo3AaJ9liEqE6IPfvXlcUvkEwaFkEBuFamWNrHCUlVwJJmxzcq9rxqzSoNd11w/dVCky/oaP3MBLMWlWig5+Ss3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B3E0CEBDE0434B83B7EF663A3C5FC6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e8df21-8ff0-4b1d-d3f6-08d63df47243
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 23:15:42.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyOC8xMC8xOCAxOjM5IGFtLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+IEhpIEJyZXR0
LA0KPg0KPiBPbiBUdWUsIDE2IE9jdCAyMDE4IDAwOjU3OjQxICswMDAwDQo+ICJHcmFuZGJvaXMs
IEJyZXR0IjxicmV0dC5ncmFuZGJvaXNAb3BlbmdlYXIuY29tPiAgd3JvdGU6DQo+DQo+PiBBZGQg
c3VwcG9ydCB0byBleHBvc2UgdGhlIFNQSSBib290IGZsYXNoIG9uIEFNRCBGYW1pbHkgMTZoIENQ
VXMgYXMgYQ0KPj4gc3RhbmRhcmQgbXRkIGRldmljZSB0byBnaXZlIHVzZXJzcGFjZSBCSU9TIHVw
ZGF0ZXJzIGdyZWF0ZXIgZmVhdHVyZQ0KPj4gc3VwcG9ydC4gIFRoZSBCSU9TIGFuZCBLZXJuZWwg
RGV2ZWxvcGVyJ3MgR3VpZGUgcmVmZXJzIHRvIHRoaXMgYXMgdGhlDQo+PiAnU1BJIFJPTScgY29u
dHJvbGxlciBhbmQgc28gdGhlIGRyaXZlciBmb2xsb3dzIHRoYXQgbmFtaW5nIGNvbnZlbnRpb24N
Cj4+IGZvciBjb25zaXN0ZW5jeS4NCj4+DQo+IFdlJ3JlIGN1cnJlbnRseSB0cnlpbmcgdG8gY29u
dmVydCBzcGktbm9yIGNvbnRyb2xsZXIgZHJpdmVycyB0byB0aGUNCj4gc3BpLW1lbSBpbnRlcmZh
Y2UgWzFdLiBDYW4geW91IGxvb2sgYXQgdGhpcyBuZXcgaW50ZXJmYWNlIGFuZCB0ZWxsIG1lIGlm
DQo+IHlvdSdkIGJlIGFibGUgdG8gaW1wbGVtZW50IGl0PyBJZiB0aGF0J3Mgbm90IHBvc3NpYmxl
LCB0aGVuIEknZCBwcmVmZXINCj4gdG8gaGF2ZSB0aGlzIGRyaXZlciBpbXBsZW1lbnQgdGhlIG10
ZF9pbmZvIGludGVyZmFjZSBkaXJlY3RseS4NCg0KU28gZnJvbSBnb2luZyBvdmVyIHRoZSBzcGkt
bWVtIGludGVyZmFjZSBpdCBsb29rcyBsaWtlIHRoZSBpbnRlbnQgaXMgZm9yIHRoZXNlIHNvcnRz
IG9mIGRldmljZXMgdG8gYmUgYSBzdGFuZGFyZCBzcGlfY29udHJvbGxlciB3aXRoIG9ubHkgbWVt
X29wcyBkZWZpbmVkIGFuZCB0aGUgdHJhbnNmZXIvX29uZS9fb25lX21lc3NhZ2UgbGVmdCBhcyBO
VUxMPyAgSXMgdGhhdCBjb3JyZWN0PyAgVGhhdCdzIGEgYml0IG9mIGEgcGl2b3QgZnJvbSBob3cg
aXQncyBjdXJyZW50bHkgZG9uZSAoaXQncyBjb25jZXB0dWFsbHkgc2ltaWxhciB0byB0aGUgaW50
ZWwtc3BpLXBjaSBkcml2ZXIgc28gSSB3YXMgZm9sbG93aW5nIHRoYXQpIGJ1dCBJIHNob3VsZCBi
ZSBhYmxlIHRvIHJld29yayBpdCB0byB0aGUgbmV3IGludGVyZmFjZS4gIFRoaXMgdGhlbiBsaXZl
cyB1bmRlciBkcml2ZXJzL3NwaSBhbmQgdGh1cyBzaG91bGQgYmUgc3VibWl0dGVkIHRvIGxpbnV4
LXNwaT8NCiAgIA0KDQo+IFRoYW5rcywNCj4NCj4gQm9yaXMNCj4NCj4gWzFdaHR0cHM6Ly9uYTAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZlbGl4
aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRmxhdGVzdCUyRnNvdXJjZSUyRmluY2x1ZGUlMkZsaW51
eCUyRnNwaSUyRnNwaS1tZW0uaCUyM0wxODUmYW1wO2RhdGE9MDIlN0MwMSU3Q2JyZXR0LmdyYW5k
Ym9pcyU0MG9wZW5nZWFyLmNvbSU3Q2Y1MjQ0ZDkyODc1MzRlYTg0YjEyMDhkNjNjMjI2ZThmJTdD
YTYyNTFjMjZkMjFmNDE2NGEyMjUxZjRlYWViZjVmOWElN0MwJTdDMCU3QzYzNjc2MjUxNTkxNTA5
NzQwNSZhbXA7c2RhdGE9OWJyR0lYY0VjTFF1NWc2V3hhWFQ2NjElMkJqZjhVTE1RUXBWZFh6STM2
TlRVJTNEJmFtcDtyZXNlcnZlZD0wDQo=
