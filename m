Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185AECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC9720881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC9720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIOBx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:53:56 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:29205 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeIOBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:53:56 -0400
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 354DDB9;
        Fri, 14 Sep 2018 20:37:50 +0000 (UTC)
Received: from G9W8670.americas.hpqcorp.net (16.220.49.29) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 20:37:50 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W8670.americas.hpqcorp.net (16.220.49.29) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 20:37:49 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 14 Sep 2018 20:37:49 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0898.NAMPRD84.PROD.OUTLOOK.COM (10.169.6.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 14 Sep 2018 20:37:48 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Fri, 14 Sep 2018
 20:37:48 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
Thread-Topic: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
Thread-Index: AQHUSoMTsCmedJ847kC065sH/qNN66TwQJAA
Date:   Fri, 14 Sep 2018 20:37:48 +0000
Message-ID: <dc8b03de1e3318e3dd577d80482260f99ab4e9a5.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1536747974-25875-4-git-send-email-will.deacon@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0898;6:5T+UxHyEwcAHF09LT/H0bmRgsAeR5ryggm+iKPOvXMaFeSt7mg2DosgG28BBGPKcKmYa5rCzzu+dVV18CjYWSauadQeel2k+ehPMk1luuqNmXrd9LViBohQHm6oBmCYg6KhBhBP7VOHKPrNjjyew1c+wYS8vhocjepNNBy4UhCdYYnDZcxCHsYA0USpPHjUcp0SHEZhwfzvE/+Jdc21AzMioOeAOdmNTgS92dSvsdM8VcC3lBEcKVUrsyhGhBARHMu6tTao9UCBjWrt7yxzhzRhlIboK9kkjVeYH5N/gS4dmBBuvNJU4kr2SYzTuwPO9772eRd7Jhq+Al61vNBNIgxXnaoyieuzpFdn2iD5XoWDIn7XD/vTUjuYMR37R3JiwwMAg3/WQBfp/GZWePfgKXgwb5cza4Zp6kRLPh4KOIWhpGzP1x52W7gBYJr2g2shzBX7zUKzrcSwBtkZBJj1XXg==;5:eyYv9FXaGDm8HpiOvZKyi0bV7IsZhlLbJPYYF7qoYrI0NphzZWVxTjQx4co9G3/xC/OXw0/jUJCmGZWQLI/y+8ww+8Tzq6h5OQukiIp2C6ldIV6SLN+TaFSzyS5sXUcmqapGp9lGA0pMDkRLV/3KsTV51sR8W9cA1AQZZWerKDw=;7:IBONwmzFaDWeLyrrCxXUboVtkrumqMYvYn1izQHS8hjFiU63uMeeWPrLdrcBGpQlY2R6BorF7Cdt+hQGKCMrLgPZqoP9kyF/HEXEswwmwrVSbj2d2x8H5Or2uDeQ9pjStuGJDDTo1pkYLLmFVS8RLLRjBYtmHW6yZ0T/K/O9k5HTRmAdNI5j5hdgnwPsN7QqiBdBqh5BHjTMMM9YAqYQzfp23zdlOzxzAAwotnmVoXjY8Fn86Y2vd1up2LOHmdbp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 72553b4b-7945-4a18-bebc-08d61a81eee3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0898;
x-ms-traffictypediagnostic: AT5PR8401MB0898:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0898AACAB19D08943D4B07E482190@AT5PR8401MB0898.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0898;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0898;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(57704003)(105586002)(316002)(68736007)(118296001)(2616005)(14454004)(446003)(97736004)(6116002)(11346002)(2906002)(25786009)(106356001)(3846002)(6436002)(6512007)(4326008)(6486002)(6246003)(53936002)(229853002)(478600001)(2900100001)(2501003)(486006)(5250100002)(8936002)(6506007)(66066001)(102836004)(36756003)(256004)(8676002)(81166006)(2201001)(81156014)(76176011)(7736002)(5660300001)(110136005)(86362001)(305945005)(476003)(99286004)(54906003)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0898;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /pvEt+uGwMfjPHxgDPDwxM4aakvosS7g/EeSqJMgtiiyJN5QqfC6fv+664yHqfwZrzRwP7q2Af+IpwgY39miSPuKKWLGPtRp28HFZ6BtzDjikQ10Dy7jSaqa0Ui7lNcY6LEqwP++3mCwRFi0wwV03ZJQNXwiCUbyg0G01hapc7VkdrsqI6PX25quVfd/IHA2oWNexmMpm8jRT7BneT5M9YY8oGXgNJI/qkkzhbPloK28fK4/ExaHvP7NZBB3jRP01CY2N03LKw9yJ+VD1ZUXjSNIUuETadnzW4ku47Sbblf8u+B9FOwjMpY2SIYleujXYicLIamz36WvTpDCmlI51daCHaEqjbQW1OxPtpKCz/s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FA3F5CC3F7D74FA70DC541EA54D9DA@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72553b4b-7945-4a18-bebc-08d61a81eee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:37:48.0249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0898
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI2ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
Tm93IHRoYXQgdGhlIGNvcmUgY29kZSBjaGVja3MgdGhpcyBmb3IgdXMsIHdlIGRvbid0IG5lZWQg
dG8gZG8gaXQgaW4gdGhlDQo+IGJhY2tlbmQuDQo+IA0KPiBDYzogQ2hpbnRhbiBQYW5keWEgPGNw
YW5keWFAY29kZWF1cm9yYS5vcmc+DQo+IENjOiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5j
b20+DQo+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gQ2M6IE1p
Y2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogV2lsbCBEZWFjb24gPHdpbGwu
ZGVhY29uQGFybS5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvbW0vcGd0YWJsZS5jIHwgNiAtLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L21tL3BndGFibGUuYyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiBpbmRleCBh
ZTM5NDU1MmZiOTQuLmI0OTE5YzQ0YTE5NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvbW0vcGd0
YWJsZS5jDQo+ICsrKyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiBAQCAtNzk2LDkgKzc5Niw2
IEBAIGludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFkZHIp
DQo+ICAJcHRlX3QgKnB0ZTsNCj4gIAlpbnQgaTsNCj4gIA0KPiAtCWlmIChwdWRfbm9uZSgqcHVk
KSkNCj4gLQkJcmV0dXJuIDE7DQo+IC0NCg0KRG8gd2UgbmVlZCB0byByZW1vdmUgdGhpcyBzYWZl
IGd1YXJkPyAgSSBmZWVsIGxpc3QgdGhpcyBpcyBzYW1lIGFzDQprZnJlZSgpIGFjY2VwdGluZyBO
VUxMLg0KDQpUaGFua3MsDQotVG9zaGkNCg0KDQo+ICAJcG1kID0gKHBtZF90ICopcHVkX3BhZ2Vf
dmFkZHIoKnB1ZCk7DQo+ICAJcG1kX3N2ID0gKHBtZF90ICopX19nZXRfZnJlZV9wYWdlKEdGUF9L
RVJORUwpOw0KPiAgCWlmICghcG1kX3N2KQ0KPiBAQCAtODQwLDkgKzgzNyw2IEBAIGludCBwbWRf
ZnJlZV9wdGVfcGFnZShwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIpDQo+ICB7DQo+ICAJ
cHRlX3QgKnB0ZTsNCj4gIA0KPiAtCWlmIChwbWRfbm9uZSgqcG1kKSkNCj4gLQkJcmV0dXJuIDE7
DQo+IC0NCj4gIAlwdGUgPSAocHRlX3QgKilwbWRfcGFnZV92YWRkcigqcG1kKTsNCj4gIAlwbWRf
Y2xlYXIocG1kKTsNCj4gIA0K
