Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KY9/i6mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEA020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLDDRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:17:54 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:61216
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbeLDDRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic4V6FJTATLKy0BI4Hp7JaQWwvug20AlLHL0Yntou0k=;
 b=KY9/i6mb4kC6wbO0yFkaR4p4kfI0l+TXqdCvBdfBtLYQ3ezfJzNTEo4V1kvA0B/OWeEWIlQKUVV3y2Skx2tODOfUc/4b53ihGHXhoPheI4VebFkJSHSXjfzbe7XglPWYZe/eAhTWVqYd00XxZR7e7Jl8uXHnBn/FfUYaBYiKWEg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 03:17:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 03:17:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] ARM: imx: update the cpu power up timing setting on
 i.mx6sx
Thread-Topic: [PATCH V2] ARM: imx: update the cpu power up timing setting on
 i.mx6sx
Thread-Index: AQHUi3/sG9Q7quxpRUG4P7UHstH/fQ==
Date:   Tue, 4 Dec 2018 03:17:45 +0000
Message-ID: <1543893119-3716-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:kmYEOwuiqJDlRZ8zJxcbxo9c5sdROWQpCOjH+SmbITtiiFDa+NfBgEJv7+YKbkC8bZGMCaV0bvBQqPUHTwhIzT5gOsfZpKthxU0nwth1O64pchbi4OSzRx6Zc3pdV5ov0hz21R4fd2vKKXzpURMDJ9ZzACjDHu8tK1Egk5WhOEhL131aJpGritOo64t/R8GFItPlgfwGxegMPkN/Xo3t3xMvmbbwMwHoKpB/VdkI2KgLzHsNVUhe+NAnRiiBxw+zK9++mGO9W02Pl58DqIchJtDUMzq4nQpZwK+oeACbpiezaH49Ku+kk9G7MefTq7PnqQjlooh5FydxqooD1AdpiihZBcOFWftKsZ65VenVlRdw6q/pZbI/XikScChNr3d1M95DJjJbvI5nAoK3/yIbU0cc2fkVCXGtMR26n9i85XvNmSjenNFgzGUAUYSQGyYKx0uiwNIQBKAR7uV5JDlEKQ==;5:AwlHr7m1M4WmN0zy6BIT6VNBv4Z4s50Oi87jZuvu/D0YpnR0mNQs+I7HdQB1RtA0KhGh+nuQcY0I/EaC2faFRQMONGjHX9Yge/martz2qqZL6AoH0/8e6AjyJHsNjqE7XBlmMcsqTidJF/GtfhovZCPCKdEnH2PlvvFzEGfuQvo=;7:ZTd/ngzSyv4IC7cmvnEISgy9wKVnL0eZLZIDV0EIhtE14y5y0B7yBtowrMHGdPq2eZyv5WVTYlfhbvliMDCnw/fI07cVUzINCiXmXKCHgDzSaxguEszrM5OROeM8QX3nrxywfhGMYKw3UX6uSMG7nA==
x-ms-office365-filtering-correlation-id: f6d0aea2-75d9-4006-123c-08d659970ed7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB375407CDADA8DEA64C0B8DA7F5AF0@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(52116002)(305945005)(186003)(2616005)(102836004)(66066001)(105586002)(8676002)(6436002)(110136005)(476003)(8936002)(7736002)(106356001)(256004)(25786009)(6116002)(486006)(81166006)(6486002)(3846002)(14444005)(53936002)(71200400001)(36756003)(6506007)(2906002)(97736004)(50226002)(68736007)(71190400001)(6666004)(2501003)(386003)(26005)(86362001)(5660300001)(316002)(4326008)(6512007)(14454004)(99286004)(2201001)(478600001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7vySBlKdqfaBqfdHxp9urmvGG9fcSJPexzBJ1awds0vybqnGYsRSeqOm0uGuc5KEZwHZugq2+k21BY4pXFhS3zAwDjVeojEw9lKNLWGdQapammtHB00pgkNsWFfp8kvJoOlS5iR/f+YfUS963YyuNcRZLVOG2mw+VTML+SfEEvbzHz1T9piWWuBivvCuASvxAE+f0etqXnxMn1QI1+rgbeSqlx4iTB6yLNHResqyqsEbMALwspiFNurAXPs0rxdLdaBm32NNtNjrVXAt/C2chxC+rcw9qVXsFtgFU0Enb/4aoIM/O6e1tIiM6HthMJwUyn5szalH88mm8LEW66ZSsKVid4x8cQ+yFuo+xl5AZHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d0aea2-75d9-4006-123c-08d659970ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 03:17:45.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sw2iso count should cover ARM LDO ramp-up time,
the MAX ARM LDO ramp-up time may be up to more than
100us on some boards, this patch sets sw2iso to 0xf
(~384us) which is the reset value, and it is much
more safe to cover different boards, since we have
observed that some customer boards failed with current
setting of 0x2.

Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6s=
x")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle=
-imx6sx.c
index 243a108..fd0053e 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -110,7 +110,7 @@ int __init imx6sx_cpuidle_init(void)
 	 * except for power up sw2iso which need to be
 	 * larger than LDO ramp up time.
 	 */
-	imx_gpc_set_arm_power_up_timing(2, 1);
+	imx_gpc_set_arm_power_up_timing(0xf, 1);
 	imx_gpc_set_arm_power_down_timing(1, 1);
=20
 	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
--=20
2.7.4

