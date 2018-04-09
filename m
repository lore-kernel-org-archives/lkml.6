Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236481-2-4572416224576812397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236481; b=FOQBTGZ9WVmlLkWJKHGg2lPCQsYZv1r/VeJdvnnIt6DHmFE09O
    Gi+VhPdDbTxtEDIK8422wLZiprna0Pj2/AsejHubc4FDOBo4wpC+wBVPQ/cRYs0R
    1NuG54jWDRypRmJcvln7D8RNScF1op1f8QuJTS4VoIqCCR3v/n07sqiowfWpn8Ze
    adRaJ7ZZNYWoQ8MMwIi5UObkht0s/RJSZio1tudQdhT2d0BOKvYbFhW6ml23kpYb
    OudGY1btwvThDBpP/C25dD/r6/dNdfj0TXTN0ZJPbDZhLvLHSfH25hHqtkIjRvcP
    i5HE0eqsuzbXqSroT+VDOtihWdnu46kLJLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523236481; bh=wI0DUnIXrjy/ZEizONRDke04mRf/7s7fxUkYMQuf6qU=; b=
    AQMgDeZDu16xMQxEy+aMDrST3o0IXdH5Zq6B+hMw4JeukO7uJf7ofqQ/s4h6iNpr
    of+4mt/ATajU7qWEXyL+FT8O4z480S6XYzUwr3lgzRbHLoe/tEJIdn4IL2BJ+gRj
    ox4En3wIsIWmmPbWtoOMjxdcOSOMFxr9cFr0NJBw9VbICschKxHc62Vn25z+A8ZW
    8/ZT/JamnEaqYLsGJvgDT/eUzDV/RnkVYRBC9IJbiFhPZRIojt/oZtnB3vBBwRIS
    mA/YdhES9qjiswUGAZKGfcH8mgi3snBGBhPtohZG9pYPFXeiPYlckYJ9i7AQsOEa
    gtRNfiJDSzxdoAXwMaI3kw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TbfaLL9N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TbfaLL9N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmP7Dlx2xh8C6ceXdsi77vZ4OWHr4r5/Jc8xem81kY4MLGADEnKuUJ9h1MI6XBg9b6HtrZZO40OOz+J4+aOVvdlaVHq2Wwr5WS3y51Ii2xAZ/1U18aU
    53ZpDQMg8+S+CyACvBgg/rdl/P87EakN93TyvXXa7PL4ILNC26OiUjaijIosjaF16FkjiSmrNXh1kE7IsuUNFLG/7ifjkorQdSpxr0LwXTZjdN8dqHblKC4I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=f5JUautJF78rpD-wVU0A:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756475AbeDIBOL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:14:11 -0400
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:17312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932912AbeDIAiB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 119/162] watchdog: sp5100_tco: Fix watchdog
 disable bit
Thread-Topic: [PATCH AUTOSEL for 4.4 119/162] watchdog: sp5100_tco: Fix
 watchdog disable bit
