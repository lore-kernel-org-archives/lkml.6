Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ixdZOG3UGFscNAAAmS7hNA
	; Thu, 07 Jun 2018 06:49:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1AF446089E; Thu,  7 Jun 2018 06:49:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jvMEjGs4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 494C66063F;
	Thu,  7 Jun 2018 06:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 494C66063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeFGGt2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:49:28 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:64096
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751681AbeFGGt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irWWIiHhRYRe7/JMl+nHUksh8mL1vFZiN+318G9MwRw=;
 b=jvMEjGs4VhuWfuqQlSsJnjMUPKaMcLbupvuAG/mQTgZOjB8HCaoAs/hfkoebZ+usOAYt6z7m0k+MUn8/6BDa8QFIDn/+c/TEFGOrgzQn3q1EU36OMuYgGFBtU6BZlhGId5gvgcRNOzZmEpk619AidP9ZXJAT7XVxtoEwdi78WGI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 06:49:14 +0000
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ASoC: AMD: Add NULL pointer check
Date: Thu,  7 Jun 2018 14:48:43 +0800
Message-Id: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:J+nE/q8tvmfysoYs7U6/HklkZs7Af9uZjTIrVPy8jEfbQjrHRWxyUbsl3bV3wRPKGuvyddYmuHVKNl/cYL4EnDl/8QeIG4mDmF8lHEjsaV6J6uCyELNW6LWn8D8j9mIVWyWHl5GnowrEHvv5kX/FdxnmzkoY2//YWz5RhauUKnM0dI/mGTI4PnNq9EPpd3XK4WIxNzpNUZ/OlahQt16IYPmKajU2EMT7zfuu1oW1aBH+1F9S4nfd2aihkiuWCP2B;25:A1YKAA05Ma/5rirUTgM4Tf7u61oluwsitY1lW03B7bHldlF3O4e0N6bRiPGZhAoIwLyAL94B+npnhj2AOn5cEArjOMrZ3nayRxr2bEBmasXqz+GlEI5eHk9zyYqA0ScB28so9G8mr8L1+WabYm0e9D++8H/X1OXa/nKovs4j00Q5Lsubtk2oTShwTdSA3puZqRDRr55zMCi4jMuuiQtSLBAcPLgyUkIclKHgyeFDZRIB2vGs8pmhrsmGhj9Kcwteh8Q40yXOl1Jn+n0mIMz+B9dgYyGHqI2cRULFcT8ksaR8z5ScophsrOk3PBtkWhRS5OoufVQvfdd2L6Gt+gMXnA==;31:GROzbGS1yboaTsd2w52Vc0k3Pk0hyBLXBV3Wg0BZXn+QbQ4R15s+AiimbYJ3bSs5DmoeBgNkjbni8LSai9M0pW04SZjDl4iPhnyTY40+LGS3DaW4MYr63DATpXWl88LPUAKhDwYJf+oEZhZlcRRquVn2JSgGE9Gp9BW/g9+BqPKQOVJtq3CGh5ij1joXPC8+k4oF9EQ3Djy731dkCZO3gYsrf13h732u7lS2zSNUp34=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:T5xu3vK+VRVtbvsPMEhvcmIn4sdWXmGnss+I27ZugiXTRn20zDnhmPkb0ZWuj+uwFsACg2wWBrYoSCZFPwQEBkti5zoqmW5YUF2smOmkNuxMc5AdEEyOLHlltZ9tRVTAGFK5mN0tJyijSEC9eF3Qs1TEj2SI6R+T9ncrz8iY/7/dYhfrz39ebbGmi5fKRGMXenmhC20rqPZ8yjqf5sZL3PpqSi6P9Fn+iRV844//v45yD0qlNEgj7HFSy73hVyQgIPKZDPgGOtY3b56ahu/ThDyB863c4fH3gaMmRdgbDz9HPdUSdQ+smgxBcbjuYQ+1CvnHGAxTzFo4R2VJGYwV0Gl160/Tfx2c+B+oFUNRSWmJ4e5eDJwu3GXq3Gkhgmdm/x3HOrbsVUH8IueUqqVA2qCTHjbyBnbstLqfV4BZXGHcKd5ZwkItNLgvy6QqsONTrCnLM2ekYpcgqhs2WFpJH6qryGx+PCz0RCuG+tlInZaXka70BpJYVhh+O+SRSFcj;4:MUd4aCv6Evn3Iq0PwG+JXzosrpcJR5jMh1z+IplVX/6iyS/9q6+BLSpq/sW7YTepy94KGhgEBIR2uT0NF6ASaSDzrtHyfgrGTKLP4pY77y3AFSYaiM3s+9lzrLG/F/gmPhCBO5TnXvHnPE0UiguXBxx0cV6joqg+xfUAVUhHhk1nktKtrWRiuY0WqJ4ph9QmCJ9+Xt7F7dOjll+1yLYl8u93cGjnye1MwyeFn+mIqvrYRhWeVViyEOGWPHxU0NPwqIETv82SvrpplxQM4C4DlwrYp/x2+GsgQi20JhzQYT+RZm5RAEFb9r4RnZ7U6OFU
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355D2E1FC24FE00360BDF96F8640@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(53936002)(44832011)(54906003)(486006)(386003)(59450400001)(316002)(7736002)(5660300001)(25786009)(86362001)(956004)(2616005)(16586007)(476003)(66066001)(305945005)(6666003)(47776003)(478600001)(106356001)(4326008)(6486002)(39060400002)(109986005)(53416004)(1671002)(105586002)(36756003)(26005)(6116002)(3846002)(52116002)(51416003)(7696005)(97736004)(8676002)(72206003)(48376002)(81166006)(16526019)(186003)(81156014)(68736007)(8936002)(2906002)(50226002)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:vzRgk0WwBZRYjt7cWcqGtUlEPoNwnVFyrfWmXbCwQ?=
 =?us-ascii?Q?t4Tcc8o3PcsQoY8P5VQX/JmGzGTWRudIuNM9bDpuX7wBsD0xf5BQ7AkeYbp4?=
 =?us-ascii?Q?mmZIEkGlOhwcC5iwlOnzf+v96bFt84TSiTGO17oc1EpPAfA6HZzf1qK/6Qz5?=
 =?us-ascii?Q?DtU28sfyPoEHV3BbUUJZNBCIfo5msRIEfBpSQvCZ9UtWD/VgeI8TR/ONvB/e?=
 =?us-ascii?Q?VoLd8t2jF4uXFqL0tNFVNQyw4Geb6ExgflSL91NL1xOqBJ2E8rhUZ4jwPWqy?=
 =?us-ascii?Q?4R7xPDoClfHMv7zStLrbGd76tLXiskiBSj2XCF8Dz740knHBTtyw2PJfXDxh?=
 =?us-ascii?Q?M2LMhVH4nMqDkQTOxvhcLNFiItmaTX5ygXQlvtar/lqoLoDDwVLKumBTsaJ0?=
 =?us-ascii?Q?O2qkERW6pV32Ok191WMAvy3J9ryzywQOcvlHLjXtXanf50IMyHQ8qPlfhop4?=
 =?us-ascii?Q?henIv78zrX2fojOSVnUTyDw8bYx8p0j77sMX/aAkOnWbAU+CB4neWqSsGRCx?=
 =?us-ascii?Q?kf/kvqc1G9eo0Pa5FtrZAQF3jz8+rV77vakfKitEM7T4V2xV+SF0RMngPbcJ?=
 =?us-ascii?Q?GY86e6Rm4jWo/wUUl0ng3bCoE9qQWkDPxEWU+GKpj/KzZu6LHjxMc4j9wc6/?=
 =?us-ascii?Q?l3kV1Xp58CCbtXfL162YiwPFm31zRFmNmhHqh1BKQYbEX51yeuOD6QZSbUso?=
 =?us-ascii?Q?IrAOIjZDTzh5iT7kvixFpkWkuxS7mNLCpW0iWNexwTOBrLVUxLoslMOapfgT?=
 =?us-ascii?Q?TZY/gUmBevDfFmmhpb139IoIF4HuRtJZ8H60bjr3IWdPvZZzXx5Xua5o84HF?=
 =?us-ascii?Q?X4aVKoI9ZQFJ/7vKYUIlxV3JVgNB2MKj8OAo+TqWo+jFEBqfH33tniEnhfEi?=
 =?us-ascii?Q?l9+k3ZuI1S3/zbZbsHLPYLCV0gW8g0AVbXJAP8wMyG4gFRJBqY1u+QRfihpS?=
 =?us-ascii?Q?Xs2KQwnjfYGukVBHH65IY8UWWSk68Ru8rNXpFsP5c/gTiGpnm+lS7yU1ckHr?=
 =?us-ascii?Q?+gpR6sa1is4nor5aiZlaX7WQaL/T9gPQ+h2YF+IzenAz3pnr68LYkkTj61wY?=
 =?us-ascii?Q?MeK00qVsxUBRAKwCm3Yfj+xdYGsmKvfCX+oyxAoKZ1dWb9SvrwOe8RJmyx1r?=
 =?us-ascii?Q?lBi/mNf9MNNwXTwZaxO6CNTCG5/s9DJsi2RueRwL0C7h1Vt+htpbKb+kgRsB?=
 =?us-ascii?Q?xMtFPEIzKM2hzfGlP6IhJ3lZ4AyIjGxn1kCtH0AA3F9GxRc93+WHsluvN26j?=
 =?us-ascii?Q?G2TwjMZuwN6obgsnpqSpD1ZeJhIG5YKJ92zu6mz?=
