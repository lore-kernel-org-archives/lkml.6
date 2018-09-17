Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBC1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2681E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmG3uuc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeIRADt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:03:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40365 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIRADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:03:49 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so12269159ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4MvxcIxQK0YX3LzlA7sMwj811mocUxktLgEKX/cywM4=;
        b=DmG3uuc/uBOF7ZRifGSJbWIv8FHVNMycRcAtbJnCxFxq6v+tgvreWWnjbKZ5ykENeR
         EkfQXnd92KGBncmS1C4N5HOY2n1vheYHzMZ9zIysA77V45aIzQq89UPnr3PpEnOuLbwO
         NKdBEDB7BilozItYw8vfS8XHzQscf8PoBG8SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4MvxcIxQK0YX3LzlA7sMwj811mocUxktLgEKX/cywM4=;
        b=A52HvcxOwXdVXUyHfkxyV1CjDSvJrwtpFnjWLj7NVopODiG1tyQQcl9z0yN3Wrvib0
         adn5osDlf9cLc6Knx8oa+IFw2dZhTtCvCWt5yCwIF/uNQbM7qHHN93T1H0HtGORh3ijj
         LrkPMhcFHBhpNITG7Zp0OFovyBzYgoT1mg+MNQeG/bDZYmWrXDBMf21lzKv3XCqGL1Wi
         oGOucDwHv7N/kk74XQoay9dmmBU/k01N5x4mo5qCxEdf0/I/0CHs3ZxpXirh9RV3y1jz
         9PrrRZICPjb2MI6SI9r6AXamQ4fhlG5mbVULR2X/GzNp8IDeh6SBoV8Py90gEszsOFv5
         21mw==
X-Gm-Message-State: APzg51AmjT/N+DMMQnpRQI+0w2+v8cm1+GvUglBsdMt1z9VWnUZPobaT
        owAT/sxSjWNm0qBFHd14/B7GJAfJCDol2q3bbYouvfLOFbw=
X-Google-Smtp-Source: ANB0VdYsO70f2/2RhPowVBnLc/dVbbAqrFt1ugAiZJlGIEZE4PF8npNAVwKUtNE/6dedMAMhkQFVBU0S3aXQW6Ipj5U=
X-Received: by 2002:a02:344:: with SMTP id y65-v6mr24163279jad.121.1537209315619;
 Mon, 17 Sep 2018 11:35:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 11:35:15
 -0700 (PDT)
In-Reply-To: <20180917133041.66100101@xhacker.debian>
References: <20180917133041.66100101@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Sep 2018 20:35:15 +0200
Message-ID: <CAPDyKFrBQHxOr5qfWir7SorJEvmvCjT_jNABwFXhGoR=_Zcc=Q@mail.gmail.com>
Subject: Re: [PATCH mmc-next] mmc: sdhci: fix __sdhci_adma_write_desc
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 07:30, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> If hosts provides ops->adma_write_desc, we should not fall back to the
> general sdhci_adma_write_desc().
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>
> Hi Ulf, Adrian,
>
> When I introduced .adma_write_desc, I made a mistake since v4 -- if the host
> provide ops->adma_write_desc, we should just call it and don't fall back
> to the general sdhci_adma_write_desc(). Before v4, the adma_write_desc return
> int, since v4 there's no return value, so when I prepared the v4, I just
> removed return, this is where the mistake is from. I dunno how to handle
> this case, fold the patch into previous commit or apply it as a separate patch?
>
> I'm very sorry for this. In fact, Adrian caught another similar bug during
> review.
>
> Sorry about the inconvenience,
> Jisheng

No worries, mistakes happens - the important thing is that we fix them!

Thanks for providing the information above.

I have applied this as is for next.

Kind regards
Uffe

>
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0dda6f4b6a24..99bdae53fa2e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -649,8 +649,8 @@ static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
>  {
>         if (host->ops->adma_write_desc)
>                 host->ops->adma_write_desc(host, desc, addr, len, cmd);
> -
> -       sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +       else
> +               sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
>  static void sdhci_adma_mark_end(void *desc)
> --
> 2.19.0
>
