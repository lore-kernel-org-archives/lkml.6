Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pVfRFq3XGlu7SwAAmS7hNA
	; Fri, 08 Jun 2018 19:23:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 468AC607E4; Fri,  8 Jun 2018 19:23:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSIRCDsn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77AA66074D;
	Fri,  8 Jun 2018 19:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77AA66074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeFHTXR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:23:17 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:51847
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752724AbeFHTXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEHjFCs4/iiVXgXE2iFMPxWd6yCpD2FxTXGmj7GFvNA=;
 b=gSIRCDsnIyztC+U4h4E1dpx6+SSsMoI9sJDYNpgx0AY30JiTeHlb8k3R1uE5dAvLHN6IFwG9lmQY9NtpgXkU3kYE/eq99aT3QxFw8wKYAWmgic7QCCtoSKmGmsjuqPKvKUnIWolkwlXBr9V6iBdO2smyR4Xmy1vHcCXUMeptrVc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
Received: from Ubuntu14.localdomain (64.157.242.222) by
 HE1PR04MB3289.eurprd04.prod.outlook.com (2603:10a6:7:1f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Fri, 8 Jun 2018 19:23:09 +0000
Received: by Ubuntu14.localdomain (Postfix, from userid 1000)
        id BEF0110A55E8; Fri,  8 Jun 2018 14:22:58 -0500 (CDT)
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 3/4] pwm: fsl-ftm: Enable support for the new SoC i.mx8qm
Date: Fri,  8 Jun 2018 14:22:36 -0500
Message-Id: <20180608192237.11063-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:805:8e::38) To HE1PR04MB3289.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3289;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;3:TrmAIy0qMFcxE7KF1zaf070+IXOxUW+ZdHZsrGOdEqi/LKqyBfSE1J0PKfZVK/cEkqhcls/hsscUZWuzv5cQCwMO8X812fJ8W+NtrEYtMyScIt6TXlPpWWEKdSa1hIh+bRAoBsIh++fJg/isczAUGscYiHHGDlgk9ztgrAAcNbHyfsa3y2SpJvuDWooMwTKgF31Z9rJ4fQYxR8JzNZCe2ypLyxB7NKY/921VBuAHblvpR27Hkft3R05VphB0K6wp;25:Hb233uyxbhvdzQuNC7Bei1H0XB4hZeRsehq4cGG7j2kMrZaWOD5QCItI7HS6zY8kc8LRM8vkFzMxFkkDEcvEtfmRkpVOD+4oaeKVCpF++jXcbgFB1RKcODYyQ8vv0e9Sg/P94SlL4kkX+3MFDt0Yf0TplqiMUHMrewIcQyE3LPsfcm5KDLdVGx8NFMONDme9MMCEP1hSJirZpCh/x0pAHF+BRxXHXmp+uq+ivdtnQn3Cd48xSeGtWryC3U+t5hnbPBd+LlgtWOx8jJVs4M0eh6MGVd99q/fy/ROwRlyR3FzRBsxZThSHqBeegT0RBvtNoqTbB+tCOTpHZc2qKauInA==;31:O/4Yp1aIrv6F89JwQz0OWj67FIRzqLnPasvbfKVggYB4Hy23mFb0wogcMQefkNE30KwHu4BYq7khsp0HN750YdTvb/k6MQt/v4d38Xo3xKdRcOeWxc5VwPM2pr88ez5wn8V/qCOzPPd+k2dZkvH1ajQIfvAXn+oTf22vhWkmF+eJ5oxZrBWfEBWinSG8mIFf7IZbCMiYw+aHGYbD3bDRt99AfiEXyiXDuxPm6Ekjan4=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3289:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;20:lVEfyHO2uJnAQJmA7erCsYq4lH9LvS4el8Z1k3Bi42eyDxn/KxioMzBksSKZ4y5nMPYZxKfMVjN+3rdjpdObdiQmALtOWUr9GvLJ5+tBKKp/08iPO3fqNlJZbNMTEWvp2Tl0CU0MHNI0lRtyL14IVJQ06YyyiSxVAUAYzlvMfKfHVHQJnRdDxjqwhwIAnx5EDRVwCyGOS4dV+Cbf1f9tTrinJRZB9QXEJKw0MwdlLXoAqCEk0J4MvNMzQIRg0hzpqEVC9ZiSXnY8ispwYP7qc4OqI2ycyqngXiKmXE2DK9eTQcPfEg7efa1xsvMliB/xOIfd4DF3KujnGLKtHlAKzQgVcsWgjw0FZVZ2X49vRDxwBPdXi7FW8YUee3LZPhw+7tdfCDNwnA1U+vrUFbU01mrI8H+zElJwuyAg3OvcLESIYUHDt8aTGvzVPm0PvnINg4z7wwxUtPqQZ/LwKZDtDFdPzo0YGdTL6OnhQZiITjdIePr2EAqZV8dTKK2DQL2w;4:T0hFLSCRRs9pT/JH3z4tACQVfz+JJGAWyXfDwvTGzYLpOBNPmL+BcqvEc5HVwzrZhx/nk8YskW3e5GjduqhXmqTYewSi+B3GTV2GCwlXbFQkVPKwMYj3leNW0KbvL06K0snCjM7qHLDR6SRGt+/zC4dCiLIGoTc5GRzMmf/TdJOmYWjfRgCMWy9K6aZ3RvNKmzvvdQUm6sMfazCznqDyfBg/g7tpBHGGGkjj2J0AY/bLoe5CIMEn04iIu3f8qc7tzFhyHkYm0glzuvnWeq3anmvdDiT3PqlgIGaFMGOTy8mxvzVzgit+wooncsxnlm06
X-Microsoft-Antispam-PRVS: <HE1PR04MB328962C4CA88C9106F3673BC897B0@HE1PR04MB3289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3289;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3289;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(52116002)(478600001)(1076002)(51416003)(6116002)(9686003)(33896004)(3846002)(101396001)(66066001)(386003)(5660300001)(47776003)(122856001)(36756003)(8936002)(50226002)(68736007)(76176011)(2361001)(81156014)(8676002)(446003)(81166006)(2351001)(7736002)(48376002)(53936002)(476003)(2906002)(11346002)(2616005)(305945005)(486006)(86362001)(106356001)(6266002)(105586002)(50466002)(42186006)(316002)(26005)(4326008)(16586007)(97736004)(39060400002)(85782001)(6666003)(90966002)(6916009)(52956003)(186003)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3289;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3289;23:yOifU9Ks2nwXSlvFpATFI4wT6OcvsdUhoEvAsJ7Yi?=
 =?us-ascii?Q?xP824IKIlRLh2nsx5uOfnSoddgJjvI+LSdckbxNHKn7hihqVdasSPN3glDW6?=
 =?us-ascii?Q?tj5qp+tJR/IQbAPsS0hp2pkXTBhfR2w0zeuo1qgh5Kr/aa1CBd2RW/HrQ/Qi?=
 =?us-ascii?Q?MhxgTEL0qE4c1eK24YgLHJtp66LKMynWxg14rSrFf0tBS9FBWx4xAn+23GaS?=
 =?us-ascii?Q?7ih8bEk7kifIv8Geet7T9/nbtvQAQo75QWXCHiBGGfNTa9wZ5B3qP6+OL8At?=
 =?us-ascii?Q?1qDGVgIT6NRNnIeqBp6BQ4A2NkpBtKlqSGuuVCLD0NhEzAV1AT07Wuv8a96a?=
 =?us-ascii?Q?0mv8zD4qFC/AdJ9ocirbZdIKbjv23jMPunD5MnFWZ2DS9XbJ1k3TmbRHGfIz?=
 =?us-ascii?Q?lMQDls1YKKYvjixas/oVe/uAjpw1/4tua+4n2l326dw/djUN3M+eCuB5RajZ?=
 =?us-ascii?Q?u4ek5lFMBBAdyn43Iw2ECkuiOWYQrivWcGxpF+u1uvThIaImq7pBOgb0Gg0o?=
 =?us-ascii?Q?94n/uY6gSeEagphR5qls4c7EOknMtWb9tQBd2RJY3SO6aLJR7qVS6ENxtPxj?=
 =?us-ascii?Q?go9t24PZFSrU9A4y2gLTIP8DWVtEDCJybyy7kszDDHDADGNINJxaz2X/w3zK?=
 =?us-ascii?Q?5txjTXWv1a3JqmAK3az2h6HAt/qWMdQ/+Nsyj2iFCfa7UVlrY9AVApUZ+ojl?=
 =?us-ascii?Q?E+Lvp8rRqRHTT4zOJd4LfaO57s4slkbUdR5IrJZVwHuD+43FeVd8oTgShrT4?=
 =?us-ascii?Q?9MZLGDIzFvm/SyxsU/Mvr1qjlxLouB902xvHcN2bbWr8+jAiFICLnlQ+D3RS?=
 =?us-ascii?Q?4qz/Tacfj5NoTcXTyT+1WjCniXfWMX9JO4MwRUerTcWl4xQvs3cMfNp0y72d?=
 =?us-ascii?Q?bKxqbjHFfzbc4WmHeQRPFn24v79DWItCJVqH9/4RfoGlzhRVupS6Ke0nwtdS?=
 =?us-ascii?Q?0DAU3R/qdvGBIVDBi20/cZKLRhL2m40f0iBI0k3tAZUooV6/x4Nj8HZLsM2/?=
 =?us-ascii?Q?qQMWWEzaSxxCSPFMPXUHFvKFt+sIScpoVuzABlBGQVkoIE5TWnGjd3ClLXJz?=
 =?us-ascii?Q?Y0flCbbDNbP2sWcjMg7S1ybTvwa187QDXXKIzl/TFgghDUXqZ/Hoo9KyOZLT?=
 =?us-ascii?Q?2rOfEtx6Im9GGWGY0bposrfZqwNXfJGPEfttwPdJZAwdETKkqxJ0mP7fLuHl?=
 =?us-ascii?Q?3PoDq7hjbZBphiMwrpM8kXQMwS7ChtHQJNYWil3xM/C/e9Qqsb3tSj/vz1Oe?=
 =?us-ascii?Q?6DFo2tdBxP6VomQhvmjhbuFQwLdFwQOnzJCHLijL0n6xYOD2NuetwV88CicG?=
 =?us-ascii?Q?H9Hh0pnfPLY0CeP6/JtJdeTeCHO4aOtAJ9VQh/IDzIWfX6DANdQr2vb+t6xC?=
 =?us-ascii?Q?IQiZA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2s4zT+6mkrrcsx1Akww4yUSH93oB22zfrUYbasRPKwTxwngsZonW4DH4pqyGWxmRxgQ0NS0kEzGbaoivhSMN0B5V7zfnl5miksI7lQd+66H7BvP4C+AjjCmKWcM7gSbOalr/583bUzZBtguDdD+wgha89s/1pWFT0iErDOULF0R80KnkC4PAQZAuH78WY46J
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;6:USMg3uFm79x+W10kimQvTLCuN+f7wXqXve3cpx3jX8aPuie7zLqtVvEkwFlobJyeCqY6q/zEJIUhAbxVjcsHzRcuC0mfDOWTBCrhReOEskcQai58jvrzDua9cr/wFltprcr4eH9Xok0qMCi0iJWWx5QzYNUwEaSJtB/5V/F1wS3d8v83luy2i2WJSOua/lAQdq6evO0UwvBd1qBauhKeAqATaQnyy72Q/+3y6ky1Te1xV/OvqNUiRLTkgC+u0D3ahZY4+2UGyW5GXuKIQw8fy9IAZER+iEYc41CXZT8yRAHFtpTnd91uQjqSnK9t0TCm/pyNSAn3zpOCXjJak6IkWt3U3LyZR85CTYcBqjLUJPspyfBg/scl77QyyQY3+N6EPtFnIWi93NzmnIbEHg+GpHP5Py89VNuSS6jaHGAdJv3q8lE8wlVi22mnVNtWQW4SEsjpbG+72gtahv2mfdP71Q==;5:bZO8tsP6kIpoA8G//psAgUT1c5HfMsXMVcu6xrv1ZQcqJj9Li3rohFUltAVzhuREuwxv9mjINqJ8mFy+/tlHC6ZXz2pMcg7z98rn7tZv1WsA1spoIY4pBoEbQ558rX8nY/mrklMJFUYn4LObWMXKv7jBeEZ25SKFwnrfVtHuScI=;24:auvvWlFAez1c3cHbu05eKiJ7Bl2lFQINhQIrgINiqi0u5I9unuPyt2j8JqbMofuCsHSXJE+8IzhOdfo8npoTkD0L9kqyVd6PwSntlC/q+OI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;7:9183zX5nUPkGv1wNysYTmIibM0GR90444PRFkTv7481kf/3Tro1M8EXG5nJNrxHl/ltayLL0yim2D399l1p5jJm5DjssEiZzulPFrScme4X4Ifj3KXLxxzNpgQ2lxqIqNAsyK/lV/LyoRpqur4AzISz9Dg5s2pP+2dYVfhFgmCJ9kfayCeT1JZKJYWBqlE7STyGhjEwY0b5npVe9u2bH5liCrVJnGLx0lu0buMSpOL4W8us1m9RZiyxfe8rwdz67
X-MS-Office365-Filtering-Correlation-Id: 5b9877b4-fe4f-4c13-7737-08d5cd754515
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 19:23:09.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9877b4-fe4f-4c13-7737-08d5cd754515
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled the support for the new SoC i.mx8qm by adding the
compatible string of "fsl,imx8qm-ftm-pwm" and its
per-compatible data with setting "has_enable_bits" to "true".

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index e4c76da..28b87ec 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -562,8 +562,13 @@ static const struct fsl_ftm_soc vf610_ftm_pwm = {
 	.has_enable_bits = false,
 };
 
+static const struct fsl_ftm_soc imx8qm_ftm_pwm = {
+	.has_enable_bits = true,
+};
+
 static const struct of_device_id fsl_pwm_dt_ids[] = {
 	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
+	{ .compatible = "fsl,imx8qm-ftm-pwm", .data = &imx8qm_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.9.2
