Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122F8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21622080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NRkL50hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfBELmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:42:18 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37482 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfBELmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:42:17 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 3416E10C1DA3;
        Tue,  5 Feb 2019 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549366937; bh=Yce3X/TqpvwmQnsjnkZtILb947iju3O7l09bMf9pFFQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NRkL50hOdiy2ezoYUIn8vRa820m5DZc2BWtlr3bd3RZkg3RjV/2g/DjFIn6Ax6kiW
         8qpF9NxFfrFE4cQdEwyhXzvSiiFXMM9SWQB1SB09IDiGoe6rn8BNgK1Gasq0GDJ0sf
         v3PVHNO4F6u/PiW5xM0Z7rGsk5UYTI6/YZfjMU9iPaWI8pbHMIGzLmUMZIYgbBMXYA
         wbOFBP7Ta7a59O5uZ+ZEyD6q1y4l95nLoNc0raA28jAiT44RKhnBtVXA4DRCcJHdM2
         38YPhP7Ncjy2o4LWowyqTTluGGbLJ2hqXL1k7NFUK/b5Rc/Fb1mgO0mywKCKruFBFh
         nKZoeOLUlZZAA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7DB06A007F;
        Tue,  5 Feb 2019 11:42:16 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 03:42:16 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 5 Feb 2019 12:42:13 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 2/2] arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT
Thread-Topic: [PATCH 2/2] arc: hsdk_defconfig: enable
 CONFIG_ARC_UBOOT_SUPPORT
Thread-Index: AQHUvS1c68i07txQV06Fs79Yk0X2SqXRBIuA
Date:   Tue, 5 Feb 2019 11:42:12 +0000
Message-ID: <1549366931.27724.26.camel@synopsys.com>
References: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
         <1549355535-22052-3-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1549355535-22052-3-git-send-email-clabbe@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A9635C44174740803D8D466C13AAB2@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29yZW50aW4sDQoNCkluIGNhc2Ugb2YgZGV2Ym9hcmRzIChsaWtlIEhTREspIHdlIHJlYWxs
eSBvZnRlbiBkaXNhYmxlIGJvb3Rsb2FkZXIgYW5kIGxvYWQNCkxpbnV4IGltYWdlIGluIG1lbW9y
eSB2aWEgSlRBRy4gRW5hYmxpbmcgQ09ORklHX0FSQ19VQk9PVF9TVVBQT1JUIGJ5DQpkZWZhdWx0
IHdpbGwgYnJlYWsgaXQgYXMgd2Ugd2lsbCB0cnkgdG8gaW50ZXJwcmV0IHNvbWUganVuayBpbiBh
IHJlZ2lzdGVycw0KYXMgYSBwb2ludGVycyB0byBib290YXJncy9ldGMgd2hpY2ggYXJlbid0IHNl
dCBieSBhbnlvbmUgaW4gY2FzZSBvZiBKVEFHIHVzaW5nLg0KDQpTbyBpdCBpc24ndCBhIGdvb2Qg
aWRlYSB0byBoYXZlIENPTkZJR19BUkNfVUJPT1RfU1VQUE9SVCBlbmFibGVkIGJ5IGRlZmF1bHQu
DQoNCk9uIFR1ZSwgMjAxOS0wMi0wNSBhdCAwODozMiArMDAwMCwgQ29yZW50aW4gTGFiYmUgd3Jv
dGU6DQo+IFdlIGhhdmUgbm93IGEgSFNESyBkZXZpY2UgaW4gb3VyIGtlcm5lbGNpIGxhYiwgYnV0
IGtlcm5lbCBidWlsZGVkIHZpYQ0KPiB0aGUgaHNka19kZWZjb25maWcgaWdub3JlIGJvb3Rhcmdz
LCBzbyBpdCBjYW5ub3QgYm9vdCBrZXJuZWxjaSBqb2JzIHlldC4NCj4gRnVydGhlcm1vcmUsIEkg
dGhpbmsgdGhlIHByb2JhYmlsaXR5IGlzIHRoYXQgZGV2aWNlcyB3aWxsIGJlIGJvb3RlZCBtb3Jl
IHZpYQ0KPiB1Ym9vdCB0aGFuIGJ5IGEgZGVidWdnZXIuDQo+IA0KPiBTbyB0aGlzIHBhdGNoIGVu
YWJsZSBDT05GSUdfQVJDX1VCT09UX1NVUFBPUlQgaW4gaHNka19kZWZjb25maWcuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDb3JlbnRpbiBMYWJiZSA8Y2xhYmJlQGJheWxpYnJlLmNvbT4NCj4gLS0t
DQo+ICBhcmNoL2FyYy9jb25maWdzL2hzZGtfZGVmY29uZmlnIHwgMSArDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9jb25maWdz
L2hzZGtfZGVmY29uZmlnIGIvYXJjaC9hcmMvY29uZmlncy9oc2RrX2RlZmNvbmZpZw0KPiBpbmRl
eCAwZTVmZDI5ZWQyMzguLmI4MGUzYWM1YzkzYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMvY29u
Zmlncy9oc2RrX2RlZmNvbmZpZw0KPiArKysgYi9hcmNoL2FyYy9jb25maWdzL2hzZGtfZGVmY29u
ZmlnDQo+IEBAIC05LDYgKzksNyBAQCBDT05GSUdfTkFNRVNQQUNFUz15DQo+ICAjIENPTkZJR19Q
SURfTlMgaXMgbm90IHNldA0KPiAgQ09ORklHX0JMS19ERVZfSU5JVFJEPXkNCj4gIENPTkZJR19C
TEtfREVWX1JBTT15DQo+ICtDT05GSUdfQVJDX1VCT09UX1NVUFBPUlQ9eQ0KPiAgQ09ORklHX0VN
QkVEREVEPXkNCj4gIENPTkZJR19QRVJGX0VWRU5UUz15DQo+ICAjIENPTkZJR19WTV9FVkVOVF9D
T1VOVEVSUyBpcyBub3Qgc2V0DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
