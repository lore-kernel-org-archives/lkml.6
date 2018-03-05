Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2082923-1520268840-2-8298983520107091573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520268839; b=KrHBYyEoeDSWYWLG0ehOxrPCgqEykpbTRAU37VuBKt8YScy
    a9ft51kfx5kMGRlScnu50RnTACc3Cy/e9PclUHCuGa8uyRxKBlA/nrRlIKaBnG3M
    35tRzvmrYOwYzdy+V48iW8nlw+9AXzJtRhok/aKd68uHVxfUropa8qcu8OGi3U4+
    IxvlbGpQN1RWjzPniFsge2Ifh9129UsoWS+GGe3U1Ey1kM/Qwc8VMx4Htvcom8nG
    xtcYZ00jVVKwp+Wkb5rmp4qqdQ90JLYWtCj9HOh+8Mr7fM6HCRwb5dgwCBoc4aA5
    2jXUTu7diAUzPYXHosZd5qNSKGAC3dpzudlPosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520268839; bh=A4T2a1aIyl/cve3d6Agd4fVRgP2ob5qjjV/Cnc
    St760=; b=TyK+MhaoDvbM9pt4qneCAWoROhLjbThe33bqpRwPxN/yqtaPkzMDLo
    45+FGztO3UUyUJLWpJW6WgGlf4UgRdbr86HZC3N9ulW/TSuzEIdSffqtW1fUND0l
    WsvYOkLHb/IBOWKtX+YYJbr8u0NvpjRW7pV5FIGbFPVTdLIIfQHm8uCs8BreqnKe
    /nYs6doHtmy1bP2R1oLJPiZ5OmTH3Z+sTo6Ni3OaTflGl0MDgG9lrb4j+NenlChY
    V6qx+3u+hY2rcO1UfGHdq5cvYyosVgZsRqRhgyZ/siMt0CTh83QbHtIIUgUULi2u
    DkHupo4GPbqa09/2j8X/iqnRQvthxC9Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeCEQx6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 11:53:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeCEQx4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 11:53:56 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi
 boards
Thread-Topic: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi
 boards
Thread-Index: AQHTtJLAbEOSjWW+hkKIAq+fErvZYaPBszcAgAAX0YA=
Date: Mon, 5 Mar 2018 16:53:23 +0000
Message-ID: <4bf43157-9214-c160-3f69-1e56f8cfdf98@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
 <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
 <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
