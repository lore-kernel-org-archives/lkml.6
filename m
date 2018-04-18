Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx49Do4VwSn6Eiy3B7+wyLEp2P++m6VtUPDqNpLht6kU5M8iXb4+pMN95i/PzkLoP9MPGTP5R
ARC-Seal: i=1; a=rsa-sha256; t=1524049376; cv=none;
        d=google.com; s=arc-20160816;
        b=qbHqLvmO+/0A5kgRmCKKQbiGVLqRqdifmC4bMlw+ZBEkL3A1tPXHPvhTGPVLDuLip3
         x9DagvwRNRbfGexb+SmMG1xQ36ebHnkUQrZhJ5u/aOhnYQSTA5R3xePwtC/A2sCi4QbW
         uSqUAu7OkjZdzdX+3dOr2/MU4mMkGYA2upwS9ec4ixaT06nDpge8HUzThvGyk/GBmhVW
         V3JtmByYL7+vKWGnw9I4SdKyIMUBZ3oCoY154fq2pni69bVWmvi/1LmWwZZSCEWb1zSf
         GLFqGjy+YP14ia2m/pw9NvD9DpCaJ8V3UpYqOaW9zd44fTalP9SfQyoJjXuGecq6kghp
         Ax7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=C0PZxp1bUD6i7UvtOO2jfW8MvCMbEhyx8/whBvYYiJ4=;
        b=oEg/XCfkVG+jzihbdaUMAjx1sbm0cKB6FRo8rse9Xnko/n28/zRzjd4aa38eH1NCyv
         ejKL/VepFyYGAuyLHTcHDjxyYJL4Fht1GnO9IFcYTePiPwofKn8VILXsii8SSOWDPPN0
         EGEgmgopoWVHZ9dQxkHguZK2T9iEE3ArGRTJQBDOFEAkR8M0GAoggpjobrfTZtcyFbd6
         +32uizuA9m2RK5fTsHdvrFJx7G7SkXJVRsDzKxCF+I+9ermqxWBrFQuq2pn87ulrfEvS
         wFYWrKxlDqIxq4D2AnlOQSzoJ7XeK/oPmMjLlT4klR85NSqyp/kThnV1p573DogMrvb2
         0z8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=dq9/+ic3;
       spf=neutral (google.com: 104.47.36.50 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=dq9/+ic3;
       spf=neutral (google.com: 104.47.36.50 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Daniel
 Kurtz" <djkurtz@chromium.org>, Jason Clinton <jclinton@chromium.org>, Guenter
 Roeck <linux@roeck-us.net>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] ASoC: amd: dma driver changes for BT I2S instance
Date: Wed, 18 Apr 2018 16:34:53 +0530
Message-ID: <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(2980300002)(428003)(199004)(189003)(9170700003)(336012)(126002)(97736004)(8936002)(81166006)(50226002)(8676002)(446003)(105586002)(426003)(11346002)(47776003)(2616005)(53416004)(486006)(53936002)(476003)(59450400001)(4326008)(50466002)(106466001)(48376002)(5660300001)(109986005)(51416003)(7696005)(104016004)(316002)(39060400002)(1671002)(76176011)(16586007)(54906003)(356003)(86362001)(36756003)(2906002)(26005)(478600001)(77096007)(575784001)(186003)(7416002)(305945005)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0759;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT039;1:ZRAv64jJYlVWmyQ/iFru/xX4IUpt5ihbb/PfgNofdbHI/LQOHom0LvU6TVAYgnNZlRFgwYdqvbEJflXiCXcM+rfe0/zArJQjLWPc6VueVUbHmINlwzyTTvg5FX7HaaU+
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;3:anM0r3YEAVMuY4Re5fmIh2HtYeQZVRSBrKrI/XD9mOljiIk1lx0I0kNag0iWOHsSkoSmi8uZ6h/L26bpNQR3JLf7KJ8R7ajaG+0MjZj5M2v9pr4jP3+8w0LOcKgeMmB0DzJEYDAVjpimNRTWTKFzCcSYpew9furOmUWJw3EpaFcMUYvXmiNxvmvUsu35YM1nMRqJ0pJrQj2Jv9hyCqaeeaYBSv4VM1KkM476SQD3rCXGmAQiKpE6NghSaWPVGObJCe6UmJmIFUw6L7MQTpyRi8ulBYcmJjIBTF0MGLlBtj+7dMt0I78a/mzFyvlJih+z/Uotk918lGbhi8IEU8HHeHGl6vX+t0DRVRFnl71SVhU=;25:SKLLPS1+Dw+fgYvm/Hb03arCrldmZpv1lyUaeAkLzYXdMgq2fNo8j3xKqKSDzouno7qaDP856P383vw8wRAUmD+iwKc3oI+mb0esFAnhu0C4wrEbVPlMrdh4GG3t0jxXOFlSZMdKGI1L2Gs+n7IDy+24NNcRiVJuBvJ7VFdH10ok/6W8Qd3EBDSu1nL4CGrCyXBeMD/cgJWBIYKvyTz/HNFz8FjmgZnVhldt2GYOfylbZyZU9vAnTNNmr7wHBBLiRXoz+5MHVkEWWAxiq8PKNluL+Ia0q46G4ipfEVmORsWpimHZCmc0c+ZMQF+NAU8Nqmm3e62C3cXHSXKhQw1HFhHcufdixRq6dClahxMIygE=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0759:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;31:9/qDe3yQx6RsFcT0A6USluxKaxZKLgXSuQ4tJkyGFvxoRbEyoNicIiwnwlN9wYdygIDh/M41hGb3BeTlD0Kgpy02gRWuQSbBfRrzL+mpHgSU1bF1BjLbxuqb3lENdcbpheuxQKb9BEujWM/yMpbVPFl2wJDvtgmEkn6BnKQo68+AnodqeUVRuKrFqRzMD7CqoEtgpOd6F6KLUkNmoIcLa3YocuOVY2iH9BToZUkyS8I=;20:8SZpxRXr+kwDkvI5lu7G+CFM46iscACK1q/k7JgUhhsrq/im8RxqiC5Hvl1f6XrN3Jm/tQngivHdYlohA42mvOQRS9rcUQ/xkZ9rn8GVTqvsp1JMhhi3rz+uJ3eT4+EPSJc3OT741rBJhYxsGalML4PW9QV4RL7pnUVWVKjqQJFPkjJ+6OhzQwu1PfxSGRazxNbDVSUz1f/WPOBvSei7Zj/TJsQ9zgmyW+AzyX6uiPn8CZHPZUt5NP3XdW5/hmRu7ahFHEjavLMIcw6ikgHbaKwSmoHZO0N1SbK5MYa1+ihXd5pd2rmK8Rp1GU14uWMKJIM4js9b0J0E7XeUH5iJZVe668YhcbFtzDxGzbsZlVwQ5B2NixQdxTDNSg0vvjw1lAQVS6b+9CsQ4122QPQIWYDn2lMO0ipNvUcmaPkTuBREefiwJwgDYDEnDS6rBL3dR7m/bVIxiGBXNptxr9cTvOkOIlqDx4gB6iXbC3rhd6tLVbWad5I6Ip7rdXaUdlpO
X-Microsoft-Antispam-PRVS: <CY1PR12MB07594437F8104AC1CAA526AD97B60@CY1PR12MB0759.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501368)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;4:RpGEXwh/QjQbkb0PH4jz04teub5lYG8zqjU2Pv386yPR314tgjecm4p9HRNjyz8XpqaL4jJnfeXn3pLoKeoxOxDz/iS/FTAMt2Sx+ZAsGW71pWE2eRhzKduBcP40ezLvAo7eneaLLBNAXO/ATz07If2MFCaaUxAf0rDizqZ0O50oiHEa9yQ3vwEnSHDlqDkZTydww4p1Oct7WHvEQP1MaD6G+m8hijSVHSWjzSYHa/THmRaFOAX37SPMNS7NfcJkcO7xdhMNVWfMc+uR0pHByBJPWC4vXZhZdGRjrRkBTDN+ae+dDN6HzG2+OHrQko3g
X-Forefront-PRVS: 06469BCC91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0759;23:aro0vG/b90sDSJxipGehKy63fSyWtUdkO5E5Y4Mze?=
 =?us-ascii?Q?ASi/st9zPJN3oOTdbFwYS/3Gdbbt3TuySF3JVclAvlIRhElVVgiFAR6LnPnv?=
 =?us-ascii?Q?InjHFd4BHHJgDv52UXDCgMRbYQGP1bZGBXIailQFaTMOt11vnLg7PKBZcDWk?=
 =?us-ascii?Q?Z3GopIUwsWDdcnw0y5bCBT5BtbN9B3k5+K14ql2dE1cgxgyW0gZ5pHTir/7X?=
 =?us-ascii?Q?XyAsVJkAFi8ZZch2o7miXNDI+GkvlzDjvq21ew9rlfVAL7HSKTGvPg/uOhvn?=
 =?us-ascii?Q?hLHu0qOGTZkImcQjn4aGK62PFkv4Hj01ErnZcP+B11N6R7LBlt0tniz8rp+5?=
 =?us-ascii?Q?CzrtXc/KY4x8RSRqUh1KZzEWKWBateTYNRpzl3CufLkoeh/u/HQiCFWqiCvr?=
 =?us-ascii?Q?NFT8HjNt/mhG5BIUGKqLmwJ1IL5H1GtHt0hZB9Z2PBzFNd/C9f8c9arKBIAL?=
 =?us-ascii?Q?hwMqcw0IpKNkAQHSKddLMyrscxt2iSeI2V+/nhM0uN6nC3IvNrZNp8YZRWPX?=
 =?us-ascii?Q?5TD6n0+BuT4fChICYX6kYm7BE+8Kjr8hQeg5N7O1YPSs63RkyedxaWorVHnp?=
 =?us-ascii?Q?urbyErvrxN5TEaCG7y9qMZePrumX0RvTUHXpBZZTcZqkxU1X3lKlkhUVASzO?=
 =?us-ascii?Q?ioCE+t//GNs8QehoHmExRoiWjuJ59iRTyHogv/aK67W7MqHrULrQHMm2u/dX?=
 =?us-ascii?Q?ZD0zZU/1vYu2YXCSmy5vvxScn/JtvZPjX5Va2o8h1lKdJT4Fg+CQ76CZZOlP?=
 =?us-ascii?Q?BngabwbVDIOAB7rmXMlat8rdd/5e1ZQHKZjSzCgUM6ngLj654L27vobmuWxD?=
 =?us-ascii?Q?Pg2dVz8GAxvFHDO5h6tHT2d/hKolPWaW4nP1H1ocDmM+8VmEH1sMRFCXuWkq?=
 =?us-ascii?Q?Ub28m3QwLxucNZbpqnx7UNeGTazfUdUaRho5SlYa6T17AN7vFm9S5u1E+NFk?=
 =?us-ascii?Q?b8jzXGAyU6fuJCdzVKLHUNcQuk2rONYTiuR5rRqjl1IJCghGANbBTuLETt6z?=
 =?us-ascii?Q?ioAjl0zs+0j9v8E6K13/vetZQOUEQBAsEEXZfyZ/dGIrLuuJJuQw7T/OTOmO?=
 =?us-ascii?Q?LRfcWYn954scqqoEqk5QYcVcnfskZxaLSlr0DTNmxT+XjnGr6i1nO1YjyJft?=
 =?us-ascii?Q?GLZPfVC0rXAnXzzOTgGsa9nCXBJ1gUVDVVPGoXXa5TO5K6OPVYhZIlQakqL8?=
 =?us-ascii?Q?Ymv9tS1sGU5nniZJvwCL0cneK8hUYkfeMflo2bc+R23TFYVkGnur8nShW/5a?=
 =?us-ascii?Q?Apa+YarWplJkUoRn0VqroMq73aDt7xt51y/LCtw?=
