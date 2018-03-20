Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2558472-1521586848-2-15584550953859708459
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
    t=1521586847; b=NKzAitTLGwGwYYyAKoDCOOQeYzlhnwKF+frO8/W37yd6BGP
    Q2AgxyLs3R0zsHEwVwVFgra7ZJ3ieSGGJFexqId+mfOw1XChtavsNouwZAeFBewA
    kBHyJXtUm4da7F1jKn78jZXOF3Jtraw6ldt62W41+D1qjgm4CJTKNjsyto2h8aBY
    DQsiaxk2e6uC4OUeuceWBmksXWr9Fdj2fNNirkOkJsvh4HPxjcHlUDw/iIUxeqcJ
    ObAkzScXlYXQ2JTBAKfgaWgQqIpyVovKeV1mF61rkRS423NF4bf92+7PZr7TEszZ
    4kGl33pZ1PCJL6DNK3ZIhcifRLVpBvcEIofAcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521586847; bh=IenC7RIqF1MRFpg9ANhDxzSzRux
    uljJCKdtMVUtCWWI=; b=IVJcHCMiWGP+BOTimTKfP/w0ga+eYtFEkUPdEIuj7g8
    nRRmMuJKhIOwghjEx9bG49x7ejL0jF1cNbhVU9elLbiqhgsPv9Dn4wr0WKupfsjL
    ZrlFjtdMm6ay5j0E4wpoM7miHr+Ya2nQ+tJivI/6ACMqEkCm1KKrKLvXOdlUQznu
    P5x/nGzLJKcJNR6TzxB3WUFvusSsXpmgnEQLtHG5vzuaoi2PZjbDvfYA9rBFEG7Y
    RjOY5XA3VUn1RCX3H861hxUEI2VzKmr24vEkmCbgLMXHmJOWN0oRPCJYynlNkau3
    yUTAUUoUrCgmwJJK6K47eQEVK5ETSsXjxZG6HmI4i3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NauPv0Xu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NauPv0Xu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngIAH090AgAB/YQD//9WnAA==
Date: Tue, 20 Mar 2018 23:00:36 +0000
Message-ID: <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8::6f0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0842;
 7:7tvNtkw1QyPSdUYFpoONXkrsfgqwA4uVJH6BDizvOPQEvci7XyKxZ+Y/8Gonv1L2jS71wr2fwIK84V7Zx3N+RKQrBq7pRmuw6kK5Ug9XUFLo3aZYx3MNrqRCW0wvKqI3N8/HXmvd8V0fh5H8qZMMx8n0sb//gE2GVRBGYQwXi1v64CMVKAKmwOYqEQEjcwj2IwCYm0KqfWG+QV9vC089HVy/426a1m30xB4t9TV6V8pMbvLUqY+tIuvloCLEdjKs;
 20:YSo3/D7l5aqDD8tvMU/v4JEZG4OeC2LJAJw60djFINkrJpHXWaRrs1OOaRyBwACHJKQpH1Kc41ryumnQ3ADm/mxKH+KeuSr3cJcKpyPPeTTN005HOh1xYlvEetC04csGGms7/xwpkLip0E994gctfqloSKNMMkFUedjBBpu96Iw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce37714d-baba-409d-ee9e-08d58eb664e0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0842;
