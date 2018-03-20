Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELuCerZNaLyPVoI282lAg2hcnT5eqjCFviLxE5yZPUtOsWkVh4ij2c+Ndy7/jbLowA/C1TD4
ARC-Seal: i=1; a=rsa-sha256; t=1521586704; cv=none;
        d=google.com; s=arc-20160816;
        b=RQYrI5OEoh+kcByDpX1Hdqny4G4LVUxbpGuXPeGbSc0FI+5IXn4BxpsrLvHi0ab6qJ
         pw+TviZGOtbI8vqxscBoj5070Gy0+I+lPXwJJl48CUPnltMs3OwMhBaBmJeolz3q0oTq
         lA/h/SCRhJK8aG6jUf6KSl5WSeUpzkrpJAC/hVDjXvtb94tJAI6oWcfeJYewPRoZd2bd
         3lRKl3WGuclcuiUP9BHQSUSEvVIXKc2kXB7s0qyRfpzfzsg4weVLszAWqI5AT3Fo47x9
         D3qZtmwbxaxyDYaGTZPLK8OS5yTBD5Em6NQVPSYZ19o+5rFHFm1V9oIbx+N+ClMN7lJ4
         0Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=Op3x7jWHlLK13xE82Ofn1iksIS5Jt96h5tLN+nqMI5o=;
        b=byqmF52EY6P9Do5Owz2cMG67V2ckkDzWnwZcJNST9G5d2rzibleOkJVMaJ7iMMlqWM
         tcmCfy6uBXtQAuVR81F9F/heex2VVotxlQ4M7rgdanRKTg91Ys8U43SwbeBpnHbascW6
         qK7fqG3Xfv7TX7etVYrjxTTvqlZUcDG1CNS5FuAxcCLCBmmVS4+okE9kGnOc2eUxVwKf
         iYhDxc/7IfeDQ1qUDVbp0Gyj2D598irtQMkFYUska1+0eWTpD6eDfelbUyjpWBsyjPla
         XKMDIafAL5qJSG48CB1wQhrNm0i95ZUB83XgRbZgLCQy3GdKvYFcl6c+OGEK6chy839G
         UHOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.140.75 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.140.75 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "takahiro.akashi@linaro.org"
	<takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com"
	<marc.zyngier@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] ioremap: Update pgtable free interfaces with addr
Thread-Topic: [PATCH v4 1/3] ioremap: Update pgtable free interfaces with addr
Thread-Index: AQHTwEETnld4elYsbkmpuHn01jUZhaPZvVEA
Date: Tue, 20 Mar 2018 22:58:18 +0000
Message-ID: <1521586688.2693.231.camel@hpe.com>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
	 <1521546314-31753-2-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521546314-31753-2-git-send-email-cpandya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0553;7:hPyNdE5vDBTdyM1+XzfvgJHuUEDvV6EcmNUQsLp2xuuXN4fwHMTrt9d7QeX6XS09szt3rVaq0a+HRC77urD/nWPO8iCltpP10hNppixRfRGkH6Ax1a+qUjOFO3dlzPc7MLu+sl/9XXgmr6xEOOjRZxe4xOO3gVs+sZB6YnzdQyEW4rLDMOQSq7Hx250Daq8Y0uDUjJdmlHzufFwKt036ToK5kwsnN24yeWX4A8p8to6Ad4mpFHvemu89Ty+PF+or
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aeee3722-e850-4a1a-f501-08d58eb612b2
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0553;
x-ms-traffictypediagnostic: DF4PR8401MB0553:
x-microsoft-antispam-prvs: <DF4PR8401MB05533B451C6A60D5721D6F6082AB0@DF4PR8401MB0553.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501316)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB0553;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0553;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(39380400002)(346002)(377424004)(189003)(199004)(51914003)(26005)(186003)(3846002)(2900100001)(15650500001)(59450400001)(54906003)(110136005)(6116002)(2906002)(229853002)(2950100002)(6506007)(99286004)(316002)(106356001)(102836004)(105586002)(25786009)(966005)(305945005)(7736002)(7416002)(14454004)(68736007)(478600001)(6246003)(4326008)(36756003)(5660300001)(5250100002)(81156014)(8936002)(3280700002)(3660700001)(6436002)(81166006)(76176011)(6486002)(2201001)(53936002)(2501003)(6512007)(8676002)(6306002)(86362001)(97736004)(66066001)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0553;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vZXEJPZcAG/PD3M5KKyGC/YitFL4bdaL+rOZnzQD/EKtWxMSGOIFB8qIFhvrrIlCDaRDzyrasAW5UruMptZpm2+pb796sX1WjBSI/H2+dNFDXnjJA1hI36UGwRsIT0SmRi8dguVe5hOMPUR/i2SMaC+TAzBsOs580RTVholA8zVsjDymqvUtbVKTcA3cN2rqiJrGS9uw5o6qTeaD01omC8lFyItNyPF+F7eATl1sS2lzRtlhgMZs8SXzyiezRi35M1nY70aPh6e6wt+mWnZkJEj8Uk1Mox1OE0JUjYSmKt7XCeZ9JZfsSop9WLaF1fYyXwMFm+wcNAXKaJFNmwSiew==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F798A5B587E5404B9DBFD68F0F5BE59D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aeee3722-e850-4a1a-f501-08d58eb612b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 22:58:19.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0553
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369882117983930?=
X-GMAIL-MSGID: =?utf-8?q?1595499300444010428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTIwIGF0IDE3OjE1ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gVGhpcyBwYXRjaCAoIm1tL3ZtYWxsb2M6IEFkZCBpbnRlcmZhY2VzIHRvIGZyZWUgdW5tYXBw
ZWQNCj4gcGFnZSB0YWJsZSIpIGFkZHMgZm9sbG93aW5nIDIgaW50ZXJmYWNlcyB0byBmcmVlIHRo
ZSBwYWdlDQo+IHRhYmxlIGluIGNhc2Ugd2UgaW1wbGVtZW50IGh1Z2UgbWFwcGluZy4NCj4gDQo+
IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCkNCj4gDQo+IFNvbWUg
YXJjaGl0ZWN0dXJlcyAobGlrZSBhcm02NCkgbmVlZHMgdG8gZG8gcHJvcGVyIFRMQg0KPiBtYWlu
dGFuYW5jZSBhZnRlciB1cGRhdGluZyBwYWdldGFibGUgZW50cnkgZXZlbiBpbiBtYXAuDQo+IFdo
eSA/IFJlYWQgdGhpcywNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDEz
NDU4MS8NCj4gDQo+IFBhc3MgJ2FkZHInIGluIHRoZXNlIGludGVyZmFjZXMgc28gdGhhdCBwcm9w
ZXIgVExCIG9wcw0KPiBjYW4gYmUgcGVyZm9ybWVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hp
bnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQoNClRoYW5rcyBmb3IgdGhlIHVw
ZGF0ZS4gIFRoZSBjaGFuZ2UgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IFRvc2hpIEthbmkg
PHRvc2hpLmthbmlAaHBlLmNvbT4NCg0KLVRvc2hp
