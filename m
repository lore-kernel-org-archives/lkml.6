Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243427-2-16529495464417468403
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
    1523243427; b=mTbt3BGpx28oGcZeJovYD1WTPVfZQzg+25mKT1NsgM2WLpX4SK
    SoluaJ1+zh7LDtaGpVXoRt1Q1CfVPoB7/OVPKf8ygbyC2tiQk1sg48Z72HZyh3sh
    XGQwFxRwtNTvdPNxlhPVFAQWcZyyOokeF+EPtFUmgRKmdr5KCn06CNQJ5OWdplr9
    iVggDnttf9320/mC5XaYDyQQGNEdQRwHFN9a2DtEPPaJzvmK50Rr6x6r9srkN12u
    zA2zDU3HYzASa97rfXlC/wRhYmiM64kWJsrza/2P4N2v8x/KQJP5PXCybzIgl9Mt
    3pv/XXVU6mRk2gqLIoOsNqUnot3krj6ZwrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523243427; bh=dP0FQsrczFchEMy/OH3yD1clO5+r2paaelzSqvOapZU=; b=
    Fnr4rYKHglfUYDateCVP2/7p5G3uvLNxE42nxA/Gxtpdf9NW5YLkJgaJFs3xEhFI
    RAJLWRQtpVc65Ag61V9A8A54vq/2Mq8wkltLvY104Et+u3Ol9KTSNNVOEnXNmJTH
    UZhi0tEpgUDovRRHirqM1OO5xVAKpxsszQ8XFmploCppVRU5LeUDJn1YkCxWOivT
    tjIN55ChT2a7ve+JF5y70lXhYeHhEss0poL5FxAbyBRHF3jfDTT+ZRUSbhKXGS93
    g1JHoF3ap8Z55zIukqtOQ7mggdrrdHzfur4dDOoZYGRUi2rUpAeH/qGzdYzJl5Rs
    OD4nBRWheb/YnACERUaGfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R11zf8/b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R11zf8/b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP0CvLV1TQeSIKYc/GfcHyDYnEuVal/JmlTNIPccfXAOZU4id22nGjNiHB9bbA+s34i7ZrmtoCPAgGTLNF77waruRY+Sgly8MMeILWtVf71j9wYzgEq4
    nqGsfiLT2xdYEbe81KM7PVxQz5J7Tv3rVh3HvadVgo+iX1Y14mE+PUJPWMTiST2nJeAA3P12o8EEsoI8skf+o4BDw7wyy6Sfe5yEnicH0l0OFWbDEfJgRNXG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=edGIuiaXAAAA:8 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8
    a=yMhMjlubAAAA:8 a=c6t4oUsiJohOfOJFmwwA:9 a=QEXdDO2ut3YA:10
    a=4kyDAASA-Eebq_PzFVE6:22 a=AjGcO6oz07-iQ99wixmX:22 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbeDIAYc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:32 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754984AbeDIAYa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 084/161] samples/bpf: Partially fixes the
 bpf.o build
Thread-Topic: [PATCH AUTOSEL for 4.14 084/161] samples/bpf: Partially fixes
 the bpf.o build
