Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C737257A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2tJCgwB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jE2d9vyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C737257A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964904AbeFYSVl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:21:41 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33011 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934772AbeFYSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:21:40 -0400
Received: by mail-yw0-f195.google.com with SMTP id u124-v6so5114792ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B7A0tAi5faH8Xv4shRMvO61nzEADjdrrFxtytoPVlao=;
        b=Y2tJCgwBIUEYhW+vRZE2xDcIxBnDeZyc3xwn7jNiqreAqGH/w+HxiCM9v0Z5zj5VhS
         sl2lKIYhfWqop2GZhPJ1YwDmd8oFTug9q5NnD3y/VxeH2Qa9wqiNzTcnCtCbI5UoVg8L
         W7Nm5w98LWqZ6jK1figiUHEE9wzCtD88ZZdUOab46zGIynh5hkP8QZ8AzqYiYhzFZtZf
         hILFvYZf29ht0ODvDwz5Js4XHc0SxUi83UEK17fgLGOrhf/XPepvLFezLXTt1+4Qam86
         VdlDmXOavUYoKxYTIdWINYlyeL1YIjRBYfqpikXbqRqHR2nAal9v9V2Xt6RjGEe+CKI+
         wFOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B7A0tAi5faH8Xv4shRMvO61nzEADjdrrFxtytoPVlao=;
        b=jE2d9vyFF8gCJ8BJhw2Lbuj9mJT7bTdb5vGfgOGKQMTeVKQHo/BXlBr1DbolTSlHkm
         PhvhCe0x1tWTPNSPLDtJkfrG6vjFyeLW17EUjdpPKo+xKvmNfDXSj6C5PsqKVMr5LnOI
         1ImcyLNoAV8h+2MLKvEVC44L4QsriKxlTXJn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=B7A0tAi5faH8Xv4shRMvO61nzEADjdrrFxtytoPVlao=;
        b=etLX+hucIBrEvOKJc/izci+IsfIgOd1DbAPwrcXYs7HMuQkywFmu3vvE35nygAHlG5
         37Sf/RoQ/JC8pAdhke9f3cIAhX1AcFhuJqj9nlJqC+WeGrcU5fRG8zTSYftW2ELPJ/Bl
         0VyFp9k9rdUJRihyz/n2EFWaC4DYRRqTRebCQ8u7WhyXfHvfqCkDR7qVzW4t8NL593tL
         PwiatLaNMPCuj/LJ8bGpIt27RG/Y+H22pJUyqj6fMTGHH7l2MyJ5nr7sPhcXnH2NE0AN
         40Ot8GNCRm2XP3FdsgZ8qZ72h49O9nUp5DiYM8FflQph4adsiUW1wwjjTkg4JijOJQ+B
         4lMg==
X-Gm-Message-State: APt69E01qkxsvmRvvXZaUbbmcV4GdgkFu14PBQWfgc+KrYyUbprAFrWU
        j8pJ2CvJpYRAprMWzr0XJ5gLnJOtmSPfnIdE7oFLhIsd
X-Google-Smtp-Source: ADUXVKIVa6mGots0rgqXZLbv8Gxl0cXzxUVHA+Brv7fdktBrYqmiRZqFl1a3diJUaj2ArCE35VcugvNyo0Ji1LiW670=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr6536650ywa.116.1529950899271;
 Mon, 25 Jun 2018 11:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 11:21:38
 -0700 (PDT)
In-Reply-To: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 11:21:38 -0700
X-Google-Sender-Auth: 2QEhZCGmQjn1TVWfGMOMdABwUGw
Message-ID: <CAGXu5jL=aEXHKr5ouVdSKwG-y7xSQFLi=x1nwSjFspYiyKL1Pw@mail.gmail.com>
Subject: Re: [PATCH] add param that allows bootline control of hardened usercopy
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:08 AM, Chris von Recklinghausen
<crecklin@redhat.com> wrote:
> Enabling HARDENED_USER_COPY causes measurable regressions in the
> networking performances, up to 8% under UDP flood.

Which function is "hot"? i.e. which copy*user() is taking up the time?
Do you have a workload that at can be used to reproduce the problem?

-Kees

-- 
Kees Cook
Pixel Security
