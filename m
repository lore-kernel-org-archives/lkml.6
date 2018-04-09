Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245824-2-4251972084204525206
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
    1523245824; b=BFgIbog1At/bPFJx6zIFiyn+9FKPf5rWO/DhhtJpkZMMs3YyDS
    O/Lyf9BFT3VLpBLsP7AwdimFmzoWWx3Q3LSKAouWa9MYM9Rb1Z7dKSI++iCLlCqM
    u74Lcg6P9a+jANen/gaUWXIsqJDDaaSi5AvnG4m1CQcFAw+xn9qfwMYL1Q+sBz5k
    eF7GI5jp8Zc/LF9hWvzoNyyaYs2yvSijetfTV14gEDcGyHetClezPyXQf+KlJely
    KUO4e2LMPUtgKr1Ha5AJj/1lv2+tXOvn4Ws9+YtM6okOk99wMzO3tcOYdLu8peRX
    MnXWUsFO2HNFhVj6W/qKEakRZsKTsM44wOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523245824; bh=YmbZsZJ8HnJ/EX7311BRkQsr93MbIM6k4n+qmp7zjyE=; b=
    vZJcZZP4ApjRY88pYq5eiM0I8oCJ4aBze36WrKXIvsKCdtT04z2SdY8y3em3FesU
    VMCKre6Qi3/03swGO2iHIDeVwXSC9mq6fk4+6mEXzwM3lR5BXcq7W7W/NdCJ1w2a
    6lc4HCMg95GmaeYU77gZ+WG2PWK3j7a5qsbXOS7CP6Vv2w/XY8Aepaxyls5hH0at
    k8/u/uAmtDXSYPBLBSdJgITnb8fM8EhDqfSg0qJ3JYY2sRX65hFQEXZHHewgVTsN
    /E4x5/yJrMfdrakGOHmAV/PtAo6TBstAyK56ecyGr/H45pQaBm4Gxo6KAb85SXn9
    Dz66hWKPVCDZNaSNh5R3dg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SOi2Rx2i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SOi2Rx2i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI1P4vfTeK8Gxdl5dLVPjwJA305DdOvmij54bC5qhOaQKSzFZTB6/5pIcU7OxGxdwOlrPkqKN02UcKUPQ3EBdOUVUsTxxK+DX1HZM9xx1xKphk8lzjK5
    evQa679m3AOMCFGztqnBFA4JZXR6h5Vlt4CwUUNg9yN5lZPf2BcYzpFLLT/uSzYAfXtsg4KK2JKqA7blORONTnfZ2S4+s/5YunaYnNn3xcZDJkOf8Y15nLpm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=IGERox2zBV1zzKJ-FZYA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeDIDtc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:49:32 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754066AbeDIATb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 114/189] x86/kvm/vmx: do not use vm-exit
 instruction length for fast MMIO when running nested
Thread-Topic: [PATCH AUTOSEL for 4.15 114/189] x86/kvm/vmx: do not use vm-exit
 instruction length for fast MMIO when running nested
