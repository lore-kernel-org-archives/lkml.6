Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1635656-1521822275-2-6041019649491563876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521822274; b=JITX0gF2OCIGB3vTPvY7NuCh1By7LqgZx3cV6rDmcQ68Xbh
    v6TlWdRElP5kgyYM2RdxrilhX5PtTN2qhWFXdBypNRd8XyanA2HpRucp54amiHVm
    t3wgAXNcRdp7PetOkC1UYPdFrn6vswWf0ZoS5q3Hko4j3/rIZ64U6MSJ3dvOBcUs
    KjAaqgKrBNzf2CZm4MIrUTHoQXfpRzD6cu0D1HVWKytzViufF0RVXE+3+0fKpn8M
    EmLr7cC+opKLub4+5dDegNpBxbKPGxW8C9AgZMOxkX5sHugaF3Hkm+bD3xTEuzp0
    D8hfKeWOWKaTaFRhL6XPKAChDncPg1mZ2pGJI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521822274; bh=K4k2g0HZFxvGTgJEEr9XFaPWNKd
    X/8CM4AlPFjSXf54=; b=cpSVn9eOLcqpnYxSAX2Le+YXdxFo+aW7wSWhj8qgOQN
    6FFiUYNAPpsDHNtIpdx2OUfzrhgxT+vPsrQt/IvRhqRj7sOd7af3+eRPlLJVRrut
    /bQeNbbiIOqGmh3VBzlbRpWtTlbw6KXAVLEcPrDhmFQSer4wkkuphGR7mys6Mpx2
    pBUrcPFQ4yfZjiO/mY5O+p5IRi2Ewo85U9F9fA7+z5Z215D4e4nE2T/6ro/OyqJc
    56+1YkvhESeMl7q2J4lPhuRrB3/eKyohaz5a13Cdo/J5nxPs7qZTFVSFRXabIPfb
    F2Ha7J3eyG9AxDk2KdohD84+Ig3v2M2QJtmrfz8Cx4g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XUx5oq2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XUx5oq2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngIAH090AgAB/YQD//9WnAIABq4qAgAKYhoA=
