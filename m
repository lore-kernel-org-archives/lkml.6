Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233192-2-9285698132063437516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233192; b=d0Ak8ZPwIilwBK5gF5zOST1ONqs3/51c5f9tCvoaLFwaYmKHFJ
    UWQ8zeGk5tL4a/JZ2pUJ80hC5G6SFJLhUVibZUO2jIKr/SCb4V2M4v3Q4KHH8f/P
    c428R3IWvqg7F2AQac7DXOcCAbtrAvtCFEei8TR1F9ISPW8Wp4dBkx2Zm6BQ7jET
    bz/4qPtzS9dBsTiuzfmuCfpLw4g1ogdUOcEmubo0qMeMrslHRJuftrnl2U2pqbBr
    EZ+CHGaGNd31SlcAuJ+O4E4nFqcsZDP0ybHanEE6PR/w1x1LvGPZaGMyea7dp0JK
    DAsTdhiy39lg+6yEOIcV2UA2f1h6Rdf5Atvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523233192; bh=epXvEeuVbPt9H/htXWGgTHxK7J4Jh+DSCO9HUeyxs5E=; b=
    CQqqfuDFsSXHpoqu7DNn6y/0w5BX//rZyoDmm5l7Abdg41ZjH8e3NbzM1Xy47QFt
    BNRp3WSDW6B+EfLPvsooMgEVg1OpudRBqac4Wtlr05xOfbjqN9oHcrsvDkkCu0zT
    kzCWpSx1GGCwdVx1BzTsqpcNjPIw09vdlBgSB4MTz2ErZ54gwgpfEPIRtyqaXBra
    3v0CumvlEFp08bNxjVvqzTt8U2DgI6KLQZjlQXBCz+gmBw3pjTzZU9NOzgP4m9BU
    Oq2/gy5nCPB90Mml+7+M3AuGov/coeoHaPhcbieaS7WdfB9gUv0GCzV3DwbMgCSd
    J8hiQ5FJRaI5K1GoOXUWvQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bqfuei5k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bqfuei5k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfErFQZg6lE12I3txH2sE8CAA/0dL7bIqfH8GlhguaIVD773fy1vdmrrIsbk2iu3ahGLpcWHWzTdaCH5eTRktRBfFbvWdaS9vuEaoQKp3Mv4cRoq/HjDF
    1jyWSs+kE3bwIIqx11kWJG4LDHzAaL8bOwlA+iA7i8WURx5lWBU6zMNH64wPNwIJ680zRJjSYWr+JDIL+KHmMqnr+LgBH4e1Fyc7IPR1J76w4t/ioA1MFHnp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=pgxZd55qGeuizeMcAicA:9 a=t-GLsDH5aVKfWNKI:21
    a=Ghei6ysmniNjMF_d:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeDIATg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:36 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:14464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754082AbeDIATd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 115/189] fs/dax.c: release PMD lock even when
 there is no PMD support in DAX
Thread-Topic: [PATCH AUTOSEL for 4.15 115/189] fs/dax.c: release PMD lock even
 when there is no PMD support in DAX
