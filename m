Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AROxLn/VGFsvOQAAmS7hNA
	; Thu, 07 Jun 2018 06:50:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 075B96089E; Thu,  7 Jun 2018 06:50:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jd93oc2k"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1A851605A2;
	Thu,  7 Jun 2018 06:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A851605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeFGGuD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:50:03 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:37006
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752996AbeFGGuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEg7Y+LGxoYb62JL/uS1frty+ZJeQHxJ7MvVpu0uNEE=;
 b=jd93oc2kp2Za6ZL0pNhw32+Jjnm0eMGrBETruuwa7+Ajtu6UFnS14beSNxAey9EFI8uBDRT7MGVfQdqEIX26odyIHfY7Z3bgCMnoOxF1iUPZv1Hf2jreh/5OBM/s9VMzGyjFpcSONQZKkh9XaLom41b7q1RZtfeYifz+med2AlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 06:49:47 +0000
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [v2, 2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
Date: Thu,  7 Jun 2018 14:48:44 +0800
Message-Id: <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
References: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:nJUZyjbgHTs5FXEmTEjgqx13NOPYl83ul60yoilmtLvkKcLa6LT4TETc0IoOy3rqnByKhjL8biTJZ4DzftOxy9KFdBYhB7vM0DmZ2xIH9NYeTQzSMl0QzTX4kduzpOb/Vq7wGLEDdjNdTbCcHCZJhioHMYKqvcXQK1xSySymKBo3VM1YRzqEm8GckO107wz897IutsrGJhfK4vdCPLxFLSN2yHDF8BMUde3hxlmDdCJIIFo2jZdPZMlF3Y2HwfXm;25:KCW2y+lCDwFcKRRgos+ofQ0+cFNA8fxPpdR33L2T2XzXfLYY4rYR9nMsmQZgJiksoOQ/0GhaosRZE2zHSt8QKMHA5dwd072yiRU50v5nzBT0v0W+ERZBxZoMuOpY3ZvUSPvzsr+z72PIq6O+gGUeS1z8ZJW1/wXYtIGoyU6DynzEq8myQj3pPzkG3rk23VbiH8pSNgFPUauTWwtMg0ACyhh9+TtEVaLI/7QoZdipB4KjY8wXlmMY7OMUJeQp5KVzQBA+O82baKbKHnIvTOT5I220i+lWZI9RDWTAIeiLzM2ttTI1kpZxs04obG8Uop2Hj4iQVdhaaNB9CbnEDVI9IQ==;31:KI28dwkk3vH+rvibbE6M7Na8C0XXn3N4HuEyL5QWqZrd/d/ctBLP7wurRbSED3uS+sC/lM3hChfzKWY8UX9rUbL59kGkdoUHJPsk7+AKRmgDu/AqA1zU/w3amafGrQfdHo3lLwl1nhEN7iwovI/HnyJEma9A6d0Mu/Ev4u6jo9usmpeiyBzyxZdNn8A77CQiAFDO9Zzc20zWp862jzi3jyCCfXHBVgRxov5g0reBFPs=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:VXgpQmQfD0/JpoX06bL1JqRsxzECdojeiEyWjVqrSq/vfsQ3ad7pV6s/bNznfK8mnmnmRQdgtjrvqqhSuj0a85QsnGKSQEhJkMKAGuxwY/78N986JCaUHPyXYoTUhHwbm+YCX8yshe/R/T1dFWbzZnph3WhtC5UaN1AyADfjxzq+NueBLBRDANDI0h11NA/8nsSH4p1R0UNABJEjh+2cSnNMvU8DFXzKvyMlx5Ck+mY1okpXUy3eihcwGYV8DeLEUxm1JBy/0Q01kmgDCoziU77dwZxEjxKATex5gk79oau4yu9tcOkrMG+7tJuWiIdbXkCbofiL4svP0IAhFPLzEDONdHaUI6sAkp7Y2Pjs9oreCyFoTkoqVepyCYl6mxrkp0ttgyGyH2tlSs9SXoEy8UXoak865/hjy6V/UduNOZEiJGrMn/GRCfGh1E+FvEYn9zq4rW6Mob+/Akl1eB1yWZJ08rF+DwzjJEmLagsqzNgBGy0SkXB//yTnxduc7J/+;4:nJb9uT/Xbih0VOClwvSQsAgRgMjm/NQD/Hf6WDw6vNjVMG2Oars98cYzDvguQe7gYvVAN67yqif8WaNmV8g7BCX3j2DHzWGo30zJ2Jh5sfatutO8yQINNrbvLrTlkhL1MhbXinLu+X24CagBaJ1gQZQatzoRv/h0El8Y3AsPQsZLa+sPKChdOzgH0sKExujXCZ/rCpPgdMziXZiY9AEXK+BXuq9IuRFvr5quyWGJvjmiGxdmCdfIlMslwJvyaYnJWXUJ+G4TxqyCDDZ6mbt9KP+a+K5+fYZfWTGBcwsH7FghuXdgbOpRBoKdXAP6POVB
X-Microsoft-Antispam-PRVS: <BL0PR12MB23553446C2E46678DE353B11F8640@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(53936002)(44832011)(54906003)(486006)(386003)(59450400001)(316002)(7736002)(5660300001)(7416002)(6306002)(25786009)(86362001)(956004)(2616005)(16586007)(11346002)(476003)(66066001)(446003)(305945005)(6666003)(47776003)(478600001)(106356001)(4326008)(6486002)(39060400002)(109986005)(53416004)(1671002)(105586002)(36756003)(26005)(76176011)(6116002)(3846002)(52116002)(51416003)(7696005)(97736004)(8676002)(966005)(72206003)(48376002)(81166006)(16526019)(186003)(81156014)(68736007)(8936002)(2906002)(50226002)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:wVfdlWWRpyIqaN5ELcPmXQeZtx+y6MunNC17XsQxM?=
 =?us-ascii?Q?PaNOybvQQXDbBAQH2JcB/gFYpT9GMES0pnaGGH7EphV0VlPIVspwa5bh2agz?=
 =?us-ascii?Q?r3cXwqqg85gt5WLbkoRa81q+onOg75eU6gXaAYPiUOEICSsF1cYesB8NQgBo?=
 =?us-ascii?Q?9gC1HeTloS5zglobtlmXION8YzYCk5y3jmOuDhzqlXumoW5x3UU6sASziRi2?=
 =?us-ascii?Q?hh5Pe6z43zi0C/236PBbT7Ohi3CbyPiBI9EbfLRaU7Rsq0TUHw92bzqvzL0X?=
 =?us-ascii?Q?Za+ieVTsyv+2lp9lArBlAXcHCrQ1FjLmC+uU8syDvKqgwPoOUazaKug7hqzS?=
 =?us-ascii?Q?7oCMX96JdHxTipzJ6OSpHtvjynmqXi01bdwLGvPmC39RjXV8V0G7RC54/R90?=
 =?us-ascii?Q?1WH889UPuKMwblLO1PejJckQ4cLjKWVSGhdrKPcFXwr+2aO7IhwOQYX9gYGU?=
 =?us-ascii?Q?Si3eLJwLsUOG9N2aG6SeaNPtEeGr2Whb4JTqDASqTb5rUW/8aoN2SCKibkp2?=
 =?us-ascii?Q?qCX809UVNp+Z0uGyXC391exHQydlVUqv6XEhFoHxEM+8mGPdC6QRwSICpzD8?=
 =?us-ascii?Q?95fRQfTFEY50pjJNLCl6V0zBfWIPhxfsX0Pt76Qy1r3h0tKPxuidhGwshPmG?=
 =?us-ascii?Q?jzdWR8SUmFusnWCXP47zXQO77I6qjePVukdTl1z67HZ7F44SoJhY0nKYIgfg?=
 =?us-ascii?Q?V5MGfrEsTIVby/jFRlfBv7vojLfn+YtsdWWctj9QVxMQW6pGHdrxQZ54O940?=
 =?us-ascii?Q?f5j8XWUhpPSYxMs389R5oChvF+Q2rk3DZEKTGUFb2m3E35sZ7F8lA+mSYdUc?=
 =?us-ascii?Q?GYr5G6QhpaVH8YqNBHS5W3SZjxlpXnqHXAl3PkrJJH05n9ihQ1G7tEeqDkVG?=
 =?us-ascii?Q?fAu2FCfFP7mC0jtKVnLYOJo3wI44Xcqimk3Guq3dRZuUMWg3so6KXNy/SJsG?=
 =?us-ascii?Q?tILOXuIvqgH+BsqdtGuLHdXPRpD6oUtSUP6UNbL/I/v3JEC0X3SPk3W6Axre?=
 =?us-ascii?Q?yn4fW0KcbsfKAdAN3OgI4t/UnYLee3+NwUsJwimlY3+EOMa7cGsMdHQ6tScg?=
 =?us-ascii?Q?2BeeaWlni/W8ndBlSGwYdnQXS/4WWMyn4PJ5+x/Z4G1miyQWmsEJIwa4ReA3?=
 =?us-ascii?Q?1Y8uHBYmWK6t33bz+O6oJoMYCcsQXioMls77TUCVO6268n75EFKyYl12eFHC?=
 =?us-ascii?Q?X9vTX9C71/zsvK7wALOeC4sbYcCR3Ln8Q68zpAgRvGr12dcsZVO9K+jFjYWf?=
 =?us-ascii?Q?hFEihkIZf4dlD9m37Itccxm4NNCk1ka17u2nTA4iKiLD459jbV8SoBQIl9Do?=
 =?us-ascii?Q?VNbmxIjIVoWx5dV7EEMCOKYs88yoMamYaJHE+LWyynAHelgSfcxIEpQb/Ep7?=
 =?us-ascii?Q?EmoIC98sprw51DF/gVRlS6uMCEmNXNDcukqZnr5/b9PIIbd?=
X-Microsoft-Antispam-Message-Info: mXew7kXawPEaivGn/LcubVOm8IPnD1hNxi/A3Co8lZlpMZNxcv3HW7l2MEC/0CYHqAg+alFvdCcvUtkClTb/pY1+2lvsk5U+w7JiUHL+aCDetUVNXlSDEUUmGPLDvIcg7huIcbSC9vthOqWfpaf6+762yF8VQlAdG6O2i5UEoMwF50o+sPOj4xemAOgj37yi
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:5UNZwYLXHVqgXSVBVAnJiVBL3xjbOJtZHwAXUCMRkAM6RVWPFNmD0L8fHJq6ARNNDLuQdOOnX6EfNYefmcMrMieHjOZBWuZ5y+WEH/AJ6LDSU3KV1QeJtBFmR3LCL4zn42zTbTWJsDCwjLF2N1sIwwAe/Y7uPkFxNdHLlpdDosdsUOnx/mWw6Gmf9UGf4atA9Af/WQyJnVPOKwL2duln4/aQi4cOsiVqw6ZxrOx2FkFtgvH5RbdIwJhTsUBDsAWvyOkmJirXs+KrfDnmZuO5xIs+9SRmrsUc784vssW5xachKFMXjW8Fx+CLbhd4N3SOThme/sdRd9NSf8LpYf88Tgg3ANP3hPJiL8ZWpGK71tGXPtz9m0bDKveBffeX3RgquidN2D+uq+47nlUW/fWCAaqFXgX2O14bhXXbpDMd1c8BitxmtzYMHyAPfFnOVs2nk8/ak5P2rV0WtoHXVeCycQ==;5:ayI5GziR4VWnEh6D2KpRCCsfACYLYF0UX9tM5eyGK5OQcoL166zW5a02x3TPa8rHP7sD7ULDtVqU1dkwbz7B5DLTiZOA8jt0OPGJngRhudFS8ux5RnTEW9Kp+LaaohADiaPwBuzfRBjFLc7W/pWK8SZM9KqzUlZmtoxrM5sEH5E=;24:QStuF8n+Ikss0kr2Sz75DwhCS9K9xBwfMgDrTi2mo+qRL3Rk4mplCwXOLCTr9SxgGIZH37/Q7TsxraDptP0sQ2JsYIyhwj4j3sIMhEVm/E0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:LaKyQU+QNPS809Gk3tQ2sWA/fO5ZSj0PjB9zg+D0Mrl2uOp7RtUzSTor6LxCXksPopdtMA770av07zctULWGOJDIg4Txty00xiPl5GosDkRhAxDVd8iG4niGwiiHFPjefgPMn4iACfeXAruVxPpkBj19uPlUqPNFLn9ZAtJm7i7/Gicl+mv1IXBEfazIs5ou6GQK5CPJwcZQtnO71/CYpTeAwC2qAnrEMPW4aqi6t+YUKb0xZsAvsXXqnfkdYdq3;20:pGE2lr3SkBxr7DPnurCxWrX5V+BkZTqhp2tVHuEM94cOGvH+KZSha3qYAhLGQ4qcsrW120/zBAbN0yjBUsB53bNvwjtNInlCoElEUuluEo+46BBOrhDQEjwGxoWEQRRcs5c6VxWP9TAelwbp0eYqPTQ8uYdlnbSb9M74FJS3P+86fk2zNUJUAz9h6cejLXaoSC5VoIIl6MXMMacYJwguLwTKExm+1mddLafAhOnwRKVpDqyqYZW1qlXMw3yvajo8
X-MS-Office365-Filtering-Correlation-Id: c4dfec77-8d90-4e90-f3d2-08d5cc42e211
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 06:49:47.7367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dfec77-8d90-4e90-f3d2-08d5cc42e211
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST/CZ SoC have 2 channels for capture in the I2SSP path.
The DMA though these channels is done using the same dma
descriptors.
We configure the channel and enable it on the basis of
channel selected by machine driver. Machine driver knows
which codec sits on which channel and thus sends the information
to dma driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Split acp_dma_cap_channel into 2 functions.

This patch is dependent on ASoC: AMD: Change codec to channel link as per hardware redesign
https://patchwork.kernel.org/patch/10388099/

 sound/soc/amd/acp-da7219-max98357a.c | 43 +++++++++++++++++++---
 sound/soc/amd/acp-pcm-dma.c          | 71 +++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp.h                  |  4 ++
 3 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 566bd26..f42606e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -149,6 +149,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
 }
 