In-Reply-To: <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A1A3AD27E1B9A4CAF36F84D026FB51B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_07:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUm9iDQoNCk9uIDAzLzA1LzIwMTggMDQ6MjggUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBP
biBNb24sIE1hciA1LCAyMDE4IGF0IDk6MDAgQU0sICA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4g
d3JvdGU6DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+Pg0KPj4gU2luY2UgZHRjIHYxLjQuNi05LWdhYWRkMGI2NWM5ODcsIGFsaWFzZXMgcHJvcGVy
dHkgbmFtZSBtdXN0DQo+PiBiZSBsb3dlcmNhc2Ugb25seS4NCj4+IFRoaXMgYWxsb3dzIHRvIGZp
eCBmb2xsb3dpbmcgd2FybmluZ3Mgd2hlbiBjb21waWxpbmcgZHRiDQo+PiB3aXRoIFc9MSBvcHRp
b24gOg0KPiANCj4gSSdtIHNvIGdsYWQgdG8gc2VlIGZpeGVzIGJlZm9yZSB0aGUgZHRjIHVwZGF0
ZSBsYW5kZWQgaW4gdGhlIGtlcm5lbCB0cmVlIQ0KDQo7LSkNCg0KPiANCj4+IGFyY2gvYXJtL2Jv
b3QvZHRzL3N0aWg0MTgtYjIxOTkuZHRiOiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2Vz
OiBhbGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAn
LScNCj4+IGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRiOiBXYXJuaW5nIChhbGlh
c19wYXRocyk6IC9hbGlhc2VzOiBhbGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9u
bHkgbG93ZXJjYXNlIGFuZCAnLScNCj4+IGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAu
ZHRiOiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2VzOiBhbGlhc2VzIHByb3BlcnR5IG5h
bWUgbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScNCj4+IGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N0aWg0MTAtYjIxMjAuZHRiOiBXYXJuaW5nIChhbGlhc19wYXRocyk6IC9hbGlhc2VzOiBh
bGlhc2VzIHByb3BlcnR5IG5hbWUgbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBz
dC5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1iMjEyMC5kdHMg
fCA0ICsrLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1iMjEyMC5kdHMgfCA0ICsr
LS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1iMjI2MC5kdHMgfCA0ICsrLS0NCj4+
ICAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxOC1iMjE5OS5kdHMgfCA0ICsrLS0NCj4+ICAgNCBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvc3RpaDQwNy1iMjEyMC5kdHMNCj4+IGluZGV4IGM4YWQ5MDVkMDMwOS4uZmExMTg2
YWY2NTc0IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1iMjEyMC5k
dHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzDQo+PiBAQCAt
MTQsNyArMTQsNyBAQA0KPj4gICAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxzdGloNDA3LWIyMTIw
IiwgInN0LHN0aWg0MDciOw0KPj4NCj4+ICAgICAgICAgIGNob3NlbiB7DQo+PiAtICAgICAgICAg
ICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT10dHlBUzAsMTE1MjAwIGNsa19pZ25vcmVfdW51c2Vk
IjsNCj4+ICsgICAgICAgICAgICAgICBib290YXJncyA9ICJjb25zb2xlPXR0eWFzMCwxMTUyMDAg
Y2xrX2lnbm9yZV91bnVzZWQiOw0KPiANCj4gVGhlIGtlcm5lbCBjaGFuZ2UgZm9yIHRoaXMgaXMg
YW4gQUJJIGJyZWFrYWdlIGJvdGggRFQgPC0+IGtlcm5lbCBhbmQNCj4ga2VybmVsIDwtPiB1c2Vy
c3BhY2UuDQo+IA0KPiBSZWFsbHksIGlmIHlvdSBhcmUgb2theSB3aXRoIGRvaW5nIHRoaXMsIHlv
dSBzaG91bGQgY2hhbmdlIGl0IHRvIHR0eVN4IElNTy4NCg0KT0sgaSB3aWxsIHVzZSBzZXJpYWxO
IGluc3RlYWQNCg0KPiANCj4+ICAgICAgICAgICAgICAgICAgbGludXgsc3Rkb3V0LXBhdGggPSAm
c2JjX3NlcmlhbDA7DQo+IA0KPiBBbmQgc2luY2UgeW91IGhhdmUgdGhpcywgeW91IGRvbid0IGV2
ZW4gbmVlZCB0aGUgY29uc29sZSBwcmFyYW0uDQoNCk9rLCBpIHdpbGwgcmVtb3ZlIHN0ZG91dC1w
YXRoIGluIGFuIGFkZGl0aW9uYWwgcGF0Y2gNCg0KPiANCj4+ICAgICAgICAgIH07DQo+Pg0KPj4g
QEAgLTI0LDcgKzI0LDcgQEANCj4+ICAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICAgYWxpYXNl
cyB7DQo+PiAtICAgICAgICAgICAgICAgdHR5QVMwID0gJnNiY19zZXJpYWwwOw0KPj4gKyAgICAg
ICAgICAgICAgIHR0eWFzMCA9ICZzYmNfc2VyaWFsMDsNCj4gDQo+IFRoZSBjb3JyZWN0IGZpeCBp
cyB1c2UgInNlcmlhbE4iIGZvciBhbGlhc2VzLg0KDQpPaw0KDQo+IA0KPiBJIGhhdmUgYSBjaGVj
ayBmb3Igb25seSBrbm93biBhbGlhcyBuYW1lcyB3aGljaCB3b3VsZCBnaXZlIGEgYmV0dGVyDQo+
IHdhcm5pbmcsIGJ1dCBEYXZpZCB0aG91Z2h0IGl0IHdhcyB0b28gcmVzdHJpY3RpdmUuDQo+IA0K
Pj4gICAgICAgICAgICAgICAgICBldGhlcm5ldDAgPSAmZXRoZXJuZXQwOw0KPj4gICAgICAgICAg
fTsNCj4+DQoNCg0KVGhhbmtzDQoNClBhdHJpY2U=
