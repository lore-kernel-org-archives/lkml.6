Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2AC26057
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opqNfB5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2AC26057
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbeFYTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:05:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39629 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFYTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:05:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so3043145pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6fyZgSiaPh8aCME7mG0kjnnqZp2lXwmJspozm5XyVs=;
        b=opqNfB5rkHDucExjsNAxU5cnkL5fRkjajGpkfBWyeEJ5WTWaG02KDgPXevVqOIaalu
         7P3ma9ggqFZBDlBp0vBmzuE/yI34vYqHeAz0WKE+JhlXbCogg9aHKougEEN21g6GLS9A
         bRDq5kmbrj2hYjMwDdZ2wdWGrANsgMKZb2bgrfHjXFeSsHqp0qOfw61VqSorTVS7ROAM
         ygo61VqAwYZVTCYclE5/A/DRD63IzTO7SSxFBgxP+VQO83v5JYyGTtoyhilpujebKmKB
         wpmfJhZyJPEGXnVW7OX8qozfX73U9WBkHeaXMVNOzpUQaRNK/42/saAsYS5ohqLYjH8h
         UZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6fyZgSiaPh8aCME7mG0kjnnqZp2lXwmJspozm5XyVs=;
        b=AopJ5ZZcZDQo3NoSwhfdHEdQNylyokfBnUSWmqgywwF5GpxgqiNa5zxgVPHyYAUJFB
         mC6MyuajpQOlXRWP7Qm8GwbLhWC4hOqZrEOGgSjD7Gk1fOd7Eni7KdJcZOsnlw5Z2Lf+
         q/0gF3Nq6LytLbvPrvZp0YsaDXX3nfvRuXQT96CoMF1ln687dyZ0KR+VQIuFEV/1FhYG
         W6Zg+Na3/bdLACfuybEO16rUvUQY0+ZMcf7ZrWYgzFqZs0FJ4aceokAYdL09gxd7MFbN
         22WOYaWdb19JD9UJXaKSWrvANw4W0f7f7i/mO0ahI/Oqc8ej3B3szk1ofHZhhEzQYzX3
         BWsQ==
X-Gm-Message-State: APt69E1g19cZkQrfNwxm7vAC0wypMPjUGTb+0SxCpP38aV03WRPM/MEn
        kw4qKTzdLMxL/MVBojfoEkLiB024jIeJzO6pncr10g==
X-Google-Smtp-Source: ADUXVKKJGDPMsycKusHPjFqxhpOzMV8m6uIe3v6AkaUhvQML+htf8dxWjifpB4zWRgmVs1m3rmSYvfFQ2S7/BPlBIK0=
X-Received: by 2002:a63:370f:: with SMTP id e15-v6mr11609344pga.192.1529953534119;
 Mon, 25 Jun 2018 12:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180619192504.180479-1-mka@chromium.org> <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
 <20180625173502.GD129942@google.com> <3b61527dd119e0ab1025e9e36f666e74a336b180.camel@perches.com>
In-Reply-To: <3b61527dd119e0ab1025e9e36f666e74a336b180.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jun 2018 15:05:22 -0400
Message-ID: <CAKwvOdnisCefufibhYjZKFFSjy87SYVPjUC+y9o=gWDwKit-ew@mail.gmail.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     joe@perches.com
Cc:     Matthias Kaehlcke <mka@chromium.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:50 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-06-25 at 10:35 -0700, Matthias Kaehlcke wrote:
> > Some other instances of the warning that have been addressed are:
> > commit 644d87dccdc69cf79834a72ed0c889580d6af32a
> > commit e2a5dca753d1cdc3212519023ed8a13e13f5495b
> > commit dae1a432ab1fe79ae53129ededeaece35a2dc14d
> > commit d1600401faad4bc186bfdb291d8af644465e20bd
> > commit a45463cbf3f9dcdae683033c256f50bded513d6a
>
> I think all these implicit conversion warnings are senseless
> and should really be silenced by setting them only to be
> output at W=3 with all the other non-static and generally
> unnecessary signed/unsigned conversions
>
> ---
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8d5357053f86..9b1d0d59e8d0 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -46,6 +46,7 @@ warning-2 += $(call cc-option, -Wunused-macros)
>  warning-3 := -Wbad-function-cast
>  warning-3 += -Wcast-qual
>  warning-3 += -Wconversion
> +warning-3 += $(call cc-option -Wconstant-conversion)
>  warning-3 += -Wpacked
>  warning-3 += -Wpadded
>  warning-3 += -Wpointer-arith

I prefer that to turning off the warning outright.

-- 
Thanks,
~Nick Desaulniers
