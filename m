Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqJrVvh9tRWqseVdj1IoOdUBfDHXNnxxSM/kwgWT8c18hUVIDBXfTOu9T13yEDfVH5ls5WU
ARC-Seal: i=1; a=rsa-sha256; t=1525207745; cv=none;
        d=google.com; s=arc-20160816;
        b=OCb7uAvtLGfZqnPri8qJ/yuERRS10wDAEqBmBAGwqV6SEnbdWxCF1QNazEFrxNiGt5
         dvrjtgUnUC1Ucmf363fxNN6Pn8UE1A7wN87etZ/vp6n0QfHQLSiXET7aI/USwVqIhScH
         bDM8FdIQ5bzcD5pT0gMJwANRvo2In6ySJL+DaebUOUO1RukMAiSc6x5sgL1d7nsjKqAo
         cTEQ9oYkpkiC73LvWolAMWt5g4ncJb1o0lndM3Wpt0bLEmTDuyuj9aoSRto0E7+9WD3V
         iQh//9lkFzHsSm1fvgx15FlkHKHQAMft3RxvZXTKuLaRSq3ODn7L7wQ91XxF84SHUedx
         +O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4Vk39zfFUMWy0n6zerHU3onTSfIhrWvck3wjgqIELaI=;
        b=qIDsgNrw3fs1tuTEl4WwrPfnepPePGtqPmy9RdONqvsYxw5Q5BiigQDgZy1XjPzp0V
         XsmmnOde+AsJKZBpSnQ0NKrIPzZZ9lo+mgex5E+x7dVscQHoWtCSm9+titj0mIA/Bi35
         8fcYx9TfAYsCbfg6tnfYD8sDZ7MN1JTFPj/NXIBQJjIlLaCXe+vSl2kIUmbiPCvZj0tW
         NL7/YN+Hq34AIKJqXHxirfyk5WCnEU3TEFIiewuef5Z4Qra7DVt+iNHYIlM77MUT6cxz
         DTETLtZjOPb6Y7kik7nMEGFXnlDpFlbTTxZq2A8P49phq/5eQv6rlj5GwZoS2m/B4/j1
         QeQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=gD8ehhVG;
       spf=neutral (google.com: 104.47.32.66 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=gD8ehhVG;
       spf=neutral (google.com: 104.47.32.66 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Jason
 Clinton" <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 04/10] ASoC: amd: pte offset related dma driver changes
Date: Wed, 2 May 2018 02:19:58 +0530
Message-ID: <1525207810-1305-4-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(2980300002)(428003)(199004)(189003)(7416002)(316002)(109986005)(76176011)(305945005)(7696005)(68736007)(86362001)(104016004)(54906003)(97736004)(16586007)(5660300001)(51416003)(26005)(53936002)(476003)(81166006)(72206003)(8936002)(186003)(478600001)(47776003)(36756003)(50226002)(11346002)(106466001)(1671002)(4326008)(50466002)(81156014)(8676002)(486006)(2906002)(48376002)(77096007)(53416004)(336012)(2616005)(426003)(126002)(446003)(39060400002)(356003)(105586002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0756;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT020;1:ihCXoMsAfTjbZjf4erVh3xPd0K4bNaxKrpT/kZ1gJfMuF06Id0hQxU2tHhdLnb1Bt3oYJ7JAU80dH8iVcnJxBZ6W6AQVBfuIqFhNYJW0kwFJ1y8/GQb6Jd21Yq3UR6vQ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0756;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0756;3:xvOXd/Lz1iuZzx0n6eYCWzI6VtIOl6cOF5BmL9w1vqhxpgd43WlsxdrCLXvGLQf9jzNYMg6ujXbuhFxFWZi71CDRV05f8j6P2xblSnNIAIDlI2gyxXfeUikl71/WrEx2JrMJE7EIqOVDJ1W7kcQFn9Y2kONr2R7fP3gE31inYYqrnWcAPT3hKO2mgqbIQqzPjLyDpzgRl413cxjCkse08vQkkgRvHdPWEJe+NJS806hIX1wTND84AYWgjSm3cBXzEzGZxO9sBanbbxz4SLphYBe6WZNwsLbhNA1NaN4oKZTozKW35IaNoLD/fxw8tBFgaA1I/nDZqFWxo+p6N0H/8r2e0Mwn6QjoesZzsdtfLqM=;25:0g8ZtlHuWYptM/VDoGjVC4N8dDSfy7wIY+pWb5sQeslNVLcZgKE/NrT03URxBqbFFT6oFs5qUnWc1ZH9Ivk8NnkXeH/ZWKflf0feNA5DGpVvyjwvGhmEwQCMdAT89590MtLmNIlIh8juSYSqIPSzMsZrW5BOMIym0OmjA4DEiRGR/SYRz/nI0Shjq8Z2o5oZoHu2CzeK+HJf/01ke5hWohKSVpn0WjIjhA0qjRx8jR/3Y+7p7BilXY7LUbT18rxRvyturofZnAHIG5acUsi9DoIivlG9DVRfS0o6DvoG5MOtRuI88MqiKB5Z4bSrgqkM8UlbQ3fiMC3hbrVmV3UOUg==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0756:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0756;31:yUsiTkjoQTnn+9VCDkSO7e1vrxApp6DNdL+yOUh91YcMWTDRSKcvT7mQs0otIAXmAWyEkxoS1mgueQJo+tYzVVWOXvGPG7Dl4gDBqczW6lSND+sQE3Yo8PIewltSM9zeX/warbbiKuwQYG4nxJ7QgStPTZ1zXjO+dE8JKZJkuTk2vD/0nCjF5m++ESvOBBNPKhBvJadKi4dXtmYeqIoXLKXhSZpGRUuuFHTwSCYqreU=;20:VSK+aDRMXwHwFwNiLO2VNTjR3r+6om1b35BCXTN++i3nJu0WJ9rhlxNtAE02TXUj3rrT1CSMSmD+Rb/BYWpY6Pd/L9xxTT1MYxSZtJ9xfKZh7VUxltLxKZXx0m0Cm25z4+28293ai/SphjZ9imOeaewsfr6ggtoHo60WJ4dgXKdS7MCESemMKybXfD7aUZzPKTfhdOu0BtThrfOSujiCjDVjERTKSwvGVrCjvTXeUU9k5KNwVSh1+/Xy5pgenxb4bRYa6qlKYbfJdVBVksXJt2S01TxT6qRFbxZTU9aKjZjurL9mvQ4Vyuko2KIdvpI25UdPM6YgZNpGx9uF4ssUMQ7/u31FSdj29QAbhLeBo1VfziGcl911HsfJWrJjl0hoeDCgF0aWGFxuomdXenOm1Jz1gMx8DOxMlIwUqPK4Dr152iBxxwbC7oHpJazdbA3W8CG14LaxQsx0Fznz4mvbV8Azr8jaW6DjkJIkUvCAYi9iBOB2+nmOEVPswVzIV04V
X-Microsoft-Antispam-PRVS: <BN4PR12MB0756760FA27FF35DF09EB05597810@BN4PR12MB0756.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN4PR12MB0756;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0756;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0756;4:CEkmfJ6lfgwhT8Kjx5P0A3b6V0Kq92Yi3/7pfi0g/LTRv4VKagApmfPc/VEGiouwI7SYf24Nci8udpxrAa+AIs18hrBw76uFrTQFFnD6vL0WqO45I6DHzJmgbnN8LZwVz4pvXMkF2/bizuKxTtvxh5BqJCN7J2MCsmqrfILJj0NsH5KsNTR5+nZ3QUoLEoMyqlTyo7jQbUD6Ttapmfq8kh/tRlrR/cvawp7XS7R2fWeZq7PdHjg71CZjuhrkXLnNvAj6x3BdfAXt8V8844dv/ePj25B43PTlIGJ7fC23gSHeUv8SD/CTGXvbKEB/M4Rk
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0756;23:yQxdNuAuxobvRxrgVbDipnyW93V8tY7XT6zs8c42W?=
 =?us-ascii?Q?59F6PL+xoJVTMZRsnh8Of64FKCo6WaRNr2ZFQzNPfwt/GegngmJhZtiRqKrD?=
 =?us-ascii?Q?JXNxVARDunD6Q2SOYdjc8clCX1i8YkmuecYv90EIP+YZZIMF9lK6mVa5zSTa?=
 =?us-ascii?Q?1lz20s2OJzzILuUPfh9nLnUf2flzPptlIo3NWSDRVCaIwSR1KcuK6x2gkH3F?=
 =?us-ascii?Q?FTZ+xJbTlu1wN+u1EvVf9eNUzLYfG/wzl9opmNAoAOUy+rybifFdTmcZN46B?=
 =?us-ascii?Q?k9QPqYldCiyiKIYotzOI6n4aU7w2msORugW/pYOygsoddj5R3Ys4BXz3l9U0?=
 =?us-ascii?Q?ZCcpJdxxGUs4GOh3DkPSY96YlWVmB2DwjY21kebHgCci9aaSKh1nhij9SHjj?=
 =?us-ascii?Q?wJ895YGwwH3IG3FyqZ9qQE5U3tiSTEeSWDd619frX4FtW+WbWDRptyu5dA+W?=
 =?us-ascii?Q?vFw6T+jcs2bq8mzC9Ywl4gyatagN+j1ngnz9HbvkA4GFtAiqbRk3icCXOBXh?=
 =?us-ascii?Q?ibDtn3vuCrIHuox9lpHWwqDgikprWWBpH4bHV94gC+yjLOdN0mRtuB8n+kVN?=
 =?us-ascii?Q?ZUUQuVb8xsK89dzNFDYaOj4Q/vQygVsuFxapgrWUGhdVaeNuw4Y/+ewY4bDp?=
 =?us-ascii?Q?M69LVCd8mENPPaGuvvEUtL0Zd9VWEEF7Z+kQZOk6C29KNYT/EpVQ64YkOun0?=
 =?us-ascii?Q?Jni1aMG1D1WMRwRDGfIDXCKgnAEozX5Y2OtsAcoEsHS6ncrwHFEXMU0whn9L?=
 =?us-ascii?Q?KdS8JaNWT909LvpfcgDmfipkHCl6foQRxiC3RgsuA1TXovW/IGdTr7j35RfJ?=
 =?us-ascii?Q?XVWRvmZ9jG//WrLxBgeUHCTYTeE/NtB61TjG6hKBEL4bZCYDnFEg9gaopjJc?=
 =?us-ascii?Q?8RG0r58N+8/kd3Tc7qG45smlnN4IcLElvbttNVkYDD+1iWCyiHImgXCMwoCD?=
 =?us-ascii?Q?FU7ivti7o31uXrBfbI1f1wJJaYAOVq9YYmzI6TV2N8d2kcQ+TgBqnQpOHJmi?=
 =?us-ascii?Q?8bKJL0nHDoGrFLy7lhe+l5+1vq27VFyLbSfNfkTfVhv7d1gIQVTZV5CD1UrX?=
 =?us-ascii?Q?2zOqEfNZXz3MRxXu44BTGQs5h0+9/MtYGyWL6DNjtURkJTXqdN8iGZ6x7S/4?=
 =?us-ascii?Q?JIB1uLOBQIh6wOCanSHXEGnl3bV3NPW/+Ezo7J3n4RRJId9BS0TRtlX6abvq?=
 =?us-ascii?Q?FPRntWSsWMzX7o29cRN+2ivtI+5lyZukh7XR0OpAwe84TGE3HLa3yhA1Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: LHY1OnoiuYzO1fge1XgUJDQqsWgucvmtIlC3VULN53lbArEttSGxGn3ffdCvmT8hBIMhZW+yBps+Gf5zBc3HSCf501j+WMUw+0XyZZ+TT3CrTyVYXEzxDgCDNQL/BKxshpwLRZ9bnHrT3Q5wYdl6yeerJsh1SZcvFNFtR1LCPNGLyFLZ3sb4wo22CnjwCO1a
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0756;6:Uh38erzoChEgecbmSI2ifKBUbwh13E8AJ4WeiQ+dZdu2u7WfdENraP2/0c+/zsPeidrvq5cztagS5LQ1lJd2U9x/bg9uXYtREgzLfHeoynd1U80Ld/f1HHU3ZRMh0aeg5VYykeJmdGP7nkBNnvPSAWu0EW9MFuT2Om7YrJ5mC+Zt/zG8pvpicXmGvLhh6AHQaED/lKBT4eVlZASzXGnuOxZM5zExhNFcW/oOvpxZKtGhIyVpnSyMQA9a1HFQs1kapWKbagteq81H6g5fMyypR7ohrV1zaEkmXV92qdqFIVHh+UI0ZRiZdQ+TOQYFDZwbVOsZKSlTuX8zSQvhs04LvYrk/qbfDW/oqf0KPaeaMgvzr0SBLb7hqwbHvndQP4ehOpAdSydTweWC6s257pkGzliKkPFPLdtdPI9LA5UsqS9A0Uma3OyB+AEeZN3KXlvgCt+gZUBmna6LNy1LieIQeQ==;5:4GR1JmeXQB05CVaYaBIu3ldWhuqWl5lX8zRtdn9PQqwQ7fJm6DCIhBQO0q0f7wImalm/JheRklm/mr0EbRKTkiw+xzuQP8784sd0vybaL0sL/FEXkHKppHb26BNILfvPO3oZIHX0JUG0/3ptYEob/1eYW9Rls88oF2cAhvoo3nM=;24:lNZPERGF1WBHIhPzulTtlpBpeVAnTSF2xfvArdSzCHkIXh+ta93a3kHPhqvHfbxgnzWwQNgiwj6o/qpD4VjTHVpbV3NI66KPYdf/TbBmN1I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0756;7:GOARqgJxd5v6RMEs9iFqIUYP4b997zgHQIpYVdwzK19YFoRwj3L+g6eerX9P4Sxqh8rjALPcKQ44DqjZmW0WhmBR/ivBUn9kmJ3Ti3aRNut6ZxG19wo+v3wumGJAL0kb521YsrQ3UM+/1/psXMultbIM9an2aknddDzX/xVAkqyqmH5ZvJs1qtWiYQ4ydNC6WP94w6Y8DcCtK8UQz9VI3x8jWiK1Jf+I3x9fG0uTdT/hPmCrlG87XFX+0ynr5EK5;20:/j9R/A4D059XSbn5+BDC5SURDWIbFZQhTn7/nB5dZ7PQxgQPRn3y+AtuX5vBSKFJoUx1A4VMKNx3QiDbBWYQDzaa3Sm8kLDoVS3f+EOCtBPg9xfE6+HhX5tQKuj+e3v+vZ8250VNU2SWA2PRqkh2qlJ05h08wvpkFp1dv2z/5QeEafJmFEB0ixwOkck7HwyDAzorZQNGSZNlTzVf6Ef1/HZXV3EcyLz4rUqjAUCQgOf6fMHiNFmaBWt9Rcg9/geH
X-MS-Office365-Filtering-Correlation-Id: 468a437f-1757-4f56-4852-08d5afa4f7b6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:49:00.2896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 468a437f-1757-4f56-4852-08d5afa4f7b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0756
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296236875612032?=
X-GMAIL-MSGID: =?utf-8?q?1599296236875612032?=
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
