Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122188-2-5867043172659660831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122188; b=lwkbUN8sULmdhGA9WNbqLuu/QHkZW+bZKWSaWWB0aT5LCXe
    rPXMhN0s47yuOnXL5VEoSFhFqAEvyDwqOOIrETbOOkbdbHt31oTekiJkU8jmzh9J
    cEFFsm5m+LsxF2jq4ilLzbksX31A5ZiY9IbxrafEJEP5C2dOwUYVnQ5YEwoH1Ky3
    zKAA3eN74o+sBlO6meT6noJyMxAknaz6948glQ72TQf95JGce3KqrlioQjrsNhwr
    lr28bx7GUd9CbkZ5m2cFZ59Pl7el/IWEbKK+nUh24b1LLfuk4Nas3/W43p1JqtXB
    PDHdgRDnrX6xiBJkmjyywUnKl80nU9pGB0Gngqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520122188; bh=CZJ43dio185YRpTW2Q+xSOXarpY8jKCmPbPbQG
    Nymnk=; b=WbC24t9XgywPxhSW7pOYK0HzbB/rcRxFLUsK4l/85qahCj9rGe13mI
    ztAzC/NgcADu0SnSOM0jdJl+gzqR0LSdh12YqLKMakSp/1wWCQSqSQ8morHuO7ot
    dEiXbBqGtUcRpjRLQ9/+yJ5ogeU5VFyO7NakCRvwX67oPKaE1c4YLMRmKPvM8oyU
    N8pnQBE3vMsZfSDhoMBSivJ+O8YdDkALep/fAFDOwhGKbofiLpvBnuKwXpkEVw9O
    s1r4Uen8BmlOc2QnHhIpE14ubhGRZsCI52Z6EDIcf9CyjorfIOrLJZ/SaYS/h/RT
    f8KvNKf2pNJ2rysvlfHg4wJjl8eFS9sw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eOajLKZd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eOajLKZd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932556AbeCDAJa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:09:30 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933550AbeCCWbB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 003/219] spi/bcm63xx: fix typo in
 bcm63xx_spi_max_length breaking compilation
Thread-Topic: [PATCH AUTOSEL for 4.9 003/219] spi/bcm63xx: fix typo in
 bcm63xx_spi_max_length breaking compilation
