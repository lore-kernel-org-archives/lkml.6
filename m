Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9FF208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="py21BhrT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PuelOli0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9FF208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390877AbeGLAMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:12:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36419 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbeGLAMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:12:19 -0400
Received: by mail-yb0-f193.google.com with SMTP id s1-v6so10753761ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fbyXeXY9K+gQYs5EYLT4iRofdz4Bdw2dGqT7Y+YVjy0=;
        b=py21BhrTLz4almdWQyx+ecVg1qRuNjZ23MlndgJYfb9DpZLow/372O0Ydus9/Rh14C
         iNTysvvvWS1PaeJEXhKtCQxVn94rvxToqgzmxCTiwX2MQYbzEcLvlhD6jj1q3Dnn3y1D
         w3cXndooFahsqeT9qk2zRZAIa4GmFIiq5M5GUHQ+R/tqmRQ/NK5W3RVo1O9NI/QZVn9+
         eYGxEzYmys3tJqzsyWNSyQYYs8TyKgE7QS6BroVUZevIjaV0Tj6JJs2mra/QmenFV+uM
         B9Im0oRlEx/+IRQGEfc197D5Ea2ptdyF9dcVd/WLJyv4cWdh5eByyIagurYgWNB3XKaC
         78kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fbyXeXY9K+gQYs5EYLT4iRofdz4Bdw2dGqT7Y+YVjy0=;
        b=PuelOli0tWhA5STElVHfqvsfuAWBq3r0Yv6X8Mr+lMtjbTYEn72H0FHJlDaP7EesZU
         FoidAlVIN3002autLKB5z6IWUXqnWzCFmgMbj9Zy/eirH2OEAAndry893nBPxZM+vwor
         Y0OihMKcfSIhwjCDNQaTH/bX4/jfdG9iiqJVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fbyXeXY9K+gQYs5EYLT4iRofdz4Bdw2dGqT7Y+YVjy0=;
        b=r2zr/W/QA4HxDXKeX53QXeEEv9XgACGhwgbk7NqVXwxkkGAVknPjYkG7bClKmlVoLE
         sEh7olQ/byDfp558HNLXmhtOb4p/RSHpGIKsuD3gxG55FSN9UEivtKplotiWdb926Mcw
         Rnryla42Loi66z5nvl3gC7WDOAkWz+u2N3lhjgIS00bP8z0DkqvWImkZT+Fv9ZC4Vbf8
         vpCXcGM5C0u1ckR2etyfcQl1/Lj88/30p/YmH3rxJYU1l+1QSV7zGkaXk0ABXKFIzE60
         zRlosDXJQSRjwh6raduClIugEB3QX7cebALjBQ8BRRRI5XjWwgYzjCJsb5KPxOAF4qxr
         b/ag==
X-Gm-Message-State: AOUpUlF6q18U0xxmLqjEZ49x9Shu/hclXt7vBnP7/joLO8mbmjSoipaO
        Di3my+dtsQhS0uVzlQB2/oGhsO09hY8CDbyIeYyzAQ==
X-Google-Smtp-Source: AAOMgpevdMjI1rxx8VZUEqhqRC8zYnUwmQReBph2+ehou+u2H51ChZk9ntl8HPwzdwfnCBNPceTiIS67/pOi5h0mwVE=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr14148ybj.112.1531353932879;
 Wed, 11 Jul 2018 17:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 17:05:32
 -0700 (PDT)
In-Reply-To: <20180629190553.7282-1-labbott@redhat.com>
References: <20180629190553.7282-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 11 Jul 2018 17:05:32 -0700
X-Google-Sender-Auth: hsmU3eX6kWo8IJR4qLkM5WXHdWk
Message-ID: <CAGXu5jLwhdKy6rfSKOeN2hajP5aCnYeT3yMka5ZbJ_o02z=WTA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the stack
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
>  include/linux/stackleak.h             |  1 +
> [...]
> diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> index e2da99b3a191..00d62b302efb 100644
> --- a/include/linux/stackleak.h
> +++ b/include/linux/stackleak.h
> @@ -5,6 +5,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>
> +#include <asm/stacktrace.h>
>  /*
>   * Check that the poison value points to the unused hole in the
>   * virtual memory map for your platform.

FYI, I squashed this change into my copy of the stackleak v14 series.
(And I just sent this arm64 patch with the adjustments for it to be
stand-alone.)

-Kees

-- 
Kees Cook
Pixel Security
