Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3653759-1520571318-2-14377026836181423685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Attached: 0001-PCI-BUS-domain-ID-corruption.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520571317; b=myJVn+qpO1or+XBQIXsl88iIEmosM25d6x4O4jL5F/PBjCI
    A+l02DEBlLNA8BmpnrLs5dCBiJNcj2XjB8ejBEBWORvCGrtouNBVNcLZtHAjH9Fj
    u1Fh7GZgRRy3ynvS3Bk7DQYqliKYg5HQPeHifWzELDA+H7MddXJRowLJlRs5yz9q
    3Y1u0g6tAkuuwIQN4FjTZj1ev8KqbjGRCPfHKbIJ4FSEtg0QKhdDjlnqC8MTAL25
    UhY2K/nrDDmTZfQiW7ayKwkK3m4/8zec0BgWUPtSMrdBNEmHxuZO0McO+znPckOn
    CegbEaHW1NylTJjy97ibWyBcKCM4RgLqEPIs+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-type:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:sender; s=arctest; t=
    1520571317; bh=p7828w8lxCZRWwdWhx/smUIMcgiy7y5l+GWFhlatevQ=; b=e
    ekl4yNxgmjS2ZkW0kvyMtmvZV2OYTXOlA7jHgw229QdhIgxxDsm8ZjeAnScIIRVi
    93TofHlKyanRLgmPnuVV2KuE1iJfZKKzbePAqCV8zt1Mr2e5Rr9uU4H7nX98lOMj
    k7vwFhEANdKj0z5/17ZHGE3EKZnMnaJSi4+/I5qzqjj5JfkQAb4wK8kCYMTO6oz/
    YPK7dvSaXLjFvlcVMGupN5HMFhUbBkJMwBm2OY2VYfuiXfevo2YQCaOMrXM2adyE
    xhGUuJbBBmmlle2D8N0ukDGHaVbAn9S7ZptHJWVdIO1tIL6y90suOMvQjwiAXse2
    mVi2TuvRbFI3JciqTOiLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jqtdqgzr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jqtdqgzr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Dexuan
 Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: fix bus domain ID corruption
