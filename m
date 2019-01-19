Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B281C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A76205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpRsvzGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfASQIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:08:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51421 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfASQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:08:53 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so11041750ite.1;
        Sat, 19 Jan 2019 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FG5gUckh9DdyTJHbL2iXHBN4K0kVRyYdpq6JIbdw0Ro=;
        b=SpRsvzGKDdBkVURRWTBndRJKZolvsy2LyvvLFetH+1jV9b92fXDx62Ck39JS6g3oif
         G8waZxwGc9KTrTPae271IBw2LFXG2DYuuBGuJ0a442w6H1w+Gg8WjCTarM/u8z4bNi5I
         gNH5KrFIEhoFQfuUTIwGWD7jiuRma3DPw4AGasq9rvh8esQMVR5b1m/xp8+dROwyFcEs
         sHeu2irrJ58sfUpGyHX/s2muXfpf2f+vZijl2N4GNeoZN0JY50Lf2klohx26ucFzvIxP
         fJfZ54BwkwUaLLcC442MaWN6aLqrsBeIWZjF0INjj1MjwvpmVoUlU+qjg2yTg8N2ABBr
         Arrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FG5gUckh9DdyTJHbL2iXHBN4K0kVRyYdpq6JIbdw0Ro=;
        b=HTieTL0Kpo1/OUrjgqeKKYP62hUrY3wYIvnShcqDBzCL8NN8MYZ09F571j7LN/EgTg
         9Ygk0ALaxZjyUMKHiRMO5WzY3WfrN6KEP6/gcRT42NuxiqYzn/l33ve/t4XDHqJiompe
         +W5VwxoEvIvXhNLNvmxBeKedtFr6mQLo54bubyIdPJERkpYyRoi9ipAOYCsrLnY0NEuT
         ccLwiGkhXK4Y1Jmyo1s75vxW8qaS38HgESX4eyxP38yUnxw7uaAv2nKzHpxpNeCGbmCV
         i2IVb5eZOpcoV7d4kUXMr2ssBhUrlBFDyPupsq+IRI9UTsRoVdQ4+zSQ4nL1gXsrwEDM
         iGKA==
X-Gm-Message-State: AJcUukfdJpRHKVBC1/a02VEypsYWCGz+LptKv949SIY3XmnI44sQqYIG
        hftyzq41ggAaQXc83/kfGWws9BzAYWfeyLfKmG07JbXNhs/noQ==
X-Google-Smtp-Source: ALg8bN6sVPjl0+Yop/E3bu9gXmMAc9dGV3J7FUhr4TLKZ4tym30nukuypUPz09jQz5LrfVmadfezv++fFcyiWw+gr3U=
X-Received: by 2002:a02:5184:: with SMTP id s126mr12851368jaa.12.1547914132538;
 Sat, 19 Jan 2019 08:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20190119050256.22520-1-tiny.windzz@gmail.com> <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
In-Reply-To: <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 20 Jan 2019 00:08:35 +0800
Message-ID: <CAEExFWt3QcdAYuUCbJP8ZAr2nhQ4gt5zcnMJA5bwyw+rvxzNUw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
To:     cwchoi00@gmail.com
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, you better to add following codes to free the memory of
> 'devfreq->trans_table' and 'devfreq->time_in_state' because this patch
> handles the memory leak of 'trans_table' and 'time_in_state'
> variables.
Hi Chanwoo:

Isn't that the mem requested by the devm_ API automatically freed when
the device is detached?
So we don't need to pay attention to free these mem.

Thanks=EF=BC=8C
Yangtao
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..945f5f1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -593,6 +593,9 @@ static void devfreq_dev_release(struct device *dev)
>                 devfreq->profile->exit(devfreq->dev.parent);
>
>         mutex_destroy(&devfreq->lock);
> +       kfree(devfreq->trans_table);
> +       kfree(devfreq->time_in_state);
>         kfree(devfreq);
>  }
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
