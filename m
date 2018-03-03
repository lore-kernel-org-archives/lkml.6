Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117377-2-5842174537955006636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117377; b=AbWwnUZ0LbnIc8B3egzhBafIl27WM37zKJFZeaD43gnoONM
    jKOREBaBkB0qGn2d5875wCDTqJqtjIHtZKMJnr17cpzFEOgTRZuaZTwsj7+HbtMj
    rd13QfV17lr+0DxsUxh0gTPelFconrUoH/NVrdRRiAHgnJd9asLZtEYY6jUMQPoZ
    n81FwbUEzeEeYqPYu1rXVHgB4F5M+IjcSc1w2QuWTc2hNwP5hYu/Oxl/uIkevqeI
    ESfhRFwK2qnECkpieWeD939GWKMmnE2oKQJyQVEpAFI5306IsJLYUZ9VZDHTnDNX
    /Fa6MwBPVJT8QuhBkcHTUXcgXb4m/nGttntD3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520117377; bh=hUKCincDlG1qxFj07X4Nl+KFR1zXLSjFrIixhC
    yBrJM=; b=qo0AmDOsAQ4Mm4Ji/0keyT1MXOjCQAf3eQ1UcyeQFbgdbikACf5XCb
    Qt0oQEyYPvxBHsgL0/tcsbCKdM5kQlePMPCD9J+MxwjWELiPnkUii32RFDESS0qS
    Q9MyqjuvjiAijkCV6BMrbDjvoXIO9l3D8qpK54Wfg0ePzVK8HwOYZfXGSQSVNxE8
    /0Os4fgW008jTs2Dkqav5k9nTr3QIZVgPTkgxamvxR2Qp43jdjEMuHZn9hcYHZhE
    6jJ8MMjEhJbhQp7xyUBOPqGztECJHvl5tQKhXkyMqza1XOsW/uvLLuneR1kKsAgj
    18NXScai/G14r0A40n0X+DDgAvhF+gpw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OG9aPR9O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OG9aPR9O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935120AbeCCWtL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:49:11 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934560AbeCCWls (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 38/63] regulator: isl9305: fix array size
Thread-Topic: [PATCH AUTOSEL for 3.18 38/63] regulator: isl9305: fix array
 size
