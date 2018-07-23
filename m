Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AFFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RhTy/ikB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeGWNmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:42:07 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:46720
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387965AbeGWNmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7GMuAYPZHdN8MQQXBC9PQ+DIvC58cOOQ5fheGsK2J4=;
 b=RhTy/ikB3ztLSLN+nITWsmYKnMf5MsgBPe728L12VhbkI13FKErGyAJB7iMZDwdr/wBzJZ664qlbgs6WXJ9WxRsoYY1qZwOFo5L0A+ieg6ctlGvlc5F2HNwHjl7Xz1BohokX46Y4zgFdqct6OKmzetBraQBg2j1u5iNmeKW/ECA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4531.eurprd04.prod.outlook.com (52.135.148.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 12:41:01 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 12:41:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Thread-Topic: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Thread-Index: AQHUICfkbI++9IJFu0qLZ8faDq/bh6SYPdYAgASGqwA=
Date:   Mon, 23 Jul 2018 12:41:00 +0000
Message-ID: <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
         <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
In-Reply-To: <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4531;6:76bCYo91JhoBOCOxr8YuzhuZMQRT3XTCWIv5CTzpGjphuZooASAFOSxmFijY6eq6aFsmjvWiT/w4b0fyDatpmTfsa2yHM5aznP1ZWVTAWakj6GzVoAUhl6zPAx8w/Wihv+JI7lwbFviO1gxdEh5x3F3LryalPIK/rw3gaXwxeJqNBC0Wa/xn/jJ0GU+UjSTXs1SwCSY7CfGg4/7Bx6PSCfJ11rXuCd/AnlBxioFrZOex5pNTEpeGCBlbR6lp/lTRSNP8eBUvpM8gnKwUXZxBdJXtNSOAtnTvreaCAvFIHe7Sl465o92Sw7TXle7J6Rs7mREu3rIbXAGIC7IiU0NA46NgjEe4g9N0UPlvFI9DC+bVdWxUooRDZNtvWsYeZZRitHXrROIAu9wbRReTbtjfMFl4RJeFhx3UIiOHvE9teW9o2hO0stzjg4giltfNj7QpMaRwwgXd3NAyjs0+EiIBLA==;5:NrOAhLBUJpbFe0f3KcsFdAa1SP83ZfeuYQpHAhBbY+ySZTK7bF9WZI5RJf0ytDUt3xe4iiDisPVsREaPf7ZaYnFtgJWRMKKwl+CToLDY+WJuHwkVPF/+/aQmAfys9aLaWjaa9AXH0eS0z7WXtzu6WVjcN095LBR9TgZMlizMafE=;7:bfE+06hGrBSb08xfFVcIiS+kQ3q9Rgxx8gw0x4cdZPszzCDia5z03P/EWy7IFNh4pp48UnzVVzYmTM9N85+fTdfYsdG6T0iuJpKjjQPLn7n1eNHY+ROIVWw8ysn5yhpR5+0d0OKSwcUfvG2VCIIm/Ux4q1zK/ppXTzCSIsQHYWAqDA3Ip7aQ7J5lY2kfqLMED6N8KrPVH3ixpE/yBLSTS4zxq8lJ/qVisUuqoEbpUDN5asmBBTrpk3rcYD+ROAMR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 62564070-f62c-4be1-eac5-08d5f0998bd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4531;
x-ms-traffictypediagnostic: AM0PR04MB4531:
x-microsoft-antispam-prvs: <AM0PR04MB4531AA31315FB1393821C0DCEE560@AM0PR04MB4531.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4531;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4531;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(66066001)(53936002)(6246003)(8936002)(229853002)(118296001)(476003)(81166006)(81156014)(8676002)(2616005)(11346002)(486006)(446003)(44832011)(6116002)(7736002)(3846002)(97736004)(2906002)(4326008)(256004)(39060400002)(99286004)(305945005)(86362001)(575784001)(5250100002)(50226002)(478600001)(316002)(5660300001)(6436002)(25786009)(102836004)(6486002)(186003)(5640700003)(53546011)(2900100001)(6506007)(26005)(68736007)(6916009)(105586002)(106356001)(76176011)(54906003)(1361003)(36756003)(2351001)(7416002)(14454004)(6512007)(2501003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4531;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mpUjztKtQX647+S+No8kvkJmVFQ9h9GXZdrvZ7pZ0VongZv3mPIbj3OsUEyrKn6ON7KYQDg0R5/ItUA1l/do5hfV9vmxCWE8Hgh4yznccFn+HKBUDa5xpZoU0X8JcWs1Wq6xg6HfR/lC9gEAcFNbAAoNz626NFc44cbZBxh+Deq7fIkQFknqmX1ZX5wrZMFGd0ZGgk9JM9KmsbekBeEkEqFSDYRQORBSrs8IsFRvZBNvxyC35fKHBmIobTeXoYxrmFZjJA9+k/ooRjNIHm7VqZ6zqblBYyNOm4KVrJ7ZGAbKm0q4ht1MSPDVboJesA6Ok+dsBGpUdx7t2P6/9v5NmXbk3/8pEE3KCrxupC45xP0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2631D153FB5824AABAFA154A1488F16@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62564070-f62c-4be1-eac5-08d5f0998bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 12:41:00.8988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTIwIGF0IDA4OjMzIC0wNzAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gT24gRnJpLCBKdWwgMjAsIDIwMTggYXQgNTo0OCBBTSBMZW9uYXJkIENyZXN0ZXogPGxlb25h
cmQuY3Jlc3RlekBueHAuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0
IDFjODZjOWRkODJmODU5YjQ3NDQ3NGE3ZmVlMGQ1MTk1ZGEyYzljMWQuDQo+ID4gDQo+ID4gVGhh
dCBjb21taXQgZm9sbG93ZWQgdGhlIHJlZmVyZW5jZSBtYW51YWwgYnV0IHVuZm9ydHVuYXRlbHkg
dGhlIGlteDdkDQo+ID4gbWFudWFsIGlzIGluY29ycmVjdC4NCj4gDQo+IEknZCBhbHNvIGFkZCBz
aW1pbGFyIGNvbW1lbnQgdG8gRFQgZmlsZSB0byBwcmV2ZW50IHBlb3BsZSBmcm9tIHRyeWluZw0K
PiB0byAiZml4IiB0aGlzIGluIHRoZSBmdXR1cmUuDQoNCkknbGwgdHJ5IHRvIHNlZSBpZiBJIGNh
biBmb2xsb3cgdXAgaW50ZXJuYWxseSB3aXRoIGRvY3MgdGVhbSB0byBnZXQNCnRoaXMgdXBkYXRl
ZCBpbiB0aGUgbmV4dCByZXZpc2lvbiBvZiB0aGUgcmVmZXJlbmNlIG1hbnVhbC4NCg0KPiBBbHNv
LCB0aGlzIGNoYW5nZSBpcyBnb2luZyB0byBicmVhayBRRU1VJ3MgbWFwcGluZyBmb3VuZCBoZXJl
Og0KDQpJIGhhZCBubyBpZGVhIHRoYXQgZXhpc3RlZCwgSSBndWVzcyBzb21lYm9keSBuZWVkcyB0
byBmaXggdGhhdCBhcyB3ZWxsLg0KDQpEbyB5b3UgaGF2ZSBhbiBpbXg3ZCBib2FyZCB1c2luZyBw
Y2kgb3IgZGlkIHlvdSBqdXN0IHRlc3QgaW4gZW11bGF0aW9uPw0KDQotLQ0KUmVnYXJkcywNCkxl
b25hcmQ=
