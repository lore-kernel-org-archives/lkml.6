Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5020817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/T8JXuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5020817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeKHEkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:40:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45487 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeKHEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:40:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id g10so15779147otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRN91ZbCBAOCJszsLQvkCl+4ufByNRJk7q4qv3voVxU=;
        b=X/T8JXuEYlTh/KrhQ1i6ohr1rkweju6mkXCEZ0dbcNyUtzX2G9y2OlZloqanHe63TR
         GGAq0a/EPGr7ymtvo3XvGYtquESNfROK+SVM2zIymbKGIDh8YpcB+PJB7LWfoapQqyR7
         Kzz4QSrK1yOTy+43WSaOfDajuRAdRies9QyMfQEptaNA1SU214YpmBGFBTVEsNArjxFe
         No3lm0tcpzzUym5ESO2XCnAmxBmV2QRDz+tMkVZU9phH+KUh638NY3JUkTSa/krEKOwV
         FPIXEEyYXUNj8+8eeA7rbWcSMFZNjPfarPAAH06AzHRTm5Jq0CnfBsJquJN9zI9x0beg
         o2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRN91ZbCBAOCJszsLQvkCl+4ufByNRJk7q4qv3voVxU=;
        b=q2HGDVkWqEMGGZdWRNjD4OKp3egEkuO59TX36gacwudqGGoSntTHYor0xvkGGBHBll
         tdPOmJUVQ+mu4+7fNxi3NGFLhNeMJonUrwUJ36MgoeX6KfhpMzqiuNuBJuH6UTcsEvaT
         xuiQDz09Ju0TPI5rkZdrbVOHHOWjIEylwQBxexg4KGUjXBDKK+5EdzlIj1NSVcmAKgXw
         wMVcSCejFuGhRWIoJY+qA/MRsdZzMRiBmwiHiC3OtFH2kkR7CYX1MUfaO4Hof0r4hK+6
         DjQ/ZbCzeZlHJJkiDdlRU9pXi/lYH5BLta2LfCdKL6GoB2CE8xCvo/EXMwo5h7BbQv4q
         JyAQ==
X-Gm-Message-State: AGRZ1gIQLZtcr1a+T7BRUDYYkhdfF0pV8tfZ9+0SAxROCVyeMchre0sY
        Dm9nKm5r6pFN8FsCJ9/5Iz+k1i1XLE4sKgn8AvA=
X-Google-Smtp-Source: AJdET5cC7OADQ1n5J7/6GgO7+8k9M7exFR8LTaEffv3CwpQ4zrFnRAQeIvfCsAjeMWPQR0WOCFpHJd5/Jls9Z/HOdL0=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr966703otj.228.1541617718129;
 Wed, 07 Nov 2018 11:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20181105143730.6071-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105143730.6071-1-tiny.windzz@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Nov 2018 17:08:28 -0200
Message-ID: <CAOMZO5C+TSGY4wJmZbMW7rVSp4RKcXLH90Em3D5LxZTP-W00Xw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
To:     tiny.windzz@gmail.com
Cc:     timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 4:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
