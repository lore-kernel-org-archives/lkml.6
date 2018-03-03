Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124080-2-17473210577508002855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124079; b=GDZY9lC86lRH4YEfOhbMATwDB9LXuCUonbA3TYoi4gYLoX8
    dZ5LACVUrl4umS4AZOWlZ3iLM6mm/jy5PgMKdouUh8yAD8x1+uSur1GLbBO3KHeA
    28j4L8DM/o6YrFpMXUEGw+Me8QdDgnjR8c7AUlqi1knze3seem3UVVH+OdSloX41
    +L4x6QMZY/nqvZT4fSfW1tvrXKbVTnBgBaCfNfwsLGPrqisTBVFQFq/kgyC1yFSP
    3hzxrheCP5Lzr3rDeRoiDZN47O7y2f8qtl3/98ejer9C620O6yqqa0KMakwWBKZW
    54PL/ff3bsNeu9Zuuow7IfE6Z5HJQ1Zvs+mogTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124079; bh=mWbhhUCloJd5OU/KxdGo/cRVdTCMmE2Hftg1l0
    eAxfU=; b=WxoPdvJW5kOzYf4SGCMo0t8PvQJDq5slyS0UCnLeYKw2u0lZhr+dAC
    ixmsSLYaY/H7vj+4yy0gPH/BGXJ7Hsi8fPDa2N5E4urwwXfSix/HMpRBHzoKupE5
    arctYAM9FH7/iQagBmu3ifvVofvhTqITbJRGdgpene019IalYHY/Z+gQkYbVF3Q5
    pCdFMmuSpIgtLafNc9Zw7QFVACSe+rGJHuZWbx0QWo1qPwkVvqv374CcvjWFUUPy
    jyFSxKi7rUYPQhBVD8r3o9ROCJQHiiYZ5tmpKL2Q7z8HADPUsM5ZevGZ/U7b82fC
    qg+Xw6gKANET0K8RHYnG3tH4ZJayXycg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BLFxLcx4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BLFxLcx4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeCDAkt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:40:49 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932653AbeCCW0V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 054/102] KVM: X86: Restart the guest when
 insn_len is zero and SEV is enabled
Thread-Topic: [PATCH AUTOSEL for 4.15 054/102] KVM: X86: Restart the guest
 when insn_len is zero and SEV is enabled