Thread-Topic: [PATCH] PCI: hv: fix bus domain ID corruption
Thread-Index: AQHTt2LLU4f2U+zlPUKLwzS9FiUhSA==
Date: Fri, 9 Mar 2018 04:55:07 +0000
Message-ID: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=srpitcha@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-08T21:58:55.7326370Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [98.232.109.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0747;
 20:2t7XOAsblP8Zv0+nrEcobn+Cz/lY4VJsi3ZN4pqr476rWgBjf0zsiuGm8rbkPokpQXLVvHWllZqF/oZ0GK8Q6m/IgY+RsJ/mqNDYDvD4s/RxdpEmFiqKoyEBgqIrRNzGCwzkNjtJse78yFEMX6QHxeFBHYIsDz4kARg7meJIUy8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f0f6d46-64b2-461e-1558-08d58579ee09
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(49563074)(7193020);
 SRVR:DM5PR21MB0747;
x-ms-traffictypediagnostic: DM5PR21MB0747:
x-microsoft-antispam-prvs: <DM5PR21MB074771C08BEF03C1F62B9B71F6DE0@DM5PR21MB0747.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(102415395)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501255)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0747; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0747;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(189003)(199004)(36756003)(3846002)(25786009)(6116002)(83716003)(10290500003)(478600001)(2906002)(305945005)(7736002)(105586002)(6512007)(8676002)(3280700002)(3660700001)(6436002)(72206003)(106356001)(81166006)(86362001)(81156014)(8936002)(2900100001)(33656002)(14454004)(68736007)(6486002)(186003)(102836004)(82746002)(1511001)(26005)(99936001)(6636002)(66066001)(5250100002)(53936002)(6346003)(86612001)(1857600001)(6506007)(54906003)(110136005)(621065002)(10090500001)(99286004)(22452003)(4270600006)(97736004)(4326008)(316002)(73894003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0747;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: KXfc6W81EihIKMAAb6OP7c9Ed2AHlvkMchNN632uRSVAS0L7yQJgarBsDYZCYhOvaSbspL/su/pvu60JmGoLvnMTwIN27jlEkXiJR2dwJGMUXNqZIu9oxt4qwSUhGSoXgl2i66LOWMtTMeZmWOe29Mlh5Xr16zYwLXTdKKIByY8cQTW9/0fpKwp2qvIddVTvJYXwryC8rN50aufozTfzWfsUIXzsjYoT6RT412JBFbuED0Isr3Lq2moNKdFHXFJuNnRZB5ETmpfisBePPuMOoeBTorwc4Nj6JvNOzQccpAyrkpCxR2TXA+zSScndt4y4DrbmYsc6q6Yy8Vk//xTitA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
 boundary="_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f6d46-64b2-461e-1558-08d58579ee09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 04:55:07.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0747
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DA46037FEB72948B777033CFA1AC4F9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64

IA0KDQo=

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_
Content-Type: application/octet-stream;
	name="0001-PCI-BUS-domain-ID-corruption.patch"
Content-Description: 0001-PCI-BUS-domain-ID-corruption.patch
Content-Disposition: attachment;
	filename="0001-PCI-BUS-domain-ID-corruption.patch"; size=1898;
	creation-date="Fri, 09 Mar 2018 04:55:06 GMT";
	modification-date="Fri, 09 Mar 2018 04:55:06 GMT"
Content-ID: <AE3E0D4C692FEB4ABA9676172324D897@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA5NzcxNmNmNGNhZTk3NzljMTgwYzAwZmI0YmVjYWNkMmRhMTM5MzU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmlkaGFyIFBpdGNoYWkgPHNyaWRoYXIucGl0Y2hhaUBnbWFp
bC5jb20+CkRhdGU6IFRodSwgOCBNYXIgMjAxOCAxNDoxNzo1MSAtMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIFBDSSBCVVMgZG9tYWluIElEIGNvcnJ1cHRpb24KCldoZW4gUENJIEJVUyBpcyBhZGRlZCwg
UENJX0JVUyBkb21haW4gSUQgaXMgc2V0LiBXaGVuIFBDSV9CVVMgYW5kIGEgZGV2aWNlCmFkZGVk
IHRvIHRoZSBidXMgaXMgcmFjaW5nIGFnYWluc3QgZWFjaCBvdGhlciwgdGhlIGZpcnN0IGRldmlj
ZSB0ZW5kcyB0bwpvdmVyd3JpdGUgdGhlIGRvbWFpbiBJRC4gSW4gb3JkZXIgdG8gYXZvaWQgdGhl
IHJhY2UsIHRoaXMgcGF0Y2ggbWFrZSBzdXJlCndoZW4gYSBkZXZpY2UgaXMgYWRkZWQgdG8gYSBi
dXMsIGl0IG5ldmVyIHVwZGF0ZWQgdGhlIGJ1cyBkb21haW4gSUQuIFNpbmNlCndlIGhhdmUgdGhl
IHRyYW5zcGFyZW50IFNSSU9WIG1vZGUgbm93LCB0aGUgc2hvcnQgVkYgZGV2aWNlIG5hbWUgaXMg
bm8KbG9uZ2VyIG5lZWRlZC4KCkZpeGVzOiA0YTliMDkzM2JkZmMoIlBDSTpodjpVc2UgZGV2aWNl
IHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IFNyaWRoYXIgUGl0Y2hhaSA8c3JwaXRjaGFAbWljcm9zb2Z0LmNvbT4K
LS0tCiBkcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYyB8IDExIC0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG9z
dC9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwppbmRleCAyZmFm
MzhlLi5hYzY3ZTU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwor
KysgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwpAQCAtMTUxOCwxNyArMTUxOCw2IEBA
IHN0YXRpYyBzdHJ1Y3QgaHZfcGNpX2RldiAqbmV3X3BjaWNoaWxkX2RldmljZShzdHJ1Y3QgaHZf
cGNpYnVzX2RldmljZSAqaGJ1cywKIAlnZXRfcGNpY2hpbGQoaHBkZXYsIGh2X3BjaWRldl9yZWZf
Y2hpbGRsaXN0KTsKIAlzcGluX2xvY2tfaXJxc2F2ZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywg
ZmxhZ3MpOwogCi0JLyoKLQkgKiBXaGVuIGEgZGV2aWNlIGlzIGJlaW5nIGFkZGVkIHRvIHRoZSBi
dXMsIHdlIHNldCB0aGUgUENJIGRvbWFpbgotCSAqIG51bWJlciB0byBiZSB0aGUgZGV2aWNlIHNl
cmlhbCBudW1iZXIsIHdoaWNoIGlzIG5vbi16ZXJvIGFuZAotCSAqIHVuaXF1ZSBvbiB0aGUgc2Ft
ZSBWTS4gIFRoZSBzZXJpYWwgbnVtYmVycyBzdGFydCB3aXRoIDEsIGFuZAotCSAqIGluY3JlYXNl
IGJ5IDEgZm9yIGVhY2ggZGV2aWNlLiAgU28gZGV2aWNlIG5hbWVzIGluY2x1ZGluZyB0aGlzCi0J
ICogY2FuIGhhdmUgc2hvcnRlciBuYW1lcyB0aGFuIGJhc2VkIG9uIHRoZSBidXMgaW5zdGFuY2Ug
VVVJRC4KLQkgKiBPbmx5IHRoZSBmaXJzdCBkZXZpY2Ugc2VyaWFsIG51bWJlciBpcyB1c2VkIGZv
ciBkb21haW4sIHNvIHRoZQotCSAqIGRvbWFpbiBudW1iZXIgd2lsbCBub3QgY2hhbmdlIGFmdGVy
IHRoZSBmaXJzdCBkZXZpY2UgaXMgYWRkZWQuCi0JICovCi0JaWYgKGxpc3RfZW1wdHkoJmhidXMt
PmNoaWxkcmVuKSkKLQkJaGJ1cy0+c3lzZGF0YS5kb21haW4gPSBkZXNjLT5zZXI7CiAJbGlzdF9h
ZGRfdGFpbCgmaHBkZXYtPmxpc3RfZW50cnksICZoYnVzLT5jaGlsZHJlbik7CiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOwogCXJldHVybiBo
cGRldjsKLS0gCjIuNy40Cgo=

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_--
