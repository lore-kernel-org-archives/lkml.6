Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFCD259BD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="K+HXydD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFCD259BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeFYM5k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:57:40 -0400
Received: from mail-ve1eur01on0041.outbound.protection.outlook.com ([104.47.1.41]:3656
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754716AbeFYM5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H2FHkXtnE7gjOZRE2vqzylyttSgOYUC0EI5hHwViMc=;
 b=K+HXydD3oe6TFnZxfEN/i2ZB5io3G0Angr3YBeOoTQ42tIcRrbJHLzC3J7VIqnAdcdXERT68onjmEGCzOLbGv+KRHH83PM2MU+hAyglNfAbrUcS9gA21cd4dVDt4oYPzd7VyAMzNcDGB3jivo8tGzVCzHoChdXjXNpYS7bgqbFg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4657.eurprd04.prod.outlook.com (2603:10a6:208:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 12:57:28 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     robh+dt@kernel.org, thierry.reding@gmail.com
Cc:     mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/2] drm/panel: simple: Add support for DataImage SCF0700C48GGU18
Date:   Mon, 25 Jun 2018 14:41:30 +0200
Message-Id: <1529930490-11874-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
References: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM0PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::17) To AM0PR04MB4657.eurprd04.prod.outlook.com
 (2603:10a6:208:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bd266fc-3090-43cf-a904-08d5da9b34c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4657;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;3:7q7mo0RBx5c3lyP/jO/kfsuHekmAJkmcIAH3TygmRXHtfmmKzoCi8oGmKsaDueaALu6Dn5BfMa7ameuvKj5HbqNWGKCoxM1uw/XuHxSNdzvL4csU1+WvDN5dsZC8FqIXJC+yo5O0QhRaXuRQR5PyNoYkLHh8VHUxyKwrGgJUdhOzjtIGHnr6EHWr8rJwEGuXxQcOqG9WOswFwdcFksXwDkzGr+9eXiNsyvEGbyvhK/JoVKhb0Sw3WUoKLdUl503s;25:PfS/iKo1nT6D69Nx7HcRMB5wjflbv8bapPvUp2HHcg3BloOECh4NBki9DXXlNmZobtCn898O6l6WucqNwbCjBt1pUTRjumoIdVdr6NJVAdDauRWubOUarb+dehZavX9VZ9iI0haJ+8aIN5vA4ASwfcHKZdwmpUyIUWlZzOgY/rcpAxVaYf10F0M8awaIDvNjkqq3l5uYOwYCnDfRdHCfVJMD6Ay7hTY92pj5IInWuIvmGhUnqQbju/p+Zg+h0taAYjMGTF1qEu7O+t+VZ/9nduJp+HAdxNSXqdzrDoWu5swqeTVj4MFwW/uUHU5NbgRZlJkWei+Jp8zMIbgafwe4zw==;31:1dEmrZRerdt2QrEQFwbeg3Nt13YZVy7EMtVm05SJ2y7Q1n1bKM+1lmpZd8es2QoOUVRV62p1McaZngYyEbbPSPvfUBgyvtdF3sKMzBmPTQWFfnXraXzJQnCG/kyVQBMZEEvTpc5B3IppNYFrjDRvoE/bJlM3DCs0lSHpWdI3AtJBtvkuPsYMt2rXejzQ5fWKMyL8A7fGbrMHiGJ43C7N7PDnWUyzP9V67vhO8nZ4BHA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4657:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;20:PzvvQ546BJHijAsFvB4TuwksOAJ1nD+LWr8RlnikdlGVpG85WffAmkLvtR7elSrI7F7guFrlqIpKSDnTwLc6cnbPv+uG/710EDB8tI4tIALVDvXufzothjiBSrsrxZHtroh0HfxGO6ILLPALIna2f5oBIXWj2nJTcubD+VwJY0E9IS9uKl5i5p9bT89PpGZZlf+12df+sYEMwUuT1CYYTzykYM4N4WWOggHuv/UcBDg2VIp8EkRCLO5Q6JNevTI6;4:HX1bixOI/i8xbhJsZxL98Ubzc1mIFkcbMrflNtsIDUdrldjuPiGS96bDDMaurxHK7YJTwgOswYviQziXMkDwmDKnjtUgMGvEIxj8CCrUkb1MoVp9TJfcxE7x5/poRqbv44isYnZ1pWIdLY/8CFhYgDwIZZq7Tb+/Ggl0JaHSMFlvp2wkzv+xhCVtI/aWCoUu9A07EvcBgUg/aNvnyJmSIE8++Ns9qS8jtTGckcQKs3EM1BdgYBiDZNzJJqmCYgvelCVPV2NFim7jWYy7Wj03kg==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4657AAD5D9947B28F5046AE69E4A0@AM0PR04MB4657.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4657;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4657;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39850400004)(396003)(366004)(189003)(199004)(16526019)(50226002)(72206003)(478600001)(26005)(53936002)(76176011)(86362001)(107886003)(68736007)(186003)(5660300001)(66066001)(97736004)(25786009)(6666003)(39060400002)(6512007)(47776003)(6506007)(23676004)(6116002)(476003)(2616005)(6486002)(105586002)(4326008)(2870700001)(36756003)(316002)(11346002)(956004)(52116002)(305945005)(386003)(3846002)(7736002)(2906002)(446003)(486006)(50466002)(81166006)(81156014)(106356001)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4657;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU3OzIzOlp2bFV4b0lmNklLMTBWc285TjZDRklIVnlV?=
 =?utf-8?B?Um9MdlRZVVQ2Rit5TjV1THFCN0l0UG9UN09nWHVEMXI3UkZGVXlRMklzdG1z?=
 =?utf-8?B?SjBDUW5ZQ3A2eTFPNUFydEZOcnJBRC9EcFJyR3JKOHp0OGFnSWc2SEd0QVdW?=
 =?utf-8?B?bDhGSStsN1RJWFBSNE5kd3BHOFRHTEhwUFpySkxXS05GZzNqdmVwUDdmc2Va?=
 =?utf-8?B?UE9OSVhLZzRLOWtqQ2lXZ2RKbTQ2QVBpdUNmL2FIR1grNEV0YnVmcHlaK2xu?=
 =?utf-8?B?bFpLcHBUYW4wTDFIT2lSakR2Zk80N2UyVVo2MkJkOE5leHA0VFpWS0xmTzNG?=
 =?utf-8?B?VjNBYms5Zm5aMVNJU0NMU3RHNDV4dmtPSXo0QUhvZG9BanpkMnNDa3cxRkRs?=
 =?utf-8?B?cW8yUUFZQmFZU1ZiV1NuclJmSjE3eDNmNEQ3Mlhpa2t5WUNmV2RSdzJyNysw?=
 =?utf-8?B?R3BZUk41TnZPSEZ5eFZBeDU3c3dLODQ5VUM0ZEVYcEdhOGZraE9NVGJESnBT?=
 =?utf-8?B?WEpwVU9pU2lUWWRWZ1JQU2hIQkJVN3FJRDg4dG56RkxRdmVNZVpsdWZSaXA1?=
 =?utf-8?B?RXFQQUlCR0hXOEpucmtFRXUwRkp5ZmZGNlYyZ0JiblE3bk5GcUJ5eGpISDhJ?=
 =?utf-8?B?UlBodGxSRS9wL2REaElWZXpreGpWRldnR2g2MmtWMzRKTjQvSCtQRkxiWlNF?=
 =?utf-8?B?dHZlKzEwV0ZjdVpsUElmQUZHM1gyQ0FsZjhjUDRyS055Yk90ckEvWCt5TERZ?=
 =?utf-8?B?ZUl0bHFmclJxaU5QNXJ5enhweGh1L0FYbFlrTjlBRlNxektSQ0hlcVdoSmFz?=
 =?utf-8?B?OEgwWFI3QkNnTmJlM1JLRHUybWVuQ1dMeGVUdlZzTFpNSFAraTRRQWEvWGJn?=
 =?utf-8?B?R21BS3V6eitqd1lwbnk4UmV3YVMvV1JDVWl1MmJrUVl0cC9aVjFwTVJPOWls?=
 =?utf-8?B?dnpzT2hkU3dueG56QVlqV0JHczhGak9PR1YyNEVrUVVFVHhSRHRuTmQwMXJm?=
 =?utf-8?B?QmlyVWkwQmE0bldPOW1ualVoQnM1cHBTRC9vYzFBM3M2VkhraHpMckVGVzVV?=
 =?utf-8?B?MFNNWmkrR3lTOUhkL3JKeEFxWkJ1dGFlK1hwUFhVREt6dnA4bExYUG9ZSXd3?=
 =?utf-8?B?RUNscG9qME5FcHNjZVJXTE0wTUdQby81dzFhVGVldkFmVDhydEpXOW56NGIv?=
 =?utf-8?B?bkFVWFk4T3FhTzJUeC9IRCszRlpWa2E5eGJjZmh3RzBFL3ZqbE5oUjh4TnZj?=
 =?utf-8?B?TWRQUHF0M1kxZ2U3KzRHbVJGN1ZKWERsWDN6QnlPM2Y5UWJzYUt0VzN2UXda?=
 =?utf-8?B?THdGRVh5U3dBR0pzWEtVeUdibzg1Z0l0UFYrWWx5OVp4R0NESEYrRnFnY0My?=
 =?utf-8?B?aUNySmRzbm96YXFpZHB3VEdEMWw3bDY1VGh5MGg1c24wV3QybStGNlNJc2dK?=
 =?utf-8?B?bHB5cUs3Wk5nK0ovVFRuN3A2RU85WTJ5Z0lxRW9qSDJTSkVDbTBPMjhIZTBw?=
 =?utf-8?B?TWoyVUFWYTM4UjlQSHN6RDZxVVFpTVBNMVpOM01JODBNd1dmN3EyZjFJRnFk?=
 =?utf-8?B?L2hIRjJRbTF5M0NyTnVhL0VGZTZLMy9KaUMzVVlCdnpPQTZEaFBxRFhmMmxV?=
 =?utf-8?Q?13M2zCdjaFAKXccjTscC?=
