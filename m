Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA71C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F2021729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oktfsprB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2021729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHHNNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:13:05 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:59899
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbeHHNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIfB0wVeiZvb9to7NxBJ9sgs6rCArbNem2xyp47EwCk=;
 b=oktfsprB70x8aIbn6pasu0QWYQkYl4u39eVVOuYy0BlCAVoToDr8M6Q+TxponggOKYuOhkxnhuoVFApZOlUx6zrjHt0gmOzlHqm53g8OiopHvi0byPJrR0DjJXLtuLEyM8ZbMfuPgMZ/wm8Ks2g4SvgBLmgciOKHSNwzYaKDddA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 8 Aug 2018 10:53:52 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 10:53:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUI2mAdxFCdwbsIEW0mCMYIbqjI6S1xVuA
Date:   Wed, 8 Aug 2018 10:53:52 +0000
Message-ID: <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1532448745.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5299;6:AU22RHAKsFJcnF6BgF4Bw3u+KZdRHiEtpCrt2ecpxt1H+KpIC3xdIVNDFNTjrtUJDQYhC92ydf75LujFe6zLB8LZJClwNiiElxpUI4161gVzLqnmGpSPHBZSusw8+8yJgL+3iJhk1/Xikx0d8HJCmTEagccfNpjH/7C0DkBw6L1gcCbHKppJAuiMfsFFeYwILxcOZ/4r5+URljEgkhULjGzlzKkN3+O+wmJRPfvLnPPKKk7tlcutQ0TbQLKRhsDG+6UQ+QJtObG1BPoB582ZB9aDEchw1dJNjaqAEYv/JclaN8Icbwwg9TQKgWDte6iXoEvtHdh47H7C/0cBYdq3sJoyN1t7+uwCzf8NykD4C+r0Cqk7G7KmlbgTFjlnlD6cUGqHT2qU/+ChnLhNq1TOJKkINAmAnENJ817GWogyHCg6MuPIrf2WQVEzaGviCVK4soBrDzhQ4LPSvXQrQEZiNA==;5:cpBevgMiPt9yv9leMnetoNk4WXH0+Sk8fG86VMjZsWS/GkoDq5McqvIbImcVxiJt7dK4ATlQiZwv5Iv0RR/8TnjjxTNxRQx5FP4CJEl74UKuvu7S4So5OyCUsqTTBCMZBCjyV/p5eFmB73zfCSjXbLyfRfz0gzSOFM2K241/7S0=;7:huOzPJfj5KQSV/rReGoQuSlTEgDGZyJXNQ8DsUMvsDlObsaB6b/XW8Tn/RFUaA44mGfrCTRF0RmtjIL9HOUjW1MqSe0KnTZdMsZMMjUfe++D5btFB6owopxosF+zAJoZdmoW2mq41qZIWr5p0OvRj/1/jh3kUV22IkFjv5I7rrmLL4zXAG45MnTSNpEo64Cz8Fey43IpG/JC1C4m4JvbVz4DdQBER9kNAdNzqJDoWFnMz/ZhVqjpsbL9ACq2ApPu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7b1ee1eb-4f49-435b-1892-08d5fd1d3af2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5299;
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-microsoft-antispam-prvs: <AM0PR04MB52995CD63F59F5619DA0AE6AEE260@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5299;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5299;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(110136005)(446003)(25786009)(476003)(97736004)(486006)(26005)(256004)(14444005)(7736002)(39060400002)(11346002)(2616005)(6486002)(305945005)(53936002)(7416002)(6436002)(54906003)(2501003)(6116002)(36756003)(3846002)(50226002)(6246003)(316002)(44832011)(68736007)(8936002)(99286004)(966005)(81166006)(6506007)(81156014)(14454004)(5250100002)(118296001)(186003)(2201001)(5660300001)(86362001)(105586002)(106356001)(8676002)(229853002)(102836004)(2906002)(2900100001)(66066001)(76176011)(6306002)(4326008)(478600001)(6512007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1eRHy1IjjYpLXIwoiowEMdFmqXBDt8n1SJ1kXaL9CxL8U6gGL0232ybDueE6oNyb8+Eu1O92Gh/9Cj3KdLJ14kZFGnSK1T1CxfSWXi912zK6otC9RmJvPo8vScqtEuGdK5Ng7imsWAA1hvgxBc8Y/aRl2ERHF/qTiUIg7+qLd+mzK09WJRp3aFaHza1bq8tceJQPdLzOjWSVsjmdN5k9KWhQMpQXDMiFnRUYoDUqdx+5JBn9v5T2c4ZcVOp9Ywx0MYgDQZ6ebcZBHiRNBbj8cfXRVcLHpMDbZRDG0Xr6efCE6fzb2W2nrIOR8+3WCWgzIcefo2P6sAuCOi/tDLZ0egbcBpXps01BirtUqksIicY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <23B53D73B389294AAF405023E09CE90D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1ee1eb-4f49-435b-1892-08d5fd1d3af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 10:53:52.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDE5OjE0ICswMzAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IENoYW5nZXMgc2luY2UgdjI6DQo+ICAqIFByaW50IHdpdGggZGV2X2luZm8gaWYgbGluayBm
YWlscyBvbiByZXN1bWUgKEx1Y2FzKQ0KPiAgKiBBZGQgYSBjb21tZW50IG9uIGlteDdkIHBjaSBp
cnEgbWFwcGluZ3MgKEFuZHJleSkNCj4gICogTWFrZSBpbXg2X3BjaWVfbHRzc21fZGlzYWJsZSBw
cmludCBhbiBlcnJvciBvbiBJTVg2USAoTHVjYXMpDQo+IA0KPiBUaGUgbHRzc21fZGlzYWJsZSBk
b2VzIG5vdCByZXR1cm4gYW4gZXJyb3IgYmVjYXVzZSBpdCBjYW4ndCBiZSB1c2VmdWxseQ0KPiBo
YW5kbGVkLCByZXZlcnNpbmcgcGFydGlhbCBzdXNwZW5kIGlzIGEgbmlnaHRtYXJlIGFuZCB1bmxp
a2VseSB0byB3b3JrLg0KPiANCj4gICogRHJvcCAicmVzZXQ6IGlteDc6IEZpeCBhbHdheXMgd3Jp
dGluZyBiaXRzIGFzIDAgKGFjY2VwdGVkIGJ5IFBoaWxpcHApDQo+IA0KPiBTZXJpZXMgaXMgYWdh
aW5zdCBsaW51eC1uZXh0IHRhZyBuZXh0LTIwMTgwNzI0IHdoZXJlIHRoZSByZXNldCBwYXRjaCB3
YXMNCj4gYWxyZWFkeSBhY2NlcHRlZC4gVGhlIGlteDdkLmR0c2kgcGF0Y2ggaXMgYWxzbyB1c2Vm
dWwgc3RhbmRhbG9uZS4NCj4gDQo+IExpbmsgdG8gdjI6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE4LzcvMjAvNDcyDQoNClRoaXMgaXMgYSBnZW50bGUgcmVtaW5kZXIgdGhhdCB0aGlzIHNlcmll
cyB3YXMgcmV2aWV3ZWQgYnkgTHVjYXMgdHdvDQp3ZWVrcyBhZ28gYnV0IG5vdCB5ZXQgaW5jbHVk
ZWQuDQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA==
