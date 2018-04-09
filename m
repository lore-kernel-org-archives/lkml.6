Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237291-2-4744039937129822371
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
    1523237291; b=sd6E/Y3xjiNSwJPamh3LloXimHhdx0BkXCbd1kRn0BbzpZNkOQ
    vQW3337P4WF9xq5PcU91Mvl9/O1L6rlGLFBU2w2xVSnG0BcqY6lGJdiyOsIDmTOF
    jYS5r42lyBaOtLm3srkib0HJS8mp1OI9UN+f41B1MThryXPzpSjpZmOSAIUd0zU3
    Ui59/bF1/bZGSx148NUlmGSWACWT0ErXY/O9lfUFx7xeBVO06DN1U3kIKZ1bUmHL
    BRJVl1tXmeCgMVZZNY/xEAfjcFDXK0VY9twBy4PTkq+ltaBRXjI8FEa9X3EnpuvR
    dPmopRw2uVI3IY3wi4GFVVZcIlLr4J7D0dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523237291; bh=tcOMuIBLT3WsGUN586EeMNxc1x8ThUz3KAwdQD7Sz+A=; b=
    dAlZwd93gv9dwO2cwpc7TDq/s2mA0QpUSeBLEInkA3KIz9ocDpmmrcVnZeVChJDr
    ARHA4Xr5YET6gzR4hYq99y3+7h5vhKNgfmnR6g2jn21QQMDHlWGA+upJCzFDVH8c
    M4yR4iAy8UTnfKp5kQCukOQv9WaOKkeJ1G2MGAANLzCcyWu5RFfoqZYvY9ldLCtQ
    dkGroQ7rTGmk3nPIEo9xMk/s9wNIuVyadnTNMsX8Llqgy2hnwnlA4+mDQO7E+xWR
    Q0JstzxAOUJfwyj0JFnxkejJ2UiZS0GOTE2CV15WIC5ZBkUrpuDuhEqjAERmx6cj
    T8NqpeIDmKu+AmGsMsa5Pg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BGO8JAEY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BGO8JAEY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFydb+MlmJcCol7NIvlKkU/aXGUFQqgCljNUAoi0ldqGVb+9inKyaSzpFd8iUfpcuYkid5od6MBrnbMWVqBy3Muepo3Ca8g/xZYGZFqxC1Pl1yyp6Oc/
    NDHMfUNMgXGFvuGKti4DTNcZB0PpFxQf5F+iAk947GO9YrrKsZnUKAANLzBOycpFVTbQ4d/a1vPUErZuHWLHXDkqgC+gtPIav/GvXncoGdroIETKph0U6EhS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2VYn-sL6AAAA:8 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=stmduOJDnH9FryZnRoEA:9 a=QEXdDO2ut3YA:10
    a=BgzNFtnbkgrEfe--4AkY:22 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756689AbeDIAgN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:13 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:22256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756640AbeDIAgJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit@wsystem.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 052/162] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Topic: [PATCH AUTOSEL for 4.4 052/162] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Index: AQHTz5mp67ALs16KJEmjz787QyXsmw==