Thread-Index: AQHTsz5rGQEzgB1Ok0Odlrwoz0qWXQ==
Date: Sat, 3 Mar 2018 22:24:40 +0000
Message-ID: <20180303222318.26006-54-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:F/ZGYGRpOc98iGkXscL7M83v9vqfDVbU0L6dtlx2OPrZR+o44H+W8fFJKg6cj6Jv9E8zfncNqLPkogSlanDoilHdTblQzwExiVvdBE4ysnbFyzWZg9fgDnsbbJB8a4ggEGR/bCacpbWlD8I0A6W7IHMMdZ7v/oN5mcFY+JR+VVNOHTWE9Ag3x3ZEgbSBp/MkQdn8SuVEQq1krRzX/RQ8UjaCnWWafdx1nQYCGs3T3utdUBeqFOaKuuIL60i7AcD8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b14a9b4a-262c-4e8b-1182-08d58155c558
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970372ABCDF911B2551D18CFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(767451399110)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(7416002)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(8666007)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vNW3Zt3ocH/fxuLqnZsXCPjv9njdgr5hX40AjDonW73VF26B1OLtQ1K8eeLunjZftKshpGZ+jmo9fik2F4TBSZ1vNMV6RnMAf6xrfhFzBrJzlsfPOsNzFuW4OC9/ce/3LKEBw2Iw9uNqerluBUrrFoFSYGlzY+Ird44LQPVeeoo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B53CFBA69ED3E4CA723D80CFD69C0BC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a9b4a-262c-4e8b-1182-08d58155c558
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:40.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCAwMGIxMGZlMTA0NmM0YjIyMzIwOTdhN2ZmYWE5MjM4YzdlNDc5Mzg4IF0NCg0KT24g
QU1EIHBsYXRmb3JtcywgdW5kZXIgY2VydGFpbiBjb25kaXRpb25zIGluc25fbGVuIG1heSBiZSB6
ZXJvIG9uICNOUEYuDQpUaGlzIGNhbiBoYXBwZW4gaWYgYSBndWVzdCBnZXRzIGEgcGFnZS1mYXVs
dCBvbiBkYXRhIGFjY2VzcyBidXQgdGhlIEhXDQp0YWJsZSB3YWxrZXIgaXMgbm90IGFibGUgdG8g
cmVhZCB0aGUgaW5zdHJ1Y3Rpb24gcGFnZSAoZS5nIGluc3RydWN0aW9uDQpwYWdlIGlzIG5vdCBw
cmVzZW50IGluIG1lbW9yeSkuDQoNClR5cGljYWxseSwgd2hlbiBpbnNuX2xlbiBpcyB6ZXJvLCB4
ODZfZW11bGF0ZV9pbnN0cnVjdGlvbigpIHdhbGtzIHRoZQ0KZ3Vlc3QgcGFnZSB0YWJsZSBhbmQg
ZmV0Y2hlcyB0aGUgaW5zdHJ1Y3Rpb24gYnl0ZXMgZnJvbSBndWVzdCBtZW1vcnkuDQpXaGVuIFNF
ViBpcyBlbmFibGVkLCB0aGUgZ3Vlc3QgbWVtb3J5IGlzIGVuY3J5cHRlZCB3aXRoIGd1ZXN0LXNw
ZWNpZmljDQprZXkgaGVuY2UgaHlwZXJ2aXNvciB3aWxsIG5vdCBhYmxlIHRvIGZldGNoIHRoZSBp
bnN0cnVjdGlvbiBieXRlcy4NCkluIHRob3NlIGNhc2VzIHdlIHNpbXBseSByZXN0YXJ0IHRoZSBn
dWVzdC4NCg0KSSBoYXZlIGVuY291bnRlcmVkIHRoaXMgaXNzdWUgd2hlbiBydW5uaW5nIGtlcm5i
ZW5jaCBpbnNpZGUgdGhlIGd1ZXN0Lg0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+DQpDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzogIkguIFBl
dGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhhdC5jb20+DQpD
YzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQpDYzogQm9yaXNsYXYgUGV0a292IDxi
cEBzdXNlLmRlPg0KQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQpD
YzogeDg2QGtlcm5lbC5vcmcNCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVz
aC5zaW5naEBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5s
ZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYva3ZtL21tdS5jIHwgMTAgKysrKysr
KysrKw0KIGFyY2gveDg2L2t2bS9zdm0uYyB8ICA2ICsrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9tbXUuYyBiL2FyY2gveDg2L2t2bS9tbXUuYw0KaW5kZXggY2M4M2JkY2I2NWQxLi5kOTc3
M2UzOGI1MzcgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vbW11LmMNCisrKyBiL2FyY2gveDg2
L2t2bS9tbXUuYw0KQEAgLTQ5NTEsNiArNDk1MSwxNiBAQCBpbnQga3ZtX21tdV9wYWdlX2ZhdWx0
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3ZhX3QgY3IyLCB1NjQgZXJyb3JfY29kZSwNCiAJaWYg
KG1taW9faW5mb19pbl9jYWNoZSh2Y3B1LCBjcjIsIGRpcmVjdCkpDQogCQllbXVsYXRpb25fdHlw
ZSA9IDA7DQogZW11bGF0ZToNCisJLyoNCisJICogT24gQU1EIHBsYXRmb3JtcywgdW5kZXIgY2Vy
dGFpbiBjb25kaXRpb25zIGluc25fbGVuIG1heSBiZSB6ZXJvIG9uICNOUEYuDQorCSAqIFRoaXMg
Y2FuIGhhcHBlbiBpZiBhIGd1ZXN0IGdldHMgYSBwYWdlLWZhdWx0IG9uIGRhdGEgYWNjZXNzIGJ1
dCB0aGUgSFcNCisJICogdGFibGUgd2Fsa2VyIGlzIG5vdCBhYmxlIHRvIHJlYWQgdGhlIGluc3Ry
dWN0aW9uIHBhZ2UgKGUuZyBpbnN0cnVjdGlvbg0KKwkgKiBwYWdlIGlzIG5vdCBwcmVzZW50IGlu
IG1lbW9yeSkuIEluIHRob3NlIGNhc2VzIHdlIHNpbXBseSByZXN0YXJ0IHRoZQ0KKwkgKiBndWVz
dC4NCisJICovDQorCWlmICh1bmxpa2VseShpbnNuICYmICFpbnNuX2xlbikpDQorCQlyZXR1cm4g
MTsNCisNCiAJZXIgPSB4ODZfZW11bGF0ZV9pbnN0cnVjdGlvbih2Y3B1LCBjcjIsIGVtdWxhdGlv
bl90eXBlLCBpbnNuLCBpbnNuX2xlbik7DQogDQogCXN3aXRjaCAoZXIpIHsNCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCmluZGV4IDRlM2M3OTUz
MDUyNi4uMWRiY2I4ODllMjRmIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQorKysg
Yi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCkBAIC0yMTc3LDcgKzIxNzcsOCBAQCBzdGF0aWMgaW50IHBm
X2ludGVyY2VwdGlvbihzdHJ1Y3QgdmNwdV9zdm0gKnN2bSkNCiAJdTY0IGVycm9yX2NvZGUgPSBz
dm0tPnZtY2ItPmNvbnRyb2wuZXhpdF9pbmZvXzE7DQogDQogCXJldHVybiBrdm1faGFuZGxlX3Bh
Z2VfZmF1bHQoJnN2bS0+dmNwdSwgZXJyb3JfY29kZSwgZmF1bHRfYWRkcmVzcywNCi0JCQlzdm0t
PnZtY2ItPmNvbnRyb2wuaW5zbl9ieXRlcywNCisJCQlzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVS
RV9ERUNPREVBU1NJU1RTKSA/DQorCQkJc3ZtLT52bWNiLT5jb250cm9sLmluc25fYnl0ZXMgOiBO
VUxMLA0KIAkJCXN2bS0+dm1jYi0+Y29udHJvbC5pbnNuX2xlbik7DQogfQ0KIA0KQEAgLTIxODgs
NyArMjE4OSw4IEBAIHN0YXRpYyBpbnQgbnBmX2ludGVyY2VwdGlvbihzdHJ1Y3QgdmNwdV9zdm0g
KnN2bSkNCiANCiAJdHJhY2Vfa3ZtX3BhZ2VfZmF1bHQoZmF1bHRfYWRkcmVzcywgZXJyb3JfY29k
ZSk7DQogCXJldHVybiBrdm1fbW11X3BhZ2VfZmF1bHQoJnN2bS0+dmNwdSwgZmF1bHRfYWRkcmVz
cywgZXJyb3JfY29kZSwNCi0JCQlzdm0tPnZtY2ItPmNvbnRyb2wuaW5zbl9ieXRlcywNCisJCQlz
dGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9ERUNPREVBU1NJU1RTKSA/DQorCQkJc3ZtLT52bWNi
LT5jb250cm9sLmluc25fYnl0ZXMgOiBOVUxMLA0KIAkJCXN2bS0+dm1jYi0+Y29udHJvbC5pbnNu
X2xlbik7DQogfQ0KIA0KLS0gDQoyLjE0LjENCg==