x-ms-traffictypediagnostic: DM5PR21MB0842:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB0842B5C8A5F246F63A2EB2DBF6AB0@DM5PR21MB0842.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(189930954265078)(84791874153150)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501316)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0842; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0842;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(40224003)(199004)(189003)(105586002)(97736004)(102836004)(99286004)(53936002)(5250100002)(6486002)(186003)(3660700001)(68736007)(6436002)(6512007)(3280700002)(54906003)(6306002)(2900100001)(82746002)(2906002)(10090500001)(33656002)(59450400001)(6506007)(6116002)(106356001)(6246003)(316002)(22452003)(86612001)(86362001)(46003)(14454004)(93886005)(4326008)(478600001)(83716003)(25786009)(36756003)(6916009)(2950100002)(966005)(5660300001)(72206003)(229853002)(76176011)(7736002)(10290500003)(81156014)(305945005)(81166006)(8676002)(8936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0842;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: hk7XGq51Q3pqCPQnhEfCMn+E3/P9JrP8r67vuQecCeRODxySPMylCi0VhquNCB8miWeQ9R6VKtMzr4Kf+aBOq6btVpLqIsgv0mYZG3hGz4ms6hMHbRESVeqGaFpgZtzaaIIjVrhRinRVUE5nV2ynfYdvtaSjqGg6t3c/g587Ks8V0OJEGXHBl/xK/vNGIWmciyMlnEN+iQA4/pHTnjYzioTcOSMn8HyZIcDhXTpziqA8yeLzT1DBxhl9sXWmC6LsGVaOqUNVRBSePwk+eCeFchcTIUZhJOSSEr5e1CioL0lpYp2kCUa5u/UFXdzhE4vct2+FevccYKVUHfOAlrrldA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <316AA6E636888748BA17B3230720E712@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce37714d-baba-409d-ee9e-08d58eb664e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 23:00:36.8796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0842
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

SGkgTG9yZW56bywNCiAgIFRyYW5zcGFyZW50IFNSSU9WIGlzIGV4cG9zaW5nIHRoZSBOSUMgZGly
ZWN0bHkgdG8gdGhlIGtlcm5lbCB2aWENCnBhcmEtdmlydHVhbCBkZXZpY2UsIHVubGlrZSBjcmVh
dGluZyBhIG5ldGRldiBhbmQgYXNzb2NpYXRpbmcgaXQgd2l0aCB0aGUgYm9uZA0KZHJpdmVyLiBG
dXJ0aGVyIGRlc2NyaXB0aW9ucyBoZXJlLA0KICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD0wYzE5
NTU2N2E4ZjZlODJlYTU1MzVjZDlmMWQ1NGExNjI2ZGQyMzNlDQoNClByZXZpb3VzbHksIHdoZW4g
dXNpbmcgdGhlIGJvbmQgZHJpdmVyLCB1bmlxdWUgYW5kIHBlcnNpc3RlbnQgVkYgTklDIG5hbWUN
CndhcyByZXF1aXJlZCwgc28gd2UgdXNlZCBzZXJpYWwgbnVtYmVyIGFzIFBDSSBkb21haW4gd2hp
Y2ggaXMgaW5jbHVkZWQgYXMNCnBhcnQgb2YgdGhlIFZGIE5JQyBuYW1lLiAgVHJhbnNwYXJlbnQg
U1JJT1YgbW9kZSBwdXRzIFZGIE5JQyBiYXNlZCBvbiBNQUMNCm1hdGNoIGFzIGEgc2xhdmUgb2Yg
c3ludGhldGljIE5JQywgc28gVkYgTklD4oCZcyBuYW1lIGlzIG5vIGxvbmdlciBpbXBvcnRhbnQu
DQoNClRoYW5rcywNClNyaWRoYXINCg0K77u/T24gMy8yMC8xOCwgMTE6MzIgQU0sICJMb3Jlbnpv
IFBpZXJhbGlzaSIgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+IHdyb3RlOg0KDQogICAgT24g
VHVlLCBNYXIgMjAsIDIwMTggYXQgMDU6NTY6MTVQTSArMDAwMCwgU3JpZGhhciBQaXRjaGFpIHdy
b3RlOg0KICAgID4gSGkgTG9yZW56bywNCiAgICANCiAgICA+IEFyZSB3ZSBnb29kIHdpdGggdGhl
IGV4cGxhbmF0aW9uPyBDYW4gSSBzZW5kIHRoZSBwYXRjaCB3aXRoIHRoZQ0KICAgID4gdXBkYXRl
ZCBjb21taXQgY29tbWVudHM/DQogICAgDQogICAgQWxtb3N0Lg0KICAgIA0KICAgIFsuLi5dDQog
ICAgDQogICAgPiAgICAgU2luY2Ugd2UgaGF2ZSB0aGUgdHJhbnNwYXJlbnQgU1JJT1YgbW9kZSBu
b3csIHRoZSBzaG9ydCBWRiBkZXZpY2UgbmFtZQ0KICAgID4gICAgIGlzIG5vIGxvbmdlciBuZWVk
ZWQuDQogICAgDQogICAgQ2FuIHlvdSBjb3JyZWxhdGUgdHJhbnNwYXJlbnQgU1JJT1YgbW9kZSB0
byB0aGUgcG9pbnQgeW91IGFyZSBtYWtpbmcNCiAgICBiZWxvdyA/IFBsZWFzZSBleHBsYWluIHdo
YXQgdHJhbnNwYXJlbnQgU1JJT1YgbW9kZSBhbGxvd3MgeW91IHRvIHJlbW92ZQ0KICAgIGFuZCB3
aHkuIFRoZSByZXN0IG9mIHRoZSBleHBsYW5hdGlvbiBzZWVtcyBPSy4NCiAgICANCiAgICBQbGVh
c2UgZm9sbG93IHRoaXMgZW1haWwgZm9ybWF0Og0KICAgIA0KICAgIGh0dHBzOi8vbmEwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ2Z2VyLmtlcm5l
bC5vcmclMkZsa21sJTJGJTIzczMtOSZkYXRhPTA0JTdDMDElN0NTcmlkaGFyLlBpdGNoYWklNDBt
aWNyb3NvZnQuY29tJTdDYzVjZGNiNzk1MWY2NDMxOGU1MjcwOGQ1OGU5MGU2ZjIlN0M3MmY5ODhi
Zjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM2NTcxNjc1MzY2MTgxNzM4JTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lmUSUzRCUzRCU3Qy0xJnNkYXRhPXlCZHFjNE5RWnNPN085dmZnSnNy
NW9sVThHZkxOakY1ZTlFQWFDYjd2cTQlM0QmcmVzZXJ2ZWQ9MA0KICAgIA0KICAgIFRoYW5rcywN
CiAgICBMb3JlbnpvDQogICAgDQogICAgPiAgICAgSSBzdGlsbCBkbyBub3QgdW5kZXJzdGFuZCB3
aGF0IHRoaXMgbWVhbnMgYW5kIGhvdyBpdCBpcyByZWxhdGVkIHRvIHRoZQ0KICAgID4gICAgIHBh
dGNoIGJlbG93LCBpdCBtYXkgYmUgY2xlYXIgdG8geW91LCBpdCBpcyBub3QgdG8gbWUsIGF0IGFs
bC4NCiAgICA+ICAgICANCiAgICA+ICAgICBTcmlkaGFyID4+IHRoZSBwYXRjaCBiZWxvdywgd2Fz
IGludHJvZHVjZWQgdG8gbWFrZSB0aGUgZGV2aWNlIG5hbWUgc21hbGwsIGJ5IHRha2luZyBvbmx5
DQogICAgPiAgICAgMTZiaXRzIG9mIHRoZSBzZXJpYWwgbnVtYmVyLiBTaW5jZSB3ZSBhcmUgbm90
IGdvaW5nIHRvIGhhdmUgdGhlIHNlcmlhbCBudW1iZXINCiAgICA+ICAgICB1cGRhdGVkIHRvIHRo
ZSBCVVMgaWQsIHRoaXMgaGFzIHRvIGJlIHJlbW92ZWQuDQogICAgPiAgICAgDQogICAgPiAgICAg
Rml4ZXM6IDRhOWIwOTMzYmRmYygiUENJOmh2OlVzZSBkZXZpY2Ugc2VyaWFsIG51bWJlciBhcyBQ
Q0kgZG9tYWluIikNCiAgICA+ICAgICANCiAgICA+ICAgICBGaXhlczogNGE5YjA5MzNiZGZjICgi
UENJOiBodjogVXNlIGRldmljZSBzZXJpYWwgbnVtYmVyIGFzIFBDSSBkb21haW4iKQ0KICAgID4g
ICAgIFNyaWRociA+PiB5ZXMNCiAgICA+ICAgICANCiAgICA+ICAgICBJIGFza2VkIHlvdSBhbiBl
eHBsaWNpdCBxdWVzdGlvbi4gQ29tbWl0IGFib3ZlIHdhcyBhZGRlZCBmb3IgYSByZWFzb24NCiAg
ICA+ICAgICBJIGFzc3VtZS4gVGhpcyBwYXRjaCBpbXBsaWVzIHRoYXQga2VybmVsIGhhcyBiZWVu
IGJyb2tlbiBzaW5jZSB2NC4xMQ0KICAgID4gICAgIHdoaWNoIGlzIGFsbW9zdCBhIHllYXIgYWdv
IGFuZCBub2JvZHkgZXZlcnkgbm90aWNlZCA/IE9yIHRoZXJlIGFyZQ0KICAgID4gICAgIHN5c3Rl
bXMgd2hlcmUgY29tbWl0IGFib3ZlIGlzIF9uZWNlc3NhcnlfIGFuZCB0aGlzIHBhdGNoIHdvdWxk
IGJyZWFrDQogICAgPiAgICAgdGhlbSA/DQogICAgPiAgICAgDQogICAgPiAgICAgSSB3YW50IGEg
ZGV0YWlsZWQgZXhwbGFuYXRpb24gdGhhdCBoaWdobGlnaHRzICp3aHkqIGl0IGlzIHNhZmUgdG8g
YXBwbHkNCiAgICA+ICAgICB0aGlzIHBhdGNoIGFuZCBzZW5kIGl0IHRvIHN0YWJsZSBrZXJuZWxz
LCBjb21taXQgbG9nIGFib3ZlIHdvbid0IGRvLg0KICAgID4gICAgIA0KICAgID4gICAgIFNyaWRo
YXI+PiBIeXBlclYgcHJvdmlkZXMgYSB1bmlxdWUgZG9tYWluIElEIGZvciBQQ0kgQlVTLiBCdXQg
aXQgaXMgbW9kaWZpZWQgYnkgdGhlIGNoaWxkDQogICAgPiAgICAgZGV2aWNlIHdoZW4gaXQgaXMg
YWRkZWQuIFRoaXMgY2Fubm90IHByb2R1Y2UgYSB1bmlxdWUgZG9tYWluIElEIGFsbCB0aGUgdGlt
ZS4NCiAgICA+ICAgICBIZXJlIGluIHRoZSBidWcsIHdlIHNlZSB0aGUgY29sbGlzaW9uIGJldHdl
ZW4gdGhlIHNlcmlhbCBudW1iZXIgYW5kIGFscmVhZHkNCiAgICA+ICAgICBleGlzdGluZyBQQ0kg
YnVzLiBUaGUgY2xlYW5lciB3YXkgaXMgbmV2ZXIgdG91Y2ggdGhlIGRvbWFpbiBJRCBwcm92aWRl
ZCBieQ0KICAgID4gICAgIGh5cGVyViBkdXJpbmcgdGhlIFBDSSBidXMgY3JlYXRpb24uIEFzIGxv
bmcgYXMgaHlwZXJWIG1ha2Ugc3VyZSBpdCBwcm92aWRlcyBhDQogICAgPiAgICAgdW5pcXVlIGRv
bWFpbiBJRCBmb3IgdGhlIFBDSSBmb3IgYSBWTSBpdCB3aWxsIG5vdCBicmVhaywgYW5kIEh5cGVy
ViB3aWxsDQogICAgPiAgICAgZ3VhcmFudGVlcyB0aGF0IHRoZSBkb21haW4gZm9yIHRoZSBQQ0kg
YnVzIGZvciBhIGdpdmVuIFZNIHdpbGwgYmUgYWx3YXlzIHVuaXF1ZS4NCiAgICA+ICAgICBUaGUg
b3JpZ2luYWwgcGF0Y2ggd2FzIGFsc28gaW50ZW5kaW5nIHRvIGhhdmUgYSB1bmlxdWUgZG9tYWlu
IElEIGZvciB0aGUgUENJDQogICAgPiAgICAgYnVzLCBieSB0YWtpbmcgdGhlIHNlcmlhbCBudW1i
ZXIgb2YgdGhlIGRldmljZSwgYnV0IGl0IGlzIG5vdCBzdWZmaWNpZW50LCB3aGVuDQogICAgPiAg
ICAgdGhlIGRldmljZSBzZXJpYWwgbnVtYmVyIGlzIG51bWJlciB3aGljaCBpcyB0aGUgZG9tYWlu
IElEIG9mIHRoZSBleGlzdGluZyBQQ0kNCiAgICA+ICAgICBidXMuICBXaXRoIHRoZSBjdXJyZW50
IGtlcm5lbCB3ZSBjYW4gcmVwcm8gdGhpcyBpc3N1ZSBieSBhZGRpbmcgYSBkZXZpY2Ugd2l0aCBh
DQogICAgPiAgICAgc2VyaWFsIG51bWJlciBtYXRjaGluZyB0aGUgZXhpc3RpbmcgUENJIGJ1cyBk
b21haW4gaWQuIChpbiB0aGlzIGNhc2UgdGhhdA0KICAgID4gICAgIGhhcHBlbnMgdG8gYmUgemVy
bykuDQogICAgPiAgICAgDQogICAgPiAgICAgDQogICAgPiAgICAgVGhhbmtzLA0KICAgID4gICAg
IExvcmVuem8NCiAgICA+ICAgICANCiAgICA+ICAgICBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KICAgID4gICAgIFNpZ25lZC1vZmYtYnk6IFNyaWRoYXIgUGl0Y2hhaSA8c3JwaXRjaGFAbWlj
cm9zb2Z0LmNvbT4NCiAgICA+ICAgICAtLS0NCiAgICA+ICAgICBDaGFuZ2VzIGluIHYzOg0KICAg
ID4gICAgICogZml4IHRoZSBjb21taXQgY29tbWVudC4gW0tZIFNyaW5pdmFzYW4sIE1pY2hhZWwg
S2VsbGV5XQ0KICAgID4gICAgIC0tLQ0KICAgID4gICAgICAgZHJpdmVycy9wY2kvaG9zdC9wY2kt
aHlwZXJ2LmMgfCAxMSAtLS0tLS0tLS0tLQ0KICAgID4gICAgICAgMSBmaWxlIGNoYW5nZWQsIDEx
IGRlbGV0aW9ucygtKQ0KICAgID4gICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9ob3N0L3Bj
aS1oeXBlcnYuYyBiL2RyaXZlcnMvcGNpL2hvc3QvcGNpLWh5cGVydi5jDQogICAgPiAgICAgaW5k
ZXggMmZhZjM4ZS4uYWM2N2U1NiAxMDA2NDQNCiAgICA+ICAgICAtLS0gYS9kcml2ZXJzL3BjaS9o
b3N0L3BjaS1oeXBlcnYuYw0KICAgID4gICAgICsrKyBiL2RyaXZlcnMvcGNpL2hvc3QvcGNpLWh5
cGVydi5jDQogICAgPiAgICAgQEAgLTE1MTgsMTcgKzE1MTgsNiBAQCBzdGF0aWMgc3RydWN0IGh2
X3BjaV9kZXYgKm5ld19wY2ljaGlsZF9kZXZpY2Uoc3RydWN0IGh2X3BjaWJ1c19kZXZpY2UgKmhi
dXMsDQogICAgPiAgICAgICAJZ2V0X3BjaWNoaWxkKGhwZGV2LCBodl9wY2lkZXZfcmVmX2NoaWxk
bGlzdCk7DQogICAgPiAgICAgICAJc3Bpbl9sb2NrX2lycXNhdmUoJmhidXMtPmRldmljZV9saXN0
X2xvY2ssIGZsYWdzKTsNCiAgICA+ICAgICAgIA0KICAgID4gICAgIC0JLyoNCiAgICA+ICAgICAt
CSAqIFdoZW4gYSBkZXZpY2UgaXMgYmVpbmcgYWRkZWQgdG8gdGhlIGJ1cywgd2Ugc2V0IHRoZSBQ
Q0kgZG9tYWluDQogICAgPiAgICAgLQkgKiBudW1iZXIgdG8gYmUgdGhlIGRldmljZSBzZXJpYWwg
bnVtYmVyLCB3aGljaCBpcyBub24temVybyBhbmQNCiAgICA+ICAgICAtCSAqIHVuaXF1ZSBvbiB0
aGUgc2FtZSBWTS4gIFRoZSBzZXJpYWwgbnVtYmVycyBzdGFydCB3aXRoIDEsIGFuZA0KICAgID4g
ICAgIC0JICogaW5jcmVhc2UgYnkgMSBmb3IgZWFjaCBkZXZpY2UuICBTbyBkZXZpY2UgbmFtZXMg
aW5jbHVkaW5nIHRoaXMNCiAgICA+ICAgICAtCSAqIGNhbiBoYXZlIHNob3J0ZXIgbmFtZXMgdGhh
biBiYXNlZCBvbiB0aGUgYnVzIGluc3RhbmNlIFVVSUQuDQogICAgPiAgICAgLQkgKiBPbmx5IHRo
ZSBmaXJzdCBkZXZpY2Ugc2VyaWFsIG51bWJlciBpcyB1c2VkIGZvciBkb21haW4sIHNvIHRoZQ0K
ICAgID4gICAgIC0JICogZG9tYWluIG51bWJlciB3aWxsIG5vdCBjaGFuZ2UgYWZ0ZXIgdGhlIGZp
cnN0IGRldmljZSBpcyBhZGRlZC4NCiAgICA+ICAgICAtCSAqLw0KICAgID4gICAgIC0JaWYgKGxp
c3RfZW1wdHkoJmhidXMtPmNoaWxkcmVuKSkNCiAgICA+ICAgICAtCQloYnVzLT5zeXNkYXRhLmRv
bWFpbiA9IGRlc2MtPnNlcjsNCiAgICA+ICAgICAgIAlsaXN0X2FkZF90YWlsKCZocGRldi0+bGlz
dF9lbnRyeSwgJmhidXMtPmNoaWxkcmVuKTsNCiAgICA+ICAgICAgIAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZoYnVzLT5kZXZpY2VfbGlzdF9sb2NrLCBmbGFncyk7DQogICAgPiAgICAgICAJcmV0
dXJuIGhwZGV2Ow0KICAgID4gICAgIC0tDQogICAgPiAgICAgMi43LjQgDQogICAgPiAgICAgDQog
ICAgPiAgICAgDQogICAgPiANCiAgICANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJv
amVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
