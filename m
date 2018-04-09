Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247102-2-16549028154359273764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247101; b=LvVJZLxr0vHYpKgtrpIt+O3b4R2NwwVV/9lF25jSQHyQ6Dz/Se
    RAwqIvMBSYWGsMilp7L2zpg+Ubpd8X2/PXwisPf6xHB9cWtRbHReCGMfKtIGurM7
    z79XlSNKFd6wV0I7IA9QDqrl/28yNXjlEaav6SI7g/1WtmVOpMNYzadcUVrryGI6
    xH5RCgkMrE6xv8RxLn8U6+QJ6/XXLkuEwPfrFvlkACZQpQaeCmCfS2L3zoZPLs6X
    aS3h3Lwy8q3p/UJQrAwo4FqM+9/KLDuyKXvUK7YhrgBTj5k+cwLMddMlS6qCBza6
    4YmljjLEJr/jHjD/ZDTCdZD5DFins0GKPobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247101; bh=zaf5eosrKn
    XvXKNojDwByaOUcwR1xjxHT1ZjcSR9PlE=; b=cjdr+SFqbhn//YGFvL9yQolSly
    lnd0SzGVvdMjvNwDSM+kwfVdpRqcjM2C39WOdNLka+wV2ZQ+lsrlYdYRKh4W95a7
    s9vFko1HO04gZzilj8v1kYAAXk4L1N4PECD2ncQZ1q4c0mv25K/wD0SAuPFUgjqZ
    ZA4m7HkW08fd+hqLNnSWkIYxgraPyZI3x3DeMC+wnee8mHUuUgHZ+ocKruhoqtHZ
    aCnHs4KxJi/FxeRFPTm9c5QNNnaQGpvj21IgP/lgNQDijqJTv0R30OTQYN4oGd6C
    Mv5TyFmBUdxDTicXh6aVoE68UMj9ywPSqGPmP0YFtzq6hNV795GPdM0EPgDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hK1O2I66 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hK1O2I66 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNGaU4BIHIFWn0SL7RIgouxJC7EhRWu5fYdS+vqlVaThJu/vFCg7ZmXgxz3pMSR8BCA/saK9kvUtdTpMeqRvlSN70nKbRKK09n+KtFAiTGRsODoOAniF
    +qmiPAj6gin8QrTbtgTOHq6R7np2tVN2bUdLM/NWNZhXcLC8JLpFM2s+tRP8X0Q5g4Kfh0Ln+nQ9hwpQbhaa+ylGmZu93EcgkGqtT14Hpy9MMPmOtS9030+c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=D2ETlDs0240gq-PhJq4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeDIEKz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:10:55 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752992AbeDIARB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 015/189] KVM: s390: use created_vcpus in more
 places
Thread-Topic: [PATCH AUTOSEL for 4.15 015/189] KVM: s390: use created_vcpus in
 more places
Thread-Index: AQHTz5gRBEGpHD7TMEKQwteh0chGjQ==
Date: Mon, 9 Apr 2018 00:16:56 +0000
Message-ID: <20180409001637.162453-15-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:DSBhYlHMp3eUrVmPiBQFVjix8piM/eGzWXx79kNGQ1gEDs/VXKeXk6+IcnsPe2d4nAf8x38ybwwZy6NAF+iqIyvRjPfU/pZX/IUpAPDnFRh8KpcT7cNk8xaFvHww7eWKKyHDgtxVSFYJFdA2r1qgE2gYwPL4x/HN00dY+8igaZ0J3Ne4oAzuc2zDxB5Sme/UfYrX09OJRJ0DZA6YGWHFmu45Ou9oyt7hOWa0eraY4PPwMsMSdK28dIFwIMbdtTQ3;20:zCscY/8v6ppqmyYelmVhr5PYqecSW1AxI2WCaxhxK8a6aIPHAHlThGSV2Pczc+i1WPhjIklTsH5H07RK+9/9w2m8VBKpjBb305RgqcAeCuqdguSNQx1Hz1GCLiyKPZe47uWu95TTxKHh7gyJb/ojG3B1l4M6zccvnEl0OfM4Ous=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bef04675-0d32-4da8-f914-08d59daf3424
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11276B88D6ECE272493C5462FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Tb19vznTUbp9DpeKne0WktkVyiQMm+9I07o7uc+Kf030CbShitdOaXYKTgPnE3Mu7kjhi8CIYsFNKHT9o2hxLalARRHkYPkBEAkla/gfCwFfXn89CR6avFl6KpKvP33LErgzjpQtU1w9dZV319CRuJGtKX+v9MkK19wMlJ9fwQr7HsqmHxbx3SBaoN3onq2gOC5gjFSkeDtqgbN78hF+o66IiHYTsDp3TSnJF/mKVDI9B2ArWDf7XBFMcUHRgMVJGlq9bBL7nZqxVGC9D+S1ltHpZezcSA+/FqGhu48mHvOvOb9Yrrx8QX6cnXLN+LEig1hM/9+euiLwWjqmy8FyLMmvlWfUiza1bP34X+FFulQJ9tPXjiwBgvrpBia1IcaxvsxeAy2CokILR98gL/jg89AW4p6KAz2UvcMgtjaqGYs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef04675-0d32-4da8-f914-08d59daf3424
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:56.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 241e3ec0faf5ab1a0d9b1f6c43eefa919fb9c112 ]

commit a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus") introduced
kvm->created_vcpus to avoid races with the existing kvm->online_vcpus
scheme. One place was "forgotten" and one new place was "added".
Let's fix those.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
Fixes: a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus")
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 004684eaa827..50193cbc819a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -602,7 +602,7 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, str=
uct kvm_enable_cap *cap)
 	case KVM_CAP_S390_GS:
 		r =3D -EINVAL;
 		mutex_lock(&kvm->lock);
-		if (atomic_read(&kvm->online_vcpus)) {
+		if (kvm->created_vcpus) {
 			r =3D -EBUSY;
 		} else if (test_facility(133)) {
 			set_kvm_facility(kvm->arch.model.fac_mask, 133);
@@ -1122,7 +1122,7 @@ static int kvm_s390_set_processor_feat(struct kvm *kv=
m,
 		return -EINVAL;
=20
 	mutex_lock(&kvm->lock);
-	if (!atomic_read(&kvm->online_vcpus)) {
+	if (!kvm->created_vcpus) {
 		bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
 			    KVM_S390_VM_CPU_FEAT_NR_BITS);
 		ret =3D 0;
--=20
2.15.1
