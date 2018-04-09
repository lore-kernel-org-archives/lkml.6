Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246408-2-451487219694693869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246405; b=S1bJWGnDN4x4+BD3/3e8hn02Y/xryplL+6vYgcjtfky2FijMcO
    68ee6vJCTiFz+kjTQRUN3m/bKnqa7Rxd8Vc2C/EYi7+5JxmLr1zM7zQUlDb/mnWg
    +1VfLY1fOvd5k4P4h7KLXIqhVLKHY8w/XlXelfTO9TlpmKLvAjqH8lFG0v9L1q8R
    3iPDzAHqBMguy0o2Ql4xNLwKCrjQG8oLNO2e/ve7UxmsaryP7FnGXaIRdd651zO6
    QRJSQnRyynDz1KuXcUN0cwlPgP3S7DxYj58oMHZHdiqPa0yrkTZm3/rFOUQGlb2Q
    oY/PC6YCbwXn8Oo8JVn+LMtXcQF/Jy2t5LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523246405; bh=NOGd4V7aWAFFGRC1cO5g43OVxqxMccKnubSQa6bm8Xc=; b=
    CDPvw5xQHQSHRnAD9adHUTJ64Yvhx5xO5kjOl2MEJ1NCs1XALfEXRp16zk4H4PMp
    RrFoGWwxEppOZyJhhJzCsZ+1m2r/audgvRGuXLD8DfnaBGaW4UFNhOV9aWtKSnvo
    R9qu50ntbaGevY2CPgQuyxo0/OO74AB1PUjJntIIrNqE0YjMthwMjjpm0CBfQVXv
    wsmn2H05eNj4si/hyhxcsOTmFjmJez2vny1Uisna/+zCn6MnWLT7/5r6W2w+qJDK
    qulkIFNsltNhkwnwC4E2BX0o/urx2spJVjSHaSZOV9i+ag/SnzSX/q3nkrx/1NFL
    lfU/lxTJBxVRe/rJ/qkBUg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eg1p/SFA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eg1p/SFA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHbu+bC4aTphM7IAt54dNYigvm6kqHDe9btJn7OZAuDx5vqDwS4VGQUDxHT5QGpxQy09FJv7NzOHjHM0PuNJC0XxMXwsfB4uAZ7EF4Evyfu5nKhYVCY
    N7A8t3rl4XhmU8xxnbvAYEosigBqaYY/2/qnDK9hDZh4EVjgxUoeZeepjzkP/QqSgAPMavWE0oEsV8JQLDxSFqOQKzPGT1PLkLpKXYzu0RkZbXDe4GlJKeNZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=j9DfLVgzAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=LiddNo2BJTX4za3ltmAA:9 a=QEXdDO2ut3YA:10
    a=Wga97vBfyVxnudVkrIJn:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeDID7p (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:59:45 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753625AbeDIASe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 066/189] Btrfs: raid56: fix race between
 merge_bio and rbio_orig_end_io
Thread-Topic: [PATCH AUTOSEL for 4.15 066/189] Btrfs: raid56: fix race between
 merge_bio and rbio_orig_end_io