X-Microsoft-Antispam-Message-Info: j5fF2fmk+I3SyVDs0d/pG7tiL6lufIFS3JsxQqcO2/5nf219mGQY0Py2DHWFi8ob127PfX9xVHsTfvmxag4Uoew9Ij0T6JZwuxK4AKSYbzCs3Z3hH+KefpzhtaC3m01bFORAo/6KRy9YKoxzx/qWurFDm3wZ9PRGoGAZ4EHwCcwzB+f/d3P1iY7YPMCZ7Ex9
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;6:hZNsbwzgvmZlKkC3u2EKyeKrCDCmSABEOvnoawnWlAblr+rXGSq9mpAu1LbWVlzu9o4ulfmOdl/T1YkwxsKIJhYb3wLhyCn5LoGU4POSynRcMPIiFJo4vkmfVzgjKogZjrb91qIQb7dOXRxPeZXV377zsgJlatAUuRo1shT1gXhNHn0YvDlRKDLtrfn5PgoAvqKuEge8dd/GYkv3BcSS96fWzlGr12SQejKfQeTauhnv7hu0I7ixRjEjRQsJPIQvP+YkpWLqtNrmJ3IhxD5szaV8Z7q1+/XAfA1AFaTgDV2YNFLpBkVj10eRqXQwCQtp+SpddwmSeT7JC+A0sevJFNv+WZdEQihf0F4eAq/qW/yWbOv82uyKkyhUUciMldjuvUlVYBiSga8x7JjN96mPmS44K5ieOyEcB3yeFiBTbqaqNDL0yX7CN6lowr+dYk6vSS8e1c9/7DJdaS1bmdTc3g==;5:axyrt0Jn3v+hgXeM8odLqo+nm4ml+4WlYYSftZjXekxKsiLFqHcfSskFjD3baEnGc+qjpk0saM1osZosUhtzop0qd6IbfkEql12uKJ0d7uOQa/lHsXhiJ/2lHPZsImOl3BAOYPwig+uR+77CYuor4V99OhQR3va8cY2EtAfpdT4=;24:4lCFLnh98MpNO5gwMW8ZV/euXSwJrpM8zspo+MpeXvCk5XsgaloSi9re4BoZbdyalGPYx4Pl93upgaLdUtZoa+nRg9EmD5SZf4wqDAF6i8E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;7:IAuI5xqAPg9ag28db0CEy01k5rvPGnzkWZJQ/KlKhihDnsOLdnnwWxdDpVG10mGq89DLRSoz8OM7Q7JrqtrNtCZOZnDKn8+Eyr57040CiBhk9N5UhXJNwpgt6zhazkg/FV+hf19tlZYfMz0BAumFk2VWRu1i7OaXg1uLvZwzWM8Iya0KBWUGTIOAQfGzq1d53Mp9o3bAMDOXfA9bPNK2IRf5A0i4NzbQD+unx5Lrx2ekuxvYNLEGWpYk2mq2uZ/c;20:up2Y2K8KaRZzyt23ZLQsk4fIZpLRMIiqDHyQ1yLyrDte1ojXQoOzbzKZgNQAINti0xKha8W19PeNAYF5uOTGbKoeVyp8ISgAHZceFd9vkLjzuBu03SCq9X118HJn4eCoM+dpfBehILz+O8CxFrtcQdZIcVrXpZXNpJp5Mm3QkNHD39x7OwjD+Adm7LekxhGvFokw8U4VTKUPMj8vrcJAcJTOiMXb4YjoRitRiWuLHmBhZnKLPsqaaVIk4IV9O/Gp
X-MS-Office365-Filtering-Correlation-Id: ec606aa4-b53e-40d3-433e-08d5a51bee81
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 11:02:52.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec606aa4-b53e-40d3-433e-08d5a51bee81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0759
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598081599449157832?=
X-GMAIL-MSGID: =?utf-8?q?1598081599449157832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2: defined i2s instance macros in acp header file
 sound/soc/amd/Kconfig       |   1 +
 sound/soc/amd/acp-pcm-dma.c | 388 +++++++++++++++++++++++++++-----------------
 sound/soc/amd/acp.h         |  67 +++++++-
 3 files changed, 298 insertions(+), 158 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..6b7c620 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -1,5 +1,6 @@
 config SND_SOC_AMD_ACP
 	tristate "AMD Audio Coprocessor support"
