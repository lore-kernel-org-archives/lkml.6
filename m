Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244666-2-15839685687043848669
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
    1523244666; b=EjNKShDiL1iT3w20/I1BfZ2oVf6cSUBzl705CKCwU5iJZiIMGg
    NrtsADMoVUhza/cJ9i3oI+xrQ6UzIx85dsTvP2KJrMa+TrhP5q9ZZaQp+/R4rhN+
    XPLN3yYVuca5lD3889XFJxEopZp7lCce82K2GBXzudJdZD1ad6kbyV/RXLpOMH5Z
    Im5YO3UBxusqX7pxI2WtoqyMNf3u5U4mdk56ikfnPQnyO334ImuXfL3t6jnnouCw
    aLObgr7Fb7pFA5tSriiDDDAXh3FpxtwSc3EqI6Q353BU+se1YoOCC6q6sc2Ob/8N
    X7EDW5CpyQS1bb5/g92TGoQXAd9fxPzzRY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523244666; bh=X0bJ3jAZd3WNdmj/FRtNyFYkrVvb9L
    8qG8svt8n6VdI=; b=U9VB1uBFwO6cPOpYbzl1Tj/VebWv9x9g5+Wb2E/FrBqfHD
    bhWQwLuxYb2TdIT6hz3JxAkNS6fsBMv+frOid93bdc+nMOMU94IBld0pLbiaI+NT
    gCp8QBJv5EXSKA2GDKm/4oPBmEsFupPPwqmn6RJ0rDYB2eI0yAqs5MxrHH+QtA/7
    G5qLtUfgJaUfuI8VCv16Cn4bJ3bVV/GIt+aAuRR8rRf6mwGnX+lHa19JbCggV0aV
    aRLff1MixR/j9uNgpPVzvdMPLVKDR5PaVFs79BWT5xzCHfdoGgUt2ovzDuo7Okih
    Xkb9Abo4rryf8Q4++L1VcyfykH9lb+nhDlPBI2xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxE9mbHM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxE9mbHM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAngvsj2GbJLoCOcuNulfAy6t7mrVYE2kzjFQBqW0KOu6edcNTTM0z2l/1ujrmxbfnErq2p/YUFdOKPRV2Zw0kbFU5VKZlZoPgrLJdUFDzu8HiGvkyCP
    U3+6oLbRnbtfXir70wgiMr15r72Bb1Cb9xrsqerjYArSd3dcxAtzpAxvqFVkzZgMM4O+GYFkEte5KUD9AjY6IVYSIt2fSgVyN7+NicUd1XF2x0wEU6O38oA7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDIDav (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:30:51 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754556AbeDIAV5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hector Martin <marcan@marcan.st>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 001/161] firewire-ohci: work around oversized
 DMA reads on JMicron controllers
Thread-Topic: [PATCH AUTOSEL for 4.14 001/161] firewire-ohci: work around
 oversized DMA reads on JMicron controllers
Thread-Index: AQHTz5h0/9hJy9Ln8UKcvf5gNagYOw==
Date: Mon, 9 Apr 2018 00:19:41 +0000
Message-ID: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:zoYXnpW2/X+v+7gU1Lk3efF9H6e3bzzMIrUnbAh/6+rsO2FvHd/dZncMgE93mdqA7rpaQO0gyhK3CcDIvqvJYqC1M5HEhys2bw5QsKu11uYBgXAoEzYKLVx+P/h1pBOiBd5T6xmbBWW5XNbl5q2bqKr8AYiDLS9Fjqmywh8BFBUhQ7mY8CW6j0nGzfss+Hz1/Xjgk3WbY0e/LJudyHVFs8mhWoDkeBzCyoxm93HB3Gkpdln/mvl1ZnmJewUiLrr/;20:2yFp3TDz6TGdYsD90QDVtWeE8pt+p9ouCGFhP2/hizClF7UCkbDm8R/uuRWmmhEG2dJTgHzAOY2xUd7wnwdfdMhFwR5VO4f50Yu4ASjXNxSLaHQmjILyjesr7kaisC21Rci7H1k3bThrI7R6SB/0mRpKsXKR05Uw/Xuj7Wx+nYo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d7a36ec-7b5c-4995-c5d1-08d59dafe5f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936A7FF2F9CEF80036117B3FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(59450400001)(10090500001)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mcEa9G9Nok/W6jvskukBeAD4xZzpZtAtR8sRUUwpa1MApUMiJsf91X2Y3VWe0IUkhfSGOARIED0Iqnf3aeEegetDOqHyJNGdLm9XMBkKpIsk/5v9krV3PqLIFq5NmrFXoXPFmQYhhlu5f353PwOLH6DCUiDxnZJGd7KMl6fh2e1CfBxJVzLbqI+XUtw0KDdoS4iCxCQ0jcSIu4AlzqReh9ho4waclGdVO6BsJBB/cEzCfDyXKBKxLPb4vmahlM4rreqc/YS8SUoP1mVTVtqhVTn1yf6MKO9ZLjTr7VwV7HdLZPrQi4BT8o4GTkGc2t57JwiGWhDiIeAWwBWp4OsZVuVAf4t9UrsNdF02c+1t85g/LG846duHuYdYjP0PEcSUPwhmwzkUdiuTCe1nZSe8zUuS+6ZvGQBk0Fm/l+y4ELY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7a36ec-7b5c-4995-c5d1-08d59dafe5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:41.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 188775181bc05f29372b305ef96485840e351fde ]

At least some JMicron controllers issue buggy oversized DMA reads when
fetching context descriptors, always fetching 0x20 bytes at once for
descriptors which are only 0x10 bytes long. This is often harmless, but
can cause page faults on modern systems with IOMMUs:

DMAR: [DMA Read] Request device [05:00.0] fault addr fff56000 [fault reason=
 06] PTE Read access is not set
firewire_ohci 0000:05:00.0: DMA context IT0 has stopped, error code: evt_de=
scriptor_read

This works around the problem by always leaving 0x10 padding bytes at
the end of descriptor buffer pages, which should be harmless to do
unconditionally for controllers in case others have the same behavior.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firewire/ohci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 8bf89267dc25..d731b413cb2c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1130,7 +1130,13 @@ static int context_add_buffer(struct context *ctx)
 		return -ENOMEM;
=20
 	offset =3D (void *)&desc->buffer - (void *)desc;
-	desc->buffer_size =3D PAGE_SIZE - offset;
+	/*
+	 * Some controllers, like JMicron ones, always issue 0x20-byte DMA reads
+	 * for descriptors, even 0x10-byte ones. This can cause page faults when
+	 * an IOMMU is in use and the oversized read crosses a page boundary.
+	 * Work around this by always leaving at least 0x10 bytes of padding.
+	 */
+	desc->buffer_size =3D PAGE_SIZE - offset - 0x10;
 	desc->buffer_bus =3D bus_addr + offset;
 	desc->used =3D 0;
=20
--=20
2.15.1
