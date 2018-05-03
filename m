Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039369-1525378547-2-14707268879999779162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525378546; b=a2HY//Q1K4Vr9buxdwWIcG3ISuubjSip76UtSSRr05kCZwDrNJ
    yUaKe//pYiDROyRODO+jC6pVQ+YvQ7xs5H4esgb4g3ghE8jcnDHX7bMNv08uD+H0
    ATko6JpQYP9GsfX4dIUhPFkgYIuxcYd/SAmuU45mvt2hbGCR9KRHMet3WMzh3QDb
    xMPdTx/dTgX7aWGpzpgyG445F72W6G1CbIC3Lhl6+3yb9zvPtSZVgN6rMNbKNpJi
    BM7h5BY0e8c5NTykPoJmSNHrmVi76QcQ4JG7sT+hmyJEoSzUx3cy7gwBrHHCyXi6
    3mgefJPiFfbxaJ1f/2p8odaCvBCKcB78/WPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525378546; bh=4r+1QO1hmsFP45bPxb6ugo08eTv+vMp0V/hGXwydW5I=; b=
    AYsZ2GUUmU3nfSfZcuNSfBRPkBhBL60LjR7R0qKrkorfzOenXs7erqFs23DUaq6O
    gXo8jTF6T/qhiEZDKXk72rCndM7kuHFK+BDCLM8TXMpHre0DQ+/oVTQYT4rH9VhX
    HAqntACzjMpgopV5q+W4KgxYVydXgUIVBYJQpEkumI4awTBL2cjkcpukpmx98Vj9
    w6sNrGZf/tx9qXjxmDjckYfmOSwadtJOlKMnZatYbpE9YjglZ8RuR8BeZCRATebE
    DQHrQgXrcozyWibE8gc+WbvjRg0TWsdv4DiLrZ7Cqm5KvcQaPaC9nTgxwvZ5ZNh1
    0zPZt9v4bsZ4bYEJeRTyoQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=NPendxoa x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=UrmWwLKE x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=NPendxoa x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=UrmWwLKE x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDAAR7GZHr4hWqoNWw+/q8Zg3xy8NWjT5LRlCDF6ihCBbOHfsKc+JUi2msVlh/fIaxAYyB5brb4ZKc9mehZIJADgyhPFtKf4PbzeceK4xj+KO/QttbL5
    44en3CWqdH3G04WkyJ6dYkOGxHGqiHgq4YB6hfNHhWA3heKkshkgSpFicKSyH12M5bcMsWOm3VK4q5igkIlXXUHl0+gTLg62RDa/exQGsSrZJlnWXgs9p1rV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NW1C4N5ZCfcA:10 a=l63GRFdEORMA:10
    a=wwSihFc02yEA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=szbNn-S5iAZgS6ZV2IoA:9
    a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECUPb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 16:15:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13144 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeECUP3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 16:15:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,359,1520870400";
   d="scan'208";a="180424839"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Topic: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Index: AQHT4wufiwM6RlY01kC8IdAQoZXaF6QeVHuAgAAcXoA=
