Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475562-2-10940155782688231585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475561; b=gR4v9dyGpxtwqzMm4+JodkUDn0mzvESio4Uwxn0HrxFAYP9
    LjGm4r64CPga7IafOSV+orvTwLf84L1vHVdJkOUD1jeoFSFsSboifvZCe0qBYSY5
    mH2xA7pz+uur10xNLJpDquXyUFlYI+cLEjq20/OS2rrNBh/K9G6WOLXsmImWsAoz
    zMDcp4K5vkBqAC216wFlbS4/uqq2ZbF+SZFEsoC1yK+00JfqIAwQWSkL4Pad7Q4c
    bThhxiS8Kr2p+tMiJENhTeOn+7uNjJbdPi017e0YHbGQ3jH93cNhN9JxOXwRNXLL
    lP0EwXzKBf1TfVv6ljt8w5XiWjcd0W2JKgKzjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521475561; bh=UkA4H8s3c60HB3awSAWApvgzc2uV82gubuwrm7
    Vtq9c=; b=f7F51MZZH+EDSgov9q4f7be8T5lxACOI1qdtds/vku7SVdIodKlZvJ
    eb0AePbf7YpHJROVLET946JkIN0AoAP30p7tS0ofkGWP1cfhHHMdwBschkMK8ncE
    yL/sWK/W4lcfK+O/Y3G2NgFjQPbwhf1TEDy4snO+pSVt4EE09aGt4oYZYEZHfIlp
    XedoqKgZqsFn+qF/KYxPWqYYItUne671c438kUAVf8iq7YYdII+xFWotuq0DYPf/
    wpT4PuIXK1iFILdcU+oMq+Yll176Xvs8fGUSeOF0l8TyZbOursb17tfkJSfTA8cC
    68QslDYRDCRLExiGNHzvVIC7L/Mo1z8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mDPx+CeH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepsghpfhdrtgdqohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleefkedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mDPx+CeH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepsghpfhdrtgdqohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleefkedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965867AbeCSQF5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:57 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965843AbeCSQFr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Will Drewry <wad@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 260/281] selftests: kselftest_harness: Fix
 compile warning
Thread-Topic: [PATCH AUTOSEL for 4.9 260/281] selftests: kselftest_harness:
 Fix compile warning
