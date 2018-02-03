Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682579-2-15413849927290697758
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
    t=1517682579; b=jcc4HJfwAxkyJqtnvloiW+gvx3V7xOjQNgEXlEl9J1y1obk
    eWXBOi6t44i+jWW/JKODndb+O8xJtSjskYVzFjNt2EbV+yD2ZyPyb5v8My4cMzTp
    GuINU+Mzzxe23ncQyIiBzW5TCvlaKTb5uH/h9IheAW1CcWi7JuQJdrfRiRNDqECC
    5xyy5U5hVb3H2tLRfMVNjgXZMXw6ye3/F85iVSChPlwssdc4yms6nFTy6XoNq2Xr
    U5Ktc9lZ7DOJ5e+kTIEV+BpBAah4aDPPY+AdWyNfKCaa2HEBe25j9C+b0QVLXsjv
    /i052mPN4HsVopK/nHjUcl5KNrB2zkV5dHGtxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682579; bh=iLOm4T
    wqxPRrsuxXviozEtK9AQNRJx4sgHPnRbefCCU=; b=RIBjWWnf9BDJPtQK0E/98a
    bp9+lncnSznBlVsNQBptcVMMPqU+bv8BrmhGBPiQpLQNalYfn2eBQuePCcGVTEK8
    XgKOQPmeBTHh1ADRHDKxfcgE1+szJME238uSmmC295JqMDRP7t5FpnVSAjjVbWvL
    s09ShYFYVOUcyng9xIEsvwLFb124al3kf5JYIZ5kpc4gA4SKMeJ4UnpdbDFI7T7B
    5PnecRg8rqh8BOmW8LhOPBqCRNSkC+rkabZypDeGv0/R9ltfWd341DcE+vf6bJBE
    14OK4GnuvoYyAc8PZdGbqcmXvEqDz9M2xOKh4vGE2AQsHKIg6b7+o4+XaBivyswA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RxJFn0fM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RxJFn0fM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeBCS30 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:26 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753042AbeBCSE3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 107/110] net: gianfar_ptp: move set_fipers()
 to spinlock protecting area
Thread-Topic: [PATCH AUTOSEL for 4.14 107/110] net: gianfar_ptp: move
 set_fipers() to spinlock protecting area
Thread-Index: AQHTnRkHh4LV42k8j0yfji4hajZK0Q==
Date: Sat, 3 Feb 2018 18:01:34 +0000
Message-ID: <20180203180015.29073-107-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:sXFvkxCDRq383VAeLoPAM+YCiDd2DKAdbTygXhl6B5kYCYdZSdLbpKrho0F6KALVIo4SOmtIVr2D25w7IgeUl2oxnMYv5ziHIp/l3Vdmd+h0l8bgYtvWA0+YVm2FxkvoOmxwA57UODBcgzObDyHt45dH60JKoPvxFrWA10qzLuOffUwWCHLdjRWJyhSasv8g492TskrJajA8ooYhFB3YfM/WI1/Ut7he/DZVUMpvYBwxAL82UbMbg4Sz25ShZO2C
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cc070e6-246e-4975-d3b4-08d56b30595d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099394C49FCF1C6441BF42EDFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(8656006)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KIqbYHMsVEl5pcbNS9qAHoy+2HM/SZoTARoQ9ecjcHeiKiNnoXvNedcgdmpo8gGjyrizW1sA7eUbHTirc/+FMA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc070e6-246e-4975-d3b4-08d56b30595d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:34.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index 544114281ea7..9f8d4f8e57e3 100644
--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -319,11 +319,10 @@ static int ptp_gianfar_adjtime(struct ptp_clock_info =
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
