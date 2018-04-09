Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244445-2-8020812113578714633
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
    1523244445; b=j0Gfm+2hEEkoY/NN1Z17BmLpbepF+ftN4Sc63RfoGxOzv03qyS
    jLcdya8IrMPkRpf2LapgUyYQVppsjz/hmkUWcWAGHFED99gefKcMCpgNSj+R+wvL
    gxm28RusKdWZN4In0flUlShz7TtAThn8HF1mjtZ+YlQY/sAA3iW5xXB8QjwV7EP3
    pEkfZ+Sg/TnRB7aeoheZ8YrPp+1nuyDb5HzKuWQ7yxQ3sHZ9LgXm+RiZNXGxsJWj
    kR1zKiBaNZOaxS4tyBkeTTnAu3Zn0qKCi5kMTp133AgBrgFyt/beMnsh4wnJ1rcl
    eXC7Tn+31D3enziBPRITZq9kvIXGOYx6TR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244445; bh=QKwj0HdMUC
    xI9Z91+FW66d6gkScJAZ6i+lAqFAcXo6k=; b=LeDbqtOLa/wjStk7mOg2/kIUV4
    peHyBG5BmAnN+MVqfB+mKZJ/zDBuBPek+FykNneTt0lGKkz2n5gdrARbeBDA5/xH
    7pCWj/n97CcA742p3FNuSawe+85USWoLnOa1bDjJrZRuM+VSigIaXAx+EP4dRyQc
    VVjRgCCQsOKxsNqbQWdfy3LwES+NAuMBSlOWNQP84pAOcxv/qFX04OouJAJxlRfn
    p3QepWzxej9uCVyIgOzvok6rpndDMCk+P6N4p9KCKFZP8VrepQk/kueN9DapIEwr
    rsmNXqi/unTOh/dOd9faTR8hUU0lXm2HTtYSK4vcyz/wQnUwfMVy6LuNVAGA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSDrO54E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSDrO54E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ9JcOpdQZlNA0IePx9Cqj6TodTSFlsVOgw1IGxa2zCIEQ0mZjMprwfNjnwywrztvo2OVQBI/W4ylE5poE73e/WpXddZyy0FSLCxPTFlEb7cXrj7sgSl
    ApykzSgOhI9iBEREQndMuuYxrrCI9BpxHShzPGsP12fdfmefCO+wqK5aIpZh0j4n/WcVP0aWsFa1KPOwcCBHdtF/f08F4ngTEzc6v0CwauEIKYJD2BHf+7uX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=D2ETlDs0240gq-PhJq4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDID1A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:27:00 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:3548
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754574AbeDIAWI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 012/161] KVM: s390: use created_vcpus in more
 places
Thread-Topic: [PATCH AUTOSEL for 4.14 012/161] KVM: s390: use created_vcpus in
 more places
Thread-Index: AQHTz5h5A8EBYN+Knk6NO2r3BIXzYg==
Date: Mon, 9 Apr 2018 00:19:50 +0000
Message-ID: <20180409001936.162706-12-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:xMdw8HtKx9Jf2LSFeRXhx6JvOaQA5qxjUjlmYwp20lL1UsrqUlPNEvycseeEu0XFQykwJcDkjNvXqUSXikWUqSDUeNb8ck+oarCGXNzSu8UkyoW/4CJEPdHTS3A0GPC3h6HrGBNiwXC6RuqZUiOR67zWBacqQvsSYPjIkgSAKs82TU/C5TcmptKuLnf4JZ+HTcevoMPlOhLv6rrQfU2itaqvfwEbu1WxmRrd+HiMT3TT+tJeSpu6fui9hGW56Ido;20:asPhdTxbISIvaic9j6muvhcWfTwVQQTmZfJuIhkCELKTskUaU3YnUIlNcdL1oNZhg2m4ZZcEBzjieksyE04XdWpjXydvSzHGQv3yOV2U+GSkTch6B94vYRwRE9JEJUU0CTbZz32BCne9SXycTAQ07PRzBj2Du2xnNazmAwjJrLA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dbe638f-fbec-4d68-accd-08d59dafe9a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936E952D98E8971A78ECF18FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(575784001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jamrqTpgFOr9BM4ytfKvCA0cS6PoIB+OhUXVDR5PHi7T1absrNtv7iW44KP6ca0kaV1EB3Hzv/BlSWdX6p/ueJeaPYhumbsUesf3sVzcD/iETiggXsXiNZZ05iPwNLRIDfVHFXVZ+mbN/2r0j2Zu9bC2MV0duxAnDPSAuASjaI4DDNvtf/2VkdocN2djt2zEyhNScbR0HNn9XfEo4QEn3vknf3i8aTVpbqKKan4K9FE0rJ3+Pw3Mdpauvg6d1IExxDJTOsELutNGvBza+y9ZQ4RBAs9okycyKruGSRUy1ESZkv2QvQ/pzBQJX7hYPWFFqCcbU6hNn0LtWMfqPWMvMzB4ka6BV6cC8EpyNrGbXZhqUGJPXPRkIaa1YzQpI7HnvVsnxkHIcj4ZLewwgMV7CFl/TFDoKEaru+NmyeURczU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbe638f-fbec-4d68-accd-08d59dafe9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:50.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 0fa3a788dd20..0bce918db11a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -601,7 +601,7 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, str=
uct kvm_enable_cap *cap)
 	case KVM_CAP_S390_GS:
 		r =3D -EINVAL;
 		mutex_lock(&kvm->lock);
-		if (atomic_read(&kvm->online_vcpus)) {
+		if (kvm->created_vcpus) {
 			r =3D -EBUSY;
 		} else if (test_facility(133)) {
 			set_kvm_facility(kvm->arch.model.fac_mask, 133);
@@ -1121,7 +1121,7 @@ static int kvm_s390_set_processor_feat(struct kvm *kv=
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
