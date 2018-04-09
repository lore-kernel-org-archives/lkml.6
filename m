Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235888-2-8882772447755148537
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235888; b=JzdfD920H1RdY3jcAepL5KWSeF31NrlxiuZKnwA5s9YLflPw3A
    xzUL7lPmwMXOP9aWefEf5k+4jAXe+6h8MGkzFIkpo9qlM2+o2E+yaN9G9A3vyrlw
    Sbo+c/Ku9Hp/2l4WNkDR61IH2Os3M0tOpS64s7oYYRaLbWCmYLfsX+chgabYp9uB
    4rX/9HrFhtlCRoqp0EQoZpFC3EDII4MSKI5JxVkov78u/sO67xntJR72UBH417fE
    JuIPOY1oIZCP7ZCBlMep3JPQM7b8yxnI2FSebf1h7RH4vvw+bgYR4XHFJrZq0f+8
    i5kOBiDv2D/8R1QWU97UdLBeCwwEguaFvhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235888; bh=4Z3QH9nS25
    8eL3fNEiLL5rF9DfTdJP6/9TW+PqZeNPQ=; b=j1CTSATg1/1NZKoXFSoegHJ7Ao
    FKV5SRolmZYJ6f7IPvl88jrfvuSyk8F2GTpPNxDxP82Z7alrU/wdjVu97Ot8xBb5
    BnFi0rHLW3tvf/teGleP8i/7KKYb1wO03HcakJHlfdl7lWQRQf4YdszDNA8OTTeK
    U1Iu1oZMhMeWy8lzLFknJ95vWuQRntFkAKGEZ6+dMzxwZVGuUf8KYbMh/CdZPOQA
    DuIdDQrDXoDNOuA1EreITIKEapRy6QX3Z0lAgpnD4yIU16c7i3dizYExRqK+5sK6
    yBbKXZ0BtT0mwtKWJN/938cQ0lDAhkK+V4H/gYpLr0NIF8yyIspwJyv3vx2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kYQ5gROJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kYQ5gROJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC7i1plcQCqfUtPljsa3Tclo7pvIT9o7tgzT+WL7sGsDWdWje7th+A/sW0xPs4i71N2aUpo7l9nBJtrOZKBIGIuK/Q3LTgKs2byMz8PXuE1+r98DhcWO
    pdhMIp9aEIya7hcnoBaxaI1YMmtFH0lYRVBaVSnViYUqA+7gAr4PT5s9k/xRv+yWPriA1SB7ZgwbhbKPe1EOE6DHmAjj+e20d1/r5Ca/iQ4pLrzDjwq81e8W
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=v8_uC2TkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=nJfSwvQdgnDg2EGCjrgA:9 a=iKxVXWsshok0ePGL:21 a=CcWCeBfwhg7qmQb1:21
    a=wPNLvfGTeEIA:10 a=OGrQfBrq7qvr04naqs9r:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDIBDd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:03:33 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:50200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933154AbeDIAjf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 008/101] xen: avoid type warning in
 xchg_xen_ulong
Thread-Topic: [PATCH AUTOSEL for 3.18 008/101] xen: avoid type warning in
 xchg_xen_ulong
Thread-Index: AQHTz5qheyoJZXptUEKL7GOd7oPAug==
Date: Mon, 9 Apr 2018 00:35:16 +0000
Message-ID: <20180409003505.164715-8-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:xUB9Bzq8UcK0kvJub91KjVgIlH3NN4x/aN9PkF1220Kcvb4g/c7CJWs1OotWmqCw5O3g5yQkPYwWjtaBq6TDrSFCl2SHOMkFQpvfNwcP+AMFJwPFXHvf2MSQ44hFuoc2tnzb7moksv61sjAR663gctOZdua1TtZtAAfTQQPf6JnRs2AJrOxrC5Eo8F7TV/aHPZhGFLwB8ztPKg20fxCWLqG2FPde983K2vV9dizHm01Oh6A5DhAq/rx4ddq6q5gC;20:/qxdkianhCdNwg4aJxyIk/Uc+TbvCzOwra7/s4U9dPyHpo87vmSKz4BgskY1PaB710hAVWQURC+O/RfytNtcC0F/lZPlGifpnpjo1Wnuzo3FaOc5giC3t0xQtqMpUdVvFm6iLSDDrtXbcQrj1v2tSd+gB3hWk+dPASYpqhSPlyE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96857811-21e8-474b-9cd1-08d59db25a70
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104782A7369EE4085D2BE46BFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SSnM2CbeHRh/pyGv56xMFTI0Zc0bZ/PWLCDeux2EQZMtZKoKBVczeLY2v1QTdMNvAP57YWyY5E4cdNeiSVy0jEwnkGXXGWExv1QT7CTlqXlNUXBYVnulvD9eSm9xjS0c33uygk4WyrRzXJqnsMd34EsiE/l0dQRr/4xbiOVx/gMeHaeIHTldxGui98GB2Ve3ZpIn/Y0p4DlykLXOjwbedB88Ly408inXKoY7s6DhQQPSuvxM0M6PBzV5F29Aia6n7VwjNPWANO+N7HvBYRTimtP/dmjz5hzpxjL2IW4OfGuzSXSNkl1nu98IstRYqbpCW5ATeEBd0F+1j/LQehcLDViiUE+Bp/adHlNoj+eIf8dKARVa7kEs0NMMjn1hsG0Jv9m67Dnqp7usMfRhM3nNoLci2EKgcDsTvwh+e5xLqc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96857811-21e8-474b-9cd1-08d59db25a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:16.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index 8b1f37bfeeec..b7aadab9b0e8 100644
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
