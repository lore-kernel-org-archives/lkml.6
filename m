Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EB324F77
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xLgBJILB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EB324F77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeGCC5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:57:18 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:30353
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753798AbeGCC5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yugg8G+uxn+zqPO6o6ZZ6APV8xHCfoyPzMqYB571Fak=;
 b=xLgBJILBoMLnyLOtO5JKxgCmw3bUZmHMjhEa6CfiNS1Q/OALfYxb9/4T+EjgxNCKk3o4HKYiznD+CUNc6yvoEWX0xvZLUlfO5oa3ay2OCoujcXqVo+XlylXrzvoJk77b0q+V/SI4j7YkDLsxwgS5/IsCcZ2uls0FJLUuqkMaE/o=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (10.170.211.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 02:57:13 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%5]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 02:57:13 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Index: AQHUB6ubqqf+VcikvUmzLvpSTD8gdKRyrn4AgAkh14CAAC5rgIABau2A
Date:   Tue, 3 Jul 2018 02:57:13 +0000
Message-ID: <1530615395.15665.26.camel@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
         <1530025442.9910.44.camel@pengutronix.de>
         <1530527489.15665.22.camel@nxp.com> <20180702131737.GJ22377@vkoul-mobl>
In-Reply-To: <20180702131737.GJ22377@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3222;7:YEU+5MhPSURdMzwdLTpe0bKF8WAyRma39KFI6inRuEcbfeftljNG7Egd3KnOXwsM+cn4trs6a88dvqMqkzy8uHQh5vU19v0QGPL9ip6oGzpWC51B4puJOHp1VNl1xgiA+DF6GC5nioQK+aM/qGT3IFy8LJT0aV90iwF6Wvg7hj7S5mp6RHWVhHJ2x+TO5pKfnRs4qIQILi0q31yUi58sz8w8Z4aVA1qgV5gxUxM+qFzOCNfNrn5t+ld/wVKm1zZT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a04f0798-22fc-47b8-9ba3-08d5e090ad5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
x-ms-traffictypediagnostic: DB6PR04MB3222:
x-microsoft-antispam-prvs: <DB6PR04MB32228F1D8F57BA94DF32309E89420@DB6PR04MB3222.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(7416002)(11346002)(446003)(316002)(2501003)(486006)(66066001)(68736007)(186003)(53546011)(36756003)(476003)(2616005)(6486002)(103116003)(54906003)(6506007)(256004)(14444005)(97736004)(102836004)(25786009)(86362001)(5660300001)(26005)(99286004)(6916009)(5250100002)(4326008)(53936002)(6116002)(93886005)(105586002)(50226002)(76176011)(2351001)(106356001)(6512007)(6246003)(2900100001)(229853002)(478600001)(7736002)(6436002)(14454004)(5640700003)(1730700003)(81156014)(81166006)(8676002)(3846002)(8936002)(2906002)(305945005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FxHqWcQQXOHcpdTVjR6ZY5KRO2Q10ulPTdDVXCl4Z/FjAB8lU5ywTQztp3JyMihHvgnzPFowNWTMqRryCCogj0PnCMJArcscZrTZYMjfWiyTduHQtCObmFKi+XZduH8ElN6U7T6ttblQr6olzAfqkokl0044RkscvvyiNSYQOe5g9IHqeiTrURpEEeou5BgEk3cd25EjdS+hvZuPE9TdZ2E4a7B9TQQz0i4RrelTdfAjSDda4TNww9YIqHb6UaSk6JRB4qJijxTT1UtI/Mjq3BKcj/9IVTESNDVWkCmZGsrTgcmQK6woNaRlKQ9JXHDYIz+LukIyy1VQ5R6hcsHWUi6490GI7LDK+/h/vHbd218=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E027C099FB2924C8DBAB8375DA4838E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04f0798-22fc-47b8-9ba3-08d5e090ad5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 02:57:13.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24g5LiALCAyMDE4LTA3LTAyIGF0IDE4OjQ3ICswNTMwLCBWaW5vZCB3cm90ZToNCj4gT24gMDIt
MDctMTgsIDAyOjMyLCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+IA0KPiA+IEhpIFZpbm9kLA0KPiA+
IAlEbyB5b3UgaGF2ZSBhbnkgY29tbWVudCBmb3IgdGhpcyBwYXRjaHNldD8gTHVjYXMgYW5kIFNh
c2NoYQ0KPiA+IGFja2VkIGl0IGFuZCB0dHkgcGF0Y2ggYWxyZWFkeSBtZXJnZWQgaW4uDQo+IEkg
d2FzIGFjdHVhbGx5IHdhaXRpbmcgZm9yIEFDSy9hY3Rpb24gb24gcGF0Y2ggMSA6KQ0KPiANCj4g
SSBoYXZlIHJldmlld2VkIHRoZSBzZXJpZXMsIHNvbWUgbml0cGlja3Mgbm90aGluZyBtYWpvciwg
c28gSSBoYXZlDQo+IGFwcGxpZWQgdGhpcyBnb29kIGNsZWFudXAgYW5kIGNvbnZlcnNpb24gOikg
YWxvbmcgd2l0aCBmaXhlcyBmb3INCj4gdHlwb3MNCj4gaW4gY29kZSwgR0ZQXyBmaXggYW5kIHJl
bW92ZWQgdW51c2VkIHZhcmlhYmxlLg0KPiANCj4gTXkgYnVpbGRjaGFpbiBub3RpY2VkIHdhcm5z
ICh3aXRoIFc9MSkgb24gdGhpcyBmaWxlLCBlc3Agbm93IHRoYXQNCj4gc3RydWN0cyBhcmUgbW92
ZWQgYXJvdW5kLiBQbHMgZml4IHRoZSBzdHJ1Y3QgZGVzY3JpcHRpb25zLg0KT2theSwgSSdsbCBz
ZW5kIGFub3RoZXIgcGF0Y2ggdG8gZml4IHN1Y2ggYnVpbGQgd2FybmluZyBpc3N1ZSBsYXRlci4N
CkJUVywgcGF0Y2ggMSBoYXMgYWxyZWFkeSBiZWVuIGluIGxpbnV4LW5leHQgdHJlZSA6KS4NCj4g
DQo+IFRoYW5rcw==
