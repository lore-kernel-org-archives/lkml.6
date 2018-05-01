Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqxmlDDLePZjQbcXGWU6avx1Oz7UZjJgH6UMiFgHJFb29F8aV6Lx1KyobcyBWc/Bh4FV/HV
ARC-Seal: i=1; a=rsa-sha256; t=1525207685; cv=none;
        d=google.com; s=arc-20160816;
        b=PfTfE5LlK3RwClfOQQA8LDHzZMF+98bc9PxfFpQLG18nkp8++QI6S1RxdYKARh7LU8
         geSoBRi0pxymVoSxtlYJ3sYywKIlDzZe/PbQc+5aYKlVTlfc11dTsMsTidKwiBwa+16m
         eP6XwIsV6T3CH+l7/awu6LdzEMPbK4/xikXQdBIj7bOIOHjIRZg4lGjyrJwhsbBSQlie
         MvfYm/LFs8AQfWvgqbHw+dPa/opqPeYO6/0Z0cloO3TVpiM86iHjKEk4yTDe59WLlM4y
         ST2Q3ZFG1NUsOKoVaQiCthM0LXMSh1uRG5AsbbtGkLDS/VRv9rnLJPLx2VPh5fV0Hb+0
         1kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BW55bTQmvWxTvzTfib/DFm3GrV7GDx1wvnPjDnmM65Y=;
        b=GaQWG376eXC0X5PZRtOkTRnMgjUnhB7YYrxVtxaAmAXPDU1ELH0oMCdVE50trfZ+Aw
         fpGaoTrj+AwoL3KeTzWmHfvwgMJ7lCL44bb1biNayIHSPmIu4i7B8h7qo/imR1O68gIU
         i2ckoMI6egJM26YiNr+fnBdPxWFPIflMVVgDEIM8QXK+hCu2Jpns4OGjJCMlwaf0M8Vw
         am770APoPSs4h0n0/xnB4vZvoxozLQwjLpQThhvrGsxG8ptye9G7ftLwh+hRoag/NpNL
         TRIMFlfhQlTmdcm0rB+SDOjDoPoECXb68/E0QPmm5lFyvTnfRNNDnEm2MGLeEFg9u0/g
         0cbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=h260CKqV;
       spf=neutral (google.com: 104.47.40.46 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=h260CKqV;
       spf=neutral (google.com: 104.47.40.46 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kate Stewart
	<kstewart@linuxfoundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 02/10] ASoC: amd: added byte count register offset variables to rtd
Date: Wed, 2 May 2018 02:19:56 +0530
Message-ID: <1525207810-1305-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(2980300002)(428003)(189003)(199004)(68736007)(316002)(7416002)(26005)(8936002)(5660300001)(356003)(109986005)(8676002)(50226002)(72206003)(478600001)(104016004)(39060400002)(81156014)(81166006)(7696005)(76176011)(77096007)(97736004)(186003)(86362001)(305945005)(51416003)(336012)(2906002)(106466001)(105586002)(48376002)(1671002)(47776003)(446003)(426003)(4326008)(11346002)(50466002)(54906003)(16586007)(53416004)(6666003)(36756003)(486006)(2616005)(126002)(53936002)(476003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0768;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT018;1:Q6bnWb0EM+pR9NBiJp4ZdFKctqDTOOqJjXo13MZF6ajySZAvh0fGEIDYPw1t7R7kld7jSUS10XokvYw1QTDKVMGQwQ7t3D2423/NBjCsDFZSgT5ut+QJ09UyQWLDmBFT
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB0768;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;3:1hnl7nhWbgGEEwOcLc6UuKFPd5KwpH2r4lb3swr3DLXwoPLYM7GP0khH1dkM/lgP2Pm51t7pwI93Bth3+XA1CZlbXGIHAHO/y6wCF3baC0789YcKnbLImuciEwCBG8ia1G5sJnoKfU/Wr0lZgZ7rj6F6878I3SIl6Wj0e3DaTQed22I6F1KqXLDiwhYpwQtogmBmG8jh1x8KFxRi95OG03IeBVTjAAGgQsglU0wVyUpIr2yl0yLuy+t6IXvnHeUYp0lC6uysc9vnNlXEppjivuRvmXMAG3EVQ5x/bU4+Y2FPBM0gL7nMSgtPjBfXUmbbMjLOvDukawQ9L6FtnNuYV0ucwFL8Yl9dWiwtmFP6zVo=;25:r8xPZhG1kaz6oEjcTxOqnxaFwevvtYXJupQYr/Jbz3NlXvfR25m8soHH2BQb10VfrVH+mpNgrLD92FSXJJxT+9gBg5nRg6MhSfavoilJKUHXkBLtaALUJvdt0Bhcz3mFALNEax++X4ZKqmL8FrJBd303a9193CGcAgFzDCV9qY2tkORtdJDaoKBiW6c8lMe+ffW8kRdYH8l+9kwfW1ATid+woC6Hekho7gycuRzb+1WD04g+xcxG1F2o35duYvczeNApInKQI9UUPAhYS3dsD86YtSKqzNkYd5jJin+AqDaYhjYfkx6CPIWzzaki5a6YgT8DMVjxbG2b6WbDNq2AeQ==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0768:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;31:1BTtt8gKBNqdLzo2WfQiGrf7cQ/TuOBuL0/rOF9EFCnx0pex5xNGCYt0R9Rs8Ygr1UHECmRob4TW3BeNbnJdEdrffmetlHs1cTVvc4qUe4JUBaHVaZBxluithA4ThJCthFnYepLIofgAoPAhsPyQICe7WikpJ+/dHp+HHT79DZ73Ymv5QRafBhkeYOyo3kpkI6IzGqbbsQ4syIkk8LlAiJAkZuXX791M8eCW3zZxT8E=;20:IEG8eH+gvmdFYr4wKnNZXucttIfxCNBrQnLeqmZIsxWnHF4NoOWZBO4NuwjWrk30E1HE5j/0UntrXq6HarRaKaIBxpTPttMqQc0W3YesObqh9icNfANeIiVNJQc8kPMDMgUquq1uIuxeULRsC3V3yvTYzbjRXr9Xm2/maS21AiEciRhuKsxtYmEISa0swkP0TZO/c6+61FZXINIwH0jhF2qu4Q9/ps6Q1wf9hXm1tiQkJsWOD/bOOxtfu6u2vIZWztMELSIjtdpBG75toS3Su1uCC1WBwOoT6xm7u5CBK+deAhpw/rFt/wp3wVSxU2/QLhnFvpqDeTRy99xyyr1Zs1lQaP7Yq1qPGOzZ78csXpP+d46krDf4W1TBkzq+1XucsTmia9/YcIWUWhvixTNF4piBBXVve2J6iFDcNjXizvBwhqMv/W05R6MAqLYDv69IV3hLRUC39of9mxq8/vHC4iMIIvcIoEyMHkRn5W1kgc0n1EplvNb8mqSge+KrqjXR
X-Microsoft-Antispam-PRVS: <SN1PR12MB07680102B10CA0532D74966F97810@SN1PR12MB0768.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0768;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0768;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;4:Gm7dBvctNANPx6Zb2xAH98mIPXF0oKcUlgQSxEEUtFQojG41/eGx3OWlrkEGkUvO92pvuVHSJg9+z0Fl67djNOEmj0Wqs1Wufzh+J+f6b43Tp28N/iVf/17g9Nng9YRa+JfNsXehVSkWTS3D1kEfAWObBc0KlXheHD/OCltrTIIMdqQq8TeSbLv2jlzg7hW93iQ19j0QCcKqosrnXSUx4RCQbBJHOKzyCoB/xKir76GYdIc6tl7uE6+0dc3BJNz645NrKN0dF7QGqXtI88taPIwcX4WDYqWRTTwAKgi4k9A4CYH3Dz+587laPrAgxD9i
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0768;23:cOBQZmkSsgB16w/zn3ND0xCSKUF4kJC1ZiV70lSmG?=
 =?us-ascii?Q?JcB/7eCpeT1b/fmsJ1MjND7gjGa/6AGFG++dK57MPxz/0OW88QMz5XDq5191?=
 =?us-ascii?Q?hICKJSv1IGzqT4rmTa//CUgkOSdqE3kVXgwHf546W/DzgMpBplDEa++gk759?=
 =?us-ascii?Q?OGq8UKEaCbv5tEoZ1whUaEhcqXe+bTA0+/sSLDpjC8VQtlKrORFr0ihjnIP5?=
 =?us-ascii?Q?GKGcAM8v8KpyE0CmKNdTYoZDibDkObiR38A0yzmX2zu86RLA0Li8CCiyFSqF?=
 =?us-ascii?Q?DbP1SYCZWSPVxFUC17YATU/Wa5LYjMhlh8+gLyhtNwNC+E1sZM7uq+jPA7Aw?=
 =?us-ascii?Q?YdgVJUcdowvxrGxkFAWsElxCQTy34xyAmj4s6u3cm7rEvZb6HwZAiQrcwQlW?=
 =?us-ascii?Q?vMsYE1M2XfbtOyolLrBsxwNZL8P8npzUiWWixxN4rJozasMSqeX3oZU3puon?=
 =?us-ascii?Q?VTNcrl1xeWZzp1I4LoMUqhwrLIo0kcaZ248gDOt5szs9lF02KSG36e0GUfXA?=
 =?us-ascii?Q?Dl4m9yEqMqXcDCZfcKkN8cGoh1ux0+u4sewI/Gqcz9rcx0juRsMrS4b/mwjp?=
 =?us-ascii?Q?hlITy/ckg3L5FMyarFgc+9LCVncHahPTH3IJyzOoIwngtmw+Mj0Bx3knOLEC?=
 =?us-ascii?Q?S1jnR1R5Jz3qs+epVA+/lSdtkqNnuhKNUuC+rsax+z0t3/ZlptuLq+J72tyq?=
 =?us-ascii?Q?r2nZiDncP0nXUxYna3eAQD6AUW40leR679aGmY19thaMQFhRXcvMqZ9qleCf?=
 =?us-ascii?Q?Mk/bn3Ifl5OxaY+kjbh79g0duY5lP7KovTCHPlooK49Pi8JOp6yqLJLD+1QG?=
 =?us-ascii?Q?gdOoNVNPF78YmooFFo11ZZehe8Us8IoJpaf0mTGV7WzFlN4DP8cYQhDvqmjd?=
 =?us-ascii?Q?r9GsvBdeBCQzg7/Zgfg/uJQJHM5jtHmReQ2fSzmw5pn8B8iPXUXvXK8EzEnk?=
 =?us-ascii?Q?1mdXynS5QiKb7YT5qhhRy8+Qs/gMIBY2HC8JnyvHY788Y5+K9bbBLJGGZGqg?=
 =?us-ascii?Q?9rdV8Y8l1OyZN02Ar7ENpkH9DLpdVYuGZ9AUpqkO3TOrxjraWbP8K1P67LAY?=
 =?us-ascii?Q?cULf/WpNNUb0XOPwjDxTq94ep3h/UmhEKm2hWDgdqFyY5UBAjBA30BQv28hk?=
 =?us-ascii?Q?3RHF6JM3lJRdjWKZib+VAhi8SMq268Q5XiUFuChV8JlSUHCyWJ2mRVO2PdY0?=
 =?us-ascii?Q?IrWDUFT8namqARwmfjqhE2iMj2f4yWPhLolp8hpKldHW0K/B/zaTwD1E9qy4?=
 =?us-ascii?Q?4KN7V/jWlQ1oXqju8Q=3D?=
X-Microsoft-Antispam-Message-Info: ZtS4MQLtn6Pf0Plh49dV8iJLTBE8jL8A+Mrz8Qo2H4Ng4ADWNe6elI0X5AgNYLWuBuWCzJLz2NapFuGnTwZAalM9Q0EqbFXTwnRHP10uFC3Kb6GI+/cYqlDldQL3QSNfSorsCXzZNxnRqG3qlxnepgwXfr+MhyPnGWWDoYazLMqs56vlk+TU/woqhLleoqtC
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;6:JkJoNVbrJvy3TNSgNUlvGwzi7KEnaId1tSrBBILBkA2co6vviamdTWkQ8TH5+oWG8GsF9aC6LkYMuvLF5HqSE2GmZ/U5x9dvaN3LFIUpCOZ1+v1wlnc2A55T1Bk1X2vvSG3+2jJiv5z9zoTMOvrf3cYCkN6nRQgbgnl7KSdm2Lk5/Qqw4neUBIcHnC7qiXbH1LLh2+YSlc99XgJYFy9HF8jTgLfmqNUrbHxCj7+HW5rQBVOb2J0YxHFFnUJFyVS/XXjsMTLNv1c/4MLzZoLMeDjSo3OOYo5ZNpkGgZkfrX8X2PhSacsqEv4/oWG+57NOVVX5VenUosqYMENhH6o9Va0CQxA+bgeqv75igQ9IhkOwI7/SpBXIROsDoLsNSvmEdNpAs9dWItj9Jur5qDLtAfNjAXuzJ6jkxnGldtdSZKvaEzIGwaXLBDjuWy7lAsMzwhBAh/afNFeb+4ZtlcRH1Q==;5:zP+2YoMhV49IY/mUcb3058kw3HVV5HY5WuWzX8XgeX5em1FXObOCA3i2RrdMzcuvIPNtZR7xI7eHxkJAOpyvOouiMbIILcQej0gPONz9147BjOdvvid/8qSCws/ubIS4oJwvq5ihRCFHnrgTxumckwnw+hpgi7r0uJeiSURS2H0=;24:9axlshvwEMJk7R2fOIrZv3arLYgjFczG3U7A4oiCw7mDGxMRrh3NbUQ9ZE/Ss/QvXlI4bv3LjA3s+YyqRR0eVeDeQcd2fDrj6vUhYHpMmrI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;7:0uFBCXcciE+GnToQFEscgBfDNHrzHvpHL4BRn1AihhWEqYakfjKOmlvCRwjQHNOPJYJJ6Sjp07pdQRvW+2fAuGooPfm8T13RJNTYvDcIEppp/C3SZy176dvGopvSMA2A8T4At0tAq0pX1k9VUE7bAjUjoz3PKYL3poK6nuFC3r4XgdOwR/ChiwwNpCPoZLO1dyc5pW2sEf8l82ezCDoCzCDqKkhJWqw6lfljKBW+wjgxKXRLnFQGgnmL5id5TKic;20:DxUEdOJCo/nBATed8ZHhkznRhsRqbHiApOj+MokcikAfHiHJ97oFXtP6dAmQC37VO70QrYHFdHSFKM9w/OwOy1KEE1PW06o16cj/dDv8xPfUuonbKMD3cerRTWEfKfcBbNS74a2eSpCnA+tOxg3/nc2mRKWVDvfaFFthuNevPrnZFXVtywpbstu26vDOoastcMDgHTOhGf+f0U48g4fyLoCsHVGZqSYFLA3H/Nw4Vj4FtBhUlovqhD/mNCp+FVbm
X-MS-Office365-Filtering-Correlation-Id: d14e54c8-026d-4217-d161-08d5afa4d498
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:48:01.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14e54c8-026d-4217-d161-08d5afa4d498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0768
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296173851499958?=
X-GMAIL-MSGID: =?utf-8?q?1599296173851499958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added byte count register offset variables to audio_substream_data
structure. Modified dma pointer callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Fixed Indentation issues
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e9736fe..6e338fe 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 	}
 
 	size = params_buffer_bytes(params);
@@ -834,26 +840,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
+static u64 acp_get_byte_count(struct audio_substream_data *rtd)
 {
-	union acp_dma_count playback_dma_count;
-	union acp_dma_count capture_dma_count;
-	u64 bytescount = 0;
+	union acp_dma_count byte_count;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
-		playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
-		bytescount = playback_dma_count.bytescount;
-	} else {
-		capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
-		capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
-		bytescount = capture_dma_count.bytescount;
-	}
-	return bytescount;
+	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_high_reg_offset);
+	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_low_reg_offset);
+	return byte_count.bytescount;
 }
 
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
@@ -869,7 +864,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
+	bytescount = acp_get_byte_count(rtd);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (bytescount > rtd->i2ssp_renderbytescount)
@@ -925,8 +920,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd->acp_mmio,
-						substream->stream);
+		bytescount = acp_get_byte_count(rtd);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 5e25428..3b076c6 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -90,6 +90,8 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u32 byte_cnt_high_reg_offset;
+	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
-- 
2.7.4
