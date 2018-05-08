Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZoeRVTQY+RYne1xiWn6yLijubts513J+DW+4yfBJqFLgKGj/ov5v/jGG88OLuSKMZzrpV+S
ARC-Seal: i=1; a=rsa-sha256; t=1525754686; cv=none;
        d=google.com; s=arc-20160816;
        b=Ej+DzKmUAEp4OsWJHrHxE4QkCY32N1jPaesX71d/mMpKFaIOs8O/sHhbfyODijVoBy
         j78EMG60BBNEulbwkDpv58zImH8nUG4uP+mJLHPRX5eGsGp8812ZuiO79GeE0ZOE3Yq/
         Ghvx8W7GITeHC2aJ8FhlZQ75w62vksbx8SMlMPuHtnGkzOubCwxNmaySsI0ZP/pe7pbk
         aKdtZGN8ATMMlrq8e+IHkAab9Ekjl9N5Vqu7/vp4mETsfiAlNEoYB0iU+FzFaxmm3FbG
         afh2YN/9Q4yvE2LoWPbnsoT6diXuxwh3snYw+FCt5ro1E5FBW4P8ZitaLrVyyu6pib3N
         L+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=keT/9DcIaRDIRVnHO/3x9ViqX2U/wsMse1daMxOlyH0=;
        b=hQcap6lSSvxPTEWTw515qk85Zvt4I5xrH6pPnLLU8GnETO2QUmo+K163MiaOPHTGH2
         SK85R7wtczke7U7hqNNc/lyXC0L2ewKX+t2MPk+9j7AaJD48/7ukxPOkBr80L8Z1s+uv
         5e2N7zwZMbD6nkrKji84EJ0phKyQBLaU60uwmDd/e0J6NKCvYXaxwnxxqjldxu4n4f4W
         c/M5PVJuFfVceZO1dEH8UjYuydJXDIBRQfUHloNos6/SQ2jDCmYgqcqxgnYnnbuj19ii
         tBKzE6GpYR8BPWmp1mTWQqMB6SOEAYYQ2uwdM+J+ktwhM/f3q4IZRQKUPYN/jk0mibBG
         ZisA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=x7eI8JA7;
       spf=neutral (google.com: 104.47.41.46 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=x7eI8JA7;
       spf=neutral (google.com: 104.47.41.46 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
Subject: [PATCH V2 01/10] ASoC: amd: dma config parameters changes
Date: Tue, 8 May 2018 10:17:44 +0530
Message-ID: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(346002)(2980300002)(428003)(199004)(189003)(50226002)(305945005)(72206003)(478600001)(47776003)(68736007)(2906002)(186003)(104016004)(5660300001)(8936002)(97736004)(1671002)(2616005)(109986005)(77096007)(316002)(356003)(26005)(53416004)(16586007)(476003)(336012)(105586002)(39060400002)(36756003)(59450400001)(81156014)(126002)(81166006)(106466001)(51416003)(48376002)(426003)(4326008)(486006)(50466002)(54906003)(7696005)(53936002)(86362001)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0322;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT038;1:c3nsSVyT6IsS/2N56KDVStSUrutgq7qXzzHdWSO3NIxX78Tm4hfx0dbVDrg5zb2DGxHx+jEOasti14kfJcH7OnxYw9ZpyKRcNWBYuvxIyEXm0wy16dQPS7DmWXK/gapC
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0322;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0322;3:J7fkSygbbqM+k4HtCH5lMwh9FPCbutNJAQajCAdJKOqXt7nCzNMWfaXWdbqGm+oFMI2dBe0VRZnpQj18z8J0CuhCUi8W15cmpGmKp0t0CNUz2hHpithJkhkbTxM0xxzCI5hNtOdPE6Z1vTizJPUKATkN/Z4y2154c3SJso1vj20M9DVJbUpuNWQgGMwQXgTxgpwoGe6zN5ErTfvBgUVmW1tjdjb72hDwhs6Yf4Zl5UGT58dSLcO6dppCmcFTMbzl33+PjON0Lu5ygqJ7rFHIfHIaWvZLGRJ0FYDYNcslW3NxG1j8JnfWjCbZQaK108POawv2jGTzyoqYSmtdfrH6kfuP+fPfWA4WKXCnY1U8pYw=;25:gx5jFYjyjECMoQNVw0qghpEiYXCPGwxSahIoFOebkkng0YxdFWVQodkzlllt2JtZLxYE8Ou0/TBx4uUX2cnIhgwNKFO2fZXIFoGT/vRDL6ZgB+HYX+b1XiKi6838sR7Q0YeDPBhxoENA5yrxnqzT2vgtifzaJamfYQYsqiyCHqZ1gwMlyiEfkH1RwHvREs4Efab+fGm3BdQjhCDkuPin7byQcp3M74hP+mnJL3rhkEEnI/ngbSh5DGUSHAIFut3lSkS32ppqyELaH/ETSCu1/Ow0gBf0fbrpdJ5qz1ZV30iY5ZkghTOFxYhhafZXNFXUaH/EgAGI+xucG0fTa6taJA==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0322:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0322;31:3LAH9J1/QoAC4WpxkO2P2BEw53W0F1kClFBTsAvtOz8pri+1/BoCfRtU2tF+qlNw6/xrIlX5lkGhROICsfnGToYdMp4p8/gYKDPGdkj+N0Ua5h9HFYXICVOo6WWlbXvwLtd8XadM2aSBUfVT4iA2IlHo/bGgcJbZ2kn0GxRez+nRnIx2VtFqlSV+Yjs5Ac8LPnP2aRf9hEMyr/18wOT6hnRhOZLf7TGUKkQ6JTDWFlw=;20:jZKNctILBcNEj06a5aUCAtVV9crs0EUybc4J097CNp+l+27kvk23SamkOv201bioyIsN3zZzJba3uSUUys/L8sVnmFlvwwEcbR1oK6XNIOBAlp6yHFh/8MdaG87A65Zzso0TnQRMcI4RVT+9w37a21zahCXLpkcV/FY/vSl29HuhvXMTlpJK1fMeySfByTD4VtVoiP0vZSL4mOnLKjTgWwyDfXt4jySg39tUoDsNkyA2w0rcuETDBNhhOJSq1MlvJY5opcT51ltNer3Nyi50u+ORE5BADHUJHXs11nll1Gy8alGBmYqhZRixo93irCok5UHqvjgOvw+TdJjTvC1k65fdgEZsKdimzJu/LTEuFpt11+hn95Cb/zQBVsiQGC84TOfCIqW48qOZqeOthmgII1ZmW1iR7ZGV0iR18W0Xy2C9RhSCT2B2672DvAtns6h3fwHbt98V6DM7qpLBv/qLcK6UppyNP3NsjXCOmnRu5CBDZwxKVsRrEXHOOLdeG3oB
X-Microsoft-Antispam-PRVS: <BY2PR12MB032216091868E0F94F7C64C9979A0@BY2PR12MB0322.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0322;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0322;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0322;4:6hySKW+XZTz43s9HBql94XEeE7gJODu+1yDtjkpA/v0h9H1jbgqXenH7adGa64kGBfHkuxB57dWyZRoih6/Zqc0iJkbWvFKVFu+f+jO4ezWP/i+JUSs3yQl9F3ygts6nflUv8iFaEhwPzwRouVDazNae01IA4xh3fFftluHZmjp23aaOf6LFhZhkpEgYAHu6+Sm73GbHCXLJOuewWksnBKrDN+Jk3ImMBK0uZGQCPVKL1h82Cit9w5PPzqWf+d8vOJGt+DZjly6kSEXAlsUYzrEYnQ9Hg6La4mtYu1EaAltzePKLb7hcDFYVppVAhNhz
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0322;23:TYnIn69ZVaip6UFSpd/M7B0l6jCvU5W2Goyxk4ilq?=
 =?us-ascii?Q?GznFoBdSCs4vcpVeuodpByPKlHLXPVvU0Z06kPh2OccwYtxrjDFIYPqhKNZ4?=
 =?us-ascii?Q?I0W8U99KXmfWOXri0bd5G+KRl5hhj9mXy2xuK4B0p9DCcqAK/VN/EOO8n1dZ?=
 =?us-ascii?Q?h6P7rvHVmeH8f5U6iN8mN1q3LmMnSSBbbKdT/2qoEBFoj318R205bcyRasS2?=
 =?us-ascii?Q?4hn7TT9ZOlXyOLZ23HXHZ/EWEakhScQM5kSDdNXebIwoOIpL/R94V9EoClzJ?=
 =?us-ascii?Q?bEuo09jdwu0fHQS+OBraqz1uCXvA2s1TRbU39lYfKfQ+oDzzZp1l3krEVUjI?=
 =?us-ascii?Q?A5nSHo5USha5q0rXWADYNIty8JFQeD41xo7t5lhUwEAxXo/AAAp0ukNy1402?=
 =?us-ascii?Q?dER1rL+FHuAmC3xOQP7Inu018OMvMaVLBx2nFd/qQUBUzvy6DLhVH9BnfpHF?=
 =?us-ascii?Q?NNRhck7XEUVyX4btJ7SvNV1hjSdr1qhWwFhKneqHJYACNHwhq/i+iCQZL9IS?=
 =?us-ascii?Q?D5GGL1bnluSOaF3UHA691uZjvjPWm2Asp8NZMUyenjIgUVv5qGA0Knf4KZgm?=
 =?us-ascii?Q?beQ4fkhL2RxXIK3jCbLtDZ1ZCreDd7yVtCfPsFqhVfNHJ6+VFE2Bt3aoVlyz?=
 =?us-ascii?Q?qu3FcY8QQXvrc/rwCylqKYg/HD8HK8RMBR/Gy4B1/GsEnUJJ8dtYZxxFiT1V?=
 =?us-ascii?Q?5h/zIy597SAcHKCTszlbdKlOPC/RrVEfpGnRAw2UPdYC8EVpEO1vfkR9lWxq?=
 =?us-ascii?Q?PaqxQejfNToA9Be+ueKEOE/sZVhlNli9YfSfm1ZueAjreF0tbH6mTrsw5U8z?=
 =?us-ascii?Q?4IpvX/TIQ4AINRewg4rWl40/8flNFfetrNQzfosKrdICaIa71nPB0nHaXM7G?=
 =?us-ascii?Q?pM9mbM73OxcjXnKSkv4T0+XLnX3ltLo921bO2wutO2qkUPLghEKvITc++AMx?=
 =?us-ascii?Q?De0v3LhJFJBIB9Hx8qWoM5D8KtY5n7Mbz9c14lm6fJeHY6tjy/e8CVQDZio7?=
 =?us-ascii?Q?j7FYdD+MquyVXlNKkE7H+unKpxeQYeNnW7yqL5Vc0rT8J4fuT4DQFWabohO4?=
 =?us-ascii?Q?kq+LqXUbJP4dCNtE41pPUaRBeiQhzXZLWZdV5pi+qx9RrAtAv78Kog3VA+x9?=
 =?us-ascii?Q?+fUhOkUPO0SkAEiV4VxylduXA8wNC+fp3pCG0UhF+pqeNBiR785mqYxR8z3t?=
 =?us-ascii?Q?AR67QMHHZxuOKU=3D?=
X-Microsoft-Antispam-Message-Info: bBD9A/U0OKb3l8oXWFoC9Bfp1LegHliNS8iMXajHc+90gUrcF5HFj2P63QtFWiitJgy84sa3s0ieskmKW464YE1qoDtMQv+zhEiOFhOdMDzlUOfMGXkUF0sVWA9ZmfBKv7aa/GgNCyvR+RLg7jKpwsSAlFKBIyV3Rr6FDp0Of0bY5QvGORW39AeF9jA7/t3E
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0322;6:MqdHjHV3lWejX3vEJDf5nrBEvSVKSecaY3+pKPce0NL8syjpVsZnXxjSYyEt/7ejcYyFTwBbVrDHvwZarqhw3rZQUj112+EdUTZeda8ushAXq5CH1pF/C/6ngxSWqSQnD+YjyDNSVJuMht4a1iC0oP+uVqUsVnnoZ1m+FJcgNUhTkYdZhHSI3vkaDc8qGb+S0FWiVRmiDE1LMT+ysSQZQG6989vpWtG7c/k/2waXdduaPxFVEgKVf71AusgvLYqRyWOr4tb0bht5uS7ATwxxvK3HEqto2t2l+IEu/wEoVxksTRE/lXGDk/GIpgnay+QXD/Qyw7twlt1fh7WDmy4ZnVMkb0MqixKy15Wu1HVFQULqkfbU14Hn6vC8p/nY4JL/1ACtT3NY9tGB5Yt+sHeSG0r0lrUt2F+vwcuYKhbW5vB3urVsRL6Gnrhe+VYd7BosaToYGtakSCMr4ZDBF/AUIw==;5:Xkv9Cg9IGT6QqVEMtdSaUMRHkftz5nbC1XiAaNHLNPkB0kHmckrmBGjZmpknPrRxx6g969XIWxk+pvVxQssDqYX76LIoWPXJbJB1xqAcNxoNj6IPVUFuUksT084W7OH1Jsh09YoyillOHhE+18CeQvqDGZZtQjybrfSmB47SEHs=;24:fzIOidmsDPpMIfjAu2aarC+L/AQ0Bua16D4gThq0oas0DiXbEv2Ni0Du7XemF5V1yvGjsr5Cemdp6JQwr/2ZslMbejFzyedjnQly9Q1zBRk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0322;7:kcSH3o9YkloEV12fCob0DCfXYK7lbP+NISSgBJ3mFgE5+L+1xNK1GkofWp1JsN6LOWh344/umvFf9Wq8y0jVNj4wYdSHyUhJ19urPhFxx/Cqe0g+EQkcLNjpFboMFcqOPZDpO94M0R3JjFg4odvh+pa/KqmMMX6D+tUJGMUdASkG5YKPH81lFHz8+fF6dATDtH/cZpoK2iQgxEKCsw/8Fshby1WVIRjfAXz2vVg3OvBc96pUmmIrpdKarKiD4R6S;20:gOO7htMH4yYT49m8M0bKhnBPYsDiIyYZAERW6ZAYACLBSKnLcvxH/Mcbpbk6dpgiEO6FwNGm/L14SQNXuoebImvOZCyJe3CvFM2+XgcolGtgHqKKDTWrEFdxS5TeYb26zyTrZk44UY9VNA7C/ZMmO5gEBqxa9M+trg6CowKA6gAajBJGVfosG6Ix1eEbV1O7ZKK0GAr/RSvN/OQIZASnrzyQnU+T2akrCEgnhbn4WoFnieUzfh6jiTch6z2TemHy
X-MS-Office365-Filtering-Correlation-Id: e974bcc7-8603-4622-5b8d-08d5b49e6a4d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:44:41.9392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e974bcc7-8603-4622-5b8d-08d5b49e6a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0322
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869745586333714?=
X-GMAIL-MSGID: =?utf-8?q?1599869745586333714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added dma configuration parameters to rtd structure.
Moved dma configuration parameters initialization to
hw_params callback.
Removed hard coding in prepare and trigger callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2 : Fixed capture stream wrong channel assignment
	 added comments in dma trigger api
 sound/soc/amd/acp-pcm-dma.c | 103 ++++++++++++++++++--------------------------
 sound/soc/amd/acp.h         |   5 +++
 2 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9c026c4..e9736fe 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
-	u16 ch1, ch2, destination, dma_dscr_idx;
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
 	} else {
 		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		default:
 			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
 		}
-		destination = FROM_ACP_I2S_1;
 	}
