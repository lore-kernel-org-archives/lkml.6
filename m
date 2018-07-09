Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB607C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D62F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Zoxva2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D62F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbeGIVg4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:36:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41840 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeGIVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:36:48 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so38682154oiw.8;
        Mon, 09 Jul 2018 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dcf1z5fESRBeTSnem1zEw61UCTDV8BKhkunh4trWMjg=;
        b=B4Zoxva2disaZJYVTR6MdryTd0gpxmm8pyjJd3W29YnbTwk/wdtHa7z7at7bMQkf/U
         sEhzQ0smRIQ7F+TPnpks0kvCQCbbXfOKZT6rR8Z3Q4YUnHRNjNSdN63v8TWEQrsjNfO1
         A+xJ8jo1/n9xdG7RevHTOes7hvbyxmgAuqYFqKGQlolliR8lwSFwBALsFw1+19ozV6wq
         zo8BRtdsb6cARbTD4sq+vgWUHn01+8d0/spkJQego1jeRAYbXoex/9Rnub1UKB2+bm0L
         51pyUspVfonbcwgjyu2zNGA5fTNYazr2PDTWexP+MBsrYsgwZqcxsin6tnPtR2CWrM9p
         lQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dcf1z5fESRBeTSnem1zEw61UCTDV8BKhkunh4trWMjg=;
        b=YMVG/3YdKGTKzopol8nyLbmQ9dLW8v4KZpgXsOB6l4rHt8k/NPf8L1mnWocdQXRXng
         lRmccpcKMamKoWlo9ipp8Kj9Ocl19/iJr+0v5bHN9jvwnFlzHZMmsPRKqMne+qsTD7kY
         ANXrM3EOmPry6MW76W570Vpy0+XCo6Uy1TvI+etOxFbmvocwTCrcxF6yNGwj6MR8dN2K
         ASxzAv78pyqlXcsRnN/EI0W59CrMi/5XQW0qQ7y1OFYkrF7HcIsv+earw3Jg+vcwDSoq
         S/lqpChkUbr4hrQ+qx7kZ5dANibePVOnrez6TaHA51Mz4IQfiQ75dlArvOylHBComN45
         Iurg==
X-Gm-Message-State: APt69E0gQiwi3LRTDIM7aY7SQ+3XE7kBfycNuEcC/OxWuLR4yWhMA49s
        o/Wd8lNDHnBQ8vkDR/cf24d1wYCxwFmsg4fWVi0=
X-Google-Smtp-Source: AAOMgpcTZpOPJy+lCxtPPKBvrMmwt3zlKzM4/wDDSDa8qS2CyYhOvJSYuCQ/Q86GcqTv2z76iD23d8KNC1plvCVpI9U=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr23704551oic.358.1531172207878;
 Mon, 09 Jul 2018 14:36:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:36:47 -0700 (PDT)
In-Reply-To: <20180709161129.28425-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-4-daniel.vetter@ffwll.ch> <20180709161129.28425-1-daniel.vetter@ffwll.ch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Jul 2018 23:36:47 +0200
X-Google-Sender-Auth: dma-v-kgZNWUnx2djS_y5bNY0CE
Message-ID: <CAJZ5v0jzc-V1GWAQbYUTbYQVm_DGZp1GpwAq158uW6Z6Sv++uA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use for_each_if
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Engestrom <eric.engestrom@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 6:11 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Avoids the inverted condition compared to the open coded version.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Eric Engestrom <eric.engestrom@intel.com>
> --
> v2: Fix the logic fumble in the 2nd hunk, spotted by Eric.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or do you want me to apply it?

> ---
>  include/linux/cpufreq.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 882a9b9e34bc..3a774f523d00 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -649,9 +649,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
>
>  #define cpufreq_for_each_valid_entry(pos, table)                       \
>         for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)   \
> -               if (pos->frequency == CPUFREQ_ENTRY_INVALID)            \
> -                       continue;                                       \
> -               else
> +               for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
>
>  /*
>   * cpufreq_for_each_valid_entry_idx -     iterate with index over a cpufreq
> @@ -663,9 +661,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
>
>  #define cpufreq_for_each_valid_entry_idx(pos, table, idx)              \
>         cpufreq_for_each_entry_idx(pos, table, idx)                     \
> -               if (pos->frequency == CPUFREQ_ENTRY_INVALID)            \
> -                       continue;                                       \
> -               else
> +               for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
>
>
>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
> --
> 2.18.0
>
