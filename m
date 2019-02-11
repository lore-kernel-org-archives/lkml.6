Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FCDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A442229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R7SOBHX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfBKS2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:28:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44828 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfBKS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:28:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id a16so5545404ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSPVW2NMcPPdzr+75OjW10PNfn+ROi7Iwu293MaFsYI=;
        b=R7SOBHX/qKEZAN/FbdqmfuQRLxAsb57zz/oMhyUoJWJ4h8GHbIXNKV1Pf1GSasttuD
         KBVpTqhzrg9/zQf56BdVKs1NQ2KUy3kMO2/r3lpW1pHCKd5w9v9M5xb2uxfdpdCN2wNV
         LO1pvoiZaawEQ4DmMuD+jXDeco0yXSi/J/OlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSPVW2NMcPPdzr+75OjW10PNfn+ROi7Iwu293MaFsYI=;
        b=tU3Lmq7TuSCddygAxc6JVJjmLCb/F5B8JGttarISBCRyUZKIv6VZ+oSWyI9Dtl+K/x
         Lex+f9/Up6b61dafUFgLg+mwSxM9zdHx8kzaUl6U8Frdl5vWXsNxg5YRH0+xre3E61vy
         /63Y79Yi6gckGgYdgmNHIAo221zWwAbQ/ufV3hojhLExL7YvpQ9ZGkHTzwPXYks9cG35
         VAXeD7BZRrnKV+SGQQYtJABoDRydNxuSr60R6pnIk80ed4bGfc7PRc0Q4RCBESji39YF
         UlYhcAPJDMt8NF7PWwl3mOMdmlDQytJok2jS8ySTi6TC8yTTgVeajw8qUPIdZsiI3lLP
         p4sw==
X-Gm-Message-State: AHQUAuZVJzsfIuCtoUkHcG0kfWVYAcbZAM1E71VOnTrgSBty2uIioAs+
        xUgo+l2Zw0lSTd556Ehas/mlqEYBJFY=
X-Google-Smtp-Source: AHgI3IZtGkksOZLxXXH75RYstSaxfZvf6iHhx4J/UJB4qnMs+22bNwmNx/aAPhLzAhjePuU0Wox+Pw==
X-Received: by 2002:a2e:918d:: with SMTP id f13mr3161503ljg.151.1549909725226;
        Mon, 11 Feb 2019 10:28:45 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d5sm2497289lfi.65.2019.02.11.10.28.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 10:28:43 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id m11so8545990lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:28:43 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr22492916lfh.117.1549909723182;
 Mon, 11 Feb 2019 10:28:43 -0800 (PST)
MIME-Version: 1.0
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1549861699-11875-1-git-send-email-guoren@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Feb 2019 10:28:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Message-ID: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
>
> arch/csky patches for 5.0-rc6

The bulk of this seems to be new hardware support code.

Please send it during the 5.1 merge window, not as fixes at post-rc6 time.

                 Linus
