Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237603-2-11337831979783001688
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
    1523237602; b=aiq9T9FR0HJxV6tlDKner3tuLnW802Gq0wYNkUDLXUhK3CI2kV
    s9gzj9uJpyBwRNcHXWZb7mjKbgbC8kRPVNJHp5Dj0DE1WCQ+K3rodyvzKajoNAwM
    nOekv4+nRPDoHFzEbaKYZaAJNzwM0Th7gIhI1bjTMSiN90jbEju5PXMJYakxGgLL
    GmZa4OUq78JmQTZx5ksoaOe4kPtElRuru/9qwqsx89qU03s0A5xsxbDboV4hEQV3
    ToXHC8CfpremzCW9mb1xu7nr+4j8lZokdSvrnCU5fE5X4t0FiW9j+BeeacUOopRj
    04QQN8yXrAFxDrn2VG2DzPG1OH8XnaA2bzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523237602; bh=T5694IixvmaXROunWMIGUIxRg212Fb8XLkjmqolWmTI=; b=
    gByWwMlSDtFbD086KzPL5HEvc+dZHR9Dcz9iexiXqjQs91mMQrT/jFrnfO2PyGmW
    b3i7tldT2/ki/qrDssGpKG+ka03qfNBvO3DTd4TeFuf09XusNfZQVq0sGK7plzMS
    8qXOpeTlwslJZ40Jm+/tWeLz2DDlxR/7ZCuQjX+MRHJaoQ4gRTqZHDnWszNB86iX
    Zd4hnNci65RqYAIjxrwnaOUvG6fAQoCUJyXy7YXwRxUcWmLMQgQDxvGwAzVGbW9J
    NvJ07nTW03t/KfKKhXSImKtLBjPc5Z1f++Zp/ql6Q2IsctA7YBQJOx4WuhFaualA
    P4nUceyVnPAsc3N3AVnzBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xdb/lbrx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xdb/lbrx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE4zGlagI1X/XzZ2ObNgFW4xCBGOc8HRtb8kYn9+Z/de6Exyv01T9ZKeImL5N5cz0afYJAnbLNZRHLMO4iCeFCEUrv3CbDnbWx3ZUr5zbNAosgXTxi4O
    ivAljbtyVAvAA8BBnIN95QD0NVTuU6E4gnqxC+u4xgp4VVo1YB/rKhHQQdM9NORvvhO7mORYieXALjBZi8xC1CoMobN4ZzfcemQGyHJEyRRIC9TesiggMFBn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=EqdPLkY1AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=c9LJUD5P9b49lab5o-oA:9 a=CPSBYo6li2zp6erR:21
    a=CJImAz3WB0RoXbvh:21 a=QEXdDO2ut3YA:10 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756585AbeDIAfq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:46 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:45331
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755359AbeDIAfo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@gmail.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 031/162] platform/x86: acer-wmi: Detect RF
 Button capability
Thread-Topic: [PATCH AUTOSEL for 4.4 031/162] platform/x86: acer-wmi: Detect
 RF Button capability