Thread-Index: AQHTz5ifhrHmjRig/EChvR1FCpQ7lw==
Date: Mon, 9 Apr 2018 00:20:55 +0000
Message-ID: <20180409001936.162706-84-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:PUsuWachP7mMJQU4D7a0uRsc+c3ChAZXTGhBbcbU3GxUw/NKkpOpIz7WKu/1b7yJQ6XvxsVMUO7XPkXtHkNUM+KeKKaVcg55FWA7thn7WVguiVYUJm1anPO4X0oGybWpzfQwbDExj9ox6WWW3/f8ZgYU6fN/kTIbxXF/kU9SHqWbQzfEwdDbLsBeBJyMfhiEFlusbfzgnc31L3mqsF9GcwZa+PNI4nZmnuDHkVZVqQg7TvAM8fluJLLwsF0MI7ey;20:K3HOfQk5Ta/Y2UMw/MkIBEOdg1lbm1hoZI5y4PQj1kJ9ZqZJw4uUN6KU4Hr1k/QENVQ2GeeqdXBj8J1NC80YXjrkXr5sF7f4aJEUH05T0VLDUvTZsbRgmaBFGagT4QiP3EJhHTpWoZNHKxL+I2/C+Na5fhFgEX+k8K0FMYD3NHw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc5d8c1f-b969-4c2e-ac3f-08d59db04132
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098431B371E8212688DF9418FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SEx7AzbZJkpiTQUsHvnR8vVqxC0Nq9xAT6a6BVYPxrGX0LdE0poJ3Q1F7hTdhgD3rBWxAeSTmcM8jxa89KV1ccz1O4ag5ZZ95DjkUeHt/iX0mAq9fGfcxjLSGG0yXhdr7/bMXIQ2dFhxDqKjdmiZNm3xWuiik9DnH+bdShHKaa926YC/P2M9xE5yEavQp/tPifMaxL+0AQjtRzTYelG0X3w9QpbXyqn6ZdJpDfvoH8OKxyml2lW8QwjpAuMorqZSZFE6o2UpLO7F68ej6AbxNwaZIPE3iA6td5ToDXGxKdZaLEXPm9v++ZfGnEpglNt4WodaOvnPZ4JyDwHIy4AZbT1ee5tuqZLcHlMcLWOkI303p8j7sVEQ6Mhh2ZtImHJmFXNqiaaNHmoiPMCJ8+Pgdo9a74kjJaWq5uKWbZCnOFM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <716B6D8EF9631D41B5A2ADC9B7527564@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d8c1f-b969-4c2e-ac3f-08d59db04132
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:55.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBjMjVlZjZhNWU2MmZhMjEyZDI5OGNlMjQ5OTVjZTIzOWYyOWI1Zjk2IF0NCg0KRG8gbm90
IGJ1aWxkIGxpYi9icGYvYnBmLm8gd2l0aCB0aGlzIE1ha2VmaWxlIGJ1dCB1c2UgdGhlIG9uZSBm
cm9tIHRoZQ0KbGlicmFyeSBkaXJlY3RvcnkuICBUaGlzIGF2b2lkIG1ha2luZyBhIGJ1Z2d5IGJw
Zi5vIGZpbGUgKGUuZy4gbWlzc2luZw0Kc3ltYm9scykuDQoNClRoaXMgcGF0Y2ggaXMgdXNlZnVs
IGlmIHNvbWUgY29kZSAoZS5nLiBMYW5kbG9jayB0ZXN0cykgbmVlZHMgYm90aCB0aGUNCmJwZi5v
IChmcm9tIHRvb2xzL2xpYi9icGYpIGFuZCB0aGUgYnBmX2xvYWQubyAoZnJvbSBzYW1wbGVzL2Jw
ZikuDQoNClNpZ25lZC1vZmYtYnk6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4N
CkNjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPg0KQ2M6IERhbmllbCBCb3Jr
bWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQm9ya21h
bm4gPGRhbmllbEBpb2dlYXJib3gubmV0Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFs
ZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogc2FtcGxlcy9icGYvTWFrZWZpbGUg
fCA1ICsrKystDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvc2FtcGxlcy9icGYvTWFrZWZpbGUgYi9zYW1wbGVzL2JwZi9NYWtl
ZmlsZQ0KaW5kZXggOWI0YTY2ZTMzNjNlLi5jMWRjNjMyZDRlYTQgMTAwNjQ0DQotLS0gYS9zYW1w
bGVzL2JwZi9NYWtlZmlsZQ0KKysrIGIvc2FtcGxlcy9icGYvTWFrZWZpbGUNCkBAIC0xNzksMTMg
KzE3OSwxNiBAQCBMTEMgPz0gbGxjDQogQ0xBTkcgPz0gY2xhbmcNCiANCiAjIFRyaWNrIHRvIGFs
bG93IG1ha2UgdG8gYmUgcnVuIGZyb20gdGhpcyBkaXJlY3RvcnkNCi1hbGw6DQorYWxsOiAkKExJ
QkJQRikNCiAJJChNQUtFKSAtQyAuLi8uLi8gJChDVVJESVIpLw0KIA0KIGNsZWFuOg0KIAkkKE1B
S0UpIC1DIC4uLy4uLyBNPSQoQ1VSRElSKSBjbGVhbg0KIAlAcm0gLWYgKn4NCiANCiskKExJQkJQ
Rik6IEZPUkNFDQorCSQoTUFLRSkgLUMgJChkaXIgJEApICQobm90ZGlyICRAKQ0KKw0KICQob2Jq
KS9zeXNjYWxsX25ycy5zOgkkKHNyYykvc3lzY2FsbF9ucnMuYw0KIAkkKGNhbGwgaWZfY2hhbmdl
ZF9kZXAsY2Nfc19jKQ0KIA0KLS0gDQoyLjE1LjENCg==