Thread-Index: AQHTz5gq9p2qcAhcEkSP9JvFY/zrxw==
Date: Mon, 9 Apr 2018 00:17:37 +0000
Message-ID: <20180409001637.162453-66-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:hsxd9R9L1dMwQUAh5xp2a1nG1x27d2FywTR6B7mq2tTUwvpS42vPqyS6RM9FAPvUa7f1oIGJzeKATKSWXFIwuJqE+HjaslQK79yLe+NV0i6ptXfkX4hefNPK2rQWGObuIWCZ1OQsuW+LfFUeQT9BU4W3rvkYmGfH69te3tpAgaFgHsqVoH+Ck53AYd1FxObkkOM8WXSHIMxpdQCAIzqrFdk7eGCxv0klcsB7YhnLd/dsEyxPZXCkyyJ75FNRzFW+;20:AYwNGF0wc+KanxeL/4BxQpsrOYJs/SnzMt6qa9rMwByQujL8akmnulnQdKuLugCJEercHZ/elGsx3W3T3xglfmuRgt+tJrIDCHjr59Mgl7NF0bM1Vq9X3um/3EHYXSaNJD830DMJ0/NIkB01MQKmPXqbS5eyYhEuNyLBIeFjNkE=
X-MS-Office365-Filtering-Correlation-Id: 3b71d927-0fd6-4c4f-83f3-08d59daf6c66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10467C4E77D27630A01BBB66FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EFCo0YJkBayZ9GpekUdi48TlgKRIc3nS2bbgQ7NhmEVlSaYp8DqAy5NPpWYDHLY7Yd+hWmTML7ywqauF8XIEscJ/Aj1XVbpV21z3vesniFE5L9WLnoS6HVQnuGddEpb/jOZyrwY+/6rEtbVIXzC+VnHUt3hlKCzlyH2T0iCzBx9vYvv44z0US/JawaZ8XzWEZRmAyGVOr59K1SQ1xUt1wS8LG4wg0Oa3PsEyZju/PR8Wz+NbK8zOvbPRdRd2I+pvtA68MnwbM4zXSkfNlCfaJqX2uK4At2MuvGHXN7OcghsXfPKvPM5j0I+spl3bSr445d9NdnEnrzyqhOrlJMhbHDWX+F5svGtoWUS1QhA+7Dp4Kp4BqSCTI2UQYWOwwCCQkZObWaDmo5iVBRQSw87iqjLeXwqen4+AGHiHidNx0uk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <62B5C162E5F00440A1D3AB1033CC9D57@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b71d927-0fd6-4c4f-83f3-08d59daf6c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:37.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGl1IEJvIDxiby5saS5saXVAb3JhY2xlLmNvbT4NCg0KWyBVcHN0cmVhbSBjb21taXQg
NzU4M2Q4ZDA4OGZmMmMzMjNiMWQ0ZjE1YjE5MWNhMmMyM2QzMjU1OCBdDQoNCkJlZm9yZSByYmlv
X29yaWdfZW5kX2lvKCkgZ29lcyB0byBmcmVlIHJiaW8sIHJiaW8gbWF5IGdldCBtZXJnZWQgd2l0
aA0KbW9yZSBiaW9zIGZyb20gb3RoZXIgcmJpb3MgYW5kIHJiaW8tPmJpb19saXN0IGJlY29tZXMg
bm9uLWVtcHR5LA0KaW4gdGhhdCBjYXNlLCB0aGVzZSBuZXdseSBtZXJnZWQgYmlvcyBkb24ndCBl
bmQgcHJvcGVybHkuDQoNCk9uY2UgdW5sb2NrX3N0cmlwZSgpIGlzIGRvbmUsIHJiaW8tPmJpb19s
aXN0IHdpbGwgbm90IGJlIHVwZGF0ZWQgYW55DQptb3JlIGFuZCB3ZSBjYW4gY2FsbCBiaW9fZW5k
aW8oKSBvbiBhbGwgcXVldWVkIGJpb3MuDQoNCkl0IHNob3VsZCBvbmx5IGhhcHBlbiBpbiBlcnJv
ci1vdXQgY2FzZXMsIHRoZSBub3JtYWwgcGF0aCBvZiByZWNvdmVyDQphbmQgZnVsbCBzdHJpcGUg
d3JpdGUgaGF2ZSBhbHJlYWR5IHNldCBSQklPX1JNV19MT0NLRURfQklUIHRvIGRpc2FibGUNCm1l
cmdlIGJlZm9yZSBkb2luZyBJTywgc28gcmJpb19vcmlnX2VuZF9pbygpIGNhbGxlZCBieSB0aGVt
IGRvZXNuJ3QNCmhhdmUgdGhlIGFib3ZlIGlzc3VlLg0KDQpSZXBvcnRlZC1ieTogSsOpcsO0bWUg
Q2FycmV0ZXJvIDxjSi1rb0B6b3VnbG91Yi5ldT4NClNpZ25lZC1vZmYtYnk6IExpdSBCbyA8Ym8u
bGkubGl1QG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTdGVyYmEgPGRzdGVyYmFA
c3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1p
Y3Jvc29mdC5jb20+DQotLS0NCiBmcy9idHJmcy9yYWlkNTYuYyB8IDM3ICsrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9yYWlkNTYuYyBiL2Zz
L2J0cmZzL3JhaWQ1Ni5jDQppbmRleCAwMjVlNjljNTdjYmQuLjE5ZTEyOTY0YWE2ZCAxMDA2NDQN
Ci0tLSBhL2ZzL2J0cmZzL3JhaWQ1Ni5jDQorKysgYi9mcy9idHJmcy9yYWlkNTYuYw0KQEAgLTg1
OCwxMCArODU4LDE3IEBAIHN0YXRpYyB2b2lkIF9fZnJlZV9yYWlkX2JpbyhzdHJ1Y3QgYnRyZnNf
cmFpZF9iaW8gKnJiaW8pDQogCWtmcmVlKHJiaW8pOw0KIH0NCiANCi1zdGF0aWMgdm9pZCBmcmVl
X3JhaWRfYmlvKHN0cnVjdCBidHJmc19yYWlkX2JpbyAqcmJpbykNCitzdGF0aWMgdm9pZCByYmlv
X2VuZGlvX2Jpb19saXN0KHN0cnVjdCBiaW8gKmN1ciwgYmxrX3N0YXR1c190IGVycikNCiB7DQot
CXVubG9ja19zdHJpcGUocmJpbyk7DQotCV9fZnJlZV9yYWlkX2JpbyhyYmlvKTsNCisJc3RydWN0
IGJpbyAqbmV4dDsNCisNCisJd2hpbGUgKGN1cikgew0KKwkJbmV4dCA9IGN1ci0+YmlfbmV4dDsN
CisJCWN1ci0+YmlfbmV4dCA9IE5VTEw7DQorCQljdXItPmJpX3N0YXR1cyA9IGVycjsNCisJCWJp
b19lbmRpbyhjdXIpOw0KKwkJY3VyID0gbmV4dDsNCisJfQ0KIH0NCiANCiAvKg0KQEAgLTg3MSwy
MCArODc4LDI2IEBAIHN0YXRpYyB2b2lkIGZyZWVfcmFpZF9iaW8oc3RydWN0IGJ0cmZzX3JhaWRf
YmlvICpyYmlvKQ0KIHN0YXRpYyB2b2lkIHJiaW9fb3JpZ19lbmRfaW8oc3RydWN0IGJ0cmZzX3Jh
aWRfYmlvICpyYmlvLCBibGtfc3RhdHVzX3QgZXJyKQ0KIHsNCiAJc3RydWN0IGJpbyAqY3VyID0g
YmlvX2xpc3RfZ2V0KCZyYmlvLT5iaW9fbGlzdCk7DQotCXN0cnVjdCBiaW8gKm5leHQ7DQorCXN0
cnVjdCBiaW8gKmV4dHJhOw0KIA0KIAlpZiAocmJpby0+Z2VuZXJpY19iaW9fY250KQ0KIAkJYnRy
ZnNfYmlvX2NvdW50ZXJfc3ViKHJiaW8tPmZzX2luZm8sIHJiaW8tPmdlbmVyaWNfYmlvX2NudCk7
DQogDQotCWZyZWVfcmFpZF9iaW8ocmJpbyk7DQorCS8qDQorCSAqIEF0IHRoaXMgbW9tZW50LCBy
YmlvLT5iaW9fbGlzdCBpcyBlbXB0eSwgaG93ZXZlciBzaW5jZSByYmlvIGRvZXMgbm90DQorCSAq
IGFsd2F5cyBoYXZlIFJCSU9fUk1XX0xPQ0tFRF9CSVQgc2V0IGFuZCByYmlvIGlzIHN0aWxsIGxp
bmtlZCBvbiB0aGUNCisJICogaGFzaCBsaXN0LCByYmlvIG1heSBiZSBtZXJnZWQgd2l0aCBvdGhl
cnMgc28gdGhhdCByYmlvLT5iaW9fbGlzdA0KKwkgKiBiZWNvbWVzIG5vbi1lbXB0eS4NCisJICog
T25jZSB1bmxvY2tfc3RyaXBlKCkgaXMgZG9uZSwgcmJpby0+YmlvX2xpc3Qgd2lsbCBub3QgYmUg
dXBkYXRlZCBhbnkNCisJICogbW9yZSBhbmQgd2UgY2FuIGNhbGwgYmlvX2VuZGlvKCkgb24gYWxs
IHF1ZXVlZCBiaW9zLg0KKwkgKi8NCisJdW5sb2NrX3N0cmlwZShyYmlvKTsNCisJZXh0cmEgPSBi
aW9fbGlzdF9nZXQoJnJiaW8tPmJpb19saXN0KTsNCisJX19mcmVlX3JhaWRfYmlvKHJiaW8pOw0K
IA0KLQl3aGlsZSAoY3VyKSB7DQotCQluZXh0ID0gY3VyLT5iaV9uZXh0Ow0KLQkJY3VyLT5iaV9u
ZXh0ID0gTlVMTDsNCi0JCWN1ci0+Ymlfc3RhdHVzID0gZXJyOw0KLQkJYmlvX2VuZGlvKGN1cik7
DQotCQljdXIgPSBuZXh0Ow0KLQl9DQorCXJiaW9fZW5kaW9fYmlvX2xpc3QoY3VyLCBlcnIpOw0K
KwlpZiAoZXh0cmEpDQorCQlyYmlvX2VuZGlvX2Jpb19saXN0KGV4dHJhLCBlcnIpOw0KIH0NCiAN
CiAvKg0KLS0gDQoyLjE1LjENCg==
