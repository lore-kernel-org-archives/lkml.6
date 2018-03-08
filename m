Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491545-3-9908792017889328124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491544; b=fQqEsBWhyfAUpAyOJBtcrZMQBW+L4wQoRDcbMYp32ZNigEh
    Luz3JcD5ark7omJmeWi/sg6mevKr5tizfGLK+8H/14Yzx4QydwFAylNKvOa9FZwL
    u3rD46dHfwslHNGG8WV+tEzFR8jXlja+sSEEId3i2rnJc7NaXags9fOyEMxLaHe5
    8IiE5dYGNaDw0pUkGnv0GjjPfsqbSOYG7n8kgquwJJfuKoVc/JAjFRRxm84COH7G
    7ARCH0VbJgYUhto1VHmz4MsFovXGI2D3KkqWCTSUFg/sf737cZxafco7Pyy/n+pS
    lh5VnBLRP0OonrNuFu6NmsFGxCjHcG4L/mkq/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520491544; bh=0iEyqKWYCncOBC9g3raUgLa2K1tOrJi3lete+n
    zPNDA=; b=L6TR4zL71La6TDwBpH09hwdsvFtnXjS0lvH7xoo1t3Q3POmt6bnemk
    kz+6PtlZhHcCTh0pA558WwyV9SARZS7eCmz0X/PMGdI8WuGBvqvCfT5JfyjdQXxJ
    4Fs73Cjk+ms2u45xpHea4wwpSi4snmJ7fM1+L62+6SPgK9Ru7yjx7fu8xE8ZdShv
    QIfT3tp6FU+zuJsBeAHgt4jLO54QXqurxpPN9vXeqBGb67nAEqgXgU9G5q+haZOk
    XsbOgqNh0Fp2VS0igvp6s1mIVfDa/08R/GpDasWid166d2ELccm6VEXwohG1tqKb
    2BehAP56gpkw4zRWcELdd2zJpv9C78xg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PDwmyuEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PDwmyuEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965162AbeCHE60 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:26 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:60295
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965028AbeCHE6L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 09/67] RDMA/iwpm: Fix uninitialized error
 code in iwpm_send_mapinfo()
Thread-Topic: [PATCH AUTOSEL for 4.14 09/67] RDMA/iwpm: Fix uninitialized
 error code in iwpm_send_mapinfo()
Thread-Index: AQHTtpn5I+WSrJHseUySkJDhmm9aEQ==
Date: Thu, 8 Mar 2018 04:57:35 +0000
Message-ID: <20180308045641.7814-9-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:RjSXlmo2rJIBQuxCKXgq2HytuDzJLJ+p51Xa9EWQ67zsmuNSM3t6Oikjs7SuVy3iYLOaL+jq3bqOyh+RcaxMqdVQbAJM4LAaaqXL9ppNF6+Yr85uN+P5ChpkP1Nrvri7WnM4ioVXHUX1q1B5HPF+mRDdFYeHGhb9lnB4XO37vdBJQKP8iPQwCRwgaNuMb5XH5okFLSJkOsCL/jugtht0k0embb9LWmYD3stTXY1Wvy8FK7TF8YKn9Wrzo/5/r+0G;20:KZrpWAL4f+UPo3iMuO3etopvtfSNiMOoJNPVA4XLqnOxOC7BCIBjLMPaa+pHAfwTc1fxwKfF0GjFvEuzMKX0ePptsuPRbTuUIsm2y1Nr1yQ5TC1c7oSRE846d4PUgdd/nStE+XFwvy+mpXbmZgsqzVfRvERa6ccDvBeMhgGkxAc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94424dd8-f75d-4d2f-e993-08d584b12e34
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08886927E8201CCB83F60650FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JA/iWlu7sjj607sXUs8RvRw1+5wUpvCLXiRXDFmhn/ULu13efKwfHjY+jwNx7lNKu7oVlqpFmV9vqpl9ZY1mqWmW3yJHXLim1vCbiYEOqmXbZJbJFdCBh6i3ExxYncsGwuVwKY6hgvOCuUjZ4rWkZ6p4YSqj21jN3F+6kmAD6rdhpy/NL4xRLJuku7A6XXXVApsEd6Wl+pDCPouq62/zTtJEh/X2FKhQs6Cfz4GeF/p4OaED2NXmiyE/bj5Qnenhs3hUYnjUagPn9lnkARu1q4OYeP7iJ+fdq87ARij7LYeRRS51K0CrxkMhMuUdnpyVZnh1/q/4VGgIXu/IjC5xJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <42D06B9FCCAEBD4F8190566D7E2C682F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94424dd8-f75d-4d2f-e993-08d584b12e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:35.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgMzAyZDY0MjRlNGEyOTNhNTc2MTk5N2U2YzlmYzNkZmIxZTRjMzU1ZiBdDQoN
CldpdGggZ2NjLTQuMS4yOg0KDQogICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdwbV91dGls
LmM6IEluIGZ1bmN0aW9uIOKAmGl3cG1fc2VuZF9tYXBpbmZv4oCZOg0KICAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2l3cG1fdXRpbC5jOjY0Nzogd2FybmluZzog4oCYcmV04oCZIG1heSBiZSB1
c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbg0KDQpJbmRlZWQsIGlmIG5sX2NsaWVu
dCBpcyBub3QgZm91bmQgaW4gYW55IG9mIHRoZSBzY2FubmVkIGhhcyBidWNrZXRzLCByZXQNCndp
bGwgYmUgdXNlZCB1bmluaXRpYWxpemVkLg0KDQpQcmVpbml0aWFsaXplIHJldCB0byAtRUlOVkFM
IHRvIGZpeCB0aGlzLg0KDQpGaXhlczogMzBkYzVlNjNkNmE1YWQyNCAoIlJETUEvY29yZTogQWRk
IHN1cHBvcnQgZm9yIGlXQVJQIFBvcnQgTWFwcGVyIHVzZXIgc3BhY2Ugc2VydmljZSIpDQpTaWdu
ZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KUmV2
aWV3ZWQtYnk6IFRhdHlhbmEgTmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQot
LS0NCiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvaXdwbV91dGlsLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0K
aW5kZXggM2M0ZmFhZGI4Y2RkLi44MTUyOGY2NDA2MWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
aXdwbV91dGlsLmMNCkBAIC02NTQsNiArNjU0LDcgQEAgaW50IGl3cG1fc2VuZF9tYXBpbmZvKHU4
IG5sX2NsaWVudCwgaW50IGl3cG1fcGlkKQ0KIAl9DQogCXNrYl9udW0rKzsNCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJml3cG1fbWFwaW5mb19sb2NrLCBmbGFncyk7DQorCXJldCA9IC1FSU5WQUw7DQog
CWZvciAoaSA9IDA7IGkgPCBJV1BNX01BUElORk9fSEFTSF9TSVpFOyBpKyspIHsNCiAJCWhsaXN0
X2Zvcl9lYWNoX2VudHJ5KG1hcF9pbmZvLCAmaXdwbV9oYXNoX2J1Y2tldFtpXSwNCiAJCQkJICAg
ICBobGlzdF9ub2RlKSB7DQotLSANCjIuMTQuMQ0K
