Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELuvxNCtU8TOYOXjXGHKb6lV5/n6HRHztRrIxLoRaJkNs8geNhBoce7Rw0isKRovspkp2yFG
ARC-Seal: i=1; a=rsa-sha256; t=1521038283; cv=none;
        d=google.com; s=arc-20160816;
        b=QuRAGL+Y2wCKXbpovcpD416HMwE4G+0zJSzxbXuEmy3HAu30Bkal6e5/+sDMLOb8KL
         1yKls7A24ziA7HCU4DfVGTXd5YhBjN/hyYrrfFToF72+/km6Ba3Mdb4huK8mcaHcHclt
         KfI8LDmUjuvvCkpm4iO3JmQC5lCX4xlSHCmgsbb9acHKIQwHZKRyYS8fqH6N3AuBipJM
         0mNURrZugj3TBearqxqI+oPBs4iToEL2xGGrZtf6o3KvJyIFb8zAsXBDJ8lADVsVO4gE
         wHzOnnJlS7QKYHHMrczn1iNlqzPvdvbuUYN1gNv229QMwrvNCJWOWcdPbqTEmwxX860Z
         9Cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=COOYYVa4coq46wJkZgdUivxMvjsrQ06Zd3aD9tUw60E=;
        b=YAaotQQWqPslCw4kfXHhQXj5NpiDhg0OoAvhG1tGjQIO/hBUhZtvvFCNsLCPUEoWDM
         ukyOs6sfkhfIDEuOxZG3tURXF3Dgc8yvkuzDY3LNydUWzSnbJ9+wq9K5ffB8rdRlHR3A
         XD6eB1DazjYBZxDPu5EfKBrMZN9OF1IOwYNn8b/lEwPGwPm2x+Nh0Fcyqoq56SUjU4JX
         4A0qM0VDDL16k/WyzkxMOt8VIuLO9s3jxdt2zkFX8pJurTUTgiUMEQDzEBvtCdYMRHHf
         TQu1C2D+LlWLUdV6wmjdiv1xWOI93LDCy/z+5SzQGfvwk1VYBieiU5EnWstWeqhaEFH3
         OXQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.48.72 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.48.72 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "takahiro.akashi@linaro.org"
	<takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com"
	<marc.zyngier@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Thread-Topic: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Thread-Index: AQHTu3FSGWoL5FTXrkiY4uG3QiL07aPPzTOA
Date: Wed, 14 Mar 2018 14:38:00 +0000
Message-ID: <1521038277.2693.131.camel@hpe.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB1081;7:eAbPYjC0imA9gHoPg4o5oCLGdNJuEN5MRrsK9Q9Asug2fjDbPmdJp5hj930/zpnBZuVLDIgRuT6QAm6630EDmg/90RW+GW9vI7jZiL+ryyIP9/xwVmZNcaPT1E+bEcdDk4uWi1GpX2IA9psUkMlrCb0S4RJUvsH9Smy54DNjj/DCwWcoD8jmxZXnQHctn4KfcsfqiTv49eJdcnYgzhUyx89ViPO6n1nS6dCySMDTJhBGgNUdplxXkFY6ZFk4LWfb
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab4b4674-ba3c-426f-b729-08d589b92fae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1081;
x-ms-traffictypediagnostic: DF4PR8401MB1081:
x-microsoft-antispam-prvs: <DF4PR8401MB10816B7DE99D59E9BB23ED4282D10@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB1081;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1081;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(189003)(377424004)(199004)(5250100002)(186003)(2950100002)(14454004)(6486002)(2501003)(6436002)(68736007)(110136005)(229853002)(97736004)(4326008)(5660300001)(66066001)(25786009)(2201001)(316002)(105586002)(54906003)(86362001)(8676002)(81156014)(8936002)(76176011)(81166006)(102836004)(6506007)(2900100001)(3846002)(3280700002)(6246003)(6512007)(26005)(99286004)(106356001)(53936002)(7736002)(478600001)(3660700001)(103116003)(305945005)(7416002)(6116002)(36756003)(2906002)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1081;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8SZwwlCs9DrIVXdd90oraiWcpLpAlEIqpLVqZNMWBg39f8sfEXlseHzIya8s7TYVz0JYARp3B/fwrWOIadHzh2Fhxs5jnEoAU1iPE7zEh2eAmCmPkLvWnDmPJ8IO3wCOgNaBrTR1X4A77bGCbr0fKWRd4Aws1TDAMPy4GIuwQIo7+NI80g+gs0OEtIg3netClJzlSV8lcsRzudWHcDftPVqg/RP1BgEafaMvlLYmpvV3frSFpPAeTVDf2m7nPG6uqRiZRiv4mffLQdMxy001ZWdzYi68JVFhYCFpcVY0KZA4KEVRm/+Rqlk9wFoek4BBnn9N3wFj5c+1w0v89lbfHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C99D1C06EF2B3428FA0FC72FB6CB5DB@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4b4674-ba3c-426f-b729-08d589b92fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 14:38:00.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1081
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902258124982014?=
X-GMAIL-MSGID: =?utf-8?q?1594924238930474385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDE0OjE4ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gTm90ZTogSSB3YXMgd29ya2luZyBvbiB0aGVzZSBwYXRjaGVzIGZvciBxdWl0ZSBzb21ldGlt
ZQ0KPiBhbmQgcmVhbGl6ZWQgdGhhdCBUb3NoaSBLYW5pIGhhcyBzaGFyZWQgc29tZSBwYXRjaGVz
DQo+IGFkZHJlc3NpbmcgdGhlIHNhbWUgaXNzc3VlIHdpdGggc3ViamVjdA0KPiAiW1BBVENIIDAv
Ml0gZml4IG1lbW9yeSBsZWFrIC8gcGFuaWMgaW4gaW9yZW1hcCBodWdlIHBhZ2VzIi4NCj4gSSd2
ZSB0YWtlbiBzbGlnaHRseSBkaWZmZXJlbnQgYXBwcm9hY2ggaGVyZSwgc28gc2VuZGluZw0KPiB0
byB0aGUgbGlzdCwgZmluYWxseS4NCg0KSGkgQ2hpbnRhbiwNCg0KRG8geW91IGhhdmUgYW55IGlz
c3VlIGluIG15IHBhdGNoc2V0PyAgSWYgc28sIGNhbiB5b3UgcGxlYXNlIGNvbW1lbnQgb24NCnRo
ZW0/ICBJdCBjb21wbGljYXRlcyB0aGUgdGhpbmcgd2hlbiB5b3Ugc2VuZCBhIGRpZmZlcmVudCBh
cHByb2FjaA0Kd2l0aG91dCB0ZWxsaW5nIHdoeSBhIGRpZmZlcmVudCBhcHByb2FjaCBpcyBuZWVk
ZWQuICBZb3VyIGFwcHJvYWNoDQpwdXJnZXMgVExCIGFmdGVyIHVwZGF0aW5nIHBtZC9wdWQsIHdo
aWNoIEkgdGhpbmsgaXMgYnJva2VuLiAgQ2FuIHlvdQ0Kd29yayBvbiB0b3Agb2YgbXkgcGF0Y2hz
ZXQgYW5kIHByb3Blcmx5IGltcGxlbWVudCBwWGRfZnJlZV9wdGVfcGFnZSgpDQpmb3IgYXJtNjQ/
ICBJIHdpbGwgc2VuZCBvdXQgbXkgdjIgdG9kYXkuDQogIA0KVGhhbmtzLA0KLVRvc2hpDQo=
