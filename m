Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZoJC1fhUsyTHQf/o+RkbB3iSf9nuN+hLT57OcWiJJBWeVnJdxC0guLWeWlY0GXShIOhUX+C
ARC-Seal: i=1; a=rsa-sha256; t=1525754714; cv=none;
        d=google.com; s=arc-20160816;
        b=fPBvWPwBRvoZOT2BbOYA6MOdL1c6/qpLZEkRl2Y4FUrURLH7DprUw5Ruqb2HTY/0xD
         DrK8S5Q4WqCvRorYK8lScu5hSRkUOlSf5Vo+yoKClllm0Tg/652wyRWmS9ZxLuUlSPt4
         gD/qD3ScstdyPVHDBM351hnz/wkves77G2H+RGp/QQoxttcIkRu3h//Klg28ANq6oSil
         HHbFRgrHt6PQkk4oLdJMgKVy7r8O7IRxfSMz+qtY2YxQWEauWiSOgDPOIK9mrRJls7PL
         v9HFKZjqshiFmHtznKp6pWyOlMMwV1JeGtqvCLJfD+OvQan7LUigpi26vk7jKJa9mZHE
         9zYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bl0GQPvHEDwTxrsDh7bvbFOHIRUXS3eDSkIaPPTUWcM=;
        b=I234+gUS4ALrsyVCv1pERawUysa7j4OIJ000IfUMzVP3K+16Si/Ha2LKxi4ha1VZIC
         NQjiWy/LfW2CStjZplxAJ35hP0XsNtLySu9RW1trih1WcB1lL5Ux8yb6qTpi6QZI2zYq
         wzfrXh8cAdzjaA3N/WmlB9+zPbzv+EBtExdV5jus2/sQS6VrKCxB0YUvtupobYe5vTQP
         d7PJwQ342cGrI6jA8FT7v8xAQArIoTpq1vDHxHD1B34ddgEDi+Q1u84T6+TYNWo1SO/d
         gpV7pOn4hbJnu5TYhwWYfV98vuitp/k5VX6abhFiM5Fz+AZYIrHsbsHhOSMKEoR2Z3jY
         iw8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Cos9G8eR;
       spf=neutral (google.com: 104.47.36.84 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Cos9G8eR;
       spf=neutral (google.com: 104.47.36.84 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 03/10] ASoC: amd: removed separate byte count variables for playback and capture
Date: Tue, 8 May 2018 10:17:46 +0530
Message-ID: <1525754888-14124-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(2980300002)(428003)(189003)(199004)(2906002)(356003)(97736004)(104016004)(48376002)(86362001)(8676002)(68736007)(81166006)(486006)(2616005)(50466002)(446003)(36756003)(81156014)(11346002)(4326008)(5660300001)(336012)(7696005)(126002)(426003)(476003)(39060400002)(6666003)(478600001)(72206003)(54906003)(53416004)(26005)(53936002)(77096007)(105586002)(305945005)(8936002)(50226002)(106466001)(76176011)(6346003)(47776003)(109986005)(186003)(16586007)(316002)(51416003)(1671002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0327;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT028;1:7YgWQeeawY+A7k3AgxHZ/QTtZmqvzdwotMFQ2swsw5UXZH//464j8uaegFAotdRVzKYMXuV5VYG8Uctydo94pNkW6rrQu4b4uSwJQIcksZP60SHRfNvXa+19pqajBFBu
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;3:1IgUOYTq/UKyjVSHhsuKfiKgS1F3l+A1ep8f9Xtb/yWUIQHj19SzSor03nKn1nd8rO8sBl1gWZGNhykXofd1ia733ZmjbwukUfq1vbBBxScEVszxW83/rEXb7A2B73grgEd04PEE6WTgC7L8SQwSxYYqOHzGYF3wePXcKQuVFbDS5uSF558xFSC0J9GLTy5YA06QzQeOHMWH/5Ku2rEKx8kN3kW3Wqzg27nLjU7JMB6udh8eU78r05R9ZJdlOurGaJOaTGBo7VcSy66LZ1rLrHEgNru2PXt4rmL1AaOMHxklY9Lj0l3O9EkIzGjr8csAf91KJ4M577+NSOFEvyqPVKIXH1WTawUOx3SY0LyqnIk=;25:UBXTh4yVy/a0IXiQnHNbR0c8SkmSkVqapbK1AbgA6GX19Q26t9f8hejRxVLezgT08l0bgw4eGgJsmCF5/unXwxlsvEafaMMfjlR3Q2sXVJPOknbyPZXBz2TRdwE3khpLMxUPmo4DrIgF8sFcBTst0u6U+BEOucBd5+OQjQmGgftzPb6SXRUQ9l8jATsMOynSWBaShIkHc5vhhlJ3wyvT5xwf1G16ZCAQcjXeMZiuS3/I1k4OFW4grFoun+KDSSV70zoem8x1NkTj5LYDVWdSKyq/MrAu5I2xk5f9atGGeEwxieJ3L3nWCW41zWGRiUozckEb3SwHsBmAmx2d/ZYHSQ==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0327:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;31:j6Jz9wiFB89QIoupi6jWOACh27BwMUMdJ7G6uyPdtzYsSUA9Xt7evNY5CEvVLrNRYC3tfKF4Bp/kUu03AnSxOB86TPCbF2xNDi0P/rG51c1rAg1JyI7w9MoEapA34AAp8S6duN7Nm+pGCAI0pb9MHj4a5XlTmBOOCgi/m0iZyA99nKT6BvSpx9Du2IbWDnKqWWoWuammA5AUW0n37HRQi7TjYAlMhVEeFqq8k/f0wzE=;20:mWjGe/6zaX2X1cggO658aawnBtI9PbVOB3P5v07hqYL9iFXzxZGyC38pVkJGSbMY6RaNwwZm7+tFrd9vZV6nvIIQK7N5LalGlaZnGvVvp4t8ye147FxOGQ9ix92YnHys3vcN0RvOmRM9o60aQoCkDh6kkyyMc0RVNyxDzZP0rgAuOVOiBlt46qVZxAM9Sodmp+8IzgCGb9X3zMELc7c2eWR/inaPHa6Flks60UONjnq+5ENHdvho9mNj68PzdwPyxSgDUiyS96i4HZklW1knKp3E8bSiiZEi/WaK/WaBlo6EEB8dFUv+Tyl3bpMN1kIG5hGMj9Fd3F6357tnwNgEVrZhQJUvfm7hD8g521WJWwhSInvVuMrRpcHYo/PgLi0uoQ1QOaoTybrrH4Oqd48ZHTtfQeHFyl2NgiCQlBGtZRyXKMWcjitmkd+b7VOPBsEC0oGtbKdJlIYtC91dcDe0HktqPMpGc/JGCAIT4sjOXzezUUHv32YEEaxVxE6CSCuL
X-Microsoft-Antispam-PRVS: <CY1PR12MB0327947A121DDB30B9DDE335979A0@CY1PR12MB0327.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR12MB0327;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;4:Ud5NIywEP7Talq1cv9AqWY1JddZCq+lXiP/SEskeLC/AwZxowfrpEgbuqk0BfSSkF49o6rq8BzzTR5jBAYAjLLHsWeCCFxREanrIiX6IPdDEz5MURWHgKE4RF34kmIFjAq6ACtTIOlBvpVwD4tI7vW0t0CnnPNEdX95mx5df50H4JV4rs6VJDVeb10KdyrgM4edxBjD+HqHsgEFGH1xKYn1qq2pIQaDRlhreNKrnbPKdQzW8wXq712Ts2ZqcaN4up/mt8iUC1nzxBgugtOsMhZda1WqY2SbHRz2AGEaLI6GcW93cStnURi8BCEJ1feRd
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0327;23:7jIEtGbTrDkripj76637iICUf3k+PK/XZfgfFXxjk?=
 =?us-ascii?Q?mnF3XYqFKohdZ3tPOnJyAgiRJFdhu46FCH7oAu5LlLp65rlRmN7TC0JygPHL?=
 =?us-ascii?Q?TpaNNY6xsK4rpGrl3CRjLmn9A0JimCYdi5YK2Oj/lZGNIIOKhein1sIQy+la?=
 =?us-ascii?Q?plCl6xCUJZlw7XQV1gmiYYwMfA4jheUMIyS0VqELFskwC4QKG0UQu5Xtwbyz?=
 =?us-ascii?Q?4cqJN6Akz2dKmL37tKfEHuaYFZVhA6oEvut/Dt9T4yk1zdfARLL52BeSgz/f?=
 =?us-ascii?Q?MiwInq5++BN8n/nd5BzVq4jforbc/5TBDLF/xcYjVmTnaW5HoDd83h462Kzt?=
 =?us-ascii?Q?MggqU6whTtloOSXssleD5zrqdcmBV7FxpP6x+yST70/mi0LkjcjipZLL2U6z?=
 =?us-ascii?Q?oll8HUpYvNRP28Pxx9VIln+Q+fY5iWVHgbW9AC59L+redUlsPxkaTVChsANA?=
 =?us-ascii?Q?jIYE4ZjRqYM6nvxEoZeCRVYNOHPXpkvCMJbCjT8tNWMBhKY+iUiyUoS3Osct?=
 =?us-ascii?Q?EKw/FOZDWLIDFkV3yKRX3RliFWyRE6BQXIuFlsYgMwjhdNZKr7j1l87V+NHq?=
 =?us-ascii?Q?q8MTJeKYAuHO5UlUbSEX0hy9I76Xty4cGDJKIq16B3BAsoUGTnAFyPluoVQh?=
 =?us-ascii?Q?hhNvykZ/1os91MHaPZtmf3ipf/LYsUe/EDm9RRlNzAslVDAGqTyeU8VfJux5?=
 =?us-ascii?Q?Tzf9XGcfeAQDggP4xQn6gyFQIPMDBDiF+9V4+mgTxsjD5LB3KFQ7bGLiaY/Z?=
 =?us-ascii?Q?clNw6ePn/fvXTDeAeCUwlg+nr/y5h74hiOj9jScMsl1QFpABkeGg/EOpJKqU?=
 =?us-ascii?Q?tsZ4npZpEdaXt2YP5EhMeckvBq4FeGaWWxPsUZk+Auv6IoMwVUUezkGyBHQ2?=
 =?us-ascii?Q?swM6GAWVHr+zXwyXVB3ZW+jUubu80dFu5iW+/k07YZPTxq12Y/2/ABtX6QWJ?=
 =?us-ascii?Q?ncKFHBCd2stgLV5zrGHFu/tKBp8AchuL4CSyU2gz2LFhrWlXguvoM+GICPba?=
 =?us-ascii?Q?4DdZHyJRHHSgHee1TANvgbTOASHtYWzbZxT8KT0vQIbUXx9u6JGlamwc6boR?=
 =?us-ascii?Q?fYlAPwiyuKMFfiwQwlKOqN3CqA1isyohU/3odDt4OyBPFfmkjhLOmmMRxpFT?=
 =?us-ascii?Q?zgc1mKo3O4nrnlWfsbg39KDaxV9Ewi4A6oJ6bP93yJH/ud5P47Ic1ddZ7Cmh?=
 =?us-ascii?Q?IcTNjvNkUSVUUQnnvUQiKgz6eSip1s/hYsP24TK1B6KTo6WAB+LgpeQNDVT0?=
 =?us-ascii?Q?c57l7BNNIk/tTcsCwM=3D?=
X-Microsoft-Antispam-Message-Info: bjBVm1skiZYuNUh5xP7/ZCyaGPsWRvRUxyTYo6nRXrSLerM3sstyFT3YlSMzdsKOq12Qov4V6ia9TxYlWt/e+x+iNdDCE1IuEjOjO32HI92welrTTrTbaVobtoABHkUaJhuNpwyB1igp3zj7spI+dRk0LXPA7PB/eIt4YYkCUcUFbmLOdnI7wdH4HLcEoPsC
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;6:t6FNkDPDUh6TABAvIu5U+Itf5AX0DbK+2sxezWtyThzlrZKhC4M2/wP/ZSgsO3nLPjBKbW6HWnKG7+F2Zhr8w27p8bJ6a167qRmhhopd0vV8ZEGqKEA5IJUY7eQjnY9+NS6z6lQuk3MgyRsFhsafmSfX/kFXmRgBs1vMwUJOWFpNKQ+pJ9hFBhv2m+Et+iV85WtjblVTHRRq8gMpgBWFW2H2RSJOSr6EDb0jVpW9sVJQViwe7HJ+l7EnjiAWegCjMTdB4NtPWEu+4tLzSFLp5I8PZlvUH8VYIHR2KPWElZODJ9ZVKRr1AibEJyobDMgrTN9ccqMSbZt6WJXY7A25WBVXYSzigMqeTZ02iSwzok+SUWpZ3wMDVtBUFIEMVSWi+fspMY36Y8NhYqsx4LlY0Ll1u+pe93eFCOPKBsplx1mpy0K79LfZvA8XyT+LQLBrroI/C7+BYwf3XoOfDviCyQ==;5:lHb8fCjvwPetxlbCYPVOQ+xg70CW+FeFsNtCJ5pP5nDUbXU4ZJ4gEiS1Z99J8gjoOkjJIW1r7sMyqNb5vDijTMqgxLExVMuX3FNmSVNEyXBwECWGFK9qJu5v4gxpjwOf0jN6ORL0TzCGJ62OoL/1pMKmxm0epd4Ijq13qLrWdY0=;24:ZKli6a5GlyUH5dYNcMsSTtiOVU6zx3TmW+j7T0h1AfP3LoMTLTVs4FvSVjkh5rklw9828GEGlHMZa7jl4XZtIRFDBePEX9aHmg9eYG3x4ao=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;7:NCCJhnJ3/s6XWgrRBnPycKWubFY+ZNkR4lxIQVdco5DghENy7OszV4KbXfdsEePCQgA0iVAYuSfs+gG3s7TQO1NFX24XUQGX1GBUTiD4jdJvRk7qmYW55Ha6e4lni4uCh3c2HzhCUAtaiWFi+xtlbE4Q4kNmAeWKIu6wVd1ADcBszh3OZIplvwsZSoZCeTXakLWtLE+aTneAqW0ddBiYQLor2tGjTDzCdoUvt17YH6bDcO3JCYhsjJ5vSmToAbtg;20:eA28j3VZODqV24XPJr411Z2sIYTCwbPEXcHTI194K/lvXhG/2qtUbrzAfpFHhct6HjIbcWS7l8B5GC+hXIjhJ833Sf1Q4SDNY3R2dM+yTtVJ2EHuk9k53bj/1u2McEcb0n103avpk/7nNQ3/ei+ifDOFwe/wDE52as/Sz9SQ2XEwvHionyiBRulz9NoaoqhxfWhsCmqHJJyFHcA5E12g5aRP0KRS2adrK1a+uIlm5AjGtGEjgEQDiies0XSq9b9f
X-MS-Office365-Filtering-Correlation-Id: 1fa59a2b-2c8a-4a1e-b4c1-08d5b49e7b32
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:45:10.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa59a2b-2c8a-4a1e-b4c1-08d5b49e7b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0327
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869775255711131?=
X-GMAIL-MSGID: =?utf-8?q?1599869775255711131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removed separate byte count variables for playback and capture.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Fixed review comment in acp_dma_pointer callback
 sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
 sound/soc/amd/acp.h         |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 6e338fe..862c1cf 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 				BIT(rtd->ch1)) {
@@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
 		}
 		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
@@ -955,12 +947,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			rtd->i2ssp_capturebytescount = 0;
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3b076c6..82470bc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -93,8 +93,7 @@ struct audio_substream_data {
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.7.4
