Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 592DBC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C720660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NAhfTt0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8C720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932667AbeFKRei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:34:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34138 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeFKReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:34:36 -0400
Received: by mail-it0-f68.google.com with SMTP id y127-v6so11893656itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GyE/jIAODKjXcr9kahCORmuqNdh/8NzZxTjDlDusV4=;
        b=NAhfTt0+DMHHHNmk0ToY4Lq8kNvOiCfbjP/mDYpLm9LdJgcdrwJuKse13jtevSqTHf
         WQQ49bAYO9V46BKB1gsVUBi4cQFd8BZHvZtFlKZ303jvN9Fp3c26ndtoKEH7OEuk60j4
         g1Sgx5FI9v9No0VST/MHU5Gz45aZ13BwEZFuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GyE/jIAODKjXcr9kahCORmuqNdh/8NzZxTjDlDusV4=;
        b=GcEiexN1BNUoC1EHKThOYgLGto3QyX1+ukWZcVdewpgQILs9yHdIaqLjsfeAhXwsE6
         IbW3qdnHlG/GMkulGcVOe/yMGYRT5a8IEILl7HyCur5+4MbJNaxsYbS1P3zM+cgD1XUI
         bE5LSVOIwXnxeEZ7pf89zat1Lb37Qtk+Q6WicH8JoXM+Q9rE+nb3OYsxq6ccwtqvwF58
         KJT/pPxATnLxm6sLGsChpTHN+6K0lY3omT04U6YRm/YX9wNpUtSKYEtsYNFISPsd7G20
         EkABeGAcieA0L+vq0s7FLf0LjgTrsYvNQeskD0i+gQ36qto2LPJ4Sg6tgU3BTuOBEsg/
         bvKA==
X-Gm-Message-State: APt69E2UXJtWYuL34Vk9ZHJzOcredwv3ydUzw83eqOQ3nKkpcyBE9pL/
        qmfsaRxnfvQW5vQI1Pbs8L5xERGiduqkg3p3f1A=
X-Google-Smtp-Source: ADUXVKJjBmUZIGYkZtP/iLMXRrqTZbVSiV5bkYdCnyd/Rcb7GSHBrFVavJSjgAFqSwiucOiKaEoBxOlkz7zxcQUVogY=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr136032itd.16.1528738476137;
 Mon, 11 Jun 2018 10:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 10:34:24 -0700
Message-ID: <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Chao Yu <yuchao0@huawei.com>
Cc:     "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Eric Biggers (4):
>       f2fs: call unlock_new_inode() before d_instantiate()

Btw, in my merge, this got superseded by commit 1e2e547a93a00ebc2158
("do d_instantiate/unlock_new_inode combinations safely"), because the
ordering of that d_instantiate() and unlock_new_inode() was subtler
than just doing the unlock first.

I can't test the end result, so you guys should double-check whatever
xfstest you ran originall, ok?

            Linus
