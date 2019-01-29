Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA562175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="OSONzU8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfA2F0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:26:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40919 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2F0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:26:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so11238242vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH6trCpzaH3Y2k6uLe5RNVpinUp6tmuQF7V5r9ojHTo=;
        b=OSONzU8yJ+nMk/zAj4WUxsAVCGu6N9t6lR4yeVjj8HIPjNTHRdgCEFqaG0tU/vBNTR
         uVB0gzFeGeuKFIX0jpB7SBaYJXX2x7nla51RPVJ16Vj006fiSTozkOY2BV2vagBFHJ3K
         8MUL5KQJIo9DAj6zYjTl4iPFOXAJ6DYcsKWtcAywpgEIAG0oRqFei51b1i/CvlTc3/FT
         y55EhAv9qxWViW/yeBw6EPIQ76cgQcKnCRHV+tHUSPLctZVR3gJbUNRfeHWvlbQFcKX5
         sp1ZZrVJw70pXUThJ9KeqAd7+sMb57dBNT0KrpwwWG5QbTrxAovvsAjs2dfx/A+pF/ST
         O3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH6trCpzaH3Y2k6uLe5RNVpinUp6tmuQF7V5r9ojHTo=;
        b=A8hOlHERrZ80wvcZrIWOFrmM8rLKOauiqZrZ7fulXEdnDKYiqiYOnzg9MfnZX6rs+M
         Im6I2sJIxoWBvk8kiC20avyw8k67pL9H9ZZyuz2C/fh6PYYHu1jtuavOcBP5gBrUlmO4
         umUcOyr0tujIRXJi1PipAjAOQvUWveYp342DYCXzbaFdDetYvcnqLh3OgHZEaOac3rSC
         QFwfcfoNILCIlaZ0SKStg/owZUS4CRtp/VA4Z9Nx1swzp2d2yAMfBlJvLxmrpvuG4RCW
         hlTNVWzgpIMk4y+f4G08L9Y8VIranFrtXR76npRNx+9cEqlwZv0yZjUDs8F5QzSzUx9O
         FC0g==
X-Gm-Message-State: AJcUukfF+Dvcd5hbovaGUBjPGJOB+gbKzv54Uiq1BSGuotPHShvZ7aSN
        SE94DRDTNKpf+9jX3Rcpy4zHqYM3YzfblTQ69J/30w==
X-Google-Smtp-Source: ALg8bN48jypXkVnqZGK94xXBy1Kzp9q+L0Mts6N8+4yYZEULKtP8gQvkwZ7VchzhkyPQj6M3NkbJEkITiP99fo0gmn0=
X-Received: by 2002:a67:e34e:: with SMTP id s14mr9958507vsm.95.1548739580811;
 Mon, 28 Jan 2019 21:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20181224062235.GA27815@embeddedor.com>
In-Reply-To: <20181224062235.GA27815@embeddedor.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 29 Jan 2019 10:56:09 +0530
Message-ID: <CAHLCerMrJ9VB7+zNzhj5WUiM6nOGT=GbrDEHzvPTp7fsfi3f8g@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 11:52 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/soc/qcom/rpmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c7beb6841289..12c057a0b325 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -362,8 +362,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>         if (!count)
>                 return -EINVAL;
>
> -       req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
> -                     GFP_ATOMIC);
> +       req = kzalloc(struct_size(req, rpm_msgs, count), GFP_ATOMIC);
>         if (!req)
>                 return -ENOMEM;
>         req->count = count;
> --
> 2.17.0
>
