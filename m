Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235329-8-2828595096016116104
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
    1523235328; b=RDjXhMfEmj/FmDwia9OWiJaDBsaxOamLZMjKB8Oh3jzJfzMuED
    cxWa5OOoHIy+eyXNMjm5ovTarQajafm4RRcq5trIWm4M9kSokieV8AluFuxXWySq
    rBdBJVBRl9aRMy2q6anZo6uB9CCzHVkk4n+5+npQuYA/TmRgjCkD4amekqzNVVFf
    TnoLK7I5N7zattEFMApblYbQD+XOMkCo8lWr+b4jQKG50DBOY1PY+5K6+mvUx38U
    6YCzmhGu4v90z/p6oxT2gTLqKZU4xtNY1swtePPshPA7PC/qtDFLztWVn0iAcNlN
    Y4cdWHOMsQ0Q00soTKdGwx+l/pH0kUnuS2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523235328; bh=LCeuUjt4MDLoIPyGLe3YzHwcijbG9nIMSF/yeQPS49I=; b=
    s+pGWa0Beax+keNKMXA1t6X3UTYPUKzrclQK+rq5eFZR63gue3DZ7WZ2FlXZYxzW
    orPi2sYp8Lo8DkET+CP9vB1qHi7N8ZmQGk1mD7lXE3UpI+cJZZSyYG7pzBg1n6vu
    RweiwtupPI22OOHWKJIaPg/L1/bt6dZDwLzr/UPl2CKwWo1BLvt7S3QWD1EdJGi9
    7FSBYG7cWw8sKGj8iIksVgTas+ddiS1egOnCeTOna3PzDi1zUMk1w7MtJb7fovPk
    ur+JjRhcSSZPYDNOCfz2xG3Hl2G0Tlfl4BvtKB+CBilnDHNfMxfDqFHqH1b1Vcmu
    HtZMsTqGaHgsw9b5j0Q0fA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PlCNPt6Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PlCNPt6Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMIjtSag/VpwKAb9ga8I7voITrn92uz2bLlnf33oJ3L1S9iA6h62rx56FdF2yhX2KJG8hNfZO3KW48hIcSWDSzVLZogCIwQxh9IuUGRQxyusz7aCVlmV
    ssKbouk6tVb8HI6lBZkhyPWhAG4lK6osx2lSpRPhsehADKfqrs7ivYqA/BlFDmGsCJnHZnJys+ccF4Km4WzkPOHxtrMgWNCmgmJrIWuryVewcQqwfKsul6cm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2VYn-sL6AAAA:8 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=stmduOJDnH9FryZnRoEA:9 a=QEXdDO2ut3YA:10
    a=BgzNFtnbkgrEfe--4AkY:22 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeDIAk0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:26 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933266AbeDIAkU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit@wsystem.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 038/101] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Topic: [PATCH AUTOSEL for 3.18 038/101] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Index: AQHTz5qzB/835s3TXkasoZUJncGJfA==
Date: Mon, 9 Apr 2018 00:35:47 +0000
Message-ID: <20180409003505.164715-38-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:MK6AkAVSKdvTIjYL0A7SQx/KPCaDXPTN8KUiX+GcJUKsbKxG364jyIrpy/4qZAgb/nsHitD3IMA3bCG530V1UT93fj+vrzshUDNGbdB8EagX95EHdblbB4k/SGf48qf2899rAXY7YAZIaElhmB3jrQF1A5qtOZs+DINU1/QiO44QUny9lKze+86t1gNM32nmXqOJsFxYgN2t4J/Yx7lT4Zfxj2Hsq+SRpgjsRTcxMHADWnTL4lXFow4aztT0toxu;20:4x2uSic+IqB4Z9lMHPm3zk0b0qqacRIGcNQlEKTlBfaoCvPumep6HYWF0Y43sdXc03+XrlgGrOlgOpHVY2+vpH0Um+zCilg3XYOZKsuoxer1r9xMzTY4NXWi1su1FB4yxIQxRZGByDLNuuhA/QmQCnpT+Wgxav8nvQ8zPDNt/Lk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee827b0e-caae-4667-2e17-08d59db27845
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870142B2B23041B0E973073FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(15760500003)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: VWbmAwx46t+I6oE3T48Jf5vf83lgPAz419o4sPv9XJ+UXT4hlJuNQ+pmVUT1+/kMBIFHvPT40kykjZmeN7k548TSI1lY7X9GR3tg5kYeutrvUxQ1hYFCpEVwV9nBLPg/W/XqDKSnt3dzSwGhB5oTa4NOJXL/IFBCNYrEutpoSjnAfMb4/qdFugZQRGybNf9TJyh5MXN8aEXIY0o3iMqw2zrCGXYEOW4/TApfIWAeYxC/Un1XEZXhpoM+Ar7tdQmHhNkox7eqv5fKouC+uEoLQQgH1yNoiNvndbT9gfbBzMw+uwPBqajWASWp+1OOivxhD5xfNQXBDiKtR5/JcVgrqjN7qVAL7Enszii5pU59rYm/KtOZyK4eW1XO6GU7Xwrw3OgI4GEA5TSfI0wXgT54V5wnX3byzXbsPVwT0RY3FYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <18849D795AA19642889FA6F778696A7D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee827b0e-caae-4667-2e17-08d59db27845
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:47.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
ZXNkaGMuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMuaA0KaW5kZXggYTg3MGM0Mjcz
MWQ3Li40Y2MxMTkwNzJmZTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVz
ZGhjLmgNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMuaA0KQEAgLTE5LDYgKzE5
LDcgQEANCiAgKi8NCiANCiAjZGVmaW5lIEVTREhDX0RFRkFVTFRfUVVJUktTCShTREhDSV9RVUlS
S19GT1JDRV9CTEtfU1pfMjA0OCB8IFwNCisJCQkJU0RIQ0lfUVVJUktfMzJCSVRfRE1BX0FERFIg
fCBcDQogCQkJCVNESENJX1FVSVJLX05PX0JVU1lfSVJRIHwgXA0KIAkJCQlTREhDSV9RVUlSS19E
QVRBX1RJTUVPVVRfVVNFU19TRENMSyB8IFwNCiAJCQkJU0RIQ0lfUVVJUktfUElPX05FRURTX0RF
TEFZKQ0KLS0gDQoyLjE1LjENCg==
