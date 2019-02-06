Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C6AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB4A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M7ygt/4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfBFLwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:14 -0500
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:41348
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730161AbfBFLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS5ykjJeiUZQDGumUUC1S1ZOJHVOLVVbm/bAl+QLUdw=;
 b=M7ygt/4H+Uefx/az0LKqdFUe3teN+eJolmxL2X3HkvSqwvcpe5zer8LA247R0HOWpAhQLZoZtBoWCSuLFfKt4RXQ5u0oJ734rk9J1wJnOwrSPSArtMexcOAi2hnZZbgpMHJU2OEDqliw/bzwt/MgX2XoXgVmVKmoM41SLgPp/lY=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3871.eurprd04.prod.outlook.com (52.134.16.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:03 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:03 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 7/7] staging: fsl-dpaa2/ethsw: Check notification relevance
Thread-Topic: [PATCH 7/7] staging: fsl-dpaa2/ethsw: Check notification
 relevance
Thread-Index: AQHUvhJfpf/5/T8ctkOGAp55+n8WCw==
Date:   Wed, 6 Feb 2019 11:52:02 +0000
Message-ID: <1549453888-24593-8-git-send-email-ioana.ciornei@nxp.com>
References: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3871;6:xk0guwGBvM8qYRNdBdZWRFTpLK62Nx2f5DoanwVyl4OZpRzA+Gdx4TE+/bq1OZFSlyPqUiOp0qQFO/Q7IaCW8wGosQmV2IPwcRYQ524a5Tmsa5C0jx7nYvGENgx+42yNzL6LirICPMGXLuDFTrhNhxMOaBOwI1rxr3OdqkbcNkh+Nzceoy+FNAiwAJ6p2HyDXnblhdiihPWy0ci9SgJ4SPeHIKoM+P0NkNUFt0roqrc0JEAHHrGeWFC9V6q1hmxG8Pi+uvYuIscLNeZE1slnhFcLkROWxqjZ5o0D9c+4xvufZl00Zx4BCK8wFTfWOmhht972LvXaddVrwGmY6Km4XlVsk7bt2O0RQGuHqjxkZ31ne8XfqaWHtvIk9GvFNtRh0kDAZkEHtgrZx3KpPUUnnRHYCqTNhkqFIT0YtyHZO8+OihvnmcNEbB+TzxlZTiKcJiIltrXkM5hjPlZAD08gRw==;5:qCdMEvQ1I4qIYIsAZCtNywFNmtJNovuXcBrCwfco7i9HvBjW5OcF5MdiLIdrbToWYJNTUBW1ZYegeqU96o72NNiKZPNd0ON6VxJ1NiGAX57uSo0fBZxci0oJ+iY0r1WKXD2W8eAGyuoc/+HJVs0gDwOm2kqVlpGuLbcZ3fYVVTQGb/8CaUBaCAAhP4uVt5IiEkvTFFGj+wbS/UPWnc8xVA==;7:iI02AaQEjnJuBH6Pg7sVn1udVheHKnX/muLVGRkhvIXD9P4LzBLEGPjbwTPNUWdOhXIjpdLC/OkjH9zuMIFH5rTmPODFMvkFXvXSnL2HW8cPa9rQUmJHrOinZzKYTqKIcU7X+MhzXgWvDg5FmFgYoQ==
x-ms-office365-filtering-correlation-id: d883477e-6afb-4be1-f3c8-08d68c298207
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3871;
x-ms-traffictypediagnostic: VI1PR0402MB3871:
x-microsoft-antispam-prvs: <VI1PR0402MB38713E6E18E59BC38A81390BE06F0@VI1PR0402MB3871.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(71190400001)(71200400001)(86362001)(36756003)(6512007)(66066001)(6486002)(6916009)(50226002)(478600001)(5640700003)(2501003)(14454004)(4326008)(53936002)(6436002)(25786009)(68736007)(54906003)(105586002)(316002)(52116002)(2351001)(106356001)(2906002)(305945005)(7736002)(99286004)(2616005)(256004)(14444005)(446003)(76176011)(26005)(97736004)(486006)(476003)(44832011)(102836004)(11346002)(81156014)(6506007)(6116002)(386003)(4744005)(3846002)(15650500001)(1730700003)(8676002)(81166006)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3871;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q1WdFph69WjzS6nX4NKg+Fomg1klD9eHxzdw5EIK3T9tEQZEGxnMMoG0nVYSq2dVXgofz99ZGszmTKO9Gb2YKcDfiQxMs7eQwqvfgFJXF6tjEeE1aCfK0raATTBD9z/w1wLBLMxY6XWZSyIncxDxMjCIxJmvA1H9GpJ9WA4vM9b+gvbTzog68RpzWE14czw1mSr8K8KAsO9NxZCiflfz55C1J36UOq6rp84QgPeh849Qh/ftUD1+ayWiHxRtJPwipdX/SVtWMB2qdbqIVq+0URP/mWZZufFLUAr4WalEvwMQxPupiPwn5C+VhjVVNZhYcmv0ns7+b6KoQ9IpSmMZSCbS1XHtAEZVPbnyS8C/az1A9t6/eJQxcBAR8xVxsBHaRTRvFjHpYl9xIDbmtyreaw9NghiJneBeZ6RBJCFqbvU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d883477e-6afb-4be1-f3c8-08d68c298207
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:52:02.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify the notification relevance by checking if the
device is a ethsw one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.c
index f179fd0..c5da40f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1063,6 +1063,9 @@ static int port_switchdev_event(struct notifier_block=
 *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info =3D ptr;
=20
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
 	switchdev_work =3D kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
--=20
1.9.1

