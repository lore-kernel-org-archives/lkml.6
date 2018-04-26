Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755706AbeDZLQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:16:54 -0400
Received: from mail-by2nam03on0064.outbound.protection.outlook.com ([104.47.42.64]:34183
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754801AbeDZLQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:16:49 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Jason Clinton" <jclinton@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] ASoC: amd: memory freeing for rtd structure
Date: Thu, 26 Apr 2018 16:45:53 +0530
Message-ID: <1524741374-13523-7-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(39860400002)(346002)(2980300002)(428003)(199004)(189003)(26005)(126002)(59450400001)(36756003)(446003)(104016004)(486006)(76176011)(476003)(109986005)(39060400002)(72206003)(2616005)(2906002)(16586007)(11346002)(47776003)(478600001)(50226002)(186003)(316002)(81166006)(8936002)(8676002)(5660300001)(81156014)(4326008)(50466002)(53416004)(105586002)(7696005)(97736004)(356003)(53936002)(48376002)(86362001)(1671002)(336012)(54906003)(51416003)(6666003)(305945005)(68736007)(426003)(77096007)(106466001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0766;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT020;1:DhiYfcuv++Yj+TRsXivP1+lZ4HQeobnDXifEJHjlWPPXXB6EQ7ixu4+LWou1BVFnwT8mzQ3s/IklijqU9alIZTsSYdqLeFyC8aaHcMjC0V7aN8/g1/qLSI4go3Nj6tYN
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB0766;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0766;3:nuZne0ERggcWbI5At5ly/0ZEmn3PYAYQlmCL0unA7xge59XNCWIf3CQGxFcsBVE10XlVPao0K21iqnsz8CqXZYICHPiwEAg+I4Q8Kpbe2HH4r8P38DSxbTBo+S5BqHqNVZaSPNJYlKNcTxFbqbShQuCWEILi0gYwMB//CAv7kCpUOPqxbMQPrI7K7xFvle1huPqaW5bg3G/P5ifEBYiOyO0wILSWcVP7N+BhiraBYYJek6U9XdMGshFnze16WvyeeXIxsEYCSJNO2Km6akHgCxOR42JNgx8hZ7ECGj1YmWsX10Aamubi4L312Qxao9yHR7tuJWvrR4OijYT7hFz1pRl5uvx2PdCvfM4CLzg+bvY=;25:6kRatXSYHG5ma+Ea3xP812BbFffu28jm0fraXJRlYKU0qdihAMLu3VPgx29F70FebPm2lebTy9Z0fkfXsCV6bSMBspxZJHdVrSlB7zF/CpPwfoBLqncl+v8CKnpJ6sHtTT6moQQ3pHNn+k7zPjTVIN5j98OyBxE35f5XuGsdiJXG/RL44EBc8S8dsT0+GLUM3OOzJ/seXTAbu+mU1Q2STxVIhYssjnxUSHOi/lBOcodBSfz3GpwA7yW0jii2sir4mpn+fWTQFAV5yBsshTHMCFg+GQYte1xp73xCb4u/Rl8GsBr7vMLcxrP8BxW4l8MamDpUCmdJBpiMlXgidTu9xGQJgfL+b90vO7z7NWvdEIw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0766:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0766;31:Z9VilKIg4mxg5ZF1JN8ArnoihBDCUjCbs2N44zxYfRnRgMjoNrEJQZPm/UyOto2DihlOl0SfbBZHB6jcy92Mj0THBDc5+b+/Dd/Jh4CCRuSsVoaOQLTYmlPiI6yIyaEVdwW7fOBCDl6APIkKOEu1HqAwfxdtCmXKL6eKo22vUeJfs3KMzwVNAIGSrTHzJfzD4DY0kBZp2iiSugSG3CXYGxV7D5iuG81Wq9I+cdwYzCc=;20:F9NKf+axIaKjpram6ykKiflLifcgZxoVePxKQSC6kyUO5ErrQ+92aV4UzB/ToP5zgwP+cuGO48rWODKdEwde0QuXilCZ73b5OOdMjyrrj23WRv4dRn0ZzNpc3oymWNNSaUaARdbrAcg+CSDDJHpRV9dKEa6gS+kxRWFmI9LzJC7iOhYrYP0ndWkra729hv79zJeKiR2UoePhWHa4pGm2+3HHZXpknJgX0NdHliy+ajv2GCW7TIh30bFNRqCbHPdUd3xwk/yFyDqKTJSO1nfCgSdDiMgxr1pJrGtH0L+1GDTOihvtbXqcbjK3sbwKfMw/4nraKTa8ZZhq4VseLpwTjZefMwXGr1vMwfQ9HEVwvSHifQcd5KFFVqQZo/vji/ga9j11Nwvb3dlRqPfLzSyra5pvdwqPxOod65wkClvI+8y5Ir9QVJm1dEtVeCgg+RJ+S5AldMaWgRJ/YmgYYNLW79biPrhmwpXK+ItYhwBdfQ6of10aF7zPmE7J9ZJrnggc
X-Microsoft-Antispam-PRVS: <SN1PR12MB07664ADF9AEA3E8F40050114978E0@SN1PR12MB0766.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501410)(52105095)(93006095)(93003095)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0766;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0766;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0766;4:pidsagQoefaSKiLEm8ZwoB8RuB6hKNhIbJcO27dD4QXnJWOBLZAuyJ6Rvw6r+aldXwws82uB8j9lCu6lQWrt/h8yoT2Y9cGAphgvbl+hwZ8GslSoRmPu+RPvQEaoEOsUA7OgrDZsdYV0ZkgQ2devwrlwlF7vaSflhTE+sCeLOMQzd8B47P8aKlflmpLGLv9ODWIZA9dfcaE/WY0m1Kzz6HTQXzVRstM+o7n8QwC/tIGyfjZVLX2tbwFJ2MGRHA2UrIhDDm6oKovAnib7vX+Tohqar+CGyyQuKwYFG/vMxfO2z5TeBTAkjlgvbA2kK6P+
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0766;23:MSKJ+FN2+wZYzcvRUi8vdoAQ7DjWvar8ROZUb2Iqo?=
 =?us-ascii?Q?nQmkd+vY2l1tpbiEWAHUSSANAABRUU88CDWin56WLT55Y8DPhdZJ9ohzqIRH?=
 =?us-ascii?Q?NflS2V628kv50wjneRROF2070Lh7ZwAUZdWNWDJAU4u+llCa1jRmXFRCMTXN?=
 =?us-ascii?Q?icjmOkOvLVpwmiufPm+fV5YkIDY8QZ/xm6JLkYU9mHix/o+WQ7mNV+mTMcih?=
 =?us-ascii?Q?qwkhQs/ubs5XD/zgGJOLtA0weMO6p0fH/fg6U0GeGOIhCTebYlkItmvEB9lb?=
 =?us-ascii?Q?74k9QAMi4roytPS35gP5s60Pn0Dudl6h4unfFkyW0qs0SYH88st9hW6C5zbe?=
 =?us-ascii?Q?6EUUUp3v5o9qjzvk4na/3oxkdH7z1K1Y77PcJPb01WQDSISfEwfR0l69lkRl?=
 =?us-ascii?Q?AvW9TSRvrSKzJKNBI4Bsso/ZCUBJZy3wnfdvloMlJw94jLIJPGcMdJRAGAhE?=
 =?us-ascii?Q?xAYlpSnkGTdb3u23jvUMpnQ8wU6WlbeCgAYzTU98yefdWG0mfnsm0wAhxh5f?=
 =?us-ascii?Q?4gevb85G8yHPSajccQL84zlhHbSsEyg4yYlljstPBDIZCka5WkvuEHIJUysC?=
 =?us-ascii?Q?hFhUVSeJDeJjMupPLPEUdJ2D93QGdogy1EXu+34g77E6myTga632hLTEPOAU?=
 =?us-ascii?Q?uZK1qX8v4x8g1kvpe72BdVJ4MoEwtY5jIW+LwX51KC/DUoZBpa+z+dXz8rTv?=
 =?us-ascii?Q?jDasIcNTtEpcTbMOiS2r8kPPc9UVWjoMFz7JmQdrDPqIdorDy+BeIWMTnIXG?=
 =?us-ascii?Q?aX0M3tKWmL3BTNmQqtK0d40aO/VVBshfj/O09xY8FHmETlTQ2wOlk+HqgOrC?=
 =?us-ascii?Q?+vQ10qKuA2TRhgCVj6DzhQ+fxuRV7qNVzu2MDI5jqEg7iJE6xp+3LAjYM+38?=
 =?us-ascii?Q?RgzGEqAr7gn5oEdnLqRPzqvybV40iNLw+F39dCyndlPGE4H9CiPkTqwcLpYU?=
 =?us-ascii?Q?P/6rvI43iwOXfeDb6w5YNHGEAjPEdKL7fSmL9ZuKIaii6BoAeWXRQIBpClo6?=
 =?us-ascii?Q?m427bKmT7BcRZRfY/p5k9hlwuaGdA2gEV3XfnTjcVF3+Q8XPaDgSQT3sGBPu?=
 =?us-ascii?Q?SjKnojfbuBlyhxJdJgN2nOMhEmKNBrqayoPH8AiLLYGOf3z/HfGhxTF1hhAF?=
 =?us-ascii?Q?vgejixKqR8lolymQMhSeNBTYP6w4dS5bNxOa/Mb4pIQDh5QQ97Wunkdqvic+?=
 =?us-ascii?Q?ItL39oEMFLJ4ZDblkgGmVmcqemsh9MAo4WDCeTOWW7PelXGQKffEalEewW4o?=
 =?us-ascii?Q?P11AJbknTCjPGeI/Jc=3D?=
X-Microsoft-Antispam-Message-Info: c79nstiiWTw0lbipCkx+atxAZrkooFyytn71/HJKg+gtOw2i0Qd6Q7HIAh4zpyU+5tdm0K4bnoznTkDb3Th8HPHHrnpk65WgW5ymaetL0mh6uvERsFuvlovyOX0q50vL6LO0Ly51Yi+I4mzrdYqF/JPIl0Eu8p0jAqyFSJi/d9kVAzSBixu0Y+rQO1jThTZK
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0766;6:dtSRMpyI9Pbq9vAeKYBwaP6LZeaORjBQ4/40htvlb+Zrs5VzRI9BaJ/VSqNMtihA1ONpNPFDLJjKXIwuMM2Cm3tLKwLnarI82FaiCi5wPNQg8elqJ4YYZku4CjcsIf9GLHgnOEZhnHWuYRVwQheNeDTcx9shuU6AXYd6lms9y8MdoR/NimAWAcM/MnamUP71DJ3m0JWqVBaBCe8AW0ywDN8QehP0m95RfJ1qkhIPAgG2UykGFm0pPTH9HVw1FHila0vU5+ZpKY+NG+iwWSqfwwO5FzOrxJk7FFa0v1qejojcJimSogtW4GnAYX7bQvkE4T6lHLTvtB4xLSo+ZBcrKQE5G4BZo7Ma0TB26G94oCHI6bBHjSUYyl6dq2CT3UtZTZCz1p8i5Jl4ZaC0gTn00nL++WvIOFhp6joBz3sOVtO4QN28ZbGBEeZlLW+iKb4A47IN2mWrjvkg8HxCoapuOg==;5:l34FtZH5TiGkbZDRCvcRag9VmaMbC0sDrhKqY7r998y3HNR/qip1ksmYJgjsIGrCEpQ5/D0cFr9ExxFNt37wnMHH6aLzl9sCtVf6f3Jd+fMV6mnfnnUxBkMAMXV2m15EGqq5/AB+c5bKvrCs1bSccnj3i7yF2nVm6JgZOqxneyo=;24:fZ+7kU/N2b9wiiNGGERTyBdRdaNXy6aTYBeLrVk4DLFt6I61UjzNsMDbAd1MOZmzHpwOm+qZZSHlSKqAKTS+g1nlhCWOUlVSUB8wGVwRfls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0766;7:hmukBl0HAkDUk6tdj85hcR2HoOyyL7lhU5RypaFzaBC48w0k63+DNVUbd0eD9KZBeTZ6nHpSfd+p9jO5mgt+ZYXoE2CEHYkexmUhBa/AShhb5Ih/kVKiRSXm62kVUesr2vZGwERfRHXTqkD9fZHN0Gu936FjHWdPQCIoBD+0SNbB5PkcDEAZPpzKnMy93goFkb/SAWk6FGl5P791WfZliylqKdBGuamRbE6sIkPEu+JdgwwQhdtaCE4BXFkASym/;20:SLj1zrd16DSKV9M4q57Nc3biLfA6DPRrq9pR4uowqHHm7rzWqIbPjRFqvCKKMMkCUOv9ApbXcqnTdhfqxnL8Q951VK0veZOpO/zFQJVwgtEaFEYVZQyfxlSEP166QlR5aVy1G9ehuQE7PftZ5Z9ccOEjSXu23lEDvicps+7kiKNC30gPS/oSpQGK6P1RGG7EyyePasRK+36F3gUPU5IKw6N04CFgKjKUvmUzSfJHAKpLupa8nDVtHWRGrsia/fsv
X-MS-Office365-Filtering-Correlation-Id: 6b8c0b03-18c5-4d87-4d64-08d5ab6732b1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:16:46.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c0b03-18c5-4d87-4d64-08d5ab6732b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0766
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtd structure freed early may result in kernel panic in dma close
call back. moved releasing memory for rtd structure to the end of
dma close callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index b7bffc7..aa2fb38 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -990,8 +990,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1020,7 +1018,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.7.4