+	select SND_DESIGNWARE_PCM
 	help
 	 This option enables ACP DMA support on AMD platform.
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2ef..7c392fe 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -23,6 +23,8 @@
 #include <drm/amd_asic_type.h>
 #include "acp.h"
 
+#include "../dwc/local.h"
+
 #define DRV_NAME "acp_audio_dma"
 
 #define PLAYBACK_MIN_NUM_PERIODS    2
@@ -37,13 +39,14 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
 
+
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
@@ -317,54 +320,21 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
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
@@ -390,6 +360,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -670,6 +643,24 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
+			PLAYBACK_START_DMA_DESCR_CH9)
+			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+		config_acp_dma_channel(acp_mmio,
+				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+			      false);
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -692,6 +683,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+		acp_reg_write((intr_flag &
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
@@ -707,6 +723,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
 	if (!adata)
@@ -720,6 +737,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_playback;
 		}
+		adata->i2s_play_instance = dev->i2s_instance;
+		adata->bytescount = 0;
 	} else {
 		switch (intr_data->asic_type) {
 		case CHIP_STONEY:
@@ -728,6 +747,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_capture;
 		}
+		adata->i2s_capture_instance = dev->i2s_instance;
+		adata->bytescount = 0;
 	}
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -747,11 +768,46 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
+		switch (adata->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			adata->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
+			adata->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
+			adata->destination = TO_BLUETOOTH;
+			adata->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
+			adata->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
+			adata->byte_cnt_high =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			adata->byte_cnt_low =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			intr_data->play_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			switch (intr_data->asic_type) {
+			case CHIP_STONEY:
+				adata->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				adata->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			adata->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			adata->destination = TO_ACP_I2S_1;
+			adata->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+			adata->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+			adata->byte_cnt_high = mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			adata->byte_cnt_low = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			intr_data->play_i2ssp_stream = substream;
+			break;
+		}
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -763,7 +819,40 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
+		switch (adata->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			adata->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
+			adata->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			adata->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
+			adata->destination = FROM_BLUETOOTH;
+			adata->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
+			adata->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			adata->byte_cnt_high =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			adata->byte_cnt_low =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			intr_data->capture_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			adata->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			switch (intr_data->asic_type) {
+			case CHIP_STONEY:
+				adata->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				adata->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			adata->destination = FROM_ACP_I2S_1;
+			adata->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			adata->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			adata->byte_cnt_high = mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			adata->byte_cnt_low = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			intr_data->capture_i2ssp_stream = substream;
+		}
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -797,10 +886,25 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_play_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_capture_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+			}
+		}
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
@@ -837,26 +941,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
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
+					      rtd->byte_cnt_high);
+	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_low);
+	return byte_count.bytescount;
 }
 
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
@@ -872,15 +965,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
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
@@ -898,21 +986,14 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
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
 
