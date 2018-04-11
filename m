Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2635071-1523457469-2-325396552168623119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523457469; b=d8QkvYnkpStKFvoz+sh5OncXRmLpq/9zfZcoM21vwKUX6N6P1u
    FvFOGWDP39h+xSlBgoAaAsYdDYIB0H7qVNb61LkcZemiyo1lGbp/2Z3rvXbBgkxZ
    56zFy+AeAPUoArB4KbzqK12Qm0kmnRMSLldIORCSVtWPX2h5Vaiyp8MGGJ2bFhy4
    EP0I0zYmFBoovGDH2bO8eO7RH0gjN2bwAYzVg0gAE3tFcm82zpQ7UfJPpi5+dP4V
    69Jw6edHRWRBivKpLp/Nzag1RNfuyC8yYhheA4OGCtHEUr3c7fUDyPo/aVeGpSXt
    MI7AW7bH8jHkOD1agiu1PUf68mM03GEjXsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523457469; bh=nQg1QdnUy0
    l2CTK7Vot+bjOzzuZ9LNpflnSOcIrIujc=; b=UYLz7htjly4Utc6HeeztoXBwmT
    SQQe31fy1AH2ZbKqC2TW6FATBaW5KyJZliiE8h3ZjFPB6UmdYGX5928lXiCD9/nN
    QuiaPf93QhcRwrO3EaKcc9Js1IwBSPTEmm0Io3ChMffw7DXGdbdqMg9h59r2tCYz
    2JVbd8PibN4BmTZVVF2nT5cUQ2L+n8fXTzxmscb0pxcZnEQfjA3VG5WUy469zbKr
    VNxfuUDAXwobSBwfruxQz6A3BW0C8paNGxonqg6F6rF+Zu6g+5wcmgtrZer9Dtv3
    beRW/nN1SKtLZgu4G/SlPx+1TvTMRN914kuxSV6pokWn93qa6dQAE9EW29OQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNhm71bgnTa4f5rRo0HBuc+qovJyQEZu/wxssxx6f/T6DtYMNO7zDGJrOrpspYn+Bhqi2LsQw86seLrQke8uaHsfts5vHmaOi+V2XCTcm7MpMK4xXsWs
    Pin6vloD0N9AlHn9MZonv/3YpOngYjskR1Bs5Mkh/qjhxn2x/v13bEs+b9ByuZ88q42ubKqYTJ+3/LWIHPq3nQcPeUCJNPAOcbEfQ7iMlmi1Rx2DB7k29RnV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=-mWGVWDaP3wA:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
    a=7LIi7Q7VcSWbq2Tl7o0A:9 a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeDKOhc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 10:37:32 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49911 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeDKOha (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 10:37:30 -0400
X-IronPort-AV: E=Sophos;i="5.48,436,1517900400";
   d="scan'208";a="10967672"
From: <Nisar.Sayed@microchip.com>
To: <phil@raspberrypi.org>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <agraf@suse.de>,
        <tbogendoerfer@suse.de>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lan78xx: Don't reset the interface on open
Thread-Topic: [PATCH] lan78xx: Don't reset the interface on open
Thread-Index: AQHT0MYPbZtiT4HsgkyLpriGu/5z6qP6CNcQgAB83YCAARzYkA==
Date: Wed, 11 Apr 2018 14:37:29 +0000
Message-ID: <CE371C1263339941885964188A0225FA3A4C6F@CHN-SV-EXMX03.mchp-main.com>
References: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
 <CE371C1263339941885964188A0225FA3A3F82@CHN-SV-EXMX03.mchp-main.com>
 <dc7f30e2-624c-17d8-911b-d20ce96c2652@raspberrypi.org>
In-Reply-To: <dc7f30e2-624c-17d8-911b-d20ce96c2652@raspberrypi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUGhpbCwNCg0KPiBIaSBOaXNhciwNCj4gDQo+IE9uIDEwLzA0LzIwMTggMTU6MTYsIE5pc2Fy
LlNheWVkQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+ID4gVGhhbmtzIFBoaWwsIGZvciBpZGVudGlm
eWluZyB0aGUgaXNzdWVzLg0KPiA+DQo+ID4+IC0JcmV0ID0gbGFuNzh4eF9yZXNldChkZXYpOw0K
PiA+PiAtCWlmIChyZXQgPCAwKQ0KPiA+PiAtCQlnb3RvIGRvbmU7DQo+ID4+IC0NCj4gPj4gIAlw
aHlfc3RhcnQobmV0LT5waHlkZXYpOw0KPiA+Pg0KPiA+PiAgCW5ldGlmX2RiZyhkZXYsIGlmdXAs
IGRldi0+bmV0LCAicGh5IGluaXRpYWxpc2VkIHN1Y2Nlc3NmdWxseSIpOw0KPiA+PiAtLQ0KPiA+
DQo+ID4gWW91IG1heSBuZWVkIHRvIHN0YXJ0IHRoZSBpbnRlcnJ1cHRzIGJlZm9yZSAicGh5X3N0
YXJ0IiBpbnN0ZWFkIG9mDQo+IHN1cHByZXNzaW5nIGNhbGwgdG8gImxhbjc4eHhfcmVzZXQiLg0K
PiA+DQo+ID4gKyAgICAgICAgICAgICBpZiAoZGV2LT5kb21haW5fZGF0YS5waHlpcnEgPiAwKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBoeV9zdGFydF9pbnRlcnJ1cHRzKGRl
di0+bmV0LT5waHlkZXYpOw0KPiANCj4gU2hvdWxkbid0IHBoeV9jb25uZWN0X2RpcmVjdCwgY2Fs
bGVkIGZyb20gbGFuNzh4eF9waHlfaW5pdCwgYWxyZWFkeSBoYXZlDQo+IGVuYWJsZWQgaW50ZXJy
dXB0cyBmb3IgdXM/DQo+IA0KPiBUaGlzIHBhdGNoIGFkZHJlc3NlcyB0d28gcHJvYmxlbXMgLSB0
aW1lIHdhc3RlZCBieSByZW5lZ290aWF0aW5nIHRoZSBsaW5rDQo+IGFmdGVyIHRoZSByZXNldCBh
bmQgdGhlIG1pc3NlZCBpbnRlcnJ1cHQgLSBhbmQgSSdkIGxpa2UgYm90aCB0byBiZSBmaXhlZC4g
VW5sZXNzDQo+IHlvdSBjYW4gY29tZSB1cCB3aXRoIGEgZ29vZCByZWFzb24gZm9yIHBlcmZvcm1p
bmcgdGhlIHJlc2V0IGZyb20gdGhlIG9wZW4NCj4gaGFuZGxlciBJIHRoaW5rIGl0IHNob3VsZCBi
ZSByZW1vdmVkLg0KPiANCj4gUGhpbA0KDQpUaGFua3MsIHdlIGhhdmUgdmVyaWZpZWQgc3VzcGVj
dGVkIHRlc3QgY2FzZXMgYW5kIHRoZXNlIGFyZSBwYXNzZWQsIHRoZSBjaGFuZ2VzIGFyZSBnb29k
IHRvIGdvLg0KDQotIE5pc2FyDQo=
