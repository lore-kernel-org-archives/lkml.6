Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D911C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD77E214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R2m8eTCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD77E214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeHVRCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:02:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40559 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeHVRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:02:02 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so2903426ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTFZJKVAZP79pqrmjkNnSQxp0fUJ5Ifv+ucwOUiirCo=;
        b=R2m8eTCUKtX2QetItNwS93MC9Vov+DIueQUHw3nTTyJzSP3xFLA/tbwJDLj5VIewTd
         1fVCb8GTJTI2tEzktyFRi/O7MqiDreIG2yDtl6xHqVSKcqNGQyrg2KaAeQa9mKvpQkuo
         ax8KNFKnE7ufM5QqDwEnl+1jXpx5JHTCrgumY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTFZJKVAZP79pqrmjkNnSQxp0fUJ5Ifv+ucwOUiirCo=;
        b=Xr2LWOEeO1SL/wVlfMM/Xwu/5skRq7HvHX6lrsxp05bkMPjZq9Ix0Le5nZ7tM4SWo9
         OENv/dSPzwGbBkzcpXJ5Km41b3OJ9sdUADTQnz7KfMtv2xYw2nccbmA/hge7HUZTmUY1
         OsyihynYjVfIW3Qk4XzQgjWLVmQZvCLVaKSp9KX1zHKsDJW7BRECWS2dhkDl7UpbyX6P
         oz2yQtHKhYmwvW8eFxBNr+RwZ9ZdYL+eYNz7dkQuHxYsJIAakMqKDsKoX4axi6g0Ch71
         6Uwhlk/WsqqBLoxtDRla1bzut/wVvjiWzGulbwimyGNdNvOGurys2Ps5AcyDJMwS5LYH
         J/Tg==
X-Gm-Message-State: AOUpUlEs0Mhv5wPr2x2MNUo59yqpSR2phMHFKWXhRxKZcf84CUxlU4YZ
        74xTU9eD9bHIjm1Y+yeS1EcdFjgIPjZqrt6GmK4=
X-Google-Smtp-Source: ANB0VdbmErCQu8YeQ1+E8yWkmc04xkAKWxhjakna8hxnME+yu4NXeqos8HL8lf+ZQWU5v0K2J75jyOYQvQRC4EWVyD0=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr7686042jal.72.1534945024763;
 Wed, 22 Aug 2018 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <8736v8dp6u.wl-ysato@users.sourceforge.jp> <CA+55aFxDWrndr0ZxM4kTJYC5ps+Hno1dCX==4071soSqcEjUxw@mail.gmail.com>
 <871saqefeh.wl-ysato@users.sourceforge.jp>
In-Reply-To: <871saqefeh.wl-ysato@users.sourceforge.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 06:36:53 -0700
Message-ID: <CA+55aFwsupq-iEL+MbNDMbzdsGA6dcMyM2Hs8uHgBZ5r77qnHg@mail.gmail.com>
Subject: Re: [GIT PULL] arch/h8300 update
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:47 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> I fixed it.

Thanks.

However:

>   git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/for-4.19

Sorry to be such a worry-wart, but that tag is signed by a key I've
never seen before.

It looks like you used some truly ancient key of yours for the signing
- the new tag is signed with this:

  1024D/DC21AAD1 2004-10-18

while the previous tags I have from you are signed with

  4096R/0B28399C 2015-06-25

and the two keys don't even have any shared signatures.

I *suspect* you've just changed machines and that your old key is your
real key, and the one for 2015 you created just for kernel signing and
you forgot about it.

And I've pulled the code, but I would ask that if  you have both keys
available, please at least cross-sign them with each other.

Thanks,

                 Linus
