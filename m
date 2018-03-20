Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1907187-1521568586-2-5351377365534723405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521568585; b=YcVnn4YNOGv9HNOqDLbXvimhr5/UUnxGgPCQQmrrzyUIbzH
    WqdBrvwdwcQDUSK1BWslxFRa4Q9nQCUg8tbjfDNlovNti0MXgMEunEkeWy4arFg9
    Isp9l9U673J1Q+uoQAxRG/8uB00B+9NJmRHXmMc2UWI3177XrypQFLF6cBtEcKAK
    mf1eR96HzfISKN6FvTX4TyZwWtu7bNBAp2XHifUIz4gKRRq2LYd6XXnDsIdrYZf/
    DLyRzO2H9GzJSjM8E/ikrEtbEt6tqzuDMrqe9hKwizUzfu216l5w2Okq1lc8o5dY
    626aPv+6skYaRm7ca7iJGQhFgmAdkVFzbtsY/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521568585; bh=MykNrjGqcPT6h8aqlEuEn+/iHUv
    nHPR3BnP+zhtXayo=; b=VqPDZc5KE19CAXYfmV4ZiSmm5gwQLiHAtVD5xhthkQI
    pJ/d0PGTgYlPnxr8VX2Yg89DHYp4nGUcTJgkK+H+R40MmMcfMfAtfzWAMl2qbRYA
    z5Xxi5qhaKLyWc/x+hPDsEa7MjtS2IoGZYIsu1xqntam7DsnF8KuXP9JnDnhUZJv
    OWWHE+WuwNJPRDt/YZG51aT/eg786fgbiyYs0KWFMU8VPoALz5Tk3pWrXeTJv+L3
    SBWXvrVMgQmq3t+A7DYAEJ5w+jFpEf+M899DwudSdyLvicgwiZ06D6gMvG1SESG9
    HfNm1QVRHsju/rATJnRTE4rPyo0N4qtckIS7rcC4GQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIr/b8KY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIr/b8KY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngIAH090A
