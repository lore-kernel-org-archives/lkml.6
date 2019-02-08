Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C59C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D0218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ72HfAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBHVYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:24:49 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42867 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBHVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:24:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so1596725uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjgHt+X2o3TChDtwtjKj2ZhTcSA+h2SvNvnz+nW3PL0=;
        b=aJ72HfAuH4fMeW9R6t0njyc3hfc6FxC3Ri0juZosDoD4VyrvsOtCxUBrJwbvgKHezr
         uOLomOJSTrh7nGWq7LytbilX5gnLKE0TxM9bylmX2qQwM8DD0uCGO/HAvJfV6GAsSOx0
         Fqi8hF119vYw0lx3TwewCYi84iuuCIpV+T9r2zy+wT/E6Gs6nF5FR5ywOaBs5TnPhADr
         bBoKxLC029QwgvwPSqVPO34RZkzOIr7iantm+U6hEee9TC3VGvfEdfusJG5nxfCxxYIi
         3OCc/3szKHOcDm8NPS7nhPh/ck+KESJRFegUZJlXkY+5WMAbcRTL0ieJYAbcIPeg5gct
         sdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjgHt+X2o3TChDtwtjKj2ZhTcSA+h2SvNvnz+nW3PL0=;
        b=p8TEa1SxZg7VZOE7kpQjZfTAGXIJVVdAfYqn54GzmBjZFzsd2VVQQ1kngJc/UW4Dpl
         YwhqWhmgjAC4gBDx7m5GOGu4hxXdwmNhqrcItU0PBqBrG0hC2jVRfeHbKm81Z6dS2Kzi
         MI97+K0/jfhJY9LoE4QFTfJLsu0oLp2CiuRxS1j9sSkNWVHKdg0iBv7qiPoVggH4REYQ
         dcBzeaFagV0X3kspybJpf8O1o8YGZ/QNThwqPTDtGjkJnO9hRcnhIZlTeeuIgaVteQ56
         TtSa6BlsjxugpqtTUkH7dWNH5VMdVTaXWwHV4agrvLjJ0eJ4Euyy8dT++EBTvyWxyg3j
         r5eg==
X-Gm-Message-State: AHQUAub4xzpzOC1g7akjuWpQtEaMG3uoMYhQiNrpz1l0etankj+tGt5R
        +wTaZ49KVflffIw/ACG0nIVW7py0nrLysFoiTso=
X-Google-Smtp-Source: AHgI3IYP0lZ9Akice+ys6JMcejbXt8iRgZxEePdG9MPi/bQxqmAK0+P6WtwSwzD/ONcmxGB8Tc8hujfo8U/mIsS3QMw=
X-Received: by 2002:ab0:4e23:: with SMTP id g35mr9333457uah.8.1549661087693;
 Fri, 08 Feb 2019 13:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190204203254.4026-15-oded.gabbay@gmail.com>
 <20190208121603.GC23483@kroah.com>
In-Reply-To: <20190208121603.GC23483@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 8 Feb 2019 23:24:23 +0200
Message-ID: <CAFCwf13tUa47RYuLCSObYoCyG9+cYUB_Fr8fbHvjYpg6uu5kLQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] habanalabs: add debugfs support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@linux.ibm.com>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 04, 2019 at 10:32:53PM +0200, Oded Gabbay wrote:
> > +int __init hl_debugfs_init(void)
> > +{
> > +     hl_debug_root = debugfs_create_dir("habanalabs", NULL);
> > +     if (IS_ERR_OR_NULL(hl_debug_root)) {
> > +             pr_err("can not create debugfs directory\n");
> > +             hl_debug_root = NULL;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
>
> This function should just be one line:
> void __init hl_debugfs_init(void)
> {
>         hl_debug_root = debugfs_create_dir("habanalabs", NULL);
> }
>
> No need to do anything else, or check anything.
>
Correct, fixed.

> thanks,
>
> greg k-h
