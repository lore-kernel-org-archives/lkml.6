Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246467-2-14190038960628779111
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246467; b=gYdxUd4sp/UrXC8NhaOSTFaYJbEIVx1obGmMpDbylhmtInzQ7j
    uf4IbaYo3/LY18RlJDpCMf+OkijNpQpFVm60dyr8tnW+LDTLgaEXxHe/bGwAkI62
    p7sOsXDmSCNfi7i4bDWVSGtz65Dm0hIaAuhSeDs55cC1/A5+h7up/75E1pm0pS1L
    d5tJzxBlAgbZYIpV4ibEyvhJbHN11RFXfwXqqOW11bgJ6ENlV6qJXa6VjFQ0Wxk6
    kTW2tvq5VETF1f+YTwjT/igdvxkUmGLFtBQL/obHoib01lfJqmL7+8B7Yt68lRTx
    zjK1xwp6wOoiFvEW0XD2D6koO/ouuCxrww0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246467; bh=NVdslaOFl7
    DXblFhtaOiH7vOpo9R3RS176rq1db5QI4=; b=axqHn4ugkpDdXJX57kbfCqn39y
    HD1G4oD6h1OKVj59rTBJ0k5Gn/xJbSGpIZbqQRQh8M+R4xAxCkq3TskGUAwMvcGF
    1ykgg/aYC3eaP/WA4zb9WBpvXAgSHX3zsOYmPKFjCw/JxMQyyAnyTx85wB+PIyOg
    +rJtNChBxFgeuyZ3OtnGYljXKY5kfGdugZZCI96+XOKQ3UaDITZv8RtOwz0LfYQK
    QBrvdik5Z16XmVfEiuE/PcGdUMwJjrhpU51qdybIYmPgvfl0r94GaT1+rQsLF5+z
    Mi1kus53HbEuaS5EuHSVdwPAW03VIJDZUbKyDLUFo4nm80RwNVCpX9l5ZuZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hgdrhbju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hgdrhbju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKjs+Ri3U0+uTMBokv59OZEjFMeGAoUO4UrvJ25dT5D+Rs+xj32PV1kIpwwmqE1CnVXKreX3RXAXEVCuKsAQAWACrDWtnWwqilwHyBw5pvtyBq17iBVg
    4NDPHrB3l2lH6x7S8CnJhAZqfjGgTg1zQIKlbFV2KTFnhUyF+cMKX6k+SR1MwZjZPANyTq9QHMiuqcGPIZJZwbNcdITzWKH1tBXYX8zZ24WuXjoxziAw7WbX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=gZW_3bEixuK0yuQyb0QA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDIASN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:13 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753398AbeDIASI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 055/189] kconfig: Fix automatic menu creation
 mem leak
Thread-Topic: [PATCH AUTOSEL for 4.15 055/189] kconfig: Fix automatic menu
 creation mem leak
Thread-Index: AQHTz5gl1XbFDKRES0eyrQF4bxFm1Q==
Date: Mon, 9 Apr 2018 00:17:29 +0000
Message-ID: <20180409001637.162453-55-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:owmwSunMa7e6HEe1ZL1JwWCC1S+J4zfJh6VkLSlU4E1wpo+MZ4rghWAZgX0zHRBoVTYJDZWGhk1TJyLfPFDlQRvY201e7q3iDMWOcRjJD13DQFf20AIVdFjUd4euTShosZXo/9x97NVJs0/RCJhz8JVifieYnhKkCeKFiMHS1AOmZB0Y03pR4xCV1b7rrbbBgjiE1uqNmjUNfIQNUTGPwkSWHP5mDNzqNlTWqNsbggupmy3VcDUAm8WvGMHs+91T;20:zNzit4MHU6KY1JcyDF3sDZFiowGPZJZAyamBukeqSJCxggMs+k445PbH/5hx+dyuRtjs59TrCBVmUX+EOzveBKQcB6bF9RxME/ToeKWlIkLz4hBShiaLAE8xfY0orJonLCIZf2WycwLoVLit4yS40GtmZliQCyZUWQmADf45e/E=
X-MS-Office365-Filtering-Correlation-Id: 1a3abe70-366e-472e-57fb-08d59daf5707
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10463DA4DD1F5049FFB91229FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(39060400002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +UiJ7KM0ateyizgRdaWMbqm/5E7I3kuVnvkChL2ExZntokVCU1PiBkD6iVT5R44J5ESssUuZxMQIYJg+X8qTjsmwL5BahhgcDYypkWUPnJhRCMtCgWI/q1qaEEPIw1fQ5/74wocaWH8UtK16HY7hvIYzqIDNeMP932835feyLkYCzkMA3NM0ZA9ZRrAGVWjb2HBnximm9dUkH24c8v7R1NI+EoCK2M1ha8kiD9PrnnfmArBkdTELjc3H/B0xC2gEsAh0agybYvIltjfkocd5j6iWf6CKJzbqLZ2f9/L2qsA9DuC2pVuzRwMEDv+kvaBb12wPeGHoyt8hplg7+6GBhYbwERrXJ8UQplPU91J62b5jkpwlBVSgytZsIU3syLGG3isZSyVTiBJXIk28dFsGLdLuzruIjqQvzVUnnPpE2GA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3abe70-366e-472e-57fb-08d59daf5707
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:29.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit ae7440ef0c8013d68c00dad6900e7cce5311bb1c ]

expr_trans_compare() always allocates and returns a new expression,
giving the following leak outline:

	...
	*Allocate*
	basedep =3D expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
	...
	for (menu =3D parent->next; menu; menu =3D menu->next) {
		...
		*Copy*
		dep2 =3D expr_copy(basedep);
		...
		*Free copy*
		expr_free(dep2);
	}
	*basedep lost!*

Fix by freeing 'basedep' after the loop.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,376 bytes in 14,349 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/menu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index e9357931b47d..749c2bd5fc51 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -372,6 +372,7 @@ void menu_finalize(struct menu *parent)
 			menu->parent =3D parent;
 			last_menu =3D menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list =3D parent->next;
 			parent->next =3D last_menu->next;
--=20
2.15.1