Date: Thu, 3 May 2018 20:15:26 +0000
Message-ID: <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <20180503183353.GC1562@bombadil.infradead.org>
In-Reply-To: <20180503183353.GC1562@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0652;7:G5kjH437rgpdbTjM4Bd+OQFLiqB/6g/esceDlQG3ADHEmZAE3ka6+ne4uVOScaEnA7qi0ItRMlSk9gx2bNnpi9WLHaW27Qfu+MuO321u8+muL0qW7dhg26+btmoYrtGJCkvRQNhJ9oL98HlzzwP0jVSGq2HwsljtIw0xYzwXaM5WuTGJ9XBx5sew1RhJZZ6qbduzfraDp4dSjeX/eW8eLBs/+jOWo/lJrSIzfYtiGQZBy/jPvmn9w0qRwGFNYt44;20:sVNV/jXizpp281oG52mPPZM6QnzpBcMdAXhkV1t8G0UdCPyAUPhs4rt0TwPi/vjg/j6feMe469aw3i2zI9SSSTKTZNIwxHJM8qkYslDP+G02tIc0SWSqM47hmHNE729HqiS4ApolHsHkG3qDK2nj3+FnZqhCyDOseY+32WGhniA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0652;
x-ms-traffictypediagnostic: DM5PR04MB0652:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB065226BB65E03256C7725423F0870@DM5PR04MB0652.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR04MB0652;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0652;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(39380400002)(366004)(376002)(189003)(199004)(6486002)(486006)(5250100002)(11346002)(476003)(106356001)(5660300001)(36756003)(478600001)(8676002)(6246003)(53546011)(59450400001)(54906003)(6512007)(2616005)(316002)(4326008)(446003)(99286004)(72206003)(26005)(53936002)(305945005)(102836004)(186003)(76176011)(105586002)(6506007)(8936002)(68736007)(7736002)(3846002)(6116002)(14454004)(81156014)(81166006)(86362001)(66066001)(31696002)(25786009)(3280700002)(97736004)(31686004)(2900100001)(6436002)(2906002)(6916009)(229853002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0652;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fvaKb8eguyTEzVFwutkYfxugV6pljm8qV+6afQlgHkpo2S6GdVtgOZTPsovTrdPDIoi24BX5vF7IWtnbUCrs5R3n3VUJnnqrRKRy+bJGN9lb4+2I8XPwNGJDnkl6Pvhq+ozRfSZ0IjF3BOXleLrMNWmrw3mgFQ7t7VT1xOVD1UO57VxuVmNDcjiJqAefwnwJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3822E9025F1FC74CA698A76F10CDBAAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ec641844-9402-4648-29df-08d5b1329c45
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec641844-9402-4648-29df-08d5b1329c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 20:15:26.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0652
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMy8xOCAxMTozMyBBTSwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+IE9uIFRodSwg
TWF5IDAzLCAyMDE4IGF0IDExOjIxOjE0QU0gLTA3MDAsIGFkYW0ubWFuemFuYXJlc0B3ZGMuY29t
IHdyb3RlOg0KPj4gSWYgd2Ugd2FudCB0byBhdm9pZCBibG9hdGluZyBzdHJ1Y3Qga2lvY2IsIEkg
c3VnZ2VzdCB3ZSB0dXJuIHRoZSBwcml2YXRlIGZpZWxkDQo+PiBpbnRvIGEgdW5pb24gb2YgdGhl
IHByaXZhdGUgYW5kIGtpX2lvcHJpbyBmaWVsZC4gSXQgc2VlbXMgbGlrZSB0aGUgdXNlcnMgb2YN
Cj4+IHRoZSBwcml2YXRlIGZpZWxkIGFsbCB1c2UgaXQgYXQgYSBwb2ludCB3aGVyZSB3ZSBjYW4g
eWFuayB0aGUgcHJpb3JpdHkgZnJvbQ0KPj4gdGhlIGtpb2NiIGJlZm9yZSB0aGUgcHJpdmF0ZSBm
aWVsZCBpcyB1c2VkLiBDb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMgd2VsY29tZS4NCj4gDQo+IE9y
IHdlIGNvdWxkIGp1c3QgbWFrZSBraV9oaW50IGEgdTggb3IgdTE2IC4uLiBzZWVtcyB1bmxpa2Vs
eSB3ZSdsbCBuZWVkDQo+IDMyIGJpdHMgb2Yga2lfaGludC4gIChjdXJyZW50bHkgZGVmaW5lZCB2
YWx1ZXMgYXJlIDEtNSkNCg0KSSBsaWtlIHRoZSBhcHByb2FjaCBvZiB1c2luZyBhIHUxNiBmb3Ig
dGhlIGtpX2hpbnQuIEknbGwgdXBkYXRlIGFuZCANCnJlc3VibWl0Lg0KDQo+PiBAQCAtMzAwLDYg
KzMwMSw3IEBAIHN0cnVjdCBraW9jYiB7DQo+PiAgIAl2b2lkCQkJKnByaXZhdGU7DQo+PiAgIAlp
bnQJCQlraV9mbGFnczsNCj4+ICAgCWVudW0gcndfaGludAkJa2lfaGludDsNCj4+ICsJdTE2CQkJ
a2lfaW9wcmlvOyAvKiBTZWUgbGludXgvaW9wcmlvLmggKi8NCj4+ICAgfSBfX3JhbmRvbWl6ZV9s
YXlvdXQ7DQo+PiAgIA0KPj4gICBzdGF0aWMgaW5saW5lIGJvb2wgaXNfc3luY19raW9jYihzdHJ1
Y3Qga2lvY2IgKmtpb2NiKQ==
