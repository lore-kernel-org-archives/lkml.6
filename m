Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCEC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF652064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMR0Mb9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF652064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJZXoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:44:08 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56307 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJZXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:44:08 -0400
Received: by mail-it1-f194.google.com with SMTP id e17so274066itk.5;
        Fri, 26 Oct 2018 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXv0D7r6O0vfJXkgnfNbiSkxNKT1EH4+3pNCSjaVN6I=;
        b=IMR0Mb9ueIF8ZuwYoAHxCgnWcVjNxx7bBdMltpd11z0eQxFQ7qmv5mBfaaAC/EC6C+
         u++FPknJMo1I4zt24Ti0m5YxvHt5h5vXss8+nk/7wEzOFBFEkw7IJ09CUiGunoORTHNS
         13CF07BNYS7FIHDkadNAofO5wWu794k2y2g1EOuWWstzVAZ8Y2E0PkT9nAoLdyc25nbQ
         0Fyng3o5ksi2aX6GPstKZm05LjZiJ6q3LyBloBMITn2W7VP8UVA+5cb/hcqIv3vMrQU5
         ByaeeoAmREh77v4jVDXsojL4OVyy2dReECC9zJnsnmfRiBsVK35yd9FP0ekbxyd+cp4U
         EjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXv0D7r6O0vfJXkgnfNbiSkxNKT1EH4+3pNCSjaVN6I=;
        b=fnUxDAPjLGrrfvAg+O85LKvnT34f9zvPiLb1qKu+OTCKq9u6tz0q+BRmOa7ahGsH62
         qehDPvrEGzv1KHOON28E2hFIAziP/6bpAlWoarP/VDLOZwqigi6kIfR81AUpq21h3fLy
         1x3jcoV40WaQSmAbrfJ16/IQHKrQFmxJ5j2ljVPzW5Us0MEqk+yU6pvG4ZTeSTHcNYHM
         y3NMx/V9y6H9IJ4BVG//OPlLswHJ7A+vtU1fxN9jdYt8gZ1/XKOnlZv2a8GFEpvp0jeZ
         nwv83C9C3/KCwe6YL5yMWuMU5QFsMWBsiz01r67H/Fyl6t9K1xD9kLGO/nFrWz8vxIbq
         DqYw==
X-Gm-Message-State: AGRZ1gL/pzGb3DfwH4D/oAdZMOeA/wfgxmQtrskdbpxiFasnOQ+5t+ET
        6SwAu4kFYBUb1APg6v5Sne7DUWdETSr4d5J5gNrRa1bf
X-Google-Smtp-Source: AJdET5cY9ImfzMpwTVD0+5OLBs+GYzifdWsY1T4yxsIOh+E8bdS8XZlECZ3sTk/cRAcqomCOi80SKeD7OWynakxO7tc=
X-Received: by 2002:a02:f94:: with SMTP id 20-v6mr2799747jao.76.1540566402631;
 Fri, 26 Oct 2018 08:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk> <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
 <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
In-Reply-To: <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 26 Oct 2018 11:06:30 -0400
Message-ID: <CAEAjamtTcLHhFZ_k6DCyTGS8WntKBeqUBVvJWB7jkAZnd+eq5g@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try to use git as email client.


Thanks,
Kyungtae Kim
On Fri, Oct 26, 2018 at 10:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/18 8:51 AM, Kyungtae Kim wrote:
> > Do you mean mail client?? Well, I'm currently using gmail.
>
> Yes, email client. I've never sent patches with gmail, so can't
> say if that works or not. OK, just checked
>
> Documentation/process/email-clients.rst
>
> and is states that:
>
> "Gmail (Web GUI)
> ***************
>
> Does not work for sending patches.
>
> Gmail web client converts tabs to spaces automatically."
>
> so I guess that won't work for you. You can use git send-email
> with gmail smtp, that's what I do. Or read the above file to figure out
> what will work the best for you.
>
> --
> Jens Axboe
>
