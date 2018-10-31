Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5352081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U050z7kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5352081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeKAFHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:07:55 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36960 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKAFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:07:55 -0400
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so7192032yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mXNW9Z9pdNKylpCYEsjGBtFwSbBTAGrJoPaCRvqHuFM=;
        b=U050z7kz05sjSInfJ7XskyK5mO6beh8HmvrtlaeEFt1URGVgMnx9DeeNg8fNifLwcW
         0kWVk52JFRbuf6WWQteTRmnpG7mjHOQPsmYmNm7z/EpntfEdYTwMG7c5RFD+sPGh1VGV
         KnidEXGhtejxZeR/9doS33G/yxFD8/d2tWdviq9VlKL38hpGr9E2LFtZxOR0svsDEvpQ
         lz3XJfLy20zRyHkQdQ38PR2mY4ejGK5kg4bEnHNFh/r7mwcXPpN96Scy5GMvyj+CRfKb
         8qwPYfozOoUJ8NIMCqWEQBBEDSAM5PJjH51qJUMkdEpVuouVKmvb0BSAzFc4p9juL523
         5oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXNW9Z9pdNKylpCYEsjGBtFwSbBTAGrJoPaCRvqHuFM=;
        b=islkG1Hg1U3bXB4MF4YABEzqQmyhubqiEN0+XYfFsofSpysBoBwVOGDD3HiSnqASOl
         A5F4GBiXWqmiSg2zoW9EnqS5Fjq2iSJVVIIOtzT+HHn6Wf5Lij2kLF/4w08HC41BaCae
         7V7i7aVkGSfmmMPx+QV9JDT47twcnkJ8T7KYw5Vmu0ZeIlfd7KnEGj8MvrfVxC2GxRot
         TMe2AW6g3EfDEQAh2mstwjvvMZ+W0qyG8YJagsD7QHOjTVp2UZeuZxk3FMij5ZeRz689
         K5c8RZvUgJcB8HPFshw5swh6OL8mV6pTXDWhWHb78tfwsdkwjcVj6yQ4uyuG9DkfAwy5
         MpjQ==
X-Gm-Message-State: AGRZ1gIVoDd5xHLNzByxixJkYncAjnTNPiGNx03mixLMSf3RtfEQ8P4Q
        rIPd8sC6TmzNkLHn8U3WXw==
X-Google-Smtp-Source: AJdET5fH1egl9EFDccHNi3I3Mia/P/+mj5/Jvp52amLHx+y7XXnlCsuBhrkMtdRSTfpgcW3vKYuYJA==
X-Received: by 2002:a25:2d60:: with SMTP id s32-v6mr4799142ybe.471.1541016499993;
        Wed, 31 Oct 2018 13:08:19 -0700 (PDT)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id q2-v6sm9721689ywa.24.2018.10.31.13.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:08:19 -0700 (PDT)
Message-ID: <60bede7d2cc0a0c06575da2bcbf06367f15bf4ca.camel@gmail.com>
Subject: Re: [PATCH 2/3] ALSA:hda: fix front speakers on Huawei MBXP.
From:   ayman.bagabas@gmail.com
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Oct 2018 16:08:18 -0400
In-Reply-To: <20181031192013.7701-1-ayman.bagabas@gmail.com>
References: <20181031192013.7701-1-ayman.bagabas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves bug 200501 'Only 2 of 4 speakers playing sound.' 
https://bugzilla.kernel.org/show_bug.cgi?id=200501

On Wed, 2018-10-31 at 15:20 -0400, Ayman Bagabas wrote:
> This patch enables the front speakers on Huawei Matebook X Pro
> laptops.
> These laptops come with Dolby Atmos sound system and these pins
> configuration enables the front speakers.
> 
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c
> index 3ac7ba9b342d..4f7a39c7883c 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5493,6 +5493,7 @@ enum {
>  	ALC298_FIXUP_TPT470_DOCK,
>  	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
>  	ALC255_FIXUP_DELL_HEADSET_MIC,
> +	ALC256_FIXUP_HUAWEI_MBXP_PINS,
>  	ALC295_FIXUP_HP_X360,
>  	ALC221_FIXUP_HP_HEADSET_MIC,
>  };
> @@ -6347,6 +6348,22 @@ static const struct hda_fixup alc269_fixups[]
> = {
>  		.chained = true,
>  		.chain_id = ALC269_FIXUP_HEADSET_MIC
>  	},
> +	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{0x12, 0x90a60130},
> +			{0x13, 0x40000000},
> +			{0x14, 0x90170110},
> +			{0x18, 0x411111f0},
> +			{0x19, 0x04a11040},
> +			{0x1a, 0x411111f0},
> +			{0x1b, 0x90170112},
> +			{0x1d, 0x40759a05},
> +			{0x1e, 0x411111f0},
> +			{0x21, 0x04211020},
> +			{ },
> +		},
> +	},
>  	[ALC295_FIXUP_HP_X360] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc295_fixup_hp_top_speakers,
> @@ -6592,6 +6609,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad",
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>  	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad",
> ALC298_FIXUP_TPT470_DOCK),
>  	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad",
> ALC298_FIXUP_TPT470_DOCK),
> +	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP",
> ALC256_FIXUP_HUAWEI_MBXP_PINS),
>  	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1",
> ALC269_FIXUP_PCM_44K),
>  	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB",
> ALC269_FIXUP_LENOVO_EAPD),
>  	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ",
> ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */

