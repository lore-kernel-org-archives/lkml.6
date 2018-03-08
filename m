Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486779-2-6977157391738266190
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
    t=1520486779; b=K9ZnTnjml45zNG2ykRjspj+fSW03VEGHv3NlWi9iSQ8oPbc
    YCn6keej+InMUHOUUHg/y595QGwE3EGfPeTS48BfcwiJRESURKlWVbe5lW8fCeFj
    I2z8E+ADiCv+aEU96zThDWWlmc4wYK9DasfLEQHKfmYTdivIRqorlpYiJ2f6NbHI
    n4J+hzFUP5Id3mR8kHRjIQ9HlA/vczlJkpX86ECctTZVCM188bc8ETbXGanamiPD
    ZjRZNUS/2UUYgUlbxZjwZGehjNbbUWRUXwDhzn8eo7w6iQg52pGPYlQeEsmkebOc
    KxByzxrEQQTWjxNsfRq2CXyrO2mjmnsFhu4aVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520486779; bh=sdt4iqXUuLsmqzSBnWyOmkFkrz9LhFucc/C56i
    i14VU=; b=o4iuhI6Qm8lM4JMXVDs/+gsSHFB5wafQL7SZ86NHbZetVpGOSqC3l1
    gV1OgZGgF4mBopj6JNF/jTzTp+pBgI0NhLKav/CYPo8/5kNjgQAooMW15CS0yll/
    n0Xorppds4FDfB+dkgCk74vhGMeOaIPG0i4pA3Pws1MHeG6VT/xkrr3NxEobo9Cm
    jPry0vRwlnN6tSgdZyrH30uTKk/drXmUtQfcvFxjRGhaetRzcu2yLE3SH9brDTc0
    iB6DfsP6GMBlGnpIT/qLudhqywaPVHCrL8vcgD3kq7ZaYfsLGFB6HORCB9ghG+2K
    JyBBsOyPb+S5xbOBmdptfllp6LiBLpWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VFrTVQTt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VFrTVQTt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966572AbeCHF0H (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:26:07 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966549AbeCHFHQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 081/101] RDMA/iwpm: Fix uninitialized error
 code in iwpm_send_mapinfo()
Thread-Topic: [PATCH AUTOSEL for 4.4 081/101] RDMA/iwpm: Fix uninitialized
 error code in iwpm_send_mapinfo()
Thread-Index: AQHTtpqcUY/wBqEUTE+BsIHaXHCJ2Q==
Date: Thu, 8 Mar 2018 05:02:08 +0000
Message-ID: <20180308050023.8548-81-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:T27xiEU/cQv8AHjf+4nZ8oSlldb15LxmvawCTQ614+hOe9oWEINsY4rxTSM6xwpDZnIv1n/FRSPyRHHAaLiYmJoSP0GB8ota7cP2y8PNx009mJgQBdZZHfPTaQbnuMBb7mbqveGIDVdwhi+7NF1CzojCvaNxEtmKv826K2WVoqkaPJJXEnjCZBfVenmXTxeM60Ovr+JTfKPd6ab1opvQSAjFNjX7cWGTtVatrgQPTQTHY1dpubi66NfPaG62MbRC;20:gIEc6Ahybl+BaCl9JDabQZpMAsPMhut06y9giQaCua33/VjLmpMse0IpIfm5+9tFAuLFGgisqbqSeRIWund/9vUHTDMFsjHuwiD1dq6iIeVgcEI0S7glYld9y6Ud8At2gZYqh9mqYeGzFm9sDfM1+id02/UqtyKvyJefz/XM8O8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2c44cdd-4787-4224-f6b5-08d584b274b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077DECFCDC335EDB0D1D7E5FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rFB2A9ay4BSSjNVmIdjgHMCxEenUOdhgyaxPO2Vb0VaCf0T50+BXIyP+4OI/AVzkt80ynLhmA6sgiLqMvaW2S6KnYmn4vWgg2i0EQprWSaIaPh7AFB36inoneazt8ApTTzkPiYxcBa0ftBZNGd5G/1ijEWh4RrEhvfBnchAdIn7UCPS+6H7K1ohBJUE3NNMyDsXyiVFhMwRJQ4fsqC8EXolDqHpiGCFgKE63uVThCdD04RzWZ0mC930ry/fnL8h/rW00fIHG86KEHZeWkyi1EIOcPnJBjh5V7rzdexL2oC4AQdNVdQy3LqlB0VWAa9iZl3zEAdVCeXV0lNAPHipA7Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFBF2360BBD3BF469ECBF4F52C2F6F65@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c44cdd-4787-4224-f6b5-08d584b274b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:08.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
aW5kZXggZmI0M2EyNDI4NDdiLi44ZDdkMTEwZDA3MjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
aXdwbV91dGlsLmMNCkBAIC02NjMsNiArNjYzLDcgQEAgaW50IGl3cG1fc2VuZF9tYXBpbmZvKHU4
IG5sX2NsaWVudCwgaW50IGl3cG1fcGlkKQ0KIAl9DQogCXNrYl9udW0rKzsNCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJml3cG1fbWFwaW5mb19sb2NrLCBmbGFncyk7DQorCXJldCA9IC1FSU5WQUw7DQog
CWZvciAoaSA9IDA7IGkgPCBJV1BNX01BUElORk9fSEFTSF9TSVpFOyBpKyspIHsNCiAJCWhsaXN0
X2Zvcl9lYWNoX2VudHJ5KG1hcF9pbmZvLCAmaXdwbV9oYXNoX2J1Y2tldFtpXSwNCiAJCQkJICAg
ICBobGlzdF9ub2RlKSB7DQotLSANCjIuMTQuMQ0K
