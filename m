Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44367C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122C20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1122C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeLLVQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:16:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:16742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbeLLVQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:16:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 13:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,346,1539673200"; 
   d="scan'208";a="127380543"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2018 13:16:41 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 13:16:41 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.103]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.49]) with mapi id 14.03.0415.000;
 Wed, 12 Dec 2018 13:16:41 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Thread-Topic: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Thread-Index: AQHUkj7xabqLvJKsV0WIbkZeNQOeIqV7dNjwgACQKYCAABnZAP//enag
Date:   Wed, 12 Dec 2018 21:16:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
 <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
 <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgW21haWx0bzpyYWZhZWxAa2VybmVsLm9yZ10NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJl
ciAxMiwgMjAxOCAxOjA3IFBNDQo+IFRvOiBva2F5YUBrZXJuZWwub3JnOyBTY2htYXVzcywgRXJp
ayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+DQo+IENjOiBBQ1BJIERldmVsIE1hbGluZyBMaXN0
IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IE1vb3JlLCBSb2JlcnQNCj4gPHJvYmVydC5t
b29yZUBpbnRlbC5jb20+OyBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb20+Ow0KPiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGRldmVsQGFjcGljYS5vcmc7
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNS81XSBBQ1BJQ0E6IFJlbW92ZSBQQ0kgYml0
cyBmcm9tIEFDUElDQSB3aGVuDQo+IENPTkZJR19QQ0kgaXMgdW5zZXQNCj4gDQo+IE9uIFdlZCwg
RGVjIDEyLCAyMDE4IGF0IDg6MzQgUE0gU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+ID4NCj4gPiBPbiAxMi8xMi8yMDE4IDI6MDIgUE0sIFNjaG1hdXNzLCBFcmlrIHdyb3Rl
Og0KPiA+ID4+ICsrIGIvZHJpdmVycy9hY3BpL2FjcGljYS9hY2h3YXJlLmgNCj4gPiA+PiBAQCAt
MTA5LDggKzEwOSwxNyBAQCBhY3BpX2h3X2VuYWJsZV9ydW50aW1lX2dwZV9ibG9jayhzdHJ1Y3QN
Cj4gPiA+PiBhY3BpX2dwZV94cnVwdF9pbmZvICpncGVfeHJ1cHRfaW5mbywNCj4gPiA+IENPTkZJ
R19QQ0kgaXMgYSBMaW51eC1pc20uIFdlIHNob3VsZCBzdGF5IHdpdGggdGhlIE9TLWluZGVwZW5k
ZW50DQo+ID4gPiBuYXR1cmUgb2YgQUNQSUNBLiBQbGVhc2UgdXNlIEFDUElfUENJX0NPTkZJR1VS
RUQgYW5kIHB1dCBpdCBhYm92ZQ0KPiB0aGUgY29tbWVudCBsaWtlIHNvOg0KPiA+ID4NCj4gPiA+
ICNpZmRlZiBBQ1BJX1BDSV9DT05GSUdVUkVEDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBmZWVk
YmFjay4gTXkgc2VhcmNoIGZvciBBQ1BJX1BDSV9DT05GSUdVUkVEIHJldHVybmVkDQo+IG5vdGhp
bmcuDQo+ID4NCj4gPiBnaXQgZ3JlcCBBQ1BJX1BDSV9DT05GSUdVUkVEDQo+ID4NCj4gPiBAUmFm
YWVsLA0KPiA+DQo+ID4gSG93IGRvIHlvdSB3YW50IHRvIGhhbmRsZSB0aGlzPw0KPiANCj4gSSB0
aGluayB3aGF0IEVyaWMgc3VnZ2VzdGVkIGlzIGVmZmVjdGl2ZWx5IHRvIGludHJvZHVjZSBhIG5l
dyBBQ1BJQ0Egc3ltYm9sLg0KPiBFcmlrPw0KDQpZZXMsIHRoYXQncyBjb3JyZWN0IGFuZCB5b3Ug
Y2FuIGFkZCBzb21ldGhpbmcgbGlrZQ0KDQojaWZkZWYgQ09ORklHX1BDSQ0KI2RlZmluZSBBQ1BJ
X1BDSV9DT05GSUdVUkVEDQojZW5kaWYNCg0KaW4gaW5jbHVkZS9saW51eC9wbGF0Zm9ybS9hY2xp
bnV4LmggdG8gZW5hYmxlIGl0LiANCg==
