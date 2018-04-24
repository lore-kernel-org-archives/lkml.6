Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4/WWhTof5VKEp2Q3JEhAuMa1wjKrYJr4/KIDezK/9JRtjTtZ2aex3HoGXiA6JqADtM/yPi3
ARC-Seal: i=1; a=rsa-sha256; t=1524538945; cv=none;
        d=google.com; s=arc-20160816;
        b=oeZQSk4SJdGVf+LEPcmU2J0TGTTCvXFAsP7O8ND+gBoB06dN1zg5qSpBdtPCUINo1N
         yQiwzXPfUi+/K+BcLhnQycwcY32/b8BE3mIXJL2tMt9sZYg6n9GEkubF952gmB6h9Pp0
         kde0xxdmJyB3j8Wfqwc4fpCgvulWmZXaFCC7GXmyt9hkxNqTVt4Es/mZxnSH4CErC/OW
         /mAYxQllKTle9pb8WxKkP6ytDMiRL+LfjLzxmbackGgJCDkVpKQBUxZS7SBAYiYYQ9Bp
         RMQ6vsqU4npUTMSiWhU4GXN7pUtAgJgNKAChALWksl8p4tinTaE3PmqYjF5g7uynR/1C
         y9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wLcQ2QpWKKKWyI4XBF4YbU/5qjnjB8Eg3WHjNNaS47Q=;
        b=zvoikGw4tOUhfwoiEsLKrZqIFqZgkhw+M299aLk+oQY9PINbNfZAFDC0NJP+84q5CB
         r2Abamv1/rraGbgDpp/k85NO79UKvaddKTSQC98Y5hd2npjafCP3s5pA+gRbS8qJa2MW
         MFjNzOMbU9Z5cojPT+6BIMSRLMjRezQ+OFq8rmvthKC+PYtcdEbWIysoiNLAQnth9TwE
         +B3W3Oe13Xymee1b6NGosgNAGodZPbBi6rXXZY22A0AG/FCNEpymQzpbutueU9NdS2C8
         yHspQDUN41+2N+IZ3VIumaAqqblcekHX5Lt4YXLIPkZwik6fCbQeIcDornZLoyJ8Cniv
         p9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=ALd5eYsl;
       spf=neutral (google.com: 104.47.34.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=ALd5eYsl;
       spf=neutral (google.com: 104.47.34.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Jason
 Clinton" <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: acp dma driver code cleanup
Date: Tue, 24 Apr 2018 08:34:36 +0530
Message-ID: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(2980300002)(428003)(199004)(189003)(9170700003)(109986005)(36756003)(105586002)(26005)(106466001)(48376002)(6666003)(316002)(54906003)(50466002)(50226002)(1671002)(59450400001)(7696005)(16586007)(86362001)(53416004)(104016004)(51416003)(2906002)(8936002)(81166006)(336012)(486006)(47776003)(126002)(72206003)(8676002)(356003)(77096007)(186003)(4326008)(305945005)(426003)(5660300001)(476003)(39060400002)(7416002)(478600001)(53936002)(2616005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0754;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT040;1:fgXl5SfMfqc52rqt9OAvwkpn8jZ3X0hzgDF08o/q3ZBhUfSNG8DrqvcCJ5gBiSrHaKyYgVeWTxlOXn1exlO5qZoJWcuD+CN3JJSvX4XUgEHH0ASPPocIqMK0rrPf1wMk
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;3:7r+u0CrzzCn2TXLaToIzG+gtlBErEVsKQgRMq8UlGS0j5KHgYmWzF7kbxk6tW1TEFp5P7Pz/70eSDfjlxH2IWioy+cFockcURhuPyknRJUY8Yu/NQenSIoNW6NTgyu6HNWZMdAh7gXjV/TxWHGaY0z1bE9UxDSgtNKFP/8f4U+ZGvJa/AjmJx+OpVV50kPvo2v2kSUZnrJRBsuvxr8GpyX9e/qFntcRlIItYb7CWOAWensBRiCpb1M7qmE/KPGSaDuVeiVJHsuaPYFDKBvVLLUAKn/yIisNMoWCx/9PoStydkDTmRvHHMTCMD/d+fE0w8mCOiJclrO5mTVenV8hJ4S/PJhipLcOEN/ZH6I8Wkis=;25:XimXo9wxWhJQtuTxpRmlasI6yOmppb7kDCpLWTZtQWciJUIHUxA8USvwAbc6aforfiM+72B8aUZjyPbpGcskxNauYoYHtU6fZ+b0jT/LAYWIxLF1wxwz+CpNl5CwJWTk9KrACMMRQYrBVv0lU4RohsnL9ECWP8Je7GeRE8f+JkRD4JVM9aJHYdBJDpwSrhFtQ3u85sRCbW1xpFE1IarTb7zh9mGTnHFDEAYEzqxVLoWU0VZCp1vkcJshZlIyA9ewrNuQXLJIEx7SVaBLicJq6yfY/gTP9c0iOZUyZQAV/izky16sGdgbxt4Bzctq1WHaSGpQrqh8Rj2XTGMuLL7Xqg==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0754:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;31:w0Y8qpq5NKn9j1Y4vi34ViK13Nbvst4o3vkgh6x7THiLMHe2gy+XVEH/E5urrCvHpX271RAqfUAsvUnO3ZrhybzLd50a1rm+F/QtOfa3bGlIsNq1Ph2HxYM57GAQSdx4CnkCQT925pX2a+tEiUTgROKW3wi4qmRJZgvXMC4vuLEBiHPDeeHpYAb1y12DzxNtkTtEAC660lfrM0AIzzH1ClIe2Eh9HRc8IeqAmapHK8Q=;20:15EX3QVoLuGKZlYG2oH+J2kxCMYZZlAaIIBTYFvMAcDVy5atQ3MAW1Jb0D/4anGHAzs96tHdveJYFtAo84/TG9QPIouMNWW/LI4cnQmBH51ePWJYkCP2wJ1FuzYHB3543uvJe5stFAE6Yg/rOTNOTLWfwB0vh4Qzo6gPW9j4PVbuT29cbXkwcxLDUZYn3Uh2ENyLzRMBkSuU3Oje8yDCvtnsjNWJwnpvYGWiRT66MTYZleMmdn2ZMbfdBXcyy+Pz59+uN9dZnaHQe1FSbuDiILV/vPBHy8duWQzjx9rSOXnEcP+JsUMo2ozHBHVqXW3XW0zqIc1+Hm0UfyheNafc9TLiIDTGIxY1hZAqVUzBqt5/VZedmoD0bZmqPXcoZEbsqzwIckFV0nqqgtHJOwgnwRhM6Za+gl8jFJ1b5Lk28WTzIgCNpl+Xa4cw3fMbX8xg/Noc/3xdC9G6aK7+T6VwCLXoJboLdxLKkUQo28Z9njLPAS5hsfIMTte17nP5Qxg4
X-Microsoft-Antispam-PRVS: <BN4PR12MB07544987960F1BEA3D8AADCA97880@BN4PR12MB0754.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN4PR12MB0754;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;4:mllp8q4I2YyVWEmcQqYJc4FRYHAfsD7kuj0IviFGXCUyePixosKqTYJHOq3/w3SYQUfSwTcwYcGq5RURSB567sZWEQFmwrBKjyjAEUAZgydRKu1Gw61C7edxPXNZb48vPwM/cTsw/jubK57ARzbQKarHrVQydGuWEh+eXG74Cw07qCJfszFRuJ2WRsvcv9KcNPeG63SdgsbRhX1MriDDDoIVRin7w/pi+FUzx+dyJbIGwXYUfArowDUayS8aoIHoJdayCYFohg7GOFDhbeXa79fZVhtjuzorR/vIttswGe5AWLLZ52uPW84ncoWRj3lg
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0754;23:lLMOWmAi9b1qX+oBwceFiCQguNPwczSj5/HhmHL0Y?=
 =?us-ascii?Q?zEpoyJds8U7amVcfeEkOQvsvve9sii57PcQWLYQw02dbG8hKdaU5qwoIXiLc?=
 =?us-ascii?Q?oerTpg8jsxdYqEr4JPtHSDMJ156FRofS2A7apk1cqcwCfhCzJvKB5rUm8Ypn?=
 =?us-ascii?Q?NwnOMizvrnGUU2u3tI13nZusAJzxrcGe1YjOoJ920NHK6myGIsU6Kr277YoR?=
 =?us-ascii?Q?6WsroUSFSfw6lHFnnwKSTmhHBci+2kqCcf893Mv54MsA2DCWrd0qwV+jR1Xg?=
 =?us-ascii?Q?EtOXtbsfTfFkSNZ/dPyzKNP1FLegTDQt1o4tJNf46YvOzTiCPf9u8iLzYwsj?=
 =?us-ascii?Q?/lmuWL8clKaf+2/aj4M/jPPkWCqGRQE7ntoPYz43QrcdaEiogz0JhxFLFmGl?=
 =?us-ascii?Q?r3N9WdLtSQt654qrz98DcGTYBixweymWivZ3hFXDMClR4CCWgXslkA1R78p0?=
 =?us-ascii?Q?uEttjGVN+paOKTvdYUMMUbd1uqnWvXoQDArs7qSz9R7GbUawI52H0h1BMKxl?=
 =?us-ascii?Q?qhJDjL1ZE+guEkPZKub5lG/sy2FuxYbvqj5JRUeKjsFvYGP9JR0803HWDWO2?=
 =?us-ascii?Q?JnT3ZMjymxJWWBG0RjzLZm9oh23OUs3eozdCp2Ej34QaFFAMPhW/oleEKqNY?=
 =?us-ascii?Q?I+A5vZJbAJoZTXAXDdgezr0ZYTGhbRmVNDDP7Opv+vMcUFH2x1iw9wOUA+00?=
 =?us-ascii?Q?HG7DfTcpOHEJ4CrdGUtdu/tTBRktbEUJMwXq+0wMaS0V9LjebzLKL2mdrDE0?=
 =?us-ascii?Q?NPyW9jvaamm+xMMvSxbFzeLLeavmNr221NwIbRcz6jV96GfUvIqbZHdNe2Jb?=
 =?us-ascii?Q?IRrUM02ZB+4oDd8IatP+M4FaY/2S6AFpeP0YtDFtkyzf2eb2y/+AXTVLlFcP?=
 =?us-ascii?Q?WYNc9i7sP/ObfoF84SOXgP9de+U/qJSKOTopmbhAJX4+CP8Iv7MACtBOSBwN?=
 =?us-ascii?Q?3xh/JN5z9EKKs9tiTXD3YsnRoQpQykTbcYYo+ucE1uUAasr+RCAzplK5sG50?=
 =?us-ascii?Q?tLaUDiXBV8LegAiYYOi8BoRlYApkzFJSdAS+Tc9PItwd/y9rf+cepjOVRbUf?=
 =?us-ascii?Q?hFy+PRaaehFRSsUjKQtHRgGjcHFKmvM6q1zLa+iJLM2ob5vgzCZnXI5ggZlW?=
 =?us-ascii?Q?QqfUd7PZ+fAeEFJdQZ0PgZPBlU1+piz5r4zoMTR/HkN344roNZGkA1tvNqv5?=
 =?us-ascii?Q?faHJIU6EqDs9ug=3D?=
X-Microsoft-Antispam-Message-Info: qhHtxYDTpqueWgcvOMgwO56240GBgKzVqJBHkl3g1E8lzGAUwYOw6sa/wHI9MNtVhW775MpWCJXHk1jHuBJXMsA6hl43udPdncZhWpuzJ7Y86Bq6bmOXwEywa/gw2RXsXLtNe6IVt3zGGhFotF1josgadozjeCuR0ZyhNQ7d9tzrP4CyKiBk6XULJvSrULfS
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;6:A5fJGc86B1DhIW1Y5oQF6E+KKJ5mV+v5puJm+BsEImsbOCw+/DDxTIixv8i94S7kJlzPktepmlelAy+wFSWYxTKBH5F5KjXa7HtnAvA9fwCXG8Ncmf1E8ZJEMSyL7GWEdxCvUf+DmPcKU9Xn/IK2/CX/b8UbGnTkDzrXVlH+egL+ajSJf+xcczGJR/UQRAGafZpsWbSl7gzDsLX4BIcmIG979nB1fZw/VZxvQ60SHa1JijQiqJmSV2AsVRdUhkGicqg7JpPG4XZpL23cyaFv4PppEd2GzVqyBXcOjvHlKpZvJdZRCsHi4spu/ytGc1X1X5Aps79K3MyLCiERs4i3MLvv/m/IUYdQ4wblJ4DPHpcPMuWLofDxqchXdpqsE1WHubvgZjMfr5YC6ChloIv7sek6mc+4wF/n/eeDeCwZUzySSHeJYe6EA+yk4DmSW+dIvuNx/6arS7z6i7IOgJf4EA==;5:+5lAYxY2WMF2tIb/cFo4mJeYBmqA6qurtjn7IG1dUtnb5DVZ0qROIVTh0Ga09JHbW0C0mQ9KZxXNSto/+6H4oZKkvoxMZAIv00vuoKU5bjaaFIts4GmWy9rtgF800eeAH3qbWMc0iIOjlwSc8ZKRFCnKlDv/N471VARDU0xNM7I=;24:5kZXwazObYXHdheQcAHPhyZLFT8bwRpIqFbJsJeGzfMFhK4PlSlxH5wBPB4OKeNX2im611DRxXFBnemnFka/7jIvWuURwYDjTwPHPSNWteE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;7:ygUZquNx6FJwVaJzSfoDdoY6y5QRUU5sfaiYFmwuXIXiyQCb6p6hVnvdJCJwSGb0knyEpH68sW0AEi/1FtsOI99x/EtPyZ1zLNPayDgIRTeAQ5WytDLaHUq1cYmAYAGXtceZj/ueoaPlMpvcvrLiOtZgtx47m8v3PjRnajxSC3VNAbkQn8S+h4AmXTxUTS42aXBJ1uLXUWuFN/S2VR9MJhV4Ah4NYE2VYIIcdlMHwB/H9BJp4ftov/8AqEa8LwTM;20:dnSiRDZFiA9p+rGEhPSn7NZcvBW0TM1wbtxTXAEUzUcLWsThC8H3JwyhDdHajFdXjmwR/YyMr0VGYaDoA2h1YeWMAwfubVA6rVCQkXjCfLNbKlcZnQS7fT0KzxQE6E6QRDxxIMzXq5o1mLHUVntYcv5cKWaA+yMZnorrD/OxNAEV9fnIke55b0dmMVADoJQcgApwT/e0IOQkgirCCh/oIYOA0n1auFJp6MVjFlbgCbCfOzop9u6y03mmONBa/25H
X-MS-Office365-Filtering-Correlation-Id: 959cd9d0-5c82-4091-554a-08d5a98fcc9a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 03:02:21.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959cd9d0-5c82-4091-554a-08d5a98fcc9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0754
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598594949725044405?=
X-GMAIL-MSGID: =?utf-8?q?1598594949725044405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added dma configuration parameters in audio_substream_data
structure. Moved dma configuration parameters initialization
to dma hw params callback.
Removed separate byte count variables for playback and capture.
Added variables to store ACP register offsets in audio_substream_data
structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 241 ++++++++++++++++++--------------------------
 sound/soc/amd/acp.h         |  35 +++++--
 2 files changed, 126 insertions(+), 150 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2ef..4a4bbdf 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -317,54 +317,21 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config,
+			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 pte_offset, sram_bank;
-	u16 ch1, ch2, destination, dma_dscr_idx;
-
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		switch (asic_type) {
-		case CHIP_STONEY:
-			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
-			break;
-		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
-		}
-		destination = FROM_ACP_I2S_1;
-	}
-
-	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
-		       pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-
+	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
+		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
-	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset, ch1,
-				       sram_bank, dma_dscr_idx, asic_type);
-
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, rtd->pte_offset,
+				       rtd->ch1, rtd->sram_bank,
+				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
-	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, sram_bank,
-				       destination, ch2, dma_dscr_idx,
-				       asic_type);
+	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, rtd->sram_bank,
+				       rtd->destination, rtd->ch2,
+				       rtd->dma_dscr_idx_2, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -700,7 +667,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 static int acp_dma_open(struct snd_pcm_substream *substream)
 {
-	u16 bank;
 	int ret = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -720,6 +686,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_playback;
 		}
