Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7409621527
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okL8GATC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7409621527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbeHGTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:44:58 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42633 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbeHGTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:44:58 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so6899192ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJJ53J14vfYOQrRWiWYJi7gbq3yu83/NHVkAvFG3pa4=;
        b=okL8GATCTfAQLiRyWO0kTuhDflF4+QI1VNb6iX4XfAuy2Zn5+rrBi/yBF42InHLzdy
         7Hw6HjK7dBuel/msZUXRkFngyjuAhYTz8x0HytsceqqH2Jhd47Z1xP8e0wIwRu1pOjYM
         HW/Ls6C7ZxgPdCx6aMOTNjk/UcBECr0I4R0rwTW5CA2nvojnKfhCa3jhJ+FJfcFDNtfI
         fEfl+7W47oCq/2md+YguADAi89jV/V3BubU+SHFfhpcvgLMHWiz7jcGAymdeB9ohaB4O
         zIKeJdmBFGj2JMau2B2Z9dqqupq76kLZgNKq4dXiuX7XRYqqZB0y6gm9XIZZsb9YiqdX
         ue3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJJ53J14vfYOQrRWiWYJi7gbq3yu83/NHVkAvFG3pa4=;
        b=K5jld0AONc1Exe/khLUKVoxShOrlr5skgilvKO/nFncyaXimuIhrgYKTLaVzB7Y06T
         vJFJBqTbJJn0zc/UvXxkG7WSkhtnMgb5ITA9YSqBn4F7HeyPcR/jt7f2rqITMxsrcb9K
         MPeJ11qglOTDRpPbXwY6eQfOi96koXUroyxJEVo59UjYY0hQ+Df4KME4FsWtPr2gRXRF
         bfmgWPE1Vb1vJMIXJIWVDtnTqnp6HFYC2YDqVM4l6CobJrcPzIJbx+p6qMRZ+m9Ts2XA
         HN13zOYMuerYcZn0BI/5E2poQd7NmSjVcpT0NGoXGdOYleeZyGOTsnYYzwGvVm9s59bO
         HNUQ==
X-Gm-Message-State: AOUpUlEkStQ8oKkgouUchXMyjkW53oWrtXxFWwT7701rT8R+b0d8KwNv
        nkS7C3n4SMr6pg67xZm6HzlqRCtdTOweR5S2KyKjkw==
X-Google-Smtp-Source: AAOMgpfT6L6KKjYcTJiM7kjGKZSLs6mnsmcPG5xL/nGmXNkBVRLUSg9eLOOkD9YXYZV9HHftP0HhHUc3zq1dKYWnvBA=
X-Received: by 2002:a25:bd91:: with SMTP id f17-v6mr10317912ybh.10.1533662976294;
 Tue, 07 Aug 2018 10:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180807171940.150507-1-mka@chromium.org>
In-Reply-To: <20180807171940.150507-1-mka@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Aug 2018 10:29:25 -0700
Message-ID: <CABXOdTdTqzsvDfXyrCBY98iP+icj_g=Rig5Lb1Rq0MMQPBGZ2Q@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of rt5677_of_match.data
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 10:19 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The driver expects to find the device id in rt5677_of_match.data, however
> it is currently assigned to rt5677_of_match.type. Fix this.
>
> The problem was found with the help of clang:
>   sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
>   zero treated as a null pointer constant of type 'const void *'
>   [-Wnon-literal-null-conversion]
>     { .compatible = "realtek,rt5677", RT5677 },
>                                       ^~~~~~
>
> Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> --
> Changes in v2:
> - assign device id to data instead of 'type'
> - updated subject and commit message
> - added: 'Fixes' tag
> ---
>  sound/soc/codecs/rt5677.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 8a0181a2db08..47feef30dadb 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
>  };
>
>  static const struct of_device_id rt5677_of_match[] = {
> -       { .compatible = "realtek,rt5677", RT5677 },
> +       { .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);
> --
> 2.18.0.597.ga71716f1ad-goog
>
