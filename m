Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB80C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326D205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaAaPTjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJNAnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:43:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46471 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeJNAnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:43:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so12150857oia.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBV0QO459WTTqFnmD7pZDxx8U0cyPRIGNGBD4H22lDc=;
        b=DaAaPTjgo+XOcS0x2asnXJncPDtmSnkH2rCjORfHnH8ZzZ+RdhWnxz5m7sa0l43XoA
         EwIA0pktSB/fLA63EpRehV24BbfSeoTyq7ezutJcFAOOXxKnzjQVisEEJcfk6ch0DF8A
         SUTVqU0BpFA8Xh2qB4KcByqPOE0zYNBnIt6CqgeK98gLhklONdOXktY1l+a7KukSK+pX
         VUWLxTQu/cM2QDh85WGi1/DZ5G+bMSnCCxip2DWvtOQ7TC4r9PRu5nrDBx2azyvq2zxc
         RWy8v5trMoDqYpDSdGDeeEOdXT+KDP2OefxhhCx7Kwx+azqrHOe7+uzUE92HKxqWqnFq
         Rclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBV0QO459WTTqFnmD7pZDxx8U0cyPRIGNGBD4H22lDc=;
        b=EfM+S0e9fRDi1behJdMQeyJKHzTP/h1DTL5di0frxjlbu/+Ok2TuVWniJ7Vck59bEN
         ek8vvRykegfgdG6wG7AC/+yi59oV9p5h33gmXVVhFjM0Uew91PtgepWE9zfKoodoWEXs
         GO2Jos+EXhHIIKHM5D7XUjMRJif2aAh441/TxdORbYei+wLQ3FpAuB6p+AlMeeYswpzT
         +Qgv6w5X16Fqf7AUMQLOKF4BilTUSBylsby5k2iaEaN4fWyh5b8Y4ZvNq70WXBRhlmNV
         iOflBQ+ZWuMcHRyhwxFFh3rufQLar5TeAUz6TtcqmgsYvjEndtqBdNXt7JmpIxbqYQYA
         I2ZA==
X-Gm-Message-State: ABuFfojqU3aJFwpWgCWF//NwZknXeKvfDrFa8SlXSLFiBlRvFh8IvRqP
        2dphBAzo3Q3lHNpe1Mxif+cijdB87ydALBnDZ2E=
X-Google-Smtp-Source: ACcGV63tUx5Toloynjwfaxqql/W4z6901AYEYJ31xeSirZVVdIUtdnm4Mtci0sMz9vL0qlAU9/iARcXlJnRMRJPIxZE=
X-Received: by 2002:aca:4792:: with SMTP id u140-v6mr5538699oia.215.1539450321921;
 Sat, 13 Oct 2018 10:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539447319-5383-1-git-send-email-penghao122@sina.com.cn>
In-Reply-To: <1539447319-5383-1-git-send-email-penghao122@sina.com.cn>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Date:   Sat, 13 Oct 2018 13:04:45 -0400
Message-ID: <CAGM2reYqEpY9KbMDU6uSaCuzsyN6qcXit930vbWk54PLhvZxZg@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: remove a check that compare if unsigned
 variable is negative
To:     penghao122@sina.com.cn
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        pasha.tatashin@oracle.com, osalvador@suse.de,
        LKML <linux-kernel@vger.kernel.org>, peng.hao2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is incorrect: next_present_section_nr() returns "int" and -1 no
next section, this change would lead to infinite loop.
On Sat, Oct 13, 2018 at 12:16 PM Peng Hao <penghao122@sina.com.cn> wrote:
>
>
> From: Peng Hao <peng.hao2@zte.com.cn>
>
> In all use locations for for_each_present_section_nr, variable
> section_nr is unsigned. It is unnecessary to test if it is negative.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  mm/sparse.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 10b07ee..a6f9f22 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -196,8 +196,7 @@ static inline int next_present_section_nr(int section_nr)
>  }
>  #define for_each_present_section_nr(start, section_nr)         \
>         for (section_nr = next_present_section_nr(start-1);     \
> -            ((section_nr >= 0) &&                              \
> -             (section_nr <= __highest_present_section_nr));    \
> +            section_nr <= __highest_present_section_nr;        \
>              section_nr = next_present_section_nr(section_nr))
>
>  static inline unsigned long first_present_section_nr(void)
> --
> 1.8.3.1
>
>
