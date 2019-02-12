Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABFCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6AE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfBLOg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:36:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44486 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbfBLOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:36:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so2213727ljb.11;
        Tue, 12 Feb 2019 06:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guuYew1Ncjl7H1KyN/+d4GhN9hKbdQmhfcnFG/18cZU=;
        b=IJm50y3tHXtY48COGEM79qzUYcw7UGn9rjdAsk13OA20ma5DD0Sfw9stsP7/OvRK9b
         dNGW6E55kP1yJ6JIMqnaVIqC3tjLEYHCfsiGRJaO9zDjEp0d2xnwO5YC+TueHHApplq9
         wwcICMqyoBoRjgoaCBcLFfwvmhnhjKYtr/wi3Cp1/+XNL+aNs+U6+RZeYAyJtYl6rGNS
         oCUunJ9iPZ8c1BaqisyHKyiaQGHuauFAf0zVNWNnbZVranFb+rkmpKXYkhQ5SX0nsB1s
         CThFrrPntKiKFx4FuY5/DUw6oFO2dyn1ktTwUxWQB3H2rbMnSvgvjeByBUTGhV1MRZzM
         Cp8Q==
X-Gm-Message-State: AHQUAuaz4pf4nAv+gcitSVQAs44e4wF7dQVw4EoYEtcxseSphiRW6D86
        vRsnmsZUSLo4Y2CcUXmyfiok8LRlHd+9wRP2g/s=
X-Google-Smtp-Source: AHgI3IbPzxguFa34PG3FKW8c0uyEzlnlQmomlROznWScUAB6LPdsjcVkPEXcjkFEnx2R1RHt5rxvJ0a/rDl7O16QcaU=
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr2303448ljd.168.1549982183866;
 Tue, 12 Feb 2019 06:36:23 -0800 (PST)
MIME-Version: 1.0
References: <1549861699-11875-1-git-send-email-guoren@kernel.org> <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
In-Reply-To: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Feb 2019 15:36:04 +0100
Message-ID: <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.0-rc6
>
> The bulk of this seems to be new hardware support code.
>
> Please send it during the 5.1 merge window, not as fixes at post-rc6 time.

Aside from this, I also noticed that the new code is for drivers/irqchip,
which is a separate subsystems with its own maintainers, who were
neither on Cc nor did they Ack the patches.

Generally, those should get merged through the respective subsystem
trees as listed in the linux/MAINTAINERS file.


      Arnd
