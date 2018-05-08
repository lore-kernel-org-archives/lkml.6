Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZpiuZz7H/8X8h2Be5mZY5cTeK2Nb7SxYWWpgXxMOgco1CqjDa6+3TNgH9/SE4MuBRVbbpYz
ARC-Seal: i=1; a=rsa-sha256; t=1525754919; cv=none;
        d=google.com; s=arc-20160816;
        b=1DPdlHiWSqLruqKQ8KWOSBcfZ9bu/nwoYDL8y+VnGdWcWsS3y34OYotg/58SaqjU+h
         WSFvQ8Xq9nhJoK/YbwgSlbfa3CYOzpeaUkRgqsU9iwwfczP8wz+UjlTN6ZYWlQX5R8Vv
         QufyY3plt0pP5+QTAkv/SqFCi2M7crYzVWM2neMcxWTTWFQt1O7QQ89Moj+ovxt/8MLG
         ElCJjzqEvJXGoBi+vae1xutwfUlQAoqc2PPmgUcDfErAQVbgCnF6ZuNJCjHwFepVUO2f
         NRJQOJ8aXeRT/LC9fpQ8aex3EFsEAg/+en8opq6m0Kqx5W8DLu4YUcu0zbY28OfyttMF
         pNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4RjT0tvYDOcId01K4/Zh9qc4MtXpH+yeFX3oFkSpL2Y=;
        b=TteXPD0vkvJAtppKe7aLy/mhoHQ8ZVSioQDQK9XIiGF0Kn+e72c4/XaaHk6EGjmXnm
         txdf9mx/r/uSoTV4+iojzOyoj4nhxAEVWs7QL2OfTjvNwirwfPFUs1TWyFZeNLFRYjVn
         RgBV5TO0bPPJMHn3rn9tilyMRy/ieHmhLyENb0pp0s8NSnbltsPi0hb5Ikb5PpusP2JA
         YJnqL9R2dw7P4HL6pYhmwlUmgUVkvHyMXIZOJFVL2PJmEbdToaQ1xavpFeii1Fhmr0lu
         b3RtEUk7Jv9p9lRzwUfmmSYg/oEwl/K5AVyd385hNairxibBWtFdzEZ2hL1GupQAX24k
         oFKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=gyjAwp7a;
       spf=neutral (google.com: 104.47.41.73 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=gyjAwp7a;
       spf=neutral (google.com: 104.47.41.73 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, Alex Deucher
	<alexander.deucher@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>,
	Jason Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 10/10] ASoC: amd: dma driver changes for bt i2s instance
Date: Tue, 8 May 2018 10:17:53 +0530
Message-ID: <1525754888-14124-10-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(396003)(2980300002)(428003)(189003)(199004)(486006)(86362001)(478600001)(2616005)(575784001)(5660300001)(105586002)(106466001)(68736007)(109986005)(39060400002)(36756003)(446003)(50226002)(2906002)(53936002)(59450400001)(7416002)(356003)(53416004)(11346002)(76176011)(77096007)(104016004)(426003)(126002)(7696005)(72206003)(97736004)(476003)(336012)(4326008)(50466002)(81166006)(1671002)(81156014)(186003)(6666003)(54906003)(8936002)(48376002)(305945005)(47776003)(16586007)(26005)(316002)(51416003)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0764;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT062;1:KSaT8higJ9gwcxMKzaNQqE8h3ivEg1HByeStob3dIgEZ/HxIGQQn3XUTAhekbbQ80anOx/B7a95hJfAxqjKfvRaXJ20VJHhybTTyGnmtoIThwhQx93FC2s+G9Yac/HzG
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;3:L6WYevelweNKab753TixKHtwcWKBCXLtBC73J7V+bQz713MwHNSco1GZUJoPuYXZ1kEvE/V88Wg4HNkabBl4CHN1EyiU7/TpbV5/PAYzXQdoIGfIyEgDNst+WiPPcRCriwfHLw2Ifj3V0MhwXmN7jfTObCzC/2RysgYqZqt7M92YgAhQw1KXLLXzyjB0z++qllScccAvoUcrRDlARHeAUi5tTUpttcECaWyKnOmUzEkIlo0apUtTjFlUa1GXaBa9CpA0OZWBkBPBD3obRHI+dEmaU+ke/cjVJpVwK5KmjoJPcmPwrLQwHK5pw56U3HALVU8CR2QCFpdyzS75iDAKfTB//FJrnNnRVRzCUs5ZWD8=;25:IzB6GDy8+mQBdDyBOyqsHByAoyTd0ONts/PuDdOhTXjYHYWCpsAN4o+WhR9RXqRRIfBfGhWGYdP87Isnq3Ei+bwBfLsxKXyHfpedExcMGFU7YL220nDDCaayKXF7QMwSFJhXxlcfY3E9bi1HqT0ZTLrGmOncYzOFvr2db4+qR+uSfWdJuw5tPkX9Fv9/BXwYldePKGYRxoL6u9ZnrpKglPyclcCfrHIj60NjCf25hSMn2Qjj8ub+vORZ6+KBULhMHvWYAjX1yoWGBRb0UQBh33hS8o/EQvyXSSuaaQlza8dYS4OfOWLF0Sse1dlWTSWoi7S114MdhUoI1icRCEgNdw==
X-MS-TrafficTypeDiagnostic: DM3PR12MB0764:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;31:rk0sPB1kIKx3FJpl/RThDYaO3mzl+cxc1ZxY8yikcKDlSfBl8WjbAidro8AolKtKC2DtbrZE5bmKDUnxn+E4Q84yw7eTk/aNFNjW8/rYTAmQQxgGUZ/AEPAOdo9BbCbvMkFG4KfzHBdt7PaDDLkj2fXvadsW5apniq8bFKtiwl8y4gPmbVq4gBIq9UStYWUte5TvGPssr1qQOXtF3Pt9WMGND/5hGuZNHkjT5qnwjdk=;20:SMYBgSSNjR8gUlplgvWh6BXpy962UW3eoJKrQ5MOBljm+6C8PsAMvZF6ZfvVA9miE2jL88p5N4hgpSbMkttO014hZusp3/gp31/vwRKevEFXzany3BNuI7G8FoquGtUJVRmd2cHe8Cxy0jokoiW4va4Jm3qOmv3iPqEJehn9jJgX3/GU6ur03BpvoYJk0QQiGgM8X9fxU32HuiDPb/amjPkZAhRXgYjMSxzBcfnXN/z4a8y2Lcb5qbGSFHO9VAtnGiR4NFtU+6MLOrZAlqUBoSkflT8YJ1PuUSuGD0W1Mka2NtYOGsIsSzChonTmQeLsuKpygvjysEXlvE0YCXuuMN8YdiBmYCM6FrX6Q5qXR5nX4Ow+01/diTzJHnwgvoTY5odvowmJB53T7vfxMItudAjOabTD92XXbXGyZ2+2INh6igYioEtcypdQKXCktKScBj8DENKa3jVeh1rE20JjyhuGuZzb1hLFswJ7SoPCDHvwB2aNKzwOwL01PUuADnP+
X-Microsoft-Antispam-PRVS: <DM3PR12MB0764BF60FA0AA5F138B2E05D979A0@DM3PR12MB0764.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM3PR12MB0764;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;4:L15Tl3tVBl2iR/sXkD/ZJcJyTlI0W+vOlwPlYCUXJUo13vQ5+x/Ob81Z1C7P8SGPyn5x4wdnZtcAk0sHqGlFkU9upz3UsNQIPtD//76QAEjHdy9+YKiqzrsSyW7WU/Uke6zaDOO73mf45nncqSBCUUyb0AJGh8EqJnPcemBIRQGv52hfRduYKtzQX19GzNAjvVrgPa8eppHPJA94WFRTlYSxriukm+O45/7anZdt7zdQR8l4qZZLPAEo4ahGmsWGyGEIgYRQQuNgjnJKzUhWmEK4EgxEWK2pI4nwbnfqRzWn9dgVfhIaHxeeHDhu8r+R
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0764;23:cePnRCyRIFbD5GTmrJ28m01jGbqBOcVXyT51VqIKA?=
 =?us-ascii?Q?erUNkoOKR/5SVRI76l681NNiTZAEzi/t9JhPf5eWaViI8UOdSOBBbLKrd08H?=
 =?us-ascii?Q?4OV8iTf7My7tnPDy3UX0rYm8TNJQnIK2X5WxOiuhHyE6r+oLy53qa0T2S/QZ?=
 =?us-ascii?Q?K6fkX08nYfzYfU60GDxZ9ZRoiDTGHcWNrj+MVa77hr9+aV9Tp4MAuCnCHWL+?=
 =?us-ascii?Q?uMjZhY2pXL9jlQZkJjRTJChiUFABNaXlfPwsqPSDoi8ZHD45b+aA47DTviLP?=
 =?us-ascii?Q?34Xm3koBmpj6gBcs47aKUkfvLVH0tLj8nFPgtfvDQYTA+r2vyT3LnjSAl/U1?=
 =?us-ascii?Q?C6iY4esBNbnrw1CB979nllS9Thbxix9lYYp0LO4sp6hl636NL6p3D6e3YjM/?=
 =?us-ascii?Q?RZX5pNh+Ewh0s5hLoo4ewnnyD98/K0F/yEU99OOhRbGDXVn+GgH4EtdlGuTn?=
 =?us-ascii?Q?r8VrfRsDRbBNOeuHGQ7PUALR1EbduMIvrksq0zpefoYo5omHTXSnBVTJzXEC?=
 =?us-ascii?Q?ajDApEqmjmC8S7ms/8JHi7QiqLVIxASCiTq2bW5E7s0JE9pUMt3gMtx6E50m?=
 =?us-ascii?Q?YRpex6IPeKTdp6l38DkUxnVGYlNX+l0Jbbod30QDq/tKcivQXaAFwAz4UyzE?=
 =?us-ascii?Q?DSOPzYo09aSJmbb5upiZIYDBWxpjRtr/yok9cpLFtYKnyOjHG0Br7dmveweQ?=
 =?us-ascii?Q?gjvY5PGmcrQX5M7J7mI8m3hBW6Fj4xsjmho8FfPoIJLvcU+PlJzkVkuRpsS4?=
 =?us-ascii?Q?Yd4c1rcqfXVOJgikHQeDxYDrjs/ErxzTwebmCnegK2wWt84NpmGDHhwq7j3A?=
 =?us-ascii?Q?3tHyRvjscFfnir1rd2uWfeOq7a9aX01xNHWfuG07Yfr+0JBEZ4UXMooavOgF?=
 =?us-ascii?Q?mjmMkCyG1xKFjCVkFZtHAEVbkTyworC3YgEXR6Lmpelly4Ba7pZT0WOXtv3N?=
 =?us-ascii?Q?T0BF7lMoeY7gJ9JRZr8F7O+BojcI6jlaEPHho8KYsiWiIWSHj7eNOlV+JIK4?=
 =?us-ascii?Q?ULbPU7MhhKtN2osx0WrS4hh1JxfoY+z+620WaYMnbicLdHkAGr3PqFcWqmse?=
 =?us-ascii?Q?rXsiKj6W+Ns4YkAPieK1j3NS/6dciJGD6nXuGGvqr9hBodYlSnmlV2cQ0LHT?=
 =?us-ascii?Q?jVT0Tty32AUVgpAzmLP5PdBc7D1F3NWcF1RmasZnnFIVxx+JkuymzbVpbiCE?=
 =?us-ascii?Q?drz6DxypqPiGIOlYmCYXmWScA5kq7XQXLmXsymrGOrsiqFVGc52WBqi/66tY?=
 =?us-ascii?Q?X6eYpTMEVKPtxvlW4sxX1WpWEW6bBQz9W2oTF06l1ZMFh31uyCwzuZPqQn7s?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: JJWjOg6R7LmQMKb2WD3pxWhACWycW+SOCTKl8xJ0Sg1Wj2jMUJqMIhDWu8XDh7yvmwNueQ5RAZJX331maGCPyAiywvMa0H2bDs8cHgK7qF4yu9w/ZHy2Jm13tF57/FsBebZrx2MoF3AjAp73zUJlukm/Dg5Ar7YaUjAviWqVI4BthMcx3/59T7Ia+jSbxS4O
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;6:LNRRabcwWnWMeZYqKf1B62LZrn8KQNmEqAf5QfeYHmcP3KcMOHCrVSpWRpa8ofBgmjRHDkiP8DqboNEZ1PAWBwpJaL/vgczfl1+hCzhE1sKszOgC0j1CWWp1MobrmuSdV1KK8yiSVfJGaziyI+whGhyqtM1rYC2CZn4KbZxRDePtuolcRmZ9/PzB8GrJf0Wpi/8MoRAaGFyXclnIzif3vbAsE/YgEwEL94RSi/rU5TDJYth894PDqh8I3qjMdek5ikG3e/3AsScTDtsEY9+7g2cVhFMiLeL/3BRouZU0xW38v0imGrOg6NMFTLzQQfETad5gvKKsuoXi3cZmVEPR7CpkDgupUdlOOgBo+iq9u0epmbXD5FjwuXVgrQWrKI6dZFfpJTpbmS2HWNfA2vwyI9QbbFwbWmhdsaI7B/JXDJqZ6Y0hkuHedTpFc9PebT6DYEDUUEejJQjU5AK08LMSuA==;5:6D5EwQWJkYOdTsnMynMwZr7j2KMKp6yTlu61Tu7tGTBE4qrCwm/KsBQr/ZEfqNmzRmZCLupboj6okKVbyLAFnIGrRS8ZlTnzs9ykA6XLKP8zfIb7mD9xwY5/BULuRhfo9cMdju/FYbLB9B3xaNGwEnOvaU52+vG4PpTKHk8mH+Y=;24:amkD3KvMSTJUscc6oLTftKXf9EfPfM6Y4ee7UjY22dQ+HAIHYTYHtS8/Y1EpydhOoRQrUBPS3r7sG+YGtFKap4X5E0HO8OODcGJ1ypimaDw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;7:w86VMaUWYQyAo2QJdT/KuSUdkrRfem3AwKkgS/aM/ZpKgJBpKvH7uEE6MaSkOi69YDoNyxsZrFCgI2JWac4jL2yuL9KyRYreB3zMdft+bvuQMNFbsEUkpV2QVP9YqvV5cjLNMKF1q8tc+W08pRTdLfbXYQw2a9kICZH2EjO+H0ghcnGFfnuztWwQ4TOLfUA+TWk35oMBBaeaunBAwrgaS/zjay4hyH0sL/VwHPAXGhi9VuGe9x/INw4o0sBkxNvB;20:qiJO5rDtrVdRC6NwM8gsooEww57z5KjGrDiev+98FX+2J6+Klnw6FR8ozjURWjGfDklERACp+70kN1eeal2rCWmbSRj8v2bS2K9dfwhHWFPmteCUgESwPqVf07sUV9Ex4bDcESOSujmLXx0zJmNU9vY05gQKRn3b7pzJrGxqNFyLZ1+ijx5b1y/W2BRtCAOvqi2WSAL9rwPBuHkdKgmdM/9ivuPOGNYZGQXUe107pLUOCvYFZ8nmSFlwp2B8fyn/
X-MS-Office365-Filtering-Correlation-Id: c76f3352-41b8-42f0-3dac-08d5b49ef5e1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:48:36.0179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76f3352-41b8-42f0-3dac-08d5b49ef5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0764
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869990217577157?=
X-GMAIL-MSGID: =?utf-8?q?1599869990217577157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: defined i2s instance macros in acp header file
v2->v3: sqaushed previous patch series and spilt changes
	into multiple patches (acp dma driver code cleanup
	patches and bt i2s instance specific changes)
v3->v4: Fixed checkpatch.pl error
 sound/soc/amd/acp-da7219-max98357a.c |  24 ++++
 sound/soc/amd/acp-pcm-dma.c          | 256 +++++++++++++++++++++++++++--------
 sound/soc/amd/acp.h                  |  40 ++++++
 3 files changed, 263 insertions(+), 57 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 133139d..ccddc66 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/acpi.h>
 
+#include "acp.h"
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
@@ -44,6 +45,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
+extern int bt_uart_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -143,6 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -153,6 +159,11 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,6 +174,11 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_dmic_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -266,10 +282,16 @@ static int cz_probe(struct platform_device *pdev)
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
@@ -277,6 +299,8 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_uart_enable = !device_property_read_bool(&pdev->dev,
+						    "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ec9cab3..906eb77 100644
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
+bool bt_uart_enable = true;
+EXPORT_SYMBOL(bt_uart_enable);
 
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
+	if (!bt_uart_enable) {
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
@@ -714,11 +769,11 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -730,7 +785,6 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -754,6 +808,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct snd_soc_card *card = prtd->card;
+	struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -761,52 +817,109 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
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
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
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
+					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2ssp_stream = substream;
 		}
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
-		rtd->destination = TO_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
-		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-		rtd->byte_cnt_high_reg_offset =
-				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
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
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			adata->capture_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
+			rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			rtd->destination = FROM_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			adata->capture_i2ssp_stream = substream;
 		}
-		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
-		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
-		rtd->destination = FROM_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
-		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-		rtd->byte_cnt_high_reg_offset =
-				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 	}
 
 	size = params_buffer_bytes(params);
@@ -999,24 +1112,39 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
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
 
@@ -1024,7 +1152,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	kfree(rtd);
 	return 0;
@@ -1078,6 +1207,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1134,6 +1265,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1153,9 +1285,8 @@ static int acp_pcm_resume(struct device *dev)
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
@@ -1164,9 +1295,20 @@ static int acp_pcm_resume(struct device *dev)
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
