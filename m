Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B2C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B371223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhefSlDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B371223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHJGIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:08:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35065 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeHJGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:08:24 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so13612617oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2HnXrY7/eo1Gts0P7tITuTj0xwjhvsQ7ruhjt3n7uq8=;
        b=JhefSlDPIJSN7RiiK+nUGr7JYFSvMRF0sqWTu+GVPGOZ6jl7pvO1z5Sxo6aTXzMzEC
         ZNLp/ZgO/Oaci2db+/snLmF+t8pQgo+usygrzyHziVL8wX4eLjJxMjIA/hoLqh/xecEj
         4iACXafrcf/Ut9MRW6zAd9QXsZfAWvXn5jTX8Lqym9bcuK99s1TGJjh77ZOKLPbZV7I8
         OPIQ9rlaPtK/ctcxivo+eFEEjW7my+7xP8ArK0ZLrEABaSkC4NAjANxCwp0NYoaVpdMa
         nhX4XLSGwJmM4w9W7VdpM3uvGNHpzhGEFlLPw5agsYFkJhZxzVXQNySAb/jgqmCRCWC5
         q7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2HnXrY7/eo1Gts0P7tITuTj0xwjhvsQ7ruhjt3n7uq8=;
        b=cqJ2SV7jDsqNjCSbt1YtCedzM/eyQIyJ9wAa+ZLewReviEBpEKPpkgf0yK+Y5nh0hU
         EASwfXOJqGl7QwdAx/CbmjXJCtAz8PTE4mDygE8K3GMcIEGXTleD332NWiQs4BpihnQ0
         D0wF7JfP7weyP5xk924CEceRQ87U3CcgqyujUSMjJgfn4oMY/USXTNboeB6LCqsPkTT9
         MewH3EmhTzWk1ZxrYf3ryKj7ewz63/NDSAN+X3w5/Bj7JdMX3ta5j1LRnoVPXbH/nu0M
         AnPQd3G+U5n089iGH3OQyihZP/dl7dFH5QekDsjNbRKLN/ACZPUV05egypFnw7tX7dQJ
         elcg==
X-Gm-Message-State: AOUpUlHnCgorUaLdyr5JwfazNKWaj1QTN/xNnozWnfDIYuDg0U/Mly9e
        gcyfmARSavu5nhFKCyO3Sm1/E+vZG+f5x3vBLfY2Pw==
X-Google-Smtp-Source: AA+uWPz94kfQMf3sbuP6r9v9FZfzBRKPqRnhZJrsiyvkXTZmh2yoNKoPKkFYYCkSed0fc2C23k9IOcyqureIqJlOC28=
X-Received: by 2002:aca:ba57:: with SMTP id k84-v6mr4524806oif.10.1533872427262;
 Thu, 09 Aug 2018 20:40:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:13d3:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 20:40:06 -0700 (PDT)
In-Reply-To: <20180810032111.197743-2-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com> <20180810032111.197743-2-toddpoynor@gmail.com>
From:   John Joseph <jnjoseph@google.com>
Date:   Thu, 9 Aug 2018 20:40:06 -0700
Message-ID: <CAOmRg6P53DdsmMKOXpB2RWueU5d2Otzg_gyWgcX+5cPf+wSJ7w@mail.gmail.com>
Subject: Re: [PATCH 01/16] MAINTAINERS: Switch a maintainer for drivers/staging/gasket
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: John Joseph <jnjoseph@google.com>

On Thu, Aug 9, 2018 at 8:20 PM, Todd Poynor <toddpoynor@gmail.com> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Todd Poynor takes over for John Joseph.
>
> Signed-off-by: John Joseph <jnjoseph@google.com>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af64fe0f0b41f..f3466b5c50482 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5939,7 +5939,7 @@ F:        Documentation/gcc-plugins.txt
>
>  GASKET DRIVER FRAMEWORK
>  M:     Rob Springer <rspringer@google.com>
> -M:     John Joseph <jnjoseph@google.com>
> +M:     Todd Poynor <toddpoynor@google.com>
>  M:     Ben Chan <benchan@chromium.org>
>  S:     Maintained
>  F:     drivers/staging/gasket/
> --
> 2.18.0.597.ga71716f1ad-goog
>
