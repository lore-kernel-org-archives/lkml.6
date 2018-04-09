Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235960-2-11853186380667280777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235959; b=fAtPHdkx2XDfnQ5RIatraiFJTrtwCms4wglkcWbYNtdT1YH/XA
    L3GTU1ZqqZJBtyfjPoclQmIe7RLglZxWR0dkiKT1HIECmS/rmmYbCvGAMc1ncA87
    JRC8u/UIrFySmoTg6K/oFQKSwBw4VVvFPUrHyH/330FSbLV6YrV4NeBhF2hIqHrt
    F0GJ6Qa6b07DJGLR73qSXrj31gz6II+3tgK2U7ZSIItPdrAnC94p+GIjv9uLiW7Z
    4bYdlcJi3Qz6i5r91/14vcMiatZhDHdHu9QM7cnMo06lbiNm1HAHUveVJh7N/ZA5
    dVwAOvyuv3JFKVAI3MyouNgJy5s4dG3YIarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235959; bh=eJCr+ENV2x
    tSuikKtG94QoJhvimjb4qTNrW9jPVmO1w=; b=QJ9ikon3aSBqP4fDN0fbiqewNS
    MD7ic3TGGBrGy/wBg0S4/vxYo8D6warQaKWuQADD6Ryr/fQztv9Fj7WcZk3myCeN
    GKMUIxD5zxwS3B9ts0FqVMY7UzTbSOJv6XxAm74SQ8y5dsjoISPVDFFXbxjY2ZaA
    Y72csN1MzJRJVq8cvk6SejcjqbOtOAdiglbKRs+remBqPhfuGgO8pZR9TtPPmxW/
    vRtcxzityWGSib5bXCLjqHA4cee6orBJv+v+XNKL8BjnRLpqTtqmkZ/fjvwNE9yt
    Epx3EYuu2Zz9LUnvvV4zwOebQdeNynwJkboTZLzo96tzaDIane96j4De9cLA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=coffmnd9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=coffmnd9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNFZO37njD+Pitcemtt4W56Hol3e4IOEJOtKXV1A5gFJiCI3sTcUtcXd0mLMidJpQlQ70i2zsFIhlbNpoUCgXxv+DlxBfMudUIRV8qiQo/ZlF+jcb8t5
    ZboEzPrZ3nft2CsjPWm8ZqaeNG5YKgMeYCUC/1eZ+tlsMG+2LKBecefHMO0bm85r5S829w6gNkLuLh+lKLBQtfCZs75XaVifss4Xri4fbOggdpTVp27CTS+i
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=72xZbA8UcqOln83T7vIA:9 a=4zZynRfxn_piIYhw:21 a=IFRIY7OpxCe8iowW:21
    a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeDIBFn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:05:43 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933118AbeDIAj3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 004/101] MIPS: mm: fixed mappings: correct
 initialisation
Thread-Topic: [PATCH AUTOSEL for 3.18 004/101] MIPS: mm: fixed mappings:
 correct initialisation
Thread-Index: AQHTz5qfz6OJ+DhKy0GyQNBBiOVL9Q==
Date: Mon, 9 Apr 2018 00:35:12 +0000
Message-ID: <20180409003505.164715-4-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:ANXaEGTG/0rGg2XgGc9p9FmTvyaYQIYNdY5fb1Njmn3zDLd8gKa3MjZ0FE7/455emlARYX8EC6Lfp5bOYWxD99slPdB6mvqOXYKsxbxrAAdQELlHlT/Hsn5fC9NiTmRACHGqWOd7Hc5in15zZ3BjDbdHQKFhnrZnHX4lXJJULSu14C4wHP6Gtbtua+twSeBhSmODgH5B4yORgZXufVPNRIbM9MkoeaJx+mJPpDb0P9ncxhjUZDeZVelg55EwFvBx;20:2ULkptk1ioT1PzFQyetrSl+4haq6VcILw0FkXiAStKX8acw08+Uk3u4WxZXKSJ8eYTqg/JB/vFJ+QrDbCWTLLPx6HdZzEroWO7HksRvS/JGOm5k5HLYkzb1qzgNWec9T3WD9fZGByE8hqYTzKDTgqcmTPGWJn4zuTDk3ODdOgjA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0b6b9dd-98e7-4cb0-49f5-08d59db25919
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047B484376947F56ED3B535FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8yOj/WKLdyZri8i9/bs7uRrRQB2KOqEIzC1i6cwlvCRALj/9/i0Xbq639g5+nVooEyH8X+vF3HSxXRgO+6qLWWeCXIYWMuSR/3xGhqjQQDxOmSwWO3NbPUDp3lN7oAak1hXsNOVOVVQXJHxL8rlT9iQPzLhIu5DSI7vqqlZShmusCTkXDx2HTkWgG9P+BE8/NPgfYwUQc67mHdCT16Xx4LmI4MdQW4jttlZhf9sJzlrXNWidbf87yD/DDSuLw4bGCosPUPl5mcRPN65dTJj+qjZXRzxpp5EOcuqgyH7VtkrghgnQpx9w3aaIPwfDWDcN7Z1V4hgi1uoRoEZZ+VSfBTmGBz29+janaqWAongusYj3wKrMIB5vP+OFlSRJtiarYCywMMindcN+lirtIn5zjTUM7Dhi3Ltbe/Ddn/Rd6lI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b6b9dd-98e7-4cb0-49f5-08d59db25919
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:12.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 71eb989ab5a110df8bcbb9609bacde73feacbedd ]

fixrange_init operates at PMD-granularity and expects the addresses to
be PMD-size aligned, but currently that might not be the case for
PKMAP_BASE unless it is defined properly, so ensure a correct alignment
is used before passing the address to fixrange_init.

fixed mappings: only align the start address that is passed to
fixrange_init rather than the value before adding the size, as we may
end up with uninitialised upper part of the range.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/pgtable-32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911ba748..b19a3c506b1e 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -51,15 +51,15 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1);
+	fixrange_init(vaddr & PMD_MASK, vaddr + FIXADDR_SIZE, pgd_base);
=20
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr =3D PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr & PMD_MASK, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
=20
 	pgd =3D swapper_pg_dir + __pgd_offset(vaddr);
 	pud =3D pud_offset(pgd, vaddr);
--=20
2.15.1
