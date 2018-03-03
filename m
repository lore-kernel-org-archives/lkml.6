Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402533-1520124652-2-6378142782432130867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124651; b=IPd17H6Z1OgzsyhrXqWd5SlsUgF4sRu7QnmHWcrgdnp40th
    JtdCpyZAicHEznUYfBt8+DKI9blhLBq9msWKknfmARh51NEN2Htzifz30EdTVR8w
    /GzOId02nOyKKhK0oRHB54/7hZZNZ1lXfc8E+M+0tyOMEtomKFjRZJlbDACrJ0CV
    JyXf3QN9twQqYrcKrZmQ4aoWs4LupUCcVA8X7WE/GIpmQ03fTpWnMhRqb7HI5yih
    bzQ+54RU3nNVpqb1o61MBv2Au5bO7wJMdG4pirqZfIpG88V8725JTtcU5qOM7FxU
    dsM0yhn3Pop+NLZC+gYdzIw6Z9vNswvd12d9bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124651; bh=ImOhTn
    xopJDlp+KCFsN7Zeco3uyL6YF/YM3KVZhGLpQ=; b=jfE3ixVq2+8cAPiW/YAxXm
    msJ6Aji/ZOSH3W4CEFe3QCq4XI4Bg4Uepnr+/W5Zq8EFVo7kOze9zHmKqPA6/lW3
    klla4QqaJTBDNrlz7WY1XR9/IStEnkPyFw+0Pj9T8hj9SqvZRMr93osOv4Phllk6
    Af8zrWvtGl7w2vHtKmDCXj2DgPjtoQEhcsbVyomtaZ7Yk42CKqwkrK9XiMK9BwXk
    90i1BbOH+43bf4MXY65a24mfIOQdlHfUxz9G6SwApoSJKY49WxbckU+XAe6FZJGc
    fG9cnoNU0PQ+IMrqGVpOfx1dhNut2KFTwe+qttjvqZHh27abtDhQA+TKdNOCdi2Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L3qzbMwy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L3qzbMwy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeCDAug (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:50:36 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:61181
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeCCWYU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 008/102] KVM: PPC: Book3S HV: Fix typo in
 kvmppc_hv_get_dirty_log_radix()
Thread-Topic: [PATCH AUTOSEL for 4.15 008/102] KVM: PPC: Book3S HV: Fix typo
 in kvmppc_hv_get_dirty_log_radix()
Thread-Index: AQHTsz5btEeoH1twYEyiTI2xv+PwLA==
Date: Sat, 3 Mar 2018 22:24:13 +0000
Message-ID: <20180303222318.26006-8-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:J7jB4I4WHyCz1U5JB5Ig6aKflY4pabTksAgNEew/y8DSfs6dtfGRAv+3vUGJMkGEj6SipjhnGeaIDio0T3QNqaX3O+vlyUuCC+tH/D+gTRiln+TdMHS+8AF6cf4IgzWUA4RiRSeZt9myRndCPjiwR17kBzt31eMdz3kDVbBkaJemXY3POwCPASBXd+mQDkX73gQkK5VRRxZRhSnWKRuBDK7WYykROsbi6SlcfY5Pjh4bo56Ksd8ls0+EQqQ758vG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 873ae207-dd23-467b-d029-08d5815580ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890CC5BD48074C03B818364FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(32563001)(14143004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9hZoHetcq8XYP6hCnRZ8dKBHkfeyXLUkmR6dFQjvxezGcNMeTfsDYXujLId7m+9Pjyym/gAXMkZqWhXSbc55BGZXnUo1uZtxGrxr7k38ltUt5etxBaT4F+lL5zxByr+q1+8eM0hJyq2vSXdaVclS2W94xsdKENHqME0eVMcKl+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ae207-dd23-467b-d029-08d5815580ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:13.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 117647ff936e2d9684cc881d87c0291f46669c20 ]

This fixes a typo where the intent was to assign to 'j' in order to
skip some number of bits in the dirty bitmap for a guest.  The effect
of the typo is benign since it means we just iterate through all the
bits rather than skipping bits which we know will be zero.  This issue
was found by Coverity.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book=
3s_64_mmu_radix.c
index 58618f644c56..0c854816e653 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -573,7 +573,7 @@ long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
 		j =3D i + 1;
 		if (npages) {
 			set_dirty_bits(map, i, npages);
-			i =3D j + npages;
+			j =3D i + npages;
 		}
 	}
 	return 0;
--=20
2.14.1
