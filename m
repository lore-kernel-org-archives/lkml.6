Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E3EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED96A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlTAXMMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED96A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeJSWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:09:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeJSWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:09:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so38359347qth.3;
        Fri, 19 Oct 2018 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNv+7ITjT3q8HPDhYxOFruPX3saC0eKt/oD5YGDFlRM=;
        b=RlTAXMMq77iHPv7Fn+w1IuU68xWqGJKvBYlvl3wobzpOjd3egY8AHuVykFhmp90inL
         B4ZLVLBw99SfzFd+ODFn4I9dvzOv3NT2GlwDvv81REA/WGCAOoCf8gfv3gVrX5zgH+K5
         vj/CafFniaIcPEbyEEKgP0SLDcADSiEAkXGtMdI1/mdIhRDB5Nsopjf1vVj5DdR6tNfL
         h9TWeO2oLtSu3I/KeeKO/wEML7TyfpiDD5sOzOke1dPJZMDsXPENhfVJiWAUAaomVJ1+
         dUGDIgtgn0lJILKaYc9VxnMX9WlyscTLIcw6sDR1qfzV6J2tHynOs/gPX3U+uDkRVMkd
         KubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNv+7ITjT3q8HPDhYxOFruPX3saC0eKt/oD5YGDFlRM=;
        b=nupIMF39+SuVq9nLtcfpdVNtyJBhYnthCugfLPx/BOZBo5iiS3VrSHwpJ0IL9SYROO
         VImxL+/C2T2nioisk3UvyR/k5+PudL6BymXe0xX5UYbTClxELC0URfAjkugtSvTGRWyg
         KbKVVvigaZuYw+xzmo5CESKnzlQcW8oYVzXsE4BbLq5JpG+7W7ScicpK081pUybBqujt
         SYB0RkR4fXaqWnbWByZFcmko7ulQfJDQDJ7iuDsfGBvidKbW18aizJINvuz9cX0PBRxK
         R5yT4Li5T/ePm7CYFGl5ZSVYtOiQjGT9v+rrdpXq8jJZwWrOuA6cZh3pv51DH1X7PjjQ
         mX4w==
X-Gm-Message-State: ABuFfohdKaY/Sc9iI5GuzACip2I09LdZMTVWdQLpdvHByxFbkKKQmGpm
        qoNLBwQ3q0Ug8AdMWzDbh7in+k6AftYcJ6c6PTA=
X-Google-Smtp-Source: ACcGV63k9T6BmCIcSkJumuK7zBxWPENKGVge9mDVVb1NxzCA4vcNg3CSW6CLazPPT0gHL9oWevQ1EXAyvu85K4vyF1A=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr32756340qtc.194.1539957774037;
 Fri, 19 Oct 2018 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com> <20181012162816.14396-1-david.e.box@intel.com>
In-Reply-To: <20181012162816.14396-1-david.e.box@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 17:02:42 +0300
Message-ID: <CAHp75VfzQN-OX34Dt8Ce5G98vWyVT1HM86pxoj6BHENac38P5Q@mail.gmail.com>
Subject: Re: [PATCH V3] MAINTAINERS: intel_telemetry: Update maintainers info
To:     "Box, David E" <david.e.box@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajneesh.bhardwaj@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:29 PM David E. Box <david.e.box@intel.com> wrote:
>
> Remove Souvik who has left this role. Add Rajneesh and David who work
> jointly on telemetry updates for new platforms.
>

Pushed to my reviewing and testing queue, thanks!

> Signed-off-by: David E. Box <david.e.box@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>
>         V3: Change signoff format
>
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 544cac829cf4..cbe1595db4a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7355,7 +7355,8 @@ F:        arch/x86/crypto/sha*-mb
>  F:     crypto/mcryptd.c
>
>  INTEL TELEMETRY DRIVER
> -M:     Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> +M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> +M:     "David E. Box" <david.e.box@linux.intel.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     arch/x86/include/asm/intel_telemetry.h
> --
> 2.14.4
>


-- 
With Best Regards,
Andy Shevchenko
