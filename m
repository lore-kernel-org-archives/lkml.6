Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B620578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7lRSvmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfAOBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:07:34 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34951 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:07:33 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so249488vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmcABwfNUJF9dDu8ObsqvMi8NHBXHK+ON9pk86F9MU4=;
        b=E7lRSvmKe89TA5qnFsUOx6/jJh8AlQnop0mN8lFBVWs3j+NcBu3svULuXbrYxwqpVy
         gPp3v/3oVCiK0i2rrACYFivip3z9NaCuC4FKwkRGWCblaAQNDGLia6EZfFj/BmrzWB/6
         bW96eChs2Vl87JMxGoTcAdv+tvLM2JBD7wGSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmcABwfNUJF9dDu8ObsqvMi8NHBXHK+ON9pk86F9MU4=;
        b=gDxQAYoxUQPieYY0GPo27FIELLRKOEKfNUAFuU+ijwFO6N8NQ4hK5uGxoXUO4nzlle
         Tiy8UIgdvjyz44NLg7mjhlWNljWytjMA4SD87Ulf59CIajsGnl31OHAygEmJEYEqRxY6
         JQr9gSuDKy9V0OiX2Kof75YQ9Nb/QhPKHawopnGn+IHFFJi9VXIR0YbJ13LR6iVp9o1I
         Rhg1vFXBoBcYjCW8IvbyT7y/icHdwMEY+q8qtRwEt2qPbt7QPUQrWFzZLIxWLvCuAE99
         1Ui9XQywQm0zr/0XtNO1ZKf2n/p4/+mcZwk8/2WbnNI4FFl201v3+7JPWejiv3TMEi3p
         dQMA==
X-Gm-Message-State: AJcUukdjDK5jG5cWTKwipOGS8w/dX8GV55l71RK3pdyaooLR9edgfO4w
        mMyk5GG9HyO/aY4aKxRKuvr8PKVHW60=
X-Google-Smtp-Source: ALg8bN7jHPos+AGaLTyv75cFju88Q7TXlXc5VH4IpQvvsu6+F7lms+VcMaDy2/8VyhF09ZNBFv+fNw==
X-Received: by 2002:a1f:4158:: with SMTP id o85mr545576vka.42.1547514452473;
        Mon, 14 Jan 2019 17:07:32 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id w65sm4121267vsc.16.2019.01.14.17.07.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:07:31 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id x1so642555vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:07:31 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr607682vsl.66.1547514450824;
 Mon, 14 Jan 2019 17:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
In-Reply-To: <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:07:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKFoTjvr-EHUYHn7TSgEfiwn2BJ1J4Dwu3FGOLmz+TxvA@mail.gmail.com>
Message-ID: <CAGXu5jKFoTjvr-EHUYHn7TSgEfiwn2BJ1J4Dwu3FGOLmz+TxvA@mail.gmail.com>
Subject: Re: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 5:02 PM Kees Cook <keescook@chromium.org> wrote:
> On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> > Change snprintf to scnprintf. There are generally two cases where using
> > snprintf causes problems.
>
> (I didn't find a 0/8 cover letter, so I'm replying here...)

I forgot to mention: can we please get a Coccinelle rule added to
catch these cases in the future? (And make sure sfr is running it? :)
)

My attempt at it was:

@@
expression LEN, BUF, SIZE;
identifier FUNC;
@@

  LEN += snprintf(BUF + LEN, SIZE - LEN, ...);
  ... when != LEN &gt; SIZE
      when != LEN &gt;= SIZE
* FUNC(..., LEN, ...)

But this needs adjustment to deal with some false positives (like using min()).

--
Kees Cook
