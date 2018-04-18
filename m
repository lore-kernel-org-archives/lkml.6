Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4/ImJiTkGFt7Kn/Yt4EsfC59vu4L36+9JLFh+ga3pZQCdIRqSAso6EfFToecfke+sQ5WXNW
ARC-Seal: i=1; a=rsa-sha256; t=1524049409; cv=none;
        d=google.com; s=arc-20160816;
        b=bBjTCPnwh71OynhuiJE1Kb49C6cxXKTPHdV9PSLlzyzuiPee3vRl1zuoPzpZmY1yUX
         Uu0gFrOJAbhdOb+xLIHS4Hd9axBEdLYyAnvPslHGV13qPbJy3LPCgZUaIKPYNNnXfCcg
         vJmeew+zjUHGuXoR9bTCR1bVGewAiQY7C9OHrGjjQ5TkOs3E+ekUnnhDxqq9NxdTj35L
         px+MVSMBN7FY6Rc3CFX6aQRAYaXtjLipQVRPxcCL299U17TTeRWAZAJxSH/uaVI2cy1K
         ye32T0gV3eT5D4P2SFzq7bbH2CPSBjZYt5UNT6OK1mrIgKD58aENMmWXmNHWTm8zhkTi
         UZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=DapgEGwh+Ii6Ebhsc0sp4cuxkDJdjOrWdU1/EaaKygA=;
        b=oROvh/SkxpPJfKlv3NUdwqe8eG7cJsIO5cSaHJrdwYsa15OjI1GUqnmcRIsxgVWWkH
         RCNxx0rXIVwM5NN1jdNjiwLtKPtuRz9Nc5eMKIHHCHTrl7he84j9P1l31z8XdKcWNxSM
         SNKO14Ih9tlwaWunPoMeX9FWygDjHdCgfnonC88ak+ycSnI44yTkmXiHgMrK8IECnqWO
         MuGnLcfzW/XT9pEAnqRmIU+hYAHKgMcXXRj7dYRBhALLqpXESm2Q9PEHo6ZjYIYntZFI
         jArl896qqKPXPM6UROC4kl0ZrxY+eNrHQpMdAxv+eL/WzCnZKj6BuuaiEJuuRVAJOjcj
         mNNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=y5aeCMfo;
       spf=neutral (google.com: 104.47.40.56 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=y5aeCMfo;
       spf=neutral (google.com: 104.47.40.56 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Dylan Reid <dgreid@chromium.org>, "Jason
 Clinton" <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] ASoC: amd: enabling bt i2s config after acp reset
Date: Wed, 18 Apr 2018 16:34:54 +0530
Message-ID: <1524049494-19526-4-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(39860400002)(346002)(2980300002)(428003)(189003)(199004)(9170700003)(8676002)(105586002)(446003)(478600001)(336012)(106466001)(486006)(53416004)(2616005)(476003)(11346002)(126002)(72206003)(1671002)(48376002)(4326008)(36756003)(50466002)(76176011)(5660300001)(39060400002)(86362001)(109986005)(426003)(54906003)(53936002)(7416002)(16586007)(26005)(186003)(6666003)(47776003)(2906002)(305945005)(77096007)(104016004)(356003)(97736004)(81166006)(50226002)(7696005)(8936002)(51416003)(316002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0330;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT025;1:MRpuiXX/ykPhCc63CIxSkojx4P5UzfdTO0prbhTFu7AfAiNO2cSm9g/9sq1c57MX03zjcArhAqNpbq3SmGj4MDTVxPTarOHPfJtCTTxJ0R/nchRSnH5sCeWTkMVqu/3h
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0330;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;3:tr3pYNYZrYqxL/VK1bruKvAqbo1j0nUHmCZb1ubJfWzdC5WafojPUo/7iy/kNqTsNkzIg6o5wQjcSgKypzBonraywFlTMiQ3nwfEHyAexDVjvHixVzoHFf5av9oNwtg/rdXR5tV7reB+sFEkyLrqif7RAcs9cwDAVclh8Zt6FIv0fwnwqWrTjMCOpi2Ap8YfiUg5Xh4IR2U2XuT8MIkyksIHI4znIQHs+TcUWYz2/9ogK5F9BykQ4oiik25OqYXR1u/LRigc9DBsyRzZBy2XxCJWXI4F2PRTvVh42ioyh9QolfhKK2mDd1oLB9rGtQlbOCFhe2Dn+0UQWWwHuR5V0kc6Mxshc54WLcVA5iGjpOc=;25:6H5bZOTiizA4b15bMQwkEX//Z60/O2hsvllaO6jTGJyCaZcS9PmM6nAXIU3Cz8zyWzLohg93ZrrW4oaY9281bZcs83SR1ZB3AvLd2Dj2kIP6R4dvmsRjtUP9fjEr4E7tOWeoIqFTik7Y4VKKhf9Knhu3k4LN6u7Xrb1gc2H5npDr2WXpi7dRMjLB8RGs5FbArvrxf3fL1l0qdCYzFplAkwjEIRULvKSgYLnFZh/+mKPE8Wc8Zh2XI7l30MruxzM9QIHpOly7EupY02GGxvJ+UlJRch8T18CgUkJBPakheqW6/xj3ddPsNTlKiARJ/pBa4/FR6OeFfETnAkXaEqsmY+jpIPlfpgs9wpYuNobTB58=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0330:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;31:+VKaknHSRg+9pmB6DXJo9SkXAuZcm61bqhyLYowKLK0upmUEVXNfCTCiqmvYfm/8guVpJw7Dvvt9CCPWy1+wdiZoyH9W7IRCbETNn9h1pv+CsyD1Rcub8nKKRRNROaYhcazmeqeKEgA+oKC2GLRHynF4Tu6VhUbFxcVrb1tye4YSIRJboCCLRzlEH8UrNLCUi9hvZaNhS5K/OBrA0ZOoH80MrYpu2KVVJpKT4/klU/o=;20:R+Ka+3rgnDWV0KnazzgYrioeSRcO2VNT/z8/Z/KjjhMfNp84LnjD4Ci8rg0idQKSOzGsZNDJqU9lzrqDHKo6Rfcq8+AO/6VRpJmg7mpJD/jGYVIcYr5e8I30fDilcJafyid5TOG55jfddgKjmk1AnctReDrKippPwqux7rbIR6z/6rPn6dlBBy5QHk4fkBEovql7EaMdrdtlV6oqCS4msXirEZiThRhCrGuoso7EBqsV8Z/9p33RzpDNqR9zkYB5HmR1Y17+9DXz2v08enCzklGN/K2fVu0kgO9bAgMaJVxb8yxXHgskP0DmJzqw8Jkmm4IR9ENXr5c0/1YChevOXGQMuBW8as5MLGtBeLXQioma2AqpSS9R1+ZpRiF7X852l/0R+K9xyDgssvvVuYUPl4U4YhMdbfqdYU955x0TLwKtsmx5jyQ2cqlKZDUC2m3cWEnR2OlKmt9SYQztFC6PG2JVx+LYnibKt7gviHSIQW/R0pGsIeMFlZhkDMZ2PYbp
X-Microsoft-Antispam-PRVS: <DM2PR12MB03300C37BF2E59BE0CB260D097B60@DM2PR12MB0330.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93003095)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR12MB0330;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0330;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;4:0UGu+Srk0b/NZCtFQ5d9pUD278olsliuFfLatkg649HWcJogZCtrdJpWg1etib06bTBddiL6uEkMgIRCaNYviwPw1yzaw6FR7QX2X3wsUu+UiQyedXHdyEdkBTlnMyf+cKlYd88m3AtsVU4tCOhDrwSJ8hgcYD4IAJbklnc/BaR/OFjVD9f6J3zT2fiGm3v+6SKXF0jfwE6TGYj7WIElx+T4PRXTULiwEaHJNsxWDZ4uXLiKOET+TQuvZ3QCMYiA2WGFqn80sfTCNniGRfFbMeVPMbhouMC57Xf0BQW790bJdB951cqoVWfNpU1vqg3i
X-Forefront-PRVS: 06469BCC91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0330;23:11wytHBOaS6MYsMkX5dK7oA9AGXfzkXz69IBIaYDG?=
 =?us-ascii?Q?62E0A9uE/TF3zQx3rgulAa8uUDJHv1UjQCP+2LY42KQIrHTH8VLioVpNxOuj?=
 =?us-ascii?Q?JOrm2zoP9LQG9kPZElhjEQYo4x33rAj86c1nL5dEe/8Ull4r5/ooRbeN7S1d?=
 =?us-ascii?Q?ylTV767nuCgjLL9L/ocPzAPtxZA4W1yYvvcTNbXuAA3OVzYeN5H58JkzY7Gc?=
 =?us-ascii?Q?FbsRhdQ4cEAw0+8SMJ6WcPbEzHuKMt5agkiUA7p8KN6krFIXQ0rWbSl6rEiF?=
 =?us-ascii?Q?CPD0MmGxnQaIEpWIK0WeLVlsW1/mlo8b5n0L92Vb3O9G0XMKLIV/VeJHLUC1?=
 =?us-ascii?Q?kJFMcWpdWXlEt+QnExVWb0K9joBzDbSbtkCVYe+wDPCUv6ioMtWDYz06u5/N?=
 =?us-ascii?Q?wG2S7hkoJBu5E32Fo76boCzv2Te000TIumcPlTFhSfcTfiwcuvMBTVio1xAu?=
 =?us-ascii?Q?wStmcolTW2EJCfomOSxeXbRSjYbvtAdUneSrHDEetaRtKL5IBfckapVE79Eg?=
 =?us-ascii?Q?OtSYTHRpj2y4Zdl6s86ocuRO1SQNaE3oHDTbvxO/OjHJTmxtwzUYMVz8Lctw?=
 =?us-ascii?Q?V/uDUcNwWgYBdhfuKzK9lVan+gxYz5OENzzZbYMT+0dIoPqudWxY6sd3lAy4?=
 =?us-ascii?Q?/hDtbBctZUyVXQ3psizRVmj2cSuZlMfwSyYn3JJkr4C5b/4egrKP47kFl6tK?=
 =?us-ascii?Q?uvkdMt+GvmAwoCBOWo4Ouc6VK1+GJLZJJ9ZuxbeouCUJHff/DBayQlndsbR1?=
 =?us-ascii?Q?2Qa/peDTHqrPjTaxlg4DyoDxLNH0pr+o6RW8rj8voPuocnp+qSnFSpul3Y11?=
 =?us-ascii?Q?K2KNQNa3FwKrIlKFn4Xf6NlBn3T6Tzeq+Op9kbHQrlT+J95Clu3q+6BpoOih?=
 =?us-ascii?Q?RogVuedJ9FhA6NlxgEncz4qNOPFpg8boGCG0PBOSZPQPo1GXAz6C42US1OLq?=
 =?us-ascii?Q?eP9j8Fk+NQbgnBnRC80cf6fpiXG67u437jVIaV2WRXV5epjgsKLrRGW/bjkn?=
 =?us-ascii?Q?/cG7qBeVwSeJVTR+FAQA4AWzX7sG6ZqJ258lBsxM/pIR+mRFvfBAswE0ABbN?=
 =?us-ascii?Q?dvPFymi+Weq4mWyP713ifHzRHlkl9++Wp0B3hJfdwIBbfLj6pJDDvOXcwC4Y?=
 =?us-ascii?Q?F0NcaRacnsOGXrrO2BTR5QtikgntJN5v9CI6VX8+OQviBcgPYAuP63QrezXE?=
 =?us-ascii?Q?uxAPCsQ3Wxx2Qd7jiSx1NL2zGvjZzirufxc6QW1drKcensReLJQ/mhORQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: sm+R2ZS0x50xMG+LnDEWLxgBC+tBWLTW0aBKF4V+ZvBIY53QEARor0q2a+i4D+x9Ddss9zkIM9sJN68Z8vYYUUu9oRk6k8xRSKxRXgRrEOUMpqa7GyV9k7DCIxC9+Q7rxkA8b/yMjsrdjECnQYEnyT8FzevnZwfFyDEOLDLxifdpJeb1kxLHoVxbSYxnUFit
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;6:pNCbHp1hDyT5smAFw5wtwX4kKnRbwNk15phPLV/zB6Exix/F5IiL6qFPGtOhHHRBzkWEqxjLVkOZGwUBllxq7J7OxRLO9WIWzZzQ3ykTAWWIEHuKc6FjqQ39kgwXASWaoRyPSzBY3CdaN/UWzg7fdtlnMInGqCNCuQ4JIbzc3CukT2yYyp1mW98kKz7UwcIyAEPViXXpBmYxrCRh8/E+QJ4RS0HdNhGNnloqUDvQ6y/OcxwdMqqAeUuQviYXu+3CiMvCV7xNn2FBsmPgwkJ2ReABjoGtGcOV35Yiz4DHp5nr/NjIVs2QZ0gyTAYilNbsSgr73RZ5Gy02dtGK0fy1OppBShoIhSmBnk1MIwiZY8lvTb1I36YGtOnaqP4GZ/Iv1vbfgrDPK0zbjYkBd4fITQ2U8M6Y84UHoAbyXBICYQwBh2q+l53K1u87R5N4lp4TFuV+1fW+Dh3t+/sHt82feA==;5:vx+DZuiyxXsQILHpveN35OaAlcmyHpLigl96onFTgsoMgg5G+OWaxcba8okfdtkq+KjCfAyyNCenD0wB7+dA81qJxeD5M3me9d5h0OlkRDWa2Ca+TJYwgxl/a+2BriH19yb8ZGfb8OeNgo0M/YcRhdbVKZmPdbHSrVHTDwB52ro=;24:AjUhq2Zx4JjUY4V/ykXVONTxRR9azAS546gaIknB/pmgdcuR5T9inzTnmkHZ/xAfhsqSPzcv5K3qNPRB2k0KIe+h5AUT/gyLPUcOwYk7neQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0330;7:87vG0UvptNef60xV2QeZei0vn26NSvwvoMbWVx0w6hnOtSy0LRBOWG0FuFPSvSHcCuh/wxZ7kPi12C1P7yz0kmh06RdPce6SCTfU6AbGreTsOZXY3gFKEoPfhqPFr6DuKT4nlhhcVp13Rdcu5YKC+YYpcvjEGMlcYdN9fy/H4TNHc7wLWaggJZHzG3PMeDV44F3pXs16X+WdsbM5hFw4qDr9qMl/3AWScEYNIcEYvcP29u2zdomf3Vq1NnEdKTze;20:NOVjIIA57MpDFCfprBqLtKAN34gjeyWxKOL980n4uwAiTQFwKzc6p3uLdd/ufG5MUJFGQbH+qkh+MWuC/6WBALfAtJYzsjoihceSbPPZxp5vVTclyqza1FL4Noa6YJIYhfB3TNUzXkpIy0+4RJ1N7HigTBP9jFwxjKP8vFoMXhIdm3vO7AY8vsrgchD+T5Bwxyi97WoGHS5nAAfwjI1XPrppjIQJKkZMVFGXWfYLGm+AnAOj9OuoAEUuVCu9Dvgs
X-MS-Office365-Filtering-Correlation-Id: 8c4e596a-56a9-4a9b-ba06-08d5a51c01db
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 11:03:25.0075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4e596a-56a9-4a9b-ba06-08d5a51c01db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598081634008733695?=
X-GMAIL-MSGID: =?utf-8?q?1598081634008733695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On ST/CZ based platforms, for specific platform bt uart
mux to be defined for bt i2s.
By default, these pins will be used for uart.
After acp reset , it requires to reprogram bt i2s config
mux pins to enable bt i2s instance.
added bt i2s enablement sequence during acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v1->v2: fixed kbuild errors
 sound/soc/amd/acp-da7219-max98357a.c | 2 ++
 sound/soc/amd/acp-pcm-dma.c          | 9 +++++++++
 sound/soc/amd/acp.h                  | 1 +
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..9ff2138 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -44,6 +44,7 @@
 
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
+extern int bt_pad_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -251,6 +252,7 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 7c392fe..b52c660 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -46,6 +46,8 @@
 
 #define DRV_NAME "acp_audio_dma"
 
+bool bt_pad_enable = false;
+EXPORT_SYMBOL(bt_pad_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -525,6 +527,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
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
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 95c39a3..520a08f 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -110,6 +110,7 @@
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
 
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
-- 
2.7.4
