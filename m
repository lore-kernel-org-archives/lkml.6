Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx49wVAOLBAfynguFJh8brK9j0K22qUM1NzsxkigK0qdFcAhRg0Y17dgxkLrXmUbiQJzUd4Ov
ARC-Seal: i=1; a=rsa-sha256; t=1524741291; cv=none;
        d=google.com; s=arc-20160816;
        b=MP1Z6/V93euG9bkMtYkd1FQIsOleWcRAMe+7Zi9xBRPamPZ+vXZYlornRTkBCKNTFQ
         4Zf0Gp0wl4ZqlKjBE392MWKkz4NYMkBgyi6p8MXSac1HQwjfBzIfPkwCEglwuwXDsYxU
         rspDlz2XBk7s9bWUAeqg0DGBtkFTSgNOBKGH6FuJv/iYUIkF/fflzfXnOX1FPcVcfkIF
         8hr+mkK+Q6ySz2tP6p32YX2PNEWlE1eZF1zCMAOvQ3+sJo1ebcxaEZolgRmuoEiPS0Xa
         0PCc/daZtv45JDAOqtyuzZ0iSJuAV5wf5ug0WErG9Hg5k0hJjW2aXPp1G78c3/L6lDXe
         EF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ChMhOnaSH74EjmfRUv750rweC3/Ahz8IOkWaNdcRA0w=;
        b=fxwFL6AViKybFL7JgZyOxapUzZoeRAMsK2Egac2b/o+oUuPi+bveoFes8rnhIUoA9c
         6Y/JwHjkE/7zDe4Y7b6MPhL3hn47GWHA4XC7PjrNJHT9dV8vOYT0yfB/PXYSVpBH3hF9
         v47NDb9zKhG90J1UARW/RqH9i++Oo8fLIJzThoNxpBA3iIek3V1kP1jGb/MuiAPQ202p
         aDYEGtB6e3SyBPwTAw5EBjo0RnTwuAZinfXgqSdbvhc4VHc4UhT3SFQcpjP9nQpF3fkq
         E+j5uVPY9csq3VLfnwxQlfBPs6fDAWFDjLvTbQzjkEVeEO0cdz7gtrPhUKP8+NhI6odc
         53UA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Hxe8+mE4;
       spf=neutral (google.com: 104.47.37.79 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Hxe8+mE4;
       spf=neutral (google.com: 104.47.37.79 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "Kate
 Stewart" <kstewart@linuxfoundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] ASoC: amd: added byte count register offset variables to rtd
Date: Thu, 26 Apr 2018 16:45:49 +0530
Message-ID: <1524741374-13523-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(2980300002)(428003)(189003)(199004)(8936002)(54906003)(53416004)(53936002)(97736004)(76176011)(105586002)(86362001)(2616005)(446003)(126002)(11346002)(1671002)(68736007)(7416002)(106466001)(39060400002)(36756003)(109986005)(476003)(50226002)(426003)(48376002)(50466002)(5660300001)(186003)(305945005)(72206003)(77096007)(16586007)(478600001)(81166006)(336012)(2906002)(4326008)(51416003)(47776003)(104016004)(81156014)(486006)(7696005)(26005)(316002)(8676002)(356003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0324;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT033;1:7kEt+Avu1QRK3GwJ+1moktUWKB7slKjai7y4nYMXMddE2dxZIxfqvJ4uKsje0wn37wbdFD+SfgBM346sx3xajIoaLGwj4A9MY1aDuWPLuQ/Y0gfR800cmiakJAbLVR/c
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;3:4fPeor/TzZAIpBxAwjjMvSBFIcBoKKbkk7KvKQ4eSBKuJssXxIZfIFIR3SVgKh80HXezwK42jOS5QlZg6KI88SeIXlNA5C2sFcMu8z5XLPpsnOLbsZJu+2QyVQGTxJOLR5PxgDkseGLVmDpZgo6i6KBAvZQ2b1TiIs1sqJiH7i39VF0Zqjd3zkJ5hZL6RF4zcfvXYkCA/I8vivmfXpqYZc3AmZzHSMEqkx057/jGg3beiP3+5wMrElHBcCnTQ8wTZy+olOblTCiO4TUxYbAfIBxi9QOh9EOlr8ujKGdoa3YPOmn5LSscj39w8lH4zbyNjADZjd9RCXeVUB4uZ1PWRHQ/mbmib8qWY1Qoq0LfwbI=;25:juDmwbuUSt7w9efeMMOt0II6o8T5e1uEXosvKNIPp44jPufIzvLf8CN4Efal5dzjtOx9My6pY6YgEVOW4AqEwz3ITi7lgIP3YWRk3OniwUfpZbuyqpSlHQWiQn7C4CDXTvdvWYWtIXt7Zlx2aoa+v7w/Vn+Lbd8BysTvG4st2E9ww2iFTbgnuDLqOYAumOkkpETX6x5wumWp6v652XySpIKM9h/hVxlIqRirgS01sF9oejQ3f/FOZg8wpyrmWIvxvwMPDkgYFl/ByjfH5TdOy7DCy+xgis+ofEr/Wq0R7A8h1mlA1PvHjrJm3V2DgVSDQ1X3HKKMYMwozS+JU7zKwLhp+38uPYPP2JgEwHhXDYM=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0324:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;31:qIK0BnIhF3HUGuuXbkSaV25iihZI7Splxd1QgWayqVnJOj8g33XXXF0uVaVYJ68zwcJ9waHO/5FGtCHTgTbIiv0XrTi5cc8GyJgSsktIigy2C/TDF37QjYSD4Fr6uEC58ykfMKUQkAECdhQO1kXajUpy2CJRTKwRFR0DJTRgnVTZSXffOGEpurv/M08TfpUEX3AgJ+rwveStNxoWzrOiynIWlkyYfgkM6VU23h8X6w8=;20:8iBDmguOLhrJR/VvaVUd7I2rAQ67ykKppS/lysmhZvXNRG5G1mlYZ86eQnV7u7xcBR+VE2caYajeWVoeSwWhddMF3cR5C7m02kRVL+q156RhnM4kJ09B1Y3SweTxbp0FiAOEeM0cNJAQ6t56dU3s1pPPI2obG5ikYiDo4zbYK54Qogg2nIxOPK+DCysU31y6r0asQOXqWhFglKKO16mrsaIC0C0KjjvkeiQ76X2bFwbWtpVgVdbJW0/Tfl1EdDfsyJizn5VXDEl0UsDB5UO7Q0Gy3mbrT5QIOaTxpuaPX4Kej6pTvcXBvmYdwf47v7+k2tvHvSBldn+Z9hClWt1XbVasy/n8aSFXuHKiF01VC3aqS111tOWABmm699dAc6C0tK+EYtqbW9xrtykFQi0R2BsimF60Bjpsmwxoo0nMFjXwoMySeV4kPni02y3SpQ4pvqI8WYvcHcdD49qF3lx06TGagyTD8QJKyl8oGbRkPKK5mOIb0IawmKiZZJW+EXIw
X-Microsoft-Antispam-PRVS: <BY2PR12MB0324803CC99CB8DE9EA749AF978E0@BY2PR12MB0324.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0324;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;4:EvL/1fwI3j2WTOJJJ2njRSoqNumqEkwSv6Et5ICgU2hCD20AzvHe0HqxH87xf6hQ6qsvynGr/VrC+4t3Pc4KZCTGosEPrVR9b6Wfc1vDdH4G/fW07zQPMscv2K2MN+x2M2bwtq/RqWs3qADUdAtb0eLGCFws5EIe+lw6eDXYcHxDZMcNigtfWcRpIA5s8I9YishJSPvSViv6m0Ik/9W7fLzEgtkZTCscL6FYGkmLoUvrnWG0HbTvNkhgFpKOzpmfIAStUH4CTYGClMvYSv3rufZURJBaTYmFgdVpL7nE1MiEAhLBTtwZyZihpm93pgmM
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0324;23:wfpy98tUax67I5Fyl3YXqArqzY1DLOAk1pjAYRMXj?=
 =?us-ascii?Q?+0bPlNCEiKPxO/e10ko0tlyVWaWI/mLofK0yMYN822cc2UucHeD9w3cFz8rM?=
 =?us-ascii?Q?sHBgnJ8Nl7YRd2ceZQoRn/BQLfrrxCy7qu8SwlYiJHCGfafc7xTpnzXLKudq?=
 =?us-ascii?Q?r5JPBNPBLJcO+m7gytChjueWd+grIbtMNFHFznEmAgFINxB7r0gbA9DuVmmT?=
 =?us-ascii?Q?I+xCRJrARxJIT7xR6xnXYeo2B0MuhojP5JPndz6zOmOgaR6wjY6tMzgrwbAx?=
 =?us-ascii?Q?J7Lr0+rO5H6gfPmuwvQYLKe1x/8UkzB21pS/GFJczw0DZBkpmlVWYEqj0tdr?=
 =?us-ascii?Q?+xgdn3vk6M9Ls+M3xIywkPj3ITuSMSXeYkkw9VuFtke2CFP3ASbzSD0PwMwg?=
 =?us-ascii?Q?4vLJOdN59OfGTt0uWctY5XdRtXe9SbXeEDojZzj4h7op+Os230lky5qbOiI3?=
 =?us-ascii?Q?WSAcccxXVoUbzfSQjI6zdhye5NdTExFISdf75YS9a+JMYUE4fScvAj2Ib+bB?=
 =?us-ascii?Q?zAXH0JWzCWMM1x7KNiRX1vIPzSzUgXh43YnGirSxcfkIeBB5FEEP/EM7eoha?=
 =?us-ascii?Q?ppSOU6a0Rtg8M/DnVsKgoqU+123h6PC5s+XQ6CQP4JVcDsHMGCjHjekwVqLm?=
 =?us-ascii?Q?/Ctn99QvQN8DIJls2hctyuq87wPRSxYaOp02t3YrTaI4apg+r+QtOzeUhdcR?=
 =?us-ascii?Q?GYETkcdNy1guBHKvN85Hr9HFVzxtqyilwZ5ZAH6Id+ygP4FASEbp1xISA0gC?=
 =?us-ascii?Q?G8rinQBIXcSjtTZy9x0ilDfnUEKKRO8HHdavHPMhA3I7BMFeGNWNuyZcxZ/Y?=
 =?us-ascii?Q?3I79I70wB+ssil/wh5McyXhsOu03yXdauskShi7TSOF9Z8Ey7V6WbvzvJGXR?=
 =?us-ascii?Q?asiI8sOuaM+oPtDL0rc1amAFr95wlqWiHewMry8O1j3unMHldqvF/UG/yhA7?=
 =?us-ascii?Q?Yc8kJ/aAjHcZ6mo7WOLUBqr6dhKdg8kYBC0cneUcDwjmykVadVSMlOdydomG?=
 =?us-ascii?Q?roTidAm516o4a0mKzs7NRgf9G2RowutNh0xGp4KqfkTR2Xd27d8NnEpDpCxu?=
 =?us-ascii?Q?n03tglE9gWaKjdk8a/VnrKR+RxWzZXo3nTOtyomreSHUyUdKiRcghGoKYTct?=
 =?us-ascii?Q?oYq1S4wPuL57c1lK0VPswrXBa7V4w+5RgfcsdCl8UgKYLo2wpBn6IZp951hM?=
 =?us-ascii?Q?3vhNl3fHJqkDTOYurlJwW5+3XWfGxMSC4sVyRAoYlfDJpRYAiYYiQ+VBA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: IhZyEz/A3XIDOUs0jakqkpCTRUPIozhEyvKvciDZ8VXnki8nK3XvtjQ5bE/SRk26AIBYyofK66PPXFxMKBIWDEdMSZR1rnobSWbc1S/U22tabeddJ2mKfjA2/sNh9BIV6RjHmrko0jalx2mB1tirhsd1uEKs1+z7e09XzqtGdKIxLw41gg+s1fKUDjztjCUW
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;6:fA/z9ymS8aLRYOIZZmkGbPX0N8g0Jye/7xLrlynl7/OaqyZX3JPCSFV7AxdaTuZdfsZd+6rUXhkH0J6IyuaEdv4/kZALIYWCGI5aVW1TkNq5WZCIasOEAYPIHvQigCxg28UZWVYFG3NYMPYm+SfkIfs0qrS4E/rDbCXov/4GH6z/3Tk6kJlXBrlNlapFIQBWjCmK4rqHUyiiCS3hX7i1dJPs7ZLSsQIv2AUoIT3Sy/zkiojVSgKV2MSGXkraF0r0b/MA/vmCO4ivz7Mt+ZTHx7h9Vkn28TsVS+ocLmwEML3VUkyRMagvjIGic6RrhGj1zLuH48EE7W5/7FyQP6rBEq+2VELYFyr/mHeWYjQH2TtXjNipef0i+6pnt//hiM9kGj+kbQ5KAfJAz5kpddmLDcEfKsaK8vt2aSIqT2VjrltZhocJpfyMckf+0hToELMR5XJIO7vaOIGO07i+un7VKA==;5:bG5KJmws7gn/ezDClx2fl0NhnDp8eKHnJCANCqOGmcu1DtbJ02o/8ajRnQVsvCV18IeWUIvVb29DDLMHnQJirCA/Pztpa5uiUD/iMOrfK5+BeRhTtXCx2AMTxdq3/r7tf3wE3WlWpr13JCG4QLJHY1NKSYBUSYws/wNTJETNtwk=;24:bygswRWZFBKcZB1xCBN0xFTeZRlXcP7DFV8sHBUnbuyklP9kDL5Ae/DHGP4sCySmkbVyL6HYaiuKUbpCoGH1+KKLKK8/ytBY/1mjDXK9pr4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;7:fgRc4736xgo9J3UpeZHuv9xGCzwcg5wfdCvbfhhDoDygA6TOVFuxbtrxgG8q2hGZd/HCGOfNBKawrmGxzOWvgJfbmJlcXh1miKRDyfCuPMRNv2gDF29NJZ3ga1HNhMEemV3XvW1JO68Pbs2vCO5daueAE/kIvhqCxK1xb8p0i+TJ2gOB2iLt/R5k0g7s/H1RaXdXoQPixc0BGrusoCzO/Vcyw2Doi8/NYhKWXKnZOliWtP21ajeNUluoeJIJuj7w;20:MSZjrFL/KJlJnzLXDpmpMQ5HL+pd+bmUzdEcIZIIizDvQUlxEoxriqZUI1HLJrfDthsZOfRhCQZldM7TKcSHtrEZeF9FzTPf8/8UcDNXksprGwT1iOh0b8jdj8A0tyq6zMSA2nJIamyH0cRuOwicAZVEIDWX4e6rSSSxs0E78d0qiqJMPllbd0/vqDdqW1e1DUpSfmwDl8iMjbTE8nV0zp6Aa//RlNtvDhtaQ1m8DcHT9ofATXBY6wi5ERqatYjk
X-MS-Office365-Filtering-Correlation-Id: 538871ff-75ac-4fe6-f4e6-08d5ab66ebd5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:14:47.0568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538871ff-75ac-4fe6-f4e6-08d5ab66ebd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0324
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807124963001399?=
X-GMAIL-MSGID: =?utf-8?q?1598807124963001399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added byte count register offset variables to audio_substream_data
structure. Modified dma pointer callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index f18ed9a..019f696 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+		rtd->byte_cnt_high_reg_offset =
+		mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+		rtd->byte_cnt_high_reg_offset =
+		mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
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