Thread-Index: AQHTsz+pbHijvF5s9kO1IXeLOrivFQ==
Date: Sat, 3 Mar 2018 22:33:32 +0000
Message-ID: <20180303223228.27323-38-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:r6PHtEF9Z5e5F52yQ5xSNyJSGJg9Yo1EzcMLMN9VpGT7TLg1KkbigoEwOu4dhmGT3F1Izvvrd9i2Mp+QnCySRik3YlWRZzSYZb094br3o9V7PoP9R0grocbNpQOZqQkIe/X+nxFBBA7NdiereIlIkRO3eMrCz6GOPXy9FM8SVBz2Lm9pDUOIbhUwgEFCChcCzDmUNv46vzGxg4iLodDvkRP3YRskkx5+OMYZU11QhGViEifbiHQfnrfrI1R2dmxQ++/htQEscMNAuFGT++lAmLiB4uqi+uqKRIHEoxqhHm8vodXDg9o6o09pq1gdRsluF62N8QrDmEnUXgzMdH6UyMeE1Xdns5BEnzUPe7oTxvogc6bFHFiGBzf984AbsrKv;5:k7+h1Ia+al6N2Ki+40Sn5jzgJYqZ5fC0fdHQVHYakOuFJy88DhFFPwuMEbv6wuSIZ3Phd/GtfpYXFUIaSt7DMBfVTeGV6gr/JvgpYPSWh36E/KlPjr86iSWFnZD5IWX5nV1qCnqEi8j5p9HD6gVjvMq46g3/HtWhqb8qxIWbQGg=;24:2e7aQV+7lbFlqs72HKdwEqGhCSt+4pOGTCe1Z8V+tZlYuqdn9vACvnAcocqk7HZxhQKz8q7afzNL3XqDAoTH4Q6Wj96SGoZyg/GJWZox360=;7:0mujPp/i9AT5odMwMualLOPEjRVMoYioOoURXAcCxVD0b4hh4sYrtwZ4F7Q9vqpOJgvxFsyJ+XG0kWcgKgwTIkRC2t8x9HBYeJv5Gyo+6dN3+L6JcqvSF0WPswBA+6YQ2r9dkv9nYSAXxuAkK88TNCbW5f7XLlOso711kQleA6RYYPCwGuE+lUhqfZPB1YrJsb9ONxqrIha1JxnPGAMFt1Cuy0GTC26vFr3U+iR3612ByBAfCLv+jTtxrhduVX9Z
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17740ed6-782c-4a5c-f93b-08d58157f22d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06C731F9485CD08CC851DBFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(184751874519063)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(8656006)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hf3jBFv+rfmItrqLtaftua+RGLAXX0+hQr0B0gLmseGv8D353jGsVGSjxyjDSjXaBzvPaBUit4Y9OnxqNsBK14tqBmnbML+LLR8ySB+1huugpaejPO9qx2JuHxypNSUsXhG7gk9LLQsshk4EX24kqKaTIOljJZLwJHeDT28IpzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0521595205B5074EA801CD14CA647C9B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17740ed6-782c-4a5c-f93b-08d58157f22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:32.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBsYXBvc3RlLm5ldD4NCg0KWyBV
cHN0cmVhbSBjb21taXQgMGMwOGFhZjg3MzE3NGM5NWU2NzRjZjIxZmZjZDA0MWM1ODlkMmU1YiBd
DQoNCklTTDkzMDVfTUFYX1JFR1VMQVRPUiBpcyB0aGUgbGFzdCBpbmRleCB1c2VkIHRvIGFjY2Vz
cyB0aGUgaW5pdF9kYXRhW10NCmFycmF5LCBzbyB3ZSBuZWVkIHRvIGFkZCBvbmUgdG8gdGhpcyBs
YXN0IGluZGV4IHRvIG9idGFpbiB0aGUgbmVjZXNzYXJ5DQphcnJheSBzaXplLg0KDQpUaGlzIGZp
eGVzIHRoZSBmb2xsb3dpbmcgc21hdGNoIGVycm9yOg0KDQogIGRyaXZlcnMvcmVndWxhdG9yL2lz
bDkzMDUuYzoxNjAgaXNsOTMwNV9pMmNfcHJvYmUoKSBlcnJvcjogYnVmZmVyIG92ZXJmbG93ICdw
ZGF0YS0+aW5pdF9kYXRhJyAzIDw9IDMNCg0KRml4ZXM6IGRlYzM4YjVjZTZhOWVkYjQgKCJyZWd1
bGF0b3I6IGlzbDkzMDU6IEFkZCBJbnRlcnNpbCBJU0w5MzA1L0ggZHJpdmVyIikNClNpZ25lZC1v
ZmYtYnk6IFZpbmNlbnQgU3RlaGzDqSA8dmluY2VudC5zdGVobGVAbGFwb3N0ZS5uZXQ+DQpDYzog
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogTWFyayBCcm93
biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhh
bmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL2lzbDkzMDUuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaXNsOTMwNS5oDQppbmRleCAx
NDE5MTMzZmE2OWUuLjRhYzFhMDcwYWYwYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9pc2w5MzA1LmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmgNCkBAIC0yNCw3ICsyNCw3IEBADQogc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGE7
DQogDQogc3RydWN0IGlzbDkzMDVfcGRhdGEgew0KLQlzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0
YSAqaW5pdF9kYXRhW0lTTDkzMDVfTUFYX1JFR1VMQVRPUl07DQorCXN0cnVjdCByZWd1bGF0b3Jf
aW5pdF9kYXRhICppbml0X2RhdGFbSVNMOTMwNV9NQVhfUkVHVUxBVE9SICsgMV07DQogfTsNCiAN
CiAjZW5kaWYNCi0tIA0KMi4xNC4xDQo=
