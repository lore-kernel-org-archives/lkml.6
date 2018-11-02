Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6577FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF1F2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfnj06zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeKCHNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:13:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46707 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKCHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:13:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id q1so5403625qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KuoUSfvBiAv/XbB6ZBKWmCcCzrYBewE/VVpuiZ7g0ak=;
        b=gfnj06zPIRPEnWzOnKz7WnvldTQcp08+dWJUg7mdLYk8vrPiLbmCvGd8DWrDcsg2ku
         j2VHyROYYCUgyZwlId1lH8M9/Gn6DoFPDg+V+gF1YN+85ep8+p40Q+hFiDKttwhnOMDa
         +Qjmn311nQMvrEE4tdrua8YqKTqlP2bwnGYeeoJqkE1rGqXoFYC60jW8mEtyxwy0+g6N
         5ujYravJAno1WAG+jgDirGRlG3kVmeaDREq4dj9zjAPgL7Oxpb/u6Ojxv6ULRN+siIrt
         eOaX+ruB4/EAGno7aVoKBcsgD3R4H+gcF0VJh6e19d9hLoQecewm6fRY3o2NM3ArhKkO
         HT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KuoUSfvBiAv/XbB6ZBKWmCcCzrYBewE/VVpuiZ7g0ak=;
        b=LbIWZbLrwdgpkVG3kFUGKAYVkNAC8jLUtwcN7QFGGXLRTyVPglZNeVd/cnSak24mpT
         Bp8DtyUUuq4nvpOp15RV6DeUXBS/6frs1MDJIKtEuEWIhyn5vrdZELYiXtMWzto28M+M
         dFgjl3LQ/sv41to1O6zsvGy627e4Md0+rmrp41JpTnb+67A4btGhvDpLDwK3DEBkCoDh
         yrCMYH5g6wI3v9UlKDc31Vu66ONYwffg/NfISK9Hfhp1IuCvDzCmCsytsmZvFWEd0jUV
         TYRUIcXRrPB3rXFvuKG8IuL2PVivcVJ3KB2TXT4z+SXn1OEG8zwrGvXr/ClejFyZIS4G
         Licw==
X-Gm-Message-State: AGRZ1gLkj1GFlZGRj1HahyYK6W4bnD7W/hj05J5Nwnf61pq+2tQ0HaFs
        9vVaGvAIl3LOhg94OPcTwYOfHSPCOqit0ipZoqA=
X-Google-Smtp-Source: AJdET5dNp1TTxp6QnJLOF8gJZqVcHctTjvvclEmS+vX8/01AMVVOwbj14v1vkZkP5Kvtx6qGaZw3hTQYB7memBGarJw=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr4846019qvk.40.1541196270149;
 Fri, 02 Nov 2018 15:04:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 15:04:28 -0700 (PDT)
In-Reply-To: <13542843.KjxkD9786N@anarsoul-thinkpad>
References: <20181102153406.1528053-1-arnd@arndb.de> <13542843.KjxkD9786N@anarsoul-thinkpad>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 23:04:28 +0100
X-Google-Sender-Auth: LxxBTD2bMhK6Wu2pdoqdiSFiTK8
Message-ID: <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
>> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
>> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
>> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
>> into link errors for some configurations:
>>
>> sound/soc/sunxi/sun50i-codec-analog.o: In function
>> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62):
>> undefined
>> reference to `sun8i_adda_pr_regmap_init'
>>
>> The new name appears to be more sensible, and as the symbol is hidden,
>> there are no downsides in the rename, so use that consistently now.
>
> Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier
> to
> fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to
> SND_SUN8I_ADDA_PR_REGMAP.

Sure, I don't care either way. Please send a patch to do that then.

      Arnd
