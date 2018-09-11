Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74E320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O561XwPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74E320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeIKV6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:58:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40017 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeIKV6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:58:01 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so2431916ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nRqqLayrv/Gyo2l1ZslvLYvqjB4cefFZgIwRCRghGEM=;
        b=O561XwPXLVAq+TPnBlsoRbRgCusciwRRU5hl7JJGMg9Jkn5QKFd9jrRcryObpCgi4h
         0u0C19OmLz/nrEY3yPtxiLE7QJ6jmqZhpU/6UEq09lX1bXw+uLxwYHlDVS/3U3qRGtgf
         /aABVYO64hESZr5wJlt7Lpx6QX7iv37ZU4rFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nRqqLayrv/Gyo2l1ZslvLYvqjB4cefFZgIwRCRghGEM=;
        b=B5xlkR20+hLBjueMQfFU4N+Ejec0vnGRjR04O6KeqN29uWtHelgUVMOwQ6sTLUjCvI
         MhIySl9JM6G03F0rGX/zzVefAQddHKaKI1uj9N51c91MbigbX7jcCYJ2ZtFNc5TK2SER
         WH2VSVRULwvvS36LpsChVobBNZIk75YCcyN2LMm+WTBrQE1vKPxfKzuLqqBKD2oL8/LZ
         jM2d2HYh9a0FRjhaEHpiIK0L/ZehcX03RapdSmVUF7/8j2lUU3x5Adhtv5M8aJ6wlBqA
         arQYg7lLVvBW6EVtpQ5subhOV1/JEdUJZALuJAn/RcKUYqKbEynkHY+qfOSRFXo1at/r
         m8vg==
X-Gm-Message-State: APzg51AfA0SZLmsB1C1qvheDc2YfncS99E00FqbuD5kTYl+vklFYdB9v
        XKlt7VVrT+gdOQCmCvF8YEgFBPt79TG7QY/DTygHrsTz
X-Google-Smtp-Source: ANB0VdZq4dwopSX4cECRbuxKRphZoMQo9E32SiyO1Lf6ojKJe6uzRkHBrbltIOhv0fdDtVZschVe4xCTaFqB2ZzFPmM=
X-Received: by 2002:a24:d0d6:: with SMTP id m205-v6mr2343015itg.89.1536685069471;
 Tue, 11 Sep 2018 09:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:870a:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 09:57:48
 -0700 (PDT)
In-Reply-To: <20180828154403.9207-1-semen.protsenko@linaro.org>
References: <20180828154403.9207-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 11 Sep 2018 19:57:48 +0300
Message-ID: <CAKaJLVs1HxV7ZB_XtrLHq8VXy+HvvGWRE+6KfkafPViQKm_3WQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/SRCU: Fix ctags
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

It's been a while since I sent this one. Can we please merge it if
there is no objections?

Thanks.

On Tue, Aug 28, 2018 at 6:44 PM, Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> ctags indexing ("make tags" command) throws this warning:
>
>     ctags: Warning: include/linux/notifier.h:125:
>     null expansion of name pattern "\1"
>
> This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
> getting rid of line break.
>
> Similar fix was already done in commit 25528213fe9f ("tags: Fix
> DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/linux/notifier.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index f35c7bf76143..2c6ff4cde938 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>
>  #ifdef CONFIG_TREE_SRCU
>  #define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> -       static DEFINE_PER_CPU(struct srcu_data,                 \
> -                       name##_head_srcu_data);                 \
> +       static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
>         mod struct srcu_notifier_head name =                    \
>                         SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
>
> --
> 2.18.0
>
