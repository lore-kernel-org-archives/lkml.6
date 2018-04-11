Return-Path: <ning.a.zhang@intel.com>
X-Google-Smtp-Source: AIpwx49gPvQzdwDaWLUOfSq0uil+SqKyx53ExAhENg8CSgqhOYyeptmzzid7Kte+sujYNbX9dmYe
ARC-Seal: i=1; a=rsa-sha256; t=1523436667; cv=none;
        d=google.com; s=arc-20160816;
        b=WuaCBc5wC6bzutWwZ3BU1HiqA0bCCoEsdpLJ7Li8zz6WCOfy/O9UTXjS/EwTNtxknX
         6g2blZLgk1vrMmEunqlDH6AlP93hComOlxmtJS+0rdoZJzYM8L0DF4Lkup1XD3u2brb9
         a3GHGXvN1+IvX8XNMuMwDL4acZTY86S0JDoJ3EaBnv/NyLL+kKO8bv9LQw97kUrNktB0
         PQ6G/2+VHFhXZDYNLcFec6zXvkS+v9pCeQjgECMcyoXrLrqzlRGIfTusDh3hiQb2iN+E
         RNkyMSV7GQeWRrdHmmrAMCLiidPRUXKGD4qGcqrbuu7j4IiI4hM9shY+UrtXnIxOWsZC
         gOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=GDuq/n0woTQyd/i7Td2iqbHAX4WwkZS0cmww8cdE5FE=;
        b=jGN5/xU5C2ef7fvVb1YypEVMIoXClsFgApxigg5p3I95h/Gyih6SV8Ng383YOyVwse
         rF/DKHa5Cb6d+EW21r+v6+PnPgAcRYuiAHBHknVal+iknAv/E07XtEFuts8yZrof0KoR
         4SAyN2yncUpZsgGUkp433aSrOJSyv2qHA8KTzJ0TloNkIefSvM+POPSl4VaJICX7kHSi
         EqG4sqJj3IWYfsMtKuvZ7mPwMWkbbHkEbL/TCJvVgEExPf90uZfSqgJL8LlT6GF/hZFX
         AbAPCkfx0+yAhHUBrAxg08gKOrzoYY1z6JLugmEVisy1Bm2bF4CLd7M6NQ+V9fJhLVsb
         TbwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ning.a.zhang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=ning.a.zhang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ning.a.zhang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=ning.a.zhang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="32506398"
From: "Zhang, Ning A" <ning.a.zhang@intel.com>
To: "pombredanne@nexb.com" <pombredanne@nexb.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 3 version of MKDEV: kernel, uapi, libc, why?
Thread-Topic: 3 version of MKDEV: kernel, uapi, libc, why?
Thread-Index: AQHT0XI4sEeugig6tUuuIe0XAMHC3w==
Date: Wed, 11 Apr 2018 08:51:03 +0000
Message-ID: <1523436662.1414.12.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.113]
Content-Type: text/plain; charset="utf-8"
Content-ID: <72FD5AA0A59B104DA38F33E98043CADE@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597439126464031035?=
X-GMAIL-MSGID: =?utf-8?q?1597439126464031035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksIEdyZWcsIFRob21hcw0KDQpJIGZpbmQgMyB2ZXJzaW9uIG9mIE1LREVWIChhY3R1YWxseSAy
ICsgbWFrZWRldikNCg0KaW4gaW5jbHVkZS9saW51eC9rZGV2X3QuaA0KDQogICAgI2RlZmluZSBN
SU5PUkJJVFMgICAgCSAgICAyMA0KICAgICNkZWZpbmUgTUtERVYobWEsbWkpICAgIAkgICAgKCgo
bWEpIDw8IE1JTk9SQklUUykgfCAobWkpKQ0KDQppbiBpbmxjdWRlL3VhcGkvbGludXgva2Rldl90
LmgNCg0KICAgICNkZWZpbmUgTUtERVYobWEsbWkpICAgIAkgICAgKChtYSk8PDggfCAobWkpKQ0K
DQppbiBBbmRyb2lkIGJpb25pYw0KDQogICAgI2RlZmluZSBtYWtlZGV2KF9fbWFqb3IsIF9fbWlu
b3IpIFwNCiAgICDCoCAoIFwNCiAgICDCoMKgwqDCoCgoKF9fbWFqb3IpICYgMHhmZmZmZjAwMFVM
TCkgPDwgMzIpIHwgKCgoX19tYWpvcikgJiAweGZmZlVMTCkgPDwNCiAgICA4KSB8IFwNCiAgICDC
oMKgwqDCoCgoKF9fbWlub3IpICYgMHhmZmZmZmYwMFVMTCkgPDwgMTIpIHwgKCgoX19taW5vcikg
JiAweGZmVUxMKSkgXA0KICAgIMKgICkNCg0KaWYgSSB1c2UgbWtub2QoInJlbmRlckQxMjgiLCBT
X0lGQ0hSfDA2NjYsIE1LREVWKDIyNiwgMTI4KSk7DQpJIGdldCB3cm9uZyBkZXZpY2U6DQpjcnct
cnctcnctIDEgcm9vdCBncmFwaGljc8KgMCwgNTc5ODQgMjAxMS0xMS0xMSAxMToyMCByZW5kZXJE
MTI4DQoNCg0KaWYgSSB1c2UgKCJyZW5kZXJEMTI4IixTX0lGQ0hSfDA2NjYsIG1ha2VkZXYoMjI2
LCAxMjgpKTsNCkkgZ2V0IHJpZ2h0IGRldmljZS4NCg0KYnV0LCB3aGVuIEkgdXNlOiBta25vZCgi
Y2FyZDAiLCBTX0lGQ0hSfDA2NjYsIE1LREVWKDIyNiwgMCkpOw0KSSBjYW4gZ2V0IHJpZ2h0IGRl
dmljZS4NCg0KQlIuDQpOaW5nLg==
