Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233161-2-18225681677626845458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233160; b=XAZUYztsXokc5kkJsQxEdjmcPCMgM4RUnWICOxRdpblsne+TU2
    GNRUQA7GGp6x54khvPBXPjaptOaDlz6J/ta81HU8fqcfpov4yd3l198I8WcLgQmP
    c11cvZI6qsAK64yApWMgT7fQVUZ+LyvDtBCulwtVcS8Zp/REaT2D89Dg45uS0oNi
    8/t5peB4iYiW9psfLh/h4tEMm9mcMGLNOeSzl8/luD52Lm5ZRBg5gCAAprjk91tt
    7K35ZCbRzga82dqPAECPZz7djGW1Sd4yhaOw9VWjWR8N4JIVBk7yPUTHjdQVBXCD
    ZmNL/jWspzi+q6nliu6+ngcztXcxFcjC6zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233160; bh=7DerXCw8pX
    h6izxPUBPmDoLtMJdHcLsTsScrTkweU0k=; b=U7NT33bYjVlbhnqvi09JBgHSGA
    I4r2+tscogmuId2dH3ZBdqb7V9R2c7rtE70KRUIqIV0Wv8jZORFtwofDsaahyJJx
    OzMNgKJ2hMtWz3mMkIp67aTRsY2Q8AvfoN0CMUOf8+qxqMncdHfJqnhOg4ZL670x
    9vbz2vxEFoHk57D9k3C7kivYFd2Ify9mozQpPT+l76HYpulROCxdlVW/hooc8cXV
    BY3XWQo/Q0EBJJKvx/Z6wesEEPYhLgC7Icni7D5bYmDWuOpGWmEunyBaYT7cD/RW
    UZFtGV9zmmpYqcvOOOih/f48BhSB9NNErzEIsZ07jQZ3+GVcxDrHRLJfaEfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ScxK01my x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ScxK01my x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHO0nFzwMuqwnx42HPWaejVZap9mL7YCBolXhne0dMR7nDUh2rgBsssb0rznG+jOt0O+H2XK+Nq4vbFPnJ1IGfwz/mZNV8XN5JZ5l3M2/iCgUV4fM9Y0
    uGA9ctlRjQgKflmd/NxnSMLvj2fZDSGk0I0T3oiKlOYS03rV9j8Sk7qTVARbhWVwL0tuOgm970GSe6vormm7d6wdo0eCj4NmCZqL2Yhh2sYarupASk7yFkI7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=n2GhSfulAAAA:8 a=cm27Pg_UAAAA:8 a=ag1SF4gXAAAA:8
    a=yMhMjlubAAAA:8 a=EZtTqvFjjNeZs8embs0A:9 a=wPNLvfGTeEIA:10
    a=9NqWk_7B-uqI6kdQTXIl:22 a=xmb-EsYY8bH0VWELuYED:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeDIATT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:19 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753783AbeDIATQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ivan Delalande <colona@arista.com>,
        Travis Brown <travisb@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 091/189] lkdtm: fix handle_irq_event symbol
 for INT_HW_IRQ_EN
Thread-Topic: [PATCH AUTOSEL for 4.15 091/189] lkdtm: fix handle_irq_event
 symbol for INT_HW_IRQ_EN
Thread-Index: AQHTz5g23wHfZb07ekmn4h8hRI0mYg==
Date: Mon, 9 Apr 2018 00:17:57 +0000
Message-ID: <20180409001637.162453-91-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:yg8MyjkbSBiW6EfwdF8gxILv0BWtPOOoDAv0KEZKJKxmTm5hdGkwsCewgunCzyQtRV5LkrreUw7AqbDB9QUBw0NFdx7Rl6tT9pp7QQrC/Xw369+YBkKvPtTlHWt8Y9B4VlqgKhyE84D3HEZPMnOpNyr6uwH3sQ1ri5H9ltMR2OE3mPxkj+QtgxkbCkk063aDiZB5c8nZH2XaHQN0NfRBgqPXsgqPsh0r5mUrC2nJMq/HhGWYFEywPP/GfKE20jd/;20:nIUOaFbO7ShDcGTDiB42v6IIx89sNqRI68oZ7csF+++2vruhZ++5VGynHwx9utivmigYoLFDRFHqd97j+LATVQNCnoH2VAHb8U7W2m5Yij2Di/UADo31YkVo67ZYm1wZ2EXEHyPhamG3VmOda3FLc5DFUfppSyfvIuj5PKMsBjQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89adf76d-e15e-40f8-a1c8-08d59daf864c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063CEEAE01FEA154E8000C4FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RxjyfFQrJjz8ezQuprdigFMcWjx48SjTqLMo3OVzbOxc2nM/yhIi86J35oAoegFr+KePxyzdp/5d+u9bL/ON1GUuzOsuSHnFWqQEsKrhVZ8DSnGsSLNSl8JpKc9bvUJioiJVoSM1O6gglg+mV/KtHuuqFWFRGCWkoET6WPdAuNoZeGLiwSixQdsxyFGqsQg007XXZeuR1OOPuXHv9qIRSBRThzHEjoitNP2ReWTms3AAkWLdFf2j5fZOER9twwIBLqS/wL8hr61bKO+B6x33HodoDnbSZTNV658RARfwAtum3sInrMpMD6ytQZIehqpzyAvoD6CSy/J4WjqLdA0t6WLg073hqHqc0EVO2RYJ0EMCJQN0qIMIWANSkGD4wd0W+3ZYNlEM6nqsCwZKpPawz5aGcJBhaf59VPPPonJs/Fk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89adf76d-e15e-40f8-a1c8-08d59daf864c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:57.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ivan Delalande <colona@arista.com>

[ Upstream commit 5be2a5011c039506e2862650c928acfb2e3d7b9c ]

Function handle_IRQ_event was retired in v2.6.39 and replaced with
handle_irq_event but nobody changed it in lkdtm so INT_HW_IRQ_EN has
been broken for a while.

Fixes: 33b054b867b8 ("genirq: Remove handle_IRQ_event")
Signed-off-by: Travis Brown <travisb@arista.com>
Signed-off-by: Ivan Delalande <colona@arista.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/lkdtm_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index ba92291508dc..4942da93d066 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -96,7 +96,7 @@ static struct crashpoint crashpoints[] =3D {
 	CRASHPOINT("DIRECT",		 NULL),
 #ifdef CONFIG_KPROBES
 	CRASHPOINT("INT_HARDWARE_ENTRY", "do_IRQ"),
-	CRASHPOINT("INT_HW_IRQ_EN",	 "handle_IRQ_event"),
+	CRASHPOINT("INT_HW_IRQ_EN",	 "handle_irq_event"),
 	CRASHPOINT("INT_TASKLET_ENTRY",	 "tasklet_action"),
 	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
--=20
2.15.1