+		adata->bytescount = 0;
 	} else {
 		switch (intr_data->asic_type) {
 		case CHIP_STONEY:
@@ -728,6 +695,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_capture;
 		}
+		adata->bytescount = 0;
 	}
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -749,28 +717,6 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 */
 	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
-		/*
-		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 */
-		if (intr_data->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(intr_data->acp_mmio,
-							bank, true);
-		}
-	} else {
-		intr_data->capture_i2ssp_stream = substream;
-		if (intr_data->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(intr_data->acp_mmio,
-							bank, true);
-		}
-	}
-
 	return 0;
 }
 
@@ -779,6 +725,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	uint64_t size;
+	u16 bank;
 	u32 val = 0;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
@@ -804,6 +751,60 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+		}
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+		rtd->destination = TO_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+		rtd->byte_cnt_high_reg_offset =
+		mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+		adata->play_i2ssp_stream = substream;
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
+		 * won't be turned off. The default state for SRAM banks is ON.
+		 * Setting SRAM bank state code skipped for STONEY platform.
+		 */
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 1; bank <= 4; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio,
+							bank, true);
+		}
+	} else {
+		rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+			break;
+		default:
+			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+		}
+		rtd->destination = FROM_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+		rtd->byte_cnt_high_reg_offset =
+		mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+		adata->capture_i2ssp_stream = substream;
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 5; bank <= 8; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio,
+							bank, true);
+		}
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
@@ -837,26 +838,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
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
@@ -872,15 +862,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
+	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount = bytescount - rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -898,21 +883,15 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
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
 
@@ -934,15 +913,13 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd->acp_mmio,
-						substream->stream);
+		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      SYSRAM_TO_ACP_CH_NUM, false);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
+				BIT(rtd->ch1)) {
 				if (!loops--) {
 					dev_err(component->dev,
 						"acp dma start timeout\n");
@@ -950,40 +927,21 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-
-			acp_dma_start(rtd->acp_mmio,
-				      ACP_TO_I2S_DMA_CH_NUM, true);
-
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
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
-		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   SYSRAM_TO_ACP_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_I2S_DMA_CH_NUM);
-			rtd->i2ssp_renderbytescount = 0;
+			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
+			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_SYSRAM_CH_NUM);
-			rtd->i2ssp_capturebytescount = 0;
+			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
@@ -1028,8 +986,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1059,6 +1015,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
+	kfree(rtd);
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b..62695ed 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,17 +10,28 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
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
@@ -85,9 +96,17 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
+	u32 pte_offset;
+	u32 sram_bank;
+	u32 byte_cnt_high_reg_offset;
+	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.7.4
