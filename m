Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx49FSBCRl7075v+1hJ2hYYpgdcloe0icaxIxUQrOe12Id42xcEDqFEPVaVTwS8TKli7Vlfz2
ARC-Seal: i=1; a=rsa-sha256; t=1524539033; cv=none;
        d=google.com; s=arc-20160816;
        b=Xc9wxuhNtt9eCGfx9TR4tJvSACcRC1xR7ZFjlLglNyn0FwH7jFvrpi+WlCIuu8XomV
         pPLZfP7td7rQvo62ARVH9zVMJh8u6pjS7HmnV/zLapJSDGUV54f5aS+Zqga4w30c02Jj
         OoRxwI+r1WNGQxY1KELszyaJAqvrWlCFGbYpTbRAofeBQoUDjcVMZsOpircNxibLUlJu
         D7RY7qPRDCfMoS1J+pLt7XGkE1TdwK3RzQRqTwjNAjLn/PK8JJVaWZkMEIZ54/e9gc1I
         Gj488YFAGZhrFibI3ZzY4RhphZAfHgcvpJGmNPkW1wxnCTHF9kMYzJeh2pSpO64Hf0iI
         LVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=r4cXfUhmmwYrBwEjWtUAGtL3YcurFcNnDWc4CCWIVx4=;
        b=adS7H+tqqfRI/gJlB3CMHlQsGUuZ0n9VV27xbT/GawVP2u0TPUE/th1N4C6REUQOl+
         Lk6rCxer/K6vBetrIURjhdJNExm22h4Smln1J7SQyFRNyaipGV1cx9V17tVk3b7CQQqA
         AYn0yOCfGmtbFeCiGetoeRjBcCzpeZEjeh86UoSxMlRkUxkc8NCvaj3eecxZ3F2ZHvty
         kw35DzXMdwV6g8ZwupH9MviQZ6v0CjP4pl2VWIcAQBguDOSluku1XRCRwiaKgVXgTWCS
         d61l6OxgR1A5niLg1OmRU2+px+fnRTDDyDgW5jC0AFlzhaFHrcS7kORFJLjC+hAMy8b4
         5Qmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=195Cd5wV;
       spf=neutral (google.com: 104.47.37.81 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=195Cd5wV;
       spf=neutral (google.com: 104.47.37.81 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Jason Clinton <jclinton@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] ASoC: amd: dma driver changes for bt i2s instance
Date: Tue, 24 Apr 2018 08:34:38 +0530
Message-ID: <1524539088-9043-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(346002)(376002)(2980300002)(428003)(189003)(199004)(9170700003)(305945005)(36756003)(6666003)(105586002)(5660300001)(106466001)(53416004)(7416002)(72206003)(76176011)(2906002)(54906003)(478600001)(86362001)(51416003)(7696005)(575784001)(59450400001)(77096007)(426003)(8936002)(476003)(2616005)(356003)(48376002)(8676002)(186003)(11346002)(16586007)(316002)(446003)(104016004)(4326008)(26005)(1671002)(126002)(39060400002)(50226002)(486006)(109986005)(50466002)(47776003)(53936002)(81166006)(336012)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0330;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT058;1:vgNnpLIydx1zhabpUUZnvZiaOgDrdo6gcXDRNCkBGxZv93mS8p9TbSmTykl2by3NJ+HS67IW+Hj8cl3DmQMXc5YF18GNGlOtYxjWA4lZoNhhwWFXkO+KeFUxIjeVX3Is
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0330;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;3:wD51xrXsmJ5+JLwsewEBgeQDRmctxTVkv4gEFHtaGVZRQwXPNSAsNXgKV4fNoia+J0lnf7iC80p5YbthNo97mQv0h2+YnlIbDriEf3M/lHNaAmSmAAxtC8KdQjdyt4an7f6RXA0gPuKqTUU/djr1rLQf24DZNsaLziVVtrvVGmt3LFQf1KieXB4r2LY5Bv0gIyIkfMB4mgui4i+hcsvuP8kclDTPUTxlmNlJHh8gpvlGpcfJTja04QhsqyHjupkXYXvpx1IwtXCDEOCTlAOILyPomZS8MbKpTOu7G07kO7KhvYPR3Fqcn0vOZGSaT9NraBJ33E5hFWEXCAYbkfxWTIblnmcWPti6CTjRXh8WFWQ=;25:OZSa0pQNpVCDHl0GOJqwgBTTSeK4ek78As7fFzcliuew5xhJ0e1r3nAL77I/TdTFzBP4/psKs/8bDF1yW8L03I05n0IiFYl4/hU6TsWiL+sMv01W9ttX8DFC0nmpIfUAnJPG3vWHiaFBTbQBtS1Sd6dCedsvk5lCiTSL3CohtFQytC4zMEt94ek4m5Z8GbPqAW4cMAe9/Lnb/xZwjpM0VHkwcmh1N54ojCTJdN1+2OIKGdxtGM4FGM01w7odXo1/r4vhNNj4mn9WSzJOT4SLey6mttz8yLOABAksaWNKkK4erZgBcnb7f145FasxkxQSg6jpHURS9LNbi7GhwknQ9Q==
X-MS-TrafficTypeDiagnostic: DM2PR12MB0330:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;31:lDSZJFTgCiJku2Zw1p6qdev8Gmdslr1OamFLUVX3SF7AkrD7UyeoWkJke7OghijmwLHfkCPmnOnpbhmvy82yaoQnAfUXnvQQBQwyZrNPDLK1gsjmlqBYiH0D5a52HPx2MNB7uJZgbwYz+QXttS8HBbDc310RU7tpIXnXJhO2Eszs+SHSnRTYWc1SViQitjUsJiE8E9nNPjXcvrFW0qCIKx6bQIxjNKzLI/Ywr3nQG5o=;20:ipGwD35DxDYcYUIevA0uQQ1IA6Inv+JniowtePx/Sj1+iBs+XhS9qI+b2/4B0+KzNENw7SFkeGaVpGyGERSXUf1mpDFDVlNvMzfBbYSZaJsYes9rH1NyYgyiucmXdDj0U5iJa+5r3rMRov4dGOZsaXOxsX+pg01secViYpX5uLNMlm+3FaxAUe1vOwurgvaVVBrfh6Zc5Fy9qO04yZ3GWSdEQhPBJ+u2bBEwYbkDZDexGxFoKuO50eR59cPKfQvv96vWC/PpgtW5vTBE7AyHyx/kFUcZ/F9ujJ6EO15rIHo5eOIl78Lk7nsUH0yGYLBsHa3ZQ+thXBoy34VKmNNGmLpuaK7it3oIpkHBKfKjkbiKCJx59Fx5qyytJfva13Y7QB9c1xXhYuG188y0vyWw1u4ogjQuW5zLV2qnBMvSaK493h+EYdI0ggtwPBSX9XtVWaNYjKaz3iyf9kqxCtSRKJe+oigicV8wgno2pfojVhwyjxsUFryXdNSwMa4VaG38
X-Microsoft-Antispam-PRVS: <DM2PR12MB033023E79BE904018215D07997880@DM2PR12MB0330.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR12MB0330;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0330;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;4:i4GTGTdPS2s70SUH3K7QpX44IZtsvSxrxeI6B6/nCKy4NkRzRb+d9IUXq56L+XO44KV8qcgLT/tseL2QM0H3TY0Kb1Op881hbHZUlKf7p6GdkRfeRqloC6TDtywIV2zkSHQN5K21nan7Z1HJ7Q915WNrOZt3zjt1mDLfcYIYBUbkPREhwTa/Hptuqrvz5lprqSLyB8QKVD1FbDMClKfp25wszMuUnWvwBq4L6NtP5ErhoOwEXFSU+1YB7UdQop0jYT/627krXomZwlXK7fnp8M5hT2sFVU1heyJZYOQFxoGo1su5PrXwe+3QZdt+mUdW
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0330;23:/U6ioSLhCioeSq41H3xwajszvCSzeLXokUz9h2RSW?=
 =?us-ascii?Q?sDy5NxUHQQIXbaUft73+LE/+d5Q2noJ+W3f4TkDVfL09cfHVVWSUI/0hmqDj?=
 =?us-ascii?Q?Dd51bgEOu0YSBjnxNoHAWJhd8vY0jIyKbGU6N4aBhrj5X3IVr6yJA7CQ3/MJ?=
 =?us-ascii?Q?LgLAo7gK9CphSJyVtWC+9AMEB1/l/AVOicQ1i8iBpw4j2O1FINoIUBFoE4tZ?=
 =?us-ascii?Q?/wM5xSCAe26EgIcFZU/Wxz4SR5q00efvZIbrIflTrd51BoyeNJQtTbnyej8n?=
 =?us-ascii?Q?kyneF3apKl/tD6w3JXNf5JmWHEQfqGknmvYUuSupAHFnooR3vrJQj90U3PZx?=
 =?us-ascii?Q?EFji5V++wK6ppuNosj1ZiyXrRxXlnRREwdlOamHpsUkkEwdso0ZKh7fllmIZ?=
 =?us-ascii?Q?D0iHjXaC0v3qv6CMAwMVohGL/zMKZ20ANNOW9l4mpHm7TGhSzGo3Pa7Bxl7A?=
 =?us-ascii?Q?Dp6mYdf31PTwCYZSzwfkqTqWP022UV/AeVRW8dcfH7U1k9gTYJ5zD/Drllkn?=
 =?us-ascii?Q?YRFOcz5HGA+G922vhsLfhC23OFLJvRlXbBm8urhpX4YQPlj65EUFXOR5L9i1?=
 =?us-ascii?Q?bj+Vxm8DlV+at6k+fEcouhXm3qTVua47bdMRHFr5lcrq+otBXv9P8LU57zWo?=
 =?us-ascii?Q?qRrq0wLOitXj3EzsagYMdOchMomtp+CyxjSvm0l99LTntE0fzc7jByEmC9AB?=
 =?us-ascii?Q?0xqy4dw9+X8E/Rig/+TkfzOpOTKb1YLfkENXoyP2ArSksIoeTTv/4fRSfDu8?=
 =?us-ascii?Q?/1b8sC3eSv46OJfX9Z+SYhqtKEBMKpOgaaoU/r2PvLy4mOrosI8TZEEMyh8L?=
 =?us-ascii?Q?0/oSCHt+hLI/Hg44IPusvAOFsJBYMkufh149Eq0YRscrE5ezlhCWCmp7aYrQ?=
 =?us-ascii?Q?hvbS9iCV/OidMfW0XQvTW8A7XL5GnSK9qFClcrB2rrepOiFNF47SS+aCbchc?=
 =?us-ascii?Q?9Iq4SNYDb4AUZKK1P/DNRhepiIUyWUFjrxuh9UtIvV0auNAvWKXzezFAlte7?=
 =?us-ascii?Q?9U7dF6hLoJ7ao9pMBdHVcIgs6wsVN+Z9ZbL/k1E1gew8Fb/5dsrG/BqR3y1T?=
 =?us-ascii?Q?SYWrfE4xxcNdjDJetlcOuwqE/5M7uMOjxW+Y2J+XNi23MQHAWOtFyChveynh?=
 =?us-ascii?Q?5nwJM2XP9kbQgOq+yq8YavABJNKKFiJDB8UHY4BbA8WisBIARHOBXewSLjw5?=
 =?us-ascii?Q?xc8xA/tjrW2+5PcrWOkIsHBqXrOPp2DiYfa2DlZicepTAZjBuE9YjeQ/sxIX?=
 =?us-ascii?Q?KmQU/yF9n4TRAxxncJgG+LGHxlPUyr2Q9Qu5uvd?=
X-Microsoft-Antispam-Message-Info: AnUDi8/zVolSkxlVaa3nI1Gfqoyq488/6gdNUGhKc7FkKkxRTcet3z4vkW/iFz8GdxH4hq/g+Wpu63C45oRdorXAhQKFaih4C7XKEjP27z/tN1eIU+ftoxHOSD5o5K2pjwUfy8MMVCdwrLipC5WQA5uTYOUt1ZGDWWEbEcmo/ofzSGdQiBVVAg6kfU9s/Uxz
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;6:tXflPSEfz2wwT15w06CMv4WsHblxsmA/7iPN2jg5lJ0h2x+m4hmFe4mQCJXcp8KkITOQWGvJrDvtQbqDBMXB1LNJaHUpnN5OqAmqZ7K/1v3Pz5Tqap5occCin68dPeZVdNi4dh0/87gWF76/PFS7FDDpHBi83Dr257cGbEk2nXeeiA40YxaG/2lXBzSceK4cwoBb6xtnkaCWVppsatnUr4NQ8cc46u+Onk5KdVxOANtZI0UwlneBjBEJ17AXSsLJFVr8NFWPlQP4sbPradnQoFLVhWwU5s7FL5wp2Me0W6SzkgO7f8iU5QQ/Se6HjwQb3UnFTRGRuQ0jL/X6vEV6M7ZmatNB+XZw5oz8R+Z1ZR2TkuLXKhMFqsxsJYeoFsuCT9Nzys89AbXVpY8qqsWuk2R6I4iqmeMsLP3Tripy2VFqLRsieQ87l8v0acO7h1yeCa0s2d+HlOU/+H/D+TtziA==;5:WHc2chTpffHvcRXalDS3biN+GJn6oG/CXczF+KaPsA3zCf2CPn53SFbL0KeX3yCSMjEx6N8UaYhYvsY54zkdx8LpTFO/ALHHD3vrtwTke0TBjpJXONLxSf/5qZrCOLd/ydavxua7RDoKobqqS6BKg+yGpvonLmlCVAgbhzqkyH0=;24:0vhoaDTmuRB1AT4AH1hdmCdcKN+hg8JitT7i9GbipwvP9/qrwG8rQtI2k8ZBIKobuC0zCjEQQDYQASTNyI7evVROwlb6oe+50SOjZpcWA8o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;7:4zNNk7mIRXZFWEbZF6N1cEeGStaGnm92QrPekXlqw5Ev7sW7oZ9wcdQInNyA9AJeZW3842oi2Q+nGkeXKCRlY121iSXSCXFvkLHhgmxeltlWrf75qzZVcwnmx6B87VbWfc7pVaKz0tQYucA4qvAkg9xD0c9mtNoXxvNlYZN8+hBrSOSbA7uTEC/YslmPiR2vj4ESvLBkSZtr9ARoHbVuM4NLDgfnqy1RtKMLIDTssvr4qJGBhPxlRCCN4B83t2py;20:V9qeixNzVQG6MsA2tCevgJQetgTgOqUinbrKt2TwUiKa2Mv8gtAVRf9TxP2n6UK8jes8ka8SeCXC1weN0+nk0Gj4yZxu5AoZZc/ECuMkLNSRsCXg4LaJ3qIDZ37ncRbTCyK68qK9Yu0idasNb33rZQeJk1MwrKEOaMBV9XO12+i++LH1n1h/iBegQrSAfhoBTCWiBj5bT1jDRVZYOS+8/0RFBgeteuPvj+esH3fZslou+NT1/iFdu6QoIzeGjwbp
X-MS-Office365-Filtering-Correlation-Id: e48cc60f-54e4-4d3d-ae43-08d5a99000c3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 03:03:49.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48cc60f-54e4-4d3d-ae43-08d5a99000c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598595041212907440?=
X-GMAIL-MSGID: =?utf-8?q?1598595041212907440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v1->v2: defined i2s instance macros in acp header file
v2->v3: sqaushed previous patch series and spilt changes
	into two patches ( acp dma driver code cleanup patch
	and bt i2s specific changes patch)
 sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
 sound/soc/amd/acp-pcm-dma.c          | 255 +++++++++++++++++++++++++++--------
 sound/soc/amd/acp.h                  |  40 ++++++
 3 files changed, 261 insertions(+), 57 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 0f16f6d..4a0653f 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -35,6 +35,7 @@
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 
+#include "acp.h"
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
@@ -43,6 +44,7 @@
 
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
+extern int bt_pad_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -126,6 +128,9 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -137,6 +142,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -147,6 +153,11 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -157,6 +168,11 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_dmic_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -260,10 +276,16 @@ static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
+	struct acp_platform_info *machine;
 
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
+			       GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
 	card = &cz_card;
 	cz_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -271,6 +293,7 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 4a4bbdf..864bd6a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -37,12 +37,14 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
+bool bt_pad_enable = false;
+EXPORT_SYMBOL(bt_pad_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -357,6 +359,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -519,6 +524,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
 
+	/* For BT instance change pins from UART to BT */
+	if (bt_pad_enable) {
+		val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
+		val |= ACP_BT_UART_PAD_SELECT_MASK;
+		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
+	}
+
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
 		      mmACP_AXI2DAGB_ONION_CNTL);
@@ -637,6 +649,24 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
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
@@ -659,6 +689,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
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
@@ -715,7 +770,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
@@ -734,6 +790,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct snd_soc_card *card = prtd->card;
+	struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -741,35 +799,70 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_instance) {
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
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
+			rtd->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
+			rtd->destination = TO_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
+			rtd->byte_cnt_high_reg_offset =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			rtd->destination = TO_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+			rtd->byte_cnt_high_reg_offset =
+			mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+			mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2ssp_stream = substream;
 		}
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
-		rtd->destination = TO_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
-		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-		rtd->byte_cnt_high_reg_offset =
-		mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
-		adata->play_i2ssp_stream = substream;
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -781,23 +874,42 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 							bank, true);
 		}
 	} else {
-		rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
+			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
+			rtd->destination = FROM_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			adata->capture_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			rtd->destination = FROM_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+			mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+			mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			adata->capture_i2ssp_stream = substream;
 		}
