Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C2424E48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iD5y1Dss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C2424E48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeGBSyW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:54:22 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:53772 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeGBSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:53:13 -0400
Received: by mail-it0-f44.google.com with SMTP id a195-v6so13537725itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmoIMGmSpwQjwTXba6zzjqD82456Rmf9sXklUYhjASQ=;
        b=iD5y1DssTnj1WxJ03vGjJnYgiOvmz/VEEN2Ff4EE9of+au3x8SOE8AXPN5grmquPDo
         FmkwZOZUiNnkh526ePusPEnFyGgFuDAqUtrozn2VTgWCqbuiNpcNgTrfbFgMtXOTTi9c
         0FY6RfWSZ3XArTmoeNvsQ3qkWJXwo9rqSOlAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmoIMGmSpwQjwTXba6zzjqD82456Rmf9sXklUYhjASQ=;
        b=J1ryhholD3QuCWhp2CXJT6uewFwztnPj2Zb9TMiMJl2QFLqrUFGRFp1OGD8I53NWG7
         YEIV7tBRB+DdK8OSU1OFz6MUhl6Vo3hfT29wO6uk6mgacn0aiQvx+mpUJtITZ06aEcyb
         +IN6SQWo7YoNmu0JRGgsoo+zbh0sm/z5NQmps5eVLrSaYW4j7N9jLTv8307a7Yr0QeFP
         lS8QH6Or92qqSiZ6vY2cq4xkrSoCQLXKW99wBIb7EiUHBXSCmq1YoZn4+QPrft2Tzu8v
         1TrHv7KybZC4uvUdD83IfA3CH6NhKw7qN7lW7U7xMCTiHyelOk/tbt5OEFy9XvP9IUDu
         jJaQ==
X-Gm-Message-State: APt69E1HZIdxdIlAj1ysD0iC81xiZ6oUHrLgnLockhxPqOmEJy+M5Ia+
        59Jd8YgQlQynXXPELvqK8dSf+Oi/StgymTDkPJURPA==
X-Google-Smtp-Source: AAOMgpcYbx4yDZaWp6q3aegbMjU9c1OIi5/TO7WgjP3t4MAtFMeKIChcqzrPzD39AmjjzPePl59N6HhoTj1X671spyE=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr6757426itd.16.1530557592120;
 Mon, 02 Jul 2018 11:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180630084933.GA15210@gmail.com> <CA+55aFz4BiRVKKwdF+y8K4O1jZnig8mmuQZ7prGp6o+DiH_TeQ@mail.gmail.com>
 <CALCETrWiTEscV8E--v6=+kkvfWKf_OXzVceMjX7GA51uJo-+DQ@mail.gmail.com>
In-Reply-To: <CALCETrWiTEscV8E--v6=+kkvfWKf_OXzVceMjX7GA51uJo-+DQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 11:53:01 -0700
Message-ID: <CA+55aFzakezPMP+=9KAaM+fJtR4BeKWj5MjEuPFwiH6K1wBqbg@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:48 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> BTR is way more leet than AND!

I stand corrected.

              Linus
