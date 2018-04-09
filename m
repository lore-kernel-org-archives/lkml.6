Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233939-2-17522977524833505305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233938; b=hAIjM68nglTis1IXvSCqqlSyeKw+Ftb43U8X9YyW27A/0mogwT
    qchDn1JpRbl80aNjOPGHuCtcMWTcKvU1QzRb1QJO7em3RnInnJxYwPxMxcliqWpQ
    UgZDzHRXQbm9akirplrX+mmXaLaop/YkuFfK0dGsFy3nuomONuMYMiuT2P7jBKTX
    oWUlioO4sO+BLfPg9HpQ7ThLNCaYHsGui73G1ujDRO4hRR/vwNNbRhy3vyDoRh7+
    b5g+SxpUcvSpZi7fMEhz1A9UQnACKny/2wOxuBHP86QjJIdPJ8Z1lEzdQeXAj8Xs
    Rbv9dq0PtoYrxET28FKPVSoHy4kQUVcF/ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233938; bh=PHkeemZ7HP
    PD0Jl0H/DUx1catmbnvjKWIwoB5LP9SFI=; b=IstmSU+VpVhjvQkKxCXiAKRiaZ
    OQCqP2df2JVNdIybeTwgDkETTsNoGrcD3XU7iHd8iKfBP/SjW9QdBgK2R3gN9Ycs
    /ppPTOWc61IKaOimr3AJH5Bppn2gZeZuHndJIZeRWoJxZgqUfnxaEbiMz6vwR69O
    Fi6fZB+cKSXdsDRAZ6ao8jPK+4+h8PkjdqC7OKWMqLPxotLcx3RSPSUURusSMuY2
    GPXzCM8nYduq5k4gxaEG+EheR5XrlzEaaB3ib9Mko6itUf7lWUoQl4VHJlN4a6+h
    pWTih2CWTQ2gJ7E9KWtBMHYerLke7HxBKhYY/KB5J0lJgwH3yhBw2dZz8elg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YyePs6s/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YyePs6s/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+4IlOkQKBAQnrZXvsbyNplk1stXsf9eVQQEdYzHp3/eJzubQTkKxRdgUaOGePCQYcLqjE2+0MVM+k0OxpnvZoSI9nO75mm/ZU2dMXeyCg7CLv4T7vc
    mwfV2PRjGrfYWWMlamiSs7wFWmUEzdzXacOVl0mncw6nTLybPmFlnvRa/KWlbjfoQQxgfGqHBZGu5MXrxING5TG/g37bKyrTcVwS1/17CqMoKCO5CzjFVGEg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=i3KyWQbGKiS6jn5U1LwA:9 a=ZCIFQFsroKvXqBDV:21 a=Wmd661WRv6ZPlw8l:21
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756399AbeDIAcN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:13 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756434AbeDIAcK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 198/293] powerpc64/elfv1: Only dereference
 function descriptor for non-text symbols
Thread-Topic: [PATCH AUTOSEL for 4.9 198/293] powerpc64/elfv1: Only
 dereference function descriptor for non-text symbols
Thread-Index: AQHTz5lDoNQBKU1l/EmOcy8JJUaGPg==
Date: Mon, 9 Apr 2018 00:25:28 +0000
Message-ID: <20180409002239.163177-198-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:/HVWt18C+AEBgXhp1yq+etOzRnn+bSiH1eD3FaJoo0v9iPpit1xQBPeJ4sKc1uBvl0jCCcCVHJezKN48+CQPL0xi7+iu8i69I9/Zdilgpt96JB6aYwU2/Gl1J4Pc5LqxZK1+Z1a+xqjC7nLj1NJLlOGbEhpglQKhRIGXz1ijoYp3EShilI6e2kXzuBH6G9inuKUPK5JmfwhtSxlHSsluVhDEP7JqPtbAYqYxDk8g25YDnPooOSjRuhXuTyWs6H9s;20:5Pafwh4/i62AZX/LxxxxTlbslUiROzshpD42KF7mzpFkQLzk0F1Hxo/5ViJRm6gP20vHKx0kTZ1qlUbltXKExK/CzgUTibmnjo1xkhSyv36ptWs98/XBJEDG93bc9qzZptgrX9FDnzPBZnFLgTjkbu2XdGzNrG1Y+G2jfP2Z3r4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5802a4cc-0e82-45b4-4a52-08d59db15292
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08708FB69C446DCBB236D6AFFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yIzhqObQcg/IU5UamJtQRH42pjy+SLnoYNQEtuyLcbpMCO3IirGTgVs/lTIqtsT8tZGQaSCiLGPgMbJf7uj+9WPjLApIEW9rNkfhCVqXYwqVoCOMB4nFhKnJQab57+IlGTy3520oEEosiNpE9D503kqJGo4s6bwN5jxLvdkx0eZ5Wv7RcR/N9GqyivVwxYltmKrPZiT1MPS5x67sgiOZwVQpJNP6vaJV6tVYs7tsPPDAy5aB21tuzod+DHtdHOcZ/hHaG3NCW9vd/PZ3I+hSotKXqyfShbK/QQ/2qSWtFYf3rTRtZZMMDojNQZlT3pWrmR0anJ3f2ZyfrKghYnd5K5C9LPshLT+IFyuHYHVhG4HAjLJWz6EZVIxBMjS3OmIiU/OTDVD1RBc6yOOl4BG/gvZZYbGKWbztsw10QVIDMh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5802a4cc-0e82-45b4-4a52-08d59db15292
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:28.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit 83e840c770f2c578bbbff478d62a4403c073b438 ]

Currently, we assume that the function pointer we receive in
ppc_function_entry() points to a function descriptor. However, this is
not always the case. In particular, assembly symbols without the right
annotation do not have an associated function descriptor. Some of these
symbols are added to the kprobe blacklist using _ASM_NOKPROBE_SYMBOL().

When such addresses are subsequently processed through
arch_deref_entry_point() in populate_kprobe_blacklist(), we see the
below errors during bootup:
    [    0.663963] Failed to find blacklist at 7d9b02a648029b6c
    [    0.663970] Failed to find blacklist at a14d03d0394a0001
    [    0.663972] Failed to find blacklist at 7d5302a6f94d0388
    [    0.663973] Failed to find blacklist at 48027d11e8610178
    [    0.663974] Failed to find blacklist at f8010070f8410080
    [    0.663976] Failed to find blacklist at 386100704801f89d
    [    0.663977] Failed to find blacklist at 7d5302a6f94d00b0

Fix this by checking if the function pointer we receive in
ppc_function_entry() already points to kernel text. If so, we just
return it as is. If not, we assume that this is a function descriptor
and proceed to dereference it.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/code-patching.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/includ=
e/asm/code-patching.h
index b4ab1f497335..a96e4ad380d1 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -80,8 +80,16 @@ static inline unsigned long ppc_function_entry(void *fun=
c)
 	 * On PPC64 ABIv1 the function pointer actually points to the
 	 * function's descriptor. The first entry in the descriptor is the
 	 * address of the function text.
+	 *
+	 * However, we may also receive pointer to an assembly symbol. To
+	 * detect that, we first check if the function pointer we receive
+	 * already points to kernel/module text and we only dereference it
+	 * if it doesn't.
 	 */
-	return ((func_descr_t *)func)->entry;
+	if (kernel_text_address((unsigned long)func))
+		return (unsigned long)func;
+	else
+		return ((func_descr_t *)func)->entry;
 #else
 	return (unsigned long)func;
 #endif
--=20
2.15.1
