Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4+OMLH7/azAPQcRgoZ+ehG6YOqT2k3XHtNU9WgsojvbmVjbMk50vX1nybBz32Y2KBXWbH7i
ARC-Seal: i=1; a=rsa-sha256; t=1524741366; cv=none;
        d=google.com; s=arc-20160816;
        b=PW4VNS6c4rjsLLS1bAnjiXsT/jikBvEGoXVnssmXXRXvf/+YluVsnniC6pmE9VXxeZ
         GEcvI7OtE3BZg2TDtqC/uGDkEBZZiUdzbeMdwgOQ6jw5+JPKEkQIrts1pRdPTmvvQaD/
         XWW49NfPYfK6GCBXedNLqIteC9Fg9Mw5e+/0JpXvVN0JCvbAmD4LUeBmnN+Z/1p2tLQD
         ehuL4mVEW6cXPBp5NBHbEx490bQFtLwyKz8Z9aJHaziSRYAa40Liq34Lr9O2J4Cbz/u/
         vopQ7f2oXa43ThKk842QDN/3VUHpIj2yacyENhApuYy+vUBBroZxH7HTawVrXP2iFsUz
         DI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bcTgM2fsiEDIPH46KnEVSh25StO7pe1UUfUQLn2mV+M=;
        b=qLrOj/PaDOGgVp6LVBdMWy5FCKt3blGwaRY6I6+Rdg4P0F+Mm5JxF2In9In7aM8J2R
         aLTsZbMyy1Tnix2kyHWY8Jp2n7uZSR5wdct2onzhTC1UElajobG1cjXEbf5SNPODCYj9
         HS68wR5tKAR16WTOaZuDdeBwT3rRHTEzobUIM0bXwtWlZd89pBkeUoC6vROwDndvqHP1
         gBa2DO83t9C4YI1Ch0s4JeAC3pnOpWQmmIjD1gnEOOZaHxtzizowVSjfWO592U8vM3X7
         1eBxYXEm9lUcL240Po4y3XycXnmOnuhGYQjeQ62VFHN7ijgcecmLVeiR56Qtd54JySzJ
         Nxog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=lVgkvIlV;
       spf=neutral (google.com: 104.47.42.60 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=lVgkvIlV;
       spf=neutral (google.com: 104.47.42.60 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] ASoC: amd: pte offset related dma driver changes
Date: Thu, 26 Apr 2018 16:45:51 +0530
Message-ID: <1524741374-13523-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(396003)(2980300002)(428003)(199004)(189003)(426003)(48376002)(356003)(50466002)(1671002)(105586002)(53936002)(4326008)(5660300001)(6666003)(7696005)(109986005)(77096007)(26005)(68736007)(486006)(50226002)(54906003)(53416004)(39060400002)(186003)(106466001)(316002)(2906002)(81156014)(8676002)(16586007)(81166006)(8936002)(476003)(126002)(11346002)(86362001)(47776003)(478600001)(76176011)(104016004)(51416003)(36756003)(97736004)(336012)(2616005)(305945005)(446003)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0762;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT019;1:PInpZiOc0X/m4Aeges7cqdbu0eSBjVi42/QYcyKLuHb+4D2+vzjawwYa8/VOC8HRhlZSs3J9pWkq6LCwNXQ+PlhxDtxA5S3rPcyFresj81GATi90Uxj2WMBvB1QUY+ZS
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0762;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;3:5mfoH6Ka4aFrppjj1oX40mUxzy2LMGAUARzVdi/GryyGA0A+vmJvuVTLxmqN7r4ZSas0yRLmq4NcT0U77n1g6PvNtBLplrlVFkusheYGjGBTB5YZY478RNRiGhEgDaWqMHKDdHSDKJdoyzchh+eKOcyo5kWYFuez6J7oxF/esY3/hTS1veflGjIQ7ctc2eU7eRLUIt/Lh0rvKIoo8y991j65bMKiaRxLMz4oCLgnRfzRyLDdYuy3BUVHBlaGsCwt7vXa8qsWrUkvyR7S38FUPkAZJuRrOf0PAzgW/6PP3bpETtqoc/HtVaRrBCLUk+oR9jB4q5n9XVvTHQvnt9kpFCam1Nhf4LkVLQncuSf4DuI=;25:/6JZgPzRMlhFaBx/VQBmH7vaskqWYXcepAgNKqzXrQUVLXOGwpKx+oxQExiUnJ6A8+ch7K/TU6XBiAOni3CsZBEVeCi+Zc8j3JAcx8XTKYsy9aoMv1uf5O/H8lCD178lSviQ7GqA4DSXiIdVbgwtiI5faCIf8TNRRHpfXAueuG2FfeR5hnCYzeABJJsbec2TIPbcFL+t+Byx2GqwNKN7ALwEuDLzWOmRj/xVTpRglupjX2+RVeTKFVU4nTWPHyEA1Knjbzh1Pp1XWUJcrYp7QqNaBB1ExPPRakCbXdfANisRupO9ujuq+DnWuAcAasrrVUycxCtSKGMb8pdiR3zWxS3NA8t0Eg5PcjEdeD0+QzM=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0762:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;31:4/dS15Xu3EBbJenSH+B/ZcdXO0svyzgNjmxKer7MHqpl8TRSyYChPo/EAPhpvsNi4GZop4n/znQzc3BECQbjRWHhXCS9cFPWFdUJDKJcT14yNwQOd442b2uGkvhtI8hhX8xsN1g4bHqznizv5zvypQPKiGsQooTXhYH2/FPGVCSXV9mQsZZCnUirTnopMyAFD3ZgvYZoFEINy0fPtjQCPPz6OeaJ1cczCyuDNVubpjY=;20:ca8QlswJiWn+8omakVHZ9iU9gmcouKlEaA+crTOQz4vz0rlq+KrrALF2S33zK+imRdhKix0PxA/qc/+8jlR6qVZd5i+GIofVH32ROKIpZ6mgyZlvQr5Lsu9M4WFHGQDZZpSrga5oYHwuU2vedGBahHNo3mP5mxaA558LLJCLa7bvoocvVMMBIfdIpPmtc7SCZIqBkqnvXG4JgNiahrt9RKBVLGONycW8jsPPacNqj4NJ8tvTyTigDBUJ0jxP6BUP2NhNQJuU7gBF3pSKDw6RouQZ7uOd7jESqhIwxulhwN2Yey8wtczTnGmeD3z6hs7q3KsvaqR/7SgHuCeTjRaCmabGAfjE/SuFlVZxcLVvvOCsSlF+zcblfzf9T0QLOVB5ibjvk/PPnFFG+/nsSZvKmYuOcEsB1J9xNxgHZ5cTEeqxL2KRKmY418swikFAlMV7fH9H8wqc4ruIHMEQ92Ha669SFaq39qogm+CjyRDLXXqYeJmn0bLuFn8CjZYU9DkY
X-Microsoft-Antispam-PRVS: <DM3PR12MB07628BD4D777F987030FA546978E0@DM3PR12MB0762.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR12MB0762;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0762;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;4:7bfDEO8u9jLI6HXh+weiiTy34cmuy+6g6rTYsXX8pnX7yTOUE4ItlE25FYLuHyX9pS082eJxVO23k5jp2G0RiCtvMwXEN7u/pM5NVdzXih5GA2eTcz96feRHhvwUuduvPwUyPGOHTuFbu1wEkqK7xHq/jB3t8M3HGc0ySgdDK7WQeWe4MfVaIRGFEqQlLZWnnKj9NeRX4H43VSBBxftF1In0akOdlYKc+zxf9KN7j8aGEhGWlfGrlqOSOJG2pQpaaiDTIQYjJfEK7Fdi303TQqNEyhxIwIMjbyZ3FTIzIYlfyM3c28wmaLAJRZXwm5CR
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0762;23:JZbiXF6YT+3oIii1jWtJot6zEBFEOFhIVy5BnZenR?=
 =?us-ascii?Q?Lcn0wB759zwUh2k6TjARn7BC8Jc3Z7pl912B9kx9+rJVf2bJKVnJradP46Mx?=
 =?us-ascii?Q?iNcaXScWozHQ5Xn5mMlIvZ9qNRsAqVTQdaf5OhLrKhwM93jk6V70oaFYT3+V?=
 =?us-ascii?Q?RrRgXigdROr55vJw466KoscfX7Lv9e3AT3sLoYnFv0eR7R/ZHMydS/br5iqT?=
 =?us-ascii?Q?+VQRGNRRfhE0vJd4NN9//fGkZyXtZNeYqDtiRTnIZLhReCAgKB7iv+/8emhN?=
 =?us-ascii?Q?EOaM1fBRsODu1cu6H2UxDFFmFfyZNmwVGEo2oxo7+63XZQnfXRdKixyH/w+9?=
 =?us-ascii?Q?pgTcz3A1kcKa27hqBK3WsuaiIsTFM6SaQ3jiYCP/JZ8+OrecYJJQCJPToez6?=
 =?us-ascii?Q?uPFa7vrl3qYXiDawKH5cF2yqgGO4UiOJpqBDexXcDMadehMlQOTgU3OhwEex?=
 =?us-ascii?Q?spzvbg8yYqL2qzyyATyOOz5qNDxeS1u9s7tuROYErJ30aeiHMjMRlAgs75r1?=
 =?us-ascii?Q?MKH3o686Ok0SNc9mSayAkz0f9TgOK/GIkju134Fy/dLKpq1xaBGuoViLk4NR?=
 =?us-ascii?Q?poj4CzzgVBrPfpfwV8ShYF6VsWMRI7jw2m+xMjE9UKRQdXxYTCTIGb901JE/?=
 =?us-ascii?Q?3CwXY0qebonUld0f4lRxzvR8iAm6+9/I6X3YILckcRx1kXXLaTMc/JZkODkU?=
 =?us-ascii?Q?/G6tOqQ7kknJJzIOeZaCiWnPWlNDNkCLS3n9L422J2CMAKu+McKSxFPkUrSN?=
 =?us-ascii?Q?7Uligc5WIYk1wF4BVHQrvi8LgZxvXp/5GWPrQBUdoIksskC3Sf7RYQJ3jac6?=
 =?us-ascii?Q?BfBOotHxbFdVchDcbax8hAD7sy7fWwR1eVfEug9LIAsEhgWC9R1qioGAM7uM?=
 =?us-ascii?Q?/PHDNMdUt0QdZin2IqLHMNH/NVybhsYGff6TCW3dRFUufulUxq3iXxkM+w05?=
 =?us-ascii?Q?IX0a3uhguzjS2M7hePvVThuxdnmVZxDJsMcL/NLMnGMoVp/7cdN306AfABqE?=
 =?us-ascii?Q?f8xx9LwpF9/AkoHhpVbOmFkorXfyRvq50Lxcnd2TZeKhv8yxPCmYmraquTgN?=
 =?us-ascii?Q?TjwCGcKZI9b5xLq/DzLkMNZD+sbfZm21YGlQKconsaHhRyXdWfYg6sz+LA23?=
 =?us-ascii?Q?k3QCZae17pwecxYQl9LNGGp+xVTQ6Bimon2VslxGlj995BC9xbqVEy3IAzJo?=
 =?us-ascii?Q?vWz8iOQtp97flyE6HI05HXIQSSqPYcIZZpsLfQdAOOlmy5Q4wEZUJAHZw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: otUh1DVw+Y+emyn1N3OWdOKpfgRSu8bt69bttGuD154jSm50NLmqm7oKSPcGGAH8Wyqqz5BkQ7wVX9AM+QSY0Yu7fdwXfotpLfT3zTFW5hXpvgWkdDrwwHXP7DvGG2jF1TrYfO0RhcFM6QAZGN/1WPupQ+bv+rlGsCh3q677kSbuNB48ZwcRf2iGiJRa7oyu
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;6:/Fl6jIx5R8sOB9fx4jbAQadnwUWjZbZD+/ur8TJo92t25M3vZxzev5LRxiElKi/g23CgKXwhuwzqQ2fM3GXjRnnSVXS0S3+Hmd6zyE9i5vthDS1z15OvYbe7NznGRuPzOPJyIGX5JarRdyrStbQnASBnGdHFb+srAESJU3GyTLpbhl9OvyaqPyAhrdHEur9dsYTCSZ3wVc2eC+e1rQhB3UlO7rApLVG+1jnCqqb9Z3YP1VAs25t1MC8SkcG1Pr8Ecf5Wv24NrWZZKEVKBNADHSU9DLbNc5Npfjde9ZGjR0vv1ti8sORcipc0CeGPPI4OR9KLvu5AsWGJKZxo7ntphSXwDx6VsP7A5qfxR6Qb1mX4Y3LvCGCcJM4Fm/sOQbyhkSgrjZZJygaxeENU5xudh8iTIY+SYzq/6q0Ibr5X9EAWc9Iin7Q+EBXNZNo7J8gQ+7LuR2qLDEWOSVCfizyHGQ==;5:dQFprZu8AoHi9sx9R3sST/pY/vn6PnDCp2Up0k2lsP4kl3DxAeDguRZE8L6YZG1MmqUjL1YR2+jvx88K2+ANysEyRjb0k1iADk5XVwEkVX9TMY7JL+/cjfDaOsXYarwIBjUTxShw3QOR0nuRawAbPvw0DmZQs5sYwi5Ue1+ujCI=;24:/by++zcyOAmiHDZwNRhuk5Gk55TZxSDVU++HMB6GEezDNj6WaNteJYHd/Jxh/2JfaDvfLNlQluxe5oZc76mFlMwKMHlU339dVuYIGAkyvdI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;7:pX/SOe8aYONEcHqk34EVALLUkCdPSwaVBjhEGeFPD+hoFxZmNo8fnGqEpxbsB3KXoJmwuUB+wUw9oLkEr3IWNSMRnxDl3VIRlkKDoTO72u+h2EZdKwLZglr9YHb4MFTY7/kYmY44XcLBNO3rRRYO4rCvnVwI1LqG/wc5smCzz6rW3uCewueorkLVXCPlGIuhXny7vJJNl4qL1UKpgxJvu18huNoPdC2qLwKoJlWHu/Fvc+o35eriRlMfduPRszPE;20:wmREZ1BdkoY0za7n6kfQ/QCzt49GKr3ASBt4nLcl1COtzP37rREINXupYiyuBZNUL8ykVnC2KMxxdQBlHyN4i95fM3UcTfM8GiiVctg4V+OMv97EpFtmYQYavdSzqZ2lK3Sr2xCFDH6dYuURGQwpUcRxEEsWYOefw+NTHXeKE52XOV3Iyr2VW7dIJfpBVBUuSEdqg8q7m0e192u8LD3E8YRPpBDECeChu8GHLk6MyE3bYrolYDa/4hQRLaXAExwP
X-MS-Office365-Filtering-Correlation-Id: 26c12ef3-5123-4e05-252f-08d5ab671984
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:16:03.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c12ef3-5123-4e05-252f-08d5ab671984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0762
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807203680552021?=
X-GMAIL-MSGID: =?utf-8?q?1598807203680552021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added pte offset variable in audio_substream_data structure.
Added Stoney related PTE offset macros in acp header file.
Modified hw_params callback to assign the pte offset value
based on asic_type.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
 sound/soc/amd/acp.h         |  5 +++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5f34be1..cb22653 100644
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
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
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