Thread-Index: AQHTz5mgDe8R1vX4DUmUxHiYgEfDbA==
Date: Mon, 9 Apr 2018 00:28:05 +0000
Message-ID: <20180409002738.163941-31-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:UC5rl78SEObzXCnr0emvMeQSiX6ukbC77nCejIb6i5PTge5UcTA7n7B7NkWcqudcAANobpiNGiHTYV4zAEWfAzB4gyCO68muzyxkpTd9u9WFpTeH3/C2UY6/6FodlYU8hRKVirSAImi7dFQHguQWR+TIePCyioY0dHRGpeTVbOpDGaJhFMWG7MuLpu+UgqiC1Rw1XN48e/LLngvsR/0hbhR7X8vaF3AB26vAXpDL0ubdUVfiiOoQl8XRbUjajqkm;20:OoYSSX2gIzfI/Ax9A0L+J/GkOBaHIoXspQedu+SWaVnadhhl5mj6sxHyIui+eqDFME8XyrDqmCBDk/Z3ryGe+23QPwUABpu9aZKz0YobxkzIxum4ClYZJsgbiMO8THAmc+0Otf/4YVZQ8vMOb0miEnpXZX5ytwzse9Cj21qP66U=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb64b8f6-750c-4c03-83c9-08d59db1d325
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072570658A56C9468B9331EBFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: e3hUUa7WAzQC/xmb+W11aflnR97TDZguVcr9pn4SgvcrW7jKrjIsZ/GCpTdlBm5NRjaS+0aUdE1Aj0EYxIRgdcmfxUcacJjffbw1vZgPIEMg43K5C79yxnEZGiGurEwAzaqUfWueRO1Op7D3qPa6J3wvNDv8NKGQDgSdM9HtVips/NdQL+PhJoalUGBS0YYLv2r2EuVBWlFY03+qUzxofSa0dp3vGvw9DB7l/1QsKpaQR1aovDHj7KEXd48PERoZ8sh5wAezDEYjtnTDgsSnUCTjfsoWQ+2W3S0r8m689W7J/OR0EKH6L03+k0uc3go+Ods2XDWhzhcoavT5FFv0t5FSTmLsM8JLPIS/MQB+cqJDeE3zxK1dwzaVrNJARb/x7rJr2oob5VaURfCWhWma54yEmc8rzAQkUsbqhMZdaTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <519125A8FA921E41AEBE4F0B66BBE635@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb64b8f6-750c-4c03-83c9-08d59db1d325
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:05.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm/Do28gUGF1bG8gUmVjaGkgVml0YSA8anBydml0YUBnbWFpbC5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IDNlMmJjNWM1YjMyNzRlYzc0MDJmYWJiZmJhNTU3ZWE1ODA4NDk4NWUgXQ0K
DQpJZiBhIG1hY2hpbmUgcmVwb3J0cyBhIFJGIEJ1dHRvbiBpbiB0aGUgY29tbXVuaWNhdGlvbiBi
dXR0b24gZGV2aWNlDQpiaXRtYXAsIHdlIG5lZWQgdG8gcmVtb3ZlIGl0IGJlZm9yZSBjYWxsaW5n
IEdldCBEZXZpY2UgU3RhdHVzIG90aGVyd2lzZQ0KaXQgd2lsbCByZXR1cm4gdGhlICJVbmRlZmlu
ZWQgZGV2aWNlIiAoMHhFMikgZXJyb3IgY29kZS4NCg0KQWx0aG91Z2ggdGhpcyBtYXkgYmUgYSBC
SU9TIGJ1Zywgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgdG8gZ2V0IG9yIHNldCB0aGUNClJGIEJ1dHRv
biBzdGF0dXMuIFRoZSBzdGF0dXMgaW5kaWNhdG9yIExFRCBlbWJlZGRlZCBpbiB0aGUgYnV0dG9u
IGlzDQpjb250cm9sbGVkIGJ5IGZpcm13YXJlIGxvZ2ljLCBkZXBlbmRpbmcgb24gdGhlIHN0YXR1
cyBvZiB0aGUgd2lyZWxlc3MNCnJhZGlvcyBwcmVzZW50IG9uIHRoZSBtYWNoaW5lIChXaUZpIHx8
IFdXQU4pLg0KDQpUaGlzIGNvbW1pdCBmaXhlcyB0aGUgd2lyZWxlc3Mgc3RhdHVzIGluZGljYXRv
ciBMRUQgb24gdGhlIEFjZXINClRyYXZlbE1hdGUgUDY0OC1HMi1NRywgYW5kIGNsZWFucyB0aGUg
Zm9sbG93aW5nIG1lc3NhZ2UgZnJvbSB0aGUga2VybmVsDQpsb2c6ICJHZXQgQ3VycmVudCBEZXZp
Y2UgU3RhdHVzIGZhaWxlZDogMHhlMiAtIDB4MCIuDQoNClNpZ25lZC1vZmYtYnk6IEpvw6NvIFBh
dWxvIFJlY2hpIFZpdGEgPGpwcnZpdGFAZW5kbGVzc20uY29tPg0KUmV2aWV3ZWQtYnk6ICJMZWUs
IENodW4tWWkiIDxqb2V5bGkua2VybmVsQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFuZHkg
U2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9m
Zi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQog
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYWNlci13bWkuYyB8IDcgKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FjZXItd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hY2VyLXdtaS5jDQppbmRleCBiMmNk
YzFhMWFkNGYuLjIwODY5MDI4OWRhMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FjZXItd21pLmMNCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FjZXItd21pLmMNCkBAIC0x
NDgsNiArMTQ4LDggQEAgc3RydWN0IGV2ZW50X3JldHVybl92YWx1ZSB7DQogI2RlZmluZSBBQ0VS
X1dNSUQzX0dEU19USFJFRUcJCSgxPDw2KQkvKiAzRyAqLw0KICNkZWZpbmUgQUNFUl9XTUlEM19H
RFNfV0lNQVgJCSgxPDw3KQkvKiBXaU1BWCAqLw0KICNkZWZpbmUgQUNFUl9XTUlEM19HRFNfQkxV
RVRPT1RICSgxPDwxMSkJLyogQlQgKi8NCisjZGVmaW5lIEFDRVJfV01JRDNfR0RTX1JGQlROCQko
MTw8MTQpCS8qIFJGIEJ1dHRvbiAqLw0KKw0KICNkZWZpbmUgQUNFUl9XTUlEM19HRFNfVE9VQ0hQ
QUQJCSgxPDwxKQkvKiBUb3VjaHBhZCAqLw0KIA0KIHN0cnVjdCBsbV9pbnB1dF9wYXJhbXMgew0K
QEAgLTIwNSw2ICsyMDcsNyBAQCBzdHJ1Y3QgaG90a2V5X2Z1bmN0aW9uX3R5cGVfYWEgew0KICNk
ZWZpbmUgQUNFUl9DQVBfQlJJR0hUTkVTUwkJKDE8PDMpDQogI2RlZmluZSBBQ0VSX0NBUF9USFJF
RUcJCQkoMTw8NCkNCiAjZGVmaW5lIEFDRVJfQ0FQX0FDQ0VMCQkJKDE8PDUpDQorI2RlZmluZSBB
Q0VSX0NBUF9SRkJUTgkJCSgxPDw2KQ0KICNkZWZpbmUgQUNFUl9DQVBfQU5ZCQkJKDB4RkZGRkZG
RkYpDQogDQogLyoNCkBAIC0xMjE4LDYgKzEyMjEsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHR5
cGVfYWFfZG1pX2RlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqaGVhZGVyLCB2b2lkICpk
KQ0KIAkJaW50ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1RIUkVFRzsNCiAJaWYgKHR5
cGVfYWEtPmNvbW11bl9mdW5jX2JpdG1hcCAmIEFDRVJfV01JRDNfR0RTX0JMVUVUT09USCkNCiAJ
CWludGVyZmFjZS0+Y2FwYWJpbGl0eSB8PSBBQ0VSX0NBUF9CTFVFVE9PVEg7DQorCWlmICh0eXBl
X2FhLT5jb21tdW5fZnVuY19iaXRtYXAgJiBBQ0VSX1dNSUQzX0dEU19SRkJUTikgew0KKwkJaW50
ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1JGQlROOw0KKwkJY29tbXVuX2Z1bmNfYml0
bWFwICY9IH5BQ0VSX1dNSUQzX0dEU19SRkJUTjsNCisJfQ0KIA0KIAljb21tdW5fZm5fa2V5X251
bWJlciA9IHR5cGVfYWEtPmNvbW11bl9mbl9rZXlfbnVtYmVyOw0KIH0NCi0tIA0KMi4xNS4xDQo=
