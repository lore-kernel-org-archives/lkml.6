Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246476-2-10723716647736126804
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
    1523246476; b=aWMji6TQcpjH6KQFmTjriR1BI4ykGSlnoqqL6Ye33E8eWxSB9b
    TwR+3HRo39SIJDTQMTr1CxIRxEyC6+T33YGAWPD6qEEIInOz0p6M27uqKCLTPeDY
    KloryFug5PIM2QeaA+d4evTfGgZwK9Anst2QtyA0ZgYwDUULx3oNoM5zhMS5VnYI
    r7kUzumIQw5QYp+PW+QxOIS6ekWyioC4qfiQ7tTRENm0swNGztg/JW1iqKD9MdNx
    p4nRMTEvWhI5ZlICslNFq+OXjWIf/8sSuaaHTMc/66su7HmxC7tZgTU1FFtWZtmp
    dZaXZvSvNC84Z1DHuKFe9rTQAzfUXypaqYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523246476; bh=0Yu0n37Xgq1EGNYJt0eBxeU7qpHF0Nu+wW9jbFkq04I=; b=
    tfgxp4xggdDqXEvvqEzmyIAIkt/fLDPLeh7XMsZbGjbZ9f0bbLEYZ48EBx/Xc9yB
    xvd20A7dV5U/tmNwdQZUs1DLil3d/ViDQsV8PENddk3urTmePy/P1zXiSHVoqc3d
    yHxeX8r3scffLnRUKIDZDW4bGKt8tHubgBr6CLHZLqOQ+PP2yvBGaHy+Y2o7kmqM
    Pwmb0G2QRXCvWz/5NI31EunGb1gthEKRjolQC1EjXXyX7pG80OVZWfvnhYbpM8L4
    gfWC5zHzOcMvmaAWbIlWLJ0JDetIgTlfJC/uC2Aj4laTyJ97+xX0wkBP4J4T7twU
    KzByfJc5OidGs16+vObECg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gma2Jgff x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Gma2Jgff x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ+x1Ouz9MFrmj1VRmuGYmKMgPzqe3JapEOEYNUuRKyQR9sK6DzZgh7lgR8ghVbEB+sXkbyrpHimXIkEuXajLXZcETcbtIIV3VzNT/7bwxzfme68oRUB
    2ZioY4jkEYrCI8+cUvy3+5KFDAkDgdf9kS6iPdEzq2Jwt613JMJyfhEwFhwmtPV/6lBJAUdf2O7a2EH+Q2y8+AQvfQPoLQUbyDlWPvWmMwMzx9E3QtqKGpgq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=f5JUautJF78rpD-wVU0A:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeDIASM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:12 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753061AbeDIASH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 051/189] watchdog: sp5100_tco: Fix watchdog
 disable bit
Thread-Topic: [PATCH AUTOSEL for 4.15 051/189] watchdog: sp5100_tco: Fix
 watchdog disable bit
Thread-Index: AQHTz5gj08DRJ4Be7EmMkIdUeB8kRQ==
Date: Mon, 9 Apr 2018 00:17:26 +0000
Message-ID: <20180409001637.162453-51-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:1D7fPl0N98S6heOoqCsWTYEmrG+60Wee/s0E+6hxdROZaq6qqlyg2NqgZZe6ZKjt7yxvns9tvoKfQAOKTou4IK5e34yMw15EvFEdCSav41DRtwbNX3+HmXgnly76eGnBcpLFD5dCOkhEsQqtcK07Q7H8Z1ye+XA60k0jDZesmqXSdLyWx8B37/6KSmTtEJXuWZw1pHMrU+BKKcma5YfZgqZ/mTPW4OmVZHoLG61lPQDd5v36A+WtPuvfiKb7gE9a;20:BM+FqclT5z1c8r0t/uSfqPd2SWMQulWFFX0RmXaf3I6eSzMuXFksZimOWvFJcios6iwjAy8NWCr6iTLUIRFbyN9y0s68l3pMdLTKjuHMWOy7Tek17z77nuKD53BKQT1sPtYKt6YqiU8tSXP797uhCAkYJhlfSDLf3+oLHa3lFoc=
X-MS-Office365-Filtering-Correlation-Id: e526367a-8690-470c-7f06-08d59daf55e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046885BEA7E88067590B0D1FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Zsh6drJqsVrdUuY1ASlBzfynXZkJ+lkStQWW/HssSkIFKn6O5rV1h+6ajImc/SPsiYj1RS1DLGhLDS0qA0SloacFT5mn6pqhgd3ZsE7jZ+Iht2+mWRKeG9MHLVn+oZbx0hQOIgfhnJxchbHjmQhtvLEkIJJh+GvXwbk+MFC/U2L9lOhPUcI40+frLsBo5pQNtkaUVIXvIiX/KwpaLgtLXEIluzVjnIC/KeN6g7QPAiD3BopYT9jYzjZ+PqTR6hCo/gYzw/XeudT9iRY9T9FpkOjFkZ8TAw4lmpg4nuFZzijoEuFkPtQXfXMwQ5LJnrjjlVrjVOYIHdTQEoiNzHuQ4Z9spWe5yZ3txp9qFQL88TRWeF/652bz8kUhjAGetzm5J75CnmTlywgHHOuJxGjxRcrrEWzHvwQCeFCQLgubYNw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F356119EB24234D81632C1CC6AC0FFF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e526367a-8690-470c-7f06-08d59daf55e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:26.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
NTEwMF90Y28uaA0KaW5kZXggMWFmNGRlZTcxMzM3Li4wZTI0MmQxMTEwY2UgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3NwNTEwMF90Y28uaA0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
cDUxMDBfdGNvLmgNCkBAIC01NSw3ICs1NSw3IEBADQogI2RlZmluZSBTQjgwMF9QTV9XQVRDSERP
R19DT05GSUcJMHg0Qw0KIA0KICNkZWZpbmUgU0I4MDBfUENJX1dBVENIRE9HX0RFQ09ERV9FTgko
MSA8PCAwKQ0KLSNkZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAyKQ0KKyNk
ZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAxKQ0KICNkZWZpbmUgU0I4MDBf
UE1fV0FUQ0hET0dfU0VDT05EX1JFUwkoMyA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlP
X0RFQ09ERV9FTgkoMSA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlPX1NFTAkJKDEgPDwg
MSkNCi0tIA0KMi4xNS4xDQo=