X-Microsoft-Antispam-Message-Info: DE649gLIxubY2XhMTcRo75QqTVBF4uKUtsTgv9xoFou9Sd2Nr4sdPqga7h1snqMnQk/+NMpJhu1mQ1BN5BTDzbqOh9tNQms3wid132C8mUCJJYa0ku30ccdX1KZYnXtKBzTwovk17+faTZm36MQAoaPmn6QR9HJXSCQJfmukzLxNrtrtBovNIi12n0H6P7EC
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:qwQBv8JkFsDptWnaFzPDnV66ro0HLM6bTHjvfUICRtltfpEdwHxXDgwSfXonI1+ppE3f3rI6RNA45d0HuTwPoYPiqgGEbC6NpzX5fvX4PI/cXPfnnoVCDiL1ttd44az6KbwolJDSKzov2vm47kAlqhBVEmle+kdaHe7zNeT/IOctER0m86hquVF28T1GX3xEgnB133AqArkiInC6wrnSAPhf7qG7wyvXXDuCDJxIXVceoYbwpxH6ZgwI+jxIESoeOqu/o8ib00gjEklIl8aaAPZ/vKSj2Qid4rX/tDjgXoGxn8BJBAdRtkCQcZEcWAbuKNWyIol40nvEAqo+URWHk6kj+PgPvDsOrGZjlMhlxw+0/uY24Xr50NnPoj2hnn5NQ0y+BKNzvTmiGCvTY9tbVf3lk+Kq27kt6nTegt9oEV9dvszCAucIqGN+qRp0eG5p3rqEvPimMrICaD3kg+FPfQ==;5:wuNto0jHhUkdJ8tZ1ffYMvGRuiav/+EpuIXDHy53W/V4cbNhNzo5Ct5IAlEANtQ/aPGujY0T1YC8dwy1DlIPYqJcTRepugDZW7PYAjJPWLjl95M+qcswyf8a0t685gZEMXCIPiG4fSUsxAVuMVIVa0TYVtGi3hKm6d+9gViQCD4=;24:tGy5q/IO7WywmTqORfb9PSN4aZiSRWZpSrwfiSPNrtFz31Z7jArsraMG4vVi8yZ7dO/I0Vcnqadf2apqY0fCaE0sBPZzGfeNeLGDPyegTJc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:8jFW4NRF+Af/GwIbI1QD4uL9isC+FZKX8q2LMxM3+iQd7dIZhH/d8G2Urgif0Y39I5MUQExQmg62/vgvr4jTc2WdEwcpU6LCDYP49GavQMRCVbCWYiqYHSPLcV3m5Z3AbNQ5RGpaOywd/jsko62TNA6z8sOwGtVCkq2acDTizgo89j6/KHYqNwo9aGmxIMUk2k5n/5sn/0U8PlsjZC20/nvcmlB1wlRKoqCcS7MQ7aULp6it6ygSqTQaYqaeIqzP;20:wed8mHd9E+mXe9FWev0hxkVLrDkfQ5U13//K8+iDJ89H3dUyXyvNKOwxdAHVAxEiy1/aAlY+C8h7kBNLq14MlXziR3k5IlAHxsU2d39K8TmAYW3b+wBlYvfzCrpiYsB3dmBfRRyOjPCHfov0biDnF3x4UvFwP6nc1pSwg2iA4NFZm0GJk05oZXAPICWQIvtQWeKHKzYjU201IRM9njSyyPdQ+HIHvPVDNXvLm5G+C0Rl2wnJY7rNvQKdIQ7dt22Y
X-MS-Office365-Filtering-Correlation-Id: 1b565575-d2d0-4c12-410a-08d5cc42cd91
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 06:49:14.1824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b565575-d2d0-4c12-410a-08d5cc42cd91
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix crash in those platforms whose machine driver does not expose
platform_info. For those platforms we rely on default value and
select I2SSP channel.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 7720384..1458b50 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -773,7 +773,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	rtd->i2s_instance = pinfo->i2s_instance;
+	if (pinfo)
+		rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-- 
1.9.1
