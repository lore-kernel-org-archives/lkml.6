Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 741666070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933672AbeFFRYk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:24:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:63911 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933527AbeFFRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:24:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="64847515"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Naresh Bhat <naresh.bhat@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>
Subject: RE: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Topic: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Index: AQHT9vOycW5QHpsqGkehQKqjrruTMqRMstgAgALXhECAA+HAgIAAGtLw
Date: Wed, 6 Jun 2018 17:24:34 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3B8BBBB8@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAFoFrHYcD7fGYaJzKwcPCtu+XyR+mh5ORDqmCpiBjLmEkDfwOQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F3B6EABDF@ORSMSX114.amr.corp.intel.com>
 <CAFoFrHbOkKpfrt-NVX9wm49aR1Mv7dXLVrDuXGQPiD0ZNbvyrw@mail.gmail.com>
In-Reply-To: <CAFoFrHbOkKpfrt-NVX9wm49aR1Mv7dXLVrDuXGQPiD0ZNbvyrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmM1YThhMTctNjg2Mi00ODM3LTllZjgtOTY2MTMxYjdhZGViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN1cySnB5MHc2XC9jRVBpSERUNlBvOGpPRHFtcDMxXC83bTRnNGZCd3BYRkl3MFNHV3RRQVR5WWVmVWROZzlxTHMwIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBJIGhhdmUgdGVzdGVkIFY0IHNlcmllcyBvbiBUaHVuZGVyWDIgVmFsMSBhbmQgU2FiZXIg
cGxhdGZvcm0gYnkNCj4gPj4gaW50ZWdyYXRpbmcgdGhlIHBhdGNoZXMgd2l0aCBMVVYgcHJvamVj
dC4NCj4gPj4gSSB3aWxsIHRlc3QgVjUgdmVyc2lvbiBzb29uIGFuZCBsZXQgeW91IGtub3cgdGhl
IG91dGNvbWUuDQo+ID4NCj4gPiBUaGFua3MgYSBsb3QhIGZvciB0YWtpbmcgdGltZSB0byB0ZXN0
IHRoZSBwYXRjaCBzZXQsIE5hcmVzaC4gV2lsbCBiZSB3YWl0aW5nIHRvDQo+IHNlZSB0aGUgcmVz
dWx0Lg0KPiANCj4gU2FpLCBJIGRpZCB1cGdyYWRlIExVViBrZXJuZWwgdG8gdjQuMTcsIGFwcGx5
IGFuZCB0ZXN0IHlvdXIgcGF0Y2hlcyBieSBydW5uaW5nDQo+IExVViBvbiBRRU1VIGFuZCBUaHVu
ZGVyWDIgaGFyZHdhcmUuIEFsbCBlZmkgdGVzdCByZXN1bHRzIGxvb2tzIG9rLg0KDQpUaGFua3Mg
YSBsb3QhIGZvciB0aGUgdXBkYXRlIDopDQoNCj4gQnV0IGFzIEFyZCBwb2ludGVkLCBJIGFsc28g
bm90aWNlZCBoYW5nIGlzc3VlIGFmdGVyIGV4ZWN1dGluZyByZWJvb3QgY29tbWFuZCBvbiBjb25z
b2xlDQo+IG9uIHJlYWwgaGFyZHdhcmUuDQoNCkFyZCBoYXMgZml4ZWQgdGhlIGlzc3VlIGJlZm9y
ZSBhcHBseWluZyBhbmQgdGhlIGxhdGVzdCBwYXRjaGVzIGNhbiBiZSBmb3VuZCBhdDoNCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2VmaS9lZmkuZ2l0L2xv
Zy8/aD1uZXh0DQoNClJlZ2FyZHMsDQpTYWkNCg==
