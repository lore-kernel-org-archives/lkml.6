Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA495C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C76F20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP0zwAKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C76F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393310AbeKVThU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:37:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35243 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbeKVThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:37:20 -0500
Received: by mail-it1-f195.google.com with SMTP id v11so12864997itj.0;
        Thu, 22 Nov 2018 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iavgR0IRdLJNomelpZ/PgKMGSqHGkmd/sowLwzntb4=;
        b=sP0zwAKxndEpMYdCciL7PUxY+PyWFAzPzCyGmL0w+4a6MvXvrjQPH8KhTJJsJnbXFS
         KDepHJcVYYFxfmQNM1AQQGCRowidzZ9MGBLtkiUUA68MOgAvSoqFmS1IJ0GuZ0MG6tJX
         03vW/duSmTX5qsNMYt/E8THJMpaOeNZe0hvg5swQqslciE8rCvaqnADVYPaWyehCtoY5
         FtiszBXb+miZ3pKKcgnRJBhQ8XjYTuMnK7ComQbY4VOnHUOcqILVUZiXTGx1J4kYamlr
         tHLDX67X0HuiUzJ42XCQSePf2YZojakMyWUkXpSm8cIzDdfXPWk5gTHo/5HeKUWd855e
         dLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iavgR0IRdLJNomelpZ/PgKMGSqHGkmd/sowLwzntb4=;
        b=DjhaOPN/dsCyiiqM5VN8OQblQuRDD/stx/nhSpGgbKdEnxv4rys1nPCx5Jo0HZPgEs
         +6igVf+j7npV+FUiRv2UWw3bvCRP7C9+S5LL8HwN8bNDqd3txfATfvHui6P1Uing8wdH
         NKD3kQOk7nCgGPLwGiUreY+mqQSqD5JbxE+vXor5066EV74EVHRZflNlO01lny1ue2+G
         Gj65RSkjp7KEs0y1iw0M1nslgIlBw/LKDB4P6uNnCAHDXpnmbDvZ16lfTVi7Spnit0yx
         T2pA70SFbOmEXG7DYvqW46gXuID+dqJfzcIgF5Pq8Mhw//eT+Lh2BxAhGk0QuzEioMNd
         5vkg==
X-Gm-Message-State: AA+aEWboJPh6SmnhHfL8Sp55lm+vzjfQBd+C6LedG+/M5bT3LWCYpNq6
        U/+RengXo+BcPCan7tLKbJP3MrmeYHT4PcfqRxbm1uVf7h0=
X-Google-Smtp-Source: AJdET5dcT9UIyepycFJv/V1HnzmIRg4lCoF/ZCYLEhh872A1DAc9wKavHnEe+Mtcp8LMCufJIHNWpR+xM+BhAcqrjX4=
X-Received: by 2002:a05:660c:681:: with SMTP id n1mr8535364itk.37.1542877127937;
 Thu, 22 Nov 2018 00:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20181122075244.3909-1-natechancellor@gmail.com> <20181122085022.GB5741@ulmo>
In-Reply-To: <20181122085022.GB5741@ulmo>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 16:58:00 +0800
Message-ID: <CAEExFWsLSm5oN+avMS1+HSWjrGNwLhGCm3u_TLDbv+YTRt8+ew@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: Fix terminating condition
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry:

How about change it to this?
            while (*match->compatible) {
This is more beautiful.    :-)

Thanks,
Yangtao
On Thu, Nov 22, 2018 at 4:50 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Nov 22, 2018 at 12:52:44AM -0700, Nathan Chancellor wrote:
> > Clang warns:
> >
> > drivers/soc/tegra/common.c:27:16: error: address of array
> > 'match->compatible' will always evaluate to 'true'
> > [-Werror,-Wpointer-bool-conversion]
> >         while (match->compatible) {
> >         ~~~~~  ~~~~~~~^~~~~~~~~~
> > 1 error generated.
> >
> > Whoops, we have an infinite loop and QEMU no longer boots...
> >
> > https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/160242918
> >
> > Check that the first character of the string isn't null so that the loop
> > properly terminates.
> >
> > Fixes: c57eff9503a5 ("soc/tegra: refactor soc_is_tegra()")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/soc/tegra/common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Wow... that's what I get from not testing this properly. Apologies for
> the inconvenience.
>
> Applied, thanks.
>
> Thierry