@@ -934,15 +1015,13 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
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
@@ -950,40 +1029,21 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
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
@@ -1028,27 +1088,40 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_i2ssp_stream = NULL;
-		/*
-		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 * added condition checks for Carrizo platform only
-		 */
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->play_i2ssp_stream = NULL;
+			/*
+			 * For Stoney, Memory gating is disabled,i.e SRAM Banks
+			 * won't be turned off. The default state for SRAM banks
+			 * is ON.Setting SRAM bank state code skipped for STONEY
+			 * platform. Added condition checks for Carrizo platform
+			 * only.
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	} else  {
-		adata->capture_i2ssp_stream = NULL;
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			adata->capture_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->capture_i2ssp_stream = NULL;
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 5; bank <= 8; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	}
 
@@ -1056,8 +1129,10 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	kfree(rtd);
 
 	return 0;
 }
@@ -1110,6 +1185,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1166,6 +1243,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1185,9 +1263,8 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->play_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd = adata->play_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
 	}
 	if (adata->capture_i2ssp_stream &&
 	    adata->capture_i2ssp_stream->runtime) {
@@ -1196,9 +1273,20 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->capture_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd =  adata->capture_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+	}
+	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2sbt_stream &&
+		    adata->play_i2sbt_stream->runtime) {
+			rtd = adata->play_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
+		if (adata->capture_i2sbt_stream &&
+		    adata->capture_i2sbt_stream->runtime) {
+			rtd = adata->capture_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b..95c39a3 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,17 +10,30 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_BT_CAPTURE_PTE_OFFSET	0x0c
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
@@ -35,8 +48,13 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
+
+#define I2S_SP_INSTANCE                 0x01
+#define I2S_BT_INSTANCE                 0x02
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -57,6 +75,14 @@
 #define ACP_TO_SYSRAM_CH_NUM 14
 #define I2S_TO_ACP_DMA_CH_NUM 15
 
+/* Playback DMA Channels for I2S BT instance */
+#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
+#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
+
+/* Capture DMA Channels for I2S BT Instance */
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -69,9 +95,22 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+/* I2S BT Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH8 8
+#define PLAYBACK_END_DMA_DESCR_CH8 9
+#define PLAYBACK_START_DMA_DESCR_CH9 10
+#define PLAYBACK_END_DMA_DESCR_CH9 11
+
+#define CAPTURE_START_DMA_DESCR_CH10 12
+#define CAPTURE_END_DMA_DESCR_CH10 13
+#define CAPTURE_START_DMA_DESCR_CH11 14
+#define CAPTURE_END_DMA_DESCR_CH11 15
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -84,16 +123,28 @@ struct audio_substream_data {
 	struct page *pg;
 	unsigned int order;
 	u16 num_of_pages;
+	u16 i2s_play_instance;
+	u16 i2s_capture_instance;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
+	u32 pte_offset;
+	u32 sram_bank;
+	u32 byte_cnt_high;
+	u32 byte_cnt_low;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
 struct audio_drv_data {
 	struct snd_pcm_substream *play_i2ssp_stream;
 	struct snd_pcm_substream *capture_i2ssp_stream;
+	struct snd_pcm_substream *play_i2sbt_stream;
+	struct snd_pcm_substream *capture_i2sbt_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
-- 
2.7.4