@@ -172,7 +173,7 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static int cz_dmic_startup(struct snd_pcm_substream *substream)
+static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
@@ -182,6 +183,17 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	return da7219_clk_enable(substream);
 }
 
+static int cz_dmic1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL0;
+	return da7219_clk_enable(substream);
+}
+
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 {
 	da7219_clk_disable();
@@ -197,8 +209,13 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	.shutdown = cz_max_shutdown,
 };
 
-static const struct snd_soc_ops cz_dmic_cap_ops = {
-	.startup = cz_dmic_startup,
+static const struct snd_soc_ops cz_dmic0_cap_ops = {
+	.startup = cz_dmic0_startup,
+	.shutdown = cz_dmic_shutdown,
+};
+
+static const struct snd_soc_ops cz_dmic1_cap_ops = {
+	.startup = cz_dmic1_startup,
 	.shutdown = cz_dmic_shutdown,
 };
 
@@ -241,8 +258,9 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.ops = &cz_max_play_ops,
 	},
 	{
-		.name = "dmic",
-		.stream_name = "DMIC Capture",
+		/* C panel DMIC */
+		.name = "dmic0",
+		.stream_name = "DMIC0 Capture",
 		.platform_name = "acp_audio_dma.0.auto",
 		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
@@ -250,7 +268,20 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
-		.ops = &cz_dmic_cap_ops,
+		.ops = &cz_dmic0_cap_ops,
+	},
+	{
+		/* A/B panel DMIC */
+		.name = "dmic1",
+		.stream_name = "DMIC1 Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "adau7002-hifi",
+		.codec_name = "ADAU7002:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_capture = 1,
+		.ops = &cz_dmic1_cap_ops,
 	},
 };
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 1458b50..3c3d398 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -336,6 +336,61 @@ static void config_acp_dma(void __iomem *acp_mmio,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
+static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
+				       u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg, res_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		ch_reg = mmACP_I2SMICSP_RER1;
+		res_reg = mmACP_I2SMICSP_RCR1;
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		ch_reg = mmACP_I2SMICSP_RER0;
+		res_reg = mmACP_I2SMICSP_RCR0;
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio,
+			   mmACP_I2S_16BIT_RESOLUTION_EN);
+	if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
+		acp_reg_write(0x0, acp_mmio, ch_reg);
+		/* Set 16bit resolution on capture */
+		acp_reg_write(0x2, acp_mmio, res_reg);
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x1, acp_mmio, ch_reg);
+}
+
+static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
+					u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		ch_reg = mmACP_I2SMICSP_RER1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		ch_reg = mmACP_I2SMICSP_RER0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x0, acp_mmio, ch_reg);
+}
+
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
@@ -773,8 +828,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	if (pinfo)
+	if (pinfo) {
 		rtd->i2s_instance = pinfo->i2s_instance;
+		rtd->capture_channel = pinfo->capture_channel;
+	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
@@ -990,6 +1047,18 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		} else {
+			if (rtd->capture_channel == CAP_CHANNEL0) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL1);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL0);
+			}
+			if (rtd->capture_channel == CAP_CHANNEL1) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL0);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL1);
+			}
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..3190fdc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -55,6 +55,8 @@
 
 #define I2S_SP_INSTANCE                 0x01
 #define I2S_BT_INSTANCE                 0x02
+#define CAP_CHANNEL0			0x00
+#define CAP_CHANNEL1			0x01
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -125,6 +127,7 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
+	u16 capture_channel;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -155,6 +158,7 @@ struct audio_drv_data {
  */
 struct acp_platform_info {
 	u16 i2s_instance;
+	u16 capture_channel;
 };
 
 union acp_dma_count {
-- 
1.9.1
