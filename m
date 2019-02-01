Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38821872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzY+oKKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfBAS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:59:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42519 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfBAS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:59:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so6251202edw.9;
        Fri, 01 Feb 2019 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm10H4UTLnKEyJZqRQKZFOUja1yf6DwweNlHYKm7RE8=;
        b=CzY+oKKasi/1LTDFLqtNt6UP9FssAec2i7vwRrtJZu5Nmp7MxV8IITPfaU/gEi1lFA
         9nUs1krLTe40jdgKpZ4M3UiPBVdfwInNa0TfAcZKnns+emI+0+Vz6ue2RAUmrCQ2QcBN
         NlMVJpwNrn7iX+zAvj7hj0rrcsNDWkUFXebkVkvtuU1qySQilrnnSqy471xxfXIdTT+e
         DZY10Jf8C6aO6hwwGh/Ta42YbJ2Yj+R3cs6a4QRNE49g/+xcvcYUmMxt92VK+eTGyf1C
         fFV8bzbthFUdLvfx/Zk+nOYnmI77lLSS6ZCUioRM8SVhvI4hsFRJI1RoHSN63BnNyWCq
         dVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm10H4UTLnKEyJZqRQKZFOUja1yf6DwweNlHYKm7RE8=;
        b=kYTnyLdESGWYK/Bj9WAJAhcwXSaLZE39G5Hgy+Vwdjp+3GtpgIX+UNQBJYGW13zXR3
         6y/SU6rT7rw4e1FrVaBjA9dV4lYVbBrxnvWNeC8yLdFIgXlG7eg2IQqlLFEL7Wq92v/F
         F/XJWDUFjlwnm2aAIWpHgGt/p5DPo4muD1luDMlC0XHHnHr1FdGN3mM6cBdL9MqWwaDA
         GWdMmMn/52mXYk4NRgnjAJaWlYPTEA09hsKt4HMISluvijo/zloj62cZYw1rkZGADx7M
         J2VcwgQpc41ksKpDSqGQmkK7uDTrVjQtAW3HpHsPL4iFlp2WufqPwnDG3MN+V/XJlP8A
         oCVA==
X-Gm-Message-State: AJcUukcm2OHj34fBWoYFOgUlSsgI7jjUN8aYT1HX7fhvZlrKUIpY9AM4
        DKhEVfPVctG85wj94cwzgDfEDgPtVs4rzDvRwAr6GQ==
X-Google-Smtp-Source: ALg8bN66rTP1JDvKUlbkZZ2mww0dDU3X7nZsrqrPTWDmBOHjaIVgcVfSNJ3Ri1eubZ8+sfrE9/BtstrH034pslud0hg=
X-Received: by 2002:a17:906:3b14:: with SMTP id g20mr22246598ejf.246.1549047538086;
 Fri, 01 Feb 2019 10:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20190201154356.15536-1-deepa.kernel@gmail.com> <20190201154356.15536-3-deepa.kernel@gmail.com>
In-Reply-To: <20190201154356.15536-3-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 1 Feb 2019 10:58:21 -0800
Message-ID: <CAF=yD-LNyuywx4_ktyy3JcOd1pvFeKb1wyvDj59kbZoVLp4Lxg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/12] socket: move compat timeout handling
 into sock.c
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:48 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is a cleanup to prepare for the addition of 64-bit time_t
> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
> unnecessarily complex and error-prone, moving it all into the
> main setsockopt()/getsockopt() implementation requires half
> as much code and is easier to extend.
>
> 32-bit user space can now use old_timeval32 on both 32-bit
> and 64-bit machines, while 64-bit code can use
> __old_kernel_timeval.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---

> @@ -1121,7 +1155,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
>                 int val;
>                 u64 val64;
>                 struct linger ling;
> -               struct timeval tm;
> +               struct old_timeval32 tm32;
> +               struct __kernel_old_timeval tm;

nit: not used?

same for stm added later in the series
