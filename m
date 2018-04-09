Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242115-5-9568211797821296975
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
    1523242114; b=E9t4UpS15imMO4dv0oS1VSMGvlp7hbJbRcNE91t1fDpDwqFizQ
    QMUY6lkh2IN3lVVOuXrLjv+bYFYE8QoyfvUjMXsnehuYJPbYMCzHZsiKnDQYO0uN
    tjEp2k/ybPz3lv3K5npOKUJDvizQJeqSZJEfRsG946EnIG2Uz44eWyFukMGg+jVj
    kwmDtDx9K0Rya7l15Ts+oAiknPD+lVAFpoxJOMwl65ctrwiHAe36LdnVcuBzVuXR
    6Fn1ihKFQA4G4lwkSOACbKZepvcopfQP2T3yxBJoHV3AcPoxLT3TN4EGUkrcrshn
    +6SmZzulPsVVBHzgidoI7hQFyOabQgkl9+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523242114; bh=gjyBqu2KDOc6pFivRXbukZxTicjqZ03qgid0uIdOap8=; b=
    hp0Iex6yQaGgkjw2h3v3BsFEYeshn7Cw7EKSdRyhVeKj3wHEOWwHH+Zh5MtiZ2+H
    D589VYmGkLUNo6T7v/sJpwf9sT6z6Gs+HgTMh+47F6pLfOid3ZUB4ZLoe43EABnj
    r0KhfAEbfgNM0eqKMKnF/zMmt+XuaK0QATt7+ZAyrRqVbIhAou+7OfICLxPie7Sw
    zt2V+jFf1OGbzDKykjJaPjcwhBXBpl45OakdfU/Haq3Lch6UrBVH6/xLz0r2TAhl
    p6OcJ6X+Wgdm5iCdqzZ8FqgM6B+5OcyN3+pGENtfs49nTQBrxcB9QCK6y0lyivKW
    scRg0hDl1BqxrvJrwsqejw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RInwGOVp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RInwGOVp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKw9b2BaXMEcTDRYD7gs0C0My9Rpa699NdVJk5osOXGhbabgd7BbknQG+c/8wbm4xftWDOLXVJvpmROEF0CP1zEoYnokzplR0QbYXiAUClJhk5GE7B/4
    EuVr8n/22BlDBbAlAegfccqJG41gZuvvQrJjQ5eyw0DRZyW/yeMWohkQwGgxP6OBdpeUXUhz1XRh2pVE5fSEnF6JQ5sRpESv7R4BG6emuseXTfuRAFzCmy76
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=Qs4HKOLk07IYOv0CpxwA:9 a=-pbWPLVgB4OOgpeN:21 a=r1VbL93W0Ay6KIKo:21
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeDICsP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:48:15 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755386AbeDIA0i (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jim Mattson <jmattson@google.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 004/293] KVM: nVMX: Update
 vmcs12->guest_linear_address on nested VM-exit
Thread-Topic: [PATCH AUTOSEL for 4.9 004/293] KVM: nVMX: Update
 vmcs12->guest_linear_address on nested VM-exit
