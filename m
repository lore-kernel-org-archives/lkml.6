Return-Path: <prvs=564c18bbf=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x226ECwlvrfoq4IdpwJTegBDuMtJk/qhEoMVKDxVde/EwSQoWw61xW9PimU9iVGnVDX+QT0MK
ARC-Seal: i=1; a=rsa-sha256; t=1517531383; cv=none;
        d=google.com; s=arc-20160816;
        b=w5k08ygowWpsSMODKw1/IqT0762SwOG6B2jaAuXftzcCL/nKwg/zfT2qyN+8HNZ+XQ
         Tut5Ueq+BaN1rvTYMimhkddR8H8ixYeKRbHeHsXu85FvXa3NodHtG1N9RKYrMwQzQPVa
         /Ot1liLDNaEvNmU+sKcbJVSSDI5sv0MIR4AA6cHfh/bbdtvFxvvdvjB0FUrPBNOQvx1W
         h9di/oGsjS0j1d2CUqqv2IQXzW0xMlEAXJBLR3yLqFdHBh2TpdhE8JCFZNCM++hhMeG9
         3zmENPPPzWqwWh9RDo7mXX6t+vNysPRoySsiOJIKSSIkx2ZPmKRAwfiwyELcyoQ7Eb3s
         +oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=nBuPB50LR0y71hea9w3llq0oZs9vBMz7W2MQ+syv2II=;
        b=rPt9odxR0cVukcUedK9+bn2qdaEG6DYtRLGJwUeVKLREmtkCDG6zZ3p54uG3HzH/X3
         1/G5M2MTl76Tbi46zkgnwlKH74Fgc0SgGZym6PL4MV7Ts7yOv3ay5a7ZmXIvIiaK+RQg
         VD7H3Y8mwQhy8EfqpAwSUJrdT1fUqde8HMedUkCD3uLzaco9wGJxY9iTazOG2rFJVB4H
         dPqwnTnCzC/4svPLlXQaEY1awmDKpCaZPctlEZ6G0htgPWUouecG/zbgHBe6+FkG9if6
         dry5g1V+BOaoWA4oAugyqbpDma8sxRO3D5b787gMuCqE7HRMbWvfg6rcZpC07iTlbJ02
         X96Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=K+/KIneE;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=n8KVs640;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=K+/KIneE;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=n8KVs640;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511798400";
   d="scan'208";a="70508188"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Topic: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Index: AQHTm3hGoRqnZ3BUQkShg0Hz0gO6oqOQQuAA
