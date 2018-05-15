Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZrA4vUonsxzcmLGuuLP8zeu0gbnbq4eZ7jerh4YGmUjiX4+c0VfuzeynJPm6svkkBHRXg+m
ARC-Seal: i=1; a=rsa-sha256; t=1526376284; cv=none;
        d=google.com; s=arc-20160816;
        b=O8dUvAw4feK4E6VPuFZs293qtq/9kMSTTQfxM2u+rwC3BBpm2Tdp8VoAtoOSsxtk1/
         7Rkbiay8kA162wH2L0lvYMD63ok1J/6KVSonrpkog2DolujzUYuhcEV8GHQJrsd0c2cr
         m4+kIxaca+p382uf+rdFjD4PrtfDqGLHOn/iXioWYW/RWLEbr4nsqrmq9QalN4dwmSZ/
         3hNBJQHsOuhq2oz5xSBKmuZayDrovc4gFLyJd266IbSWVBfBSkZJ/reNZdZWtq3DiGfr
         IYSGafhtrT8Tn5WAbqk0PYK6VrtxC1u9yXKU9LbuqZWcSKu4lFgLbtLTiXxuYUtj6Hj0
         t+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=w/5zt3cM3gec09ZGZQO0TGe/y5oUtnVgNR5iKBVVokc=;
        b=cuMeVYP5W5OMGyAn0uIFBaPW2HUF2J0W/gXojoga36DmHPlsaDuMlNmrsm6Zvdp8ar
         SvyAC6HrYyp9d5I91ypoJmNe49oAWJEY8c4NJNvqoVGh2a3J6Yb/QSZjGLhLe7+oHpZI
         KBBIzdd2r9Bkxtmg0ZsVdlZbEs37xS3zYJJWGYzxQvqepIf49YGJZM2t2EfVXaT55iak
         PVd5zWlTbFzTNU3kkGmQg1Kw0FC4fi/xEU4jipv0CUvmKOlYpJUkK14aUTrO3ao5eTPc
         B8KRr6Eva/QVpmoIsLZRtxTzvTG0QwziMeJGWk9iGfDGo/sg4DNdv4PgvNl+8NEWyAES
         n5zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=JaaHQfRM;
       spf=neutral (google.com: 104.47.33.57 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=JaaHQfRM;
       spf=neutral (google.com: 104.47.33.57 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Kurtz
	<djkurtz@chromium.org>, Guenter Roeck <linux@roeck-us.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] ASoC: amd: modified dma pointer callback implementation
Date: Tue, 15 May 2018 14:57:35 +0530
Message-ID: <1526376472-5981-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(346002)(2980300002)(428003)(189003)(199004)(39060400002)(4326008)(109986005)(86362001)(476003)(336012)(126002)(426003)(486006)(2616005)(53936002)(6306002)(97736004)(305945005)(106466001)(53416004)(54906003)(316002)(47776003)(105586002)(16586007)(68736007)(8676002)(50226002)(356003)(81156014)(8936002)(48376002)(966005)(50466002)(186003)(81166006)(6666003)(2906002)(1671002)(36756003)(72206003)(478600001)(5660300001)(26005)(104016004)(77096007)(6346003)(7696005)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0327;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT006;1:vvaJLXtQhiLaRoriOXkZxZJsBH8M6QNROGlBOGeFzm7RstnyPHQoHSWedWBNmqQ53EYOLRUVbnwNLe4cI+YRtgiPRr/2ijqYu7DvP3KgtizJKzFAQE5/b4uuZlPjHmWM
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;3:b/akVEz5gE/Uor4HnJp4xtw8eNX8OwuWN8ykBJd3cTjSVPjy32Xf9Ny3Rgsvg9JI+mknbOXDlgsYPyMjFNXGMOrg4YgDY8F95ur07XhkDvXUtG3CyJN2c1oDH+cC7Rgtd0lBU4nmA35BSlav5NZ9GoOQ0+qdERLopRWcSexKOmBRii8IvUrH8a5LmEWtIxS9fQgyB2bm4E606ZbGNiFc5hp8fQlETWsMSCDHbpongc7oWMmuycG9irUcsfnzrkx68JlV8C3TyMVMOQNhkL6iaaKNHlTMIIgJfoVUiYVyBDwnoujAXtyOsbc4uNZfUTy+aHusAgJZWLvl+HRFBuWhFC3vg7fKL6NvhUtFi21yOCM=;25:oPURFZDSKUqDGD7MhIDqp/MnXh7iMHAQ0kVDyGLYZEtXEB/PiNhdIz+8TjrnS9bxxTd0s5bzUR9rhbuenjMKMlAQo9QC1cnNk/EU4/rQ/jEiCwOV4oefv51FPd9xX9g9xg7hMC+CdOcvG+ng8k2AVEArIgGp7urARVuFg7vqsXyVhRTSrosZBUN9w12X1q/LZGIb8qKU+M+2YwrOP9d4LvadqxIRlV8HBZIUdVEjzb0SkrNzF0B/oLQgLGtXy5tBwu546m80lqhTL+a6Wt/C2NM8L/tNFKv53TVldV5Byao/kbg71DTyWsmRfczy21IsQZsm4YVG7k3bBZNtjO8g3A==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0327:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;31:7L1bckVZDMSNAJZ+uo/MFnpUoUZKLQ2CUBxVYoNJA93NctPGwTK2prhhZIuavbuOKI3fpP1wUAJinvcEageM6IPVzU5BSPVBQgkuqIEMhkT1RkQgq37wD887tyLnFx3KXA4HC9X4cVOe13/ydAYn2ekyLTkeVprfoW0sysErD6yNTix0eFoO+Yniot9O+3Jq1XJo3IBhUEmSnl4qHi+4Y0Mid0eAC/pjYMyPfpiK/2Q=;20:oNGUeLzcRh70KwfO3zfb/byD6BSCDTm4xqyNAdFU3/9kEXFgipS8k9LeBCdl96dp3Q/Ml2WkmUDbJsZyuRS+FdTKt4+cUQLY/4350SqFh5LOEcSvO58++L7xKi1GO7yqSFA4Mpx+v0ZE2ugUMxL/juLIY931ny4HY6ehWK0PRSFUho2jX6zKLhub/rtp2rclUEDQILaWszQLbTpnIuuE1O76d3h8fM0m4qml01I2RpZirXxxmkOaXPdCzta8Ek334qpMCg/TOxLSoQQKuc4i+ijxT7DyYRE2WmL2nzynEFNWc/QPOqUXSLXcGL6lRxx23I/JAFnntGBOgNkt1IBqcyIXyr9PmSqXhmjJwSD0dfQ/pPoYYKA4F4sb7DJGDPtshsQ9vsIQdE7r7CtReE0c9+QDEMGfie711oLk56Fb0tr6XqqOCzNvoZwTGLvF00n6Jnh5vlg+FPaGF9FBMfh5etumAoE431OZUuiFYnNNP/tZOAzXkimiqEk2azJAfOJP
X-Microsoft-Antispam-PRVS: <CY1PR12MB03276E570C23F479F4DFE11D97930@CY1PR12MB0327.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR12MB0327;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;4:MMDpPNuADu0MGf5Fwokq+ylS6E1taIRphSR++xMbcOf2UD10LZxFq6YIkwRjRj1bFcN7wDBn/35ctI7ORpCJ6CKFhVHSAW1S/EmXAex1PYOI8WLUomPULmIzYPcWNtkjPbbV9ZIjUDi/cX0Svuud29X35wp3DFioc6rnEl1C2enDLJuIXQ0rR5W04bSETIbHJMSclyHlkDBn+QogGWEy5qo6eQXkLIyNlD/OgkvUtIRovzBmk8JheKzlhSvFHbKIyF1dbqBeT7vOb9tH16vpj+NcfEl7A1vlNW8bdCsumbX1ZDAzWRr0zRIEtVN4bjwM
X-Forefront-PRVS: 0673F5BE31
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0327;23:JWlaRXb8DFGWgdJrUOuh3DhutwtbdugAQJT142kqb?=
 =?us-ascii?Q?6IL0fZzPB34zYXaXFN4t/8lzRLjTmZUguCdm+SRFWr7XfoUBbBxWyOQ+zR1B?=
 =?us-ascii?Q?rIG62HuvYWeRAIsDiOkWLdUa8D/nOPCTp9errgGjzLqewrjdcwVssimCIFb5?=
 =?us-ascii?Q?nRvedzkDc73utyhXQqKLp0bNBH2KmFdEdog2Z820gkUM9VE5NVZa/VOeODJ4?=
 =?us-ascii?Q?gLJhKokBy2+kJQX/FiYhhhuAN2j0pLKkj64VMxeLrseW3W3qTaLnSxuZrdHR?=
 =?us-ascii?Q?jlSvsJPAFaZIqdJChKEdPxeSA9sqCVrDAV161EVCtcbLqP3G5PM4o59Bhdgx?=
 =?us-ascii?Q?SKMrcwtyugJUuurNsKyI9LPP+aUL4vWJcOOwYxicHNewMaXXt1ZWQNEW8Bfl?=
 =?us-ascii?Q?05nq/FawDraTQqwyOd4JgkCHwbGBNGXUH9YYDcAvH1Z57TwBMcJpGO0rsp81?=
 =?us-ascii?Q?2lE7cCyeBh9kvUq4OGoWambOgtHgz0nKyg1Z+fdz0FER/5kjbKCbwb3XB42Z?=
 =?us-ascii?Q?cyNQmpfJQEtd3Y2iUA2HcpGL9+kk4VusdRCrl9Ftq/I4SqyXo3j988IeApp+?=
 =?us-ascii?Q?E0SW/9ZvamKib0sFpbGaCcbPyzSMfGgstFCt3g3bmjpaHzpSzfYGjVAQiLlE?=
 =?us-ascii?Q?gwhBfKyxGStgsw1NsiFjlxQu/OxXkzhSNo52qpNQwIurAX1nSiOKjktoMW2F?=
 =?us-ascii?Q?TiPcVqeo9BkvOWWzUvvQ8WCxF7RTOa9TG6MX9v0bBz1RMRLxoA1or+bgyEIM?=
 =?us-ascii?Q?avmls9ZWkeuRQ1CurFvTdq2JvbE5QTrBDqYWMf45P5i55WYHzFzvfe8cY4tI?=
 =?us-ascii?Q?zBHAlx6cmlvo+pwF7HRTo+A1AcMtPt5dkgkRdqFg2AH6Fjbr/PoKhdW5Txs4?=
 =?us-ascii?Q?ZUP18ge5iEGRmpCWPqo5A4nk/nOsodW3PsD8MJKBo8FsBoZiBv5whJv/2n6H?=
 =?us-ascii?Q?5Y9bixKI7Gv1PohhP5gwjHME5Ot7UiddgkOqIUs0/eNnDqipE3PZUDwk92d1?=
 =?us-ascii?Q?c6FKM0DbpnGDUSPyCA9i42nnLOdTtzLzZp4e+Y3MmjlDfKAuF27qO4ORD4st?=
 =?us-ascii?Q?uR1R6AYq1L8c/v6GtIFBBwjMOLKvapEBbXLI2znYdSVu5SrImgF9ZNWWp/Y0?=
 =?us-ascii?Q?75gw8whVJXWQZixXZkuPJBiZVv/Mj7meyg7n6hlJJN0oA+uWS4Ng80ZI+nPf?=
 =?us-ascii?Q?66ANyq/m+LI9PFh5GnT1MhHzQCkL9qK1rJSWc4sj7lPrTGAv9+zqtFjmQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 0PEp6oiyqUU4UwuRtsyZoVjC7ZQsi5bzP3cUC29pTCdTbcNQRpTFP9fZES+hFHc4KPrD9RwzFFIsOgY9+3OC4KBaBCC6wjMce/Rb88D7DifrAgptitIMBAkXLkUhgSbH9lY4Yi+wgtiVG6NwUbgh6wRal4sO4B1GtwIZOVS2t5b6+LByDp4dXubwYZ6Z6mLx
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;6:u1NIOXt7EzivBOiEMbjI/KXKj2czrPIuKiLA1/+mZC+bIBhi7KAtxtDosWYHRF5HRdujcjzVUAhpF4lyaGSUcKpvGTVOgrFVbEDc8SBKa5MuOJAvSW/GUY9GjE+lBTj6pjLCDQh/OypxiR1pfABj+1ulocbe6jjNtQA/jPbkpIuXM0nBqcoCtpprB3/l7U3IPY5JPh3eWfDLYPVKasWAgoRZy0rkMVIfrSYaodBjfRzjBO8CVthU76ikzKGg+Ph8plV8X3d/D3fiClsIM9+petI8c2ZzCYp/EYC97PakEhWc40XJe/mAfYMczhVzMB3zWNJoOCELauK7SQ/QVsPgTn7B8AouFysU0Xusm3IxqmZi+/lRHlI6Eb0gEyptE2ltsw9wQRPC3pmDerZBGZrfcuJ97qDhmy6dcRFaZiS4bM4LJ3C+JW+mjj0sFAv+WSCbTumILBa5SUDV9FwS1bFWNA==;5:qn0hD5BQgk4xbga1Tftx9wTFTzFs1FDyyUTg8azz4Cpd7KTqsMTg1WoyDpKM2wgb89vsu3nvWNqyHjA/uoUq2X1Mb7X7IyVxRAGoloKDHWgij6BP4p8RO8aHJsRSkGbVzGlnZIypt0nkNbxpjDd2x4ooLLZ0yUwvlL8BPS/ar00=;24:yV+TWDib1VqZaQB8q1TuAvZY6BpRg3tYQnJJVbXakimJH6Ud/d1miU1T7KKMUb7ZryWl07REPZwSYSh0U1b8+KQqSN556FCeGO6fBS7CGGQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;7:2kvXn2is7VHrmjcysuUTKe5PAHkQvVWZFfwFfkeQz+7X49mLeEeOGSmtXftKc0HYvJsuSSm2Xf3ssdTu5lWQUyLT1EawTHd70Y1v3IvXrurpBkE/i5kYkn/9oXmLQ0OYwb/tCNpeWwXjdykW1aLbU8Nx6dDOoJjk7liiQdLYGe1ebhYbeDOr2koY7X69PXCutpNyC2Wy06R69f6Mm8OXf1nrecfx+w9V346WWTm6HLGMMWsnLE5PEhcoE01jytyr;20:UrfialjA73OtHGQRxVr2EmKpYoqguUEro7MUlQRgetYM5gME93QZzZRfm2wpbrlaFmoqooZxT6uupLjx+lfG0UUbUmyLXfNq4UyA3iNCIvA1ZSVmVLXPmJt9qOhlnfpCg3Hr7xLhSl+dX9zhSVkvGH/kxGcoHMjd9Cj7QPnciytWNILWnX4eVNjOzkBnzN7T2NZQWNga48miAr75vYpfdN4l+p+NFn5gtLGT+UUGRwr1R+aGo7IFEWMgBw2iQhNf
X-MS-Office365-Filtering-Correlation-Id: 656f0f5c-9a79-41fa-b42d-08d5ba45b086
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:24:41.5545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 656f0f5c-9a79-41fa-b42d-08d5ba45b086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0327
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600521539213025183?=
X-GMAIL-MSGID: =?utf-8?q?1600521539213025183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Modified dma pointer callback implementation.
hw ptr calculated based on System Memory to
ACP SRAM dma channel transfer count in case of playback.
In case of capture, hw ptr calculated based on dma transfer
count for ACP SRAM to System Memory Dma channel.
Added IOC Bit for Sysmem to ACP Dma channel for both
controller instances. Invoked snd_pcm_period_elapsed() call
when IOC is reported for System memory to ACP SRAM DMA channel.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v1->v2: removed hard coded values in acp dma pointer callback
	declared dma varaibles in rtd structure.
v2->v3: modified code to invoke snd_pcm_period_elapsed() call
	when IOC reported for System Memory to ACP SRAM
	dma channel.
This patch is dependent on [V4,10/10] ASoC: amd: dma driver changes for bt i2s instance
https://patchwork.kernel.org/patch/10385381/

 sound/soc/amd/acp-pcm-dma.c | 85 +++++++++++++++++++++++----------------------
 sound/soc/amd/acp.h         | 15 +++-----
 2 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 906eb77..dfb37b5 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -207,11 +207,13 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
+				BIT(22) |
 				(ACP_DMA_ATTR_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
+				BIT(22) |
 				(ACP_DMA_ATTR_DAGB_ONION_TO_SHAREDMEM  << 16) |
 				(size / 2);
 			}
@@ -356,9 +358,11 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	dma_ctrl |= ACP_DMA_CNTL_0__DMAChRun_MASK;
 
 	switch (ch_num) {
+	case SYSRAM_TO_ACP_CH_NUM:
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
 	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
 	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
@@ -642,10 +646,14 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM, dscr_idx,
 				       1, 0);
 		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
+		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
 
+	if ((intr_flag & BIT(SYSRAM_TO_ACP_CH_NUM)) != 0) {
+		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
-
-		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(SYSRAM_TO_ACP_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
@@ -661,12 +669,19 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 				       dscr_idx, 1, 0);
 		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
 			      false);
-		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -854,10 +869,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_8;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_8;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH8;
 			adata->play_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -875,10 +889,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_12;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_12;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH12;
 			adata->play_i2ssp_stream = substream;
 		}
 	} else {
@@ -891,10 +904,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_10;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_10;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_10;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -914,10 +927,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_14;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_14;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_14;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -955,22 +968,13 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(struct audio_substream_data *rtd)
-{
-	union acp_dma_count byte_count;
-
-	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_high_reg_offset);
-	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_low_reg_offset);
-	return byte_count.bytescount;
-}
-
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 {
 	u32 buffersize;
 	u32 pos = 0;
-	u64 bytescount = 0;
+	u32 dma_count = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -979,11 +983,15 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) &&
+	    acp_reg_read(rtd->acp_mmio, rtd->dma_cntl) == 0)
+		return 0;
+	dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+	dma_count = acp_reg_read(rtd->acp_mmio, rtd->cur_trans_cnt);
+	if (dscr == rtd->end_dma_dscr)
+		dma_count += period_bytes;
+	pos = dma_count % buffersize;
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -1016,7 +1024,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
 	u32 loops = 4000;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -1030,9 +1037,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
@@ -1066,7 +1070,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..4740804 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -131,12 +131,13 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u16 end_dma_dscr;
 	u32 pte_offset;
 	u32 sram_bank;
-	u32 byte_cnt_high_reg_offset;
-	u32 byte_cnt_low_reg_offset;
+	u32 dma_cntl;
+	u32 dma_curr_dscr;
+	u32 cur_trans_cnt;
 	uint64_t size;
-	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
@@ -157,14 +158,6 @@ struct acp_platform_info {
 	u16 i2s_instance;
 };
 
-union acp_dma_count {
-	struct {
-	u32 low;
-	u32 high;
-	} bcount;
-	u64 bytescount;
-};
-
 enum {
 	ACP_TILE_P1 = 0,
 	ACP_TILE_P2,
-- 
2.7.4
