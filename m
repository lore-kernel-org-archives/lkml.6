Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx4/4QAYOv1xsLKU3Uw65/fYddz4bHCxbWYoKs2Uw3YFUhKXiA07QXz4Pdtn/q2BqPbaandct
ARC-Seal: i=1; a=rsa-sha256; t=1523482115; cv=none;
        d=google.com; s=arc-20160816;
        b=PVDJSTWpk5lRwLOatkqanNjwLqv8kNopWGWxerTEDpWTzPyfvqmDxHjj26TALsH5t/
         NXwzWfCsZwRBJnec1Mwkgt3JA5TD7fiFell8H5gHusbdrBW1CD8C0ukfPJoEnfIGgsci
         JDwUXEg4DuAN5QuxfdPjMlXWOsr2eElBqBGnVV5RBLDcDroMRexESqznVjeQ7mMI3inn
         d5EWJoZ/ujk/BrGm2GTh93MeB6GA8zp23WxZsJS+JUUZx6RxH2y9grnk3osHf9bbAAnS
         9f8WvKCFMtT3crIlbbWGy9kmyBHdTbwbMLcfsciKODEkXGE0AVEtaRycHx5s8IaOrEVn
         CSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=DKfgUg989kx2KrAFZtCqaRX3cFw5jF1fNB2l5cSjeig=;
        b=ziIt+ESqJwWBciCYePGUjzJqzHRqBTELY5Hvu0xOFP+JQCeR0cd8I71ySDqvJDDtDd
         Wvtg6Amg+PEAiRt9906hBeWYQV1lElbScfkVv8M8JF1abaSAnGOg6QmlKLYuql9WyDji
         x6kLuTeA0kkworJdY0HW1Za0KhJX9Hxq5IwmRbQRpO/PIWcYfo0SnrL0KJtw3Aj2SbQK
         BLbbbCpUxPp/a9vViwQ6EYQ1T9fQ7knlspgrAUFP1BUC2XNJls2nJZbxgJLGLRU3Eecn
         IImdIZeHoGAisQWhbcrHf9QYYYiqqUBcsuDZDG+ruAhIhroll/1PrBq4imjNDiDb0N9f
         7L/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=XHC8cjr0;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=P+oOPy2G;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=XHC8cjr0;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=P+oOPy2G;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,438,1517846400";
   d="scan'208";a="76500099"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "tj@kernel.org" <tj@kernel.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAX/wCAADPagIAAD1uAgAAYkQCAAAFwgA==
Date: Wed, 11 Apr 2018 21:28:30 +0000
Message-ID: <b34103c58fec2ff45be27cd90925f7655ff38da8.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411212320.GA26747@gmail.com>
In-Reply-To: <20180411212320.GA26747@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1214;7:8Uie1bPr0blp9Cm2odeMrAvM4Atp1hZz6mY0fCqnkju2F8Cjzmm6oMWG76M+XSfoezHQBSqkD0XWUx8cgxSB8MnQJ5gn7idgpgiujMyR82MZPKiL+lTaAIQsXekgmzgZlnBtpmHbGth2OssU03JAtDrJ8eftg1GQE9zqrEOfrmsyG3CsENaOu/q3CrnY50/LwtOz6f9a+ClH/ZAThQtfhnXNzmNkgO27UwmOXhSzVc6G4aJtMXCiztlQ6kA4+NhD;20:3cv2B+q2xkyVCZmGlxCNc46Ql3W4aH1VlmqtFbP15zVnJ54LjZArvt9lVmr+IUPvBIuvz5DutsGjmhfvO1qon+oNvwQQqTHTvs5HENsbuJtEsJ9ul/u+ejRvvaoT6JM6AXw0RTgfPJAvuYZGyvCtgIpr9ZQFLs7LwUO0tWsgPX8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1214;
x-ms-traffictypediagnostic: MWHPR04MB1214:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1214569099E0D41C40E2625898BD0@MWHPR04MB1214.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1214;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1214;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(346002)(39380400002)(377424004)(189003)(199004)(86362001)(6916009)(11346002)(4326008)(446003)(7416002)(99286004)(6436002)(2616005)(476003)(6486002)(186003)(229853002)(2351001)(68736007)(26005)(5640700003)(106356001)(105586002)(6512007)(5660300001)(2900100001)(14454004)(316002)(2501003)(97736004)(3846002)(6116002)(305945005)(7736002)(93886005)(66066001)(8676002)(1361003)(2906002)(118296001)(81166006)(25786009)(8936002)(72206003)(81156014)(3280700002)(54906003)(5250100002)(6506007)(6246003)(478600001)(76176011)(3660700001)(39060400002)(36756003)(53936002)(486006)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1214;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: T9wT1Kp9xMMUzGsIOFCLfczswhwWlxUFUTy0Y5DZCCvhg4JSgzRepx9moQY9upF4FGcsC503oPnfCqewWYTKDMM8tH5iceXrpi/LzfbbqhS35LoS1rQYZsGJrIYjqEfJfVgZNWzwCj6pGEemZWYZJ4ZZpKZ5rPoAYLjFFRADL2hrxPM3sEwYPOMsfrLKk5qFn4/aMYFEs3f0DOxsI5TelyhIqousVUGSdNQOxDMbqXnsda2wvnA/Ojne2qcJtLuTH3M8Bzw2w90kh6Ou3oIosePOpK+eTL0jqaUaFQ67xJ6vNw/F021pM4DMX4p3CNG5VmkUg0wxn5pTNdkmdtBgKgIzh+A7NjE08XDMvvi6FIH+apSRvX0ynJvsamtc8bWU6lJKff0OZU3WG8PbSXgpUgfI968/GobFxALnGrt5aqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E4E5C031431344385F0917FCB5F1924@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b5f89f61-7294-4b6a-5718-08d59ff32c3a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f89f61-7294-4b6a-5718-08d59ff32c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 21:28:30.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1214
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597486782315749240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDIzOjIzICswMjAwLCBBbGV4YW5kcnUgTW9pc2Ugd3JvdGU6
DQo+IEhpLCBJIHRlc3RlZCBpdCwgaXQgZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxlbS4NCj4gQnkg
dGhlIHRpbWUgeW91IGdldCBoZXJlIGl0J3MgYWxyZWFkeSB0b28gbGF0ZSwgbXkgcGF0Y2gNCj4g
cHJldmVudHMgdGhpcyBmcm9tIGZhaWxpbmcgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpIZWxsbyBB
bGV4LA0KDQpJZiB5b3UgY2FuIHNoYXJlIHRoZSBzdGVwcyB0byBmb2xsb3cgdG8gdHJpZ2dlciB0
aGUgYnVnIHlvdSByZXBvcnRlZCB0aGVuDQpJIHdpbGwgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHRo
aXMuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
