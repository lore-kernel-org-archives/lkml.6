Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301CC218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfADQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:52:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:64200 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfADQwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:52:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 08:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="114175906"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2019 08:52:08 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 08:52:06 -0800
Received: from bgsmsx152.gar.corp.intel.com (10.224.48.50) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 08:52:06 -0800
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.240]) by
 BGSMSX152.gar.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0415.000;
 Fri, 4 Jan 2019 22:22:04 +0530
From:   "Gopal, Saranya" <saranya.gopal@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Con Kolivas <kernel@kolivas.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
Subject: RE: [alsa-devel] ALSA:usb audio Higher sample rates on usb audio no
 longer working.
Thread-Topic: [alsa-devel] ALSA:usb audio Higher sample rates on usb audio
 no longer working.
Thread-Index: AQHUo7pxjIzhAGqnWUqc3nAThcUfcKWeSWaAgACV4ACAAGdFAA==
Date:   Fri, 4 Jan 2019 16:52:03 +0000
Message-ID: <C672AA6DAAC36042A98BAD0B0B25BDA94CB021CE@BGSMSX104.gar.corp.intel.com>
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de>
 <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <s5hd0pdey4e.wl-tiwai@suse.de>
 <5c7b2c6b-5dcc-7170-f6e1-bf6021bbb72a@linux.intel.com>
In-Reply-To: <5c7b2c6b-5dcc-7170-f6e1-bf6021bbb72a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDBkYWFiYjItZGU1ZS00OGI4LTlhNjAtZGQyZDlhZmMyZDg5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieW13V1h5RlhLdk5NTHJTTFBweHQ1aTBiSkNySkRSbnhRUnFTd3dYakhGVkdiODBFTEhlZ2h0YlwveVwvaGNSSERhIn0=
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFsgQWRkaW5nIGxpbnV4LXVzYiBNTCB0byBDYywgYXMgaXQncyBhIGNvcmUgVVNCIGlzc3Vl
IF0NCj4gPg0KPiA+IFNvIHRoZSBkZXZpY2Ugc2VlbXMgaW5jb3JyZWN0bHkgYWR2ZXJ0aXNpbmcg
YXMgaWYgaXQgd2VyZSBzdXBwb3J0aW5nDQo+ID4gVUFDMyAtLSBhc3N1bWluZyB0aGUgZGV2aWNl
IGlzIHN0aWxsIG5vdCBVQUMzLWNhcGFibGUuDQo+ID4NCj4gPiBJT1csIGl0J3MgYSBidWdneSBm
aXJtd2FyZS4gIFdlIG5lZWQgc29tZSBibGFja2xpc3RpbmcsIG9yIHJldmVydCB0aGUNCj4gPiBj
b21taXQgZm9yIG5vdywgdW5sZXNzIGFueSByZWFsIFVBQzMgZGV2aWNlIGNvbWVzIHVwIHRvIHRo
ZSBtYXJrZXQuDQo+IA0KPiBJSVJDIGFuIFVBQzMtY2FwYWJsZSBkZXZpY2UgaXMgcmVxdWlyZWQg
dG8gZXhwb3NlIGEgYmFja3dhcmRzLWNvbXBhdGlibGUNCj4gY29uZmlndXJhdGlvbiAoZWl0aGVy
IFVBQzEgb3IgVUFDMikuIE1heWJlIGFuIGFkZGl0aW9uYWwgdGVzdCBjYW4gYmUNCj4gZG9uZSB0
byBoYXJkZW4gdGhlIGRldGVjdGlvbiBzbyB0aGF0IFVBQzMgaXMgb25seSBjaG9zZW4gaWYgaW5k
ZWVkIGENCj4gc2Vjb25kIGF1ZGlvIGNvbmZpZ3VyYXRpb24gaXMgcHJlc2VudCBhcyB3ZWxsLg0K
PiANCj4gSSBhbHNvIHZhZ3VlbHkgcmVjYWxsIHRoZXJlIHdhcyB0YWxrIGFib3V0IGFkZGluZyBp
bmZvcm1hdGlvbiBpbiB0aGUgQk9TDQo+IGRlc2NyaXB0b3IsIGJ1dCBJIGRvbid0IGtub3cgaWYg
dGhpcyB3YXMgZXZlciBwdWJsaXNoZWQuDQo+IA0KPiAtUGllcnJlDQoNClRoZSBjdXJyZW50IGRl
dGVjdGlvbiBsb2dpYyBpcyB0aGF0IFVBQzMgY29uZmlndXJhdGlvbiBpcyBjaG9zZW4gb25seSB3
aGVuIGEgZGV2aWNlIGhhcyBhIGNvbmZpZ3VyYXRpb24gd2l0aCBhdWRpbyBpbnRlcmZhY2Ugc3Vw
cG9ydGluZyBVQUMzIHByb3RvY29sLg0KQWRkaXRpb25hbGx5LCBpdCBhbHJlYWR5IG1ha2VzIHN1
cmUgdGhhdCBVQUMzIGlzIHNlbGVjdGVkIG9ubHkgd2hlbiB0aGVyZSBpcyBtb3JlIHRoYW4gb25l
IGNvbmZpZ3VyYXRpb24uDQpPdGhlcndpc2UsIHRoZSBmaXJzdCBjb25maWd1cmF0aW9uIGlzIGNo
b3NlbiBieSBkZWZhdWx0LiBTbywgdGhlIHBhdGNoIGRvZXMgbm90IGFmZmVjdCBleGlzdGluZyBV
QUMxIGFuZCBVQUMyIGRldmljZXMuDQpBcyBJd2FpIHNhaWQsIHRoaXMgaXNzdWUgc2VlbXMgdG8g
YmUgYmVjYXVzZSBvZiBhIGJ1Z2d5IGZpcm13YXJlIHdoaWNoIHdyb25nbHkgYWR2ZXJ0aXNlcyBV
QUMzLWNhcGFiaWxpdHkuDQpDb3VsZCB3ZSBhZGQgc29tZSBxdWlyayB0byBzZWxlY3QgYW5vdGhl
ciBjb25maWd1cmF0aW9uIGZvciB0aGlzIHBhcnRpY3VsYXIgZGV2aWNlPw0KSSBzZWUgdGhhdCB0
aGVyZSBpcyBhIHNpbWlsYXIgaW4gcXVpcmsgaW4gc291bmQvdXNiL3F1aXJrcy5jIChzbmRfdXNi
X2Zhc3R0cmFja3Byb19ib290X3F1aXJrKSAuDQpDb3VsZCBzb21ldGhpbmcgbGlrZSB0aGF0IGJl
IGRvbmUgZm9yIHRoaXMgcGFydGljdWxhciBkZXZpY2U/DQoNCkFuZCBzaW5jZSBJIHdhcyBub3Qg
cGFydCBvZiB0aGUgaW5pdGlhbCBtYWlsIHRocmVhZCwgSSBtaWdodCBoYXZlIG1pc3NlZCBzb21l
IGluZm9ybWF0aW9uLg0KQ291bGQgc29tZW9uZSBnaXZlIG1lIGxzdXNiIC12IG91dHB1dCBmb3Ig
dGhpcyBVU0IgYXVkaW8gZGV2aWNlLg0KDQpUaGFua3MsDQpTYXJhbnlhDQoNCg0K
