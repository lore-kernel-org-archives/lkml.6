Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx48CzvW32V2qWesztj3V+U4yCCs/SYIVcaUX5v+ts6nvrHmSuEHxvrqYL8PP6k9TEoIEeoUE
ARC-Seal: i=1; a=rsa-sha256; t=1524741248; cv=none;
        d=google.com; s=arc-20160816;
        b=PKwtdWkCMfaEGG8BEVSW09WUdm266/RHjp5GJjrF4z/ktfWSeQCBuTqPONqEBZkYtH
         ihuO2UvMNzdjJhpo4LOe29RbA3IQLYQ7eSuB8y6V7v8DQTq7qK9O7sFRoMMgQO1E9IXQ
         t7OJJplCudidOhAoLgZRPmYFmRbcsuB4U5NgH9JG3wcbez2VbwzJrMGIjUsG1bTp9Y0h
         gMqtdTipWIa0Dmw+/Bo1x8BhqkLh413UDQ9laxbH95oheVK1WhcdgggGMLpsq88+MG5G
         01MHPBv2AWp7fqSVTC/2MaEt6A2Vg1OohhZs2r9Onm9ToZeqLXJLfLVTO9sAoaM9+jN9
         9azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3qVlwZ/Gli0PvfHKz4kvwNp0EVzVSxCV1d5omxV6QSQ=;
        b=oUlVhoQzegRzACNWHZhmKIbUL28Jg4Vv6PbfHtfOGV2m0xgEJI1bXbGaNPRkX+b1BH
         gaNEuSGAqxq8+KODYvyZlCdHIyuEgHM5Zr2J3SJv/MA/Zlus8nXW6jRODHTf3X4IDX26
         3SZuYKjTvh4nkVoxnKNrVSZ5Ss8q3091g+vPWYz62jgnvZQ2NuZjSRDW0pDbDrwl0tSL
         6eZIwYB9IS0YRmD0dLDhKZFIRuAsHbb6ZQDJcslgR56cCnhFKfk/Igb/+Bnky0Kh7P/h
         OESa1WU1o4MWmwIIeMjKlWq1M+k3czRSUK3s2R3LIYJc3fVdSg1H7EwZ9MCfjVWADBOf
         tiCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=KW5BDbPG;
       spf=neutral (google.com: 104.47.32.85 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=KW5BDbPG;
       spf=neutral (google.com: 104.47.32.85 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] ASoC: amd: dma config parameters changes
Date: Thu, 26 Apr 2018 16:45:48 +0530
Message-ID: <1524741374-13523-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(2980300002)(428003)(189003)(199004)(478600001)(53416004)(72206003)(77096007)(186003)(1671002)(476003)(2616005)(126002)(336012)(5660300001)(486006)(426003)(11346002)(446003)(68736007)(86362001)(76176011)(51416003)(7696005)(59450400001)(26005)(47776003)(305945005)(39060400002)(4326008)(109986005)(105586002)(6666003)(53936002)(104016004)(356003)(50226002)(8676002)(81156014)(81166006)(8936002)(36756003)(54906003)(106466001)(16586007)(50466002)(316002)(2906002)(97736004)(48376002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0754;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT018;1:OhOvxIIXEUIRd84112VhkDrJpJvQtPSVdJ9PGpnCbQPiPAhGQWoNChYuOhrf+vCoB5MsKjhddRCxMtTae0YYp3PLpPf3YyT7u4MHjYbPECx/fuNAd+bfgzUdgBoSbzn0
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;3:GAys+4oxPklVyZuODEU+hnZDeWEsWQjIr981N+QX7WZg6BKS2W67eAQ06pmVNPyD1j5MFhcXsDERKaeJg8a+BKDUERsSNf2My08uIS2Cjr3VGtfZuxusirBj+nhL6tkl0FfZ1VfeBb8nBsDUwuw4BltQW8cSpqDBFp+pK4gGVoUagDiN/1S81qYqIv9nQU3c7U1eRv9MBNlsNBwgtonPHDr2dQ0OwGfSuRxW/hwMu2QOLwNqWdtggz7MCl9YMpWHLspGCgYRO95HpztNjTukIjrYTmYo2Dyn/0dZIviGz8RdyRjc6W9c2pLyOFruEGyQNKSQ0evqrqWS7+9Mvfzn0Q2t2ifGUI8+Dvp+jm1Cf68=;25:bgqaBU6LCWXkZuafURjJ5I1+l6Z8aZXk6e/ubcToO4US++5xZsrtykiOqmRwDqDW1/vxZ9keIK0LWFMpArur1pixa12HaYBLnSxBp4K1b4Hv2JVFbhqrwwvbWvHTlAtfZ3M6hXyYGLaQrHYEfgV7U0UmNfza3E8XF2Eb0VSBZOXgmQ/9CQI6ZlfbWZL9brGZtvtj68N4s2IPqqBhK4sOhrVRWqVLeH17OeHiucRLlof3ObbYru8WU27mDwGN7kEHi3a7vKGyvY+EbjwWSxMBqXdEW3/Wse5h+cKeA0qHNclb4bod0mXgi/7DKIZh/qRJ+Iqe6jRn9nlG+U/YoCxfx+KZbbmT8ddW2qZXFUctgiQ=
X-MS-TrafficTypeDiagnostic: BN4PR12MB0754:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;31:9Q82D5iAIRzmF3kar+qCmlogeJ3z5CoweCuyXQBFRmg3Dyv3+USSBgcqxHTYztnS7vsSQL8H53WZPLcalmpJlKr/WjfaFD7504LmggLOHdes1Wlv34ThrccabmsubdnMOAgbK5mkU0Qp+aLdK0opOpO6P+UNdARCRWkDvABJWMROolaLMGJAX0dd+3HMfrVEUdk/+r8JSuHmewxq0ufj+vzcjb4YcyTmPQ85fDj+4PA=;20:/8nZnYOuKdhV7DNO4ilnhIvTd3fAGiwsOMGZehNm7+PxjEWC1cxcyiS6kCLTsj6B99acgNqh0Dwkfuf6mtESWDzpMFvm4myCgRIMgm+h+KtfHXrpC+oEaMWZzUcyAnbcHO/X8wyHcklGl88S0FS8gj3iWTInrQnkw6SWKSNxiZUfrT5TjGNL2CP5FPY28iGeztd9owpOr6HQyG/7MonuJxb3pFcP921W5GnWMZfHO+gFS1aq5Yqaa1AhsHiZIWfW4a7Rt2/SsOuu7gZN0SECeeYZEwrLiTftvVfoDDajrWBTBK5kB1VGBLHpRAiFHF8SBiC0CLf+beMJieX/AYv8NkR5vOM6baOzOfgTQ0H+D8ipdO2So7au8W7JWwOLD8QhuH+gttrMDuFv7HK0mrV/uEctclO8k14tIugEl/U7F5DqJJZVtV8fL+YrAvkrQC0CzvfI4ktAJ/eXNc8jvO7XYqsENaeRMZPIMcqS/EhymmjxkWtmqNKyd6fcOvEqfB4G
X-Microsoft-Antispam-PRVS: <BN4PR12MB0754CF48394D39012ADC6A07978E0@BN4PR12MB0754.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN4PR12MB0754;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;4:Wjnsy5JoonXtrjWgGIbe/EZ7Qn9uAp+dG4BpY0drleQ/4nNmgs3r0H8UcZ49GAkCHbzHNYARXcQ5B0JEEIuD7RPFdN9Lgxvru7+/DU+l6ppkHz3xsVQWX6FO8J9vgJK15ZRHmGha4w3yIGz4N7NPW1qy0h4z1EIcl/XpguN0ERTmYcI7fYRoHvMA4qM7o7tGD25302SD5n/ur82SLA9IYL84Xm4kP79sCW0xW636+Dik/HczvieE9lBEIyYvn9X5NiKg/ElSbU8XJ3gVWSYPY5mKW3o5UKIf5yIGBDid2uyBzuLyUl1y/rDW/C3dMc0s
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0754;23:pJsqDycZwjq+u29bafDi8qe4wAq8wYZNp4Wqmh0SV?=
 =?us-ascii?Q?/doIc0JrUXgCs20HJm5tGCKdHQVad8Qq6VjIUEqhqELarIey0xoj+ucZrwZo?=
 =?us-ascii?Q?m9T/ze7DM/twuLL0tg0URiR9EJ23pTDAqH22Z/Z+fQOe2bL8CUOeRvRsHGcZ?=
 =?us-ascii?Q?2E/seoUjOnT360p4A9EAd8ZE4lJSFSaEc+JvEXtdvUCehOFr59pBLE4wcHeg?=
 =?us-ascii?Q?3AooUthtU+CyCvb3VaRIiIk0mepsb4nU518nAANzxokTdSSxx0S2SZk7YHng?=
 =?us-ascii?Q?vDHNoCrp2ei9q6jqEJm4xCCKoJWQ+sTNwW3hRN2g/X/XmoCo4x/z4rAZC6/+?=
 =?us-ascii?Q?p7v47o3EEyUTloZC2mYX0UXLgVkgYdMBSJ823jEpTle1xRixdosVJqj2EXvO?=
 =?us-ascii?Q?i9hmWc6bU+7FNZsaDXOxAKtSgd1kJ9tu8XfghYeyZE84kJL7/JvI2zIgGPUV?=
 =?us-ascii?Q?mpQ8au1uK1pI7qz66svisQG2EHwOMKS3dLk/WOE1rPqE/IVfCgfop11DjPg7?=
 =?us-ascii?Q?ei56hT2f/OqXRILkp5lEtdezlO6OOAGEiMHJZDlYT4aiAupdzkOVrMAvThRg?=
 =?us-ascii?Q?TUNMDrH3NU1qBh2g249s6izp5KXCsIYgMKcw1sC4QlDR8l0uQSo3A5z3e0Ws?=
 =?us-ascii?Q?+LgCwxLRW8yI3c0n0gsw1yf4joVtgJ2sW505iJYql++1OdSkZKZtVwdowhqx?=
 =?us-ascii?Q?aOZcgHfOPDGtGU7M5aKUQjuHlIgsnD2jmXCMOZmtWt1MUTvY6FAk1iQeT4Vs?=
 =?us-ascii?Q?jBS0/ZRtAmKSGBJrzxDrFODfa5q8UxHDFpuzlaF6/7Ei+9JouC/XORQMSUoQ?=
 =?us-ascii?Q?YSur1hetqov3ffkDiIx+OZrFSKMCPF0JnMULKRBV0HtiemeuMVrqwESgjGO1?=
 =?us-ascii?Q?ajVQ9EtDfqLl011VAH5KySI8QoDkQDlBsimqIMvdecqW34KYUJlSLpUTnGFA?=
 =?us-ascii?Q?v4WqH6kjuN1FKZIc2jvoMVzZP9xOBv9S+Cw3F8/sMx1hgL3N0FfZVWWH00+u?=
 =?us-ascii?Q?ozA7FF+G5LUcTAMGr88lrTUxJ+FpO1krLwTsygSq8GXT10gbhJ7fS8woRe0+?=
 =?us-ascii?Q?VOyFavHbI33i1NVHObDkWi5SQk7YrMqnh9s6uTI3a6VaPBKzFLgTjDPzXGyt?=
 =?us-ascii?Q?Lp0WlWdQCoK/hO+ShX+0zhuOJeyOnP9QKXmno/voYCE4B0fSUciQly+G5f+1?=
 =?us-ascii?Q?f6pNeNYr3GJCqxT/A2GFatVPFNfT8YBGrlkN07cpHv8/RddMC7PwHdAlr+md?=
 =?us-ascii?Q?KO293H+ZVtygvsrmis=3D?=
X-Microsoft-Antispam-Message-Info: s+QXiA/hkI2GQViVu9krlCFS7BUrmTfazi0hoznuW3zgZFWrLYx0kZGijHDuGspjCmandyK1v0pMthZFi+tRrst+PpmraXRvyw+X6Myr8C2ymSg4+uHbsL7Q2JJmYHy2VQGx9ty5V8iB2LavzZKb545oSkqijaZUNZF9OpmoXIMIxMXqbDxUcPH2RDdCR3H0
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;6:QOwGFRjuY3VtGr/kLCTKSa2Edd8ieGpywRKgZWJdmqKxg7xqNVw/py8ut9Nbs0AtS9voxhkVeIwZRj4xuL0OtTVah2C5poHwt6Uw4vdMMATlehk9iFgumYgMQ/ifYknPhfoLPcGsdMT9aTIJ1criNJSH71EbNT6MbuGWV39+MLGuUu06EaKJRKbUJ3Ij3E2hyjzLHA11OtzuWHTL1lCsufArtXVPRemv39wq0gYB7e117Ljmy+Sz5RFueXFpsMUGOW0cqpfye2HhBqOHjVo/xZAEV/c+XKhPHLZ4gnHVawnu1+rHeVet8Df1MtxWZyedfKuElQz2cmSHyt1vNITrjpOU68Uf/YOxaYOjzag3hpJawsexzUcL3weyvXZLNyX3A3G7wf5Ddv0CL5koCbRc6JGcI19t9QOERB22yfQxnNTpZOGpS6IjZhPeFZPWMcjuYfk9WOYHO4RxBtZf0HfnYA==;5:vdwob7zW0I9ZxNOX+T4zA+N6gxPp59tlP4eFaWgk2HNdfGgTCxVXJNMTXRryyD1LkMOObRnaPyeoMud/pTMQ6ZBNftdh+XP999vQKwGEtZApSw3z1r3J3dmINkq8/op6g6g3Ggg7s1YdOL6240KvggUUT2GkNJaKFSTVom8RdBo=;24:mpNNwwggKzkXNEOrDKQLvUBFjjKXK+0as6GTXFX+UuodjrCCD1/cW8XTToyhfSrz+oUj4WyThMPx2IViEDD8jWnjhWTngkwbJDFmuNP/jg4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;7:W4ovEKZUaYl0ugSokTJ31H4CufjdsraJhPyjbnT6BlBuwSk7cDGcpGRc1wRIK/H+UnMWeV0piLgdPlRNZvYwkvl49IU19msYhxTsbsqm0KojluUf+sHYM8yRkpPZNCZ4p6cKm/PL6hVFJOdwaL9/xJFsYy2zcY1eh+pBrqxqUmTZ/LWwHFMdjKLRa4HBPGLtWpp5WJWW1G1Xm90gQGfOESUKAQC+Fkb3Du9vzIqLR7Jwr1lUbkiSKdQu2hjV/8qn;20:uhKutu/LXIfPJg0hU4AP81zseuGGYK33p6nLHEyfm1sAKINYuZtVmwXhWFjVURt7PGPZEjJHDXei5B6AKQfzptD+Mjg552TbDW5ssmsPr7YZBO/4j1S2oZJ85aF8DVX4CH4PRU70kmBAJoY9YxeUO9h7bLWxg3dHOQG7DNVg/cwD7bVz03UQPpUcgPXbnpgjZUdeNs5MsJBNTAf0u2r/W6h4R1ZyTIdla7xYn2n3VFuPsd7qvu9VKBS4QsP+aPi7
X-MS-Office365-Filtering-Correlation-Id: 8055882e-e5a2-4ffc-b2cf-08d5ab66d216
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:14:03.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8055882e-e5a2-4ffc-b2cf-08d5ab66d216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0754
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807079775772304?=
X-GMAIL-MSGID: =?utf-8?q?1598807079775772304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added dma configuration parameters to rtd structure.
Moved dma configuration parameters intialization to
hw_params callback.
Removed hard coding in prepare and trigger callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 97 +++++++++++++++++----------------------------
 sound/soc/amd/acp.h         |  5 +++
 2 files changed, 41 insertions(+), 61 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9c026c4..f18ed9a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
-	u16 ch1, ch2, destination, dma_dscr_idx;
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
 	} else {
 		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		default:
 			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
 		}
-		destination = FROM_ACP_I2S_1;
 	}
-
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset, ch1,
-				       sram_bank, dma_dscr_idx, asic_type);
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+				       rtd->direction, pte_offset,
+				       rtd->ch1, sram_bank,
+				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, sram_bank,
-				       destination, ch2, dma_dscr_idx,
-				       asic_type);
+				       rtd->destination, rtd->ch2,
+				       rtd->dma_dscr_idx_2, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->destination = TO_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+	} else {
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->destination = FROM_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
@@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
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
 
@@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      SYSRAM_TO_ACP_CH_NUM, false);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
+				BIT(rtd->ch1)) {
 				if (!loops--) {
 					dev_err(component->dev,
 						"acp dma start timeout\n");
@@ -950,38 +940,23 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-
-			acp_dma_start(rtd->acp_mmio,
-				      ACP_TO_I2S_DMA_CH_NUM, true);
-
 		} else {
 			if (rtd->i2ssp_capturebytescount == 0)
 				rtd->i2ssp_capturebytescount = bytescount;
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
+			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
+			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_SYSRAM_CH_NUM);
+			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b..5e25428 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -85,6 +85,11 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
-- 
2.7.4