Date: Fri, 23 Mar 2018 16:09:14 +0000
Message-ID: <4561FB62-054B-4E2D-9FDD-780FDB1374F6@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321173047.GA38649@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180321173047.GA38649@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0122;
 7:KUTBnl440vqafqumRNGtI3N70hv1wvxpUdoqCkmy/2+SayfegFo6X36SSSnvXu938jlphKHxuEGf8fppNtsMawi1EslTeqmSjb+bPN21Zzuf58amIxlzMNRuvF3YwGH2GdloEhxOdwofFVDYLAb5hyKu2OEdqV0MlWTYVGAvNotXInWpjDDx8sdNeBy1Gc2V4ZV/0xn+Y5ElKh51CDpXamxsuep/bYVytcgUwP54z2Y4Kp8hQDeK0MT5QgSIIppm;
 20:ip7X/GShuzajXIQCxiShJoPdDQ6zzBsod8Jbfq1slWe+NwMnka5zGLXXuEoAIdPStED8sh/1GhADaR0huMbfKnTHQhoR8dG45e0KF+SsOsuvi8cS509kaMgIajSVMxBaSPqWxR9riVM4hK3Yj3SeKtylNQY+AWGhikoA+Ku0vrY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20c3b1dc-7a31-4503-39b7-08d590d86c78
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB0122B4F38B2427B1DA094EDAF6A80@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0122; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0122;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(40224003)(54534003)(72206003)(59450400001)(6486002)(81156014)(10090500001)(8676002)(99286004)(229853002)(93886005)(106356001)(82746002)(102836004)(5250100002)(54906003)(7736002)(6346003)(33656002)(6512007)(66066001)(68736007)(305945005)(5660300001)(25786009)(83716003)(8936002)(14454004)(446003)(186003)(86612001)(6506007)(97736004)(53936002)(2900100001)(81166006)(4326008)(2906002)(10290500003)(6916009)(22452003)(6436002)(36756003)(86362001)(316002)(478600001)(6116002)(26005)(3846002)(76176011)(105586002)(6246003)(11346002)(3660700001)(3280700002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0122;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: 18kwM4BJT6rGGbprAf7Hco5zrsiAPOXZUVjDzQ8uF8RMysxsKmHYnF3OInL2uNo3UwMo+IVvHnGFs3aEwmBMGZRtcWvePKUT6XOzf77NFYQWRa1A3t4uBPjRPzFzTXFseTksywVDBEg172gWoJdGLEZuzN8oSTPP4kfZSW8okG2jWA6aeO7jyNMIkVVuE3jn+3A9Wq6RxFPOiRqguW8hvwuqNO5Aks2VaR8Qt1P/KP2Bv/8yZrGpuFA8/xpk2StLUL0q7gWFpZtYwVx/A0zDc7uY6vVbDK/GFWcg6BO4Jv3X/PJqnuXD3qwTh9FH8+8R36EP0vXVYilVD3BcxACH0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <2617CF6C8E8A13419979C7AFB6F87917@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c3b1dc-7a31-4503-39b7-08d590d86c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 16:09:14.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ICAgID4gUHJldmlvdXNseSwgd2hlbiB1c2luZyB0aGUgYm9uZCBkcml2ZXIsIHVuaXF1ZSBhbmQg
cGVyc2lzdGVudCBWRiBOSUMgbmFtZQ0KICAgID4gd2FzIHJlcXVpcmVkLCBzbyB3ZSB1c2VkIHNl
cmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiB3aGljaCBpcyBpbmNsdWRlZCBhcw0KICAgID4gcGFy
dCBvZiB0aGUgVkYgTklDIG5hbWUuICBUcmFuc3BhcmVudCBTUklPViBtb2RlIHB1dHMgVkYgTklD
IGJhc2VkIG9uIE1BQw0KICAgID4gbWF0Y2ggYXMgYSBzbGF2ZSBvZiBzeW50aGV0aWMgTklDLCBz
byBWRiBOSUPigJlzIG5hbWUgaXMgbm8gbG9uZ2VyIGltcG9ydGFudC4NCiAgICANCiAgICBIaSBT
cmlkaGFyLA0KICAgIA0KICAgIEEgZmV3IGhpbnRzIGFib3V0IHN1Ym1pdHRpbmcgcGF0Y2hlcyBt
b3JlIGVmZmljaWVudGx5Og0KICAgIA0KICAgIDEpIFlvdSBuZXZlciBoYXZlIHRvIGFzayAiQXJl
IHdlIE9LIHdpdGggdGhlIGV4cGxhbmF0aW9uPyAgSWYgc28sIEknbGwNCiAgICBzZW5kIGEgcGF0
Y2ggd2l0aCB1cGRhdGVkIGNoYW5nZWxvZy4iICBUaGF0IGZvcmNlcyBhbiBleHRyYQ0KICAgIHJv
dW5kLXRyaXAuICBTaW1wbHkgcG9zdCBhIG5ldyB2ZXJzaW9uIHdpdGggeW91ciBwcm9wb3NlZCB1
cGRhdGUuICBJZg0KICAgIExvcmVuem8gaGFzIG1vcmUgcXVlc3Rpb25zLCBoZSdsbCBzYXkgc28g
YW5kIHlvdSBjYW4gZG8gYW5vdGhlcg0KICAgIHZlcnNpb24uDQogICAgDQogICAgMikgV2hlbiBM
b3JlbnpvIGlzIGFza2luZyBmb3IgY2xhcmlmaWNhdGlvbiwgaGUncyBub3QgcmVhbGx5IGFza2lu
Zw0KICAgIGZvciB0aGUgY2xhcmlmaWNhdGlvbiBpbiBhbiBlbWFpbCByZXNwb25zZSwgYmVjYXVz
ZSB0aGUgZW1haWwgdGhyZWFkDQogICAgd2lsbCBzb29uIGJlIGZvcmdvdHRlbiBhbmQgbG9zdCBp
biB0aGUgYXJjaGl2ZXMuICBXaGF0IHdlIHJlYWxseSB3YW50DQogICAgaXMgZm9yIHRoZSBwZXJt
YW5lbnQgZ2l0IGNoYW5nZWxvZyB0byBtYWtlIHNlbnNlIHRvIHNvbWVvbmUgaW4gdGhlDQogICAg
ZnV0dXJlLiAgVGhlIGVhc2llc3Qgd2F5IGlzIHRvIHBvc3QgYSBuZXcgcGF0Y2ggdmVyc2lvbiB3
aXRoIGENCiAgICByZXZpc2VkIGNoYW5nZWxvZyB0aGF0IGFuc3dlcnMgdGhlIHF1ZXN0aW9ucy4N
CiAgICANCiAgICAzKSBQbGVhc2UgY2FwaXRhbGl6ZSBhbmQgcHVuY3R1YXRlIGNvbnNpc3RlbnRs
eSB3aXRoIHByZXZpb3VzIGhpc3RvcnksDQogICAgZS5nLiwgIlBDSTogaHY6IEZpeCBkb21haW4g
SUQgY29ycnVwdGlvbiIgZm9yIHlvdXIgdGl0bGUsICJTUi1JT1YiDQogICAgKG5vdCAiU1JJT1Yi
KSBhbmQgImJ1cyIgKG5vdCAiQlVTIikgaW4gY2hhbmdlbG9nLiAgQm90aCAicGFyYS12aXJ0dWFs
Ig0KICAgIGFuZCAicGFyYXZpcnR1YWwiIGFyZSB1c2VkIGluIHRoZSBrZXJuZWwsIGJ1dCAicGFy
YXZpcnR1YWwiIGlzIG11Y2gNCiAgICBtb3JlIGNvbW1vbi4gIFJ1biAiZ2l0IGxvZyIgYW5kICJn
aXQgbG9nIC0tb25lbGluZSIgb24geW91ciBmaWxlIGFuZA0KICAgIGZvbGxvdyB0aGUgc2FtZSBz
dHlsZS4NCiAgICANCiAgICA0KSBXaGVuIHlvdSByZWZlcmVuY2UgYSBwcmV2aW91cyBjb21taXQs
IHBsZWFzZSB1c2UgdGhpcyBzdHlsZToNCiAgICAwYzE5NTU2N2E4ZjYgKCJuZXR2c2M6IHRyYW5z
cGFyZW50IFZGIG1hbmFnZW1lbnQiKSwgaS5lLiwgMTItY2hhciBTSEExDQogICAgZm9sbG93ZWQg
YnkgdGl0bGUuICBZb3Ugc2VlbSB0byBoYXZlIHJlbW92ZWQgc29tZSBzcGFjZXMgZnJvbSB0aGUN
CiAgICBjb21taXQgeW91IG1lbnRpb24gaW4gdGhlICJGaXhlcyIgdGFnLg0KICAgIA0KICAgIEFu
ZCBhIGZldyBjb250ZW50IHF1ZXN0aW9ucy9vYnNlcnZhdGlvbnMgb2YgbXkgb3duOg0KICAgIA0K
ICAgIDEpICJGaXggZG9tYWluIElEIGNvcnJ1cHRpb24iIGlzbid0IGEgdmVyeSBnb29kIHRpdGxl
IGJlY2F1c2UgaXQNCiAgICBzdWdnZXN0cyB5b3UncmUgZml4aW5nIGEgbWVtb3J5IGNvcnJ1cHRp
b24gb3Igc2ltaWxhciBkZWZlY3QuICBCdXQgaW4NCiAgICBmYWN0LCBJIHRoaW5rIHlvdSdyZSBy
ZW1vdmluZyBzb21ldGhpbmcgdGhhdCB1c2VkIHRvIGJlIGEgZmVhdHVyZQ0KICAgIChhZGRlZCBi
eSA0YTliMDkzM2JkZmMgKCJQQ0k6IGh2OiBVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJ
DQogICAgZG9tYWluIikpIGJ1dCBpcyBub3cgbm8gbG9uZ2VyIG5lZWRlZCBhbmQgaW4gZmFjdCBu
b3cgY2F1c2VzIGENCiAgICBwcm9ibGVtLg0KICAgIA0KICAgIDIpIFlvdXIgY2hhbmdlbG9nIGRv
ZXMgbWVudGlvbiA0YTliMDkzM2JkZmMsIHdoaWNoIGlzIGdvb2QsIGJ1dA0KICAgIHRoZXJlIG11
c3QgYmUgc29tZSBvdGhlciA8Y29tbWl0IFg+IHRoYXQgbWFrZXMgaXQgc2FmZSB0byByZW1vdmUN
CiAgICA0YTliMDkzM2JkZmMsIGkuZS4sIDxjb21taXQgWD4gcmVtb3ZlcyB0aGUgbmVlZCBmb3Ig
dXNpbmcgdGhlIGRldmljZQ0KICAgIHNlcmlhbCBudW1iZXIgYXMgdGhlIFBDSSBkb21haW4uICA8
Q29tbWl0IFg+ICptdXN0KiBiZSBtZW50aW9uZWQgaW4NCiAgICB0aGUgY2hhbmdlbG9nLiAgT3Ro
ZXJ3aXNlLCBwZW9wbGUgbWF5IGJhY2twb3J0IHRoaXMgcGF0Y2ggdG8gYSBrZXJuZWwNCiAgICB0
aGF0IGRvZXNuJ3QgaW5jbHVkZSA8Y29tbWl0IFg+LCBhbmQgdGhpbmdzIHdpbGwgYnJlYWsuDQog
ICAgDQogICAgMykgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4gYnkgInRyYW5zcGFy
ZW50IFNSLUlPViBtb2RlIi4gIElzDQogICAgdGhhdCBzb21ldGhpbmcgZGlmZmVyZW50IHRoYW4g
cmVndWxhciBTUi1JT1Y/ICBJZiBzbywgd2hhdCBleGFjdGx5IGlzDQogICAgdGhlIGRpZmZlcmVu
Y2U/ICBJIGRvbid0IHRoaW5rIHRoZSBQQ0llIHNwZWNzIG1lbnRpb24gYSAidHJhbnNwYXJlbnQN
CiAgICBtb2RlIiwgc28gaXMgaXQgYSBIeXBlci1WIHRoaW5nPyAgSXQgc2VlbXMgaW1wb3J0YW50
LCBidXQgSSBkb24ndCBzZWUNCiAgICBhbnkgcGNpLWh5cGVydi5jIGNvbW1pdHMgdGhhdCBtZW50
aW9uIGl0Lg0KICAgIA0KICAgIEhlcmUncyBhIHN0YWIgYXQgdGhlIHNvcnQgb2YgY2hhbmdlbG9n
IEkgd291bGQgYmUgbG9va2luZyBmb3IuDQogICAgT2J2aW91c2x5IEkgZG9uJ3QgdW5kZXJzdGFu
ZCBtdWNoIGFib3V0IEh5cGVyLVYgYW5kIHBjaS1oeXBlcnYuYywgc28NCiAgICBwbGVhc2UgY29y
cmVjdCB0aGUgdGhpbmdzIEkgZ290IHdyb25nOg0KICAgIA0KICAgICAgV2hlbiBMaW51eCBydW5z
IGFzIGEgZ3Vlc3QgaW4gYSBIeXBlci1WIFZNLCBwY2ktaHlwZXJ2LmMNCiAgICAgIHBhcmF2aXJ0
dWFsaXplcyBhY2Nlc3MgdG8gUENJIGRldmljZXMgYXNzaWduZWQgdG8gdGhlIGd1ZXN0LiAgRm9y
DQogICAgICBlYWNoIG9mIHRob3NlIGRldmljZXMsIGh2X3BjaV9wcm9iZSgpIGNyZWF0ZXMgYSB2
aXJ0dWFsIFBDSSBidXMgaW4NCiAgICAgIGl0cyBvd24gdW5pcXVlIFBDSSBkb21haW4uDQogICAg
DQogICAgICA0YTliMDkzM2JkZmMgKCJQQ0k6IGh2OiBVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIg
YXMgUENJIGRvbWFpbiIpDQogICAgICBvdmVycm9kZSB0aGF0IHVuaXF1ZSBQQ0kgZG9tYWluIHRv
IGJlIHRoZSBIeXBlci1WIGRldmljZSBzZXJpYWwNCiAgICAgIG51bWJlciB0byBtYWtlIGRldmlj
ZSBuYW1lcyBtb3JlIGNvbnZlbmllbnQgPG9yIHdoYXRldmVyIHRoZSByZWFsDQogICAgICByZWFz
b24gaXM7IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGlzIHBhcnQ+Lg0KICAgIA0KICAgICAg
T25lIHByb2JsZW0gd2l0aCA0YTliMDkzM2JkZmMgaXMgdGhhdCB0aGUgSHlwZXItViBkZXZpY2Ug
c2VyaWFsDQogICAgICBudW1iZXIgaXMgbm90IG5lY2Vzc2FyaWx5IHVuaXF1ZSwgc28gd2UgbWF5
IGVuZCB1cCB3aXRoIHR3byBidXNlcw0KICAgICAgd2l0aCB0aGUgc2FtZSBkb21haW4gYW5kIGJ1
cyBudW1iZXIsIGFuZCBhZGRpbmcgdGhlIHNlY29uZCBidXMNCiAgICAgIGZhaWxzLg0KICAgIA0K
ICAgICAgV2Ugbm8gbG9uZ2VyIG5lZWQgdG8gb3ZlcnJpZGUgdGhlIFBDSSBkb21haW4gbnVtYmVy
cyBiZWNhdXNlIDxjb21taXQNCiAgICAgIFg+IHJlbW92ZWQgdGhlIG5lZWQgZm9yIHRoYXQuDQog
ICAgDQogICAgICBSZXZlcnQgNGE5YjA5MzNiZGZjICgiUENJOiBodjogVXNlIGRldmljZSBzZXJp
YWwgbnVtYmVyIGFzIFBDSQ0KICAgICAgZG9tYWluIikgc28gd2UgY2FuIHJlbGlhYmx5IHN1cHBv
cnQgbXVsdGlwbGUgZGV2aWNlcyBiZWluZyBhc3NpZ25lZA0KICAgICAgdG8gYSBndWVzdC4NCiAg
ICANCiAgICAgIFRoaXMgcmV2ZXJ0IHNob3VsZCBvbmx5IGJlIGJhY2twb3J0ZWQgdG8ga2VybmVs
cyB0aGF0IGNvbnRhaW4NCiAgICAgIDxjb21taXQgWD4uDQogICAgDQogICAgQmpvcm4NCg0KVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnRzIEJqb3JuLiBJIHRvb2sgc29tZSB0aW1lIHRvIGdvIG92ZXIg
dGhlIGFsbCB0aGUNCmNvbW1lbnRzIGFuZCBzZW5kaW5nIGEgbmV3IHZlcnNpb24gb2YgdGhlIHBh
dGNoIHdpdGggYWxsIHRoZSBjb21tZW50cyANCmluY29ycG9yYXRlZC4NCg0KVGhhbmtzDQpTcmlk
aGFyICAgIA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8v
ZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJk
ZXYtZGV2ZWwK
