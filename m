Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B69C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458D72081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfBFPbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:31:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:27202 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbfBFPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:31:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 07:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="131545108"
Received: from pgsmsx103.gar.corp.intel.com ([10.221.44.82])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2019 07:31:37 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.99]) by
 PGSMSX103.gar.corp.intel.com ([169.254.2.6]) with mapi id 14.03.0415.000;
 Wed, 6 Feb 2019 23:31:36 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUu4AgquesjEnW50+dl61NWIyu6qXRNN0AgAEpl4CAAAaDgA==
Date:   Wed, 6 Feb 2019 15:31:36 +0000
Message-ID: <9fbbe4fa9aa0e202909c2ba6eefdb22ef4f2b1d8.camel@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
         <20190205212308.GA2816@amd>
         <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
In-Reply-To: <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.140.202]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC97EFEE5D6FC4BA5E20208FC9A1C00@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgYmFja2Ryb3AgaXMgc29tZSBzdHJlc3MgdGVzdCBzY3JpcHQgb2Ygc3VzcGVuZC9yZXN1
bWUsIGxpa2UNCj4gQ2hyb21lDQo+IE9TLCBpcyBkZXNpZ25lZCB0byBwcm9ncmFtIGFuIGV4cGVj
dGVkIFJUQyB3YWtlLWFsYXJtIHRoZW4gaXNzdWUNCj4gc3VzcGVuZCBjb21tYW5kLCB3aGlsZSBp
biByYXJlIGNhc2UgKG9yIGJ1Z2d5IHNvZnR3YXJlKSwgdGhlDQo+IGZpbGVzeXN0ZW0NCj4gc3lu
YyBjb3VsZCBjb3N0IGxvbmdlciB0aW1lIGluIHNlY29uZHMsIHRoaXMgY29uc3VtZXMgdGhlIGFs
YXJtDQo+IGJ1ZGdldA0KPiBjYXVzZXMgc3VzcGVuZCBhYm9ydGluZywgaXQgY291bGQgYmUgYWJz
dHJ1c2UgdG8gcHJvZHVjdGlvbiBsaW5lDQo+IGRldmVsb3BlcnMgdG8gcmVhbGl6ZSBpdCBpcyBu
b3QgYSBwbGF0Zm9ybSBpc3N1ZSBpbiB0ZXJtcyBvZiBkcml2ZXJzDQo+IHN1c3BlbmRpbmc7IGdp
dmVuIGEgc3VjaCBtZXRyaWMgbWlnaHQgbWFrZSB0aGUgY29tbXVuaWNhdGlvbiBlYXNpZXIsDQo+
IHRoaXMgaXMgbXkgaW50dWl0aW9uLg0KPiANCmFwb2xvZ2l6ZSByZXBocmFzZTogbXkgaW50dWl0
aW9uIC0+IG15IG1vdGl2YXRpb24NCg==