Date: Fri, 2 Feb 2018 00:29:39 +0000
Message-ID: <1517531378.2746.29.camel@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
In-Reply-To: <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1486;7:OzOHDx9EDwCWIz7jV1LKcSqHkYKqsuWiBmqDp0gsFYt8ATyi7I7AzbkROwyMILEPBbHIV2t/5ESB+sQ4C0zaDkULTDiKX10UNryy3Iyl8IyLZx99Bib2loNQC5631PSBVG/Ju9xCOMHFOzjw2J/zHOQR0I7XQ6n+8oQ/rDA3xNC2VZqVBeSlYz4iCDOv/PVlxVmMplh6VQ0lZPRdHozqLOTid/05gZFsnJC6L9KixvpT8unaWA5j1cOtkvUkDoeN;20:gf6/Aqqk9ASHla3baIosU3BoSMCyrRY5KIlDQZaV8bfkUbWYNHxnw5qNaQpwjWTPVzUBiSWDGxjpM1t9NJU6P9xYUSODLIKNWHgTwCh47B1ZmYWHiaANyR0axZB3m5+HMKHFBNu1PuM4hpxNy6xpojsbQhKBr43vbDMkI9bF3Hc=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9d18bca-7051-45f8-ca0c-08d569d40c31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1486;
x-ms-traffictypediagnostic: CY1PR0401MB1486:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB14862A299E859B909CE48EF498F90@CY1PR0401MB1486.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0401MB1486;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1486;
x-forefront-prvs: 05715BE7FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(377424004)(199004)(189003)(26005)(68736007)(72206003)(36756003)(110136005)(77096007)(186003)(3846002)(6116002)(97736004)(2906002)(316002)(102836004)(6636002)(2950100002)(6506007)(105586002)(14454004)(2201001)(478600001)(86362001)(76176011)(3660700001)(2501003)(103116003)(3280700002)(106356001)(6436002)(6246003)(8936002)(229853002)(5660300001)(7736002)(8676002)(2900100001)(99286004)(81156014)(66066001)(4326008)(6486002)(25786009)(305945005)(6512007)(53936002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1486;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: xpmSASn7OPpnm+YKpH5Xw8ZbRqX1jiXbMXuvYrnlsv1/yzl/uNdBqcRFEcyI6meIq3zYg6Wcjr3A9ajhXlsO8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <90F8E70C8986BD41A1B856938504C18E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d18bca-7051-45f8-ca0c-08d569d40c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 00:29:39.9803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1486
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215920431432185?=
X-GMAIL-MSGID: =?utf-8?q?1591246987795004881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTAxIGF0IDE4OjE1ICswMjAwLCBTdGFuaXNsYXYgTmlqbmlrb3Ygd3Jv
dGU6DQo+ICtzc2l6ZV90IHVmc19zeXNmc19yZWFkX2Rlc2NfcGFyYW0oc3RydWN0IHVmc19oYmEg
KmhiYSwNCj4gKwkJCQkgIGVudW0gZGVzY19pZG4gZGVzY19pZCwNCj4gKwkJCQkgIHU4IGRlc2Nf
aW5kZXgsDQo+ICsJCQkJICB1OCBwYXJhbV9vZmZzZXQsDQo+ICsJCQkJICB1OCAqc3lzZnNfYnVm
LA0KPiArCQkJCSAgdTggcGFyYW1fc2l6ZSkNCj4gK3sNCj4gKwl1OCBkZXNjX2J1ZltVRlNfUEFS
QU1fUVdPUkRfU0laRV0gPSB7MH07DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWlmIChwYXJhbV9z
aXplID4gVUZTX1BBUkFNX1FXT1JEX1NJWkUpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+
ICsJcmV0ID0gdWZzaGNkX3JlYWRfZGVzY19wYXJhbShoYmEsIGRlc2NfaWQsIGRlc2NfaW5kZXgs
DQo+ICsJCQkJcGFyYW1fb2Zmc2V0LCBkZXNjX2J1ZiwgcGFyYW1fc2l6ZSk7DQo+ICsJaWYgKHJl
dCkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJc3dpdGNoIChwYXJhbV9zaXplKSB7DQo+ICsJ
Y2FzZSBVRlNfUEFSQU1fQllURV9TSVpFOg0KPiArCQlyZXQgPSBzcHJpbnRmKHN5c2ZzX2J1Ziwg
IjB4JTAyWFxuIiwgKmRlc2NfYnVmKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBVRlNfUEFSQU1f
V09SRF9TSVpFOg0KPiArCQlyZXQgPSBzcHJpbnRmKHN5c2ZzX2J1ZiwgIjB4JTA0WFxuIiwNCj4g
KwkJCWJlMTZfdG9fY3B1KCooKHUxNiAqKWRlc2NfYnVmKSkpOw0KPiArCQlicmVhazsNCj4gKwlj
YXNlIFVGU19QQVJBTV9EV09SRF9TSVpFOg0KPiArCQlyZXQgPSBzcHJpbnRmKHN5c2ZzX2J1Ziwg
IjB4JTA4WFxuIiwNCj4gKwkJCWJlMzJfdG9fY3B1KCooKHUzMiAqKWRlc2NfYnVmKSkpOw0KPiAr
CQlicmVhazsNCj4gKwljYXNlIFVGU19QQVJBTV9RV09SRF9TSVpFOg0KPiArCQlyZXQgPSBzcHJp
bnRmKHN5c2ZzX2J1ZiwgIjB4JTAxNmxsWFxuIiwNCj4gKwkJCWJlNjRfdG9fY3B1KCooKHU2NCAq
KWRlc2NfYnVmKSkpOw0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0K
PiArfQ0KDQpTZWVpbmcgY29kZSBsaWtlIHRoaXMgbWFrZXMgbWUgd29uZGVyIHdoZXRoZXIgdGhp
cyBwYXRjaCBzZXJpZXMgaGFzIGJlZW4gdmVyaWZpZWQNCndpdGggc3BhcnNlPyBJIHRoaW5rIHNw
YXJzZSB3aWxsIGNvbXBsYWluIGFib3V0IGFsbCB0aHJlZSBiZSpfdG9fY3B1KCkgY2FzdHMgYWJv
dmUuDQpQbGVhc2UgdXNlIGdldF91bmFsaWduZWRfYmUqKCkgaW5zdGVhZCBvZiBvcGVuLWNvZGlu
ZyB0aGVzZSBmdW5jdGlvbnMuDQoNClRoYW5rcywNCg0KQmFydC4=