Thread-Index: AQHTz5jjIXxSp0dzKECHyU8ENxAPAg==
Date: Mon, 9 Apr 2018 00:22:49 +0000
Message-ID: <20180409002239.163177-4-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:PFTqx7eOs8tbKPbODtW8MRFumllyABJFhQmrgSQndSXV7q0m8ubD4FMndI7kAah7Jk4ChavBYCv4hJfeST0EGLRN6OshcyiX1z3j7kF6B4LqgyQ12HIbO9pADgtPYXGoSET0JR8yJHcsk6+uQs6yR6YCdP6pxtrz+Qm2Dy3IWhG5aPaQThMlbBtlESf14XUdiZGEIsq7K1xmOsTDbHzp9onLZr1/OuLby0CFk9c0q3LPwx1ewiPDVJgUJZBW6F7t;20:9jsbzRY/51R+LoWyLcDG19V40SJGp5XZIndNWCS+xCpX1a3Po3giYii3i44dSXlzsQpUfU7hHfXao5tPc2eEF644yCTtKt+Ks56gwUvcyAiyHD576/Fwf5gOJQytbIT+RNCM/ZSrIJWqAy4Uyavv+mtAJv1ECqIFPy2N1xUUzgc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f62f06e-82c5-4080-508f-08d59db08afa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015E2BA2FCA3F5C371A1228FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +un2ITvzRizilhhVEiCB1pBnr2UmXcqaGvHunra08OOqp4m7xdK0rCVpArolVsb1411YGmSFIaWCJPctw5P5Vf+imZHWdB4AHem2OATVHxgTfEwP7amxtGSfnrH2dLQc1sP0M2xsVNIvGQGRDdmvuDAzGNERlnqv9tXiW1xdWKoEpxjerHY1G80O5DHlIhfqTR6WGmtChliGjT2DFic4BRGhe6ZlmBipfhYb0dP3EzBQBrKsNP3J+USGxy/HW7WlK2Lpexv4ggKKQzih02t9KQ+8Wn2b0Sdz74saywL8BQdKSF0tCqSAp7eOYW5InhKD/i08S81Cg5AJ0TQ9tcE/YO3/eZdnGOBRKXdDZDgEQ/NxjD2f8UcL853YNbhpznrVUhbq/UFdgFu9hRifZYDiQjkjB5amdhtrIVy+ZDdwumk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5A80A68596C934EAACD42427313C799@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f62f06e-82c5-4080-508f-08d59db08afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:49.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmltIE1hdHRzb24gPGptYXR0c29uQGdvb2dsZS5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGQyODFlMTNiMGJmZTc0NWEyMTA2MWExOTRlMzg2YTk0OTc4NDM5M2YgXQ0KDQpUaGUgZ3Vl
c3QtbGluZWFyIGFkZHJlc3MgZmllbGQgaXMgc2V0IGZvciBWTSBleGl0cyBkdWUgdG8gYXR0ZW1w
dHMgdG8NCmV4ZWN1dGUgTE1TVyB3aXRoIGEgbWVtb3J5IG9wZXJhbmQgYW5kIFZNIGV4aXRzIGR1
ZSB0byBhdHRlbXB0cyB0bw0KZXhlY3V0ZSBJTlMgb3IgT1VUUyBmb3Igd2hpY2ggdGhlIHJlbGV2
YW50IHNlZ21lbnQgaXMgdXNhYmxlLA0KcmVnYXJkbGVzcyBvZiB3aGV0aGVyIG9yIG5vdCBFUFQg
aXMgaW4gdXNlLg0KDQpGaXhlczogMTE5YTljMDFhNTkyMiAoIktWTTogblZNWDogcGFzcyB2YWxp
ZCBndWVzdCBsaW5lYXItYWRkcmVzcyB0byB0aGUgTDEiKQ0KU2lnbmVkLW9mZi1ieTogSmltIE1h
dHRzb24gPGptYXR0c29uQGdvb2dsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSYWRpbSBLcsSNbcOh
xZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4
YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS92bXguYyB8IDMg
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC5jDQppbmRl
eCA3ZWQ0MjJlMjY0MWIuLmMxODM3ZDA3YThiNCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS92
bXguYw0KKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jDQpAQCAtMTA2NjEsOCArMTA2NjEsNyBAQCBz
dGF0aWMgdm9pZCBwcmVwYXJlX3ZtY3MxMihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCB2
bWNzMTIgKnZtY3MxMiwNCiAJCXZtY3MxMi0+Z3Vlc3RfcGRwdHIzID0gdm1jc19yZWFkNjQoR1VF
U1RfUERQVFIzKTsNCiAJfQ0KIA0KLQlpZiAobmVzdGVkX2NwdV9oYXNfZXB0KHZtY3MxMikpDQot
CQl2bWNzMTItPmd1ZXN0X2xpbmVhcl9hZGRyZXNzID0gdm1jc19yZWFkbChHVUVTVF9MSU5FQVJf
QUREUkVTUyk7DQorCXZtY3MxMi0+Z3Vlc3RfbGluZWFyX2FkZHJlc3MgPSB2bWNzX3JlYWRsKEdV
RVNUX0xJTkVBUl9BRERSRVNTKTsNCiANCiAJaWYgKG5lc3RlZF9jcHVfaGFzX3ZpZCh2bWNzMTIp
KQ0KIAkJdm1jczEyLT5ndWVzdF9pbnRyX3N0YXR1cyA9IHZtY3NfcmVhZDE2KEdVRVNUX0lOVFJf
U1RBVFVTKTsNCi0tIA0KMi4xNS4xDQo=
