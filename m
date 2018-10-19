Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F66C21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hVP+q1UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F66C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJSXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:47:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37344 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeJSXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:47:19 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so4960828ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y3wVap68HOX2guk//IIyTZGjW62jzaoBRNbHauxyqPI=;
        b=hVP+q1UFAg15NM5NJS4999T9xFA+2QNRbhGEPvtASYBmhV+7wq+wTe9RFPHy1xpedz
         e8YjfvDHKGh9EB92+SZp1x/JA7qvfH2ve9rDWHRVd9gsNdRkPznvjQn5WeU2ZTa+mukm
         lSXwdie1suYac/dj6anXvlCBxGBO9f8Oq4x/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y3wVap68HOX2guk//IIyTZGjW62jzaoBRNbHauxyqPI=;
        b=EGXjmpgYafqpjTkyEGuzk9+J86tak6o2YKZYEH6GcKeb4MAuADRQP0AqhUFDAAhEis
         mZnHze7mYDsZZlEl4fxlkFjquwm89nRrxHaQRverTMXr2h1ScXVdJGvhPJgd3veF6k8w
         LXhaLXheq3H7IySdSFBM9j0jTF48DTUotM8oLoCknQMEietPrXnneC5E1J/m40TAJT/Y
         L4wDHp3tyN4IBcDAYBEiFkwMIuvf1ZpprFsrEaGgzbUP8lsBSf6uS4hP6jWBcsdrWY3x
         sd8yI5XQcrR6tY6wKmIopkhVa7dvIjaU/2SrID6L1njy6WYfali5ozwlHZ4j9GT2lgJ+
         bwVw==
X-Gm-Message-State: ABuFfoi+zvzz3O35OrCes5V79rjXWwlh85Wl6HYsALAjxA6p5dvy9KwK
        1hOTMyWhuO8mqJdI6Fh+ZGYz6Hr9vLUNZsQPpbi8hiFicGw=
X-Google-Smtp-Source: ACcGV63aAHZ+3SIItaO7fjflCK6K6uNhqHB8hbV513hOZuW15SrJmCCg5HtBzgJAJbyXegqXTBzhh0sPiGgWx99c50M=
X-Received: by 2002:a02:1818:: with SMTP id k24-v6mr26311040jad.77.1539963641541;
 Fri, 19 Oct 2018 08:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 08:40:40
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <16382.1539963322@warthog.procyon.org.uk>
References: <20181019122049.27121-1-mszeredi@redhat.com> <20181019122049.27121-2-mszeredi@redhat.com>
 <16382.1539963322@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Oct 2018 17:40:40 +0200
Message-ID: <CAJfpegviiy=9fru3zButbqLnhshH85srH3qyZO2zf-_RPqSs=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] uapi: deprecate STATX_ALL
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:35 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> +/*
>> + * This is deprecated, and shall remain the same value in the future.  To avoid
>> + * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
>> + * instead.
>> + */
>> +#define STATX_ALL            0x00000fffU
>
> The comment is misleading.  STATX_ALL is *not* equivalent to
> STATX_BASIC_STATS | STATX_BTIME, even though it might be numerically the
> same.  You would need to update the comment when you add STATX_ATTRIBUTES
> to mention that also.

The definition of STATX_ALL is, and will remain, equivalent to
STATX_BASIC_STATS | STATX_BTIME.

What is misleading about this?

If you feel confused by this comment, then maybe I should just drop that part.

Thanks,
Miklos
