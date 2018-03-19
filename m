Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3094471-1521472978-2-8843948145410034936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521472978; b=sfNHBxKVU6DhmB6X7UZCVPkFoiVIXPqcQoI61UrMORyQjXx
    zw1XDS/HvctC19oGhsk0BYe3wkZ9jR8eqHDp8Gymt90B/IC79r8y+nrlcHD7biMc
    yomcb73rhFNHqPUvYipBHVqfJHwba/281+PtNtlwf0IS3vUDdlrQzStNdUkfkikq
    kZlNIAJAGIvcFmrHLzc4PSAASE+SrcD/oZhkBkpASGkhPzt1MmRMmID7l/+7TJm6
    98yXx85f8nGRdjwKuCO6bKAPe6U+s18ksHt1p5UgJTdiz+a/nzpW/h/w91azwUjL
    5kwaMuOkeN02nqw9j+vl+G1YQa8zIo3HKIj00bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521472978; bh=nuWvZhczuQSs/+jcsDQjA1AOHfUR/J+m+7qg4Y
    Y6pJM=; b=nzwI/sWqmFsnNKgnAl83HCA9XDawVbcOL3fyWhevFlV5sPiUVBH5Pu
    O/L+UIgCMAU5hb8dkzX2FdZRg3IH+e7B8BwG5AoBb7G7O84n96tMA7/QYqZDHtUf
    y+iuk0LjRqQ1JVHvNpBHyciZr37u+SXl8G7n7qXLel4GI2y0IlgUCMrHU5xcyvCy
    85YDIpmsNMuNO7jStiRdl5kVvfn6kswZj7uZcJGZdBVLE2BySZPBczJm0u+nuakl
    G4RjpMNXAQQtyoVHM6lUce/tuD5GeZMpldViGEkjKsXqZY6kxFZEQCKVgZXqpuE6
    JrNyddtYwnkVLQB29gwXQSlYtJLb5VgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpedfmfgrnhhipdcuvfhoshhhihdfuceothhoshhhihdrkhgrnhhisehhphgvrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduhedrvdduuddrudelhedrkedpfhgvkedtmeemugelughfmeejfhgrmeeluggtjeemgeefleegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefvddtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpedfmfgrnhhipdcuvfhoshhhihdfuceothhoshhhihdrkhgrnhhisehhphgvrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduhedrvdduuddrudelhedrkedpfhgvkedtmeemugelughfmeejfhgrmeeluggtjeemgeefleegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefvddtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933449AbeCSPWZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:22:25 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:23132 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933400AbeCSPWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 11:22:21 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "toshi.kani@hp.com" <toshi.kani@hp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] acpi, numa: fix pxm to online numa node associations
