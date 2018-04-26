Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx48ZSGv2GwoyZ0rPoxVEFf8C1jLKDRt59bSPvxKJNU5VOsutGbuAdlD+6So7sAHWsF4ozRPJ
ARC-Seal: i=1; a=rsa-sha256; t=1524741328; cv=none;
        d=google.com; s=arc-20160816;
        b=Frqgg5ZvhYSFHq8dZN5t7x5THOS2wpRAkPFh1KcAbvfplVXcXnIL2uLBFyleWAhlBB
         YwwGKYpygnW1GSsnF23Eig6MSSvtIHSvtPc6gc/g2mm04G5fhFUSA/kmu+o31phSAcEh
         WHVV35x9zR6LIGt5HHu5KvXZfXKrbCie7MHua3BFtn+bzm0l6bUCZrACr2s9URuNWhN8
         LKbITYY8JmxCS1VtHjhwsm/OPH0oXVyYnNPMbYqexaPfonG9pbbbskR6f7LGXynFmduP
         mWchQJpLw4ofAvZCGaah815BSFuUijxAlorhs7sPdaYKyOBkysIZlv2znc6w42df8q1w
         /o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=WflTQJLH4FrarZPGM512Jv32kCrLdscV79NQ+onGVgA=;
        b=eFjhfGUuE2PqP/o17lP8vmpgzdoKhOhK9KTevbGTjARHiHfzddJBiofgTN1oJT5o0S
         9+YaCs1opyF2a+B447tM05w5UboUgsvJpd2+937vqSgQK26xfwEdIpbi1gxqYwC99BYV
         FQkSyLVpXVD2wNnwXSCj3u7p+LIFGweB8lSPiOb4Qcv0udl2OCLfAVU7VO+cbg495loS
         yEdcYUiVDHHiIApXjsnnurOjQ1KnYV61mIM+I2hcWaH+w5BJB6jK9aYivVy+SjkckHyy
         7j12eCqI/QoYM1p3NqobQcuD4qxPZGESxKQOe2OFrYgMKirnpS9WyuSDWWHDL9umJLtK
         r1zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=FRpwyNsF;
       spf=neutral (google.com: 104.47.42.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=FRpwyNsF;
       spf=neutral (google.com: 104.47.42.86 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart
	<kstewart@linuxfoundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] ASoC: amd: removed separate byte count variables for playback and capture
Date: Thu, 26 Apr 2018 16:45:50 +0530
Message-ID: <1524741374-13523-4-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(105586002)(109986005)(72206003)(186003)(51416003)(54906003)(2906002)(7696005)(26005)(53416004)(81166006)(76176011)(97736004)(5660300001)(16586007)(8676002)(305945005)(81156014)(77096007)(50226002)(316002)(7416002)(356003)(36756003)(104016004)(478600001)(106466001)(8936002)(6666003)(68736007)(2616005)(446003)(4326008)(486006)(47776003)(426003)(48376002)(336012)(476003)(53936002)(50466002)(126002)(86362001)(11346002)(1671002)(39060400002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0761;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT049;1:vBeraGPVezFrsggQN9wp4MALakm2cmbvVMPsvmxQ5wMitjmF1WcAT+i3myTOqzHmR6EmJRLBVjD6CdnsTakabZ+SIxmVTP3H9H01ttMRM/GHoLfYwSVrPMneEPN9bwCo
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;3:ezE1jNs8eThAy9F1GYbb7PbzxCSZ8zkxVh6HmTqE4VIwvc/67sQNfOeMgjnnVyHkp3VUQS2/djYvc3QBF8Ks4MdKF6r1TokY7hAa7Ntt73HThESyLOm8FrfdlD0qoGv26hyNpUHk6EYKEazfGr4wFFWVWRSmhJHu4UgCsd96sdPt9LncOxlEI4IR5CH8ipyhrk2NFiiS85W9tbT9hYUPiyAFla+h+gNYHe2QgMTrW6IVH6s6A0s7UZnAn4Syr7dosigI+UvG9imcMq3469AcM47l5ZJDvBo3g+eHg6CJ9xS7w+YV5MbkUAaqjyE0SNpMV2vGcfTy13NadlyYeGDq6YD7kztOa94o9fN01GwViz0=;25:4E0yOgEzk/drqVIdTTTwwS98LJhivoHuVu6/ytRLvFORtwDHbeJnGOUr+Blp9oK51lBsPd6SrWezreOpICnhYqGakviQaLCxecdz5jDjVvpjBIg+RhyMe/Xv5uB5E/8CTMFjW5WyysAGCZM98V4/Qnrp/Qtk0UDTBNvfXv9sjXIWn3NgUTa9McNzQNt2KQmaIzX7AFQJKQrLT+x36s2IqztOQgg/PVMEK3jt2Cu4+nyF3bJp0lcrIlwPUxBtzfUTrHT6lluS1Vl2ehxRN7v2S6RVEps8w8jMZsIGOZBkxTd1NZk1Frfrs1h3p7cuWySNIfoYmBMd0eFsG847N/Twly+Pc39dvcKfV5E+FurSToU=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0761:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;31:ifkQ2S2sNTEZ0JSn48kIw6PxXIT5gG8JEDRB0IV9wV7ZITSaCv4G5C0kitB4jGfeIY6hfskeIIDoU1CT7+gnoUlLr6jcSNhYgBN2k/fM5NAkUL4l9x3s2k1fNTUNrC11el5L2E+eS4tgwMdQ3Pa5tcNyrw8FAlODA1vX6VRMXAMWSPZZxpAqWc74j75Ngd/vIDYdIjUK1Iw8+AyyM/obgjCZXVh4VadJDfIBE0cdXMk=;20:+XSDYTHNBnSCCG0XYuDjFAB2mt3W2q0RTEPdx6KWqCobW0qxOUY81XLq5xQAYZ6YOiWVWj+PBXYwaDalT3vXh6dbInJjX6EG+ZPNyPClzKNZI0sx1DecgqpFs7XpePaEECmJ7Udz5XZOE6VXndQodY5rBgCjhsfYli+SIL+N+65t1XuDBAd/S48eaxy4dzImbb1pq0XwXX6rLbxIQ6zlWYTCc65vE4ytc3rfjMJ3Is3+WdvLcVVKll4RcHcFlDm5RjnnQadWhpeZSYp/3iOYiSyhFJBORq4Z+sSRjCSvFKt0IT99/ZPqmkH1+VYTT+Q3J7O2Pjxn9CKl+YD6zAVpBgR6wWU5Dj448XM5y6SWjri2NtUUzhcKiD+uWaPYe/18wa1Y3MmHgiiYYHaAYJ0DcxDtNW7SdE1Q/6wSFz4V+jUtOhDVIYyM3OkGiLY//XsR/sA+KP0u1c37vly+ckgsJ1If6sYvA67ivOU2t2yQ3PN8hSS/EpxJ5ElNcXJZVXO1
X-Microsoft-Antispam-PRVS: <DM3PR12MB07616B5234BD05709297645D978E0@DM3PR12MB0761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM3PR12MB0761;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;4:0GMckGKyZaR+3aTHBOGDD2Mb/r+t5pIZZxiDgo4nH8WZf6bDNRZoQU46+BvUd1aaer1NN1/VNr83bupFpkTJFCH+8KpBcDh67yaw83fveOJX7ifWFSZxTV/C2FOmBPuiD7Cil78yUUBoCgsAvApMxm2JA3cJ+s3rLhs/eM+8oybbHjprYvFc/E2q5LJaCvLsky7gkb6oMT+vIcuNMCbMw/EfsyIUIFwWXPYteNlw2jlOy0cC4nCI2rABOHInI2dM49FneGGpJVU3zxCPpuNJo7oXR1j7qt6ZHsCgyQY19Ld3HKSCe1hkH0R3gQE5BJEj
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0761;23:OoKBBDz0+e4/xrQXU5ek2W1lIvJkc7Usr18U54Jsh?=
 =?us-ascii?Q?kKbbFS3uTDyfLZunes+WOo9IocOxZMv+suDbmU6FhhfGRrFOQWCtUUC/W9W2?=
 =?us-ascii?Q?VEn+TuIH37eT2GdAs+ZNmHP7uXPstluQe3M+DL8Tf6wvTKNaZwEEeBRj8hzg?=
 =?us-ascii?Q?laLUgwOzVWGT/daFRkBph+Z3nU9u4xVMBZCL4aMFsOOxwCACx+++5TwlAvCr?=
 =?us-ascii?Q?Wpl4T8kpd7bIKQxidg6XVNOGa3fVb0o8xPeTVm7Vuepxy0dEbswSRIoN6w39?=
 =?us-ascii?Q?fkhUDt97bfq9o5vEHIS5QvQwjhQYf5tmNa2NBo5xn9gsA+gqzU8+bT/5HcbR?=
 =?us-ascii?Q?WDfh+llPER57gh7v6HoF3nVWKz/BvjPXgF7VQTAgxUBqGual3oKKO7CgoUjW?=
 =?us-ascii?Q?iqz/XO2lEBf2/OLduFzciHDEweY5Yi/tKuHJIbaDtbiNSLvnElC9cpLSRycI?=
 =?us-ascii?Q?kGkJiz8OlK023RrUvkeXksb3gvTvkx1CvIZj2bg6qSaHlmE7/0zf8whk4bv7?=
 =?us-ascii?Q?R+AjjkJ0VKgy8v6tNlfOZVjiF9yYQUSCPQ+ulCiPyfSYcqdZW5DhzJab8zo5?=
 =?us-ascii?Q?QbW9i7qKqMzrKIrKjQYy/6ptTiV7pRIXk0MkFcV8jNWWfYkWYfgARS7wt0PW?=
 =?us-ascii?Q?hS0s00KXCogMYQ+bF+ee/wmoWeF8CTZ3Twwxbr/50qppQKvrdOlHtQNupp3J?=
 =?us-ascii?Q?eCzK1CN80JQnv91xxLd0hkLlkd2v/Dz0Ykx65NDHspyUjUio39YfFC/V/nT1?=
 =?us-ascii?Q?B8NWGAuwwPozuYWo2jkCbYg5oRoXCWitmwIV/j0E5Xs+2OtZHLNyn6gEC4sF?=
 =?us-ascii?Q?9o97Yz6agbdjJxx8dDdY+2e9KgUCQ2MQpmsUgk7WP6g6njlYhQ2AmR1Ror5L?=
 =?us-ascii?Q?2nxK+1T8OvGhnhwkqwkSIJnxf+Irte8cDZWk0wYEG9C7h8YhHp/5t6mfcnwo?=
 =?us-ascii?Q?hqN64LxvvKjipHDO+QBQBVViYj2UMwicIw6jvAt3W1g1la0DAmrYiSjtGzQu?=
 =?us-ascii?Q?990fuxjDJuqrXyscNwITdo8nw9cyK1UPnVPs2dRJPdiwJSyGugQ1ilssoMP0?=
 =?us-ascii?Q?p5mR877QZACzL34OZaPH4ncsL46VzyQbSKzWOnkaR1RHPXdhw9Xe1YWuMziE?=
 =?us-ascii?Q?wSsNsT7B7xcQmkayu5sqrH0evc8f0ZcN6oHTvEvoI7FtLH0fKGqgl/4rHclP?=
 =?us-ascii?Q?/Chz7/HvSC+FRAuD3vFDCIFRR44ryoG001hTu9WFdY7ajPjQvZgO16h32H4V?=
 =?us-ascii?Q?wXsKow+n2HUrY54C44=3D?=
X-Microsoft-Antispam-Message-Info: pjAJbxZDxV3YhM0RXvdbXYtTQ+Qu0w85Ur+Wo3WkRpR6leSEu+jjZKO2+bMOERclDIb9OBj+0UT1Mi0XWrGchP7tpA/x+dAS8GVa5S8BC7qpLy4ypjFWghv8Hj3pBatqkHvhAAjIJij1Moi9CZEV2qC9f7qirAS8zcQMPzDJNMPLjsH47Kijk6m5DzYY8aRn
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;6:AxeNZ1Fcp0KktBorC9dQsyD15MkgvKFJoQ6nr8VA0ta5E/Io7nJnSAqt/lCKgXwTPs5aaadYVQFqy3KwmOgljisNaynlRZCIJF60gsV4aeRcXB0CKxtOxpRJ7LmxZOxkFm5XM5/LEMD1WfJx9qqWbxKz3duCZ3IKyOF2fFOc/lFkIg6eB8jPgeFKu6DacOcvRKovD2qS+Pv1G5832Z1hXg8kuaG8+b0wH4edMqBq1s8ttlSUBLA6tABlVHovBVVa2MP2kb+tyWpWt2gXLFe+ecM3jIXU29FhK0dH0d9dJkxlt92TutiR06tqci7YUpXD3PAcFWbEtLHCD7YIstpKxzIpdlMRo/Qw/HTFSf2Stsx9mS6jcDJ/7wuhbUmthyh9+ZSZH0Wh9I6uX1Ua81It9azXBDFSG4POe/fc2XdJE/ZNpbGakkkc5ytE1yiCZsQ58kcG63JbHh2lm2mOvdQdCg==;5:E7pbqNZyB83N15pU+joNBHH1Uf5edR7LqRjR3jp91PKHU889lH65kmf3/axi9M1uYjEQtFqVtJMIqR2m++R9TmhFQjsnTbxOGcNxceGAx3upC0sI6+ao9axynAdjkwDxF90m+x58XNUo2BBPMDFFkjeqNZOOlARXT9l0C/UWYKA=;24:vG4OHLm88ZMA0la8Zzo2Nd1hdwUhcyLTdWU4IExiGgR+lMGqs5hw1mW65NidA8RQYeGk7AFXgckLfLvBF/TtktlkP14tEvhqjLPdWEw4hmM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;7:gVWu9yFtRswIdpFs5axw7Wq0aYbkFLyKBlUQDYhZ7cj18ZDHDobXeCT0z+xHpntzrECryX8T3G43GtJWUp7aACrkrQ1b1082FNe9OoRCQDkZGEZyxH1sgNKIOxjtMaqXawM9Zo+MSH5uGWg0qHxdD5RrhnAZutLZylZdd4spcMkfwPGQZAuZwLLmzsNjuwzvCEQDSpYbJqbxT4C9ioXJGN5FFsQ3fMxzyp1uafCQphbIOQf5Q22oCntQnjs6BL2t;20:hGQ1r02dPlbly/h65nltnJtrLQNli1mbkjF4CTyXCPakMvqhSeCXRUnkp4URmyu59NpbgxuEILlfd4WWfVyQmEYsO4wG6p4r2T5mgUIKecM8oByl1XFIhXr+RigagEpDnWOBuScSPNH0RujDxpBt9TtlbkMgRK8H8dYlIPwV/pav34YvyCzbDjGR/DNyshRPrO1w1FOFAufc4WNEqBaN4jEO3vqVuqLbpvM8dAyYWJkHxllm5cHnWUjHkukgJjm+
X-MS-Office365-Filtering-Correlation-Id: d92df93c-0b40-4f35-d7bc-08d5ab67025c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:15:24.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92df93c-0b40-4f35-d7bc-08d5ab67025c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0761
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807163736514743?=
X-GMAIL-MSGID: =?utf-8?q?1598807163736514743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removed separate byte count variables for playback and capture.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
 sound/soc/amd/acp.h         |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 019f696..5f34be1 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
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
@@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 				BIT(rtd->ch1)) {
@@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
 		}
 		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
@@ -947,12 +939,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			rtd->i2ssp_capturebytescount = 0;
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3b076c6..82470bc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -93,8 +93,7 @@ struct audio_substream_data {
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.7.4