Thread-Index: AQHTz5nLL5+2q6oAn0anKr68OT62Aw==
Date: Mon, 9 Apr 2018 00:29:17 +0000
Message-ID: <20180409002738.163941-119-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:c6OyqWTWWKHhDQ44ZUQCl5R9HoqyRklw68kjzLqZq+TYVxlf6Hp/CuDwuTbJQ4xXfnS4Py3u16iCp0A7uW2AkVS6d9L5lhXog8uBGgCmGpy9u7tzDHph9atH0HLisnyFB66z0nf3kn0T3qnWsxZbdwfOICpWoSgcb/sSCYrFJqwK5i/1Ngcog92XLlsQZiEDPE4gsdaXKll5ilgCzyZ+HrMHomDFP0Dk8VwkS/GD/KOyWV4UN95ujJTgRcELs0+b;20:YMBWjEiUnFjWs2xZykeYr15FSXWk4yPxhfB9SwOvnl+GKRg1FEK4ajvyuvLjwxPc+mGlghmIJw11ZOh9DFueDvjw4WO8UsFUW+SHfFiYpOI6RNxc5Phs/s/03cNW/1X5vr5AJfn8O9jaMgLYvsJx6Naxd6keeGNYJurqIsDMjWM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34994afd-fe65-4d4e-0b68-08d59db224ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110086E442651C937918E7CFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: RtAmfTHJO7M6DGeQZCahJSsr6L2pOw2RcI7ExuqBtrorM7cPVZVFISxHzQjEE5c/4Dx+gFOEhfifdDB2p3wHVG8FtfDFlCocPLyVRxX5uKMrW+scxAzZvcSwGsbu7S6vgxqbbRvNw42DK0DioagpKb9bp3TzMyo6AiLnM0RLXYBkzoM5M1df5HbFmc23ShvpKhUvWf58MXJ0CUW4sT22H0HusI1yoTLTUP9hw6POcRtQDSnns/cTcOvs8YlarBKUymAAwcqgR0Ke4c2pm8n2DsPHXZ8h3MLZMWApKrCpd+b6l8ql4izHHtsrFlHk4mhD0mvNGAgB7XfKkQ99+M4MxXGdsQwvI2AsQzHXAYK0yOKl+i/dy4fXxZzsb9RhW/I/BVU/92VkdRtXTsbbSlJ6xcfSM1q7gjDj8CLKLnNIBFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9F068C5D9EE37408BF51746F56662EF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34994afd-fe65-4d4e-0b68-08d59db224ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:17.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBmNTQxYzA5ZWJmYzYxNjk3YjU4NmIzOGM5ZWJhZjRiNzBkZWZiMjc4IF0NCg0KQWNjb3Jk
aW5nIHRvIGFsbCBwdWJsaXNoZWQgaW5mb3JtYXRpb24sIHRoZSB3YXRjaGRvZyBkaXNhYmxlIGJp
dCBmb3IgU0I4MDANCmNvbXBhdGlibGUgY29udHJvbGxlcnMgaXMgYml0IDEgb2YgUE0gcmVnaXN0
ZXIgMHg0OCwgbm90IGJpdCAyLiBGb3IgdGhlDQptb3N0IHBhcnQgdGhhdCBkb2Vzbid0IG1hdHRl
ciBpbiBwcmFjdGljZSwgc2luY2UgdGhlIGJpdCBoYXMgdG8gYmUgY2xlYXJlZA0KdG8gZW5hYmxl
IHdhdGNoZG9nIGFkZHJlc3MgZGVjb2RpbmcsIHdoaWNoIGlzIHRoZSBkZWZhdWx0IHNldHRpbmcs
IGJ1dCBpdA0Kc3RpbGwgbmVlZHMgdG8gYmUgZml4ZWQuDQoNCkNjOiBab2x0w6FuIELDtnN6w7Zy
bcOpbnlpIDx6Ym9zem9yQHByLmh1Pg0KU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pg0KU2lnbmVkLW9mZi1ieTogV2ltIFZhbiBTZWJyb2VjayA8d2ltQGln
dWFuYS5iZT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWlj
cm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvd2F0Y2hkb2cvc3A1MTAwX3Rjby5oIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy93YXRjaGRvZy9zcDUxMDBfdGNvLmggYi9kcml2ZXJzL3dhdGNoZG9nL3Nw
NTEwMF90Y28uaA0KaW5kZXggMmIyOGMwMGRhMGRmLi5kZmUyMGI4MWNlZDUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3NwNTEwMF90Y28uaA0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
cDUxMDBfdGNvLmgNCkBAIC01NCw3ICs1NCw3IEBADQogI2RlZmluZSBTQjgwMF9QTV9XQVRDSERP
R19DT05GSUcJMHg0Qw0KIA0KICNkZWZpbmUgU0I4MDBfUENJX1dBVENIRE9HX0RFQ09ERV9FTgko
MSA8PCAwKQ0KLSNkZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAyKQ0KKyNk
ZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAxKQ0KICNkZWZpbmUgU0I4MDBf
UE1fV0FUQ0hET0dfU0VDT05EX1JFUwkoMyA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlP
X0RFQ09ERV9FTgkoMSA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlPX1NFTAkJKDEgPDwg
MSkNCi0tIA0KMi4xNS4xDQo=
