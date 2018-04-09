Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237946-2-10130393775250272357
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
    1523237945; b=t6CZ5W36hMVUFnhcITQlLqz1HPQa5u4/vkPLn4wPB6FQIoTrmD
    7O1lz/CXgHMjilYsf1SuD3b3YL18WvFfCFg7VVWxcugywBuDMYel7VQHoLpdNytp
    7/zJb2OVGmOwu2WAVl2haIDCewVnC6fdfPZN0jMww+oq6ayGHGqHLjW2WomPg7cZ
    vyTrzVEpiBLkghQi7xPHvYxVVt5vTQZcYJ3G0leqKa8snQchVlRdIDYcMMVdZgS2
    jH5QZLFiU7xlmWtR+prNBWqtUVhRGYavLcCPrTJpcnsWJe1FtVO8ZHWZh5T4ltAr
    a1Nxfsu7usIkjPBCvpqxptqLahMM9O0Q07XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237945; bh=99z+fxgPMB
    KZL6u4TzbomHMirrlh7wWYsm/yT2EFtmY=; b=JIyAKWR0eYRysLU1kFU7bawxPG
    qomF5bqAgcBgHShRSfUsDGUOdG7zJwYhfGWY42lgia6qVzrfYyirOEKKnSDfQ5e5
    02043f1Bmkd26lGsjC/cTBY94w0WWzc2CXEbBAKghU5GwOhNvQNfEjpzw67oFfOW
    A1GMVWS78Ded7nzP7xvo62nyaKLI9FGkGlHG9JgNDyFLcjLVuwsFRQFxu/JE4uhd
    znr8l/63up5lp79noD9KFF1xHXqg/N3Mpf5oEkwWqoVvetC1G4IrGI7T66O0rU7k
    V4nlBChK1q8XNXz+LWqSoctfIz+ywjR3oZUFtc9IIXRrzu9O/aiImwUL41Uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F7Hkhexq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F7Hkhexq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZDSlRmhU302wV6tC4gTdcN3Q2vRDSvIDNXvGxkrLg5GfSiA26IOsqUFzAC7fVeUx0jWKMbs6YbVW3LiL/1PM2TfCVw5swvJ0jORa5535G1sgl7Ypks
    SXZ8YOjoygabktnWPA0C/7EJ+uzZyvs45IfDlzj1sXpbYoOl3xBJVhrOzppL4zsQZoFMu5H9rOOcrLqDyj+hTXwv5GTicGTmpERAQIbqvs8d1/9UKH2jvf8w
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=v8_uC2TkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=nJfSwvQdgnDg2EGCjrgA:9 a=iKxVXWsshok0ePGL:21 a=CcWCeBfwhg7qmQb1:21
    a=wPNLvfGTeEIA:10 a=OGrQfBrq7qvr04naqs9r:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757386AbeDIBi2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:38:28 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932552AbeDIAfB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 010/162] xen: avoid type warning in
 xchg_xen_ulong
Thread-Topic: [PATCH AUTOSEL for 4.4 010/162] xen: avoid type warning in
 xchg_xen_ulong
Thread-Index: AQHTz5mXDb2bsrUJPUi8KsTaKYeItA==
Date: Mon, 9 Apr 2018 00:27:50 +0000
Message-ID: <20180409002738.163941-10-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:2H7+mYJBPMYpxzj5yvZ1CZnlwDqBEnAml/hgq00uw3GzbVVUEzemi9ByQu4C8URfWQPiqLqvg+KhH8rCEEkj89/tXT1eGEGBc9NKSwTySyXMQqGGz0pqQ9weSkoc+SaYv1HxLU8oBZGU/484qiNHpERgcll2TscKlYQgKLKhUtf2+PST4lZ6jpfI6MiN2hFVxTb02VpZuheysha1yUhNK/J8vOqi8CUevabdfjOUkGOVCp24l4EkAv6CR/zNvtuh;20:w7YLome5i3IEwqjaYljn+qBQ8HqY/wgD4kL/KY3E9l/HDL6aUoLUK6A/J5fzt/wP2xqkNGbWJnztDMa0gsKzdRsljMUs6YzwG2zYB76OyZ9deRFDUHnBUxU6l5NJNTou+o9A7CU/EG4n4ERNLOUuoydD+E9omwzURYuW7ZaKrWc=
X-MS-Office365-Filtering-Correlation-Id: 86111688-2715-4f9e-2f02-08d59db1b7ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10138390F008FFA6A6FBA3B8FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fIre9/sQUixyncW4im2BddJ8jZ7MZIXtio+av/Nhq1QaHDyQ+lYnL0EJXA0G9e2Hvm5/i75npkU7t7nT7324Dz7xdNPKTa+LZcTB0av5xT8taZZLBueemxidEuuusONRYKrpsL/aarzTLmjo1OC40ogGU2LzBu4vbMp8RahKz85jSUSQKcH3kq9BevbcRRx1QsWM20CV2BNCa6NiQBUbJX79558mvfMQFpU2/RxO8jCa8cJRupBc1+qSjroXbk7ei2ZOxMoFQ1wqgQx+3mesOe62d+3l0h08boSLBOIpeV4ieOcBuSds/vEze+8PFwhfW4cctPBK4V+/lZxGEgwMiRgTBkjZGfuXRVGsbqJOacTIyvRuDT+LBh+SI2ECS9txB5uMx1EnBiBxGMTIvsogq3wZ6g0F3wqEBjIoxoB+k5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86111688-2715-4f9e-2f02-08d59db1b7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:50.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
