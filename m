Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682011-2-11067356643259581762
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
    t=1517682010; b=XxATPJUZHTcIT1KIoJOvHbQ7qFgjLOSFIYzxXglKKReGR+H
    pK7UJSzkiUvvQod9cLQdkspiiHi6DOb7Vh06xhUp4TermOBZs0HFR79mQ1KA2NQT
    kLSFBVj6++CisKKuh2yNXsEooox6tMThbTb9zEIcS9M2R0V6rX0fh8BNxVoOSUpE
    8fIB8mmji/d/MSZ7tjnWcy2Ls+/aUOBog1kJYX6WXu4BeGC7mMd9yFNnuaJX4owJ
    dbDpT2ygr6JoCHMssWa+Lltg489QJ731REaTZF4f8qh583llhh2a3Av9N8ZvLUkk
    a71BDIqFNhHavv5bHq9nkYwy+OoZ3gs9OdD99ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682010; bh=FhH8SC
    ek8MdnaupsSwte+RJsCEOnvpYsHBJGFf7JxLk=; b=pC0Zq6qgpn5VUKNu94j6VX
    ZnoOFKfQ0FMjIbtaqFkXxPSAQeKob6uzQP18ZCXLSUbaSxiQ1c08d1zmgEEBG90u
    lh2Fp8v4YQcLaN1Yt1q9Abrfo3nIot4PciXK1vXi3WGyh/93fjVxmbKN04y4I8Z3
    MjLjeZJk0H1zvjomuuvx8IacF/RI32h7hp1TaGuGz1ZqHBPrOScp34vUTqq9HwYe
    aHXZ/7knCyno26vMdL3dubdgPV9uCtTtgBble1DcCdozwrg8vOLFMH16IgChL7lw
    wOMjFKJSp65eTnulCAxGGOD0GsoKVAtQ+HTqDqr/A+lT5ApVlJWHmwuQjQP21Xcg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSm2aPP6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSm2aPP6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeBCSUG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:06 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:35549
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753147AbeBCSGp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luu An Phu <phu.luuan@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 24/32] can: flex_can: Correct the checking for
 frame length in flexcan_start_xmit()
Thread-Topic: [PATCH AUTOSEL for 4.4 24/32] can: flex_can: Correct the
 checking for frame length in flexcan_start_xmit()
Thread-Index: AQHTnRl03lvGa/gfzEK8jk6uYauM9Q==
Date: Sat, 3 Feb 2018 18:04:37 +0000
Message-ID: <20180203180413.7438-24-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:vfgkyFyFr9nOUxFChgA2MLTjVOTeSCRnfsKfqP5sk/IIdzkYVXbmuY4TbsxjZTxvph0eGuXbm/E4lRqRB3ZfNz03Toid20YODfBV+cw8zBbCzyclchPvTVaOz9H7OffEZTCeCSTUFz7tN86V+RLqKEe70doZCgiDZ0Vj2fUX1uMpjK9y3z/c4OJ4Xy3GrNi+0T6cSwyPpw/4Hve/COaRK+1lPGBHXi7F/X+2S8X412U3bqOsF0iJt1yjX3Pvr9JO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b35c87b7-e29d-4f80-dccf-08d56b30c648
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009184843AF70C844FD36A6FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(8656006)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: sK5u+fwgazwz1arC1EHCXNYul1M+NGvENwb4BhxeCS5/7c+Yuve76kNW1LPeVBy/a8jQ0GFysXdsoL3CqWI7hA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c87b7-e29d-4f80-dccf-08d56b30c648
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:37.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luu An Phu <phu.luuan@nxp.com>

[ Upstream commit 13454c14550065fcc1705d6bd4ee6d40e057099f ]

The flexcan_start_xmit() function compares the frame length with data
register length to write frame content into data[0] and data[1]
register. Data register length is 4 bytes and frame maximum length is 8
bytes.

Fix the check that compares frame length with 3. Because the register
length is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 16f7cadda5c3..47f43bdecd51 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -493,7 +493,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 		data =3D be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[1]);
 	}
--=20
2.11.0
