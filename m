Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E532223DFD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E532223DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGEIsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:48:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752458AbeGEIsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:48:17 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id A411346EC1551;
        Thu,  5 Jul 2018 16:48:13 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.382.0; Thu, 5 Jul 2018 16:48:14 +0800
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.130]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0382.000;
 Thu, 5 Jul 2018 16:48:12 +0800
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Frieder Schrempf" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next v3] mtd: spinand: fix missing unlock on error
Thread-Topic: [PATCH -next v3] mtd: spinand: fix missing unlock on error
Thread-Index: AQHUE3heUC+B2jpPM0eR0dndkNf3KKR/rmoAgACinBA=
Date:   Thu, 5 Jul 2018 08:48:11 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB401E2726B@dggeml512-mbx.china.huawei.com>
References: <1530696061-76467-1-git-send-email-weiyongjun1@huawei.com>
        <1530696627-84879-1-git-send-email-weiyongjun1@huawei.com>
 <20180705085936.38f6c374@xps13>
In-Reply-To: <20180705085936.38f6c374@xps13>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.30.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSGkgV2VpLA0KPiANCj4gV2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+
IHdyb3RlIG9uIFdlZCwgNCBKdWwgMjAxOA0KPiAwOTozMDoyNw0KPiArMDAwMDoNCj4gDQo+ID4g
QWRkIHRoZSBtaXNzaW5nIHVubG9jayBiZWZvcmUgcmV0dXJuIGZyb20gZnVuY3Rpb24NCj4gPiBz
cGluYW5kX210ZF8ocmVhZHx3cml0ZSkgaW4gdGhlIGVycm9yIGhhbmRsaW5nIGNhc2UuDQo+ID4N
Cj4gPiBGaXhlczogYzg5OGUwNTI2ZmI2ICgibXRkOiBuYW5kOiBBZGQgY29yZSBpbmZyYXN0cnVj
dHVyZSB0byBzdXBwb3J0IFNQSQ0KPiBOQU5EcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIFlv
bmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSB0d28gZml4ZXMgb3ZlciB0aGUgc3BpbmFuZCB3b3JrLiBBcyB0aGlzIGNvZGUgaXMgbm90
DQo+IHlldCB1cHN0cmVhbSwgZG8geW91IG1pbmQgaWYgSSBmb2xkIHRob3NlIGZpeGVzIGRpcmVj
dGx5IHdpdGggdGhlDQo+IGluaXRpYWwgcGF0Y2g/DQoNCk5vLCBJIGRvbid0LiBGZWVsIGZyZWUg
dG8gZm9sZCB0aGVtIHRvIHRoZSBpbml0aWFsIHBhdGNoLg0KDQpSZWdhcmRzLA0KV2VpIHlvbmdq
dW4NCg==
