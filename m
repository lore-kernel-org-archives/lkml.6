Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235585-2-14231762527063826074
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
    1523235584; b=mmCdRFmi96RHimgpxQOzgzeW6wur3PFqluqdKuIf+Vnp17Qkly
    PA/czCwRJKJrC8CoXkjDIBfLk18dg6wheZLSj4nE8L5y8Ol5Y2Vgkg73br687u7y
    BBxJcAifSADpKyx8uwrOc7AUUnmxI8blZ0xTYxaI7gIuLxKBjEoTVczli6ri6Ibr
    hh092p29oQzplPqWb/Kv2OpQVtfH3HDltANjlwcDaiQom5+V2a0JmZpEJKMy0537
    LfzhBQ/0Sqw7CFH6wgwaawsDS3xSNmwm4TP3DpRNf0GLSKBt1Cj+UL4ubbCOzAO6
    q1LnG5Rzn4gB26gA8NDiS2naGL6SjA+AWn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523235584; bh=9IJ5KU6i8x2gFIqAZeDL04jITZIbxs9GGNzHbUL36UE=; b=
    pcb9oH9TPYFbpX+FolHnLbXxSxghWKqG4Iwo6i0+Mkp55K1iMo3y0m6310p7YJyk
    cTtGKQpKzqZ1GZHuM0KUrevHDNS25F+FB4jWSQSHoEEy7YTJEbND7I5Gekqq43oX
    1qnV4dOJPFV3XgzDCU771Dgv795btLd9T8gTBrjxzSUgPdIwKQB1nAKPmTzNmNeP
    OiRiAmOng8ofSw8jHG6ZJhlckYYVAx4hlitb1lHfUs5mla9Dyd8bS8/HMplHffF2
    H0LZh/PzTdsOOueojj/bAKH0L+sjXo/gfFfrancSxq3mM26qi2cQYm2jymebw1Dn
    4vUWdk7SalFvVxNY/4zN5Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mvJDdu3Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mvJDdu3Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOrTfur55tmVVabVIR3/t4QnuwW8DSGWcxhW1Z1DE4c40FISsAETMJCqPqwAHPHKQ+FtT1Q11Qj0rVg0sAFcPxi9PeS18N2KsTrkDp1bYkrfof4MHo3n
    z2gRPkiIHDvlNj0JF1wveyEV71vyk6a+lejNqz85tDitU9jgzqGW/Em6F407bDMNcoxfmaR+L85TstZ9DVKixfkY/hu7bqoGNFopGg1f6hv3O3ei7eLqkcLn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=EqdPLkY1AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=c9LJUD5P9b49lab5o-oA:9 a=CPSBYo6li2zp6erR:21
    a=CJImAz3WB0RoXbvh:21 a=QEXdDO2ut3YA:10 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933648AbeDIA7Z (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:59:25 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756335AbeDIAjn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@gmail.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 027/101] platform/x86: acer-wmi: Detect RF
 Button capability
Thread-Topic: [PATCH AUTOSEL for 3.18 027/101] platform/x86: acer-wmi: Detect
 RF Button capability
Thread-Index: AQHTz5qt7agqHLShKkyGbcXE76lZWw==
Date: Mon, 9 Apr 2018 00:35:36 +0000
Message-ID: <20180409003505.164715-27-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:kFNY5AKmJ5XDuJsfp9Lr62E2En3+Txi2mucHNAgEul4DlyCJ93Usz8LKl+PpcIDmUV5oH37PUB3iAHKDTD4z4v+r575HbSL2l6lfS7f0eoyP4GFyxoU7WjRb+vQA12PoPCT8d+fP7xskqaYPfw6szR2DPB326wN1yRhOtZptG2JJ+9d2n4qeiDG1kCOn69h4WzI4FOZ8UhttXYs2XMz7bYRxEKIBrA2DMY3dEJuEauS1MHx5iPOUGvGrsamrY1IV;20:15wlH4UIPeNYQzuoOIexV/UMzDQzc/B0s4l9gbxh5K7oW2VlIFGfCPOuzn8n5fAM2jBMuMbCYzzv3IgyrXQA7+H6L1l2G58dk8TadXDNdc/10bVROVTcynlhtLXpnLkRem+xYjtJpewclz1TQmaYKW1j1grrU68KZhUKVTMhqP8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c17293b9-9f02-4367-b502-08d59db26283
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096690D5A583B3F538D27B25FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GxK7sEiQtOv3N6OogGf1zvAvMR3RbeWHkRB0RhX9kLLcoR0GPRBs3s0dK1VuprXxYO/VvUYcDuvRQhwDuZfYwnyjuEwMurENNkNReeesRc0VWH1VQB4kJO544MjVsLc0+UXibgOumOlNfNduDl88QsOIZIHxnZlEGH3ZfZTX8dkOLlj7HLhQsAWCPAJCTA861rJbQtadO5UwFLwrbqZYFLSNYH/GFE0dgcQCssMX3DLd7XSvWFFQ8p5+AKlRE04CKv/m0XVVnRNY9eR8yHobkBqzM9kvE3dBrIW2NELkDnW07cT83vndqRBEvOZGe+8TbVX6D2LiepWZL2n3c/hhwGa7l+Myg+6MIHdTWEMi/uuVGP6OkmENbwNA97KeUv7jbZk2bV/FTs5Kdxh+PQpDqcOs15PycNdJHMOrk+JpeXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <046B4B98DE1593438048A4D2AC5A11F0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17293b9-9f02-4367-b502-08d59db26283
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:36.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
L2FjZXItd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hY2VyLXdtaS5jDQppbmRleCBlODlm
ODhjNDM3ZjMuLjQ5NDljZmMxOWVmZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
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
RkYpDQogDQogLyoNCkBAIC0xMjE3LDYgKzEyMjAsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHR5
cGVfYWFfZG1pX2RlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqaGVhZGVyLCB2b2lkICpk
KQ0KIAkJaW50ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1RIUkVFRzsNCiAJaWYgKHR5
cGVfYWEtPmNvbW11bl9mdW5jX2JpdG1hcCAmIEFDRVJfV01JRDNfR0RTX0JMVUVUT09USCkNCiAJ
CWludGVyZmFjZS0+Y2FwYWJpbGl0eSB8PSBBQ0VSX0NBUF9CTFVFVE9PVEg7DQorCWlmICh0eXBl
X2FhLT5jb21tdW5fZnVuY19iaXRtYXAgJiBBQ0VSX1dNSUQzX0dEU19SRkJUTikgew0KKwkJaW50
ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1JGQlROOw0KKwkJY29tbXVuX2Z1bmNfYml0
bWFwICY9IH5BQ0VSX1dNSUQzX0dEU19SRkJUTjsNCisJfQ0KIA0KIAljb21tdW5fZm5fa2V5X251
bWJlciA9IHR5cGVfYWEtPmNvbW11bl9mbl9rZXlfbnVtYmVyOw0KIH0NCi0tIA0KMi4xNS4xDQo=
