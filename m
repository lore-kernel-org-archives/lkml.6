Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeEHEqp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:46:45 -0400
Received: from mail-co1nam03on0071.outbound.protection.outlook.com ([104.47.40.71]:10317
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751381AbeEHEqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:46:44 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Akshu Agrawal" <akshu.agrawal@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] ASoC: amd: memory release for rtd structure
Date: Tue, 8 May 2018 10:17:49 +0530
Message-ID: <1525754888-14124-6-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(2980300002)(428003)(189003)(199004)(8676002)(426003)(2616005)(126002)(53936002)(53416004)(11346002)(81166006)(39060400002)(446003)(109986005)(81156014)(68736007)(4326008)(5660300001)(26005)(1671002)(186003)(486006)(77096007)(8936002)(105586002)(50466002)(106466001)(48376002)(476003)(59450400001)(47776003)(336012)(104016004)(76176011)(86362001)(7696005)(97736004)(356003)(316002)(16586007)(478600001)(72206003)(6666003)(2906002)(36756003)(305945005)(54906003)(50226002)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0758;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT016;1:cmf0jWjy4Kl0IfMDPdvKZEi9E9KyxTswZXSLmetXwlGmp0jn3oL1DVrPut2fRV86VhUcK/VxADoOzOZme5sYN7GrXcoXuVW0c8vSsVZ/SK4le/AbQSqaxYCSeLdg52P2
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0758;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;3:fzf3DBaLu8jfGiEvjoxNZQQwFUPbrQYZkF2vf9abX1lxta+Tq61cRZSaeoBDQMv3sMtqPjrP6nrpV8xNyKp0GCYSbgvZ+fEObSQQIgm6dXtatNrSgHkEua7Oy29AWTSBEPO2tHuF9CFAAkgGTT/vVIahM5MsMCwCI+QVLL2zCGq7gJNl9Lvr5S4q4pd0bmCGVLZzbbzdXZLeTaC1zrNJSxSmDGBbdlkBaqgJHm3ZC+++E3yqnpqpgLvouQJM9mCK1ceJ5079l/YWCaF6H34PYXqNa5Qsz3mxT+bHwhtxfG8I1KP9pw9N3S81JV8kd8mKqOpiU6jxMMMHlaxud4uqfWwalNKRe1nmRdSA0zMrOfg=;25:BPOF/WLcVHVLCTVuQRHS2YPqHsbsJjnVO9p2in/GEvlULo2W8AGFrUmeosOwTO9XtTKzFDM6RfG5Ts2LZ3YA4oIcLU+Lz2zVpFOx6X6LF0RJOSqPL2o0y0U4BPZ3svMi9GH+Vcb7Jo6us4QxQ++S0l2S2u6KR2Ud9UON4SwsCF3PLjdGRvI4547ooOrnZdr9PipXgPCKeygBDAo+nbOnaSuEnsUmU+g2Y75WeJUweCZ/8Z8BIJF4X29QQJjF+58RHPToheDQPy8W1i0W22zRgbzlNkCoMZ/cwNw1x6e6kcu4cLTtIEzTiBUAm2sZO1Nkfqr8hKZOd5M0WZkKzu8new==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0758:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;31:wuWcoZ+UVTBJxKnWYWSlbM3tG1E2uBuCQugHSai06uVYiSxdiotOzOQN8yPZkktXwYz9XGDvh2hS4Px3v/mfs7wU7jnUmpW5lRnbKLdG6GrXQw3JK0Sy6EMIWtjjQBuDPAVZniIW/clUzju8b0for3mbPc+XbHl+XD1GpK6Ibz0AuKXRXrN00fw1ghkDh/aSiAIn9l8f+US46MvVDDHryqLxjAXi4mJd1W6i/M66xvI=;20:8IHA1vOB/1v/IUW0chK1T0w46Mk7Znft+Rfy/JkLuqe04EXlL/MDej1QpbiE2Y1Dw/BX/eaZ53buBMWfBm5fOUEIUN9li3+NLdxHJo+7MLb2pVNdslATsyn1x5ZLcvwCesQZCMQ0hqLG4xogQRS8QXHUD0rERN/Q8faQguizNguP5/fKbPPAe6ldrywFOw45HXmZtX3BJplPW/O7VE7KVFKTvMrXvLHOBm/eutAjx9zZ4VLi1Go4uxs8K4rvfKlXhqOYmbnmrAGF5Wow56A7VdAKr9F1ubuV34Hn5opP4UA5m0g6fjWjH9islTDrdwIOAe0bhtoN+f45RSIbtGqmPmIgTFdS2tuiHvfH3b8Fb6i7A3tCqX7duW6OzqI1IE5Wl7BVLAsqlgPyGO+GIiHoHhW0IXrj+BrFw209VVKw4US3x2Xyjf/0DcUfkH0LFW0leEhTfkaE6GuKhODJtq9pZJ/vC506rYHlF6oVVnQ7kIhZc9lzrBjwl8XK/sluib4u
X-Microsoft-Antispam-PRVS: <CY1PR12MB07586DD46D8751E2A05CDCE5979A0@CY1PR12MB0758.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0758;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0758;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;4:/6jz+/3Az25sW/bh7pZhXZ7w4GZf3vzbPJdhDrOZWhY57wQqcII+26jKlLBIHfvYD9YKU0J+0e7JunCushA07SzbLxY181N5RaXIBZZu6p0f/wbON+WjQJe0FiQJ58ay6cqgFGUe6sdB3n8Bp4s8b90veXgSa5V8nkrVjOEbWj9s1DJGt24bazdaj4A7We2bEzLiRfujkOG6b2r8XOnb3U4UadKD9wUNoZ3VdCw0QyhG72tfeGbMdZng6mvXzqF3GpvI94MW9KGxBOwQTF/6ou9vYeEetGfDGpXx/I64RcGRF05KPUktOu8cf7ZiMBNG
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0758;23:AILMtHpt+kk8h9FC09/cFQ/AEoOFqwzxuzTCOasB7?=
 =?us-ascii?Q?2lhbAlyyRy9qHEIMmoQZQtctuTo8H7thLDP9ZcSRKDX6GlEmiRsoMz8Oylpk?=
 =?us-ascii?Q?cVOp101CPbo9prpvqFLTjh+M0px9CJ/N7mCVXV3x9p28zXkgbGq+WWkgbYGb?=
 =?us-ascii?Q?BwTBa5yfUT8Ymx9AmK8TlvSG8xXRth6iaSvJ/M9oLUQiw9GkGBUdRL68cjYY?=
 =?us-ascii?Q?S1l0iMGQabvDkS8+Xrbc9R2C3tB7c3TfwRnF3xZZyfAUQXwTrK0YvmVTVz2T?=
 =?us-ascii?Q?datrIfKoKBgxeaGWQi2ck2k9MGk6IAMeR17kBD7IjwJ8kzth/NtZ12YkDjJe?=
 =?us-ascii?Q?YjnJmZQq1ZYx5Bxmb0uA5VJZ4D2Rp+zCVrD586vXBYRZzwkl+2BFaXnQ8L0M?=
 =?us-ascii?Q?ZFXaWSnQrYQ/6727ALcbTtmnWU09qQ/pD3uM3K80KWZW+KE9EhoQe+PzNZpo?=
 =?us-ascii?Q?JpotUy5yzQJJiCCods8BeAqCEoB4fl1DjFyomiidIRZKDI9GVtyNM7iDDMny?=
 =?us-ascii?Q?iWTW/IS/LUtcSw0oHwJFCBz1/c9Bu21o2Vww8BzDKbQAeioKCFx0tH1fi6Px?=
 =?us-ascii?Q?znOdE+dE//oeBhp6w1enADJ/tyXSFEMhN951sN4s+YEQS+1xDWFjDFaRf2h2?=
 =?us-ascii?Q?TSKR5WWQOjnW2HgGhY+AJJ8MtOGkl0YoxN6BO7bKZiyUpH2gPtWr97XyhfMo?=
 =?us-ascii?Q?Rv7sEKf3gMXiC6cU7LmBw20s9J1dT0PM3wRyO5Zyesl2qnagcsP1tf3ZHyQS?=
 =?us-ascii?Q?YsQ5HL/uKDLdqT48f9aWn/HoPVIQxuR1l0sJV1RDDcGDg36Fb7rvz57OUi72?=
 =?us-ascii?Q?PglEab69OTCI+M9gB5IfhAOBumPOJWES/e9dfaZV3UXN4B63w8ywpXqrhhpF?=
 =?us-ascii?Q?zVMZm7InZMEvPmArhO6Kkf76cTyzvzEKvplP8xs62YN5EZbt8NgB0j/n4mYa?=
 =?us-ascii?Q?LCiqanj63ShXKeZ9Lwi+nmOmV6yL473HsfzI+JINl/LwN3EXz7fDU+DFyhuX?=
 =?us-ascii?Q?3+GNVWm6WPoIdQcItEeXAQcP9emOWralbRdGriXZegu3ZtBzlwqb3cjkfiGX?=
 =?us-ascii?Q?01L/DWQUAR4k2fmxOepuIXH9JU/9Y2hOTp2HrCfoiraBCSkMM6+7u0In276u?=
 =?us-ascii?Q?pEtmwKpgYfAux/OrMuh4gsGzF1yFUgud7WBtMmVE/yVWRF4CmSXZuAupIUfh?=
 =?us-ascii?Q?mU1uln6E0IYx87Hz26D63SECf9iBmzlY4EGFc2JaSKl0zxGIGQU+dl9cCgL1?=
 =?us-ascii?Q?SUrCBTChRZ6EYqEWy8=3D?=
X-Microsoft-Antispam-Message-Info: P7IabstZDja1Joqr6+FS3J3M7dQ+lE9G6e2a1gPDHVmXGB1e3JFHY20tg20pxgdtNSGDhrsXqqliCOgrE82sC0vv+1W1MdsJ+m2OiMMEsJHVQjWsd2PhejaudcH19PE9ZgeFndoMWEmwYb8jx6lvRikLZjPOhwG7fSL2mxEfgdi8tvo5xl3pRChw9uTBCbj7
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;6:eFF1FY0bSjAgwzBzugQW6OyuC1YsjflmKF530goxhYs2G1EeUNayxfCiWnfnBGSglmN6HZs0g/Il30MQyYt9/rZ7bp6Yw2D1bJ/bb3fEQbAs0THWwuMoO8krSix6GGic6qceEuCwUTaVaUy+RFT6Ti5Ag33CeceeqgMZphsca1wvB3GsatLTCKJXuyiwHPXkoiWiyfq8sFvCZHbSICKFs0826sUOVyr1Sw4mzOUmAGqV0cwcDepj1lZjriyFXytp7e0Ju3UrcDZj6AD3CGSCJmAx5/WXtPIq7/7sxRqP51udzOIGvAMZErRoCNNaZBOxp4SFaVjZS0pF062+0IzBXJTscqhPjn39QAjsywGoIuBMVbZ/cSy+yLAL/fmqSUKoxzKLlHUGQVAJTp3Jdd12GMV9UxypZ2I6K133MzkejbRiDDVsH7p+FvVSszK0rf7/JgehpGFEvSGQ0qNvRhHKsw==;5:I95afdC/zU6XFxbKkkS75IL4tqRT7AhzlBZ7f8CTMlxGBHgOx3JcODuH3Vf0Wvo/XOQsuk+bBXUMk/K24l5h4bX+wW8kMGagBwjhSMsn3OX/GZwt1dJCTC2TK616atY8J+l107fMx/CgE6lbmfIVIGDySpwlfDveyoy5GtYJwNg=;24:DN35Gql544fZcd9ypsIfvmIkyx+nKTxe7KIx/eOBgqd/sJje14d3enEcY6hgcUpyAWgsaWzQqTjJqyDYRcEwFGxBT8oKx3rHKDJ9AcNwYW4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;7:LqAXtHM+nx590qvtYxMcqzazutrZFEfWKsozdjoMhVpm3nFlCNkwrVNMjOLbmilvr3d8p6Za3s8quLrK6q1//1Ylyme1PFGGTG/7ZLRR7+Ito/W1tIVPGbAxunK0jp6lZWctak3RmVw2klMItfNp9sRy8dULPVgtVyYBaTKYX1D0pBlmBa5W4d3prqkL+pHE8Iw8WDecdVWtD0PEGplHPlwF6TqZL1qxCps/p6jjvOTP8yimKxigbjjGr2+s21Ol;20:mj/8+xZ38A48L6LAKe4gacrF3Rqf+cCAYn81n8Auy7q6qz6yR6FDC3quuNvIlBuUcfBps9fo6GxgP0aS74QUJDYVBSEIEeXZItwXIFb9n0b2ovhH9gBAp5Y2FSiU19jQibaLkIal++hbhQyOV7WdeQu98CIkF3c4Yg8PTJioqHUfaqiyKMd67MxARWYjI3NYGb2sYez0V+jyiYTEPZ9A113E1iLp50VBV3zOyweWUu6ryu+Z8npvFxStqXM9BdZH
X-MS-Office365-Filtering-Correlation-Id: 154c0d10-819f-43f7-4dff-08d5b49eb110
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:46:40.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c0d10-819f-43f7-4dff-08d5b49eb110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0758
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtd structure freed early may result in kernel panic in dma close
call back. moved releasing memory for rtd structure to the end of
dma close callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 8236116..ec9cab3 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -998,8 +998,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1028,7 +1026,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.7.4
