Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F0FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E62206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E62206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeJAIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:46:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJAIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:46:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so7690643pgq.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 19:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uh8huBIzsKo2lF1E7FKT7cx5ODlWVJWF/J4/6Uwa8qA=;
        b=IYlmFpoMYCzBntzEpyOTfIMd5+n+zyz/yIc24ekYefeBGRjlu3d7Ypv4W5w2HCpzmE
         EQn83jtxl8g7kd4TWHaUMttf7f/EdtvV5IyQKcr+rs2TK0+6razoZyndBz3o0tRgDy9N
         k9THILr8Ff19GSs2j0jiYq4BO6mdk3ufVWKCSHgcGFYdavlOFey+3utHqq7xQ1AfJ6F/
         URFHVSeGM0aM/+dFO5SQid9+Z/AeI78vvcjAqzrKt29myeOibaO694ZmiJ9JVu/vi4fQ
         1CVkAyDhVjgzOnuWbzjsuVQlyePg2bFRv2dI+yXanGEK/CKruffWxVfmNiamD0F2lg7E
         BqRQ==
X-Gm-Message-State: ABuFfoitWutGty98IpdYdaLACiueLKJF5jyux5q11t6TnOFdzuef7B3x
        tW3ejVCYLYwchWiPBjVEdIuV4Y0q
X-Google-Smtp-Source: ACcGV62rGvfm7KSzobNpwN/aiKsVUv6V/Dbh5NY0QC0p42755WS5XGbPc9dazxoyX4M5FSAAEWL3sQ==
X-Received: by 2002:a62:c6d7:: with SMTP id x84-v6mr9273727pfk.174.1538359838871;
        Sun, 30 Sep 2018 19:10:38 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:6caf:e2c:fa0a:6628? ([2405:6580:9660:3200:6caf:e2c:fa0a:6628])
        by smtp.gmail.com with ESMTPSA id j22-v6sm14943057pfh.45.2018.09.30.19.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 19:10:38 -0700 (PDT)
Subject: Re: [PATCH 05/11] ALSA: hda/ca0132 - Add DBpro hda_codec_ops
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
 <1538276607-30234-6-git-send-email-conmanx360@gmail.com>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <77622218-5fb8-384b-8e1a-bf55f74ea9ba@sakamocchi.jp>
Date:   Mon, 1 Oct 2018 11:10:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1538276607-30234-6-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch adds separate hda_codec_ops for the DBPro daughter board, as
> it behaves more like a generic HDA codec than the other ca0132 cards,
> despite having a ca0132 on board.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 100 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 4d23eb9..a543b23 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> ...
> @@ -8192,6 +8282,13 @@ static const struct hda_codec_ops ca0132_patch_ops = {
> ...
> +
>   static void ca0132_config(struct hda_codec *codec)
>   {
>   	struct ca0132_spec *spec = codec->spec;
> @@ -8488,6 +8585,9 @@ static int patch_ca0132(struct hda_codec *codec)
>   		spec->mixers[0] = desktop_mixer;
>   		snd_hda_codec_set_name(codec, "Sound Blaster Z");
>   		break;
> +	case QUIRK_ZXR_DBPRO:
> +		codec->patch_ops = dbpro_patch_ops;
> +		break;

This patch looks good to me, but in a view of prevention from
errors in future work (you will do), it's not better to assign to
'struct hda_codec.patch_ops' in different lines which have larger
distance.

8551 static int patch_ca0132(struct hda_codec *codec)
8552 {
...
8565         codec->patch_ops = ca0132_patch_ops;
...
8588         case QUIRK_ZXR_DBPRO:
8589                 codec->patch_ops = dbpro_patch_ops;
...

This is not a strong request but I recommend you to reorder procedures 
done in 'patch_ca0132()' so that:

patch_ca0132()
->kzalloc(sizeof(struct ca0132_spec))
->snd_pci_quirk_lookup() and sbz_detect_quirk()
->'codec' preparation (assignment to members in hda_codec, etc.)
->'spec' preparation (assignment to members in ca0132_spec, etc.)


Regards

Takashi Sakamoto
