Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681909-2-6398942649213084124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681908; b=q9uvB04Drx55fnSsnb8yQOynIwKjJZ6n/IQDYhIb3G1aIWB
    PkStWkce+OjOomWbXzliP11GpBmfcNT/eKMdVi9N3NNJalXFwug6UZOBYOPfBuIN
    w5w12Z4qQN8EHLw8V39zgrMy8WyK7+NgLKelmn40vnmU2/EebzKEiTz13nWklhgu
    W2zXgDF2ICRcS1Qh7d83EeyE0lYuQ2M6J1AYa8l347GoeXiMEQseuyA1Sc0ODEHx
    7YNocplO45Rsp/uWVPEwMPUFYUzR2REBebtN4FAcI4qBILsRAh2aXtMAjyRykyO1
    SsOrBG4xdTSyNcrm5uUpzYplLHmBm4ltwJJ9h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681908; bh=FhH8SC
    ek8MdnaupsSwte+RJsCEOnvpYsHBJGFf7JxLk=; b=HiCfRGMLHqLrwu1osrqel+
    V2+ot/OhC+tQj7TLNr7mgdhV9Mgu9wI8swK37mzn68P/8KCuGXXnGEt+fm4780eF
    ZUH7nGqn2Eeh7LIAMP8ezPs0mOCqT6+e+cijW0O4Skoah/RHoe/AmG1ycg4yaOCP
    ZmuTQGxIgfxtu8FmWLR2YwC61U8Tz9syRYaQY4uId47oEVXBlCCC7KIiGDnkWUZi
    pZXdfIn2Wg+JyDyINrgRsceD03hr+ZEH+n6rYP7B8Y+E78SPLlRBHH2ko0XTzW2b
    j7r+6IuP+puAXmqKZH9ucuWB/zRxOFyjOcHsVvUSLvHsvYRHLzEeHOIC/NS/FVJQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3rbwzF/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3rbwzF/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeBCSSY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:24 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753501AbeBCSGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luu An Phu <phu.luuan@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 44/52] can: flex_can: Correct the checking for
 frame length in flexcan_start_xmit()
Thread-Topic: [PATCH AUTOSEL for 4.9 44/52] can: flex_can: Correct the
 checking for frame length in flexcan_start_xmit()
Thread-Index: AQHTnRlcKPZ8QFqjnEWewwxnHTihLQ==
Date: Sat, 3 Feb 2018 18:03:57 +0000
Message-ID: <20180203180303.8490-44-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:JLQ1ygqk7JP7MLhH1ChZH1G0YDOVnH2l7sz5OJf9Vf5vtZGELhRyYoiCvhLxn7pI5Ly8pnVJOkA5JCE/atn74hks+wLBrkOZASQvET3pjzOG6t0y+NsEQ6qAOfmkWu1ppjY7WQdHz2rr1jtjY1CbbhFqGqJdlfnKNc36AKb5QqFqDBBUN+sDu6jdfXpKebS/Raf6a9Glc2TAOdInZaFC5xKdAzvfN4rL5n1sbiX2P1oIGtjaFv4Nj/IvAqgkb77k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea0a7e37-db30-4880-281b-08d56b30a1b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012B905B5B7C1F3C12FBEFDFBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(8656006)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: j2JXldH+E+l/gol2DkGJVagNWwHeJD6HgyzrWVA2rng+20kZD0OJbSdxmA2L3DrBpHQDedqgr+2SnSkNmq2sGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0a7e37-db30-4880-281b-08d56b30a1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:57.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
