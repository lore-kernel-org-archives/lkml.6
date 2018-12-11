Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A62C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E572054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="xvJqSfA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E572054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLKNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:47:14 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:2751
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbeLKNrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saK9xUtSjcPbJLVsWALiihu7CpdJ3Rv4Ugq26BNfgcU=;
 b=xvJqSfA2CCx5RQZn/x0GhYrIVRvpafM2qSlSnGnTPYn+1E2wt8qVwy6WPRnCKGAU0/GSfI8rZeo1bhAm9EjhJ/zX23PvMZ/6BkbwSTAVxdYbwifD8tQ9kybTZj4M/l74WCYf78sxpM7P1JWI2ph3SzUQIeKoiN8V5QctAWt5gFU=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5099.eurprd04.prod.outlook.com (20.176.235.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 13:46:30 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 13:46:30 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Topic: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Index: AQHUcfmhpCcckxtfbESTtrGd1QZCZaVMaSKAgArdFwCADGyxAIAV0JaAgAA04ACAABOCgA==
Date:   Tue, 11 Dec 2018 13:46:30 +0000
Message-ID: <dc1db0e2-b9a6-8624-4be5-8b3719d99f4b@ysoft.com>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
 <5bea0e99.1c69fb81.18be0.5162@mx.google.com>
 <42ffee3e-7c2a-aab9-547f-2064a77339a8@ysoft.com>
 <a61683a2-30aa-e387-2170-3d79e0043739@ysoft.com>
 <18065d41-4ae0-ada2-35f1-00d8a8489397@ysoft.com>
 <20181211123640.GC4632@lunn.ch>
In-Reply-To: <20181211123640.GC4632@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:209:1::44) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5099;6:YMNGjmGW5LyZ0V7ecYGDNWjW8keNBUPVjclraDL6KfFqL0aeDuHsyyk7CwspYl+Jxc4KPGOPP/Mv1ymLo+MWIbqxOx5l3DRkIJgZT1FGnTtSNkTqmdpGk99aNKHjLA83Z5WC2O9FhKRCYST+U7QYoh40ANIMOlBwwaoUATZ4oCee9fUNlPBc44S5n1V5oKIOgDWxjtTYF1V4rk/SJugrLRyR+N7B/JHkjkO0WHIA0Jd7XQzfEBTh+AdjHNzHQdyPi9sQmPb/ZUgK8gOvaFyAmAoPvs/GtRtGkmX0GP0k6taFh1icrfGlImUOV4BKKzrTj/xLQAB3MKfhi8lQj79jWFe6IEuttRyBfhZ8q7hatPXoLUM1bOup6E4GlHNhDfIoeptYHMPoydSsuzMSxumhDevQyB3nBy7bGXleufGASRU7vaMqKjUqvN6IWT4IBEoUSO9oCDzEC5OjcPveAzzOww==;5:AMyKdFsTqHG6uRYLzUXJvjVBU5YbO5Ue5fL7MRKM9jkeDSGVUalmqbT+x5GshnNc5/14TstZ3Me9zXbEnvZTOV+TN19PHdvGsy+moXdy0x1ro62im4qOlaKS1q1vYwyK3H1HpxwtC6DMQc4R3uxphOj7ULxfQHiLaL1xQPBG5nQ=;7:sQQg+eZG0COB8LxXz4XeU+tCVVBdx4VjCLz/Jpl5rTlcB6UZ+zRHPrVeiRAc95tErrRzppn3Ak5Uk1sk0bIqcIJg2X9oV7LZtNSWdZ4jItVxBh+cOYwsKoHA5Bxubshphrv4FC6MOO1RCCzf8yEvhg==
x-ms-office365-filtering-correlation-id: 9e230b6c-2ea7-4b08-30fe-08d65f6f0e47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5099;
x-ms-traffictypediagnostic: DB7PR04MB5099:
x-microsoft-antispam-prvs: <DB7PR04MB5099D09CE78B6646F191C87C9EA60@DB7PR04MB5099.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5099;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5099;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(6512007)(8676002)(71200400001)(256004)(2906002)(31686004)(53936002)(106356001)(99286004)(316002)(14454004)(54906003)(105586002)(5660300001)(71190400001)(81156014)(53546011)(102836004)(229853002)(25786009)(386003)(7416002)(3846002)(97736004)(6116002)(186003)(26005)(36756003)(446003)(72206003)(6916009)(486006)(478600001)(85182001)(6436002)(2616005)(476003)(11346002)(86362001)(8936002)(6246003)(81166006)(31696002)(14444005)(4326008)(52116002)(76176011)(66066001)(305945005)(6486002)(7736002)(68736007)(6506007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5099;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fv13WhvcaL6i8RmRh66lvhAlHH/VOLq3xMHKwpLfcCz1zpeKO9c1laS6vv7CHV0g6/urJ/e3KDyIhXjJSllk/6/YfTlP6pKKeO3hlV0270RRU2nvrWvF2EnmIrnIoUDkcLaRRLFNdF0R/JGwMIElTYkAWGalhR9KF8n4/i56omhhlU8E2LouzP0Y+w35toi9rILBcA1eweLNJtgwP6ZB0zbYCfFPt594+ujcd6uQ3QIEk1Pw6JLOsQCKUdy946H2hwOlx08/y1xzpL2TOZdfKgXqkbmG9NOnEW+Zo4Jfnh0WzKHBLCDiQ9BRBPoYr7az
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C7763841A75A4B8F7B7956CF721C8D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e230b6c-2ea7-4b08-30fe-08d65f6f0e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 13:46:30.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMTIuMjAxOCAxMzozNiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gSGkgUm9iLCBnZW50
bGUgcGluZyBvbiB0aGlzLg0KPj4+DQo+Pj4gSSB3b3VsZCBsaWtlIHRvIGJlIHN1cmUgaG93IHRv
IHByb2NlZWQgd2l0aCB0aGlzLiBEbyB5b3UgcmVhbGx5IHdhbnQgbWUNCj4+PiB0byBtb3ZlICph
bGwqIG5vZGVzIHRoYXQgYXJlIGRpc2FibGVkIGluIHRoaXMgY29tbW9uIGR0c2kgaW50byB0aGUg
cGVyDQo+Pj4gYm9hcmQgZHRzPw0KPj4+DQo+Pj4gQWxsIHRoZSBib2FyZHMgdXNlIGlkZW50aWNh
bCBQQ0IuIEFueXRoaW5nIHRoYXQgaXMgZGlzYWJsZWQgaGVyZSBpcyBub3QNCj4+PiBwcmVzZW50
IG9uIGF0IGxlYXN0IG9uZSBvZiB0aGUgYm9hcmRzLiBJdCBtZWFucyBpdCBpcyByb3V0ZWQgb24g
dGhlDQo+Pj4gYm9hcmQgYW5kIHRoZSBTb0MgaGFzIHRoZSBjYXBhYmlsaXR5IGJ1dCB0aGUgcGFy
dHMgYXJlIG5vdCBwb3B1bGF0ZWQuDQo+Pj4NCj4+PiBTbyBpdCBpcyBub3Qgb25seSBhYm91dCB0
aGUgTEVEIGNvbnRyb2xsZXIuIFdoYXQgYWJvdXQgdGhlIExDRCwgT0xFRCwNCj4+PiBiYWNrbGln
aHQsIFVTQi4uPw0KPj4NCj4+IENhbiBhbnlib2R5IGFkdmljZSBob3cgdG8gc3BsaXQgdGhlc2Ug
ZHRzL2R0c2kgZmlsZXMsIHBsZWFzZT8NCj4+IEkgYW0gbm90IHN1cmUgd2hhdCBzaG91bGQgcmVz
aWRlIGluIHRoZSBjb21tb24gZHRzaSBhbmQgd2hhdCBzaG91bGQNCj4+IGJlIG1vdmVkIGludG8g
dGhlIHBlciBib2FyZCBkdHMgaW4gY2FzZSBteSBjdXJyZW50IHNvbHV0aW9uIGlzIG5vdA0KPj4g
YXBwcm9wcmlhdGUuDQo+IA0KPiBUaGUga2lya3dvb2Qtc3lub2xvZ3kuZHRzaSBtaWdodCBiZSBv
ZiBpbnRlcmVzdD8gVGhlcmUgYXJlIGEgbG90IG9mDQo+IFN5bm9sb2d5IE5BUyBib3hlcyB3aGlj
aCBzaGFyZSBhIGxvdCBpbiBjb21tb24uIFNvIGFsbCB0aGUgY29tbW9uDQo+IHBhcnRzIGFyZSBp
biB0aGF0IC5kdHNpLiBUaGUgLmRicyBmaWxlIGZvciBlYWNoIGluZGl2aWR1YWwgbW9kZWwgdGhl
bg0KPiBlbmFibGVzIHRoZSBwYXJ0cyBpdHMgbmVlZHMuDQoNClRoYXQgaXMgYSBncmVhdCBleGFt
cGxlIEFuZHJldywgdGhhbmsgeW91ISBUaGF0IGlzIGV4YWN0bHkgd2hhdCBJIGFtDQpkb2luZy4g
RXZlcnl0aGluZyB0aGF0IGlzIHN1cHBvcnRlZCBieSB0aGUgUENCL3BsYXRmb3JtIGlzIHNwZWNp
ZmllZA0KaW4gdGhlIGNvbW1vbiBmaWxlLiBPbmx5IHBhcnRzIHRoYXQgYXJlIHBvcHVsYXRlZCBv
biBhbGwgcHJvZHVjdHMgYXJlDQplbmFibGVkIHRoZXJlLCB0aGUgb3RoZXIgc3R1ZmYgaXMgZGlz
YWJsZWQuIFRoZSAuZHRzIGZpbGVzIHRoZW4gZW5hYmxlDQphZGRpdGlvbmFsIHN0dWZmIHRoZXkg
bmVlZC4NCg0KVG8gbWUgaXQgc2VlbXMgcmVhc29uYWJsZSB0byBkbyBpdCB0aGF0IHdheSBhbmQg
bWF5YmUgSSBvbmx5DQptaXN1bmRlcnN0b29kIHdoYXQgUm9iIGFjdHVhbGx5IG1lYW50IGJ5IGhp
cyBjb21tZW50PyBJIHN0aWxsIGRvIG5vdA0KaGF2ZSBoaXMgcmVwbHkgdG8gdGhhdCB0aG91Z2gu
DQoNCj4gQWx0aG91Z2ggeW91IGhhdmUgb25lIFBDQiwgb3IgdGhlIGRpZmZlcmVudCBwb3B1bGF0
aW9uIG9wdGlvbnMNCj4gY29uc2lkZXJlZCBkaWZmZXJlbnQgcHJvZHVjdHMsIGVhY2ggd2l0aCB0
aGVyZSBvd24gbmFtZT8NCg0KWWVzLCBlYWNoIG9mIHRoZSB0aHJlZSBwb3B1bGF0aW9uIG9wdGlv
bnMgY2FuIGJlIGNvbnNpZGVyZWQgYSBkaWZmZXJlbnQNCnByb2R1Y3Qgd2l0aCBkaWZmZXJlbnQg
bmFtZS4gVGhhdCBpcyBzdGlsbCB0aGUgc2FtZSBhcyB0aGUgU3lub2xvZ3kNCk5BUyBib3hlcywg
cmlnaHQ/DQoNCk1pY2hhbA0K