X-Microsoft-Antispam-Message-Info: pkGECUnaiswCQumOFM3xb/G/1r4tktbtusM+USbvpvwq2scVl4MEXtTjg07YizP9mMEFjE566YuxC/p2e9AvwwZFXHygNCttrRJfx0wFIt0gpUg6y/miYoTnfpVxUjvYs1To90Bi44D577iWJMANanYmxB9TeufjRlvyVkMKW3GxNraUhWcpOWCXHirMCHmGZMjVGGirM7/ZtEJawYnAOL8Bh6UcxmT0qyzWyLMzBVlM930nj68i/RJvPL93Ij4lHj09BcGCSzW+2B+bMD1yOcbFQkwhPtNxcoTs5RV/MfBHk3adn/A6ci25TTH780aOhr65x2TS8qAnELBl2fsLnKoteGuZZq1BU1rDBL+AFws=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;6:Acqs6Am1+qEmkG2AQaQJ/NebT6rZbIpRTPtLx9WmMvSmiL7mKo4xQoIuztCM1oGWk0UmZPpaYvEoSZRVYYmpO2NfG1xsg0lIQpG/qCoTc+1/ZnAOCoIkgBw/RvjFIzPTdC8fOtJwjm2U9SbpKiFNUMWobcIInMrf9GCKJTuNCuQc/PRL8uQFn6n0Ln2jt3J8GaqKHlRR7En9eRODVOczwOcoPNs+BYcmrM1wyCJIDVRVip77LqLGLeSjT1blEuaEoD7acSkOPSBRoqKyMmMZHQyKlrzDVAVF5+kW/ek9yczh5OQliFoOK96Rb54NSAcArSbPfJOQPUmpZWFolcsfe89ZBvMlX8VMvkUuJLJiNNyWYMQVVFrp2hZ9JpVv6z467oSFjPnfegsziut8f+fImJ7OkcfAn2MxZ9GpRAOG2QcAl+RMlMAed/5LIs5ffLYMcrhsKJBBAUCsCIjL9VNk3g==;5:bwAx6YNXL8YMYhnHuYV/hwKFIbbHT2YyWpRfKkaaptdfPXRS0obnHAblNH3h0WA/Kaj/Avf7eG+fu3h3WFYOkwaIJErcUKgtc7ojMj1g8XtikWDScMjSW1kYEYEGiIZFjRVyIGCHTGxmcF97d9pw9Rweg6Cz/+uc1AjlfQcQHWk=;24:xmUWnXdFWnWGCirCKYLDsUL6M+0U2CotM3rLtBW8una0p602afG8ad06lOD/GnHayIEzZ37YvPWRn8g4Lo3c6lGxKm/zWjcA0/bulJRnFAg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;7:0V00RVwmIXfzQybUa2aU9Bcq+a3euGZTYecM2xXS6KcrZZblBDaSU2QCvTZhE419Cr2jLqq7qaXKqt5tlWSBH6m0r9sa/NZQsy3gGsl2w03+pxmCHjx7M6sk2zmvLH4AD+JD7YLMry4TwW0EUvzURMpO+rsP0peBjfz2uin+GVoNBeLvEMScN3fLmb5rUz/32zo2r/mNsbLbGsWAYnpcOVgbacFxDpxJOYCuqrwjDhPckOtR88QxoAohkg9MO//7
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 12:57:28.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd266fc-3090-43cf-a904-08d5da9b34c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the DataImage SCF0700C48GGU18 7.0" WVGA (800x480)
TFT LCD panel. The panel has 24-bit parallel interface and can be
supported by the simple panel driver.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 .../display/panel/dataimage,scf0700c48ggu18.txt    |  8 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.txt

