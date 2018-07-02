Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD02C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7C215F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aW2mzvvo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LHLqz4Xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B7C215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGBQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:14:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40753 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbeGBQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:14:06 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so6849153ywg.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HKEgJNMRLihiKj2s8xnxAiQDXoNYos+PwioxlwKgYIM=;
        b=aW2mzvvoVs7CAafbz5ZtV2hrv592kA/4GXS83XUlMZr+MyatCdpqKypSUmeekLeDog
         0TjeCzOQGW6ud5mhRRxw9SWi1YMNdK0ZJU8mCVRTGWJMlqDRk0XVf3b8StXqWJRH9Ohc
         mw3h1XlxDJiuqMTiU9gqlYeD2mPlC8V6+i2Ii6Sw2VqiaEw7ZT8aEkCK3wRfZemkmGLb
         DGLq3Q98Y0vedEWWFDGmePyNbGThFTPh/TUxPD5LdFeQq6dckXMzVi+EUi7MAXgZcJAr
         mXD7KDD47mzoUNIRzCiHkyZtP5X4/YytRngMMTm/iOmO5mOK95f4/eVp/irieIu6GVZR
         1uvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HKEgJNMRLihiKj2s8xnxAiQDXoNYos+PwioxlwKgYIM=;
        b=LHLqz4XacyuZ1YqWnIfpjwRSiJv9SkLEGIZ3gGxuaUfM6eRAop6oPXTpySAzh42zTM
         RWL8GVGtURm1TJI5wfoCNjbMS2lhH4V+pPIwAj1iBoH4V2u0YUTKnkHMuwCjHocu17d9
         AAf7CV68TvpaOFTqwvmBxQIMVdxqNUJmsPTyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HKEgJNMRLihiKj2s8xnxAiQDXoNYos+PwioxlwKgYIM=;
        b=aEP2vsk/eaDVhOR7lK+HLQu+2weym3Q4ySVp9IZH+h/o3FnKy76txh2h7pEEsPN+Bc
         0LB3sp0kXm2Miasgf0q99GjqwgYNP0h6V4aPXL4my+J+fKGKVLVIgVMX876q87tARIkB
         WQ5APHpwBebdqAEdXASqLibYaiHjwXhjtsnR0CGZlLaVJdHBEmTO+q1fjgpw2jdhyCf5
         4IGlDpAq6C/O3KZVzfOTgxEpEyB1d0uCS5+ZgsK7HK+Z2rv8/rGNJ6yGprCJRiJQJ1TG
         I6EDRHK1nUgoQulDepXkcBkuY5nBQHqUeSK10bK1lGoNQo79hhsO6dM3lWSgNPdsAM+A
         t0cg==
X-Gm-Message-State: APt69E2x8ATlgzkEI3HqpevVRCzR6pG3Xx5lH6L9ZwiXdRK+047W+r7i
        6/WHLJdmfWYIe6ZWk4TpwzNMZFY/2RePXs+ZIAMU0T4a
X-Google-Smtp-Source: AAOMgpeo56oyHM4DE7lxQkeHF/+ebf2OLDxOlJuWGJsum04kfN+5m9Hg6eaQ0y78Os0wFg0e6AdzS1wflTzyw5GZKew=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr13274589ywd.53.1530548045883;
 Mon, 02 Jul 2018 09:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:14:05 -0700 (PDT)
In-Reply-To: <20180702112719.GU112168@atomide.com>
References: <20180618174549.GA1893@beast> <CAGXu5jJZH0fh_q7o2w2_tX3Xxyn2xm-55J62JcucgfWBUYkU5Q@mail.gmail.com>
 <20180702112719.GU112168@atomide.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 09:14:05 -0700
X-Google-Sender-Auth: DUAnf0sztPOo0gthSQM3b_8GtW0
Message-ID: <CAGXu5j+9kPL2cQyXXjW6FfwBmQM3oHFNV-bD+2cgwWpzE12PQQ@mail.gmail.com>
Subject: Re: [PATCH] bus: ti-sysc: Use 2-factor allocator arguments
To:     Tony Lindgren <tony@atomide.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Kees Cook <keescook@chromium.org> [180627 21:59]:
>> On Mon, Jun 18, 2018 at 10:45 AM, Kees Cook <keescook@chromium.org> wrote:
>> > This adjusts the allocator calls to use 2-factor argument call style, as
>> > done treewide already for improved defense against allocation overflows.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping! :) This is the last 2-factor devm* allocation left in
>> 4.18 to be fixed.
>
> Sorry for the delay on this one. As we're already at -rc3, I'll apply
> this into omap-for-v4.19/ti-sysc. Seems there should not be need to rush
> this into v4.18-rc cycle, but please do let me know if that is not the
> case.

I'd like to be able to reason about multiplication vs allocator uses
in 4.18 and later. Since all other allocators got fixed in 4.18, I'd
really like to have this one fixed too, then the scripts that check
for multiplications in single-argument allocators will run clean for
4.18.

So, it's not strictly a "rush", but it would be appreciated. :)

-Kees

-- 
Kees Cook
Pixel Security
