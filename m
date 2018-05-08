Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqYPEjxz0M6dlpHTahJfcBW+SXJLDmxJx4+FB0qf/L7xK7YaCllJrEOyaCm0j3q+M7KEECf
ARC-Seal: i=1; a=rsa-sha256; t=1525754763; cv=none;
        d=google.com; s=arc-20160816;
        b=SnMTwTa9h0n5uVwIQfGmL++fV+DZLihHCE1ENayDnNj/lyMAhKpBchk9G8bqyYli53
         sLqMFECbqiE7jKa+IZ/BPUKvgRc9xZ1azzKWQrp6wIal4kr4UCFyXJWjs4i5X+HZ8z57
         ITx/tGxZHMO8kQsip2TyD4wLAJ5n9CLRjusjVzQtnAIACJP4eu4Ssa33gOTZP2ux7dUc
         2CUVlgc2CetbbFlYRpYayyKcdEmBTZ5IsL9AGNkOwaBrw1s+UwBCaAtjGWu5xSY6gae1
         taYnt7EJgbUoqJfrDmaoQehPcHOjlCo9je/GHsnMUD9oSEBqUyD1oZl0ddVTaMD++I5k
         hDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UnULbNemday5GmSbpo2I9F0sSwEVaZnAe++h8hD2tiI=;
        b=YIif4GBS8XF2fUL80AbOJiZqWbz+kFX0ddHJB/wzYhwWIIk4O4F1uR5NdbTcuTI29X
         yqhEuV4xq0pHgrjquHSbG67oV6HxQJkd8vCxbkymZpMFEUvbMDQoQLDdW3NNbRNu2rL7
         cF/i9E+dipwHPSDzPSFHyprf/jRZyCo9ykyUYCv7fkfurDjA5CAZqlQk8ScbIgCJqS5x
         PGaD0Wdh8J8eMNk//5TbTu4HikrEh7QpQBQMYN5Q6LgIqmixwKv++CLiKCXxwwkflPFY
         NSOv3bnjH5AEc88c4qtHALmFyztaVYn7fZgAnedPS6HRUOlRlzoF6M3cltZyBVcGSVFg
         pb7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=mRVDD0YG;
       spf=neutral (google.com: 104.47.42.49 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=mRVDD0YG;
       spf=neutral (google.com: 104.47.42.49 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
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
Subject: [PATCH V2 04/10] ASoC: amd: pte offset related dma driver changes
Date: Tue, 8 May 2018 10:17:47 +0530
Message-ID: <1525754888-14124-4-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(428003)(199004)(189003)(54906003)(48376002)(97736004)(7696005)(2906002)(81156014)(105586002)(5660300001)(486006)(8676002)(50226002)(16586007)(356003)(316002)(305945005)(446003)(8936002)(104016004)(68736007)(106466001)(53416004)(26005)(4326008)(47776003)(53936002)(478600001)(126002)(1671002)(51416003)(50466002)(11346002)(426003)(39060400002)(186003)(336012)(109986005)(2616005)(76176011)(81166006)(36756003)(476003)(86362001)(77096007)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0321;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT015;1:GomsoxTlNPrGPBkyLYIG0PsfNsMIGw86hcQq6uiY5AJVVFvLfhJSHOLX3hOBkiGe2nweKaD01NkxeXCHuz7627LQ3F2/QJsHns1fSOY3CBtvxnqNYOPrVwpEZ3uER5tC
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0321;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;3:ORe4JHYxKn8Ymb2Im0aOx4GYzxtgoMBgNoS5UkYmuCh6mYdfjITeN+FkLFQEXhKX1j5oShLbedmPyv5Eczb1GRn2Rif2ZuRxyQkzWQVAsJd8jAfPqfUUO8TqKobJkwmRUqdQZgtP2Wfk5dzbSZFVrQCI1qmD1/REuDrGbkKf8Kb361rS0z4prF7OGIMaDNC9FxDnwI0QJqqwy+xrn0gJCHrsRaLT3JzlzxRwLbN8Wfajw43xK/b5tqsg1a2Fx3kuns1bL0t6dtSAnw1Os0mGyaQBb+ReFYpyYr2c5kd2JFFqfniX6gavZIDMVAeB+tpeDfuPsByEZbBNqqE1OvQgI4uZ73+X/52adYyN32ehRkE=;25:5muTnYqRB7+vqwaxBn2queMTxvKoEi6lY5rwqB6A22GyMW+7UHls6YdoPJHvudU9WdwYGsYeNhy1JkLKzUkkZ6CFnszr/QkBhMRw9xMbQei/CczCs2wPgLanGgHzEnMHiJglhEZmaLaM54/HWGWVkn8ycEwYCAofZTmi9O7HMpd47JCllQOPxHhkKTgi2a0r4+iLa3a1WL9aIRNXGELTWQxq9jlUkke7cOrhV78KK1wwC2SHhF0oRXeuPkrcH2eNadrg2waJg4zwyHteYP71QKVhS1wA2WhYco3p1Za+3vmIdZkWncQpLqt173IAa7UojMrHZxMd3v9IDbi5T61zMg==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0321:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;31:Ir4kioI52VLrZpE3oRyLdQX1FeymNm06/inX/DRwlHNmuBwY1Ub/WcCl/Ah6Ev7JKSf9D8jFEU8OIxTo8kJsrzTouLdKiQ9ndSRL0u9VoQbkAISulDQ/k2E1j6Ha7xu0MlLvYfmP1dq0u+zlMYyTnA15ZWQpN90YX/Pp8eVZWjtz0AFXwECNoPNmZceL1rqt3qHVsfissMhdjrdhCq2nSg8rcJ4lidukIgAJmcSC7PE=;20:Uo3SfNSoajLM26+RQFjrchR4LsgAE+9Gds1wlEqtbESQC5IZTNzozmRmr6DMaU9SQSIRr9L5fNp4zH01NQQdwOSG7W8g0iWyAEVm7oMq5lONHkAITt5wZw8Ju+kcE68YT3u14l4RmcZJnLrLipf87rFQxW73ThNIjBpFqzj3w0swnhT2V5I6slwv6bdc2RXZLb9KSMylzhcbL6Z6b4EmdqXb6r7Ie8xzHnbGsXfJfdT/q2We9RwV2WW0D1+Mo4PoSbfYyGKMlElSDOch62SlLSskzmcTfDi8sssm44PgB11AXxnOonPq88c0h8vof+t683uPfTKaGQaWCX5zqdna0CWixYR5hyCGr0jYRwIjePReKMZm62xv+i7k4TPpeXzKu3PITP2WKdHY6wXEfpq63FU4NdfyVQch9CEaHaKUAfk1oIcOzNiGNO1MLc0xJ9l3rBrFW1y9JUJLWToOo6L/GgvN98ZN/a4C3XTByTdgNtsuHpIXvYi+eUlM4DKil8U2
X-Microsoft-Antispam-PRVS: <BY2PR12MB03219C2DEA1CD13531CD78AF979A0@BY2PR12MB0321.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0321;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0321;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;4:tfoGKq6kgR/ZD/vuInm1bJmmjvY7tKhYjTlMHyg6T3gMKEU6AOrYVpnGigNCE+7vgSfhQpRaJmfIis9M5XUmOM5wxbYCBnsE6bUS8b8r7BAtdAxFPA6mW0RHtxek/CxnCSAl5s35KnXN8qvhnLRHh55zkB5WYnzTxymjthanIXlG2W9F52Wypiv0t9wlq7z/v+2XzrZo2H7dix6e50rrnk6i0weAdLlLflappaP/RC9m2NUcXBmQG9jCurhjeTMJ2KbZqJi1Xlf252sRcSLAXpjKQolbPIM5I8KHuJetAsTl8Cmzn0PyFHZQg+Dy8Ov8
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0321;23:lvAubCFDTMtXKY6TGjDdLmIpvlewQRZuV/OshXFm7?=
 =?us-ascii?Q?unkpoRcFVRMwGyMI7PTsf+6kzM0MfsKo3w+SPYjhLe7eWS010bJaKc084gJv?=
 =?us-ascii?Q?UHpL+awEREO3S5aBrMJMnA+C2TyOnjq/YZNDRfakyVsZSXifwfQkNQ/QoAb3?=
 =?us-ascii?Q?tHE3zcbzXMarENnRlFTCl4wMhsRP+/9uOGb3wNWlq33ZJ0c8SG4ir+IFIgza?=
 =?us-ascii?Q?dcgtym9J7m1OxzDfZxhxoHjMoGjoQ87iOCCf0rclTWn4j0R/+pjmAMp02Usc?=
 =?us-ascii?Q?wrI+WdlB73WBBkg4RjHC8FbqiusEwEPV7XxWd5xDkl2FcU8y2V7d9sbUF8py?=
 =?us-ascii?Q?BTSCYSElW2KRBYIKgNvmAYpFXCfnri1LlD4iV6yTWYUhcz1N5v8jsduu/6vo?=
 =?us-ascii?Q?+LV6XrPfBGaidvznOq+wSbQmUMSa1VFaK2JkmoIspamsun1fxKQnYNfPX/dP?=
 =?us-ascii?Q?KHYCSQtFMx8LLri7qyijJxDahf+GUD2FNCXGa7qiGFHugjawxM0nhJTg++RK?=
 =?us-ascii?Q?Sh9silWeY7IRjQoDl+LOL8ZgGYDY4jGHLIw3JS7SBqWjFYR8s3W8SUloj9zE?=
 =?us-ascii?Q?Fp0KHg+p4qJAL4Idognd0iVFSOQFYGnxjKUfeW8JZ2pmehFfL3E0N3z0ntkx?=
 =?us-ascii?Q?MBeE1IqDdTXZUTb33MCslm3e01c91sPoe8Paa2u32pUu5tln6PmI7ER6HCm6?=
 =?us-ascii?Q?lNTwaxDsxrYAD5h6KaN0hqW7dDEECrp8s4Bj/e/MB2NnPa3/LLvkehxHvM7D?=
 =?us-ascii?Q?pRR3WemM8wBa6uWGknMEdjUKslsxgVSJ7euuJj1hECsHmvuJWBAGFOMB7yuG?=
 =?us-ascii?Q?+X9kdTBjdbBtpGENSz9AVEZYFXsO9S5DvhRiL2uptS3xMzpkWm86/k2TOuVE?=
 =?us-ascii?Q?Axu5bdokWvlntLLEzKYApUkuLZKG7qzR+r7Cod0HTESwBtOsglXf2HWHIBCT?=
 =?us-ascii?Q?5FbJQ1hBxjZcBwn21ZtGDptlzW/NEprUxlLojv4zq9YW5hrvak6ZlzXv6CI2?=
 =?us-ascii?Q?jM/fNHSj3Y3qof8f2C0HM6pdRxudcnjdhpccv0qBRfFfy1UZpCSyj1Bcns/I?=
 =?us-ascii?Q?GoXbyfobkHn1pG/1EaDEIOdYxT+tCbHqK7f9aQZxWi04q9iah0wjS8+PyzxB?=
 =?us-ascii?Q?Bc1c1x6cFVMBCIqlfylZjkdIZfcviF5kuF41A8jOh7RXjJrxhv2alHUT4agJ?=
 =?us-ascii?Q?kJmm+5RtizYgmsGqMZwSrdLDb47DklUbTh8?=
X-Microsoft-Antispam-Message-Info: U5Ad7nb2DlXqTobXGxAhqirb6zVlqZJbvmpTcQshti6fPesG/hZ5Z/dvyWNKmGHJmRape3nzFpUlR/7grAsPhZ0/PyQ7ZpKgjIiK4KUBwxo99QNUrhJb+O1QGXUU04+1S1em5SN/mE+TrV0X3i6dGAyxQ9S2UWnj7/sENmou7iL4HyNTOpepOPKArHNLkUym
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;6:M1A5DEnbzDqEombT8e3kIsdKb8ENYD0FVIfoALWN7gYsZP5fvMD29EPRTUXracJZZM6O9a5DpNCXngK+3TT1m7HbOO8DJH5WP2DBQ8k/E/Z9g8BGJxAgUKCjR5OgSFQyAD4w5eeLcFIcV2APHsv0xvxcfKSfynB7It2HqhSEEPWnWD/I2u0u3fLMg19R6c82LzPiiu3jtORMzacOPh56hsB2I+G0CR6pJaO8OT1NeQP64CAEZiOfDOkjpgK5kbd/eR8SA9LiDq8HcZMIaJr+njA9Aqn7KjO9odZbxhv+kVMVWmn1cHwaDAzQc3oobmp6+50Gla0q9pn2BPur2+CADsp3A0PrKLJNgQ4ZCbXLoMht0B3gdRURLEjLsHYmpTd63MBcdqDyZu3acL1DzqrGWIEEnbR9H//0orYwt1s5CJtPG1feoIAOkr10qcv4rAqfvVhZhsAVRAWOi24+bcmCLg==;5:jI+z1EtAUbanTgIFQMTqAP6vZH+HbRmbxMgJUaPdMG9kK0xe2M/P96wwRYRS268F6Ywa2yEOGBcBioNE23qoq+CTtDEt+bxcAMFC6TkZHRYRXdpribhjgiZvmJk6OKdF/sOCHNFcTjKdYZ4s31bfymn625W3FUoUZpGzTKUOR7Q=;24:5FffmcevVRuIihCIzUi46M6dNetvB4CUKbmNoq0ICUTU6mb87xzpE7xKLRbHgc2fInubvynJUBCM1Gh6TzRXTpw48nq/F7QbRyadRYi7HZk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;7:tjSGJUO8sDXfpHh38t/NPblRXIjQwdgoqUs62Ka597KONvqeixiLYVUQG+EHLCcYLE8GeAPb/e1/9LpQOS7cXxfqRL1TMpE3GhOO8SKSebVMZzRg3pwnrMTVJNGbcDss4SQVWhz8ka1250CB75y2oCA19gjQXNJsubOtRKcHmofVxnHPE9hAk0XzHMVOdb/Kk23Uo0aSYtYk145tl+OvBaEbN/eOG1g19395x3auklONCiTIKJ2ZMfOrz7MNRcZa;20:xAQ1TTTbmxRtFS4ccaMdAYIA02W+zFl+TTfYx7S1eLFdxK7nfeBHtqzhLe0NYPeMizlOQMVj9DPhe3jN2b08212Y4craQHNWXNF4xwrgnW7wR2aqgKZnwk4oo8Si4FNkDr0qHOeyhFpsBJ6ZHIOxXZW1TKLXut8yONYmiQear8MiXZReplod4l66C+qDW6c6EMtOsRuVFRVd7Xs9FwfHExdkB20sx37URkTFEaIGAKuiFN2m9sXmAr2kU2IiE6U1
X-MS-Office365-Filtering-Correlation-Id: fe6f4b11-82db-42cb-2149-08d5b49e989c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:45:59.6619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6f4b11-82db-42cb-2149-08d5b49e989c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0321
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869826856023070?=
X-GMAIL-MSGID: =?utf-8?q?1599869826856023070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added pte offset variable in audio_substream_data structure.
Added Stoney related PTE offset macros in acp header file.
Modified hw_params callback to assign the pte offset value
based on asic_type.
PTE Offset macros used to calculate no of PTE entries
need to be programmed when memory allocated for audio buffer.
Depending upon allocated audio buffer size, PTE offset values
will change.
Compared to CZ, Stoney has SRAM memory limitation i.e 48k
It is required to define separate PTE Offset macros for
Stoney.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Modified commit message
 sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
 sound/soc/amd/acp.h         |  5 +++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 862c1cf..39597fb 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 pte_offset, sram_bank;
+	u32 sram_bank;
 
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
+	else {
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		}
 	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
-		       pte_offset);
+		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset,
+				       rtd->direction, rtd->pte_offset,
 				       rtd->ch1, sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
@@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		rtd->destination = TO_ACP_I2S_1;
@@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
 		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 82470bc..2f48d1d 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,6 +10,10 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
@@ -90,6 +94,7 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u32 pte_offset;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.7.4