diff --git a/Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.txt b/Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.txt
new file mode 100644
index 0000000..897085e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.txt
@@ -0,0 +1,8 @@
+DataImage, Inc. 7" WVGA (800x480) TFT LCD panel with 24-bit parallel interface.
+
+Required properties:
+- compatible: should be "dataimage,scf0700c48ggu18"
+- power-supply: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab4..796b091 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -857,6 +857,32 @@ static const struct panel_desc chunghwa_claa101wb01 = {
 	},
 };
 
+static const struct drm_display_mode dataimage_scf0700c48ggu18_mode = {
+	.clock = 33260,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 128,
+	.htotal = 800 + 40 + 128 + 88,
+	.vdisplay = 480,
+	.vsync_start = 480 + 10,
+	.vsync_end = 480 + 10 + 2,
+	.vtotal = 480 + 10 + 2 + 33,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc dataimage_scf0700c48ggu18 = {
+	.modes = &dataimage_scf0700c48ggu18_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode edt_et057090dhu_mode = {
 	.clock = 25175,
 	.hdisplay = 640,
@@ -2125,6 +2151,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "chunghwa,claa101wb01",
 		.data = &chunghwa_claa101wb01
 	}, {
+		.compatible = "dataimage,scf0700c48ggu18",
+		.data = &dataimage_scf0700c48ggu18,
+	}, {
 		.compatible = "edt,et057090dhu",
 		.data = &edt_et057090dhu,
 	}, {
-- 
2.1.4