Thread-Index: AQHTz5hBO6fZwvVIm0eycL1LuUfBrw==
Date: Mon, 9 Apr 2018 00:18:16 +0000
Message-ID: <20180409001637.162453-114-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:88wLMBaRoUICOI0EoRVGVHDP+TyXZqBUEhLb5vcMzHXeF9uvkpFjdWjkcMgHFeYWOEq/7cmqaG/q/jAni3MmiQ7nOtg+6TMzYSfryU03UEczTzz+RsYwO0uILIII/YH99/4JEp9+nAJWnaqWwHeu2Bq6c31ai0cLe6uX47dJ54XppG2OjSoRg1B4lGh0bIhWrTC9v+4O1F5+HrSV6tsdW5wS3eiXnu03IYBi2f7PNxR5EYxTvEFkhLXWT/bOYLyH;20:IoK95U+ZpwN81XGOJfrRvO0cgrPiPQFZyELm7dEAczyF99zG0xWuy4KyBVdWmFnOlS5jnICzwAYpUtVOT+HPod+0V9ki4GuxxUVclUgc3LQTeg4UgZDcpH4c/3GvVRe9LYKFPElbcAepuKy7qvEmZC4wfvCT2JJr4AA2jLmeygE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17099649-fe4d-463d-8243-08d59daf8e1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07263E61CE2F8F71533A0BDEFBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(575784001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UqCPBBGv6+rxQqN0M/7UVfvPH9E06BSkmH3bwzzq59Y03v3Jter5nTn4Cmi1N19IW1ALFgu6d4qqeOQwqKSI31zdquaRIonh9O/eHXmtAbl9WfC3l7zw84Ezl+MitP2DJyGWc1viC+sndZUXbNw9CLx422ipXWN0mXjtPJIW4tKl16d9TMBlyCukNDH2gU1NgP7/AhOIcs3sxCxvShbKS4+E30OFgGdiqTma9lS6E2h7YaY7127HkLAAxJOtLDNsNYwwDSoM3df1XPVdjG7vTk9RKLof7GCXIymbybpzaBvhZ6b9oMK26ecN9u1WVr7KAiy6/Vihf7bM2bJOsL5Kz/WhSdqsvnVENEjlmluRucPjQPR/Emnd83VUz+mlkvNM21IdK3+bVMPFoA1ankzWm0F6jVv+MfQQxewbtrweCEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <53FDD043243DE143AAB47B9C4D6F0A4D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17099649-fe4d-463d-8243-08d59daf8e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:16.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZDM5MWYxMjA3MDY3MjY4MjYxYWRkMDQ4NWYwZjM0NTAzNTM5YzViMCBdDQoNCkkg
d2FzIGludmVzdGlnYXRpbmcgYW4gaXNzdWUgd2l0aCBzZWFiaW9zID49IDEuMTAgd2hpY2ggc3Rv
cHBlZCB3b3JraW5nDQpmb3IgbmVzdGVkIEtWTSBvbiBIeXBlci1WLiBUaGUgcHJvYmxlbSBhcHBl
YXJzIHRvIGJlIGluDQpoYW5kbGVfZXB0X3Zpb2xhdGlvbigpIGZ1bmN0aW9uOiB3aGVuIHdlIGRv
IGZhc3QgbW1pbyB3ZSBuZWVkIHRvIHNraXANCnRoZSBpbnN0cnVjdGlvbiBzbyB3ZSBkbyBrdm1f
c2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlvbigpLiBUaGlzLCBob3dldmVyLA0KZGVwZW5kcyBvbiBW
TV9FWElUX0lOU1RSVUNUSU9OX0xFTiBmaWVsZCBiZWluZyBzZXQgY29ycmVjdGx5IGluIFZNQ1Mu
DQpIb3dldmVyLCB0aGlzIGlzIG5vdCB0aGUgY2FzZS4NCg0KSW50ZWwncyBtYW51YWwgZG9lc24n
dCBtYW5kYXRlIFZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIHRvIGJlIHNldCB3aGVuDQpFUFQgTUlT
Q09ORklHIG9jY3Vycy4gV2hpbGUgb24gcmVhbCBoYXJkd2FyZSBpdCB3YXMgb2JzZXJ2ZWQgdG8g
YmUgc2V0LA0Kc29tZSBoeXBlcnZpc29ycyBmb2xsb3cgdGhlIHNwZWMgYW5kIGRvbid0IHNldCBp
dDsgd2UgZW5kIHVwIGFkdmFuY2luZw0KSVAgd2l0aCBzb21lIHJhbmRvbSB2YWx1ZS4NCg0KSSBj
aGVja2VkIHdpdGggTWljcm9zb2Z0IGFuZCB0aGV5IGNvbmZpcm1lZCB0aGV5IGRvbid0IGZpbGwN
ClZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIG9uIEVQVCBNSVNDT05GSUcuDQoNCkZpeCB0aGUgaXNz
dWUgYnkgZG9pbmcgaW5zdHJ1Y3Rpb24gc2tpcCB0aHJvdWdoIGVtdWxhdG9yIHdoZW4gcnVubmlu
Zw0KbmVzdGVkLg0KDQpGaXhlczogNjhjM2I0ZDE2NzZkODcwZjA0NTNjMzFkNWE1MmU3ZTY1Yzc0
NDhhZQ0KU3VnZ2VzdGVkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4N
ClN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQpBY2tlZC1i
eTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFJh
ZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYva3Zt
L3ZteC5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KIGFyY2gveDg2L2t2bS94ODYuYyB8ICAzICsr
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXguYw0KaW5k
ZXggMmJlYjc3YzMxOWU4Li44NjQ1YzFmNjk5NDQgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0v
dm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KQEAgLTY3NjksNyArNjc2OSwyMSBAQCBz
dGF0aWMgaW50IGhhbmRsZV9lcHRfbWlzY29uZmlnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiAJ
aWYgKCFpc19ndWVzdF9tb2RlKHZjcHUpICYmDQogCSAgICAha3ZtX2lvX2J1c193cml0ZSh2Y3B1
LCBLVk1fRkFTVF9NTUlPX0JVUywgZ3BhLCAwLCBOVUxMKSkgew0KIAkJdHJhY2Vfa3ZtX2Zhc3Rf
bW1pbyhncGEpOw0KLQkJcmV0dXJuIGt2bV9za2lwX2VtdWxhdGVkX2luc3RydWN0aW9uKHZjcHUp
Ow0KKwkJLyoNCisJCSAqIERvaW5nIGt2bV9za2lwX2VtdWxhdGVkX2luc3RydWN0aW9uKCkgZGVw
ZW5kcyBvbiB1bmRlZmluZWQNCisJCSAqIGJlaGF2aW9yOiBJbnRlbCdzIG1hbnVhbCBkb2Vzbid0
IG1hbmRhdGUNCisJCSAqIFZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIHRvIGJlIHNldCBpbiBWTUNT
IHdoZW4gRVBUIE1JU0NPTkZJRw0KKwkJICogb2NjdXJzIGFuZCB3aGlsZSBvbiByZWFsIGhhcmR3
YXJlIGl0IHdhcyBvYnNlcnZlZCB0byBiZSBzZXQsDQorCQkgKiBvdGhlciBoeXBlcnZpc29ycyAo
bmFtZWx5IEh5cGVyLVYpIGRvbid0IHNldCBpdCwgd2UgZW5kIHVwDQorCQkgKiBhZHZhbmNpbmcg
SVAgd2l0aCBzb21lIHJhbmRvbSB2YWx1ZS4gRGlzYWJsZSBmYXN0IG1taW8gd2hlbg0KKwkJICog
cnVubmluZyBuZXN0ZWQgYW5kIGtlZXAgaXQgZm9yIHJlYWwgaGFyZHdhcmUgaW4gaG9wZSB0aGF0
DQorCQkgKiBWTV9FWElUX0lOU1RSVUNUSU9OX0xFTiB3aWxsIGFsd2F5cyBiZSBzZXQgY29ycmVj
dGx5Lg0KKwkJICovDQorCQlpZiAoIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklT
T1IpKQ0KKwkJCXJldHVybiBrdm1fc2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlvbih2Y3B1KTsNCisJ
CWVsc2UNCisJCQlyZXR1cm4geDg2X2VtdWxhdGVfaW5zdHJ1Y3Rpb24odmNwdSwgZ3BhLCBFTVVM
VFlQRV9TS0lQLA0KKwkJCQkJCSAgICAgICBOVUxMLCAwKSA9PSBFTVVMQVRFX0RPTkU7DQogCX0N
CiANCiAJcmV0ID0ga3ZtX21tdV9wYWdlX2ZhdWx0KHZjcHUsIGdwYSwgUEZFUlJfUlNWRF9NQVNL
LCBOVUxMLCAwKTsNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9r
dm0veDg2LmMNCmluZGV4IDQxYThhYzQ0ZDVjYy4uYjEyNWY1YzkxYjk0IDEwMDY0NA0KLS0tIGEv
YXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCkBAIC01NzExLDcg
KzU3MTEsOCBAQCBpbnQgeDg2X2VtdWxhdGVfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KIAkJICogaGFuZGxlIHdhdGNocG9pbnRzIHlldCwgdGhvc2Ugd291bGQgYmUgaGFuZGxl
ZCBpbg0KIAkJICogdGhlIGVtdWxhdGVfb3BzLg0KIAkJICovDQotCQlpZiAoa3ZtX3ZjcHVfY2hl
Y2tfYnJlYWtwb2ludCh2Y3B1LCAmcikpDQorCQlpZiAoIShlbXVsYXRpb25fdHlwZSAmIEVNVUxU
WVBFX1NLSVApICYmDQorCQkgICAga3ZtX3ZjcHVfY2hlY2tfYnJlYWtwb2ludCh2Y3B1LCAmcikp
DQogCQkJcmV0dXJuIHI7DQogDQogCQljdHh0LT5pbnRlcnJ1cHRpYmlsaXR5ID0gMDsNCi0tIA0K
Mi4xNS4xDQo=