-
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset, ch1,
-				       sram_bank, dma_dscr_idx, asic_type);
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+				       rtd->direction, pte_offset,
+				       rtd->ch1, sram_bank,
+				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, sram_bank,
-				       destination, ch2, dma_dscr_idx,
-				       asic_type);
+				       rtd->destination, rtd->ch2,
+				       rtd->dma_dscr_idx_2, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->destination = TO_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+	} else {
+		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
+		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+		rtd->destination = FROM_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
@@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
 	if (!rtd)
 		return -EINVAL;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH12,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH13,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	} else {
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH14,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH15,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	}
+
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch1,
+			       rtd->dma_dscr_idx_1,
+			       NUM_DSCRS_PER_CHANNEL, 0);
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch2,
+			       rtd->dma_dscr_idx_2,
+			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
 }
 
@@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      SYSRAM_TO_ACP_CH_NUM, false);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
+				BIT(rtd->ch1)) {
 				if (!loops--) {
 					dev_err(component->dev,
 						"acp dma start timeout\n");
@@ -950,38 +940,31 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-
-			acp_dma_start(rtd->acp_mmio,
-				      ACP_TO_I2S_DMA_CH_NUM, true);
-
 		} else {
 			if (rtd->i2ssp_capturebytescount == 0)
 				rtd->i2ssp_capturebytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      I2S_TO_ACP_DMA_CH_NUM, true);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/*
-		 * Need to stop only circular DMA channels :
-		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
-		 * channels will stopped automatically after its transfer
-		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
+		/* For playback, non circular dma should be stopped first
+		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
+		 * stopped before stopping cirular dma which is acp sram to i2s
+		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
+		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
+		 * first before stopping acp sram to sysram which is circular
+		 * dma(rtd->ch1).
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   SYSRAM_TO_ACP_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_I2S_DMA_CH_NUM);
+			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
+			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_SYSRAM_CH_NUM);
+			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b..5e25428 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -85,6 +85,11 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
-- 
2.7.4
