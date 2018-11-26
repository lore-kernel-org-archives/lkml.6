Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BCA20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9IunLU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BCA20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeKZNwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:52:31 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:57305
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeKZNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwGSA6oHTM0zZaQag2fxBLitVED3Yr+qg39o/94xKo4=;
 b=Z9IunLU3tSxwIIhpnfzYVR7dW4C8qMhzmUHW6WhWhZy9nquUr9jYux/Iiw+rBO/tUXqucahYMRW4PPiEijnI2joszDP7kViaW9JWu+EDwn5G6OTjZ+LE9e9QRuUuYJzSnJ4JLRRidRkkfggCFAhtyhpIi/Kr0EqkKQAizcM8ZK8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 02:59:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 02:59:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] cpufreq: imx6q: remove unused code
Thread-Topic: [PATCH 1/2] cpufreq: imx6q: remove unused code
Thread-Index: AQHUhTQWmmMVKzplmUeqXFokY2bfOA==
Date:   Mon, 26 Nov 2018 02:59:45 +0000
Message-ID: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3769;6:w9f/f9Ed3llb4mvRgzHPosKXD9mbshggMGZjJ8b+7f6//B38TvbgxaQPIgYMihwigXgh9lwtaOvO6AS7JGFY5Wk8+Hjlm2y3GiFke+AwIs0Ya7vejCt6GQZN7sPOGTG5mbhsmo1vCNjcR96Qq909jkLTfdks4I8Ux484dtrK4EGSdqHijESBr3kQBvLLRdysU8I3pCqkW6FzcNt503HZA3ukPjwts5Qi8m93rbU2h4aYih44jYrn8a97qp+LUWrMkRgeIQ8sN7Q1N4yt2VsYiwNWfYc6uYssp8+ixXgO4TQ03x0CnHTFMPXuXHop9LkJAieAl8bBooaKsCMT+IV6vLpsWIgZN0/j9z0LOhPe4a42xhzXHTjcTuj+Y8UoRbHhyig5IkoJMbq35FAU7QKtm7BY2kZxAXfXI5nXVv3YQnGbssToun4DdyNN9UTD5uFUhmYnsjuePQM3wB70eXSvHg==;5:4wfLtrkUc4/4oRkc9mhDE5YDqx2blLMtaqZngG7kmVMnwQoF8fX7FoDuKTSPW5YiZS5ntrAbbYN9FFEDwq+jBbzksiLFqEXINYgyTQhlATN0iM/C0W1Q6b93s0VbCMkj1l1/LQEwEr9wvsuwsm+0YyhiCSw5vtd9vxohyDL9ft4=;7:uEQktd+hxv1USa7d1LGKGDFzBfVXVV2NS6vBJFIGW44CdV8Ij1XmfoPVjrQd4omGWQ1iSUY3iDvUlmL4vhYA4igw5KCZQ7Iij6QHuF71N7cmFm59SORbPDvpRbExCdlxAXvcMcrLxukJZ+G+dJypPQ==
x-ms-office365-filtering-correlation-id: fba74431-feef-48b9-bd7f-08d6534b3836
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3769;
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB3769539E6B3777AA9DA5AA48F5D70@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3769;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3769;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(110136005)(316002)(25786009)(2501003)(6116002)(3846002)(14454004)(36756003)(478600001)(97736004)(81166006)(81156014)(8676002)(486006)(66066001)(2616005)(476003)(50226002)(6436002)(71190400001)(102836004)(53936002)(26005)(186003)(5660300001)(6486002)(68736007)(4326008)(2906002)(71200400001)(106356001)(99286004)(105586002)(52116002)(6512007)(8936002)(7736002)(86362001)(6506007)(386003)(256004)(2201001)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NIs3FIdDU42MjiiaqRt2MLQ/9tporfLPVw9/eXameXztVGkBPZuktLz+L0HTfpAHVJWBleVjhLXIbhegTPq8qIUXeuH8nYC4qP6FtatBCq54lg8m5JJ8lS23gYzOtaXCDYo27xP14eHb02mL/Y8w1gnas4Xi9DR+CEza1BwC+zXu/15ysBci+A9Iin+K3z0mo50+IyY2m05HrmOPL3yo+kHzAQNB7f4s48c2cjYy82Ja513f+00Vlog62UvPGnhtX0fW8QBhL56/NyqPngofOU/+yQQHhIRg4H5pGNAd3ZqHta7vjNUUMpfOTsoPufnJNsvA4eHdvx8l9EAasw0l94IZT0+/1KSwBXmbEZaB0qg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba74431-feef-48b9-bd7f-08d6534b3836
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 02:59:45.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In voltage scale down path, the return value is NOT
used at all, remove them to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index d8c3595..8cb9683 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -177,22 +177,16 @@ static int imx6q_set_target(struct cpufreq_policy *po=
licy, unsigned int index)
 	/* scaling down?  scale voltage after frequency */
 	if (new_freq < old_freq) {
 		ret =3D regulator_set_voltage_tol(arm_reg, volt, 0);
-		if (ret) {
+		if (ret)
 			dev_warn(cpu_dev,
 				 "failed to scale vddarm down: %d\n", ret);
-			ret =3D 0;
-		}
 		ret =3D regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
-		if (ret) {
+		if (ret)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
-			ret =3D 0;
-		}
 		if (!IS_ERR(pu_reg)) {
 			ret =3D regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
-			if (ret) {
+			if (ret)
 				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
-				ret =3D 0;
-			}
 		}
 	}
=20
--=20
2.7.4

