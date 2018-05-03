Return-Path: <kevin.tian@intel.com>
X-Google-Smtp-Source: AB8JxZql90x7kQxHO5lLcco/Z/zfVGKvaFMob3jv1yDC3/GCzcDmrAO7K4FfcNAfXAf2vyWPH23d
ARC-Seal: i=1; a=rsa-sha256; t=1525351567; cv=none;
        d=google.com; s=arc-20160816;
        b=bdP0lfAtKipwoZ1+oNTawEsOssaqw1REQPlfco13todcdnJDbs4G49YudTS7GZtizK
         Nyyg7YEskXJQgky5KJgF26tIy3pVCIXn0ZUwHwDK3D+uejjFfGYV2NELtTjXJY9TI14k
         Og3Eke9yPvHDZEQORlLBVc3t7gbHQfaI1gbJ0LfBYTyXkN/82ix85O0LFLojBf6pGpXW
         msvkG7bymw28i0FI0ehPxH7dJjghg0qO4OA2MdI9D5j2PtSp20e+/XBv5G8cdPjaG0TF
         pB80QUsh+wu9x2gUC88zuckFXDr0wIKi4xTsXlCaQysyhb9+2fjKCLno018btu7Nmx1P
         KbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=siLgZ3Jd1xxfOYpbMQE2dPLhsSYZGXnBmJRM2C0FX1E=;
        b=EzTLEHIpNavq1as3WncrQbsdXGC4dsni/C0/jvf380EK1aStvFRhudVRXeY2A5nCfH
         27BKB2VmWYd+toNUDrHE5lRaPhTM15KEv4YwJJcVisRgBjVVDxxZgFbSvU1atPJPQOKt
         2SadSLKNnAjsJ1d4VXa9OIXf/1UAplaK5k8g3ja61c+WqH9EGef8D2Dm5/6V0983lulO
         Am5FSGjlGc1QVc83/IpAudBh28gWdw7+FXtABIZjxh9MAeRfGjnYSfziAo31OIURvrde
         wUg6wygLSDB1G6mqDK5qYp588cYeGcqYml6t3tCuhxpht98C5baOHukC0F5Rxcw8C2MG
         L7Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kevin.tian@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=kevin.tian@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kevin.tian@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=kevin.tian@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="48002275"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
	KarimAllah Ahmed <karahmed@amazon.de>
CC: kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "the
 arch/x86 maintainers" <x86@kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
	"Andi Kleen" <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Andy Lutomirski <luto@kernel.org>, Greg KH
	<gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, David
 Woodhouse <dwmw@amazon.co.uk>
Subject: RE: [PATCH v6 2/5] KVM: x86: Add IBPB support
Thread-Topic: [PATCH v6 2/5] KVM: x86: Add IBPB support
Thread-Index: AQHTm6hIVxVlMG6p10Oybduaf/W18KQdPnsAgACD34CAALlqgA==
Date: Thu, 3 May 2018 12:46:02 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19114A529@SHSMSX101.ccr.corp.intel.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <CANRm+CzKXA6ktG9fV4E-Q=+ZWZbS+ApUPXjogJJQErEZD2jHHQ@mail.gmail.com>
 <9c228512-33b8-0df6-0c3e-4d30140d6579@redhat.com>
In-Reply-To: <9c228512-33b8-0df6-0c3e-4d30140d6579@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTc2NGFiNWEtOGQ3Mi00NjIyLWI0MDEtNzM5Y2Y2ZDVlZjkxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Ild0bENZcGY1NVZOcjV1ZWlxa0lZd2doaDNZeFJSVTFLd0dtTWFSVE10Mk09In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1599447045411567120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBGcm9tOiBQYW9sbyBCb256aW5pDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMywgMjAxOCA1OjIw
IFBNDQo+IA0KPiBPbiAwMy8wNS8yMDE4IDAzOjI3LCBXYW5wZW5nIExpIHdyb3RlOg0KPiA+IFNv
IGZvciAxKSBndWVzdC0+Z3Vlc3QgYXR0YWNrcyAyKSBndWVzdC9yaW5nMy0+aG9zdC9yaW5nMyBh
dHRhY2tzIDMpDQo+ID4gZ3Vlc3QvcmluZzAtPmhvc3QvcmluZzAgYXR0YWNrcywgaWYgSUJQQiBp
cyBlbm91Z2ggdG8gcHJvdGVjdCB0aGVzZQ0KPiA+IHRocmVlIHNjZW5hcmlvcyBhbmQgcmV0cG9s
aW5lIGlzIG5vdCBuZWVkZWQ/DQo+IA0KPiBJbiB0aGVvcnkgeWVzLCBpbiBwcmFjdGljZSBpZiB5
b3Ugd2FudCB0byBkbyB0aGF0IElCUEIgaXMgbXVjaCBtb3JlDQo+IGV4cGVuc2l2ZSB0aGFuIHJl
dHBvbGluZXMsIGJlY2F1c2UgeW91J2QgbmVlZCBhbiBJQlBCIG9uIHZtZXhpdCBvciBhDQo+IGNh
Y2hlIGZsdXNoIG9uIHZtZW50cnkuDQo+IA0KDQp5ZXMgaWYgSFQgaXMgZGlzYWJsZWQuIG90aGVy
d2lzZSBJQlBCIGFsb25lIGlzIG5vdCBzdWZmaWNpZW50IHNpbmNlIGl0J3MgDQpqdXN0IG9uZS10
aW1lIGVmZmVjdCB3aGlsZSBwb2lzb24gZnJvbSBzaWJsaW5nIHRocmVhZCBjYW4gaGFwcGVuIA0K
YW55dGltZS4gaW4gbGF0dGVyIGNhc2UgcmV0cG9saW5lIG9yIElCUlMgaXMgZXhwZWN0ZWQgdG8g
dXNlIHdpdGgNCklCUEIgaW4gY29uanVuY3Rpb24gYXMgYSBmdWxsIG1pdGlnYXRpb24uDQoNClRo
YW5rcw0KS2V2aW4NCg==
