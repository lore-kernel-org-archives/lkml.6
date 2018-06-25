Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1EEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E80261F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SNQfvF3o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GK1frj3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E80261F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeFYWf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:35:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46359 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeFYWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:35:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id g123-v6so5016181ywf.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xYEbe008VrJdwYdW4UOYZf/SbvbAtZWqvecgZQ5B2b8=;
        b=SNQfvF3ozAmNRn6wlqli4xpbGTu9CEcfTYbhBNBkcZUDeYHMZHGsCqYGEKgBNRv2KR
         G5u3mWTLMkBmE+XzruZh6UPbMDH0knlKUyKCRblSmcuJ32RuKvPK6Vgz61SpEUQu10VN
         ybKKHCXAQIjtqpfnmhmBO1197S46IbhZA0IbQA8vOTto7v9RDDbc26ftDFEn0TMzrNE0
         qp6ZvWVz0NtAiEzvPtpFKXObl3eNmxr84miAShhzg16zhdaI37jZhNETk5LGv1k7+9z1
         V7gF69TUZYqQS33pAHx5jSWHQN9tgJdDIxTMd4I6umaTMpkHWiHYTSFy8jx176tVv1J6
         R0vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xYEbe008VrJdwYdW4UOYZf/SbvbAtZWqvecgZQ5B2b8=;
        b=GK1frj3wa53jRIHBv8BTEF/Ld3PrAxIKvHai/uuY0ivleF8iZk7KmlrIpXUM3m9Vha
         SZrqi9gmg3YgWj0VbJgIiG5CiqwhDYjPG44W9VNL3hjej+IyVf/kBq4G0o0ZrJJ37c8n
         CHYGsutIh3K1Ph1XbcgLGDQNUEZow1+UktEFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xYEbe008VrJdwYdW4UOYZf/SbvbAtZWqvecgZQ5B2b8=;
        b=XdIbTbvoqOPv1EjEVkMLjD3mE6iFS8AoFtuKOTvSuIeqcwqVb4WxNeI8ozotuFZBqn
         06A+9w3asps9yXkxeU9CeHHoDbjqa7JJ/yX8kwFBC66X/+CxI7REF9SCZFE8LmMX6kOI
         sPz1v7QyzUM7zOqKVBHPPqQp3gzky8CdPgxOweg7D67WW4OcsN9uwur8x1MgjDXJ1VI6
         E1gwYB+9SlfNL+svkzlXd9CgmsWTTegY5lH6hIybX2ND8Y7b35uokjaHtHk0/JYGg2la
         emrZNw++tht4hIs9al+ukF/md3ZkVsbkBfj1zHpTW0tgDYIjqDaRAHGUusJQPk0Rwncl
         fs7w==
X-Gm-Message-State: APt69E3qSjLx9zxSHmG1uJSx1txhERJFiDSmJsLKeY215g1Ytk7CJX1k
        FKhyKtiuVmI9B3XnpebQjMUedM/5KE8uDvGIRTzvWfBQw/U=
X-Google-Smtp-Source: ADUXVKKoX1/VyTFDd0S9hnjUHqtc0ST993/1DTOABaVbkNlvO0x+yJLM9/GrGcAlEOyDRczg+eaE4/jb7Tcfal6NN44=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr6921741ywa.116.1529966154877;
 Mon, 25 Jun 2018 15:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 15:35:54
 -0700 (PDT)
In-Reply-To: <2e4d9686-835c-f4be-2647-2344899e3cd4@redhat.com>
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
 <d110c9af-cb68-5a3c-bc70-0c7650edb0d4@redhat.com> <cfd52ae6-6fea-1a5a-b2dd-4dfdd65acd15@redhat.com>
 <2e4d9686-835c-f4be-2647-2344899e3cd4@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 15:35:54 -0700
X-Google-Sender-Auth: LOq0IiPjy6dWhPNOko9oDcJiEKo
Message-ID: <CAGXu5jJGqxKjcWGyAnbkmFebtPor0PEQ+2qpoMCGtjjdYRTHDw@mail.gmail.com>
Subject: Re: [PATCH] add param that allows bootline control of hardened usercopy
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:29 PM, Christoph von Recklinghausen
<crecklin@redhat.com> wrote:
> I have a small set of customers that want CONFIG_HARDENED_USERCOPY
> enabled, and a large number of customers who would be impacted by its
> default behavior (before my change).  The desire was to have the smaller
> number of users need to change their boot lines to get the behavior they
> wanted. Adding CONFIG_HUC_DEFAULT_OFF was an attempt to preserve the
> default behavior of existing users of CONFIG_HARDENED_USERCOPY (default
> enabled) and allowing that to coexist with the desires of the greater
> number of my customers (default disabled).
>
> If folks think that it's better to have it enabled by default and the
> command line option to turn it off I can do that (it is simpler). Does
> anyone else have opinions one way or the other?

I would prefer to isolate the actual problem case, and fix it if
possible. (i.e. try to make the copy fixed-length, etc) Barring that,
yes, a kernel command line to disable the protection would be okay.

Note that the test needs to be inside __check_object_size() otherwise
the inline optimization with __builtin_constant_p() gets broken and
makes everyone slower. :)

-Kees

-- 
Kees Cook
Pixel Security
