Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243877-2-16280534013874814848
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
    1523243874; b=qSbm1AVhw9FFliT5JCRKCHjs9byg+oBD7DiF+pu4smSgQN01l4
    gCBAQ2Y/3WcZB1qcpWsSztp2UbGhLrMaqYr7TF8q1A0A35iZj7Nq/K9AMrIKZ3tm
    zmNCqBBlgEkPCPnAxvoOKg3z1m23HXXfHcqT8K1+JzADlpJCxy2+qQWnwQRabXx0
    utVVube8T0A3/9TVWAwqk1SmvpVDkWfgXv4SyhUJWBd3kLheiB6wqZ9WqstFbF32
    qj6Ot8GcZh0qPWfx8Avg8esEL8P5RhyXe6j4QnqI0RLapr6jCaCrVkGpyfzBHJ7I
    yyfnV161shUWnkO1RA/O6NArcK7+G+scK16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523243874; bh=IG2PEkxQ7fMeSG/f1/JpvgbZ+cDo9t75QUl+a1WaJnQ=; b=
    mPNsZ4FsRcjG+MzcB2QfXVyTE37jhaAChxZJskSfEZZSi3gy/Z8pOqK6gCkqJPy/
    yZHjuecudMC97KxXruMJFeuRjrP/xipka6iuflUjQaWvYNhmp56fyp3qmNKxn13c
    8eUx4AihEBTUALdq/f1dIyb1nwXP1X0nhqd78SW9qZ02l6SVAbtYGAI7wAjcrJ1H
    u3rGhzryqCezdM34Qg8a67X2kIn7TYpF6L3vVQnEp8KMXWQ9I0zfOC09EKYHmhVh
    gu4YjcAjhalCj9PB7FRi3zpF0e1MH44tzRj46eevVuqEg/y9YL6W85+TogtI6UP2
    0I/7B+DG7Af81U/VCTHGvQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kv7xFbOz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kv7xFbOz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfImpP7OVRKB18n2glwooAk8nvrukSPKu9+om6mULDLUKioO0Qw9dUGTnBHnMbcfOqkWx68vLhxOn3d+fPapTmWSFaXnY5xMHw3p12RRLEhGLvVG0NnFX
    IF1E2LwAh56QvGvWDfyFG+08zC7liaAJZC1rVJ+dQARkffw6M/73FgesCWbQZT+fmml0y3gcS2mJD3hOqUAhz8nG5Au0XZcW+L2KAH0GJgQNbjiaRv83WVGC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=j9DfLVgzAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=LiddNo2BJTX4za3ltmAA:9 a=QEXdDO2ut3YA:10
    a=Wga97vBfyVxnudVkrIJn:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDIDRv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:17:51 -0400
Received: from mail-bn3nam01on0095.outbound.protection.outlook.com ([104.47.33.95]:56127
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754869AbeDIAXe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 056/161] Btrfs: raid56: fix race between
 merge_bio and rbio_orig_end_io
Thread-Topic: [PATCH AUTOSEL for 4.14 056/161] Btrfs: raid56: fix race between
 merge_bio and rbio_orig_end_io
Thread-Index: AQHTz5iSUcwpBkO3aUeDEe43jxopfw==
Date: Mon, 9 Apr 2018 00:20:31 +0000
Message-ID: <20180409001936.162706-56-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:D8PO+NB7WM4Sz2Fb8B1pNdQUZl7NOj5Ho3CWujfK1st5J5a/OCrUInzCt2ExrIZmhfifHV+FveZ3nqnY3Si8pQnQHvjyr3rUh3aNyy66THO0msWXsVWU6sSY9rG5YDBt+0d9g6piNO2t8TinPiJh90CWZL6hZN6TCHqjuZFvG6AmGfciWgTYVgZhqbKfTGXVu5JXl4k5kUAn2FrMUznKB0Sq4WRaqRlDbJZhTJbtAIz2BFpcVSLFTAsQKcZM3Feu;20:Xc+G2vuDr8rqUjEloKHXiwBCBNGNrMKaScG+2p8VmFza3Y3/3QJx7rWFTKvoBKd/dOqpOR4snFvqtIv3jB1AFdl0/BTZDOoCIuiiaq2qORPfagT3SLx4UKbcOQ/TGD52izV2Uf8UhZf+WDaeXxMBDkaD2vgD8GZbUJku7Eh6Oo4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecb7009b-00e1-414a-98f8-08d59db01f4e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10140188B678D70E4BB9B61BFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YkaMI9iz3yMjvgVpeRDOpdgiUT0X70q0rPCv6HAkqmKb1aH51vJy6Ijo6t6b0yqWygemReBThKFL/Mv0IsbVKQxA2OaB1pjt7Sqi0EOdZJ+cw2DIy65AHJiADUU083sAiaOt0ao4FG7K3tD0YbVmQo7uHS/CMdNcJ3AJO+/diFu6ekBC9Hp6nroLdWv8acrg5VUtPSgAzAuwcGrb8+4HHEfu6wv0mQHULyaupzhu9d30d8grzgVZeWYsUhjMrItfTmxv0mjaFlCfP3r032T8nukWVZ1svkb+vU8g7yLNO8hVznnrAW9dvK5QErGkPogUy8qqNJlI1ZBgbpppFTB3hil9RB4yyY25AayIPRvr2PEVinSfFwHVbq3ANZevT7IeZygbonhnF1zm7iW87UDGg7ck0x7BBi3WtuZSPNgh7bo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBFBCA027370394DA97A29AB77FFADEC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb7009b-00e1-414a-98f8-08d59db01f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:31.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
L2J0cmZzL3JhaWQ1Ni5jDQppbmRleCBkY2FiNDExNTc4OTkuLjJlOTk1ZTU2NTYzMyAxMDA2NDQN
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
