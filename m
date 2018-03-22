Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2417028-1521714474-2-9942586839196651886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521714473; b=E+ckJbY5SHQQwpzVlsa28X1p7hkKQN+KPvhg1QLYwgfCioL
    hwzSYOj5/dAj+LIC4TxPGAZrNDGlMuJupEfMjavyaZt9i3s9xODYRVG1Y34Muz2W
    aZCcussSsmO2/KWl3PrnAQXLKmoEB9Q19IMAtdlnkSK0oHpijV6o+fBMNzXrG88A
    LBDGfq7KNhVYp81ccZ8pSO7kVxvWg+HHb6YHeRo/zSYTz/WWeC+FaHXMgV7/3QQK
    fmex3adr5qblklWPyNIFs/vrkJ08WkZimZFDNSjBod9bACk2yeS2cefVmeRfWY+t
    befjifpSS1uACXuSQxtIyh88KmlnlxvGo8/EBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521714473; bh=KAiKOh
    jY6i9GLA9V00171utK7iMbLneiD1x5pkRc0Mk=; b=tVHwqbDJ5sNWKLE2uWuc+4
    v44TTjt6r62snJkYd5CLuuuUVOT9qONfgUeJWpTJ37e9efEyxDdo+2+QCnZjozr4
    hF0Se5tcEDyfAYAej7E/ANsalQX1TZ+xJkQWbc6+vfYVhgpeVfnW1/+1T0/R5T2p
    UHY2CZVosn9HdMvqYv6TisKalEskj992yyhSAAE2RQR3OzAtSmSoiKoSI2c6X380
    EkagXobDdyDx7hH3ShPsqY9DuRiDdnvrM9+eRVy3i4PTI251ufydat4RV6tNZnIX
    B+X0qIXySPCV0PwyRX2Dwd/FHvjkcgw/+89h10CAL0USRhUDCb99ihnPDlsRFePw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeCVK1n (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 06:27:43 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:53635 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751964AbeCVK1l (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 06:27:41 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUgTYQDH99zdtpts9TiVPa3sZRCZ4FtWXlL
  ot1ZEKIHJPlRnXW60TdnNmp+apoaGZhiF5korBTUzp+GmkWKSaVqgaaGglma+rzI0Ma2dl2nf
  fnf/l+cPz0Pi8nGhkmQsZsZkpPUqkQdxylkSGqBMr9EEP7Vtoa48qBJRU623MSqrwklQvS+zM
  aq7vlBEzWa3AOp+aTpOjRR3YNTrBnOkRG0vzxSp77ZFqxttj8Tq6hkHpnY97xGpnfNWsXrWvj
  VKrBHqjHEJljNCra26B0uckFpSv1SKrOCdNAtISDksAajdinEsghTKezUkygIepDcsxdDAzOj
  KBw4nAaq7ugg4lxc8iVr751YS3jAWNaYtCXkOR2W2NoJjAu5Es8MpYo5lMAq9cGWvFMlhH0CO
  aZc7QJISGImm32s5D4C+6EdKBc4xDhWob+TeSj+CED189hbn2QeNDy8Led6G6uYWxTxHoMmBG
  YKrRDAI5aSw/O8QVH6rieA5DF2vceCcBYe7UVV9EH/SDnTz2se/Kz1RW/4IkQsUBetGFKwlCt
  YlCtYligBRDvxYxnSRMQXs2R8YZ9LFa80GWqcPCAneF2hgWJaOZ/R0HBt4NsFgB+4LvywQAAf
  ozzveDDaRmMpH9n3MrpFviEs4l6ylWe1pU5KeYZvBFpJUIZk4rUYj9zQx8YzlvE7vfjWrMiKl
  Km+ZhJNlbCJtYHXxvNQOQskPY5MZOFlbOpWBywljgpFRKmTbOSvkrNok47+i1RfYBXyVXjIgE
  Ajk0kTGZNCZ/9cngIIEKi++Raozmv+dN+GegrmnXMh/wk0x02uS0gpgeerX+YzB2cdZd77tKt
  6bF3Tw85GM5cLO5KXM0ehU26/NZWkzhX4RRUdBWFRMWK/PoW0Ng0HOS13hTVPsQmzfnRKFNuk
  EZMzLPa7DtbjkzcCNn53HLAO5C/fSQ2P14/V45TyR3DL8tDDHnrqxO+aAq2PohgaHn4p/W/13
  lcwHqAhWS4f44yaW/gNlOCSHfAMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-8.tower-179.messagelabs.com!1521714457!98431566!2
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v5 3/5] power: supply: Add 'usb_type' property and
 supporting code
Thread-Topic: [PATCH v5 3/5] power: supply: Add 'usb_type' property and
 supporting code
Thread-Index: AQHTwFh0LGgLOsq6SU2G4xwbgVI9fqPbpfcAgABp1hA=
Date: Thu, 22 Mar 2018 10:27:37 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E2892@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <3774272cd49908e88b56a1c4bbf3b363b851ebdd.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <225f9a2f-48cc-e6e4-1240-28507f7b3ab7@roeck-us.net>
In-Reply-To: <225f9a2f-48cc-e6e4-1240-28507f7b3ab7@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 22/03/2018 04:27:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMjIgTWFyY2ggMjAxOCAwNDowOCwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgc3NpemVfdCBwb3dlcl9zdXBwbHlfc2hvd191c2JfdHlwZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4gKwkJCQkJICBlbnVtIHBvd2VyX3N1cHBseV91c2JfdHlwZQ0KPiAqdXNiX3R5cGVzLA0K
PiA+ICsJCQkJCSAgc3NpemVfdCBudW1fdXNiX3R5cGVzLA0KPiA+ICsJCQkJCSAgdW5pb24gcG93
ZXJfc3VwcGx5X3Byb3B2YWwgKnZhbHVlLA0KPiA+ICsJCQkJCSAgY2hhciAqYnVmKQ0KPiA+ICt7
DQo+ID4gKwllbnVtIHBvd2VyX3N1cHBseV91c2JfdHlwZSB1c2JfdHlwZTsNCj4gPiArCXNzaXpl
X3QgY291bnQgPSAwOw0KPiA+ICsJYm9vbCBtYXRjaCA9IGZhbHNlOw0KPiA+ICsJaW50IGk7DQo+
ID4gKw0KPiA+ICsJaWYgKCghdXNiX3R5cGVzKSB8fCAobnVtX3VzYl90eXBlcyA8PSAwKSkgew0K
Pg0KPiBVbm5lY2Vzc2FyeSAoICkNCg0KRmluZSwgY2FuIHJlbW92ZS4NCg0KPg0KPiA+ICsJCWRl
dl93YXJuKGRldiwgImRyaXZlciBoYXMgbm8gdmFsaWQgY29ubmVjdGVkIHR5cGVzXG4iKTsNCj4N
Cj4gQXJlIHRob3NlIHdhcm5pbmdzIHVzZWZ1bCBvciBkbyB0aGV5IGp1c3QgY2xvZyB0aGUgbG9n
ID8gRWl0aGVyIGNhc2UsIGlmIHRoYXQgaGFwcGVucywNCj4gd291bGRuJ3QgaXQgYmUgYmV0dGVy
IHRvIGRldGVjdCB0aGUgc2l0dWF0aW9uIGR1cmluZyByZWdpc3RyYXRpb24gYW5kIGFib3J0ID8N
Cg0KVGhpcyBpcyBhZGRlZCBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSBmb3Igc3VwcGx5IGRyaXZl
cnMuIFRoaXMgd2lsbCBvbmx5IHNob3cNCnVwIGlmIGEgc3VwcGx5IGRyaXZlciBhZGRzIHRoZSBV
U0JfVFlQRSBwcm9wZXJ0eSB0byBpdHMgbGlzdCwgYW5kIHRoZW4gc29tZW9uZQ0KYXR0ZW1wdHMg
dG8gYWNjZXNzIGl0LiBBY3R1YWxseSB0aGVyZSdzIG5vIGN1cnJlbnQgY2hlY2tpbmcgZm9yIHRo
ZSBwc3lfZGVzYw0KaW5mb3JtYXRpb24gcHJvdmlkZWQgdG8gdGhlIHJlZ2lzdGVyIGZ1bmN0aW9u
LCBzbyBmb3IgZXhhbXBsZSBpZiBpdCdzIE5VTEwgdGhlbg0KdGhlIGtlcm5lbCB3aWxsIGR1bXAg
d2hlbiBpdCB0cmllcyB0byBkZXJlZmVyZW5jZS4gSSdsbCB0YWtlIGEgbG9vayBhdCB0aGlzIGFu
ZA0Kc2VlIGlmIEkgY2FuIGFkZCBzb21ldGhpbmcsIGluY2x1ZGluZyBjaGVja3Mgb24gdGhlIHVz
Yl90eXBlIHByb3BlcnR5Lg0K
