Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JupeUrOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfBSA7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:59:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40092 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSA7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:59:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id z18so10750190vso.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1yfBHI8Q//WBQ0oBmimeToowldh4F8o70yLmpUnyEk=;
        b=JupeUrOZhKPW+Qcob0Ds7iM9ZBNJHlblm6FzS2gw7AfMnKq9Ius2AUTtKJ5Rq83sgd
         T4MvCcO4ZqY5r6of7jFbRhP2K1hShb2IZDFJHewy4MdSTVCXgMh5QV/9ffkq98eM8cL1
         MBxcC8lu1gkex9VzTTtbPhh0AoU/X8NIV4a5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1yfBHI8Q//WBQ0oBmimeToowldh4F8o70yLmpUnyEk=;
        b=pFdoWzLcacB5Cl1oa8lpIyF/gcMZotOq13QQtqPIykpkX6BWC1HmDwd/lF2U4Kmjk/
         O04mIVqS/kACencGXRpVxgWom8oeMWR71m08amuNDxabfnkJUYQXwocaMRdXxm8fuXLj
         744DHI8Xrpsf7ovJGtnnIEHYiKfDV01j5rULHktrfkUJVpY5SKVOf9/DPH/l9+rniJ71
         e+aDFK80ZQ3SuZiXG7QA926DFXUvUPgsR/vCsUpgJV5/4U8YqmO1b0Q6tb77/FL1WW7h
         0rHYuAX6ifYJgqqSUDehiRu6jXr0K86FU1g+2R2ajNlsvFo5tViuxrLlW6ywH1q0O4eH
         9ZyA==
X-Gm-Message-State: AHQUAuYfSFwS/ACv2CU7xBHBiqogyM856qxQZ9KD09Bvyvp63nCvi5Le
        AdjP7MkE8OP+G3n8xOYWzFLXrrkYF/E=
X-Google-Smtp-Source: AHgI3Ibwb0m21bNzVUv0WjncebHEL9ho5S+kw/6SQFYgNhjO23MHwwbwJ/1+P43AKHBLWS3fKWdgBw==
X-Received: by 2002:a05:6102:256:: with SMTP id a22mr6311631vsq.173.1550537991377;
        Mon, 18 Feb 2019 16:59:51 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id w19sm1694996uar.16.2019.02.18.16.59.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:59:50 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d21so6417269uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:59:50 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr13107731uan.114.1550537989755;
 Mon, 18 Feb 2019 16:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20190219003648.GA26354@beast> <CAHk-=wjbNaTu+ktipPdM=_7PEmQ=-ue08zShjDASCsYSTzo1Mw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbNaTu+ktipPdM=_7PEmQ=-ue08zShjDASCsYSTzo1Mw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 18 Feb 2019 16:59:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJXgSEfUr70HpZnLzSZ3HSK56dgkeRzL0ie5RX6i6NOTg@mail.gmail.com>
Message-ID: <CAGXu5jJXgSEfUr70HpZnLzSZ3HSK56dgkeRzL0ie5RX6i6NOTg@mail.gmail.com>
Subject: Re: [PATCH v5] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:52 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 18, 2019 at 4:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This attempts the protection again, but allows arguments to
> > remain truncated. In an effort to improve readability, helper functions
> > and comments have been added.
>
> Applied directly, in the (maybe naive) belief that this can't possibly
> break anything, and let's just get it fixed for 5.0 rather than wait
> another release.
>
> Famous last words.

Eek. :)

-- 
Kees Cook
