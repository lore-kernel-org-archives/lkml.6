Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242000-2-1987660884424937222
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
    1523241999; b=U8Bqp7xUWQo9/6/9TwOx4wFOPxrJSL7PNv/8JQWSqQSCHMgkik
    pxVfom01vyO1RGLDjE2a2FiDimCcoHoTU5sfVkn2aEtgEbY1d4CLpTUY0j9sjzto
    wJZJMUtHETZlGy5uDq4tpaT2pZm/3bbw75MRTGeJHzSTmSzGrk+5AyKJ00mD5Yu+
    ywyFpkDvIc8DZqg+tQyeB8U1DYiPblMkP03X1PLXjzKP2WLWNyMiLujNUdyqB5N+
    H+ksOUcDxZkmx/pgUYAttul6QuZzQHaNh9IgQOJt5d0VPHPlig2AjzE4OhR5Ywk0
    oOH/cBhtA3LZGlFpAgROUHpSigcIdOWDEReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241999; bh=99z+fxgPMB
    KZL6u4TzbomHMirrlh7wWYsm/yT2EFtmY=; b=CpAqH/ptlY+Of+YG/oEe4LIxsc
    dK+ziMm+kG+Qoc+6GjvcLdZ8pn0hljBmb2lZ9F8sqD/R8AuE3bT7IVC6JCi/KL3m
    KUsh3IXI01nyh+sI/63iTCNW76N+dUnIjkQogEE+Vp+RmlbX1lZDls6RuvLoemVC
    SevZWQw78cPcgu1PjAOZU0NBYmI/rFI91V6kZiWLtmgt6x+ED6XZ4tysr/jXyXf2
    qHPi4cN/j57uRzQy5zSl4Bwg70z6appVEahIr+gvUBJSw5ZCMQI1zMxcgMD3y2Tc
    LtPLunh8Q83xDYUQL94fHVm9RtyoR5T0wdNjIu834R03v3XQ5dso3H1N9m0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VxAl+ox2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VxAl+ox2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCynNSioYD9r8ZceeX4KGFDuaaTdhwLPHIYQgLBnHksUwE1OP5FcBSLRzAVIWJlM1jlnlyO8Vh+faGOHWtFoMfy2X5hAhe3AikQC66+NH5ozzuaY3myy
    Iue9uyjspBA5QCXOK+jRb9F7c60pgvoKWZu1Ycq9UoiH2ij1X4Uax1v2s+gCufdFXc6R6/4A+IY/trchGCtANCHJD77js54X/DH876yP6wczbBMmynRFCqY/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=v8_uC2TkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=nJfSwvQdgnDg2EGCjrgA:9 a=iKxVXWsshok0ePGL:21 a=CcWCeBfwhg7qmQb1:21
    a=wPNLvfGTeEIA:10 a=OGrQfBrq7qvr04naqs9r:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755350AbeDICqe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:34 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755409AbeDIA0l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 017/293] xen: avoid type warning in
 xchg_xen_ulong
Thread-Topic: [PATCH AUTOSEL for 4.9 017/293] xen: avoid type warning in
 xchg_xen_ulong
Thread-Index: AQHTz5jrjSKo4/+nHkeCZpDJhTwqaQ==
Date: Mon, 9 Apr 2018 00:23:02 +0000
Message-ID: <20180409002239.163177-17-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:4EoMWnL7BUroOxFnqdk3p9sybPWRRtp0KgYBbjP62xcuRPqUJIzlPPwacnJe6vyIwPB2N4sAXdpj07iKZMVkSUZ7WbWourxmnFaWOGdqgtBjqpZr0pnsFKmqzJttA3yyhjGNIFhcS9lA7BnB+5TdG9MR1COZnHC+2SMvr7fkH/46aQNd98672muOycbwbOuSOY5EUvX1eV1fB/OSJb2Dw1DW0oR7/Ae/iwxAYQYm2lMb24Sa43fZoA+XalmftbBs;20:2+FV9I/rM19DRKHvRfOZf+dmvzvcg1GifGEKwuxuiAUirUF07Rg4GF+638auNvYwSYVzrv/BRNaMGU4ZbioOK/N0JHWWnj9UZ2wiL1vAa8vkoDVRvntOfLTeCw5RgNgfT3X7ubu8mqY8JpmDsT3hoeh3KvVV77f2hGRVH+zSOzU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93eb7150-f20c-462c-dc74-08d59db09014
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853555798EE615BB7C9263FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: e2sEBElV2/zcZPcCyWlsRDfGWLuDnIyjaay0y0TEw0OXPjFcSsD1tuHnHyiXXiAVAzn+uEUqMTTclMF+p0xEIr3Qtdv7gPKWeyC1UJ2GP9NbgdyO6ak86XuU7gszxPKgv1tL3sdxj2GSDUAl0/aaX5OKPEt/9JT4SwyuGNqjzH+QWEr+WwMKSrl9LBCh/UBsqXEknhi79umC1p12vG29iizITvYBgso7rWEON3UORjWtLfUy31uJfF9RvQoIEc+aqGLIrhfpMd3MrwnMkBK3fXEkVXRWW3fRnIxe7BGE9bGHd2qXncEcqfMxnwSqEKzMwS6qkcJbotS3i2n980xKMj2DBYNvrZUQrcn6o23TthiUF4/wjaGlwpycNpz96yfaHWaZ088PQVusqXUPBxNJvRR1Gjx7wnh19ta/N4iwxKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eb7150-f20c-462c-dc74-08d59db09014
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:02.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9cc91f212111cdcbefa02dcdb7dd443f224bf52c ]

The improved type-checking version of container_of() triggers a warning for
xchg_xen_ulong, pointing out that 'xen_ulong_t' is unsigned, but atomic64_t
contains a signed value:

drivers/xen/events/events_2l.c: In function 'evtchn_2l_handle_events':
drivers/xen/events/events_2l.c:187:1020: error: call to '__compiletime_asse=
rt_187' declared with attribute error: pointer type mismatch in container_o=
f()

This adds a cast to work around the warning.

Cc: Ian Abbott <abbotti@mev.co.uk>
Fixes: 85323a991d40 ("xen: arm: mandate EABI and use generic atomic operati=
ons.")
Fixes: daa2ac80834d ("kernel.h: handle pointers to arrays better in contain=
er_of()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/include/asm/xen/events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/e=
vents.h
index 71e473d05fcc..620dc75362e5 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
=20
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((long long*)(p=
tr),\
 							    atomic64_t,	\
 							    counter), (val))
=20
--=20
2.15.1
