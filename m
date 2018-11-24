Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB56C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BE92086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3p0Lvt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BE92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeKYBpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:45:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40713 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKYBpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:45:38 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so21441087ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnIRUtTsDk0coHd69XNCLP6FIPmcEJNK4cjtgobduz8=;
        b=T3p0Lvt6l30lyatcn5BYbO1IMmsfT3e4z3g0BWj6wNEow5kRYguzQShcMMbs50xPEc
         4DYtH13IBxu2G8ShaOP8euxscZycvsclGk7tM3SNMh8DNHZ4BSZvOTS5Cpn+9u9ramDr
         LECmoLTtWjEDhCZclw9cGGppk2q/KagqqiFJ9kv475tDPaasCLf1A2QINmvOzycz9y4r
         9aZLs9D+7I1vR7kAffMePRfIxYy/yPdYXVMp1lDVFSqeQwkozXh6PBHq99ijfrnME++8
         gDa19n1cx8qWwXxIwial31CVMTCIsoIjGMXx1lKcZDPi2HYxFEU75oHvWCoeG9r7nJG6
         ch1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnIRUtTsDk0coHd69XNCLP6FIPmcEJNK4cjtgobduz8=;
        b=K/39XORx1Xa1hizXHP6RNqnbwNkeTve06rhseUCScrtxPLhNzeYwYzXRCW7gX6RfsC
         sjlNF9XPPueMy+8ZrHOw25NQsx0D0esgTV88bPaJ3t4sURoLxnEzwX8uEQpOiEqqqmta
         0VUMgyIUAk0t07RZJM+hb7NTaiIk6MtjOJpeQQfCs0ANPUQOyHoFYBxWXtk4XdP54ywP
         YjyC7WFJ4P0FV6z3LpVWks/yTKVkREZRLErOLnHe8phEWIUB/NiFG0ew4iyhjQTL+6xI
         GHucfcHdzdacjMaxWbe9tEHnCsYKOktwYvbdccTD74vKa0M4FCpxxwZQBGvW37HNuMDu
         W1iw==
X-Gm-Message-State: AA+aEWaAWLGnwoffGO3km/R6Yt6Lnk52v2J1+ArTghKpeyeb0eYUD7AT
        svFKagHTZwX/Dklop/RUgskd6QcANehkixWb63Q=
X-Google-Smtp-Source: AJdET5cL4FQBcq9bpCscFg3UmCwAHOMLqzra0qDVVqcMWNco3G9NlZuI5SQRJeMXUHmG70oJqg+lARNvTGCv989j9ic=
X-Received: by 2002:a05:660c:681:: with SMTP id n1mr16261267itk.37.1543071421461;
 Sat, 24 Nov 2018 06:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20181124142509.28822-1-tiny.windzz@gmail.com>
In-Reply-To: <20181124142509.28822-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 24 Nov 2018 22:56:39 +0800
Message-ID: <CAEExFWvods_59FKDpzFH9a3ifYd58CAXt3CraP7EebUUVd5n2w@mail.gmail.com>
Subject: Re: [PATCH] devres: no print device_node.name in devres_log()
To:     robh@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 10:25 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> avoid to printf node name.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/base/devres.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 4aaf00d2098b..34c07e9faaf9 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -52,8 +52,8 @@ static void devres_log(struct device *dev, struct devres_node *node,
>                        const char *op)
>  {
>         if (unlikely(log_devres))
> -               dev_err(dev, "DEVRES %3s %p %s (%lu bytes)\n",
> -                       op, node, node->name, (unsigned long)node->size);
The modification of this place is a bit problematic, ignoring this email.

Yours,
Yangtao
> +               dev_err(dev, "DEVRES %3s %p (%lu bytes)\n",
> +                       op, node, (unsigned long)node->size);
>  }
>  #else /* CONFIG_DEBUG_DEVRES */
>  #define set_node_dbginfo(node, n, s)   do {} while (0)
> --
> 2.17.0
>
