Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B148AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8332084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7Wfxz4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8332084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJZQiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:38:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40332 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:38:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so271405lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7NpKPSz0A7lAh2QMGTe5hISfmW+FWnrDsxztH/tnCuE=;
        b=d7Wfxz4k65Xvg/XIROGkZFMU9GjGCkrCCPtK+FlBLyNQuv0wp7eZ4Smi/bYQswjthB
         Oo3MyeNxwRzd2IiswKld52NGyOtTrT/p6GkIob2vDjbuCiZZltVuxBTFngaEStttJkcJ
         49QsufRvlmI00R85M72UKJpo/RvHQWQx3iPXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7NpKPSz0A7lAh2QMGTe5hISfmW+FWnrDsxztH/tnCuE=;
        b=oG3O6HTWJRCKE0930B5XlWAiNeT2wAJ/+XO1jEBumEgJk+7xCA15ZoGcD2bRFKyOLm
         ZbIcsD/GC76VIVPDxVbdpiwHljxhM0hap7yJArrB5xuzYgFET/EKvLbxvl+5dgnjnlki
         jYF2kZ4g9wRDgWHL312XphrH5RIinNw/9HRaZzMuEFsgjNqibojJ55m1kTvsNhsrTFPx
         g9FUcNq/59YViBbWhoVE071f2iHseNRLeuUyACnr5i89Fs7f1R9yqR1B+UKczgpfYVSJ
         vsj49sgjy5mHqcKCMyw5gCMYFYgxenbIO001H60DHabTjDGt3njZDwFvBjwm17iNke2y
         gM7g==
X-Gm-Message-State: AGRZ1gIogdGRDxXYSE/+vTk/u3A9QMtjbiLpaaVqWb64nCvmSRB4RvlZ
        yCnaN0EH2V4zXxlwzZHpSkF4ap40qq8ygy+M83b5IQ==
X-Google-Smtp-Source: AJdET5eMBgFkV8CtTv39gpWGyVkGdtRjIhNLpVFmh4beAt0orGpKnmqZWeNFP+jZXOnVn0FNDFfjIn0vYI7uCOt6rwg=
X-Received: by 2002:a2e:8684:: with SMTP id l4-v6mr1768719lji.52.1540540931137;
 Fri, 26 Oct 2018 01:02:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 01:02:10
 -0700 (PDT)
In-Reply-To: <20181025212429.GB18016@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com> <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com> <20181024204439.GA32300@amd>
 <79c29d20-ae6a-4a12-28fa-93d7305a0623@gmail.com> <20181025212429.GB18016@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 26 Oct 2018 16:02:10 +0800
Message-ID: <CAMz4kuLgV2Nz9yX3y=nT-_jiuFGSA+CY5g7EWQN4Yu-+oojH1g@mail.gmail.com>
Subject: Re: More checks for patterns? was: Fix pattern handling optimalization
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26 October 2018 at 05:24, Pavel Machek <pavel@ucw.cz> wrote:
>
> We don't want brightness < 0, but this may not be best way to do
> this. We also don't want brightness > max_brightness, but I'm not sure
> this check is effective.

I think this is reasonable, but we can simplify the patch as:

diff --git a/drivers/leds/trigger/ledtrig-pattern.c
b/drivers/leds/trigger/ledtrig-pattern.c
index ce7acd1..3a4ecb9 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -250,10 +250,11 @@ static ssize_t
pattern_trig_store_patterns(struct led_classdev *led_cdev,

        while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
                cr = 0;
-               ccount = sscanf(buf + offset, "%d %u %n",
+               ccount = sscanf(buf + offset, "%u %u %n",
                                &data->patterns[data->npatterns].brightness,
                                &data->patterns[data->npatterns].delta_t, &cr);
-               if (ccount != 2) {
+               if (ccount != 2 ||
+                   data->patterns[data->npatterns].brightness >
data->led_cdev->max_brightness) {
                        data->npatterns = 0;
                        err = -EINVAL;
                        goto out;

>
> We probably also don't want pattern where all the delta_t s are zero.

Yes. Maybe add one function to valid the patterns.

>
> I came up with this so far....
>                                                             Pavel
>
>
>
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index ce7acd1..bc5f495 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -250,9 +251,16 @@ static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
>
>         while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
>                 cr = 0;
> -               ccount = sscanf(buf + offset, "%d %u %n",
> +               ccount = sscanf(buf + offset, "%u %u %n",
>                                 &data->patterns[data->npatterns].brightness,
>                                 &data->patterns[data->npatterns].delta_t, &cr);
> +
> +               if (data->patterns[data->npatterns].brightness > data->led_cdev->max_brightness) {
> +                       data->npatterns = 0;
> +                       err = -EINVAL;
> +                       goto out;
> +               }
> +
>                 if (ccount != 2) {
>                         data->npatterns = 0;
>                         err = -EINVAL;
>
>
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Baolin Wang
Best Regards