Date: Tue, 20 Mar 2018 17:56:15 +0000
Message-ID: <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
In-Reply-To: <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:8::642]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0169;
 7:0v4jJxkn6uR8SEKQJs1f/h9CTeYFUUlxj13JzboW9pWYfcoV/e3Gu61V/vTRwZ2nRrPJ5jPpJmdftXu65aOkcPu6LIfgECVPFqa8e0RAjt0o6UXwLH+lQHwYQ5bJFnlPG6a8wfG2NJkc9hJRf8F5LRvkv9vJcVjo4HQ+uRP1SRRvGfEREfIcpfiXXkPT9UMXrqAgYhbciWE2zdWBpa6Qo9D3ROL2rKuzXVpBMqIVkfH6q+xWxX8nE4+rDlv0Rh5y;
 20:yr8MTb6xYF36lLLEGhij32Kt807tk+byabncmxlkZ88ZQkYecBO4s31dz+FCTmGyhRLTYiCSiKAzbfW8LAF8/MTrSKd40sODAc01sgEF3FOSRzgjVhVeGS+imkw6FYdEn9ZygonFzg/LiSIM+9v9s5t692v/pHnvzfOQ7NP6Shc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49d2290b-49d8-4818-fdfb-08d58e8be045
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0169;
x-ms-traffictypediagnostic: DM5PR21MB0169:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB01691F6C368F927FC8B70003F6AB0@DM5PR21MB0169.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501313)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0169; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0169;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(39380400002)(40224003)(13464003)(189003)(199004)(316002)(22452003)(2900100001)(25786009)(76176011)(93886005)(4326008)(7736002)(46003)(305945005)(5250100002)(82746002)(33656002)(10090500001)(8936002)(59450400001)(105586002)(10290500003)(81166006)(81156014)(8676002)(68736007)(86362001)(6486002)(97736004)(86612001)(106356001)(229853002)(6246003)(83716003)(99286004)(14454004)(36756003)(102836004)(6916009)(54906003)(2950100002)(478600001)(2906002)(6512007)(3280700002)(5660300001)(3660700001)(6436002)(186003)(6506007)(72206003)(6116002)(53546011)(53936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0169;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: ebaj1t9Pd34jouM917oMJVZf7TkXiu/1Ud5zMJJhaQUc4t6vf4mFVjaXYy/EkSd77rOzbLefkeefZPLDplhoT8NzcqmnW/g9XjcdN8rU9LVEGkSw2ExQRWVyx9NDC7S7hM05FGQsAO3EQDHbYjTCI9zxY8+tex9hV3ZaS//DCxWEDMvWmr5HmhvhqSKuWX2xi/9Detx9NcTCMEEmOrXc69xBsmngcWp6KjyRz3tbbfJ1fWVHV0fjS7El+38QBwzrK1UnMg9luFrWr2oV53d6Y1z/mgyC10WYlkbo+yAHXuhdkkGvq0BnqdFufjYZBBHrUQALrQjFpd1PzF2Eqc27Dw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <E71B6EA91576B944B285F03C2DEB8DC9@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d2290b-49d8-4818-fdfb-08d58e8be045
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 17:56:15.5333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0169
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgTG9yZW56bywNCkFyZSB3ZSBnb29kIHdpdGggdGhlIGV4cGxhbmF0aW9uPyBDYW4gSSBzZW5k
IHRoZSBwYXRjaCB3aXRoIHRoZSB1cGRhdGVkIGNvbW1pdCBjb21tZW50cz8NCg0KVGhhbmtzDQpT
cmlkaGFyDQoNCu+7v09uIDMvMTUvMTgsIDExOjI0IEFNLCAiU3JpZGhhciBQaXRjaGFpIiA8U3Jp
ZGhhci5QaXRjaGFpQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KDQogICAgQXBvbG9naWVzIGZvciBu
b3QgYWxpZ25pbmcgbXkgcmVwbHksIEkganVzdCByZWFsaXplZCBhZnRlciBsb29raW5nIGludG8N
CiAgICB0aGUgbWFpbCBhcmNoaXZlIGluIExLTUwuICBJIGhhdmUgYWxpZ25lZCB0aGUgcmVwbGF5
IG5vdy4NCiAgICANCiAgICANCiAgICBPbiAzLzE1LzE4LCAxMDo1NiBBTSwgIlNyaWRoYXIgUGl0
Y2hhaSIgPFNyaWRoYXIuUGl0Y2hhaUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCiAgICANCiAgICBI
aSBMb3JlbnpvLA0KICAgIEFuc3dlcmluZyB0aGUgcXVlc3Rpb24gaW5saW5lLg0KICAgIEtpbmRs
eSBsZXQgbWUga25vdyBpZiBpdCBjbGFyaWZpZXMuIEkgd2lsbCBzZW5kIG91dCBhbm90aGVyIHBh
dGNoIGFmdGVyIHdlIGFncmVlIG9uIHRoZSBjbGFyaWZpY2F0aW9uLg0KICAgIA0KICAgIFRoYW5r
cw0KICAgIFNyaWRoYXIgUGl0Y2hhaQ0KICAgIA0KICAgIC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQogICAgRnJvbTogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5j
b20+DQogICAgU2VudDogVGh1cnNkYXksIE1hcmNoIDE1LCAyMDE4IDU6MDUgQU0NCiAgICBUbzog
U3JpZGhhciBQaXRjaGFpIDxTcmlkaGFyLlBpdGNoYWlAbWljcm9zb2Z0LmNvbT4NCiAgICBDYzog
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IEpha2UgT3NoaW5zIDxqYWtlb0Bt
aWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFN0
ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgTWlj
aGFlbCBLZWxsZXkgKEVPU0cpIDxNaWNoYWVsLkguS2VsbGV5QG1pY3Jvc29mdC5jb20+OyBkZXZl
bEBsaW51eGRyaXZlcnByb2plY3Qub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQogICAgU3ViamVjdDogUmU6IFtQQVRDSCB2M11QQ0k6
IGh2OiBmaXggUENJLUJVUyBkb21haW5JRCBjb3JydXB0aW9uDQogICAgDQogICAgT24gVGh1LCBN
YXIgMTUsIDIwMTggYXQgMTI6MDM6MDdBTSArMDAwMCwgU3JpZGhhciBQaXRjaGFpIHdyb3RlOg0K
ICAgIFdoZW5ldmVyIFBDSSBidXMgaXMgYWRkZWQsIEh5cGVyViBndWFyYW50ZWVzIHRoZSBCVVMg
aWQgaXMgdW5pcXVlLiBFdmVuDQogICAgDQogICAgIldoZW5ldmVyIGEgUENJIGJ1cyBpcyBhZGRl
ZCINCiAgICBTcmlkaGFyPj4geWVzDQogICAgDQogICAgd2l0aCB0aGF0IHdoZW4gYSBmaXJzdCBk
ZXZpY2UgaXMgYWRkZWQgdG8gdGhlIGJ1cywgaXQgb3ZlcnJpZGVzIGJ1cyBkb21haW4NCiAgICBJ
RCB3aXRoIHRoZSBkZXZpY2Ugc2VyaWFsIG51bWJlci4gU29tZXRpbWUgdGhpcyBjYW4gcmVzdWx0
IGluIEJVUyBJRCBub3QNCiAgICANCiAgICBEZWZpbmUgIlNvbWV0aW1lIi4NCiAgICANCiAgICBT
cmlkaGFyPj4gSHlwZXJWIHdoZW4gaXQgY3JlYXRlcyBhIFBDSSBidXMgaXQgZ3VhcmFudGVlcyBp
dCBwcm92aWRlIGEgdW5pcXVlIElEIGZvciBpdC4NCiAgICBCdXQsIHRoYXQgdW5pcXVlIEJVUyBJ
RCBpcyByZXBsYWNlZCB3aXRoIGRldmljZSBzZXJpYWwgbnVtYmVyLiAwIGlzIGEgdmFsaWQNCiAg
ICBkZXZpY2Ugc2VyaWFsIG51bWJlciwgYW5kIGlmIHRoZXJlIGV4aXN0cyBhIFBDSSBidXMgd2l0
aCBkb21haW4gSUQgMCAoR2VuIDENCiAgICB2ZXJzaW9uIG9mIGh5cGVyViBWTSBoYXZlIHRoaXMg
Zm9yIHBhcmEgdmlydHVhbCBkZXZpY2VzKSwgdGhpcyB3aWxsIHJlc3VsdCBpbg0KICAgIFBDSSBi
dXMgaWQgbm90IGJlaW5nIHVuaXF1ZS4NCiAgICANCiAgICANCiAgICBiZWluZyB1bmlxdWUuIElu
IHRoaXMgY2FzZSwgd2hlbiBQQ0lfQlVTIGFuZCBhIGRldmljZSB0byBidXMgaXMgYWRkZWQsIHRo
ZQ0KICAgIGZpcnN0IGRldmljZSBvdmVyd3JpdGVzIHRoZSBidXMgZG9tYWluIElEIHRvIHRoZSBk
ZXZpY2Ugc2VyaWFsIG51bWJlciwNCiAgICB3aGljaCBpcyAwLiBTaW5jZSB0aGVyZSBleHNpc3Qg
YSBQQ0kgYnVzIHdpdGggZG9tYWluIElEIDAgYWxyZWFkeSB0aGUgUENJDQogICAgDQogICAgcy9l
eHNpc3QvZXhpc3QNCiAgICANCiAgICBTcmlkaGFyPj4geWVzDQogICAgDQogICAgYnVzIGFkZGl0
aW9uIGZhaWxzLiBUaGlzIHBhdGNoIG1ha2Ugc3VyZSB3aGVuIGEgZGV2aWNlIGlzIGFkZGVkIHRv
IGEgYnVzLA0KICAgIGl0IG5ldmVyIHVwZGF0ZWQgdGhlIGJ1cyBkb21haW4gSUQuDQogICAgDQog
ICAgcy91cGRhdGVkL3VwZGF0ZXMNCiAgICBTcmlkaGFyID4+IHllcw0KICAgIA0KICAgIFNpbmNl
IHdlIGhhdmUgdGhlIHRyYW5zcGFyZW50IFNSSU9WIG1vZGUgbm93LCB0aGUgc2hvcnQgVkYgZGV2
aWNlIG5hbWUNCiAgICBpcyBubyBsb25nZXIgbmVlZGVkLg0KICAgIA0KICAgIEkgc3RpbGwgZG8g
bm90IHVuZGVyc3RhbmQgd2hhdCB0aGlzIG1lYW5zIGFuZCBob3cgaXQgaXMgcmVsYXRlZCB0byB0
aGUNCiAgICBwYXRjaCBiZWxvdywgaXQgbWF5IGJlIGNsZWFyIHRvIHlvdSwgaXQgaXMgbm90IHRv
IG1lLCBhdCBhbGwuDQogICAgDQogICAgU3JpZGhhciA+PiB0aGUgcGF0Y2ggYmVsb3csIHdhcyBp
bnRyb2R1Y2VkIHRvIG1ha2UgdGhlIGRldmljZSBuYW1lIHNtYWxsLCBieSB0YWtpbmcgb25seQ0K
ICAgIDE2Yml0cyBvZiB0aGUgc2VyaWFsIG51bWJlci4gU2luY2Ugd2UgYXJlIG5vdCBnb2luZyB0
byBoYXZlIHRoZSBzZXJpYWwgbnVtYmVyDQogICAgdXBkYXRlZCB0byB0aGUgQlVTIGlkLCB0aGlz
IGhhcyB0byBiZSByZW1vdmVkLg0KICAgIA0KICAgIEZpeGVzOiA0YTliMDkzM2JkZmMoIlBDSTpo
djpVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiIpDQogICAgDQogICAgRml4
ZXM6IDRhOWIwOTMzYmRmYyAoIlBDSTogaHY6IFVzZSBkZXZpY2Ugc2VyaWFsIG51bWJlciBhcyBQ
Q0kgZG9tYWluIikNCiAgICBTcmlkaHIgPj4geWVzDQogICAgDQogICAgSSBhc2tlZCB5b3UgYW4g
ZXhwbGljaXQgcXVlc3Rpb24uIENvbW1pdCBhYm92ZSB3YXMgYWRkZWQgZm9yIGEgcmVhc29uDQog
ICAgSSBhc3N1bWUuIFRoaXMgcGF0Y2ggaW1wbGllcyB0aGF0IGtlcm5lbCBoYXMgYmVlbiBicm9r
ZW4gc2luY2UgdjQuMTENCiAgICB3aGljaCBpcyBhbG1vc3QgYSB5ZWFyIGFnbyBhbmQgbm9ib2R5
IGV2ZXJ5IG5vdGljZWQgPyBPciB0aGVyZSBhcmUNCiAgICBzeXN0ZW1zIHdoZXJlIGNvbW1pdCBh
Ym92ZSBpcyBfbmVjZXNzYXJ5XyBhbmQgdGhpcyBwYXRjaCB3b3VsZCBicmVhaw0KICAgIHRoZW0g
Pw0KICAgIA0KICAgIEkgd2FudCBhIGRldGFpbGVkIGV4cGxhbmF0aW9uIHRoYXQgaGlnaGxpZ2h0
cyAqd2h5KiBpdCBpcyBzYWZlIHRvIGFwcGx5DQogICAgdGhpcyBwYXRjaCBhbmQgc2VuZCBpdCB0
byBzdGFibGUga2VybmVscywgY29tbWl0IGxvZyBhYm92ZSB3b24ndCBkby4NCiAgICANCiAgICBT
cmlkaGFyPj4gSHlwZXJWIHByb3ZpZGVzIGEgdW5pcXVlIGRvbWFpbiBJRCBmb3IgUENJIEJVUy4g
QnV0IGl0IGlzIG1vZGlmaWVkIGJ5IHRoZSBjaGlsZA0KICAgIGRldmljZSB3aGVuIGl0IGlzIGFk
ZGVkLiBUaGlzIGNhbm5vdCBwcm9kdWNlIGEgdW5pcXVlIGRvbWFpbiBJRCBhbGwgdGhlIHRpbWUu
DQogICAgSGVyZSBpbiB0aGUgYnVnLCB3ZSBzZWUgdGhlIGNvbGxpc2lvbiBiZXR3ZWVuIHRoZSBz
ZXJpYWwgbnVtYmVyIGFuZCBhbHJlYWR5DQogICAgZXhpc3RpbmcgUENJIGJ1cy4gVGhlIGNsZWFu
ZXIgd2F5IGlzIG5ldmVyIHRvdWNoIHRoZSBkb21haW4gSUQgcHJvdmlkZWQgYnkNCiAgICBoeXBl
clYgZHVyaW5nIHRoZSBQQ0kgYnVzIGNyZWF0aW9uLiBBcyBsb25nIGFzIGh5cGVyViBtYWtlIHN1
cmUgaXQgcHJvdmlkZXMgYQ0KICAgIHVuaXF1ZSBkb21haW4gSUQgZm9yIHRoZSBQQ0kgZm9yIGEg
Vk0gaXQgd2lsbCBub3QgYnJlYWssIGFuZCBIeXBlclYgd2lsbA0KICAgIGd1YXJhbnRlZXMgdGhh
dCB0aGUgZG9tYWluIGZvciB0aGUgUENJIGJ1cyBmb3IgYSBnaXZlbiBWTSB3aWxsIGJlIGFsd2F5
cyB1bmlxdWUuDQogICAgVGhlIG9yaWdpbmFsIHBhdGNoIHdhcyBhbHNvIGludGVuZGluZyB0byBo
YXZlIGEgdW5pcXVlIGRvbWFpbiBJRCBmb3IgdGhlIFBDSQ0KICAgIGJ1cywgYnkgdGFraW5nIHRo
ZSBzZXJpYWwgbnVtYmVyIG9mIHRoZSBkZXZpY2UsIGJ1dCBpdCBpcyBub3Qgc3VmZmljaWVudCwg
d2hlbg0KICAgIHRoZSBkZXZpY2Ugc2VyaWFsIG51bWJlciBpcyBudW1iZXIgd2hpY2ggaXMgdGhl
IGRvbWFpbiBJRCBvZiB0aGUgZXhpc3RpbmcgUENJDQogICAgYnVzLiAgV2l0aCB0aGUgY3VycmVu
dCBrZXJuZWwgd2UgY2FuIHJlcHJvIHRoaXMgaXNzdWUgYnkgYWRkaW5nIGEgZGV2aWNlIHdpdGgg
YQ0KICAgIHNlcmlhbCBudW1iZXIgbWF0Y2hpbmcgdGhlIGV4aXN0aW5nIFBDSSBidXMgZG9tYWlu
IGlkLiAoaW4gdGhpcyBjYXNlIHRoYXQNCiAgICBoYXBwZW5zIHRvIGJlIHplcm8pLg0KICAgIA0K
ICAgIA0KICAgIFRoYW5rcywNCiAgICBMb3JlbnpvDQogICAgDQogICAgQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCiAgICBTaWduZWQtb2ZmLWJ5OiBTcmlkaGFyIFBpdGNoYWkgPHNycGl0Y2hh
QG1pY3Jvc29mdC5jb20+DQogICAgLS0tDQogICAgQ2hhbmdlcyBpbiB2MzoNCiAgICAqIGZpeCB0
aGUgY29tbWl0IGNvbW1lbnQuIFtLWSBTcmluaXZhc2FuLCBNaWNoYWVsIEtlbGxleV0NCiAgICAt
LS0NCiAgICAgIGRyaXZlcnMvcGNpL2hvc3QvcGNpLWh5cGVydi5jIHwgMTEgLS0tLS0tLS0tLS0N
CiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBkZWxldGlvbnMoLSkNCiAgICBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvaG9zdC9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBl
cnYuYw0KICAgIGluZGV4IDJmYWYzOGUuLmFjNjdlNTYgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVy
cy9wY2kvaG9zdC9wY2ktaHlwZXJ2LmMNCiAgICArKysgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1o
eXBlcnYuYw0KICAgIEBAIC0xNTE4LDE3ICsxNTE4LDYgQEAgc3RhdGljIHN0cnVjdCBodl9wY2lf
ZGV2ICpuZXdfcGNpY2hpbGRfZGV2aWNlKHN0cnVjdCBodl9wY2lidXNfZGV2aWNlICpoYnVzLA0K
ICAgICAgCWdldF9wY2ljaGlsZChocGRldiwgaHZfcGNpZGV2X3JlZl9jaGlsZGxpc3QpOw0KICAg
ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZoYnVzLT5kZXZpY2VfbGlzdF9sb2NrLCBmbGFncyk7DQog
ICAgICANCiAgICAtCS8qDQogICAgLQkgKiBXaGVuIGEgZGV2aWNlIGlzIGJlaW5nIGFkZGVkIHRv
IHRoZSBidXMsIHdlIHNldCB0aGUgUENJIGRvbWFpbg0KICAgIC0JICogbnVtYmVyIHRvIGJlIHRo
ZSBkZXZpY2Ugc2VyaWFsIG51bWJlciwgd2hpY2ggaXMgbm9uLXplcm8gYW5kDQogICAgLQkgKiB1
bmlxdWUgb24gdGhlIHNhbWUgVk0uICBUaGUgc2VyaWFsIG51bWJlcnMgc3RhcnQgd2l0aCAxLCBh
bmQNCiAgICAtCSAqIGluY3JlYXNlIGJ5IDEgZm9yIGVhY2ggZGV2aWNlLiAgU28gZGV2aWNlIG5h
bWVzIGluY2x1ZGluZyB0aGlzDQogICAgLQkgKiBjYW4gaGF2ZSBzaG9ydGVyIG5hbWVzIHRoYW4g
YmFzZWQgb24gdGhlIGJ1cyBpbnN0YW5jZSBVVUlELg0KICAgIC0JICogT25seSB0aGUgZmlyc3Qg
ZGV2aWNlIHNlcmlhbCBudW1iZXIgaXMgdXNlZCBmb3IgZG9tYWluLCBzbyB0aGUNCiAgICAtCSAq
IGRvbWFpbiBudW1iZXIgd2lsbCBub3QgY2hhbmdlIGFmdGVyIHRoZSBmaXJzdCBkZXZpY2UgaXMg
YWRkZWQuDQogICAgLQkgKi8NCiAgICAtCWlmIChsaXN0X2VtcHR5KCZoYnVzLT5jaGlsZHJlbikp
DQogICAgLQkJaGJ1cy0+c3lzZGF0YS5kb21haW4gPSBkZXNjLT5zZXI7DQogICAgICAJbGlzdF9h
ZGRfdGFpbCgmaHBkZXYtPmxpc3RfZW50cnksICZoYnVzLT5jaGlsZHJlbik7DQogICAgICAJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KICAg
ICAgCXJldHVybiBocGRldjsNCiAgICAtLQ0KICAgIDIuNy40IA0KICAgIA0KICAgIA0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5n
IGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4
ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
