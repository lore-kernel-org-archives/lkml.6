Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqgW2x0FJWvT7u8Tdz5RJuyH87iCD84ytLGowbA/D7JZ6EcTGpfya/SZQJQU3VINkwS+H3K
ARC-Seal: i=1; a=rsa-sha256; t=1525208001; cv=none;
        d=google.com; s=arc-20160816;
        b=ZEiKRwMlNYjrFVRbKLXZ8zJ5x1nqa3epP2HGuAPkN1f/OGdAQzUKYRMjxyG/ftYu9A
         gfMHhmEBW2BDRYSIlNvxO5CP5rH8JnSbg0A000Hijf4b4QTeXAnn5qxbAaUSOwPJw1Pl
         er/gOGLZmYMRC7w6qCjDvx0276ZFjvYHdE0EwlvGKpBUnUelzK9vc8V1ZIRlMthS2ORI
         JG4gA2vLWitG7p/azPdQQrp4Wyt/LvFwVj0gvtvnvER2kqK0vfp3qf/JpnbMMKUD3pmn
         uXHYG9wilxTSxigwbSF2f8exBfjbeRop91Fira5zrqOZi5iwt9gL+0u+HZWDVa+k+uri
         3jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ARbyNClGQLxasWX8TDmWHML0hSfZRbo49BKFui1e3bM=;
        b=n9+a9fzJQszVHwWa6j3i1gE+c+HMA9TeYAr5Wp+lhKGKLpEspEIOHnI2MQaU1FC1Wm
         H1iRvS5uzy9RlEWXOujtrboXt+VCxL+UrJefPCOWvxKo2HVaCnxjHzk/NsOgfOWPvby+
         MxCSh4qtuwnk8rFDwsElcITaZPlhvIIQrZBw2LtHPAKGQLpKCEp5JF1UVzU1uzuGBfyf
         tUhBLuLXXxtjtG5sRR7H+KlJRd5yOiwl+HSAbPEml6S1x7iN+7QX1AMT0+6v/5ZM6Stk
         dZBwFa1AHmk16rm6q8CdHLwf9L19F8aRH5BRGlemkR2biK/nDn2YIg3i7aY/XVbbiqFM
         F22Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=uUDOPbCM;
       spf=neutral (google.com: 104.47.36.81 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=uUDOPbCM;
       spf=neutral (google.com: 104.47.36.81 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Agrawal, Akshu"
	<Akshu.Agrawal@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Alex Deucher <alexander.deucher@amd.com>,
	Daniel Kurtz <djkurtz@chromium.org>, Wei Yongjun <weiyongjun1@huawei.com>,
	Jason Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
	<kstewart@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s instance
Date: Wed, 2 May 2018 02:20:04 +0530
Message-ID: <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(2980300002)(428003)(189003)(199004)(36756003)(81166006)(16586007)(53936002)(316002)(2906002)(1671002)(8936002)(356003)(50226002)(39060400002)(109986005)(336012)(54906003)(77096007)(426003)(81156014)(186003)(8676002)(86362001)(575784001)(106466001)(76176011)(59450400001)(7696005)(51416003)(476003)(7416002)(5660300001)(478600001)(105586002)(53416004)(26005)(68736007)(486006)(305945005)(48376002)(126002)(11346002)(97736004)(72206003)(50466002)(446003)(104016004)(4326008)(47776003)(2616005)(6666003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0767;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT025;1:yBpfZ5+KoLtNxbz+btRFWSjGMgusWHVd2Q3fNtQAQ1264aOgoR/ACf6iSAOoL/9o8BVmR8S1ATzMA5nJ7+dGKZ1fzSaNpn69EE2PwPHHqB07rohubdTfD8v0TcgVdhTd
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB0767;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0767;3:f+9X3kqr8uCqciE9nDZQMN84Hvsptcljvy7p0d9Hh0qAr1SGAASJmbN8knCyHODwt08q4hQHnQ9U+6wnt0aLI6Rl8ANg8XXDjvKMtE3vjpNfxhLL9Y7gFozElanEM/q001Gx9SWGiNAO1P9epgFjZ4uhE5F9Ty6D6A9PMYMPX9jr3ZW9/x3Zrjk5iAoQbU5dVnskPvu1PyIGoHINOUEjIvkCAPBru+HAKUoMxc86VGTU9Wi4lvvaYrC4tQKuquoUpUHA0YsMboHbU2UO+zD7AGrgNnHc6+BUJRI17Ud3OQ2ABZGP9C+it125FxPokqLvu6NcpWtqJV+Gm1YNxQoEocQE6Z5Jp4KQeOBRrDidI4E=;25:lXB0JpswJgasu6mxDFxJ6qx8OJ/ijbY6qKepqBp+dYB5dD5rVGT+6F4K9xRvsYR17K1m7x70a10JU7/LrNEtmEMUtuZa+ZWzJhJHuQNzgrXfvtYqnYliFePIW7uVI5rVN2uy24qhzQK12P8uhiKHlTrcZAf24NzVvnq65sF6OVgisOWhyV+ZGdAsrOlcu9ulWTg73Rkv1ief2sklaKdVlfJgnn6cNwUbTbQ3ALl2v4E58/P+DaRN1qauEiXviPbLmv1au0avpYOWsSzuvb1/0YY9ocwV25xIsGqpRerOOltaJl9YffWXpwmh1w/CD4lGbwNWXQV1qbHoSk9nW4kCpA==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0767:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0767;31:0csxPVHJPOzUTjVKfQHFWm7NLWbmZAJJQT1H1UqvL29bvInGqHx4NIZtzZ/rBkQzRrKuBK1L/WNS20FYXdk82ANF9TgCcrQEwKXbqKxeG6fDYeksC9trOu3s+3qn0oeHFqtonIkP+BbkWPnKtn2ZTlbrOAFS+mREMNiN+cJrz80tIw8HG5XaJk4btaWui9yDB/qD5+L7YcZ/ArEQWzu+AeRqV9McYzQT4wbFrIzowoI=;20:mNoDy/S5j7B0dfnu3qDwSnKp/A+ZbOdaZ/T1MZGG1Erbci3jgVvETN2056rhl3J9DLRVXQaCzM58mQ/OE9raH32X8QD05fMh2qvVODo5oUEVOqjvpF/bSnAWZiMdRNsLZM0jQMe5fxBpMvHLz2s0RAYrQi+9BAx4k670MVtYGrVKFvAnYrE1OwOp8kyIpcVPkkSwcTgd9eOxhJeOZ03s6N2pzANe6UZi7l49/hYrmTE/fRkbqEA2VP/rNMfPeLMACt+43tpB0UXcL7ytXpvPFxPLsw8FwLthmSsgB2dwHyhiBKSgsdFoVekbVuuFobSMLMMA3C8xM6EAV8KJvl+rgnioeou/BXzLkGqQolQZIOmRp3ljcBZlJC88X46us/OIwA5TisPxqqeWfsQ7yfOk+Oni/Kwh0YXtgTXtblmiQgTNfWEtxHE/gYSfwPSTn3YbOzRu57UR0JfBIsWCRSwpGRJ3HcNIGIcXCY7OmN9qVsF8e9dd0lLtrhi7wgo47Ozf
X-Microsoft-Antispam-PRVS: <SN1PR12MB076744C2296B707D53BEA6AF97810@SN1PR12MB0767.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB0767;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0767;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0767;4:SE6yCZift17EZJUoHUbJT0mPeobr3MHq82sGkdNn6IyKu+/iJVrv8ahHSDKptWg0sQRooS+iFxkPB5QZUFcy+9sJ2G/NBP7YJb8wGrF1zYMrTEDpPsVSj0FMfUy+zqSKtVYnakvL+QId4c/x9Lyi1EfNMG+TmtAMXRtp/UHTb512HuCasHUtdb3Xa71Ox/nelp2y7QpJwE1jgtrIcGrwRjwK7CvQEHmCuglfrgx+WYdEAYt/H4GJWScXnlFHfuRqXw8xpp9nm+NToVuPieQDmF0HWqujWPHjv8JAtxx0FfxLqL5/BkUdw4KQyr/RGYen
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0767;23:GEj9+lr+KHcu3FtJIjgP3RXyTs2rEqkBB78zA45Gl?=
 =?us-ascii?Q?xoJKX22sMPDzRE7ZQokZ1L0sy3eL9fLIwp86w9IuW5cWU8v5o57G6vphTCAx?=
 =?us-ascii?Q?N8okTH7jTS8inUzAV8lXYxS5AUavHM+bouOlHhV6EM9HFad7/hD5lkqO0XSh?=
 =?us-ascii?Q?LTUGZ/44RwTtYuzuxd0MfZrQGe0feKm+ssUlaJ43/GydPJJPCCagGvCuyqer?=
 =?us-ascii?Q?i7sg+IWQandTOFVSKTrdrbBDaQOOOjLVHLbqRNX140KubCx3DaIyrxJn7+vp?=
 =?us-ascii?Q?rpA+UkHOsbqBZgCEpbq2n4OUQZ+MeDAU+hO6U1JAVz66CO187NlRS8JbTR5i?=
 =?us-ascii?Q?xsrof8AsGS137DZSOcLr4+CXgrvoyFK9bQIir/0KgxukpH1WFGAS76lajGYN?=
 =?us-ascii?Q?Hb4ieCFCI2NripdUIIogdYAV5B6/KxnRPEBUDrJXR4oLGyCBPwlH11MS8miO?=
 =?us-ascii?Q?MAkIAjyMMHuAHfZeLa21rEeGK6fHgy5/OGPykXvhj6adbstceiYWLo7e5XCy?=
 =?us-ascii?Q?zLwt6ujTrZ7OWxP2GRpFLB+0KBZ7xCIeYxLG1Dnmf6Qf9yGo9ffzxtmEi7bF?=
 =?us-ascii?Q?TvJXldBFOa5579BF8nbq/+syhJcBu4T/WYIwQ/k8BRs51syZihMBb95SlXES?=
 =?us-ascii?Q?zEk4ii4l+WVjIlPDLWtTOYrw0njwar67PO4S9AMe9nUkD15uYl+PVTwexdaO?=
 =?us-ascii?Q?tr/HtITWrVMup1KerZTCOGcYfO6RxR1dBFnavkbK6O2y1IC+sewq68Vihgq8?=
 =?us-ascii?Q?UwxJGjoJx1yUcpolmQ/q86Uhox7eZGP6LBhdGudVtzuVo2wSAlmZZEVXPMcI?=
 =?us-ascii?Q?M6Fk6GfWCyZSww5/3fggt6HgoznsuKuuuaU0Rvnk0Icz9xwgGrE68PkJZIec?=
 =?us-ascii?Q?zJu5wpgI/bFDJawQ/VQ3M+249guMaj9E2KnnUaNF10Hq22ksib/zVxHHVcDX?=
 =?us-ascii?Q?7HYcuCkV9LSAcpsspk2Ag39GhcnWvH1vepVlWGDcF5Z0aUnYsYWe+oIWoc2Z?=
 =?us-ascii?Q?ifkQq+a7mrKjo+VJruaNbtTbtoGu0uNAFNu3zRYEL3KrBmDxf7fz0FVzRgu1?=
 =?us-ascii?Q?cH1j5yh12Mdniwd5nIWrkX0fCzUBrtN+nXs2xAZkwhN6PLECp6S5ezo/CtOY?=
 =?us-ascii?Q?12llKIwW8jtLKqabg0nME9QkXx3ObUKjTIV32Rl3f1dHY7+JfEaXscasKjyw?=
 =?us-ascii?Q?bvGIrgJN9VqE7M1QtKhRVnDkT/RwLXDDgOaumpc6CicR7GeXe5OXoBZdzGSR?=
 =?us-ascii?Q?1EHTMu2utFdIr6kHHVxif6+RhXmZyu7l7UKbE4a0EK7JV5fSThaF7iitRufq?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: XX4pw96ZFaxC+epDfUp6vpiZPHHxY7u9fdVIPOk89bleROp6eomlj75cUcOka/6t1Vw4v6R7/pcvHGKX2Rz8E2n5hMohVVaG6cwdiUcAb2nVxuoFfyA0BQd5kfiw4LA+ni03v3sfbdXKlT5xiX3+6tG7tX3eqO25SNR8FAS36z0hH+62m/dR+Aj7yjASUQSS
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0767;6:eYFhz+Q/2Bkznu12C4DqAT26B8i9bPv3N16cx3cG8Zw/ToJeNPB7eXohnrejpgZzkd3M51/O/HNqbWk7Q8RKmQWBausV4xfe07RHJifS0q9/14gMOBY8WblTGklNDhTVEbyyDmRtNaXbIp/oT56Dbn049Hc2VBC2HKQBxFpFpccAG/4iT+XStbuAq6iNxOgnLB6qKy+5xhqKoIDxD+sN7q2wN75pQZTRS/6XD6j+abPgNRcRbZiyiP5qKmwCIuE7iQ6Jdyh0JIGumKe80+aF+MugPj7ICUq8P63ZQj1N7aLl3D42retBdPm94yS/s2ZAuDER0d/3/Kq1tiybg1h4DxCoFDrdHPLgDKkMRUilLk1utmGxh5oLSsf6OVftzxvkyiCIL+dv+sZer575H2Bvo93mTPS5AMao7daCYw9jszzga9gLMILLhTnrIrXc2OUB+EUnWb0TP0Q+lc3UrcatuQ==;5:94BCQRhrEjRd+zmUDQXyn2KKJ+q/jFXibcVsObq0LgL/4pjuxnMA0XCcolTg34o+ZAjwfgYUPmndGCW/IPzBQg7BRvDfZOHzdOMVguUyEj9xP1TLy3mxB8Jj6iL1JKH3LlM9bWsXeqN1V4MMgOj8nILDKIxFL6gK/JUFR/Mz2/k=;24:judMU90PxUDEEDU9LY02sbHeu8ysy6qSQXZMQSfrp2lIpSGyHLGqD/kQuuHzTQHdgABgH9rJP5utDBge9Is97fC8uBDwXfMKnh3I1kyS8Gc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0767;7:FGxcU9UurNZ9y9HfojA51Z2/+6H9TCaTpnUC9bbJJmT/QpFnKohuV7YC0fqrcTb/UrxCtp9fm9qRylUjz36ZbG1kZ939poJyslO5VNRS0QV0Yhp54oGbqEZQZ5ioRn8SYf/bZbDBiAZQk547LGokXUZgMDORMMqFz+kFsCmsXSrRi+wLlF7vAKumLaaxyHgHscNccnkeRS9CRG39dCuF9fUATXYjpfkJkJbCYfiJIu1hTcXFauz8FstanZwtO8Ed;20:dQiDAhENB+j/ogwbRVPI7utr/xLsz9UGszFpMddrPxtoXJPr9Tmgw+FhQ/MY7wnvZk06AmtOLeDFo0wZZFMOaodXTEZruyuevBy++LebCNiI5JnBf7gHwu4CZRd5/TE+Jfw0NMCFqzMBDCWoaytVgcQt/BHrGlnkHB2xqeAfCGqyiTTqcXWr9XqRrToJdjjsvOyRsdnVrMGzeLWhWcZ/+jgQS5DvpsB5yGPpNBuCK01yueNnMeB62CaObxRshmQC
X-MS-Office365-Filtering-Correlation-Id: 0f593cad-e283-4265-c7c9-08d5afa5912a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:53:17.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f593cad-e283-4265-c7c9-08d5afa5912a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0767
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599296505721371971?=
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
v2->v3: sqaushed previous patch series and spilt changes
	into multiple patches (acp dma driver code cleanup
	patches and bt i2s instance specific changes)
 sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
 sound/soc/amd/acp-pcm-dma.c          | 256 +++++++++++++++++++++++++++--------
 sound/soc/amd/acp.h                  |  40 ++++++
 3 files changed, 262 insertions(+), 57 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 133139d..b3184ab 100644
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
+extern int bt_pad_enable;
 
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
@@ -277,6 +299,7 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ec9cab3..2ea103a 100644
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
