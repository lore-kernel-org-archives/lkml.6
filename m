Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZr+PLhHOZO48sRbEAqCm4Uw1kOHZLtOfamf+xMtg8Ipa1hmF5sZnVUvIwx1qScyJMu26wDx
ARC-Seal: i=1; a=rsa-sha256; t=1525754702; cv=none;
        d=google.com; s=arc-20160816;
        b=KaY4KDSmA3UCTytUP8YCTaoeEYvR47puqcWD39Zu31v856O9/07yvFZBxFpl+8Tp9C
         Y8tK/v4yizZe4tS8MlHIoEAbR/a3wj1YUUH4c7I194PLu2xeS493LP35AzhcUG3UZgIp
         +NiKdsg4lIfeWD3dHq5YHZ5q1B6mpEpHFvBRectRPw0k1NAzg0aLg1mag9OOLvV2jS3X
         iU0hXLtRl8AF5V0VK0EimNPJIwjVJZohzWRt8KcIXPopRzM0I8qw3nWSjQlGwbzkGqOU
         jdbuEXtJWW0qsOXSAqRxb5Cq81knnvwEOn4m6ZyGblMJQ+0aELAY8XkaDfvc2zg9kTGE
         6F5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BW55bTQmvWxTvzTfib/DFm3GrV7GDx1wvnPjDnmM65Y=;
        b=Igl5WsvC8AqMy1jK+jYemajOUe+gf3k3jnIoGSZxEt40D+Djd33GKFCx95AGXEeVOC
         3kHdlsPGP2hBx8C3gKg5nnUK5IoClv4KD3o9cxcks8sMORSwh76Rhka84b2/WWR0RVbe
         yFnlcUCXuBEmLnvsPVrSJIkKR1vwZ6j+BPN/O1khWLHMJ1kEa59LdvVOZP32af+ZGQts
         npLkWqJZCX/t7EkaVEtG/BzjH+8x9pvc7BMwKSLyaWDVQP11cFIyZv7b+ICOEIs7/N6m
         1PqtUXrQ2UhZh9N4S02OajzIaYWfEvHSnpzgmgpWoKl9oaWIGHC7idtEmkRDR/2zMWSr
         qHiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=iT7ZHj7g;
       spf=neutral (google.com: 104.47.42.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=iT7ZHj7g;
       spf=neutral (google.com: 104.47.42.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, "Jason
 Clinton" <jclinton@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>,
	Guenter Roeck <linux@roeck-us.net>, Kate Stewart
	<kstewart@linuxfoundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 02/10] ASoC: amd: added byte count register offset variables to rtd
Date: Tue, 8 May 2018 10:17:45 +0530
Message-ID: <1525754888-14124-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(39380400002)(2980300002)(428003)(189003)(199004)(54906003)(50226002)(1671002)(81166006)(86362001)(8676002)(7416002)(336012)(446003)(8936002)(2906002)(316002)(26005)(426003)(4326008)(2616005)(486006)(36756003)(476003)(48376002)(126002)(11346002)(53936002)(77096007)(16586007)(50466002)(7696005)(105586002)(53416004)(39060400002)(68736007)(356003)(5660300001)(47776003)(305945005)(109986005)(106466001)(6666003)(186003)(72206003)(478600001)(81156014)(76176011)(51416003)(97736004)(104016004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0331;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT036;1:jV3XUt0o1fN5K3CeTOy1dDv+YgRPFZWlshEFW4b4I94Xm3hb/LKdaRZCwf/HGVJDo40K51WrHEhHIIryCXIUYbQ+hXpKcpOxfi7l2oWYkLIfLXYHyRUmB39qCgmDZ/Vn
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0331;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0331;3:uTAC4s4eh0qVgG/FerXg8kBTentmnilUW8hnOoo/kPQ649rJbYYEp1J0BjUIiCKe0gFIOix4pdqaFewG+6Ky2aBG+uFFCXg55T9KQwJgMwJZkCax3cQPGATOw6aQ0+rEjMfAg6sIHEf1FvO4lkTZrHJJWHlZM9twz83vvTTsH5srr12XNjjiiNHXW+/bEexqaorBQKnyKV210wkE48XSvV1T2nU3zcqAye3N15DxEi/O/lXBqkNr83814Kb5KdWFPo9ofQYrPl3jvqJCjnp8E0oDHlH84367PM+GQKykdENiQL0TRBi/fr6Rp7hYN94gMgPwH7k7niR/LOUIlKO8AVsbiEgyPRzg2Rw0gaSFugI=;25:igm3U5fVLjWIe56zGnRCx7XQJWGYdF3Q1H8cyLYVof1sksGJ1gE4sbDAGB3LPcYdTJ0AseG3Jjvrh+4ETgjce7YkJwEHDC+bx5fAnFvZ9s7pGDgSdvJvm1VeHv7sV/msl4qr7RbaYbYUwW4HaSN1PHRWeExu/hh/k2bM95ZSN7BECpfx++0cw/Uq3ynRNOW74Fw9tFFEy/pdXbyXC7/Z/YYH4spAtJr8BecyHtk2/Y0DXuW/yW/UaEaQ4MIzpCEZhnHlKjkyogsaEV5Emoq9Tf9CUKq1cUYWT0Kr9xNawP7P07OpXckOrjWFyVoL2oynRumUbbPhkPpIw/LvKCBb1g==
X-MS-TrafficTypeDiagnostic: DM2PR12MB0331:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0331;31:wIpJXLRofpVtkrKXhrtzJ1O/RRihLaCJqcfDxuEVXchy4Q2Hhi4q+dtXK7yA1k7HP3dY6nVYNz5AoUuBZkfq5n2mkqazejd7k0s2Jqp0/BwQKFSlX5AONNz3L2NnM0oTf58JPA5k/pb8YCBkeySSPYfVyM7xQDZR75CvrD8vGeYvIJ0qbHkB+RFlvoE7G7ChYKEh7CbGWZfNxR2CJ0oDUjdFzF/+y/xZsYa3h+wLSE8=;20:owUEpgrBAc7Hu5d4Uda5RL+IIfEdHZl/tdra/MTOwU6xdEZIk1yBKfdHZjS4dXgXkEVKkhn86klVR7nu1I3BegytXutlL629sNCIOq/QK268W4Qkm7GwUlltlXCpYA2Md35nyf8Xr6wHs6RTY4PJjLQjMntZyYNhzpZO4Ob8iny+cDwDJ1LJ/T1ps8pyyUNKhGPo1b8RpFtWYmbgMszt9YE+bI4qwCK7uiKCBqAwHe9NB6tE+n/GZVWNWD4PjGcz3bSgxYkHZz5UVkl+0mT2avzdL0Bi3az+PVXfph+xM7iy6pY+xLAAyHprk0lt7MHZh8WAxW8h9AT/ywsMpliCExF4bMLdlkrSZaI/9OHJQ8xZYEd//A7XHUyhxk1VRw66V1fndP3klldNRZ/WwJILLT4zQT/9QYOvm9LDRQCXlKbl8/h/mjaQ9Xff1jGXRpP7vMGTu95P6PL01hpC1tGHGYlAGC6dpNPLzkV+3AMqkDyHoZxSDjMMchxO7wcrIs+r
X-Microsoft-Antispam-PRVS: <DM2PR12MB0331B15B58594AD8612BC762979A0@DM2PR12MB0331.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0331;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0331;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0331;4:JgStdSqT3Ms2XnwjB67g8Uf5O7940nfZGamKC/Exw84uiiOZjmrw+b47DBLJhkb6U4Qd5/tFZEoPe/Vl9WINi6VQnunBprCWXwtX55y5nXMFtzO3bbDKuKQI+BeBcu7V4hqWQrledpmL/8xEKOts9yLbCX9QHC2UsCmftKCOQdMkOjpDiljDT4ZptWjAPU/1J5rr1LkjOG0c04aEFjsokcA8uUonq+lYoz82pf89fJJP8AS0QPIrI/gOh/9O0ap4lm9z+CN8HlAUpnaEFsCPoitYUkD6VfwSq3oi4JK0SB+sUn/1KDeKtwXxs3NQs+Jt
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0331;23:S/mgLU+WLjSR/OBM/cTeFnnwD8xyLhtO508QSuBgm?=
 =?us-ascii?Q?VROx/52/lqrB9OkBvSsoLcgWGoZ3uslRWhLMQP92UCnLmjmCN1eRtVyi8+2p?=
 =?us-ascii?Q?Ngnx9kbUyQmMI/js/1B+FuhUL8mcYYkWuIAwfqma3nYCRWYgfLyBz/Wnprk5?=
 =?us-ascii?Q?GwiLtxuPoYEgJHVEEO7FZOYRu8CzfrOHjtG0ZTGQc+6fjEzGtQqVHvfayQ0o?=
 =?us-ascii?Q?3BGKFqzydhcUXWYDFFbgwG3k0ENV+YLNtw1F93X4ZoH55gv7xtE0OudYyeRX?=
 =?us-ascii?Q?Fh1sP4UGrOpm5fqQgrkxbA5qEwbbHv4E7l+3yOYi5VWFFhqoEdtlAuyUv2Np?=
 =?us-ascii?Q?CP+A2QuBTrXuKYHOYchbKArCumceJ98ymu2Qr+guWxGehxnYbTWcFt7saaFl?=
 =?us-ascii?Q?9HksGFhHt6ii1tsMFzJ4qQ4XGbM2iWe57MxsLj13FrVhDNJCIA5eRX3BQ8cr?=
 =?us-ascii?Q?l1n34CPzeWh5ZoiIA9adb//z86daFTXIE9JvoSdK73Tk7oEmk5G2cJoKy7bH?=
 =?us-ascii?Q?zAEzkZIxnRWKwHf3lDWwWVHEffH1izshOJihSN+jc7XTP/CnuFNz6uNiBIja?=
 =?us-ascii?Q?B9/QOxjt24tw+MDfmVthwUwGKbeHR8vTsJZN6PQkBx+Svydtvl98B/plVWpS?=
 =?us-ascii?Q?ChM8ftrro3GS/c+sA2q4Um/hwHd5ZZxQFPPRh0zu+Mj4flglec7T6AWjC50Z?=
 =?us-ascii?Q?vztfpHki7xYD/OvSTFRBG3iQNJnmDF51Qd0v2amD0KZPhU+vsz1dpXanOiWL?=
 =?us-ascii?Q?e5X4QLGQWxySQysAtgJZcWWnfAqd8MIfSZXhbln0IzUp4kmJApZaH/CskJEO?=
 =?us-ascii?Q?/kfdcwL2SoBURn6oHfZyDR5GkU2jTyegu6LnGvrINv8Q1YMBXQoTCeEGpWzA?=
 =?us-ascii?Q?VKOjBIJTrGxjK0Mt/TgOlvYvOybiZGBV8mzIATGyW11u5xbeX7JM6v/cgfXz?=
 =?us-ascii?Q?IZ05riUo1NTpMwGKfSiAKX+/btnYcTgORVYar6iAI+lSOO8JNyyrrvzLexRn?=
 =?us-ascii?Q?qBnMvkXCXtNBwE7cNj3pzcWxh6H6wSnoLj+FAYuwEPXdOve7kHdPGSDeA+2N?=
 =?us-ascii?Q?3sHu0B5csOT+Io073IvSFRyxF5xftqy/dIkaPlMIJFNiUm2keLB4i1bn9jPY?=
 =?us-ascii?Q?G09H0vsV1BOgK0cpgaTEGAlNhu5AMo8dvuvCU62cXGrpZ8Z5eNw/o3xaPKKZ?=
 =?us-ascii?Q?5jaPQFJZ7pTBFjpuM/UXRsspNGAuDVa/dsydn1HRM8OozEOJTohZ9rpFfUHl?=
 =?us-ascii?Q?1xTbL1RtIHKisGls7w=3D?=
X-Microsoft-Antispam-Message-Info: 7HT5R6KXu+EQBxEpuWVxPu93SlEW3/yc+rE6se40JV6YPJT4L6cKm3PYGRKEpUXnYdf4viIES3Inl0osiqo8xw8STxdluet/a1V63SSB8CI06e3xGFuTXqlDIp4TKH5KOFoKD4Hwc4I9WgsMmQQzjWtxf/ehW/b+bMibKJEPaMLHKj/N+HnI6j59MwsgJ4eB
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0331;6:QbMn8b57yJyXcD0fRfXJSMx4Vj/ZPOViXjnA/cgBsDyBXICjhYBdcJuvvErNioFF6nxKYEAGu7bFOqTMANFj//HA77fuyDdA2TM6IYuQZRerpbbLyH1pE375hvwO6AywmQOiFjMe7QJhnV0pcGPzsB9YSl1QGI14jJUz4gFAvUsaqv6CfBEi1mZtYzpbnl0u9tiiuam+xNQm87NSOIIr94Kx2ROkP8lZxgI3poTNzQ2pVBCxruE6oeeNZx8UJafKuqZd2xMi9T9EdUBdL+6PAuQr+DMajYiYPaGbLb5Mz98YdSCvYfZg6K2O/i5/u0B/Y9t/AtkJtPimaGe8Dpo0UNKvOYgTIi4k3dN90TMDuXEdJjT34C9P6CQELRww+dZBg5z1fr3YN7A5LcsX6WTn/gB95VcKR7f5z6scCQcX5gz1MBh0FJr32z2gEUdjpPMjtb2Yei/f3RMujtyuUhVBOA==;5:6JYzwIlDSGd20KGN1NRKHlaiKiJt2N5417peucvwmnLReNY2cx0830v6weKBK0ki9jQU1Xvuc8HpFiNR7kziyW1Ok5vfOrt2uTpBtY8WEl/V2+0L6L0BPUpipbNCsYNLHWRiP1T1txgxNnyKMYx2B1kz7QTM9FbFhWxgDTDsRzw=;24:liKySE4h2nfYWsEKeoVj4zDsckF7cPMilrLz9+sKx8T0GcUpzM2GtRCncjhKLlOCATFpa/ERrjE4K8N+OLZeCll1VDi0iXiDt0lYEBF6cV8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0331;7:o0CcH9uqxWG6S5TrC9gw0keHi2wBL431hG2fA5wF3TKhemUbKVU95ge3iDwtN07zUq/xHHa9IFL7n+LY/r3IWrmri4yMxLo67Hy3zxjU3DGVcU6h4Ymthr4+SQz1NaoRixsplR9vEASr7ZxQs5Pq3YbmQPNDD6Qx0expMoRY+wxubxeE/fuYJuH2c5dBd2WtXUdoSy5kwLoXdlpO4lu63KBD7Jnm08Rw6EO8dN7U+uYBuNYxxmGMww0TUttMYxuu;20:4/ml+TgkN9y52iIxXjm8ycCYSVQ2pzVGKRNxBvC2gFh20RV8rLJ0xZNm1XLuRTbqfpsrXglfEKwm865HDea78q9F2f8kxFuHtTdLcefyvQfJnAzco7UWFClYGqz6k+5fJQNs1I+gy0CctjkhEXH+Z61EQIOy4EAH5htLatyh8c6SOYXsgqZuLKtte8Bd4IkhH35ezm1FXAb+7vc2scoCkmZQLBvoXamZ0cpe9afANVad01VNApSvaXEBTJbkufeN
X-MS-Office365-Filtering-Correlation-Id: 98fe3955-4c3a-404f-7e01-08d5b49e737c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:44:57.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fe3955-4c3a-404f-7e01-08d5b49e737c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869762242298391?=
X-GMAIL-MSGID: =?utf-8?q?1599869762242298391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added byte count register offset variables to audio_substream_data
structure. Modified dma pointer callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Fixed Indentation issues
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e9736fe..6e338fe 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
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
