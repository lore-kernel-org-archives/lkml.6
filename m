Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D18C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B20D22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B20D22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeKMDKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:10:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:37584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeKMDKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:10:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 09:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="107438438"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2018 09:16:22 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 12 Nov 2018 09:16:21 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.8]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 09:16:21 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Topic: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Index: AQHUeg5iQNe5nx4eb0uQcIEPT1lgyqVMYf6w
Date:   Mon, 12 Nov 2018 17:16:19 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB9FAB9@ORSMSX110.amr.corp.intel.com>
References: <20181111221647.665769131@linuxfoundation.org>
 <20181111221648.772697504@linuxfoundation.org>
In-Reply-To: <20181111221648.772697504@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdyZWcgS3JvYWgtSGFydG1h
biBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPiBTZW50OiBTdW5kYXksIE5v
dmVtYmVyIDExLCAyMDE4IDI6MjIgUE0NCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
Ow0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBKZWFuLU1hcmMgTGVub2lyIDxhcmNobGludXhA
amloZW1lbC5jb20+Ow0KPiBTY2htYXVzcywgRXJpayA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+
OyBXeXNvY2tpLCBSYWZhZWwgSg0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCA0LjE0IDAwOS8yMjJdIEFDUElDQTogQU1MIGludGVycHJldGVyOiBhZGQg
cmVnaW9uDQo+IGFkZHJlc3NlcyBpbiBnbG9iYWwgbGlzdCBkdXJpbmcgaW5pdGlhbGl6YXRpb24N
Cj4gDQpIaSBHcmVnLA0KDQo+IDQuMTQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBo
YXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KVGhpcyBwYXRjaCBpcyBv
bmx5IG1lYW50IHRvIGJlIGFkZGVkIGZvciBrZXJuZWxzIHRoYXQgYXJlIDQuMTcgb3IgbGF0ZXIu
DQoNClBsZWFzZSBkcm9wIHRoaXMgZnJvbSBrZXJuZWwgNC4xNiBvciBvbGRlci4NCg0KVGhhbmtz
LA0KRXJpaw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBGcm9tOiBFcmlrIFNjaG1h
dXNzIDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4NCj4gDQo+IGNvbW1pdCA0YWJiOTUxYjczZmYw
YThhOTc5MTEzZWYxODU2NTFhYTNjOGRhMTliIHVwc3RyZWFtLg0KPiANCj4gVGhlIHRhYmxlIGxv
YWQgcHJvY2VzcyBvbWl0dGVkIGFkZGluZyB0aGUgb3BlcmF0aW9uIHJlZ2lvbiBhZGRyZXNzIHJh
bmdlIHRvDQo+IHRoZSBnbG9iYWwgbGlzdC4gVGhpcyBvbWlzc2lvbiBpcyBwcm9ibGVtYXRpYyBi
ZWNhdXNlIHRoZSBPUyBxdWVyaWVzIHRoZSBnbG9iYWwNCj4gbGlzdCB0byBjaGVjayBmb3IgYWRk
cmVzcyByYW5nZSBjb25mbGljdHMgYmVmb3JlIGRlY2lkaW5nIHdoaWNoIGRyaXZlcnMgdG8gbG9h
ZC4NCj4gVGhpcyBjb21taXQgbWF5IHJlc3VsdCBpbiB3YXJuaW5nIG1lc3NhZ2VzIHRoYXQgbG9v
ayBsaWtlIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBbICAgIDcuODcxNzYxXSBBQ1BJIFdhcm5pbmc6
IHN5c3RlbV9JTyByYW5nZSAweDAwMDAwNDI4LTB4MDAwMDA0MkYNCj4gY29uZmxpY3RzIHdpdGgg
b3BfcmVnaW9uIDB4MDAwMDA0MDAtMHgwMDAwMDQ3RiAoXFBNSU8pDQo+ICgyMDE4MDUzMS91dGFk
ZHJlc3MtMjEzKQ0KPiBbICAgIDcuODcxNzY5XSBBQ1BJOiBJZiBhbiBBQ1BJIGRyaXZlciBpcyBh
dmFpbGFibGUgZm9yIHRoaXMgZGV2aWNlLCB5b3Ugc2hvdWxkIHVzZQ0KPiBpdCBpbnN0ZWFkIG9m
IHRoZSBuYXRpdmUgZHJpdmVyDQo+IA0KPiBIb3dldmVyLCB0aGVzZSBtZXNzYWdlcyBkbyBub3Qg
c2lnbmlmeSByZWdyZXNzaW9ucy4gSXQgaXMgYSByZXN1bHQgb2YgcHJvcGVybHkNCj4gYWRkaW5n
IGFkZHJlc3MgcmFuZ2VzIHdpdGhpbiB0aGUgZ2xvYmFsIGFkZHJlc3MgbGlzdC4NCj4gDQo+IExp
bms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwMDExDQo+
IFRlc3RlZC1ieTogSmVhbi1NYXJjIExlbm9pciA8YXJjaGxpbnV4QGppaGVtZWwuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBFcmlrIFNjaG1hdXNzIDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4NCj4g
Q2M6IEFsbCBhcHBsaWNhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IA0KPiAtLS0NCj4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvZHNvcGNvZGUuYyB8ICAgIDQg
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gLS0tIGEvZHJp
dmVycy9hY3BpL2FjcGljYS9kc29wY29kZS5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
ZHNvcGNvZGUuYw0KPiBAQCAtNDUxLDYgKzQ1MSwxMCBAQCBhY3BpX2RzX2V2YWxfcmVnaW9uX29w
ZXJhbmRzKHN0cnVjdCBhY3BpDQo+ICAJCQkgIEFDUElfRk9STUFUX1VJTlQ2NChvYmpfZGVzYy0+
cmVnaW9uLmFkZHJlc3MpLA0KPiAgCQkJICBvYmpfZGVzYy0+cmVnaW9uLmxlbmd0aCkpOw0KPiAN
Cj4gKwlzdGF0dXMgPSBhY3BpX3V0X2FkZF9hZGRyZXNzX3JhbmdlKG9ial9kZXNjLT5yZWdpb24u
c3BhY2VfaWQsDQo+ICsJCQkJCSAgIG9ial9kZXNjLT5yZWdpb24uYWRkcmVzcywNCj4gKwkJCQkJ
ICAgb2JqX2Rlc2MtPnJlZ2lvbi5sZW5ndGgsIG5vZGUpOw0KPiArDQo+ICAJLyogTm93IHRoZSBh
ZGRyZXNzIGFuZCBsZW5ndGggYXJlIHZhbGlkIGZvciB0aGlzIG9wcmVnaW9uICovDQo+IA0KPiAg
CW9ial9kZXNjLT5yZWdpb24uZmxhZ3MgfD0gQU9QT0JKX0RBVEFfVkFMSUQ7DQo+IA0KDQo=
