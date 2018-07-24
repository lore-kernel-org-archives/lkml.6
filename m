Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4D3205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="esD0zjVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4D3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeGXMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:51:31 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:46059
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388172AbeGXMvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmjCKCqTM6TXfNSbBDR+qtsRlFsNuwiFChyLf1p4+bo=;
 b=esD0zjVaGI2Si00xB67wax1gCtQHihDzYHMeMzhOa2PRQ9uZN9JTNGPdYwCDwhrHywHcUGuozEW9U7fU2S1eUk4WTGKih5eN8+2vb5yWRO1s2OVgARrZdAw2rCdAN1TMovVCj/AkY/Hk6sT+Dq0hmxZelEB/rzTM5soOZvqVkjI=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4113.eurprd04.prod.outlook.com (52.134.125.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 11:45:23 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 11:45:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 2/3] soc: imx: gpc: clean up
Thread-Topic: [PATCH v3 2/3] soc: imx: gpc: clean up
Thread-Index: AQHUIzIqZAscYhqrPkWfQiRH5UnoQKSeQTiA
Date:   Tue, 24 Jul 2018 11:45:23 +0000
Message-ID: <73b2d272a68ba6a21c62857733f5333a30323fcc.camel@nxp.com>
References: <1532425561377.1081@mixed-mode.de>
In-Reply-To: <1532425561377.1081@mixed-mode.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4113;6:y7GgWb3QHPMYFQIq7oA0FJHatvskfxECaGNgawGIyAP011E67Bsfy+Lk7qXpNVSgxW3HDEF9Ds1ZR+PZyIFMJsgdeTLmpnyXKc0BIAVUnoGgpLJU99b28IiBtF3FjFchnFn3A49Et+o6J0ucgeUFJrTnB95jalQOkn76HZ5AZ6YnoRTvoZ7IhynIHI2jauxKpPF9vKDjxFz9Ko7P/0InJ4C0HrU6h4idw+g8wIrNKwMRtvrtRTd8pUdbAdO+DllNIYsO5HLpsLsGulwXIsz83SzOYAB71hYROF9rc5TFC4PJHV8axLNHtnhSjqyAt/1yBcqyqDgQGGtJBizePYJQypqopv1y/mEb/KoYhOqpQcKDLELGvRw53VGfnX5dr2RMfj55b/rjahV7CbQDTT95oV7SXyIzj4VSoqzPN9HPqseeoQm2XmWw32GtNWbX7ocEfCcRnUUpjyZfWCVLxniCOQ==;5:Lwumf+X7mSvkMadKwgiFnurL9c8sGig/wX7q3zmtOsj9aEyvtvOloZb49EPTX21zGVVjz1KSUdotZrNDJ1YlQkhDikwQA2XWmAq9guaPp8Y/zXwpvvW8zBCMdmz8Ue0qamTFWtB62cr69bD1QY4YjpNWieBQLavUWVW4f8EiBQM=;7:r9aKiTqiXV5Xosc5DL9DlvSPUI0Q/0VWjUI0kurJZT50O45Km/JwAXw/qpvFnP4Q40GcC7GfZLseCsehYBiXVrbPwjfIbC1gjQm75nPCjOn0luSo1JGPYpJilouQXa5KpdNwtrsh6kmxRwGiVsqlOatNXCkeLaYQakVs1kPx6jArBaTdiXFRa/hhbdkiMb/Kwehu1XKbScfENQm2kz+fVcul20yzRbh2z5pQO2PSIcjMPwqxqBZhqpTZps5dDg63
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75a44e47-4972-42d3-2112-08d5f15af132
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4113;
x-ms-traffictypediagnostic: AM0PR04MB4113:
x-microsoft-antispam-prvs: <AM0PR04MB4113D716357A15E985F94E28EE550@AM0PR04MB4113.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4113;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4113;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(316002)(478600001)(6512007)(6436002)(256004)(97736004)(305945005)(6486002)(6916009)(2351001)(118296001)(229853002)(7736002)(106356001)(25786009)(2906002)(2900100001)(5660300001)(66066001)(6246003)(5640700003)(4326008)(53936002)(8936002)(26005)(186003)(81166006)(81156014)(105586002)(99286004)(486006)(8676002)(102836004)(6506007)(2616005)(5250100002)(476003)(68736007)(36756003)(44832011)(14454004)(76176011)(54906003)(6116002)(86362001)(50226002)(3846002)(2501003)(575784001)(446003)(11346002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4113;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hlCadeVSP4k3eO0CPZ7FyLFvajelFZ/5b6ZhPDkhAUIFX3nG9rGAs6yYmi/1xNJgUOzMvP8AjL0GkveAh7yRCzPRZzRSCAoOEPq7QNbZNfkssQEicdE1svYMWKiV9blPOomq+gvvOgpmTgCqhuJ3sMsK+7S8qnJ/jTtTax2LnHh2CAiW2FwKf7J4Bt6n8cyNwC8Ew1rLlapjeepKoimpyh3iuflBisvxX1yqD1k6QVortwh9n9Yr5zKBsP7vRoXnzh4rMwYEDVo0EEYa+wm9J2nKPkObFka/jHbWKbMLkDsgTRC13D0kN+HvPBwwm7fkfr1+pyOzZ7g8s49xE5B6ASL/7yGD1nLLJ1rxg9mjcP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B555B47FEA3D240B818150E4791DC46@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a44e47-4972-42d3-2112-08d5f15af132
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 11:45:23.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDA5OjQ2ICswMDAwLCBTdmVuIFNjaG1pdHQgd3JvdGU6DQo+
IFJlbW92ZSB1bnVzZWQgI2RlZmluZXMuDQoNClRoaXMgc2hvdWxkIGJlIHRoZSB0aXRsZSBvZiB0
aGUgcGF0Y2gsICJjbGVhbiB1cCIgaXMgdG9vIHZhZ3VlLg0KDQo+IC0tLSBhL2RyaXZlcnMvc29j
L2lteC9ncGMuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvZ3BjLmMNCj4gQEAgLTI0LDE1ICsy
NCwxMSBAQA0KPiAgI2RlZmluZSBHUENfUEdDX0NUUkxfT0ZGUwkweDANCj4gICNkZWZpbmUgR1BD
X1BHQ19QVVBTQ1JfT0ZGUwkweDQNCj4gICNkZWZpbmUgR1BDX1BHQ19QRE5TQ1JfT0ZGUwkweDgN
Cj4gLSNkZWZpbmUgR1BDX1BHQ19TVzJJU09fU0hJRlQJMHg4DQo+IC0jZGVmaW5lIEdQQ19QR0Nf
U1dfU0hJRlQJMHgwDQoNCkl0IHdvdWxkIGJlIGNsZWFuZXIgaWYgeW91IHVzZWQgdGhlc2UgZGVm
aW5lcyB3aGVuIHJlYWRpbmcgdGhlIHN3L2lzbw0KdmFsdWVzLg0KDQo+ICANCj4gICNkZWZpbmUg
R1BDX1BHQ19QQ0lfUEROCQkweDIwMA0KPiAgI2RlZmluZSBHUENfUEdDX1BDSV9TUgkJMHgyMGMN
Cj4gIA0KPiAgI2RlZmluZSBHUENfUEdDX0dQVV9QRE4JCTB4MjYwDQo+IC0jZGVmaW5lIEdQQ19Q
R0NfR1BVX1BVUFNDUgkweDI2NA0KPiAtI2RlZmluZSBHUENfUEdDX0dQVV9QRE5TQ1IJMHgyNjgN
Cj4gICNkZWZpbmUgR1BDX1BHQ19HUFVfU1IJCTB4MjZjDQoNCkVhY2ggUEdDIGhhcyBhIGZpeGVk
IHNpemUgYW5kIGxheW91dCwgbWF5YmUgd2UgY291bGQganVzdCBoYXZlIGRlZmluZXMNCmZvciB0
aGUgb2Zmc2V0IG9mIHRoZSBQR0M/IEl0IHdvdWxkIGJlIHNvbWV3aGF0IHNpbWlsYXIgdG8gZ3Bj
djI=
