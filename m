Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZpvmR48o+pEVsDRgPKHZg8kIxTM1BDS0JGkwxACVw6DRZ4KeMor5K7sOBjGcjGUy/e0+1gs
ARC-Seal: i=1; a=rsa-sha256; t=1525207801; cv=none;
        d=google.com; s=arc-20160816;
        b=I0JlyI96ydrYaEJitEhF6AK9Z7RElQBP+bymT2VJkdc7JR3R9oSHHggiwT7BEjnGMq
         OWGks1jhZm2YkuZ2xKNevdnNXJIsInr72Clt5PhqTM7/N3lVlPV7vGLtpWLU3xMbUueR
         0K1wjmd+OXCO2OjRtQtSNqlGv4uON/oou+paM9pEXvPtIY9FWuQjVxa2ZZXoGR+WQMCM
         gnrY2wjAXzCC1TxC0tVES8qCm2CAwbc3F5qqqjiKS80u9nkwRoZ+kF7er8O/HsLrOzOZ
         CiO4k+YUrdQVQHIANHOmU3tPz3X7XOF9VUudYZmuQUuBMajdMv4nr5Zcpxnpr1Xw+lPV
         vKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=sfa6ZuJ6q+qxSRu+DhrZ3BW8YBpMc1mSP6NRFb47i9A=;
        b=KTo+Z4GKCI6l6TEwdpBzLXr+D/VQ9fnX7xc4Q4ioKizlCszbsB5jNPQIqXxWv9gzvb
         yVNrdoUnb/+O+EglXtmY1AXcU87rJWj+/uEHU2vS515fwB5ZoumGwZEx6djnUY3GYMCJ
         lRByhEjpkSWS9cSkZTzJB8/6EkBCmOvZOTv47u0Zq6WGMT5GMlARqpl3+aOZjvv60gXJ
         pWZGFdaLaMa+pG29JV5iNWzrh4hnSoqKdET0g90cYfIXfWnBeiBkieE1qZmGhm88mdvC
         s/KuCV1ZfK2fu9Zz5of616n2EIe1oYnEo8CK8bNIXJsqmX1PlczQrDW+HPeM+qxyZBTl
         4N7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=TNZmOMxz;
       spf=neutral (google.com: 104.47.32.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=TNZmOMxz;
       spf=neutral (google.com: 104.47.32.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Jason Clinton <jclinton@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] ASoC: amd: sram bank update changes
Date: Wed, 2 May 2018 02:19:59 +0530
Message-ID: <1525207810-1305-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(48376002)(336012)(478600001)(81166006)(50466002)(97736004)(54906003)(126002)(26005)(81156014)(11346002)(486006)(476003)(2616005)(8676002)(446003)(426003)(36756003)(76176011)(7696005)(51416003)(106466001)(47776003)(8936002)(50226002)(1671002)(356003)(104016004)(86362001)(6666003)(68736007)(72206003)(53936002)(2906002)(305945005)(15650500001)(316002)(5660300001)(109986005)(4326008)(186003)(39060400002)(77096007)(105586002)(7416002)(53416004)(16586007)(172123003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0324;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT020;1:5wmRblj8STZeSXZuGgPE7PQHRImDER0DrF1H51pbmY4TtI3b3Q3gL2Wowo9eYksaG4q66CusbOMigea/7lj28SpYSVQwy/eTZI6PMFiga2aBDkk1l+5pIdYaA5GqH/Cx
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;3:AJV7rAhJqqKocYPSI7ic8BW8C2HTQ0CQ+QY/jmx7QV+4wfL4644oFNmMHYup4EXE5al+xrrXOfLXSstK5qmL7rnsWFWPuzI2F53scMYUcRFO8zWW6bwYz83zquF7ZV/yPR0ocnvT9YI+KXRnemaCPTeebd/DGpi0JKI4zEMr6K4pLlBv7RXFC4k350iFm/vnjJLYZ4wLsUN5CHRw+zXQPkawKnjR68ebsxevijJKCGTMK8aSTVz9FVC5xjhR5fqP0+m4PV/rMaYKYjSWnVJaANDtlh26w/Rx9cxf3baCAwqQv7CZKzHbuvG2stUAnv2A+P/YuoHytwVkJ04PnYnV7V+f60cT657UDGS0glzpLGw=;25:vU3sqTICGzxR8oCoBw4lN63+DdVjOLNM4FGXXzyWRDF5PiOJGxQ8056e7s2Fp4NDHDvMw4vpe1lEcg2yurvDQU2XHBmDnECKBAtlpdFyziVVRmyiEv/2Ont7aT4Lk0b6sz3VVfnVXY/moADyYshIzpQuqu5nHbFFcQWZ5VLJKwBZPhC8jiBc0S/q5C20Y1kBuMMUN7NM+KBOM8FR8dyM+Lr3dTFPcQ8YshdXWNoerbUc9LjKcIrmyB3A05wJECd0RKC8uoxHhDtiYjqfSBXVhuQsvwpH2db1IwqQJvCKM27GJeojGTPZkUR31fkGaeSxyYVrf5yEKxlD81OygXVCug==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0324:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;31:LOwF0pz/gLfp9yfx4mB7h8BqSetAuEPA2AeJEOYZOGB0nDnjcoHdyGbX3XzTnHW+CQ7kqVS9hRdJa2vLScxQUAKS9g3tmmCqThtf7hn+O5jxldZNHizUN9GyyjdiRnXQqZE67xqdx+ZTw3zJqlLcp9EQ/eAerpBv6nqv6S8xSdPelo2S4fuLRqPe/SUVNqxJZBpoO0NDZYW2W4bqCZYfQlL1zkYo/GTBPO43Aq6l8EU=;20:0pN5FDeEuZNfprBF3iG7sTvKLLp/9iOKrOZIJGiaSxjsFdghtRFDmGw1QcOnYLTPWgf5mlevCPUhQbbaNkqQNZtcqsky3y7sVxJgRE1F8LQNaFhVzd85zcghXWBh8vO4mZ21LxjE6W+D6qhdiueV4aDIIrrtsLvMbKH0Do6QtrFbhd20aKSnKTqdqGrb6iXdL60Noua+f7EYuBOQ+07JVHM6fwVDUApMeHJcVHg5BWZHdt2DGuq1F8BhlqScVbubAG6Ojr7pGy9ijmSpOorIiJWLjK2w6mvNiiQxCsjWZ/mKgvN4TRK5S2jPBHnyyO34Aa6nhEEPKTtJT71KuK6+7oHQRqITvsCCnGLp4q9+KyiW2efGr71Tq/yNmapJqZj+7M59EXWj3KGWN7W7dnokKsFGN1fBS0eQKvq07NoQvFqYfSA/UHZINuh6OKicRm5L7xYdkRqHMGDTeKFUeTN9NnelDTp1+Ji4hIH0DyvFphwHmlDvO69GymSU+AWDwSQx
X-Microsoft-Antispam-PRVS: <BY2PR12MB032483C53683C06CA4C42F1697810@BY2PR12MB0324.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0324;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;4:x7gStTqTGF1i7eo5KGsEg47Ux4eABsDGVQFwiUQ6yibp3jFPpeYGCaEZeBmE0igJpKSNJncueh1BJV2Yw7qusDR5LDVysgctBunPSbOVK5cSI7GODIl23LJbcXzRklCao6to9HwZyGlEKp8buUq9NGWMGqjDhLoIGOA6esLulfooDGPc8Kp3G2M2p5waZeLekT0fOq/zSVZmjJar/FsBXSzrPG+fnjH4suWlJ6DDwLJ8P0D+DhCNnwlgAqITj/RPC0wfqW09G60cJwNNIqYivBFxw7iM37uJwhbqTkQZJY1gnkm3A+q4oq2kCO6CEagu
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0324;23:dzw0XJufb0JxnHFNNe2x621nU7HodMxMCYfCcqpxy?=
 =?us-ascii?Q?a34zypnLa/6cqMYseU8eteKGFoz9r3YffDEheBJts2Vb3fC3CiRRd2FaN9Nz?=
 =?us-ascii?Q?xbCSk9I3v39V4Y+hA/+14Ix7qiks88Sv52GawA3sa1HIv8R3bMqSw9EpgAB6?=
 =?us-ascii?Q?YBBN3n9576T/JrhMi2qU/DQqNXXTVTd4c1aWKLy1HsJ7yDbL2zzC/21LOD5W?=
 =?us-ascii?Q?rdpfCRbERcH4oFaIuLrKDh3fREZjXh9DvIe5ttL42LM3Nklq/o9FVx3ZSmHO?=
 =?us-ascii?Q?pyK/vesUyZyFO5HsfZ+hG4+YdekquYQZ8tx7TUxfGHG67VBhoj+AWCr2DvHY?=
 =?us-ascii?Q?WT7nvEwh3wkexUVSXEknCvg9y9yxdLRklaYMmmM0WhWmMJC5tDdVuL5nP8Ho?=
 =?us-ascii?Q?bC6k9+0zRXSVnBKiV2wPHA2lRpOr18HoMa7QqCjrJSxPKqBlj//FTSDOwGL8?=
 =?us-ascii?Q?YVVQSVIQbdWV7UcXA1ZZRC+GHjfq2XNA9HeeuLkMlRv+QA8LXDNW3idtmKHE?=
 =?us-ascii?Q?EYAbPw5aGXbyfa+7Z+gcSuz956HhpHERYt/gs9uACwQdrhEbGMm4/MMK+n7y?=
 =?us-ascii?Q?KJWypYw/79hftMOS57OHA/tOAcVhXPdSZ0UnTrKSHAS6yonevzj8gtomxxv+?=
 =?us-ascii?Q?Su+QXM9VmCp4V3qoa/JvGI768QdTJyTmKoSvi6NGZrGy6CaGx1fNxdBc992X?=
 =?us-ascii?Q?RV1/6XgnquW0GUIbZNrEDoztEsJbb6GC9HoAiRXYXW9/Y8viactacKXe56IS?=
 =?us-ascii?Q?O+ZUXNDdS/4bC3rm8fSiXHYCzCcUfieE74pgwnmbsriqK1ntMIpuvT3oEScK?=
 =?us-ascii?Q?SqDD610Hu3SlOW8iSIxPNa8WsDmvQr/pou4S9wtDkqgvbcm9T8/csbvHWQDT?=
 =?us-ascii?Q?rkeuC5wZn7y91mLT0BH4aMPOKFDFAPPPjoI2w0HUWl8jYzzN1Rh42k6geX6k?=
 =?us-ascii?Q?hAY+k0i+XhJcgQt/sVFwvDC8cBeGotY5EyU9pK2uM67PsOlSSXywEbCtKOHd?=
 =?us-ascii?Q?mUT1Dok1n18E8elpOahVJHGCY5tCGzvclbY1tpJNc88Q318eOqyKKBFmGE1w?=
 =?us-ascii?Q?dSl8INXWNG6Y7U3HV1Je3b5RyoGe3T47X/rl+UnaaqF6V+CRe0AoUXtVnSWI?=
 =?us-ascii?Q?yaZgyAYmdZqDmJtojCpcRYZTRkGUAXRmYp+b9CapvpB0BShJP1wI6QB9XNDH?=
 =?us-ascii?Q?RHq+u2xtB9sBeG6zhZd0c09n6HaTFNpyIAHaK1I/hOizQivB58La1aTmwo7Q?=
 =?us-ascii?Q?20+of+EYpjrqyWMpBxh7RidcLCwlirL1Kj0Y34W5Hb0DN00Mjouz6ofRw0PG?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: oNAO8ertP7RvoiS58eaXV3+5CvENNQCUhtIs0Pj8ECFqUrrHFoJcWkkd/zePh3jIaTTPGvmNv2eOVGnZA4W5nDtuFtT2RGUxjJiDyoURAhX9lxQsM4cWfC3O5i7kKYqnJx/2gQm7tDgRHyWf6VR7fI5pIorn3sV9vIApuhe+FZis7imO0/WXTHZyO9QmwJj6
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;6:/ObJBOe/oyEmoEjWn0shv+HcisTio/bFs+0d1S4Kl59RQv337u0OHH80rvqzczxoSwpI6j6JLlNRpk0YzfsNFbyFD7klzNj5pYi7V97xxPcf8WttQPugrERUC65YEyxgretga2rWodOCWbJLP61fIif0PmiRG3AOiQyfLorDkkDf/H1QNIJTkcJRZ5C/ErPwNEdmrzJNTNubYU69ORqsdpIbZhwSDG5P4dxc0NsUxwEBLDQ0YU8vD2GoN1ZmH/5GHYtfRyil0if65KrTL0kW5OpdNAuXMnvBLTqrmMM71lR9HM2tQ0KQ64CiPh/njzawbf+gwGHeuILB/d1EBAAZLwTf4pf9/Sl0W7BXXcqMWLu2hJd1qumLDGiX6VYc8EFQfI2luYq/siIe9WF9/oIYC0udtl3KnO6G5/3lwaSZUZyQUndrQyu/QCNqZX/K43zKEoJNckNMyvvxxiymwRY0qw==;5:PmjLd2fn+Bd31PUGAwzG9EJF+yHZp0SafHKImVxrBHqauRnLEKKmn7AlKCgHeu9oCExaBWz7NCo++NJBNc+pM9QwDo9yFPR/xZqrYOo7bsyxQ8UIxWKdD40GAg5HpTcy5T/swSC3Uc8+YpH+Ia1Hl53A1Spp92n7hGvJSLdmKwE=;24:FUJ1IANT1W/MGkXlEIzJAasRwkt8L/d0d68jdwU/i94+qmtaF/u9NcbgkFB6JkGYUM3xlnW/jJTttTm43TERsNoc7OKDmLku6XMQfPq5Zr4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;7:6JARgGlLrOaCfxv7x738e53jGKTFJv5r+WFc5fuGO2YhjebmviYkUtVm2E6QJftMKRSjeoviQ7eZ58IS6aUjjltG+9tucdhtHB5+5WF0UUQoUTZdG9ANxvA6iyhSDlOm940ITubenc1JR+YYDf1oiDUb40BNDTRCfwfglUx5YA5NO0Dnv/8ZNKEFyZ9A37L2Q5yEMnzVAs2i8wHKrtoieDtRCM6DWE4B50qNtgdkCTMW2tXesE5p1xZAiPvM7eVl;20:farVnHCyu4tCcJDf+mNeNF/FkNg/9IO+h2cH503ynk2IMGLhvE0rten8D11GEu7wzF367dMgc1utY9gM6WJtreo0VHcDdVBAXUFDY1Q59KKujD8cjcs4e7NSgbYeiYXoayfJ4YTfzIzPifeKLH0uuBj4kaYIVf4OKI1CugIRNanc9dYm8GJDX+hX5QcDWY9XwMr6m6svorIp4J+UZ/ZuE45ZN4eGG6DGJfu8vb3QYUkRStRDn70uGhoRmWc3qAFf
X-MS-Office365-Filtering-Correlation-Id: af004034-0673-4426-950b-08d5afa5120a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:49:44.4628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af004034-0673-4426-950b-08d5afa5120a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0324
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296295241890766?=
X-GMAIL-MSGID: =?utf-8?q?1599296295241890766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added sram bank variable to audio_substream_data structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
 sound/soc/amd/acp.h         | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 39597fb..8236116 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,29 +320,16 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 sram_bank;
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	else {
-		switch (asic_type) {
-		case CHIP_STONEY:
-			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
-			break;
-		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
-		}
-	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, sram_bank,
+				       rtd->ch1, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, sram_bank,
+				       rtd->direction, rtd->sram_bank,
 				       rtd->destination, rtd->ch2,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
@@ -795,6 +782,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
@@ -805,9 +793,11 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (adata->asic_type) {
 		case CHIP_STONEY:
 			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
 			break;
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
 		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 2f48d1d..62695ed 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -19,12 +19,19 @@
 
 #define ACP_PHYSICAL_BASE			0x14000
 
-/* Playback SRAM address (as a destination in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_1_ADDRESS		0x4002000
-
-/* Capture SRAM address (as a source in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
-#define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
+/*
+ * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
+ * playback and SRAM Bank 2 for capture where as in case of BT I2S
+ * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
+ * be used for capture. Carrizo uses I2S SP controller instance. SRAM Banks
+ * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be used
+ * for capture scenario.
+ */
+#define ACP_SRAM_BANK_1_ADDRESS		0x4002000
+#define ACP_SRAM_BANK_2_ADDRESS		0x4004000
+#define ACP_SRAM_BANK_3_ADDRESS		0x4006000
+#define ACP_SRAM_BANK_4_ADDRESS		0x4008000
+#define ACP_SRAM_BANK_5_ADDRESS		0x400A000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -95,6 +102,7 @@ struct audio_substream_data {
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
 	u32 pte_offset;
+	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.7.4
