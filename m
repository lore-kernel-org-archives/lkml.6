Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86590C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B3D21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ty6mLLxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B3D21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHUVxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:53:08 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:36081 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeHUVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:53:06 -0400
Received: by mail-pl0-f43.google.com with SMTP id e11-v6so9191001plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qNKAEdzdN9Q+TXhj9ZUdjvsa3xtTUQbZd07ZfnXALZI=;
        b=Ty6mLLxYa6l/crhHIV1OfSrzOQ5R51SDbjkzforX2gsyPiBOmAT1nM2IbHzn7nVPCE
         aRbmzuRD8vp/v8bO20xVxvhvfA5GvdBSNA7nD/IymCwvhBU3kKKsGEz0qwPw3tIgJpsG
         cQIEmwPmhGGjwLjfrf2tmJ0GGuGh5Q1wyPg3IW9ERX/C/S9C78c9OCZqa9t9+AKo4GqB
         eOhfw4I/U80UseGRh8dPh51071AH+mfNMrQQI+FMMoR4NoE6WKc5uSsDx4XkbcBc0B7e
         4NXCAT+IHMW43BWxe0J5NvkZS0/0kfX11fXcBnKZu8paWmdotVdI80SNdIgAglQvYeDh
         8eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qNKAEdzdN9Q+TXhj9ZUdjvsa3xtTUQbZd07ZfnXALZI=;
        b=cC5293jZK8rzM6CNCD4lUQDb4p7gtuNhPMIWzNYODTwQtKdFFL3iNJET6K7axXSXJN
         mVS4j6qRxN3+baYz+KDWzaRMAXoN+ODkbtDqERezGAR5BxwieFEfBk6RbQQlqEtSaE7c
         Q2DAtkaU1jHaLGIE9sN9wabtQP+G9A9Zk7Qx8CAxi9XqPfOi7kbKPamXMEyyQWRs/hFn
         eYO0V+wvw51+GbN9aA+Y7rJ75J0srYQpa58Bwz3BhwicUl1ZnlGtR14U8klPY/zlHKwz
         Tr4jnE5VV637jkO7xH+B6Vtvcu3uuHgb4AK+bDLdGEhrDF2bhBwNMVFgkH9AMCwgWkQ2
         yTAA==
X-Gm-Message-State: AOUpUlGOicu3cBBqmcwZvOpeHsj+BQUycD7oj1wcymnZdVkOCE3wfoZ/
        7P0rEDHzLWQZTCHH4yEwf5uBgHp66JA=
X-Google-Smtp-Source: AA+uWPz7PgjLT4+iK+sYR0adTjCL5O6sGhDvtWvlBpMrhlDTQZc5h3FB9gqTYbVWfy1aSHaP5oOFbA==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr50944339plg.153.1534876310926;
        Tue, 21 Aug 2018 11:31:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n4-v6sm13249540pga.83.2018.08.21.11.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 11:31:49 -0700 (PDT)
Date:   Tue, 21 Aug 2018 11:31:49 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 11:31:13 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
In-Reply-To: <CA+55aFz8Zt8-3iq-Gop-hJ4FDmK9DVq_pyvuo5Bw=kQHy1VvOA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-4e54e53d-d5c8-4187-8777-58d0b210d20e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 11:15:18 PDT (-0700), Linus Torvalds wrote:
> On Fri, Aug 17, 2018 at 1:28 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> I remember having sent this on Wednesday, but for some reason I don't see it in
>> your tree or my outbox so I might be crazy.
>
> You might indeed have been having hallucinations. I don't see any
> other pull request from you in my mailbox than this one.
>
> Google does find a posting from you saying
>
>  "Below is the pull request I plan to submit on Wednesday morning"
>
> on the RISC-V development google group list, so I think you just
> remembered your _plan_, not your actual email ...

That does sound like something I would do...  It's odd because I remember 
specifically being excited that I finally got the arguments to "git send-pull" 
correct, but I guess that excitement was pre-mature :)

> Anyway, I can confirm that this new pull request is now in my queue
> even if I don't see any earlier ones.

Thanks!

I'm planning on submitting another PR tomorrow (which has been baking since 
yesterday like it's supposed to), so fingers crossed I'm slightly less crazy 
this week.