Thread-Topic: [PATCH] acpi, numa: fix pxm to online numa node associations
Thread-Index: AQHTvNVqPSjmIBC9B0WbbCB8fAsb0KPXsk8A
Date: Mon, 19 Mar 2018 15:21:52 +0000
Message-ID: <1521472904.2693.192.camel@hpe.com>
References: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0346;7:gDX+HXdRY0m+7gTZSgI4cgI0v8mA38Bfy1CxEk6dmJSOv43nH0TdZ2T+wEMyro8Boebc6S9SSGPIFq+gQX+NPFVw09cVUs0N+zdLmzkkxzGeKy40JRKJ4ExfMid9f+3P7TMn7PrFMMK0b3ey+zxx56MuqGnKAkUvEEWRm0k5r0wFadne2PbSR2EeBcxegRF6z1cENy+4PadEMgdTePldriD834NtN9vdL174N8qWm7Ve/+nnXcoKaRIire13HjIc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71c5f4a2-135e-46fc-e687-08d58dad24c6
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0346;
x-ms-traffictypediagnostic: DF4PR8401MB0346:
x-microsoft-antispam-prvs: <DF4PR8401MB0346D470637D45E7D80730D482D40@DF4PR8401MB0346.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(209352067349851)(9452136761055)(222181515654134)(228905959029699)(73583498263828);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB0346;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0346;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(199004)(189003)(377424004)(8666007)(2501003)(6436002)(103116003)(5250100002)(6486002)(2900100001)(26005)(99286004)(2950100002)(186003)(229853002)(102836004)(6506007)(105586002)(110136005)(106356001)(76176011)(97736004)(54906003)(7736002)(3280700002)(25786009)(86362001)(3846002)(305945005)(6116002)(66066001)(316002)(14454004)(36756003)(4326008)(6246003)(3660700001)(68736007)(81156014)(8676002)(2906002)(6512007)(5660300001)(53936002)(8936002)(478600001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0346;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: WGHFb0SHjEm7TvCx6ZcIUEyGOpOZX+fsYHj1tH/x81hu1nFwMSKqG5My8WoLbAA/O/aLOO2NNHLsnehXdiOO3AU/1ODsKq8SeG7K42vfqGu9zvInYrGvTdIt42MTgiRsV5t8kWPjZzJ5yVPdVVM1c4rAF1ESx0To/Dw4JvxKx8FXmN4YWcRGPQIlU3zAEi10eYrd+imMt/cL5ACbm+o+nOjyZeXDnP6/R+nXNgOrZBRBxn408w1guafOut993DmMT9gW4zZPriNbjHyTFU778fK0ZWUHhr2kEtyfly9hUapXdc968vGoAuSE3YviSDgPwTyAuTsjAbmBciqiucdnRg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <201C8F00B9C81D4A82852208325D0E73@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c5f4a2-135e-46fc-e687-08d58dad24c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:21:52.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0346
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDIwOjA4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IENvbW1pdCA5OTc1OTg2OWZhZjEgImFjcGk6IEFkZCBhY3BpX21hcF9weG1fdG9fb25saW5lX25v
ZGUoKSIgYWRkZWQNCj4gc3VwcG9ydCBmb3IgbWFwcGluZyBhIGdpdmVuIHByb3hpbWl0eSB0byBp
dHMgbmVhcmVzdCwgYnkgU0xJVCBkaXN0YW5jZSwNCj4gb25saW5lIG5vZGUuIEhvd2V2ZXIsIGl0
IHNvbWV0aW1lcyByZXR1cm5zIHVuZXhwZWN0ZWQgcmVzdWx0cyBkdWUgdG8gdGhlDQo+IGZhY3Qg
dGhhdCBpdCBzd2l0Y2hlcyBmcm9tIGNvbXBhcmluZyB0aGUgUFhNIG5vZGUgdG8gdGhlIGxhc3Qg
bm9kZSB0aGF0DQo+IHdhcyBjbG9zZXIgdGhhbiB0aGUgY3VycmVudCBtYXguDQo+IA0KPiAgICAg
Zm9yX2VhY2hfb25saW5lX25vZGUobikgew0KPiAgICAgICAgICAgICBkaXN0ID0gbm9kZV9kaXN0
YW5jZShub2RlLCBuKTsNCj4gICAgICAgICAgICAgaWYgKGRpc3QgPCBtaW5fZGlzdCkgew0KPiAg
ICAgICAgICAgICAgICAgICAgIG1pbl9kaXN0ID0gZGlzdDsNCj4gICAgICAgICAgICAgICAgICAg
ICBub2RlID0gbjsJPC0tLS0gZnJvbSB0aGlzIHBvaW50IHdlJ3JlIHVzaW5nIHRoZQ0KPiAJCQkJ
ICAgICAgd3Jvbmcgbm9kZSBmb3Igbm9kZV9kaXN0YW5jZSgpDQoNCm91Y2guLi4NCg0KPiANCj4g
DQo+IEZpeGVzOiA5OTc1OTg2OWZhZjEgKCJhY3BpOiBBZGQgYWNwaV9tYXBfcHhtX3RvX29ubGlu
ZV9ub2RlKCkiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBUb3NoaSBL
YW5pIDx0b3NoaS5rYW5pQGhwLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbT4+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpUaGFua3MgRGFuIGZvciB0aGUgZml4IQ0KDQpSZXZp
ZXdlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29tPg0KDQotVG9zaGkNCg==
