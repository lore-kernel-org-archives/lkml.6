Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA1ECE567
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C20208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cK/xO/Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C20208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeIXSQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:18 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:47088
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731008AbeIXSQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WVxVoObikgPBErnEfip6fb486AZvQIMhpMrmwjOyY=;
 b=cK/xO/KdI0AGGNDg/ce+v8WNQPqpJJkOUIlrz+wMsAZVjM0ouiThtAtGaf5buWGJoN96b/KsMI60vGXJlJIdcPBu5jJc2/VaZuU5zePtDXxU+ItTm0V/w8yICRU+z516I6WQqy3xMWjnx0IEuZ3tBxd7H3n1C3yny77BY+Iq7qM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:17 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 2/6] soc/fsl/guts: Add compatible string for LX2160A
Date:   Mon, 24 Sep 2018 05:38:57 +0530
Message-Id: <1537747741-6245-3-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c114184-2f49-4293-aa67-08d6221742e3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:KlHf8d6fPfDnz5fDvIouVhk1ldNiwAoKjnrhJG0dcpCg5/1zy+aDDtfw42MdGTNCq1SEZpRbllmBG/Jq2IfVubu6Zgn/XPdpzWjDAwJ0gIvvbzT/YJMCE9hWwGacVNG+D3CjmUwukWtgAeg9ZiBnWl70RJX+x10sBXWdTPw3FvzyILRgKSqpcbWwKG4wDDyUTFxQjkLIZ7ZUQOfESw0XnsCbJObWP28yLako2wAFZ8XMNsMb6NgVY6cUTCwP6u+F;25:MhLDcoBlNXWiIFgda5M5KdoInF9lChNarzxK1fYImOtGldEtZhMml0b5eruil2otGxJkBJzSA3Xw4x/S6asuTBMTKUXXkf4xxX75131iIVON4XMr5v0BY5a/igr+HaVZDUU730gkk53I45v+lq3kXo1UHXsY9bj1MqID/uqBLforvl0jERfbtrHsf96/wUJnaov/A2kexhoMIKtdve/Iw1ogT4xS/88wvfp5eIJgWNqNQXVfQplUYhuntIg7R/34yKIy3LGHfGwsnMMbpaufHGu/qpG5u3IpztkM/JfgrEnT1EoX/YDl6m0L9qKMU/1jkW/iGdzFLdmAJCYSlRoHyA==;31:lsQKX3yM8To92OpKCX+f/AwNc82EY+juo29aDpEOJioHviag976YtreUG+wXEXR0hOWYIuE8TGWvt0BzJQR7Wyy78cUgWyghF2xwU9BfXeILj0LTWJRAPjeIzDo9pWpz57fxWsK67wKftAOkgsHlq3tst9E0HWogoj8eWD2o37kl+e8CGV+LVR9bUHJI7TyyBbtDYGuKQjVvqIB5F8+4yRfSqXfD+ApABx2HnDwWA/c=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:kJiVfY0DwRPpxxHThraQ3Udnd0UhCSqYzB6nF8C3s5lZJo0a9vSOjBW8zm9iTLTv2qbU8N2eVxxGm1x7gSA/2Md0LuoeipMCMaEcwwqUENzvTgcJESonheh+ROkg7yxXpK+JNzpUbva6i3iqsu7Et/wh3cieEz8HuZTpkfRpEL/fv2y7ihEC4XboB41o3JZYqljqAfnIlVqEq3KxjnmmQnRtfdsijyv+SN2KKsq3c7MTQGljBZzJHCue2w3ylv+6nRtIQ7DmMEKeNcYLvn6EwPtnYJg6w5t4/40UQX+YNpUeDtCHeBA5pO/8v1UY+QR2a6JLqnkwrle0j6N2h+kwU6BFVSaw2FO1qHy75+rYvhRL9YPuDTBN50bwxia7/yPMVUIBAZRMCo+iC+5K2gEmjE8D7SrNbIkqlnmxIv+BZH3jE/0PpVF2GmDBZjB3WvNTjluPeXUMu2gbd6Yq/CFrjn11eufJJbAkF9E0zRAGOwaIEx69jmgwfPqyt51cArm3;4:MSqADt7c+XvRCGyjYP22erh42t3P8OUhU1k/I+nSTZdRwC7SjZLpS6kfIItvwGW6ctNtPlX91Gg1cMwpjf4LA4rW//rKmnlDaJqj85xLjw1mymgx4cX/yY/uL6hIltDAtXAipRVFHrJkLaFeASZVgm5FpNq3H2g/Dy+gk86HOm9PRpLtIiiOs2Yropg+v5DP72Gc2hvXtR4HgeXOVscNoWp9JGXLs3OkvZbN/ggDSf7V6DMAehgkXCIdsE9GyX5gFYVacjy8JxEie4A2uAiOJT1fg1ULLIAoagNbkBjQBplP7ll9Xp7U+6CfjNVwzmnX
X-Microsoft-Antispam-PRVS: <VI1PR04MB4798992088597A9C20791059F3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(81166006)(16586007)(7416002)(486006)(36756003)(575784001)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:cHKfGsbYIDTWPTbHH/xw//ZmqnUa97k2nAsKMizvq?=
 =?us-ascii?Q?KelFP2hVVuxmo8+PJcHPMOhQ9cHZzpnGFKmn7o3wQuhsMoT/ncgHX0OaLQW8?=
 =?us-ascii?Q?CKj5SXlmdPg2NK8tA6UUz6KGfWR0Hh6tHAedKWfYVN3/K5uQucKNbbrpwxgQ?=
 =?us-ascii?Q?/gTkOaXRtIPamBGT5SFSbOQ45HXtIoVSvO9SgYOqeyK06f/8qBdcd1fyq2rk?=
 =?us-ascii?Q?jlUFJsTU8MlP1HquqjSqIQ9qKM2aJWh0Nri90lezTDk2qsR9ZkJh37zzYDuI?=
 =?us-ascii?Q?oCCfquQNKZKp2Il81NmRk3VpFULmcSvS2lwfc8bwZ9geVvTKMDLjZRRIGgfB?=
 =?us-ascii?Q?j5GKahS5KTvcCDyuyAWsBBufaVAjjAZoXvPBXYkay9tRbf73JFJ3a+Sp1uH+?=
 =?us-ascii?Q?tqjUe0pp4OmAVrSbLpvvwpcIViO77kgVG7W23xl3xXoJDYzlzuQUQN1C0G6Y?=
 =?us-ascii?Q?8BN6HM7p0ifVTwgQl9zQ6m5PoCmeJzkWyaKljgJRugLVohAxZ3fitSJBAxFt?=
 =?us-ascii?Q?jqKLFdkwQGlznxTl3m246cWbrQ9Tpn2a3dPu59hOdBDopfbb3IuSaLsDBhvJ?=
 =?us-ascii?Q?xsnqLp4v1ObTPGHUTYC9fEmElzjlAAmreWHw7tk3kQgp5Q6RRxG6HYtSqiV9?=
 =?us-ascii?Q?33oJiYfdIidQ0oP3hqU7P7u8ejJCZrO5HSSPRBLPvqj56xo1kMTOsPurUCC6?=
 =?us-ascii?Q?1H8fmxFnqvYIbhW31s5nEi8NDUroVPAdg9o0XZ3gfRumIOEhc26+ttfIRQja?=
 =?us-ascii?Q?LbRa2DlFWtiz0fvMttNBbsakjH+1iTxf4onZOwadK9ouJ1YanLcktUhh6KxA?=
 =?us-ascii?Q?pvXja1G91GUGBFpMplFgHE9RzFKdolKi1jVyGXUpxeRs6fTbRkIpH8O+LFHs?=
 =?us-ascii?Q?+pWwOMVIberOx5SRmxJw2SHmz7bTn+di6/lARzfZ9xpZXyoehUQWn9aY24tN?=
 =?us-ascii?Q?8XDie7ll9ey8lstV04x5oRYUCtj1qpOr2BgWed9VwaRNE2CVTXgdgqopOHC5?=
 =?us-ascii?Q?OQzRw8Fa922x3T6t8ztgXcq7XWfZZljuFnmOFj5lg78hlfJIBAzl4hzhGNne?=
 =?us-ascii?Q?vZRSe7Uo50IG+hOShORJEyGFh+ruhcinMrLoH5peX6jDdqA2R3xIKP/1vrXc?=
 =?us-ascii?Q?rY9fGLwo5d9gp6MvwqoXV8RdX5pL5o3KCjzlOjy3w0EA5T0muCH/+k54ZdV/?=
 =?us-ascii?Q?iGZhGUn6GU7wChJjUuXjUyOorJBUFsqKWHqnnf7V3xJqhZ4K5GxjqGIBIvtM?=
 =?us-ascii?Q?j/cqEnI5hGAQHvFb72h+LC//DgJdvSvuzl9nOt9dpbS+8LH2F0lmBg6cHyS8?=
 =?us-ascii?Q?gg3Huw1HGuhl5GRuAh22ho=3D?=
