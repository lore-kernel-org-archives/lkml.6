Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4+/qiQJqgcE4pGmVisjHLNwuzwZ74yocbwosmn7ZSZF5fnL4RRZP3+U85o2PoSb9HFGleAv
ARC-Seal: i=1; a=rsa-sha256; t=1523941145; cv=none;
        d=google.com; s=arc-20160816;
        b=xQpNiFEfMdNB3H77WdsxcjKt2mpZjTu/z+/VrbxyxBvVAgEe7sWIZ98vL2HFBaBB7R
         /mw4C1Vce5FDWFZ2c3pHZwnQraWp0ngxNbW5Z6Z5d9kZsl/jBVoXdSda+zVV63Uwqq/k
         +waIyuNBM+VLb1zNauG4B/o7y4XKmV9OnkxLLMguW927EvreDbyHElti7ZoQxVY129Pd
         oKX3tRcHChDGyiAsbb60cR3cgomGSl588xCZIJnFLhiED+PA0ByxFqy/CLR6QlbEraHW
         o4ZfMSu4NxSduufX6GOAUAJk8NpN2n68uXmup+N05Zpkk5IpcigNtErJ57pM4g11pdMS
         LNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=d/aqK0bwlmdkGYWazvO/QWvdyQyNrnCFCOPe8TqGELc=;
        b=EmaHWiuLON7Ndt7bVnrrljNvzQ6e+2fd2B4hISMdalwT9v1Lsn+Dal09erAKRlImHe
         xRau6D4L2Ysir2NXQdp1iaTXb7ZLMugYg9M1UmE5qx3CTgbVnwBvQmlQwI+gqaNev06v
         yR+TrPVuMgYT5nIZoOSsyO7oKD3zoRoTmfT8o3crUgK+1mWQ+NsKXZiX8n8G7MY1qW0y
         TrbIV2JOZ9pPR7Huu9IOK/uZ/hJkDxud6kgjeObstKf9Sjw3GBJWNJhaLP7dc/GdRGIQ
         9AOgBtJe6iLKuXZ4gp6v9hA7pjT/qNzVW6iXHHWreM6ujRBpJdw+tgKRYFPlnQWjhSJB
         JKkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=bOLXYZnU;
       spf=neutral (google.com: 104.47.33.45 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=bOLXYZnU;
       spf=neutral (google.com: 104.47.33.45 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Dylan
 Reid" <dgreid@chromium.org>, Jason Clinton <jclinton@chromium.org>, "Guenter
 Roeck" <linux@roeck-us.net>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: amd: dma driver changes for BT I2S instance
Date: Tue, 17 Apr 2018 10:29:53 +0530
Message-ID: <1523941201-15665-4-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(2980300002)(428003)(199004)(189003)(486006)(126002)(476003)(11346002)(446003)(97736004)(68736007)(478600001)(5660300001)(305945005)(7416002)(426003)(8676002)(81166006)(81156014)(8936002)(26005)(50226002)(6666003)(2616005)(4326008)(72206003)(86362001)(575784001)(39060400002)(106466001)(336012)(36756003)(105586002)(50466002)(48376002)(1671002)(316002)(76176011)(53416004)(109986005)(54906003)(186003)(59450400001)(356003)(16586007)(2906002)(104016004)(47776003)(7696005)(51416003)(77096007)(53936002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0323;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT036;1:XmGqcmPfKvxGD0tNaCRF3OmUsxNdeE0u+9YEKT+C5bX8j/eB17aXGdLytwGcq0gvHL9sOqjBW1s4IOxW48G/FQC20E9z2meu84EOmOAN/zcJKpUVeDOecMWZ8aKrM7Iw
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;3:wW4PYao9GDuidEOQuEx1vi+EuocnLpbtWlQeJSE89he6fQjBqtoU9gnA6FKO6ZLnt3D+M5FnX1JZdfzCMxDJHh8blOD7XrYCKd0w5gw5oJPrqud/2Nst4y/yFBduLJWzEzXulWrxEgy1mzP73MAGX1xos6yd0/N1K7PyqMZs8X02KkJXzeG5PLPcw/LolhRhxBhsTghEqHPyYJDlpFckJHDdcUG7S7qouRkUcNEZjyMikcWUnyUxITVQx2mzak0nY7wkwcSzLcDCvltgXJqFvruN0u6s8rTscQgVRxeefk3sIBSA9mhtpfqhuHiwww74fnjWV9RBwKsc3ZKi7zAcBJZfnpY4xPeZ8Rj01XqmWO4=;25:P8ABGaAhtEqNBHq1E96MjMvM7O45Qg4ca3rfqs4Hlqmm8jWLTLkwStnzehPC5UugTwSR+1JtneFVeDUPN8VbV3P4fDbxQlmoSWkM+IVCgEQImOPvMBHca0JOaxIT9LwY7WQujFHKJ/k7VN1pP4MX1KEj1kkFZLIE9rCltYGN+wABUSMSXuDU64BoW01ScyzV9SrJ89c5pYyB9MI5UaYAN1j0URms4QdTM+d0wlLuvRq/ycpC0DC1/a8HU2TEVqOEvzbISC1t8x3GZm/Y/Pzgy7gVhXIg0Be7yc2PCHuKWwCnHMwI9ahP7h/6DHPkM9s2OGsVWjlXp4d7rsqvD//l7A==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0323:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;31:OuV0uaHC5vow5DWxiVcXCWgxMa/AteyPe63RAme1yBwP5u9kmogUy2ODAhjoVsmZbe3S4o13sMuiXVKENJ6nAp6MVYDAI97k7FAUdU1aBMldFY9FHHG8ztJo/A5pxCBsd8uHWvHplwvKpZSAqSaXjmbEMt/0m1lfhEyL4ReITazQPRzaKOy1gpa05vcRnC/1kExzmh5xwahXWyYQ6zk34ZWvftDLXm4LEfo6fa2O1+I=;20:pdpkkvzhonDIWSXul9kvkOesLy3Y8ul8GmnlY3HkJG5MbiVS0tatv6ZNsjQt+zvy59Ghg7ZKpUVFYWrM1Q53wpR4nmKwE8mse830+noW3S7w8KhoMVFMUbx/5jvJxl3M90eoisWwlEs3RTuKbXgahTFp9uxkNE8QMC+v5z+1J7g5w/j2/scKKiCkq4tJUhIZWJz/wCAgpR0PedqC7D2+hAiddeISryek/0Y7ifbJe25lJwiDsMlBadMAl9inwVPV2xrV0y2EUiM6946cS3C9Bu7jULTe0MfIM4Ho1K2zpWRqUK7UeWNVnrGhaQWA6ZDjlIIFypDNvK+A4uHc9eTXMfr/fEcw9zWwswXVSep8dn5TvjDjJ+GozoNSEOITorj7JNun65F1w2Ml4kHJF37Wb1dM2BovAh5PJF8oT5Se7Ur9cO1g1P8PNpwVhES6j5kXMz6C301QFPaunnnpVcnFuYEdSpKR9T7IeFsPGfM5lkF/P80JtENZXv1zRVE8SCaj
X-Microsoft-Antispam-PRVS: <BY2PR12MB0323508EF2936845A1041DB597B70@BY2PR12MB0323.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(3002001)(93006095)(93003095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR12MB0323;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;4:37IJ0TjeXKYpJ6bdTgK+tSSXZVf8+cEp3RKKQ4c5OMBZ5MEkExg2ax8RCKtv4HL2WlJJDt3Ao/HWGAdeCORdWp7RajBUdCZgxaBD+NcjCW/bigGZBGCYwL9CTQkz0QE2g/dXmot6CONbXKSMolVGnTX0r8NDTykmLc6E8/v4kA4m48rYKlS5wUGNcd9zLNDnczHDZLNPOTzfyazv7DcmqD2MAysTMBxt1YA/j0qFNGLfx/9h0B0/0ASTwKTkpW4Q/0J2Bo/WtNRZ1hQhfwEcNAIy0iOQi/tQd/bSVpFKQw6hixCtSU+/JYqPEvBnUIe6
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0323;23:4O5nUljrbnFohmbmTMiBLonufOAtIaSQsWYdAkupC?=
 =?us-ascii?Q?5LgaBOVt8iUN9a07MqFfeU0hnE7uM8ZcX4VhxJdWMhwZLdLLqQEUx2nSWEXb?=
 =?us-ascii?Q?OIOi5gYg0j56jAhyiX0hUcxg1nnYqJKZsxsvZaflyYovq+Qxoc3qaqVakErP?=
 =?us-ascii?Q?oKvkhbdX2lc7LQSgWjQ8VcQsUSLGZ2Jv+rih3Ve8i328X/WuxRQsb+lYZBPW?=
 =?us-ascii?Q?zhKYa9j4JOW8YRs6wCLdQ1KbYvSJkkUJX/K+rf4qJlOGlF4gRXmcOBydX3HJ?=
 =?us-ascii?Q?/fUqduqWfFPvHxK6vcpRLjAmKDmth+LKSwpD39rsqKHv3b+Lh3bdPKgAcCRn?=
 =?us-ascii?Q?Xos0PIPpEfJZcB9vz9B4l1SJY9yEgXJhc3Bni8zTh8mR1EyLMwQauroxGBYk?=
 =?us-ascii?Q?EmNv3gGpGoeU/XwFhdt3OThjJc9zDi8ESKp4Tv5gNeqviRm7e3S8Xs6ottGg?=
 =?us-ascii?Q?QYIQPdN1xbLNpx8s95BJ+REBEz1hLWwP5TYuMa8l7rgWn/ohZzlJ15GsjiJB?=
 =?us-ascii?Q?V6eaWFooWhQDdF5RXo6/1t5dgcIOrejKgfvUJ6v1pxeYVDfU4DmcMBlqBlMe?=
 =?us-ascii?Q?9aE3CmOj/eUdVCSt7SVqVHfQxSI1n6WeE15NRyBgn1OLa2wujAIgIiIraaVj?=
 =?us-ascii?Q?t9YItovTNqU950tRNFwYh3DpWDQruzqCSvMckAeqHDowKu9VLbDtJjGgLDKu?=
 =?us-ascii?Q?tX/mlOskKu46NyhlE5beoVZd/zPv00lUPzuuXm6JR4ViZSfO3iZspxoRybTm?=
 =?us-ascii?Q?qwc3czY8twfLvaRcrzuOx6kJpUAXoFjmJhnrg56L/glFWq81vWIazYO07/jH?=
 =?us-ascii?Q?4Uv2O7omQV4Y4+wwrIAUdVBiRglDypZEGI/vhYmG03PQf8RVR1xW924R+q3T?=
 =?us-ascii?Q?gHHG1w78EYig34sIzBSzQ92F7hrNUFKopMGchKutKYcYUS7DRNyCaBparC1E?=
 =?us-ascii?Q?5D4NAvF+mSwk4hbl2sH/SAoZc66ocpQM0DOrDReWVi7ABJLNnMzlYI+fcYEQ?=
 =?us-ascii?Q?SiLh//Z/J5bSmfzsRTvJpHgsRnTCnNpzcFHWYeARy3SvTagipg7NThcQgeHF?=
 =?us-ascii?Q?SAaRcmBEqbl+zlJDn8bmHOvS0p7rtsS2BaRJ/pLcuIPM8IGz1L5hcDmDeAB7?=
 =?us-ascii?Q?9Wz71QcyLHWyI5YHi0Da9/viV0BUtCNO7yB+RFOVzbGNlaFDukxi0firTPBE?=
 =?us-ascii?Q?m/pK6I1BmkDmQRpDifMZZq0rgRzH3dI6oGLDvYdNNzjNk8IfvM7Lcl9H+VF1?=
 =?us-ascii?Q?WqluPDvxTKQ136shzkjbF+iod9rJZ+8OHxEhD/xPHUrEGmjknNUnqA+YqyTI?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: WMf1hm8MGVlw+wPf/bBUx6XS/C4EeWznIDKgIV89fN78vOANRkd3zeEjsoMkzZ5b/7j7u0xgo+EaRrnbId6BaWc/0UNMCj/YHwgtuRLwGfKyg0q5g+BsYebixnlz+NxUw4eXIC3RkqKYzplzqZiGfc0Wb0TyTP0GV/znGgudi1xH0wBZcdJhFk9ASNB9vu3z
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;6:CPq9itXWoL0UK+SnVkqIg5DgKySS/kgUnSbUg+eLT2ayyXozg0RHcgyXIzIzg/KuDdVsPWzM2tZ5Pu/1Hu3pL7bvbSxIPf62IER6u0r1bJsHmh28LYYCNp55OUkTqaynolg5SYTtwr0bEXCgMAwaDPKQg0xnWwCFU2AHf6bnyYzcZIUSMwjZ/0sz46oG75bX/NOa2HP0JRCwMp3jzbwRp9GEputkafHIlsNN01fGZXPs6ySlUplABR4G8nMA1DGKuaX2qSj+KgI+o85lgeUsaeyNWwc/TDRSEYfz8EKPR+IROJw96ev4i52gs6e/xRIeBposZQmzJwXJKV5CUBk+lT9uyXIWBG+YTJqFOFER98Q8ABxznqCuWsrda93oo1WbZCNFXMH3c+fFPn5IjMhjYeILEiihXhs3tW1kgless3532STuVcLy13jGlWGOy9UgvpkGtMy73Q3A50Kc7I6S6Q==;5:pWuEtr/41Gleo+Vfrj8F5HuSCiH5nZ+8KNq/x/0VxQ4xPAQgodJlUU+2H2JwWmsvmUBfHhNcUwRzec9y2HCuc4vX0sbrT+1ocIqsjZgbcwOgVsPwK4IVlPtd61dJ+YArcl0r922j05mr/nhxrsnop6Zvp1NXDuksmI3fhUoM7aE=;24:ThPsRD4TJ+tq85tolU8FJ/NRgLzen6usaJXxz570G6qu/Qw8lsWMmZu4qk20a8VT3iY9m8ahPgmPMRPrTLqnPyOYG+kpcBs4/qKrDoYIv9c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;7:a7NU44GpYCVHPtZdSwe6spQyL0zKYR3f3ktOHmdrMDYh+VGLXT6yl4DVyP95Z7oylFXbcNtdTXuo9oWA5OzmUOdkTKFspQIuYQZ0oiedzgmofB9HWOG3nRjJhjXPQ3NR9aj4ziLbCzrY6XHG7qhJu5QW0Hi4Q4LD4foxfTApJDRtBqaNBmjJ0JTJFj1lwEkABXHp4qFDA0L421WF4G/qEkVe3zzxG7pX2WKAdbm4XkXBPRCSs2Av0NFUzeMFtu6f;20:HZSxPNFGowuYOgyZbDV/5FDX4NHMUuwK8mhBj9i5A/378TzDi1m9iS2KA6ZyelkhpnxOIYCsDQp961VfZbg5B/VYts7vJ+CWyKX8SWFgF+q6rskcS8ZcYdCYRxTR9xh9Gcrb4NxhPZ8FcmdgAWckVcbnkzWO6SpTom6vIHbRc4k1TL58V+UBENYDE10U5IDloTSjjcgGqYwA6my4XnWcHV17HpuFy+OBn26cp65EaN8Q3faxYM7twn44uQG90q7j
X-MS-Office365-Filtering-Correlation-Id: d6fc0f0a-f319-4891-ad37-08d5a41fef24
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 04:59:00.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fc0f0a-f319-4891-ad37-08d5a41fef24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968110550199281?=
X-GMAIL-MSGID: =?utf-8?q?1597968110550199281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig       |   1 +
 sound/soc/amd/acp-pcm-dma.c | 388 +++++++++++++++++++++++++++-----------------
 sound/soc/amd/acp.h         |  64 +++++++-
 3 files changed, 295 insertions(+), 158 deletions(-)

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
index 0e6089b..460365c 100644
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
@@ -35,8 +48,10 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -57,6 +72,14 @@
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
@@ -69,9 +92,22 @@
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
@@ -84,16 +120,28 @@ struct audio_substream_data {
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
