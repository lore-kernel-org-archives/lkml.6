Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240677-2-11014737718161543725
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
    1523240676; b=nNOMCeORHwS2MghZ0qa+/qnYL8KhNBAdgr6LYgSWYELsSzlLaN
    EEvNQJiboNTFDr9f86DVoxuljO/jtNlya5rjYIob2oLXVfmpGXZopYz5yRwLWeYT
    BE2PXub2q/PTXavrilQJfXEePjw00PdpaPGAh5TuERvdJfGyXoAChOqvaPLm6HL4
    7rJ2xG8TtgbrpudK051Kf2KlF1UAWDZuyMz524UTsM1napqhBcghOE06bUyn2b4S
    9+b6Yg3E/SIGvV800QSjOs89dJCTnD3bL76x+QphawnpqRs8GLttKKmqIaytnaOu
    FTPwlXRuFhdOmf9eK/k7CwgGx8u/8ba3qIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523240676; bh=tcOMuIBLT3WsGUN586EeMNxc1x8ThUz3KAwdQD7Sz+A=; b=
    GTTZ/BNkG04vr4pRn3lzri4J5vvQYaZNSHBCo1NPeikvTFv3N8TU+EWn8aXTeAq1
    YpF5Gbc3xDwBmj74TjRm0CKEVJqsoPHwOABCxzk8dxTYwkFrFaMn8xwEFwwTynvt
    AohvpLJOcFbccKUBhPBoUeoWHHzpwRHdHyW/7+rtW8d5kWmGMBmuolzhbTXTLBLe
    +1v+A7haY8uhGMtfMazeLI1GgDE0YjfwU6qb0HuS9+19eUXcagGtEwPWOAoYVwZV
    kzLaFW4D+m6tnpkitKknVFLLPP7otmhLl7y9WwcYLTUmgXhKNC3bRDTuu85nwlun
    ZVLjs3mKkGe3EWLx+KRtQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J4Rltz/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J4Rltz/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGG0TTVkzAzxTjAY4xjKAEGWT+KO138ZszOhye6acoT3iEkRriH88I9+vkjdXGWsyVLBSvLkwkFAHJeL0+nW6DzoC7mv86d+VbTlsDrNCML9F42kcsF
    pa1vnhcr+tn3NWAZpc67YYoe9zLIHCUP0j9m+c6u5vsuORtyorhkLYuQtodeDp36kZhM5uyzWyWZ/jMpiB97g9m8fsTBNKn7xsGFbo0TllrlTrh9Bkmhs2IT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2VYn-sL6AAAA:8 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=stmduOJDnH9FryZnRoEA:9 a=QEXdDO2ut3YA:10
    a=BgzNFtnbkgrEfe--4AkY:22 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeDIA31 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:27 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:47376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755973AbeDIA30 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit@wsystem.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 101/293] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Topic: [PATCH AUTOSEL for 4.9 101/293] mmc: sdhci-esdhc: Add
 SDHCI_QUIRK_32BIT_DMA_ADDR
Thread-Index: AQHTz5kVAxH4VRXK3EaveMdIv8gmYg==
Date: Mon, 9 Apr 2018 00:24:12 +0000
Message-ID: <20180409002239.163177-101-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:pBb5DAb2cP1Jj0zDVAq9q9UszrHCOhu7D+KoMTszcZdtQuBUHV9+YiwoUmWWiEK/Sp7LwPPwYbNlIqX+IA/iUjh0NNlGvdn9EcdJhuMS6ZJkctycDCO89ieuCxCbxsNx21QwVq9UXL4IWNHleQHMxSkVTL/pbp111xc6qcZwxMn04kbAHlfRulh/aySEPe6psbA26Tbv8ielQjHInyxYMoJRN2+Y6ObM2AIKLMvbLGnjDJ0yegbQNUggZEnycr6u;20:SJGioHjMG2mdFGoeTY5m1s56FFkcbAUf2BI/Q9ExFbPJTMSCNDdXrI5zmCF+Neittav7eI7UDqhUKwRbcmq+pe1KalF/BF0XZWcSmLouppzgVSnSQabxsP4M3nAA1DL2kY8SB0Z8EgXAcwrSipFzFALHCJrtLm5/LwqK+vpxdWc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 933c463d-0a0f-4a85-954a-08d59db0f207
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967E2D39890B7F1CD8F8CE9FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(15760500003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Rg6uoFvCT7gJYEGXZxYTPH2r3cINxpsn4niT3Ic3ur4EBKrdBUOX+TvMIFxbaKpOMMd44A7h2RIHPFOpaH0EWJUdA4oiEBGGnAj9liJbtAMbDTOM+cKuCc5u71HjXqHg/6sox7m/cSdsnNzkC5Q6B96+T3N+LhWFV/qS0ch/Y1TKFwkx99DMApbmMuySPgp2I6WhudNLSxC3LHiL3vMe5QCCNKc5bnYMXWSp0bJo5L8Lq5KeBZ7edi3sgdVmlXSR72NXrOnfw1HaU1U8Bxun5w+PTwcCujRyj83YaNQJbgiAM7xh0W/7AWkwX7SVtT3i5slUvou1VnaQTfKGg2LCpqysorwfW1OmMwPauigYrfRBQcPHvF5oGNgI+v2SGGmNUZyk7T2WJnqyuuWYayLt+ThoepUjpbthsAixcUEz2uU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <96BF5033CD97E848B255EBAEC2A8CD30@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933c463d-0a0f-4a85-954a-08d59db0f207
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:12.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
