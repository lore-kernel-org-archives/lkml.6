Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE4521473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOIFR+TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE4521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeHCADU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:03:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45734 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:03:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so1835081pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpHNqzP8KKdqEtkiDzZsGSpl7KeAf4dBWHU7tUz20Ts=;
        b=fOIFR+TVhUojuSuNQgCS/66W4GJ5IIaq13iYBj0puJ5XHQUDIvRseyoKsjyUt19zgB
         2GFlJTi6mmq4aaTKfWZFr6fm0jssQasctkEpU2ra+ddB4PI+j17w31gOKIXbQvPFDE4M
         yLr8sGyPACnB4NXpAoSvqZ8yUnOhDedIKIh65N1v5S8HpQMZZ7pTSshgcHtQ7+eOxhUI
         iwxZEVclUACBir4AOQqqLN/A3CMMYS5Fu+HbKpn/b8FimhrQlaeOpN++zYO+3H7GwKJH
         pJGs38Ezea26ehzDM/04pL48G29IomKy6YWOjrXfzPadYMlRoa/BucIeG/oHvBSNC1Mb
         jiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpHNqzP8KKdqEtkiDzZsGSpl7KeAf4dBWHU7tUz20Ts=;
        b=CETxJYnOSn22UHtEkWN3R03HWllZnItyuEoH+YxOl7wbHWjyBknEjPVTKHKQNr0pJw
         ECp13DGj6w+W+4ckjMEEGfGpVwMhzIvrNfwGcan661KI1ajZ784293DhlzyOj9qqO4n5
         EdHknV7+/e6c+wakH07y3kEOUqAdN8f0J73u3PqJD6GJ0EFbyJShtrJVJaf0cnepww86
         qOJMb7SggKPZ7DUGOjDmOMuVjkqr/4l/zmFwQDciIBeVFr8ZG3JknHCnElPwKAsiorZt
         Ux2Pv8tBZ0OnCVSU6efK/sBWEkmjCp3RD0VoWhTGT5Zk5vcQB7gNpn+GLpGDuDzr6y5C
         VP7g==
X-Gm-Message-State: AOUpUlGTgGPe2fjxnw5xcJ/kLc2JGAtZF+Y0rndaUstBWtyCF94vRRdm
        HyuIYUiaayh5gV+MBXdL696I/xz0sA+QX/hHIZJ9tg==
X-Google-Smtp-Source: AAOMgpeJQWhvKqmAaq6B2OKFjF06VJrouZ7MjHW3x5H/GuXTW2yIL4ObBbrYggBJx2LCkssgetGmA+b8OHbDx2wH9N8=
X-Received: by 2002:a62:106:: with SMTP id 6-v6mr1374799pfb.168.1533247812152;
 Thu, 02 Aug 2018 15:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180801215759.103758-1-ndesaulniers@google.com> <20180802.144234.41564686794492805.davem@davemloft.net>
In-Reply-To: <20180802.144234.41564686794492805.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Aug 2018 15:10:00 -0700
Message-ID: <CAKwvOdnp7R094sbsyKi921ZVB8BD+d-8L37mcPv0UjMMF4QqDg@mail.gmail.com>
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to current_text_addr
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 2:42 PM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Wed,  1 Aug 2018 14:57:59 -0700
>
> > As part of the effort to reduce the code duplication between _THIS_IP_
> > and current_text_addr(), let's consolidate callers of
> > current_text_addr() to use _THIS_IP_.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I'll ACk this for now:
>
> Acked-by: David S. Miller <davem@davemloft.net>

Thank you David.  Should you take it into the net tree, can you please add:

Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4

to the commit message? This will help us as Nathan stated previously
in this thread.
-- 
Thanks,
~Nick Desaulniers
