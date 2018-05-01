Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqYodBFV0tofNwvjAr2I3Q1JPZSc3xPoNuhbDqftlolqfHec6fW8BJfUiG6/CbY+C41V0vE
ARC-Seal: i=1; a=rsa-sha256; t=1525207654; cv=none;
        d=google.com; s=arc-20160816;
        b=W32CBUinUzJKdhQRVw0oUPOVvdiaJguKGUaJ+weonKMnIbS1ZEcs4pLvGMwbJ3HRcM
         ymFSwuvCrNt6MXeJIPWHFi0u7mEl/dSPY+ftmSCZ22euZ7fbClKm9uyt9pKMEZzBAJ8s
         4VRWRTDOk4uRO/gtt8rWgdKPps7vG/dkOPZDnKFvQMyAESKnlj3WMGOVy65AK7F0pZPs
         qKiA/aLTkezwHw+Yz0LO/O322bcx+W2LcTs9eQdBsJ38Nxvgb37+Pp7CN2Fwx2Tf6+VX
         5BkTe57s2/Ss/O8/ROrq3raIQNfhImdjwrWbsALwAPA1dFFPV7UyXjzUMHeqM5zbuuFH
         6SjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/7uh4tTZ+Ka2KK7+s1G4NYMedSbCtWcaEAIF1omMNPk=;
        b=D/wOTq5k6IWe1fyuaXpYSS4HNkTeefM2KKqsQ+jKVgpbknM6lQ12QOcPtN/8vtrPjm
         VHGKc91ObYjOsgw84A3UFZob6HodOU/evXN/t4BP8XyiYe+fj+QRmLkF0H2eyH6fFt7k
         n5hCGrvUCSi5yRsrsx2L/n2CIW+N7dEMOh9jS9/ImMPbxmdLlzkPsml1NY6//2pnQXW6
         mypF52j9O++enO5GtynpZRt2YL0N6W9u6QW+oAdYqI1OYKFSBTZkqvwv5AdDLmUrUdKl
         AGHvFlA+EwpxgSvA4iXkMNZQz8S2V0ERDjaPrQ6kwZURDl9kLNDNsPP1X6VIquTIUnb9
         sgbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=N5CPMfl9;
       spf=neutral (google.com: 104.47.37.72 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=N5CPMfl9;
       spf=neutral (google.com: 104.47.37.72 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Jason Clinton <jclinton@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 01/10] ASoC: amd: dma config parameters changes
Date: Wed, 2 May 2018 02:19:55 +0530
Message-ID: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(376002)(39860400002)(2980300002)(428003)(189003)(199004)(72206003)(7696005)(86362001)(356003)(53936002)(2906002)(126002)(8936002)(2616005)(476003)(478600001)(68736007)(97736004)(109986005)(6666003)(59450400001)(426003)(486006)(51416003)(47776003)(336012)(8676002)(186003)(39060400002)(26005)(48376002)(7416002)(1671002)(316002)(50466002)(54906003)(305945005)(5660300001)(81166006)(81156014)(36756003)(105586002)(16586007)(106466001)(77096007)(104016004)(53416004)(50226002)(4326008)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2422;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT039;1:YRvPZS4rkqJsNDbi626NWUiXZxOZdt+Y537SKuAWjPf0HsP/x478h0yYT3fBk/cHtWA4mtsJ9epmfN11Aarmb2UrMqLDGqx3p2OFYFEpwe13r8aATHUbOExqjRqu9ZZj
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR12MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2422;3:jtLl0mnJn8xv+H4JsywzK6g0Dgv6gwdBy6EiAIEzVwu59q/cC0g9nSEUTo1iWFplkJtZaYLMz93H2CR1Wy+JHXou4k5DGzLXWSwBmeXhfi1ElYULqd5Jo0xeuHzzLsZXBd7NRUGcXUnC+hx9YNlAsPfLnlVDz7GQBt90uxmh4TSJSrUWfDP0uiFg/F48HoconibgGNwjtsqfXt3lzVF753d6iIyC1mSZLtgsvK2ol3PTaA8Lslt01DRf44dciEBPTLSlSKDRuWWBm5eYwAOohfUrxdd7WjL7tW8ZsCKdVJHXJZh1xPI9vCEnii6QKRciqO5czw/j58XfDzWB9xYGRew4pS7DSBh16k2c/k8z+Pc=;25:1Mi2jA6Y9RkSpFkSqe0t47h5Qpemv0U7SMtXnDEndYuTFKeiO8nzLI8udwntpbOQYEicQo9CVUVcFsNlMmjt/CcUJC5r6KYFxgGK+AxMCc/V/TDUyndtLpzRwdwZ6flhs1mVoeQAK/lHhNkLxSuVrx7X5ww6y6tdNt13T6NJDPn6FhMTHAf1OG2ileekXODBi/gLj8AwQndXdbekGXK9l7zdCOurWCbtG/e0rfXo6jCQir8gjrHNsSPRxDZg7ouoL7pJ86gwKHgW8gGFp/sG3KGexIqMq5GuDVP1S2kzLM/B0lYBZlAGP/S7jboZq9pRRAclRZ29KSjUkoUif+mAsQ==
X-MS-TrafficTypeDiagnostic: DM5PR12MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2422;31:/+EZTidsU86wlf/bDtC0PbzPmPW7YuMFvWlTNBcTu6SYJ2F8WrF/LF5cwDYF4Bv4Jh5qq2f74u9PfgjTrVwqvJ+vagGVNeVcZC2aepxZSa4EQl6q8t88fPxZQPFx2XkJJ24yd7FRgRK/IQjKHvnzQCztPhzedC11PjNQv6bzxKe8pnTu8bVY0CgVXGgDe2smc0ChAG4zdGTs8xRqpax3h0VBqO8XEjt4WuKn+7hhSa8=;20:yEJogvnWq9UqWUnmqXuY8h5LV6+YNxG5XFgoij4bidw0Nb9uPifo0PUjKG0CVdMaNCS304Qy5LB0vYDzNH1ETEaiZjRl9xHojHVaWFNxPRrALCnHaYXd0oFeQ7e8vMCAwBM1EHTqfA9T9ybdXmjEi0WX6UpOLhi2v5mhJEM+TFOAOlMKZ+nz+oXdaP80+U6Ct9rQlOCpZtNA70mcLtP00Aqn86KX4foioRFJoEh26MloZ3ethK0MILgPHtgnQkO9kEU2FJ4n/NVLtb/LpFIj03UVic/eyI2luejiAvEZZmWIChBKWj43VY36vHOo6YTxMo7VV477IDqAFrkCq1oBSh1c+Kn0Ht6/Cq10m4Z6p0gLW7A14Bxq6b84ZRSmQfJipcCIJpye1J/Y/QDdKUVJoI+YaC/bfPG6/xQ1b2VSCUUNmikLuRGtMKWfOcSEafIYu+mfOHWiWphsP6uvd8dHj5AOAb43+TYirHhjEp0ilTVSeq8ZxXt7LyEAjB+pK4mu
X-Microsoft-Antispam-PRVS: <DM5PR12MB242278000AD128BA67D3780397810@DM5PR12MB2422.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB2422;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2422;4:H3cme1/+tycco79myvgsDt+AVfLIFERl7qOceHpwMBaRcWIJrntzlFxq4YSYv45rhqloSnb9Qjce3NinWtzH/xrgzHC4AxD2CzQqz5Sm3t6fhaa2bHQz/5hErZT5URqiWhncjEE7GjDkZbTLCrUOgQJYAybM7lpG+7HfjEtAyf68alv55PJ2J3WGkIZ+PU5JLLpJPUgYVD7UOmY/qYyWAC2g9kVe0/KQrr59xD5FHQ5pgiYQRUhsaUq1smQWTuu/0rLRTBuHwY/6DqmzsMNjZwy/8oVUWojS8KqdNVYE+S0Rxb5CK03TkHGFwcnBaD+l
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2422;23:38aqHO+jc5BpQgtwBZdwMS64FAQSBvPC5Af7LfBIL?=
 =?us-ascii?Q?nfybQAiNzaJ1Rqczh9zk97rB4jIgK+8e1hshBOEiX/0Mqg8NgKBX+T9wVOv+?=
 =?us-ascii?Q?MvprhgVd/P0cgwHiT/Tjn17l8tfP1Fo3DIJNT6kJTOae45XxSBTSqHcJRr8K?=
 =?us-ascii?Q?TlxeGntE9onUA1RcJidrWO2sTDZI0alYvaJdfYM92e7NEHK54SRck5/tFkcx?=
 =?us-ascii?Q?EVDT7DydlrcojU3ETFvFFc0LEI8ozbrCNNQBhnecKmWtMEiilZvJrW3Qac9H?=
 =?us-ascii?Q?S1Hc+O2gyYLcKCqk6v19s2vDUCRXFIR6uCLOkagiSvdnZ/U5aCcUNCJiKgJm?=
 =?us-ascii?Q?FpQ2ygR89+YZ/0zIm4obMEFVxTEmZ0z0qkOoGr0fcncNBI+97OWek2gQVLwN?=
 =?us-ascii?Q?EJ/goOw0eG+Jsa6lXvfTY6tgiYrOwInC8d6kiwuODkrs3EgVKoh2chB01N7k?=
 =?us-ascii?Q?tiTwzuJIg/tYvM2r8QAqTP9If8rLACnJUibzyK7hlAHOPZ9kgBQLKnNo/PeZ?=
 =?us-ascii?Q?vidmU8qC+T5cL7MRVPtsCjc+2wkzjCg0FEaCEj7KrXkSGqcnxSII/We/hBs8?=
 =?us-ascii?Q?VYh5RZT0Isi8xLN8SfcPJ3IsrtAwpRYhqzAZJUmcstY8I3jIlkzxiuTvzVvP?=
 =?us-ascii?Q?xn7/r2n0oxQLx1GxH4jv3mubqLrQQZCH0EFhAXpxfA0E/2QN4KGA56bfVaP3?=
 =?us-ascii?Q?9AAt4t0dDjz7yKWQp2jI/9c/3J6yo01RZ/pgd50FhKOK7oagTV+pqrLF66xo?=
 =?us-ascii?Q?7HeoGIbvJhUMzLA7TJi0/3vxPYX0zQEAsmSXO3el2NfPY48znyogrdstUMOX?=
 =?us-ascii?Q?LOJN/+5TxgvjiC0XhUDm2Tf7ihV0WNzjV6gVVpw0MuVb6S6M1KBsoV0UUhqD?=
 =?us-ascii?Q?iiPGMAwTzcNQC7xYado6AbXyFQgsoMfMLTxiVyW94NRG7vujP66L29JA4TST?=
 =?us-ascii?Q?Db3wa+CGc8SwvgJhXIGvR3XD7NRZlaBOg2XeAlItW1apMa6tOh/zzUuMZwGp?=
 =?us-ascii?Q?5PI4m0C4JqoHWo5h4hApM4CQo5IvZLlDw1lkSzhbrq2qWKxN6BP/Mw0+GLWX?=
 =?us-ascii?Q?TdQmUBm+pwvxiQZsuzTRXsYucah8vLAUH6iSXbOxd0DgieL3qYaU1C2el6MH?=
 =?us-ascii?Q?4fZIdPrwNck2hFocTPqXthU6TbvRlcY3a0w3Lo4EQdNItaj0iKZg4K0775cn?=
 =?us-ascii?Q?c92v/eicZoWRS7fdfy40l0S34Nk5s3qBKKQKWofFfMZAhairmkZ58H6Hw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: KvxqwN1uhgprjOhl3RlHQrPV8JxwjwRrMl4gFfYxmuG2wjUlPZyzWFiYyhcnp8+Av3cfiWtYIdbMB5DkhQypzR3WqoEcRyJY09stRZSLYuvBrQXotKnIyp78VXE1JDewj0osSyij6qfnjB/JY43zrbexXj16op+CsSPY4GwdM0Sy8U2ZMRBdJdYxJkeX4XWe
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2422;6:uCi4p3ENEtj86zIoei9W7COpnn4hfFtHpy4KsN+vl4USQ22TZemn6IehuOpU/vHR9K5hnydJa0hUfMwxOAibYUGudoxelIYgl7vF15lp1cLrmQpSJvhk4kjM/kuMpnBio6nV9jIfcy1O9fpaBPvg26+IkGEB+uv+1TrISADx7KuY8FCHbjnw+VeYMRpgngb+vWVcBLkSO1nYJFc1jKrOnG6X6FPfylsCKzzqPJz0jvio8zt9BCtcZFgK0HDSCjOihB5mpPdYaFpWFQ0tXGLGw2gtxPnAQcDW8zEZ69XvvPtLsx/H8vF0xBepFp1Pq4uzyNN5bKkKYGzik1u6jACiM+ZyLHhTKxdn+rTs2zPPSo7moE4zUZTAIMoNav9Yv4/csODbsQZboPtM64I/vMcerDcUWY9Jp65/COvdQCgnC3ihrrffLwhvxZ0G+MZbSCWQdAHUg1ZLB94FIZyq+WcnrA==;5:oJWpk8PjVJim0oXBZrpjJ8LAlXe22NpQ4L8orVJkFHDV5t0v2xABSOyFwbHpSwHNCOvzCd0idVjX+P7VFFJwQBs8O29UabvjAH5ozqNpzxrDAiVtQh8ZrnEIgouMBQCiSXAzRkeq4mPvfV7DOOysvvLZt0AIAKacpibRsgbMqQ4=;24:JL29NOSgGd6jM7zTWCY4mZL5+UG80vDjULS6amvowI5rS5Bwe02wZIk56KH2iw/2luVtp7OcR+t6dyFQJM3WBTE4GpS+CEOap5chqQG5Nt4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2422;7:BHp06lxadW2Gp7qBAGOyuxM23At+iLKb7giHqsx03cnxVJN2m7cMwdO1ciRNNrFP5XsqzOzBLQvJT5ejuvK9xTjDn3eXqkgqPIpwRM/TFDaAHULGfAhSHzHTehHAzdHj58Y7HnNOSAM/O20HYCHuRVUXsGk+PuTwDCjmOxUm8tfQKlx295qfI51g6oNLp7v1XAVICklsuWm4aa7nE2xESHKu75gQhNU2wE428pHPVd0tWUTcRsFhQQ/V0pgjKV6M;20:+pdMmsCpgssU51Rhm+uBO7nufA983ZsEO7AscFtv03L0OvS3WWVgMhhLYrp2a2fJ/utnzKsCVmk8uJvNNJNu2/EW+UjxF4H0BoXZFnefdoHsLvg4uHI64bTgkMc9fgJNo2mZZD1QOgBrZq7rW3/U7qhEkx8H3F9wySsctcTzkDHicB6G2yogyK9itNH7WlslVmvTdpg/V+WzYsU1fy21+qvhjaqqzWm7mtA4N/cycAd+Tr1cbO8b6GRDpvPRp0nV
X-MS-Office365-Filtering-Correlation-Id: 96d60d24-285a-48c3-2f4c-08d5afa4c295
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:47:31.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d60d24-285a-48c3-2f4c-08d5afa4c295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296141928589066?=
X-GMAIL-MSGID: =?utf-8?q?1599296141928589066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added dma configuration parameters to rtd structure.
Moved dma configuration parameters initialization to
hw_params callback.
Removed hard coding in prepare and trigger callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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
