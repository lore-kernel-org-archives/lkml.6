Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E455C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3472148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZLOoHzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA1Hdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:33:50 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36324 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1Hdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:33:49 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so17968947itj.1;
        Sun, 27 Jan 2019 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RFSSxz4m/NvoqiruFso6swFM5t1/nFtrAesTHYfanoI=;
        b=jZLOoHzBxp63DXTEIIIW1X9+O6LB16+EDQRAoKqtTPT4GwR0GkiJYktYtm8ZhTLJvw
         gW6w1xDjVukaNQm7LnxF1mPO5N7Dgv+O7ih0PuG4zS9cu4Pp6Q2Jpv6WkFMRVAwf/HOJ
         Zh+fUzefHwRyv+AZfKmDCgHQ+3XOseYYScoWsWA3uW2PVwSSa84LpNGj2okQEBtGslwa
         v3AqFHdh04xVrxCvzXCjGXpsKyP60xYatpBj0nCHr53odLfS+MBXUZaPzMw8auZfy6Cn
         gxNqQr/L5yNAo9wV92qOMQJHH2InY//vTjH3YXtUbhMBpUBStVWu+ufKlO3gRQL8yohT
         WZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RFSSxz4m/NvoqiruFso6swFM5t1/nFtrAesTHYfanoI=;
        b=GqSYpsXnSh4DbEDyEu5Dy5BqB3BKFTFhGRgq4O33y4LpYUUOchruArlZ+mYd7AeReA
         7+a9BoozRTqNlyb6Hma6Rpbl0mMfLkPlXf5r1VOCTYku/XKkDS0vdGkYVpP7ECjHVboP
         9+aiOiShiPPPLvXUeC2AMzaZQY99MdYvVxcsxREX+qhsvmh+Ph5PulLhcniMzm0DLoqE
         X8llOXWw/cJzrbk7xfzFz2RKXqUFZbQnG7YZq4xbscgARaQDv9nM+RuTQTpSW3evh+3f
         P1469kIAaiyxAUDzQnLU7XdZJEfFD8WCbTl3yIFM8SH+sdgGSgVTQAXUcoApTDB/NGml
         4A6A==
X-Gm-Message-State: AJcUukfCHxYSwXuhV9tPMa/BAlNsX1cO1Nu4XEAlbJoqB/7MkxvPUoUV
        smBG8K0NGWj0XXYtuQ0HnLsqtCht8cSO08JEkf0XS+EKBSk=
X-Google-Smtp-Source: AHgI3Iad6/zT4hiXulnJbY2JZzhC5tl8Nk8pKjBhqG/Vya4S1qcJkn5BjiZPGOwrjsN50xyne9FdMh4hZGFRnuu1yD0=
X-Received: by 2002:a24:70d2:: with SMTP id f201mr9260093itc.127.1548660828915;
 Sun, 27 Jan 2019 23:33:48 -0800 (PST)
MIME-Version: 1.0
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com> <20190128071654.GC4678@dell>
In-Reply-To: <20190128071654.GC4678@dell>
From:   Billy Laws <blaws05@gmail.com>
Date:   Mon, 28 Jan 2019 07:33:37 +0000
Message-ID: <CAFUUQHMFm=t_7CfVkieqZqwGAN0U39tHUHTVx6PwbgefkAaeQA@mail.gmail.com>
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19, Lee Jones <lee.jones@linaro.org> wrote:
> Re-sending due to dodgy looking 'reply-to'.
>
> On Sun, 27 Jan 2019, Billy Laws wrote:
>
>> >This patch adds PMIC configurations for low-battery
>> >monitoring by handling max77620 register CNFGGLBL1.
>> >
>> It might be an idea to add lbhyst configuration here and support using
>> custom lbdac values to specify a different cutoff point.
>
> Do you know why this email was sent independent of the original
> submission?  Something wrong with your mailer?
>
I tried to add the reply to manually in thunderbird as I wasn't
subscribed to the mailing list, seems it didn't exactly work.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