Thread-Index: AQHTz5hBRdV57VsfqEGkRZbKdfGifw==
Date: Mon, 9 Apr 2018 00:18:16 +0000
Message-ID: <20180409001637.162453-115-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:KULVmrMQE1f+yfIyPjxV7C2KV/GOHyTcqN395gNaYZBRGtJVVxbbDq089yD40scw7PmHjnsJHe8FaLlWSVWGNKUna+y83lPEyAmKNu2W4IepbDX3f6yRuziWAMIdh5WccrjfBizWiMv62A/Z8UswKbgotLlLFLBg7ioYv3KFmX6s1IArnFEZycq5kD/zghtXVs8HK9q+/MxSXh+U11wKIItxvqagOnI2NizhSCGDXd1kRMzZ3gqNCDQMIVa9q96p;20:5PLlRSDvJNxeaudAR74EZ3b3dw0i7qK9BadBGIaeqQ/7p6H+1fga/sid1UDT70eNiX5f5iysXee0p0eybvbA8nxIi5vpRlSH2BXHHYVE1uEratq6laj9QmULmfivibF8LY2y3QP/qLN9NVFLacfxSJRV6XKjXg9RSKF/PKjsLx0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 680a4fc0-7ca4-491b-f3f9-08d59daf8e6d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C89960062E3ECDAFF63BFBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(575784001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: th6rQ/wNcIfzKq27j9XemFy6xIMGgdB7ERzHwKymQ5lGuffbyu+2Dr3KqFBReVPLnPDOXe8Mxw0SnVAHDmKAFH2xce3S0eYDpIyoRK4c0gR62FbvJhcENlXPXiOpwUSiBQyxGG2aC1a/NA3EEVD0AnD+j8Av6Fe0CIsfru7csEApF/kUm8O3LRlshKIlTbj37NDVTuDpiZPEG/jQ8N6+JR1ntkjKWyYbwk3/E8RHxsBUmjz6llKkpdRGEQ6FHEZQ4H60AADdz9looq21gWJgK6jRx2EWzP/GFGMSa+qpqiUO6+E67jB6QE+nTX/2kgIxwsx/QxCmFplaJkuy1ZHu3hzH7dalO/WAVzD5MLKIiQHpZTlQO7tiA1JvlvbsOMxznwu6znWtBDuddBY4GWCA//+kGOypCj05XDIR/lPS4J8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <544744B19DE62140B5516E76839BE1BD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680a4fc0-7ca4-491b-f3f9-08d59daf8e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:16.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuIEguIFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZWUxOTBjYTY1MTZiYzgyNTdlM2QzNjE4N2NhNmYwZjcxYTllYzQ3NyBdDQoNCmZv
bGxvd19wdGVfcG1kKCkgY2FuIHRoZW9yZXRpY2FsbHkgcmV0dXJuIGFmdGVyIGhhdmluZyBhY3F1
aXJlZCBhIFBNRA0KbG9jaywgZXZlbiB3aGVuIERBWCB3YXMgbm90IGNvbXBpbGVkIHdpdGggQ09O
RklHX0ZTX0RBWF9QTUQuDQoNClJlbGVhc2UgdGhlIFBNRCBsb2NrIHVuY29uZGl0aW9uYWxseS4N
Cg0KTGluazogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzIwMTgwMTE4MTMzODM5LjIwNTg3LTEt
anNjaG9lbmhAYW1hem9uLmRlDQpGaXhlczogZjcyOWM4YzliMjRmICgiZGF4OiB3cnByb3RlY3Qg
cG1kX3QgaW4gZGF4X21hcHBpbmdfZW50cnlfbWtjbGVhbiIpDQpTaWduZWQtb2ZmLWJ5OiBKYW4g
SC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPg0KUmV2aWV3ZWQtYnk6IFJvc3MgWndp
c2xlciA8cm9zcy56d2lzbGVyQGxpbnV4LmludGVsLmNvbT4NClJldmlld2VkLWJ5OiBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IE1hdHRoZXcgV2lsY294IDxt
YXdpbGNveEBtaWNyb3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmlu
IDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGZzL2RheC5jIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZnMvZGF4LmMgYi9mcy9kYXguYw0KaW5kZXggOTU5ODE1OTE5NzdhLi5jMmViZjEwYjcw
ZGEgMTAwNjQ0DQotLS0gYS9mcy9kYXguYw0KKysrIGIvZnMvZGF4LmMNCkBAIC02MzYsOCArNjM2
LDggQEAgc3RhdGljIHZvaWQgZGF4X21hcHBpbmdfZW50cnlfbWtjbGVhbihzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZywNCiAJCQlwbWQgPSBwbWRfbWtjbGVhbihwbWQpOw0KIAkJCXNldF9w
bWRfYXQodm1hLT52bV9tbSwgYWRkcmVzcywgcG1kcCwgcG1kKTsNCiB1bmxvY2tfcG1kOg0KLQkJ
CXNwaW5fdW5sb2NrKHB0bCk7DQogI2VuZGlmDQorCQkJc3Bpbl91bmxvY2socHRsKTsNCiAJCX0g
ZWxzZSB7DQogCQkJaWYgKHBmbiAhPSBwdGVfcGZuKCpwdGVwKSkNCiAJCQkJZ290byB1bmxvY2tf
cHRlOw0KLS0gDQoyLjE1LjENCg==