Thread-Index: AQHTsz7hmrDDFO4zD02nSlfiUq/t7g==
Date: Sat, 3 Mar 2018 22:27:56 +0000
Message-ID: <20180303222716.26640-3-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:00qRngRI/51zo6w2GDjt3YD5NF1Gm6AFoKR8pnkA12zrgftdZkcyNr2bb/jx3EnX/XcYMqRBtm/W0iO44SnXns/Y9VFstgEZXT1rxPe8LCnFkyaKC00LmYpSYgQVZcw+p+dPFg+LTGyvy9Q+d/oeO4lkxqd7pFK2MXdSnoClBe2w8dLKBxqyS2o1lxU2LuLJS+SCaKVzi2lVRXkS+fVO83pAaLTIPJxfDap+jVhpf+6ICajNm9UqG2LPMap1ryK/6tnS2yGfPXLk3x7Y/z0N81g32My82IGjUGG+qjf2dGiBvBogTeSH0bEAk/V4X6C2g9gsOhd77aSxxwdOsQwY8BvYkiCRPfylACfK0SMKG5R/DN+pvi0FSGDZeDJrzRg/;5:QZW+sB+BC1QX7cAnbtbWFf5xK4jGgK5bRzYtjWPE7xeOtArS93ULtpq0MR2BIflaX84zYDO5b9P3H4WZtRlp4IrNrP+gdq89H0+D0sS3GSAX/hPRtp+US0zwYCCokiab6aF5NZ5RMXPnl+4p0nKjdXsC3w5jYj5EbskhsAQ/Bl0=;24:G//ottWvEr7M6VP8ZhxsLxFZM2kAlsMmqBvPoQW4GVLVeATV6lK48t+nmGioZE0q6Zdedehcl1kMluH5GCD9Nw8hLw/N+dbb2JatS/Qlhrs=;7:jHtdPOpn4gd09KjCgErOqXFRVkR1mYBlyabJaYxmqiKVUDbCvPFYkvjNhVZTWs9gohLcKbIigPe2382Mc3evy3eBmLbtH8M7b7TJZobVCfdSMpLeCv7jdUemS7RtHrvskaQd/jedVg/haAcT/RY11vT485ADtbb3HlZupVIpkavwPmwwKuZZtOyDtu9iipyF6r2XawOSdrWuLdQkuAMSFCti+mKIIdQAAVYELwFmEC/tj7+gJlrsm4WdTD0Bu7LP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6df7b0a-88ec-4b1b-73b5-08d581566f3c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09706994FDA979A04C3CD86FFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(15760500003)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: bhlbvxaVYCgbxzrnqft+VMMtKPoDawy0nQEcuIRmb6vtFx0rtpjHyrW4iJFbVKwphSTeqyvfVoZ/A5M5bchBFhovmnsa/DKgBTz2b4IJOAg9fORmWReTICHxWA/X/bTuYM4Bjx3yLoOH7LlSvVbr97RPfzWVsa1GfujLDOCDo3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC80027E24FB7B4895F3404C5F127AC7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df7b0a-88ec-4b1b-73b5-08d581566f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:56.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm9uYXMgR29yc2tpIDxqb25hcy5nb3Jza2lAZ21haWwuY29tPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCBjY2QwNjU3YzMzYjJjMzcwMWM1YjE0NzI1Mjg0YjdlNjcxZDNmYjkzIF0NCg0KRml4
IGNvbXBpbGF0aW9uIGJ5IHJlbmFtaW5nIGFyZ3VtZW50IGRldiB0byBzcGkgYXMgZXhwZWN0ZWQg
YnkgdGhlIGNvZGUuDQoNCkZpeGVzIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNCmRyaXZlcnMvc3Bp
L3NwaS1iY202M3h4LmM6IEluIGZ1bmN0aW9uIOKAmGJjbTYzeHhfc3BpX21heF9sZW5ndGjigJk6
DQpkcml2ZXJzL3NwaS9zcGktYmNtNjN4eC5jOjQzNDo1MDogZXJyb3I6IOKAmHNwaeKAmSB1bmRl
Y2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCiAgc3RydWN0IGJjbTYzeHhfc3Bp
ICpicyA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOw0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn4NCg0KRml4ZXM6IDAxMzVj
MDNkZjkxNCAoInNwaS9iY202M3h4OiBtYWtlIHNwaSBzdWJzeXN0ZW0gYXdhcmUgb2YgbWVzc2Fn
ZSBzaXplIGxpbWl0cyIpDQpTaWduZWQtb2ZmLWJ5OiBKb25hcyBHb3Jza2kgPGpvbmFzLmdvcnNr
aUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29m
dC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktYmNtNjN4eC5jIHwgMiArLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLWJjbTYzeHguYyBiL2RyaXZlcnMvc3BpL3NwaS1iY202M3h4LmMNCmluZGV4
IGNhYTczM2VjNDA1Yy4uN2VlNGIwNGE0YTExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LWJjbTYzeHguYw0KKysrIGIvZHJpdmVycy9zcGkvc3BpLWJjbTYzeHguYw0KQEAgLTQyOCw3ICs0
MjgsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYmNtNjN4eF9zcGlfaW50ZXJydXB0KGludCBpcnEs
IHZvaWQgKmRldl9pZCkNCiAJcmV0dXJuIElSUV9IQU5ETEVEOw0KIH0NCiANCi1zdGF0aWMgc2l6
ZV90IGJjbTYzeHhfc3BpX21heF9sZW5ndGgoc3RydWN0IHNwaV9kZXZpY2UgKmRldikNCitzdGF0
aWMgc2l6ZV90IGJjbTYzeHhfc3BpX21heF9sZW5ndGgoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkN
CiB7DQogCXN0cnVjdCBiY202M3h4X3NwaSAqYnMgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKHNw
aS0+bWFzdGVyKTsNCiANCi0tIA0KMi4xNC4xDQo=
