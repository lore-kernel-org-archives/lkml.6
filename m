Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241327-2-5356300767885839354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241326; b=E2iqTCDie0xyYJ8Qye9UjeRJ3fXn1x0zBzFvaw87UAARSSj8q0
    gBTAc/PtoBaioaegTEM9kW743/sw5svVeAfD9GCAMpFYlFUxhUwDEBhcq2tRBT5D
    EIiYvzYkWAaMC/x9pVVRkk2ItPR3Jm6MDwa5rT+u0L7pqQ5/fp+ZpBfjuxc4F7mE
    ygt8qrdMO9q7wphMuRc+aJu9Jijtm6gf0XzcOEGZv7a6iVpEp8ZvCeMCASdSn31W
    5LH35E/8JX8IqL4YMRsr1fKDs5AbizMzzdGhd3rWx2s9btxbLDxgmnr1LwVAe8Hk
    /eHbXUGKOVfau43EDq5dRz2aTi0MmRwJqoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523241326; bh=R0olzx2qq9RhCyb+XC/Mg9VxESCS+AViRzVWYOqm0O8=; b=
    UAKYgMiD1j86WRPhnY4rPRTigsKaCWu9B9SfWwLd7w8GX2egWiC5jI4CNxqIZo0s
    iNOxhF63Ja5uNs9u1MgvedSvxPyhYq3ocNzXFN0j9tKeZxYqJY6iNlgTqlh29Y5A
    Ck5GIrBaqAI5+8HV89NY7n6O3Np41ySxtNrGCaukqdYp8qM0X0XWOz0cvmx1rJFz
    Qk6O0gNvmj/ToqYZ/voBQ0OFILo72Jw6ahut7WeF03hIcCEYE0533PSqL3/S8tva
    ROlNv6gXboC1hXgOqfqojkWI3MuAWrsRz3XZ3Kj16gLnpqVFEY0dwQMERpVgpSt/
    HPLJo7FDj5XxNwq/2belNQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XqQrGnot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XqQrGnot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUQB8ncL59joOXLJnvCokabujs8X7ydYXP9N+OGvaTPa8ZAhM9K24W8BIurOcRO7BHtQH88TCXVbFw4iRsh7NoOWJ5ECAuqIsP5iDxgyGmz38jOAYSr
    OjSelz48wAh9y6jvekCAB/yKw3PwNVmJWA0vNTMpVu4mvuovStryzTZUsHWbHqw4jyDipRyKK8LtdPZQWRYmML543PA/+Kun3NNj5zwe2hVgY7fsLy1Yp3lx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=edGIuiaXAAAA:8 a=SOq6UgPBAAAA:8 a=cm27Pg_UAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=1EehLWispcOvLuCKlS0A:9 a=QEXdDO2ut3YA:10
    a=4kyDAASA-Eebq_PzFVE6:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755651AbeDIA1i (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:38 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:11355
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755610AbeDIA1d (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Will Drewry <wad@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 047/293] selftests: kselftest_harness: Fix
 compile warning
Thread-Topic: [PATCH AUTOSEL for 4.9 047/293] selftests: kselftest_harness:
 Fix compile warning
Thread-Index: AQHTz5j6wPCsgrzXCE6rQDzuqzC+1Q==
Date: Mon, 9 Apr 2018 00:23:26 +0000
Message-ID: <20180409002239.163177-47-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:+0xds+sOi22iD8Lr9rBtdSAU9NePHihv2J90oAMe2BU5cS8I4kq5Ym492KEHI+qrNJugw3M1V6bdl8FLq3dj/DzboxYkoiyBkyNpQoatT5ub0+AQEfkc7wbyu/o6eKUJw1BoO6YKuBq4awIeJeSpaJD6dCAoHxYy4tRSrOJzKFKxYiRRJ6yrfBjSHZboXvynIGB78NjHd/e4ZqQVh1MQ6hYQ9IhHm9qV7lclaR9Z+RxZX+qQ2k6zZJfw5ewpTNr9;20:rUX5JewDHEKPEe0XTLtKc7nouglENKLD6FLkMt9EkBlQt5vqyo4Ezq9QOZhAaTxt2zliiDC5LOirpUYo+sMyJ5XYi6U2gZpQ/5a1SCJXd4OhP02mQN6JTg1s1AXe4WedJgbIZSKQRnyzmQWO0HckNI5taVhK7bsyl2gWdihSdtI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae324828-ae4f-4d92-250c-08d59db0acd0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031B13700EB4EDBC827A24BFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Hl1raJ3AMik0olrIh6OxJzjMlg3WxSM1pOR3DUayCC+zxyrO2RFLMpaqywpUo829AVtQOHE3EQuBhWcLRSQTz5ZfdHezdhpi5+jntPZk3NxOi30wd60iTKQGlwdWwN9r3DfyH9EBEUF48E3bPms7c/p6rIDmh4oZ8MczLRvZWAZtLRJxtYqvA2EIlWFfGROAKv0ON77NHxxY2ZpaV3ohB3hdIfraeP7TtQZUXsa8LcRgPuoqld8/LQSoh/H409VRZrCmyOJv1gT+fjS0GY5aJVBmr2mD2LIZCjRBpuRXW0uLcAgNjkRmJaDnekk86oT5RH48NP9d1KeKVR2ufqFT2CwDcHSGskT7k13Wihyb4L/XZpCVjwAokAXyX/kMs47JJ2UtLLLomkklt2r01+MChF7Pf0qnE8I68wlmnvUB3g0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3119746C4D4A85418C7385FAC24D1AA0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae324828-ae4f-4d92-250c-08d59db0acd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:26.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
bmVkKF9fczM5MF9fKSB8fCBkZWZpbmVkKF9faHBwYV9fKQ0KLS0gDQoyLjE1LjENCg==
