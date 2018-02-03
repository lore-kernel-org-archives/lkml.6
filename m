Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681323-2-5009807657482610956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681322; b=Njsm2R4td3VbtBrMkc42FA+M5hlB58nQK+hMAyj1NSp6l5Y
    /xH6RoMNsuleEaPpUKRPow+OmTKR7jDX1YJL3QfBrMDmbFw6rxzsMb2ArK/E2IiC
    o+FApFlZlatGzuCZYBXfvPaFx/5mtDkbzZKNMv1EcyuTVmnqVx+t7Fp18sdClsy3
    Wl5C/ENnWOQeeyArj7FoxKNqounhGUypME6uZTgpnxlIYlw/rxQvV3dXGkw64+Z2
    2ouXzmPYBYL29F7XjA0SCNvQb7jn8kfWlBT3jQ5wOAv5dmgTCkxIs5d70zvPlrmN
    VzyfH9o9Rh8JFN8FGdtOzY/bLc4d49gs+MgyxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681322; bh=pupTv/
    o3Ek+d7yrf5bL3gNXCSO3OzAGnZfzT4solJ3U=; b=W1INLkcBcSP3WRBESG/UMW
    33qkzG6dEfeJeVtkgPycOsk2VTanqyuX6RqNvRtV3XylOz+cmtwPUH4sPI8rOjMh
    vUG8Es/TsiM+A/I7aiWRT9NBVF+7sU8/JnWLFkK7DC1Pp9eLakb1/dJdapGC43i3
    QCtNYSolKPwkenLSP5FPIOtmLb7QeHiSoIHVi1qpA5HKpZ5fEEHKHQg2ndV6J4NH
    7sSWXymnewDM1qo5hwziYx341lISh9ar/NwJFf1L5uX5xuCkZeNjBhpFRsjGmHUI
    4aNZwBifWsAikAwYXVEdCWPRUeeSQMWo9/lOG8WM1MFDq5Lv+1jNI4beDL407AXg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RtKz7sVx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RtKz7sVx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeBCSId (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:33 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:39758
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753589AbeBCSHa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 24/24] net: gianfar_ptp: move set_fipers() to
 spinlock protecting area
Thread-Topic: [PATCH AUTOSEL for 3.18 24/24] net: gianfar_ptp: move
 set_fipers() to spinlock protecting area
Thread-Index: AQHTnRmIFSnAfTKoVE21RIYIxSBVKw==
Date: Sat, 3 Feb 2018 18:05:11 +0000
Message-ID: <20180203180444.10801-24-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1025;7:xNz2InFqrdN6jo9oLQ+AGmK+GRywC13yyN/MAIwuSPKkeYkEU3IQI04LMzpn4kgPeb5Y19ZwcU+JTHtP+qawMOMFXLuPHD3Bf1cOa9UGigUtgO53m2IkAyz47QFcYTO9EqD810zE6EwlXcJy3mZd82Sh0WNxHEakMzMbGRZU5WCtqEqQbWpBW9D1Pc6U3Pg/oLCcPI/LZkozGV77iDaB8W2FMVnfW59LACV/gOZUFMVfVta3UyoiUXd3T7wTBO8k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7092f93c-d53b-41c5-5225-08d56b30e486
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB10255D1ED23883739CDAA553FBF80@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1025;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1025;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(6506007)(97736004)(86612001)(6116002)(3846002)(1076002)(59450400001)(76176011)(2906002)(26005)(6346003)(68736007)(102836004)(186003)(72206003)(2501003)(66066001)(2900100001)(53936002)(6512007)(14454004)(106356001)(10290500003)(25786009)(8936002)(107886003)(478600001)(6486002)(81166006)(4326008)(81156014)(8676002)(5660300001)(5250100002)(2950100002)(3280700002)(7736002)(305945005)(36756003)(6436002)(6666003)(3660700001)(105586002)(110136005)(86362001)(316002)(99286004)(10090500001)(54906003)(8656006)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 9iw+gDouEq8ZQo3lxBHaOFmm68DBBv0fOuIOB0zM7fBGVW3gnRVuMuWoToPIyqhZDqaXjQrKAN2pOFXy0l+v/g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7092f93c-d53b-41c5-5225-08d56b30e486
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:11.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yangbo Lu <yangbo.lu@nxp.com>

[ Upstream commit 11d827a993a969c3c6ec56758ff63a44ba19b466 ]

set_fipers() calling should be protected by spinlock in
case that any interrupt breaks related registers setting
and the function we expect. This patch is to move set_fipers()
to spinlock protecting area in ptp_gianfar_adjtime().

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/gianfar_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ptp.c b/drivers/net/eth=
ernet/freescale/gianfar_ptp.c
index bb568006f37d..503991823551 100644
--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -314,11 +314,10 @@ static int ptp_gianfar_adjtime(struct ptp_clock_info =
*ptp, s64 delta)
 	now =3D tmr_cnt_read(etsects);
 	now +=3D delta;
 	tmr_cnt_write(etsects, now);
+	set_fipers(etsects);
=20
 	spin_unlock_irqrestore(&etsects->lock, flags);
=20
-	set_fipers(etsects);
-
 	return 0;
 }
=20
--=20
2.11.0
