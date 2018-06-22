Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2717C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577E21722
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITlEtCQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8577E21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFVIT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:19:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45004 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeFVITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:19:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id t12-v6so934927ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Njt7jcepfDhoRsfWskcm1WgxpOAtqsJvlnQTNa2O78s=;
        b=ITlEtCQqpRZvwpasoLGjIVrk7puOKKMLNafkFJr5BH55UH46PoRmfvLNFRI1vg4gz1
         HxblcodhgwSj0V9lL4jb7sllSbu6kAo+pM8lIoHZScyJd0tWSluM+AGwjvywwN9Ys2yW
         4IfPF52F+ILHrcFOK/nMLtM5WmLrx9RNtPT4lL67HL4tq1CVkVJWm4jMSEvbCo5hOC3y
         V+orfOEUgmddai0QkN8LTvdhunpibkWQ/aj+ZlNmN0Lt/iyoc02PU1r+FP6d1xveAZEu
         r292InRRb6n6VpIpSJPIG2IQXybdR00Rrtn/wmBBR46gBK4+0USHTSYzXT83VqBO1VOX
         9XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Njt7jcepfDhoRsfWskcm1WgxpOAtqsJvlnQTNa2O78s=;
        b=ToPW3/Ma0nhRZbrjMmhWWCfBeo2uSeAmS8yxXEK3vXWXNHQzbvbIk1+gdF1GInr2EF
         hOmL2PEtgmi1KTtSbUgQQzUnzZnVndxSzlzR0/m+UERTbA2WQXnI7/tiL542jhGINNJH
         /Qs6kmo77rHJUJBQhnK3oRxB5OIbqZgtPZ9A/KAMzATSW98wc5Nrmn+xckqfHRLr8aTu
         uuULC71/bnqyqmlvr613NVe/WDyAFHvIPIYGROyL3M8INOUXxHMW7nllxizHRqa/zIrt
         G5BfLCnhTkfQuGBPK7cV+UEN2YPMV7a/AJa+MrmJYhwDB+p2nqGjR2QXdfIWefSA0MFu
         onOg==
X-Gm-Message-State: APt69E20/ne0dYmdci4uh6gsDDoxoFjLc3aMopDypXmGmAyLiaYD/VAB
        FB/+r/8hWAqT6V4ZUVMdyibMnSLk+dtAIwTSWIpsaA==
X-Google-Smtp-Source: ADUXVKLFq/ojvRo2hgOATo6fWL1v5Nl4AAdg6KvLnf6QK1BIJAZnL0n8Dz2VtLJN7rRhE+vfpnz17of0xQB6JhaBbZw=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr551477ljg.22.1529655592718;
 Fri, 22 Jun 2018 01:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:19:51
 -0700 (PDT)
In-Reply-To: <20180622075421.16001-1-geert@linux-m68k.org>
References: <20180622075421.16001-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 10:19:51 +0200
X-Google-Sender-Auth: ap4f3oXu6pDEMpgueVKRGDH2jWM
Message-ID: <CAK8P3a3OHT-tEHoh7MbGMU5m-L3mNkBVf=L5YgwgP4jQVV9SCA@mail.gmail.com>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 9:54 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> time period.
>
> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> zero for small non-zero time periods.  This may break code that relies
> on receiving back a non-zero value.
>
> jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> not support values of HZ larger than 12287, thus rejecting any
> problematic huge values of HZ.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
