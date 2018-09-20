Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6021BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100AD2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lVbQKMK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100AD2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbeITSAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:00:36 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:29408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeITSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZYqEOYxiEFMIUlegmuBidPrdIZxI+pwJlXaCxtW6HI=;
 b=lVbQKMK6fvOGBV0CgUBC+JQ/VKeC5omQWYSYptbat7L5/r7i0bZoAuy3v+9mJ9THzz+eFhcxCr66FGNpfm9nJLNS6OXtejAkq4ZXBzFFtPoTPJrcA0UjWx9zwH+ZDV8p3XNCTI2qCqkHV/k0WoCGzT5GfIq41YDexSItl3Uoc04=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4308.eurprd04.prod.outlook.com (52.134.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 12:17:18 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 12:17:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "jslaby@suse.com" <jslaby@suse.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] serial: imx: restore handshaking irq for imx1
Thread-Topic: [PATCH] serial: imx: restore handshaking irq for imx1
Thread-Index: AQHUUNsX9E7BfMdKEEeXeGa6mxFO3qT5Ff8A
Date:   Thu, 20 Sep 2018 12:17:18 +0000
Message-ID: <7c7d24fcfac2fe8afe7151d3afe49cb48be68dce.camel@nxp.com>
References: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
         <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4308;6:3qH2szq3HYoT5GDY0g0b/TwyUohLeKaSynJyOuxcu8aW+gBBjkelud/wcmuwHHOPnhZzq2ABssGBhm8EIS6lGKcayw1dFSQSVXSsBuFRM9zGwERDqqCA1aRohQWKB8G2mat3xuMGXT+Y4DcD6CCBculHhX5jAg9eO/yELgpB2Sun54J7/TPnXdFuE3HopB59Qm5u4ikthlK/cuassnwhbL/bngAKa0fQHIK2/a70A0pcZvMor/H8iWGidNCsgQMos0czsUuP8gmOjz2v4hHZroOjOCOxKw/NpedQaVRQXErSCIJXoeNRhn2ay+r3rGt4cI603AstKBRvsGq8qEQHKVqYQdUXCPRnWEFomHyWjYcNo+WJEdYZx3XrOkN5exSeI9KEL/tPwr0x/PU1+euKnngmPVn4jEAwBktxkENwC1F1RsiJJ1wsSS5Ihw89e/1Qq2iM05kf9HnDqU5aQ6q/zA==;5:Tt7YvPE3vZz5ZUBPfuBk5zsr1kJuIGiTs1z2I2sewkVW+i7yltFJc9EZ9W0Pj5v+mtpq3ttSk+2ylM4bgcs8BE98/0PlpURLYE4ZgmbJp2LhcBaiS37/poTB3dA3XWfIjy6Sg6pqK9KalbHm65ho5Q8jMBzmvCJdiutoIboxZRY=;7:VjfuxDf1ZK4KyQekRSfBigntWsGC56530/zVzOY2ZvfR0HfZpLOKWWlFN8eUG01TGw76oJFL47eYSbQ4XtbZbNF1+oHRjzBhcDUn9T7aNGas9EEzaoyiPJxadeB7cxAL0m0r5YVN5lHJG0HGN9ytGIL2JuA1EUp/P8KqJxKvsp8ehmfS0rp1xPo3eyNiZv0fXTfSNY1GQ2RPsG7Zh5c0zpBavr1Lx05M7CVRN0Vpce/gJk5lTKmnUgf9IJR8pKm+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7c6c7c65-efda-4a6d-7b50-08d61ef3029b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4308;
x-ms-traffictypediagnostic: AM0PR04MB4308:
x-microsoft-antispam-prvs: <AM0PR04MB43086011EF150831261CADE8EE130@AM0PR04MB4308.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4308;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4308;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(7736002)(229853002)(110136005)(68736007)(8676002)(6512007)(486006)(2900100001)(186003)(2201001)(478600001)(99286004)(66066001)(50226002)(26005)(2906002)(14454004)(102836004)(86362001)(2501003)(97736004)(6436002)(316002)(2616005)(6486002)(11346002)(4326008)(53936002)(446003)(76176011)(44832011)(5250100002)(54906003)(6246003)(25786009)(6506007)(8936002)(6116002)(36756003)(81156014)(5660300001)(476003)(3846002)(256004)(305945005)(81166006)(118296001)(105586002)(106356001)(71190400001)(71200400001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4308;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ax/RgjC+US3bM7NmPhrsK1gMeYmYpcEynpaLNOGXhzhheC7jpsxJvEoaDT8WVs3f/7SimucFHEuvcQY8YjBMXXtjZdSvzXWi9lF70RFOnVabIpIyA2jSeKrA2rfi4lUeU3GgyC4WW+cEro9AormA0r96RnmKlUyYhSWnl1GZ3ctcy1Bo2JpjBoFYqjKUG+SmcAbvfa7WzcdmaCMU+LF7tY4ao+aUJzqu473AcjZ7OoKGjXdQAqIbm6wZ+zHNyAQNBrutzTOi1DVkD5ia9H4BXH/n45zh5kD+UxwN9QeRqok2JtAxaL/c8npsclM6vNpU4aR5sE/Usn1z5zhmDekZ9BGPlcelx2pgssBUaGvH0Qg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CEEF2D0D925944A9715C53B0CE8233E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6c7c65-efda-4a6d-7b50-08d61ef3029b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 12:17:18.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA5LTIwIGF0IDE0OjExICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gQmFjayBpbiAyMDE1IHdoZW4gaXJkYSB3YXMgZHJvcHBlZCBmcm9tIHRoZSBkcml2ZXIg
aW14MSB3YXMgYnJva2VuLiBUaGlzDQo+IGNoYW5nZSByZWludHJvZHVjZXMgdGhlIHN1cHBvcnQg
Zm9yIHRoZSB0aGlyZCBpbnRlcnJ1cHQgb2YgdGhlIFVBUlQuDQo+IA0KPiBGaXhlczogYWZlOWNi
YjFhNmFkICgic2VyaWFsOiBpbXg6IGRyb3Agc3VwcG9ydCBmb3IgSVJEQSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+
DQoNClJldmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29t
Pg0KDQpJJ20gbm90IHN1cmUgaWYgYW55b25lIGhhcyBpbXgxIGhhcmR3YXJlIGhhbmR5IGNhbiBp
cyB3aWxsaW5nIHRvIHRlc3QNCnRoaXMgQ1RTL1JUUyBidXQgdGhlIGZpeCBpcyBwcmV0dHkgb2J2
aW91c2x5IGNvcnJlY3Qu
