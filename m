Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4++AHTUDO82vJOq3DVuNOTCYz+nuscEi4Pd+3noawZtpjvB9ta4il3DfD9/0APkqusY0iZM
ARC-Seal: i=1; a=rsa-sha256; t=1523941177; cv=none;
        d=google.com; s=arc-20160816;
        b=AWGhw0zKK6iCQ7wcUKkXxfHCMUV5wNzJZRyoYaI1r/1sSbx/A7UuLz422qVa1wPr+0
         /sK3amyHbzbkyBhxqbSFTEab3A8VoP0URa4wLRX+8rOVSQEg0NDpPzukXZbBYzjy+/L6
         h4QBjbKbffOsoma/VqXYMvevC1Ve+EQCwsl9/v2gOBVPz5RgqjGIQV9O6o7WZ3va/FmV
         QKpbmtIlO9oXNI+v2/WpxTVhPQuU3HLUxRVSFnMFfJJKe3BSMh87UZv72UAg8aiMWQ5c
         +T55QGmdSo5jUdufyvZqm5bqQKyQQMqWaBpIwIkaBc+DqUbmDqmlpRCldHje1wcjqSq8
         t1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=jDjUHqFhi4Yf5HCQUUdvMTckfNomuus/CQ6y4447rOY=;
        b=h9VL9B4/BV2OWi7ZXSi5xBttBWHpx9t35TMwcGrvB4zgjIQ1uCT7FADVpOi/EVMjQA
         EArzqtKXFNnRN/If0bMEp4KT4pSrknC6lWFQkfdSH5ZeXGUrmCLYGE9ooxcMG+3IhV+0
         UW0iFz8YdjknDMDPqtaJcGxPCNv0V+AnO62tvJhAIr5eEd/+OVx8m+dNBi/vpLFMobCM
         peJbzW4DYZf73wCdxV8Q0+AUICHAiAiE77J069tVR+nckZ/+AuTsfR1UcnR2/QWOXjTP
         4NBTxTfg6OgctUrhax+4isO0OsLaI5R0e7umkg5SrE23cKJ2XfaIwRqdZJBAfRsn8u36
         Rvcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=plq/XtBk;
       spf=neutral (google.com: 104.47.41.61 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=plq/XtBk;
       spf=neutral (google.com: 104.47.41.61 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Alex
 Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>, Jason
 Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Philippe
 Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: amd: enabling bt i2s config after acp reset
Date: Tue, 17 Apr 2018 10:29:54 +0530
Message-ID: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(39380400002)(2980300002)(428003)(199004)(189003)(47776003)(2616005)(476003)(126002)(446003)(11346002)(1671002)(5660300001)(426003)(50466002)(81156014)(356003)(48376002)(336012)(68736007)(8676002)(81166006)(8936002)(77096007)(26005)(186003)(50226002)(106466001)(54906003)(53416004)(16586007)(76176011)(51416003)(316002)(7696005)(105586002)(486006)(36756003)(97736004)(72206003)(478600001)(7416002)(305945005)(6666003)(109986005)(53936002)(39060400002)(104016004)(2906002)(4326008)(575784001)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0326;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT063;1:Fw/JZqKhVCf7lOttpJ9FU1a94K+pjV8BnNmdwlgeDtj4J+6KzygD4UYSbdxLnrdROgjF5rNi3SAqz7o2jgIdaZybkmc9NIZ/pTGCsPMO6a3LzZ3MLQsAJd1+sCeqrCOA
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0326;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0326;3:EFTu9HOVD76rNb2SGzYEHMCgGpGIQprI8KPODtLgxM2LCxLtPNJHKfrRS/72kK82SuM3DB3bVU9Wbk67kgvhptkzT+YiTeVpvbd2HYGVHljM00frK4UDc8PDw7PId7+uiITBdUU/y9Bkh/f2fWMAUmOQRFto4LhW5DOTCOMKb2EkWW7LJhY/4INAEZiEdsfend+1mvr7fgtsPjATI6VfI4+sI+aOGMqGL5g0h8N74fbLiB5cRF43PgwYIseLNrKhKmpv3Bn2GeVvj2XMsuTUmNb5Fm0WXCPZV8f9iOf/LvupmwAjfVwlRKzklTgLYtwmBr0BH10eTQC0dZV/FB52gCSRBHenaGuFyOUI6ZlRJHQ=;25:1g8pAQ+VQwT/komU1Ibgrpbq1uNqC7Kvkr70iFvAyDtLTlKDQjGCEfpt19VEyBtcklaXDyjA2gNUwUYj4+RhYBvpLRhcaFc3lgP1PpO3U+2ui7BShnSSuQ4yKOc1axWwXJDnt1pmm6PdZtESH3ESwCNd+sxy9M9HLvDsgkK5nMkAApO9rGV/Fk29LIWCllk5aLi/kP5lUeXScJSjXU5Gw5QaoRE4xO6A4MoUb2PgYFO4aPoaqweVttX34u9/ak44JcATcRSGZjlfs01QEP/nq9WL6w3JO9PXsupLKLxVUE8ZVJXyqmNFTdAP42VRHec5XvItYwez/aceAVpw/m9eFg==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0326:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0326;31:IJdQPMFEO/5LezG8SYnoq03Bd9hpwpYg7FYBKn+Y++vSNCU2YQkcMpJXN8vzPJ9EjtHzcSSAIcgV4EH32wKqJitZZjbiUBn3TJLhivjlSENt05QKvWiHmYBgxlsdPXDu6Ou8PVaMRMZFLuTwhzAPT+0iNeEmxUJXeALQxUhMmYfJgzghLVWKA2r3JZwcmTsFkdnvO838BBVXE4js3LRjeJc+8A/Gktf6yW0E2eGwa5k=;20:jbRqycEmXNbVGqU/pdvPePxN/KwAv3lMv3nkGBttpUOi34Z8bFUQdF3+DwL2LBMkm2eVrPR5OlWRGYBQIGgUfnCbozF33CqP2zGypmY9/Vxrqy3B1JcbGfMGbzyiCAD55xv4QEjOaep9BAQJyD9aKLBcB47ppH52IZ8i6FeqXLO+lInlA4bKgm7dD71SY4uiYnqHNbvfEEgxzta3ix9/Ou6UAtyCuZ1Gn3eZVASG/jS6FogahMGnl1qQHUENzC58ozygCme4LIoHf6upPTJKvr7ZseIXYdbpnw12UMJWjJFNJP0L9yDGsc92TXl64/9V2x83rS36SEB6N1VZ+YDkrrS1NYzK1vmCQmp6TDJqqZaeIdkDi7ZIXE8/L7+HO6pDPvkVjaMe8y5pBnAErzQDJGF+sfdx1XlP6xnb/X8OAmDHxPO4b46xHIHut+swox+57Yib5QUahIuH369gnm8ZTPCy31sjE46c2CeJC4deTGv64N2bfHol3H1XP+UIOMdM
X-Microsoft-Antispam-PRVS: <CY1PR12MB032659E9834EBB495855D49397B70@CY1PR12MB0326.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0326;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0326;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0326;4:ovl8PVmZk5j6GcAthjj3SSB98rpqcHqC8kjIdXzfoyryBcHVLfH3yhKvBpgs6U8TD4L/e4f95oHA0FBg+em5amchwzm8Ocf6u4hzO8XQq/1Qhk5SkFPOJM7hujVhXKosReFIIkIUYBGzVJRc/JVyVrSWBa12cpnCoEsKeK0ppHs5brveJCfT1/9Y0pvKrZG0G16msbQdnnPOkmw5xvSPzCKNfkoo/GmgrrR+4R1kB/htqGEhIBhhFtd6ui3y2/+2SPf1abDDoVhnZ9YCsS1irYrWReVbYkWlSoi9PNxSNZfoBadrbMtUaM8uRxg/nva0
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0326;23:zVztQvnGpjhYlmAeoXQxantkKpohezv3pZ8e7F5kA?=
 =?us-ascii?Q?WiDGN4LGLZBaOgq4wfgNFzCSCc0RujMCp33H7HiuwdS/0gfJUjnXVJv5MiAB?=
 =?us-ascii?Q?qu7g5COGEbpeQdT7O8Au8g1Zzpi9J6m4fPhThPlI9FEDtis6EN/WTucTnxFf?=
 =?us-ascii?Q?lFsbnjBVbSD+W889TNktsquEa+hSFH/VKy6EdlimoX2ztgUw30rDe36EDJfV?=
 =?us-ascii?Q?aVUajZkCxQZDtQOPC7hUMxQXrlJ+K65CkbI6mKfCAwBDmebP5JzJzl0bP/AF?=
 =?us-ascii?Q?0VjGJmM3Qo5QcTkSYKo20b8mHHg0d6hWCJTVp8tLI3ZUfDpohGsP3AFInc6N?=
 =?us-ascii?Q?Wg/JEcSHHytiHzlcbcvaBhLRd41Vuaa0chqaETkJ7kzrtp+FXsnopzRIsCdF?=
 =?us-ascii?Q?rQSWBMwuj21FslsE48xlTed+jmChBlNczB9A8xsuK9hsz3H9ERo4/vF6RRO8?=
 =?us-ascii?Q?M7LOIBs7nTdTl2TcWAgh0x2HOLWf+soAT/V81n8CFYvUKN/gjrRP8PXWFuj3?=
 =?us-ascii?Q?S9VKDTHKAwG68/K38E4oMggqRMVtHKZgMkH15mHQc2zCQuDzfCy+x3VdWZoT?=
 =?us-ascii?Q?YsN22DKeXOCIH9XXRkuXA0cxEOxCxnr8bbB+sJKjchncr87/GsgZuG05pvY4?=
 =?us-ascii?Q?Ym1cN0U9BJE9bc4xgQwyf9ZnIy/grDDQw1mMInxT/LGQw6RWpQM9wjFlyKpD?=
 =?us-ascii?Q?rPLn/TUC4ngMRamaQYy4z2KMObBJtsYnSsW+rrElB7r8GrA1RaPj+JrGGSE6?=
 =?us-ascii?Q?x7FwG1CdWY21Ib9mzvpq7u+96Y720C+nIerv953cKmrQbJM7Ue2tiUD6SJGU?=
 =?us-ascii?Q?S5YT73E0I2CKRHUIPZay9biYNXJ8D7FXlv0hdT207HfiH9MQS9aLLHdKChRU?=
 =?us-ascii?Q?Ve7yuQy326u9fmuS/qIGW0ULg9Tmo0re6m/8cTaNHvabGt7bQbbxd8+FLO7Y?=
 =?us-ascii?Q?H4r2Fm5zskbmiuqCeDDpiI6ngP4NkHefrojo0/+s8W8y4bh2kqoz5yyhHrYQ?=
 =?us-ascii?Q?yPC++hnwBuhhw0mZS7sl/TlFTjM6dmPHXCd5C6+VVCAnE/cYwW51/fTM0tho?=
 =?us-ascii?Q?xf6KyTIE7wifyJXNJK/nLhSjIxwnjHhXaR4g8FlupRs06z/XI/NuH1M6+ypx?=
 =?us-ascii?Q?mKrJYTRYraovN3CDfN4x1ViUXYRUzzEKd5KO7+ruJ+krJj6YB/SugoIhhYRB?=
 =?us-ascii?Q?dj6YCvYrNkDLwOaXMnqxPMItwELvyIb9GpjyAlaGCzTYailLchfZ34fgGLcY?=
 =?us-ascii?Q?YLQTjONy8yZTRlVfIyCuzyu4GgCoH7CRWctKyXv?=
X-Microsoft-Antispam-Message-Info: qNbLV/7k40/2IPNf4jtLf0QOhBOXzJqxFYAdNrHdjb+82EIGjs07XwUnWP7OC1bHlZKJtkdq/3hUsT3Pl/WDMzm8FeMXPuNSRYOrNfYEX2Pw3xmjsOdPI9HagCCZm2y7PfnMuFCPDFDLyRLWXWHXT6Up9qr8w0SZo29YfRwREqrGOSrVuiobH4u30kVPIZty
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0326;6:2G82z4XAfZZmO4oV9YAb9WDOYLY9beCjxVkQOBdR2pC3Lsp24YURbzKzvCNMNqLtMhXe8xoVKVxuTXL5y9ikrfDTCa3z7ufBCoyk8ATjw0FAA8+9cAMTm9savCDkZx+vS6DmWFckbUZYxjrXDMA5vzNSC54GmCRB9ASgzE+DFC+q3AsYPQoJtuzVk+NCs8z+EkiZrQ7fx6xrpm3wSKxYAYdYBEC1IXoAfrbIH6FiwboVZOV8f5NiOLjzWOfcoMbzC+u0PhUkssiA/6vQtJc77ex0L9b2sw2q4NaIn2QEotPPXK6Sono870LplH5biNJV+LIR1cCaqP7y+Plw+gTBsg3su/mzK2Lf7hmQs30450yxS9KoKJDRE/mo5xWnEKwdLcxMsgtNKe6ubq94twnJTNSXiGc/ONzIZ2aycDD5vBLvELBN4UeatX3znHSiGPmeyAT2DEGUdmHJsODuRJsCcA==;5:ONudyC2xniGJEwf2lAxqICU8Rq5Vcy+LXzFEBFN/PvzugEsfiecnpPHFjlTxe/0udP03XdV6LbzrKamMNZSeDbRCj8Orqj6UCAfGdbMdQXHY04UqeOQtX55MWk9Fpl8kVAW1OZRSojPrktj/0sYtolyFCLu/WhDR/fVfAAq8dJU=;24:7+opv1lS4f9+Iibt7SvlM3j0y0ukKqxsG8RG21M0Cc722sdw8MksjZkwnSuuhSk4dhzbz+/bqTw1AU3vod0Jve+JlDWWIc7pR6o0DhbwUEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0326;7:LZYo7Id1ob0LDJ9uEDLf0Kw9xZHl9AoEHZyxu6pyW24OU9I9fi9O4/T9SPGCkdLzbXjz+dYNJaD5SpQS9+hevKiS5t/egTzVwldHGGw2cOFGOkEb72uu1eB+CjIUH7s2Y0rv319vZ0m2uB9BP52Zccm0FxaO0SNeX1m/pKZX7u0+0f0tj+MJuDFu+b/dwiCqxQQHTras0tgqS2mzIBGOYqi3WjM7bbD36CjiSulJajK4OWYzqJ3XmLpCeJlwiOl0;20:qIMMwAELvWhXW2CliaKcsjJIhje6mJKotVyA3Esp/rpvyy/AP2oE5/vFA19AVkVNr5sA73CdWaNKWDClomOW8dCNMqAnqSmbIIUP0Urjo6lZyrI5/hfDaD83oPv3Fwp4uJURP4FjfaVmD5Y7ihH1vMf6E2B9oArDiAYsENmDHHuFyTT0bxxQrGRc86zz2KjlxEvnaskw8zrf2SJZgvQoyTeDq1OQ9u+qfh2FgGUejqeLibh9s4oTVd+W6p4DKKNM
X-MS-Office365-Filtering-Correlation-Id: 851a4fe1-f6aa-42b5-bf47-08d5a4200332
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 04:59:33.8452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851a4fe1-f6aa-42b5-bf47-08d5a4200332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0326
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968144319777100?=
X-GMAIL-MSGID: =?utf-8?q?1597968144319777100?=
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
 sound/soc/amd/acp-da7219-max98357a.c | 2 ++
 sound/soc/amd/acp-pcm-dma.c          | 9 +++++++++
 sound/soc/amd/acp.h                  | 1 +
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..6dad0cb 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -44,6 +44,7 @@
 
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
+extern int bt_pad_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -81,6 +82,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	da7219_aad_jack_det(component, &cz_jack);
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
index 460365c..6b43144 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -107,6 +107,7 @@
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
 
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
-- 
2.7.4