Thread-Index: AQHTv5vCAJiRw0+G90S1Hxp9lhdC0Q==
Date: Mon, 19 Mar 2018 16:03:02 +0000
Message-ID: <20180319155742.13731-260-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:LmQlQU1HQIboC8ahCu3o1xPtjRCZDifKaG6dv/yzCwH1uO002Br4ZX94KId72hCp+40g4ZANSjckQtvc7TUkPYmy4eW9OvBapjrGTn+1RabxVm1QyfgOOjMnn3OUM+DNaM5vVN3RZIYcTxNG389KKqRV5Zcx34WDTVUJ1KZlK3U3OCv/PqUCBYs5zBasvH7kImAwG1/MAwGok4wstA/LyvTa5uoYSFUKcb/OFGeicXImd/5rnBbvQk0gvuPrjpLU;20:l8uj8yXZ1VEGmSwPreK52zIM/kO8GHoQsFqTCU00a19/yU2IMFjmz4XFEJEJNijwl3J9IN2M/V5Qw0PFv1qZoqHy1JxQ0jCPU4e9mOcFjLhqOH4VopQAZa2e/wEWs4Xi6f1N4tC+fDEys7ekGzOYlKpsh8YepwsPdzTD3TaQBj4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea913861-1e5d-4684-05e9-08d58db3414f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015952007A8DF7C9A0E5EE2FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: j8shONqHSChHSu6+4VQVlypgoHa3pb9CmPr/c+oaWZamWq8SMyZO2/ba7H/dFYSh3HsceDX3KIPP9BbrmxbBurfJlBsgKplS0YZIyx9IMT9J2nS5uFVdC56lpbWc8e9nE+ZRGlwww3j1TIAovs0/il6FUsrLrA3epPsd2CmEALcYZWODl1h303W/zLhjzHyVipD1RMEQmhfndA8v/Y305BuyglgdrADYxAn4F3Qx3ZzKM+poht9AW+2E3pk2YD/nFZarR+p/YpVEjsDxbp/sS221M3Tac77K0jELEygafG7NCwnA8KFquNVN40ElCHrsoH6o4VcZo4liVRpUiOsfuw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14738FDBB77224FA600C85C47176E1D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea913861-1e5d-4684-05e9-08d58db3414f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:02.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCAzNGEwNDhjYzA2ODAyNTU2ZTVmOTZmMzI1ZGMzMmNjMmY2YTExMjI1IF0NCg0KRG8gbm90
IGNvbmZ1c2UgdGhlIGNvbXBpbGVyIHdpdGggYSBzZW1pY29sb24gcHJlY2VkaW5nIGEgYmxvY2su
IFJlcGxhY2UNCnRoZSBzZW1pY29sb24gd2l0aCBhbiBlbXB0eSBibG9jayB0byBhdm9pZCBhIHdh
cm5pbmc6DQoNCiAgZ2NjIC1XbCwtbm8tYXMtbmVlZGVkIC1XYWxsIC1scHRocmVhZCBzZWNjb21w
X2JwZi5jIC1vIC8uLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2VjY29tcC9zZWNj
b21wX2JwZg0KICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gc2VjY29tcF9icGYuYzo0MDowOg0KICBz
ZWNjb21wX2JwZi5jOiBJbiBmdW5jdGlvbiDigJhjaGFuZ2Vfc3lzY2FsbOKAmToNCiAgLi4va3Nl
bGZ0ZXN0X2hhcm5lc3MuaDo1NTg6Mjogd2FybmluZzogdGhpcyDigJhmb3LigJkgY2xhdXNlIGRv
ZXMgbm90IGd1YXJkLi4uIFstV21pc2xlYWRpbmctaW5kZW50YXRpb25dDQogICAgZm9yICg7IF9t
ZXRhZGF0YS0+dHJpZ2dlcjsgIF9tZXRhZGF0YS0+dHJpZ2dlciA9IF9fYmFpbChfYXNzZXJ0KSkN
CiAgICBeDQogIC4uL2tzZWxmdGVzdF9oYXJuZXNzLmg6NTc0OjE0OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYT1BUSU9OQUxfSEFORExFUuKAmQ0KICAgfSB3aGlsZSAoMCk7IE9QVElP
TkFMX0hBTkRMRVIoX2Fzc2VydCkNCiAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQog
IC4uL2tzZWxmdGVzdF9oYXJuZXNzLmg6NDQwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNy
byDigJhfX0VYUEVDVOKAmQ0KICAgIF9fRVhQRUNUKGV4cGVjdGVkLCBzZWVuLCA9PSwgMCkNCiAg
ICBefn5+fn5+fg0KICBzZWNjb21wX2JwZi5jOjEzMTM6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmEVYUEVDVF9FUeKAmQ0KICAgIEVYUEVDVF9FUSgwLCByZXQpOw0KICAgIF5+fn5+
fn5+fg0KICBzZWNjb21wX2JwZi5jOjEzMTc6Mjogbm90ZTogLi4udGhpcyBzdGF0ZW1lbnQsIGJ1
dCB0aGUgbGF0dGVyIGlzIG1pc2xlYWRpbmdseSBpbmRlbnRlZCBhcyBpZiBpdCBpcyBndWFyZGVk
IGJ5IHRoZSDigJhmb3LigJkNCiAgICB7DQogICAgXg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNrYcOr
bCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+DQpDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFt
YWNhcGl0YWwubmV0Pg0KQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KQ2M6
IFNodWFoIEtoYW4gPHNodWFoa2hAb3NnLnNhbXN1bmcuY29tPg0KQ2M6IFdpbGwgRHJld3J5IDx3
YWRAY2hyb21pdW0ub3JnPg0KQWNrZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0u
b3JnPg0KU2lnbmVkLW9mZi1ieTogU2h1YWggS2hhbiA8c2h1YWhraEBvc2cuc2Ftc3VuZy5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5j
b20+DQotLS0NCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZWNjb21wL3NlY2NvbXBfYnBmLmMg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZWNjb21wL3NlY2NvbXBfYnBm
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZWNjb21wL3NlY2NvbXBfYnBmLmMNCmluZGV4
IGNiYjA1NjRjMGVjNC4uZjY4OTk4MTQ5MzUxIDEwMDY0NA0KLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvc2VjY29tcC9zZWNjb21wX2JwZi5jDQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZWNjb21wL3NlY2NvbXBfYnBmLmMNCkBAIC0xMzE4LDcgKzEzMTgsNyBAQCB2b2lkIGNo
YW5nZV9zeXNjYWxsKHN0cnVjdCBfX3Rlc3RfbWV0YWRhdGEgKl9tZXRhZGF0YSwNCiAJaW92Lmlv
dl9sZW4gPSBzaXplb2YocmVncyk7DQogCXJldCA9IHB0cmFjZShQVFJBQ0VfR0VUUkVHU0VULCB0
cmFjZWUsIE5UX1BSU1RBVFVTLCAmaW92KTsNCiAjZW5kaWYNCi0JRVhQRUNUX0VRKDAsIHJldCk7
DQorCUVYUEVDVF9FUSgwLCByZXQpIHt9DQogDQogI2lmIGRlZmluZWQoX194ODZfNjRfXykgfHwg
ZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChfX3Bvd2VycGNfXykgfHwgXA0KICAgICBkZWZp
bmVkKF9fczM5MF9fKSB8fCBkZWZpbmVkKF9faHBwYV9fKQ0KLS0gDQoyLjE0LjENCg==
