Return-Path: <kevin.tian@intel.com>
X-Google-Smtp-Source: AB8JxZrliU3HJPsk1cTDHla6SL+dALVOpgNjhC5sLw3CB3yENAHNqeyJ3sqW/CWAqmjo4DcFrGqW
ARC-Seal: i=1; a=rsa-sha256; t=1524883275; cv=none;
        d=google.com; s=arc-20160816;
        b=bbtEUbq5bk1m8fxYeT2cbVarJ3+lVK9Pq5oqty1S9pVueji+TrhoztFr2qvVyJAASC
         jeeLS+3rVJm6Sr/ThD5P/ny6B3ya20iO9YKKBOxuyG0J330WRtF0Za2l0r2bSK3DZ/xY
         ZuQs2piszFpjv9fCltzkF6ZnOz9w8IvKKvmDj44zusfb8127riiTfIvdveFekGOW41nR
         rDMt4ypV+aWDEa9NAm87WhodIQGU1ngQKP6IXfcr5DTD3q3e11+bBm8o+6d/YgPdtECl
         GynU1X0Hr3ayy2Wb3GDWwS2HXMdyRyEWusWuKB2acSlzBRVMArbwpxt7GyDzoAGZqgIG
         4mgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=bEb/vWvw7dQxxVTydf06VyMnOg3Tq8M2JH7m+ThjBIY=;
        b=E1ANUgMaJq4qsUUaqzQR+QzSyDtLzFWzStBCL1WLBwZ9/yIaMTtFujzs+EE3aZTN93
         WVyIcVsL9sAhVrV5chxPc14seTMTLydd+sPIstk5TDdnHILUhk5ANRlnONizcJ6sgy04
         YT6X7P2Pbe0c5Amwupfyfxrg6GlBr+A9Q3jLcNQ/pUK4apTykdQA8z2NPw8m2hWeLZYJ
         nC76Ai2Ugxkr9g26QeolX/yaZHu5L/yoHGgZ4zcAhTjVMp60SPA8CN1K9jV+C0irLl7U
         DKI20c+TTkmyTtrig1V6gJxNec9nGjq8bovXFJ5Mq+0UaH/SH68L5avEQo8UlS4X5ZcW
         auWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kevin.tian@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=kevin.tian@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kevin.tian@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=kevin.tian@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,337,1520924400";
   d="scan'208";a="224026882"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare
	<khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>,
	"Liu@ostrya.localdomain" <Liu@ostrya.localdomain>
Subject: RE: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Thread-Topic: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Thread-Index: AQHT1cxrLYSb+FbfgUGQMGzMISYt+aQJdqYAgATfGICABh3TgIABEUxw
Date: Sat, 28 Apr 2018 02:41:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19113D5F3@SHSMSX101.ccr.corp.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180420181951.GA50099@ostrya.localdomain>
 <20180423134325.6780f6ac@jacob-builder>
 <72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
In-Reply-To: <72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTI3YmExZTYtMWFhMS00OTM1LWI0YWEtMzE3MmUxZTA5NWM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Imd5bXZuc3RmSjdBeVArVzRUODlzS2FtOHNvZ2ZpR2grSTA4cFdQS1kxMjg9In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1598956005240418720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogU2F0dXJkYXksIEFwcmlsIDI4LCAyMDE4IDI6MDggQU0NCj4g
DQo+IFsuLi5dDQo+ID4+IElmIHRoaXMgY29ycmVzcG9uZHMgdG8gUUlfR1JBTl9BTExfQUxMIGlu
IHBhdGNoIDksIHRoZSBjb21tZW50IHNob3VsZA0KPiA+PiBiZSAiQ2FjaGUgb2YgYWxsIFBBU0lE
cyI/IE9yIG1heWJlICJhbGwgZW50cmllcyBmb3IgYWxsIFBBU0lEcyI/IElzIGl0DQo+ID4+IGRp
ZmZlcmVudCBmcm9tIEdSQU5VX0RPTUFJTiB0aGVuPw0KPiA+IFFJX0dSQU5fQUxMX0FMTCBtYXBz
IHRvIFZULWQgc3BlYyA2LjUuMi40LCB3aGljaCBpbnZhbGlkYXRlcyBhbGwgZXh0DQo+ID4gVExC
IGNhY2hlIHdpdGhpbiBhIGRvbWFpbi4gSXQgY291bGQgcmV1c2UgR1JBTlVfRE9NQUlOIGJ1dCBJ
IHdhcw0KPiA+IGFsc28gdHJ5aW5nIHRvIG1hdGNoIHRoZSBuYW1pbmcgY29udmVudGlvbiBpbiB0
aGUgc3BlYy4NCj4gDQo+IFNvcnJ5IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIFRMQiBhbmQgZXh0IFRMQg0KPiBpbnZhbGlkYXRpb24uIENhbiBhbiBleHQg
VExCIGludmFsaWRhdGlvbiBkbyBldmVyeXRoaW5nIGEgVExCIGNhbiBkbw0KPiBwbHVzIHNvbWUg
YWRkaXRpb25hbCBwYXJhbWV0ZXJzIChpbnRyb2R1Y2VkIGluIG1vcmUgcmVjZW50IHZlcnNpb24g
b2YNCj4gdGhlIHNwZWMpLCBvciBkbyB0aGV5IGhhdmUgZGlzdGluY3QgcHVycG9zZXM/IEknbSB0
cnlpbmcgdG8gdW5kZXJzdGFuZA0KPiB3aHkgaXQgbmVlZHMgdG8gYmUgdXNlci12aXNpYmxlDQoN
CmRpc3RpbmN0IHB1cnBvc2UgdGhvdWdoIHNvbWUgb3ZlcmxhcHBlZCBlZmZlY3Q6DQoNCklPVExC
IGludmFsaWRhdGUgaXMgbW9yZSBmb3IgMm5kLWxldmVsIGNhY2hlIG9uIGdyYW51bGFyaXR5IChn
bG9iYWwvDQpkb21haW4vUFNJKSwgd2l0aCBzaWRlIGVmZmVjdCBvbiAxc3QtbGV2ZWwgYW5kIG5l
c3RlZCBjYWNoZXMgKGdsb2JhbC8NCmRvbWFpbikuDQoNCkV4dGVuZGVkIElPVExCIGludmFsaWRh
dGUgaXMgc3BlY2lmaWNhbGx5IGZvciAxc3QtbGV2ZWwgYW5kIG5lc3RlZA0KY2FjaGVzIG9uIGdy
YW51bGFyaXR5IChwZXItZG9tYWluOiBhbGwgUEFTSURzL3BlciBQQVNJRC9QU0kpLiANCg0KVGhh
bmtzDQpLZXZpbg0K