X-Microsoft-Antispam-Message-Info: AzdiHj0MHzxzhtuiZ7afnOL5Esf+MluK2jVhFvQqKDJkrzDnchLo4YHVN6fIzIpNz7FOpnrEHIUF+dRPv//qf9hGC8M2SuOtryIyegz6oG01vvDn9E871ZjIhp4s1AisktKuF3UM6m9+IpLVScJQ00uvhWXMYpLMFLoqrju+xwFAb5/P7Ol8hJRKXBS63XhYnzlNNR1vFQAaTLFJvWfmAwet3zCk6Vwkmkeo6lOLrpL57i45tswnl8U1xD737f4zi1N3Bf1fe8XvtsQ1rWv5SJmIZk8mNXX8uERJYqLkM6exX01Z5sC9x1sCYYRG9d3lz0g27NwdD6WBIhqo6bRQqU2F29KN5W6W4RhUk6jSU0A=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:+9GlFx7le6OSVoLTwqjGmi8Ce7YR0krliBYh0LKmubuBIrT7z/XS3DZAm9OCMAH9kQYYJh+IK6WylpbSvGlE/QOE0nfbg36sjvGanb7+FxL3jc5VRP4lV9IpGgQ2wSqPSg3872kzHYORlj0XVgXlzy1efdRWqaqsskq7hK0DeJzcKpZWfqKBWuUVHLKCfjfvZX3BUkXSsGqG2+7JHD02Y+ADh/9u1b6VCb4Uqibd0mW84vh98Qn//Nz2UeF8LRuSCt8HRmrmyCIw4gAF6UWV7UPwUa7IT9TTZ/GN42XmS1kFktRPw6bb8b8dIP9dFZHJ0dBhaBhQOXEmwnoL0ySVOmC+LWxOacTnG8cIO+5PkzehztJPC79Gm3WmN0gMmUXAkBFqXS3M3yoxcOc9n86NRnk7HKLV+GPadM6UG9vKj1heeQcAAdTEJzaZ/h7HVeFwh6AhwPK0nskqa8TzEEGyYQ==;5:mYcY5fsm9Qji6cX0MnKK2s3DxbD5Dueosk/qjUtCOZ+5+nPgesEB1KTOwukSaYJ+CCVoBzqzJIZmBgGjnB2CEJnyCAENn91qxRbr+ppkr8DrgmREr4RTkB9G5fWNc+5vFTDIjwwhAtFavjNOd4SEXV/bZ/uGWo7d9rEGLjFY2/s=;7:NzWtfIk2KDSSM6xMRU7uDAIqFbRdx2hUQHV+ur3s/Wr1yogokvDh7o/gpB8VDk/5hMSariTblRUntoEQ9lg4f/KbhMxweqelndTPLsw6GbzEqzvZpgR0gJMA5fja3hB5KDxOI0gQ2mZg1dX4T8G90z/wQ+DQTE7AjZdPqd1kIuBqHtP32WU9fKtuaV66QRxnXfMt4aZFm7vPiWCjTwdLpSmUB6KJJnCi4h969npPZZQQuxN4iUArMJAIdp326YFc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:17.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c114184-2f49-4293-aa67-08d6221742e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/fsl/guts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..5e1e633 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -222,6 +222,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4

