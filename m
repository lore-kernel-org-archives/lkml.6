Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AE4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4140C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noUuiEjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfANVdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:33:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33952 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfANVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:33:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so229792pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZ8gvssZ/nyR2KF9Y+HMZ8ajKxpeRu6X+yi4Xwckv+A=;
        b=noUuiEjm7ZTOlMjIop0ki/e6FXW6XvVqVnzSKjjzhNF2f21QxAtOzlmCIzswTQ6fM0
         jbRtnsCh2nXVk6b4CzEcs+RPpTRH+NbgRQtbhGYKZZdRlO1Vof5Jb2375YFzq0IFkd4N
         MB4Bv2eep+FxSzaP/PDg6xnVXCoPJ4FAsCfwwJWtqvoW6b+55vE7WwcmlxwQP67ufgEf
         oRu8Z2glWsXD3YPtL4cyButlM0yOJBpNXd43e7CwuhLKyLol6uzIhLy8anP4T0q7Xpag
         A0WnRai9N8XV1c3u7TpCg8gBSY1DzPtDypX4BRWXtTzjZvBEmGcdUpDwONIhp8nfbWWe
         sdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZ8gvssZ/nyR2KF9Y+HMZ8ajKxpeRu6X+yi4Xwckv+A=;
        b=VEXUO+T6sfArj05Enp42hbH5/T4A1D5svv4nTw6ygD7GPoygMvivgpxpGgwwe/HQAn
         hE0AhJMHccSgLWOzV4cAGk0PoeaJq5zi3zij7LAelXEEDh4/u1COzvvr4Fue8cShKscv
         jybxTxcZ9Lo/IGMcyKb1EJNhLvpDHMjp2PBmTyJhazpq8c4W3La/d5hIDTqUlPNAp7Wc
         mF8Ekm3ukBLoHw8fQj9ocRa5w5on+aXgnI5LREBopBBdFDAuNMRUFrKWfMqwqcfb8qiD
         zmXLJTVySjs9h0QaCyVPDAtbcieiNTDd9iqxKYx2typ3ZKINz1UdmsCSMQFiqdNXAW4E
         9TNw==
X-Gm-Message-State: AJcUukcMzr5lIP+CdtF6lTE7TvLL2rnSBRoEiMUhh4Xjk4lKZHRJLKGH
        H7E7x63JYII9s5WT3t+GmHvTj7vEv29CxANpRFuWtg==
X-Google-Smtp-Source: ALg8bN5QQ6Be7HN9dE0aXTtj8PFff0Bhs2BAi6+cLvCn6afLUqOkRFpIEYFhWNnm9+5mm7WJFnEw46HNkNmKtU3qYzI=
X-Received: by 2002:a65:4683:: with SMTP id h3mr492422pgr.225.1547501583977;
 Mon, 14 Jan 2019 13:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20190114210426.177543-1-trong@android.com>
In-Reply-To: <20190114210426.177543-1-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jan 2019 13:32:52 -0800
Message-ID: <CAKwvOdkoN1myuDM1OFga+v30LQ9pV5VD9J_KCJN1Z7AY+kaXxQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] gcov: add Clang support
To:     Tri Vo <trong@android.com>
Cc:     oberpar@linux.ibm.com, ghackmann@android.com,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:04 PM Tri Vo <trong@android.com> wrote:
>
> This patch series adds Clang supoprt for gcov.
>
> Patch 1 refactors existing code in preparation for Clang support. Patches
> 2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
> Patch 4 simplifies config selection.
>
> Greg Hackmann (2):
>   gcov: clang: move common gcc code into gcc_base.c
>   gcov: clang support
>
> Nick Desaulniers (1):
>   gcov: clang: link/unlink profiling data set.
>
> Tri Vo (1):
>   gcov: clang: pick GCC vs Clang format depending on compiler

Thanks for sending Tri!  Doesn't the output format require llvm-cov, or no?
-- 
Thanks,
~Nick Desaulniers
