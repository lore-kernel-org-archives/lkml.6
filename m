Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEAUvT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:51:19 -0400
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:56348
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751084AbeEAUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:51:16 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] ASoC: AMD: Fix clocks in CZ DA7219 machine driver
Date: Wed, 2 May 2018 02:20:02 +0530
Message-ID: <1525207810-1305-8-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(48376002)(336012)(478600001)(81166006)(50466002)(97736004)(54906003)(126002)(26005)(81156014)(11346002)(486006)(476003)(2616005)(8676002)(446003)(426003)(36756003)(76176011)(7696005)(51416003)(106466001)(47776003)(8936002)(50226002)(1671002)(356003)(104016004)(86362001)(6666003)(68736007)(72206003)(53936002)(2906002)(305945005)(316002)(5660300001)(109986005)(4326008)(186003)(39060400002)(77096007)(105586002)(53416004)(16586007)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0324;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT044;1:K1C4z94hHLSxv4ZlqwDwhC04FE/kbzZAlX11Tq8UyNPRdpMrJF/bMnwUERIxpQK2Y39tdpp/BQm4WuEUjkOLmXzPTv/7haTKdW/KUBmIp7PUWXlIVIU/yuQK2kZFq95x
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;3:itVDb+/uKAFYktGGpJIZe7pIBjf8UX6DBSbjyJgnT3Ecsa9kXti+dtfjHPCbF49wCX1GsbqbsG/jCZjwCupAOMRGiSIcIrXYjAFjXabH81InTl7aCMnnlZgTJevviCV1lGQiHpx8yJMmi6D/RSIp74TgOO9hgxMZ5JCbr0Yvx2ujPHG14SBfkBoX7Kaz9pS+XfFkM4BEeJ0Nq/K6s/OcoNb/y3yI75cwa8Xh6toBiBwVGnkLdd2uzH31z2QmHMubAXjWZCb7EG7sapuy11WV0/8yDAhvkHTvXdoZZRRHvmxnuGH2IBW6r2ifotRqS4G5kDiL/0G4ThMseNJtg2QqifHAVUCIbqW9UK2i3r3b3i8=;25:I/MPX8P1lJiFPItgB0m3Gn4lnofveP0TH2WMWONYpdX8qC0WusTeziLirs8Rkv1VbN0hHBw9LueD5eDZM/NTFUiiI1k6kieqPd3eihGb78Bwb0Zj3rtB6xoSTd4As7mq/ShcHofh0fyxgYjXbdvl6JAoa8M9/c5NXUaw5TsjZkVcoPZhcPWKluyZCC5OQRnj6A1wJWDIaHjsRyD8MmntW7dU8pzS7HAhZdtSwq43YK2kSA8UNWVQmmxRf1/mV8n/kynWY9p46dJZNg8MrPcZnPhVZVxL0Vi0ZKBorsRRB+xCRozE7amRNkJkxH6HL85Vjty0Py4fnY4VZXUHxwZ2dA==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0324:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;31:gXq1Yt5uTl5yekeFCM42lP4Fg06g4P1e1nYC3x12u/R64GEdn7Jnep/AE1af6M2bErJY2yf6sjFYhC3j3gOXVqsEF7mJGg0piF3R2jRgIYXndoijW6xcgNz2lumjlokE8vO3PNf90nXlLLSo/q5pxF6552s5Li/wshA/UI5hdOzR915i9rGc1bIXawhc022AzVUwWXsx6tFpww+HgLM21jeiVc61liKVIev/qcuNiO4=;20:dZWXpodKAc/l1PNupkzPTEOUIbXrxcaBhuobwppI+9jyrrJFM1+YQa4UuqynYpJGmiHDnIoUC/hJ0wuDLE2wn2FZ6oT4J+LPCmh0w4plaoy+uJZV+eLDPmepkOe1Y2+JgBvZLuL/29xJ7ao6p3N5GJ67wc+8t3RDcmAVUuw9suL3bdiuOVkZk77QT6HKkzh9Y/f+f28GP6W8+Pk6s5RYyFO2VNgevO8xjWvTC/McJC1Sq5+sV7w8BiXIhIqGl2gn/6YiqB8zLGJ9Al4fT6d1FIboI1mlgkNkIildxe1vNI1oMFSWNM+dgMnVjCMaCMlyTvMwN24nsS3EGcvfz+hm8bZhlA5R5DCzN51UUStmxn6/Hk11F+L56Lxsf9ZQxUAFEQfGXpqJ9STVkHq69BtSGvFSMHGW5FW29JaB4Zw15F7dOU1JTh6PNeYfFUPg45CeHtC0KEdUwtQAh9seAcONCBNfnZjIz47u9hX9d4Sq50pEh1GOrmEqAlD/BJ0hn/SA
X-Microsoft-Antispam-PRVS: <BY2PR12MB0324260C3B3C70327DE56C2C97810@BY2PR12MB0324.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0324;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0324;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;4:dM0Ld4eJkKgqMmiRGljwSeZW6pUDlCdXZ7KfJgKff9JJqdkDirf64iCj5duBBWFSB0LTWRif+WVGOYK5OEcq0vLx+ch65jJlKycBdfVWFmqASRWM3fApeUeVVFjPjemaULuXu1Nm4pOOvfd7k4WnEmgj/HEQA6/d77z+XlVV/ZWjQXRA8dOszbbMhAkN2c7uswV5sP6k3ZL4AQxDIsFvjnHcAHBdG1/RKphF0rSOHaXkSdlyKD0Tx0YUmj1wzT/rhj/EMum3Al/R3qTLUjQRmrGjsMjgS/bDo06Klykj0b2/DeRC8wySj3p/F1V/wO5B
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0324;23:gWOgPc9IBSnSfqQ2ynYD199KTGtJyWOK0vhO/mEoz?=
 =?us-ascii?Q?DZbunQ2w6KYfWYa3hE9oHGVM3h3JLU8PdSntyiZNuZELZNFZXure5nsbseIv?=
 =?us-ascii?Q?jMmDu2aLNFuAaKYDWr99efUzIkxq8oEt4mOGRg/1vb+5+eqc9dhZU1d51wrH?=
 =?us-ascii?Q?FS1pxvlaCeHeHP+O1O2tntrDZjZfehifSf4JxeEXO8VR+6lypm46SCI2LzkR?=
 =?us-ascii?Q?oWDvWx9nCAT8iJ65l5SaQCHq8M4lWlJ3M6oZQqgqOLOtvQLjiLCQhq9KYUGa?=
 =?us-ascii?Q?unMOPX1+SDBTMmF22tLQ2WIopu1nJhWXseFjrpEobhPTu/7HR/3kVVSbn3cl?=
 =?us-ascii?Q?MuU4cqHhl4RwVofj46GVg1hoNrwsHV6ibwMAe1iDEPuGdRoGklxlNRojZSps?=
 =?us-ascii?Q?d8hH3GYFZHcaI4SrcPS0mfv5a5XdHWrTmlx3QwIkr3GXfAb+FjcksbOv4PT2?=
 =?us-ascii?Q?Swf0U2WExfiZ/E/2rpRrp8rCxtNjB1Ps4LBFsk7j/EPgO/N8LnivV/PkVy5/?=
 =?us-ascii?Q?88lF3voD2h3eVuciFNcpqfhRd6JhJdx+E48FdNRIp0QHe3GKFg+kAHF53ihv?=
 =?us-ascii?Q?byev7EkF5BkDJulNyZgtStTceTFNXjknhjLnY4bI67O/xJYN35F76V/sThRs?=
 =?us-ascii?Q?u4K/MnVlT2Zkt0BLd1aCdlcwWbmlNLHsbE5A8ZrrSEAG0BpMjCunBCnJgli5?=
 =?us-ascii?Q?roSjj5qakJjaSZpcK6YlSmE5Ov/B/03wSKkbvP7g+PRY2TFiNkRkwCvtcBSR?=
 =?us-ascii?Q?GqavegEuBXTitF+bjdKtV2vbfGeh+NjuVQ3UJgCyTKNKqdV7qcVquzQ42zPd?=
 =?us-ascii?Q?tQad8vHtkwHKgq0BvijxGUIeyrxMTdFfys7YRoAc9Q0jNWstFTbbvOPMhSfu?=
 =?us-ascii?Q?E/ZzIrs4FiNdoSCe4Bdd9lUlnp7YPDsueZVR/sEfUYg603AyeoG+bGvNtZ63?=
 =?us-ascii?Q?fn6SrfJ2J84Iug/2F5b6Yd+jlTIu34MTR9kJ+N66JOuGk7kijQoGG6/jwFeY?=
 =?us-ascii?Q?SauIWFlMVf5+V5LhZ2oKBrkjtRY/JSWpcemDVP/ezID4nAEcnjbmfnDwSCqv?=
 =?us-ascii?Q?I9c/M9BZ/5T6PAupQGGtIGNsEpGjn51FMMD/B6IMu/EJzhfhrnouM25Usiwx?=
 =?us-ascii?Q?YId709sXTROnrrz9qSbxM2OWxkZdeMhsuikDW+9DF/RppGmoktvqBFUolxVp?=
 =?us-ascii?Q?0ZAAuG5YzBJIdbZWlrb1dF9x5tSkjrkjP7/qqFAXM5xIANcc2JnqGiC5g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: aW6crm6SJxpqAYIbk8XxxXIH3a0Q8GDEuCcNsBGsLaJcMY9MntFSW8ouEcWKSP3NAntiTgzVctWslJK7zqJcFm5axe8SJARZ280Nn9GVU1bXdo1z5lKiPJcEkU9qdiHhR9uzkop+V5yH24+GpTLPPNfYfh2Y7CFzP7vL9O/grRjdXMOIvLtvJIxz/3i6rvfI
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;6:zSQlC8NEMnIUFPpgrybF5fmyVqLtUpeuOdw2ORaJI2n6zYUaLsg4hFMp30M6JXnnTC8JCJyzr1ItilqSiO0c8vyrCobuzTgy2WeMzygSvS/x0Hfgj7dkZOJPe7Tnl0ZE97k9K7snySw1cp26E531mwAYcaq5KdfBV7Nrj8mOLFssIH0lrXFY2CyhTbfZ04ULSsbXjdrhmaR/XQ7JhdCOdaMIUvvrYTGXsvFO492VHb91M0k52RsAw66ypg+4FnwoOfj8cKhslDAvdNh94hyZIls5jiL0DsulWee5HAnP/QVqQ6sNKrwMbXj3zVI0lB1lFAGHVopMaAap/mjVLPdYFrxNJlTYhXcYQhaE37ldNznoTdmXhJlul/CjJQysjv1fMiY/YLtfK1/WxtDVKRLfEATUHGS4UDNGRWVPOEdJs+Q4oKrRqlzP9s4mhG0keE+nnnDBPe591ri2ONppbwAlvg==;5:HrLOktx3avyKxqR9xtqe4Q1eNJVtsNjNVZG0Ve1aGh+OG+msCxvfJthLmo3Jvu7SQD2aLsIbi2qtNGK/YHL/3gjU6biqN0X8mqSUl0XBVWSl3hRNJzU1ggxAfwEzk1jTspaY5uXXDc7GrbuyKfqfYM9puvdhuVAF6L2nHzcPXW4=;24:6cOmWkFxkGA+OdMDv+1rD62QkyKocq4yI7wyDpp7YOtvuQ/4muHwhiL5ms8o60YlynG1UyJirPT5EjrnHz6YPm6DViuX0oxhsBG6Kzqdh/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0324;7:SMg9b6/wgUt5+UAT/IYEjNBZ9MPCb6Cplbq1WLX6ggTa/Ekni8reOyRPatMoA1flfeiSW3tlUWzODrvkRzLD3Skt7iUP3wQSaVnG1RpbTVDF6NfobsAtYRrOZEtYWG7WvsU8cU9aIUHbBBTRVFMuVx3BRvSIk2KonaCXP5Jr7bgjVxyfLZDYCNDQWKrDollJmlQp9N4toY651QDcfwRMw5gsOpB5gohW2OmEgTfRLQ5LFRTLRs3dOUFIQ4lwVfeS;20:6KpixdllvBWAvu8p2za/8iWAzs0UZ5Qm4yFb8td44qABwaYhInamTxh1yJ8ESMysj6K3KONLkdznMjxmOlD53p+C71f5It+4se0bnnzKQEal5huCwaG+1I0awG7T7kHIjSnVjr+rbWcc5vr8HhKG6VOfS7w1FQHNNN7XYRpZ/oSCd4VS+bnDLUAomRaGxG2xxeId/stlNcm5mtBNxxg9ArtagH7ReO1UDMsUo5U2LZtCPn/Qkj2uqjfshDiQCEt5
X-MS-Office365-Filtering-Correlation-Id: 92c5f80f-0cb8-44c4-b376-08d5afa546bd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:51:12.8938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c5f80f-0cb8-44c4-b376-08d5afa546bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0324
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

System clock on the platform is 25Mhz and not 24Mhz.

PLL_OUT for da7219 codec to use DA7219_PLL_FREQ_OUT_98304
as it is for 48KHz SR.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 6495eed..fa5ad5b 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -39,8 +39,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
@@ -63,7 +62,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
-- 
2.7.4