Date: Mon, 9 Apr 2018 00:28:19 +0000
Message-ID: <20180409002738.163941-52-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:MtZgLcdt45WiviJDZbxW9VGtL3o9I80o8vQ3OrzhEehaz3lvteN2EENo7NR5koadEgzLfWHSb7I9LLLH97JUIbrBZEVpqqVg/amljJNuyQsD1HvUSc228qhxCuMcebs7FlAzQTVExKEukYXVwHVfv/vRYQlvMEvv2k1XKhqBN/yW+cAkmMk0wooYSmxXnIG/ueaDnUZAGychsykOaLcyWpLcipJIo12FGz3NNiEHAaF/+hDIZXLK8yjrxxKVNPCv;20:pBXU5JHMYQ4Nw6JjFSXejqTTg16IvajkbkO9CUw67BOnxBAMWRKwRhQ8Kmafs9K5YiTTu6WTdz9dyWWEa5Vo2IQtgK4tZajjDcW9CY7skfB7+xwC7xU6khHGEqsbLwXx5u/0ikbaG6L64qtrsxqLdObb+YaFGQFwTAguex12Ieo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ff93ebe-2ccc-45a8-934a-08d59db1e22d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10154756AA630892994F1B11FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(15760500003)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RU4I7LgbFPip+1QsnmfGz9DLf79wCP0Ddey+kN2AAEbD/iG+V+2o0sXs8XgtDyPAE4u35duveqThfUvFiDClnYLdK4I79/UmPnIcu3lMUfHs5smjDsEWd4ct/JeZ4DIvpdVhf1mHdq9axTDKuqAz+yRveasV51ENbQp9DbxULNQBMO2mAnXWg/Qgr9ix4pADI6bJc2sYe4uFmHdSpqkLXZO6kvQIc/HefibN39iLr71e1wmJf337m5jvqhfFPiqzdsaqn9ymsMwOZX4NFSgcJkA3zxP2cN8vprL4PHI2Lg/BJQw8rrRMlGzNXOtK38UoSo9VWPhhFWnLjWHiTJRcvio6XTXwE6eOaZLcUMpdMB34ObGDx+FCF89beH8oc3wMk71uxoQXiEx9EZHf1LO28LvVD3C0mN/1WUwV5fVzHHk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AF44E90E2EADF4CA98DCDDD835C9DB7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff93ebe-2ccc-45a8-934a-08d59db1e22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:19.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQmVub8OudCBUaMOpYmF1ZGVhdSA8YmVub2l0QHdzeXN0ZW0uY29tPg0KDQpbIFVwc3Ry
ZWFtIGNvbW1pdCBjYmI0NTA5Mzc0OTYzYmVhNDQwYzE1ZmYyNmUyNTAxZDE1ZTc5MjdhIF0NCg0K
VGhlIGVTREhDIGNhbiBvbmx5IERNQSBmcm9tIDMyLWJpdC1hbGlnbmVkIGFkZHJlc3Nlcy4NCg0K
VGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIHRlc3QgY2FzZXMgb2YgbW1jX3Rlc3Q6DQogIDExOglC
YWRseSBhbGlnbmVkIHdyaXRlDQogIDEyOglCYWRseSBhbGlnbmVkIHJlYWQNCiAgMTM6CUJhZGx5
IGFsaWduZWQgbXVsdGktYmxvY2sgd3JpdGUNCiAgMTQ6CUJhZGx5IGFsaWduZWQgbXVsdGktYmxv
Y2sgcmVhZA0KDQpTaWduZWQtb2ZmLWJ5OiBCZW5vw650IFRow6liYXVkZWF1IDxiZW5vaXRAd3N5
c3RlbS5jb20+DQpBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+DQpSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPg0K
U2lnbmVkLW9mZi1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQpTaWdu
ZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQot
LS0NCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLmggfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMuaA0KaW5kZXggZGUxMzJlMjgx
NzUzLi4zZDZhMDA1YWQ4OTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVz
ZGhjLmgNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMuaA0KQEAgLTE5LDYgKzE5
LDcgQEANCiAgKi8NCiANCiAjZGVmaW5lIEVTREhDX0RFRkFVTFRfUVVJUktTCShTREhDSV9RVUlS
S19GT1JDRV9CTEtfU1pfMjA0OCB8IFwNCisJCQkJU0RIQ0lfUVVJUktfMzJCSVRfRE1BX0FERFIg
fCBcDQogCQkJCVNESENJX1FVSVJLX05PX0JVU1lfSVJRIHwgXA0KIAkJCQlTREhDSV9RVUlSS19E
QVRBX1RJTUVPVVRfVVNFU19TRENMSyB8IFwNCiAJCQkJU0RIQ0lfUVVJUktfUElPX05FRURTX0RF
TEFZIHwgXA0KLS0gDQoyLjE1LjENCg==