-		rtd->destination = FROM_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
-		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-		rtd->byte_cnt_high_reg_offset =
-		mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
-		adata->capture_i2ssp_stream = substream;
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio,
@@ -987,24 +1099,39 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
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
+		switch (rtd->i2s_instance) {
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
+		switch (rtd->i2s_instance) {
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
 
@@ -1012,7 +1139,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	kfree(rtd);
@@ -1067,6 +1195,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1123,6 +1253,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1142,9 +1273,8 @@ static int acp_pcm_resume(struct device *dev)
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
@@ -1153,9 +1283,20 @@ static int acp_pcm_resume(struct device *dev)
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
index 62695ed..9cd3e96 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -13,6 +13,8 @@
 /* Playback and Capture Offset for Stoney */
 #define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
 #define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_BT_CAPTURE_PTE_OFFSET	0x0c
 
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
@@ -46,8 +48,13 @@
 
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
@@ -68,6 +75,14 @@
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
@@ -80,9 +95,23 @@
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
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -95,6 +124,7 @@ struct audio_substream_data {
 	struct page *pg;
 	unsigned int order;
 	u16 num_of_pages;
+	u16 i2s_instance;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -113,10 +143,20 @@ struct audio_substream_data {
 struct audio_drv_data {
 	struct snd_pcm_substream *play_i2ssp_stream;
 	struct snd_pcm_substream *capture_i2ssp_stream;
+	struct snd_pcm_substream *play_i2sbt_stream;
+	struct snd_pcm_substream *capture_i2sbt_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
 
+/*
+ * this structure used for platform data transfer between machine driver
+ * and dma driver
+ */
+struct acp_platform_info {
+	u16 i2s_instance;
+};
+
 union acp_dma_count {
 	struct {
 	u32 low;
-- 
2.7.4
