Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30F5DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EBA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxqsH5V+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EBA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933645AbeFLIgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:36:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33022 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbeFLIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:36:45 -0400
Received: by mail-vk0-f66.google.com with SMTP id 200-v6so13919147vkc.0;
        Tue, 12 Jun 2018 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9hgjN1Uh8n9pEECNbkjPZLeKWNu+ACkuy6jgkmZozCw=;
        b=NxqsH5V+X7H35veNxXhZyZrtalp8YKn6Y7+O/xBpd4kYkgrZjbnVwQjcBwmUcBnna1
         JGaTDdKB1pd1/F2CjMZ1K04srr88mArOjQ/c0el7TcCU3UcTAgjxRcEBFED47GRDdB1x
         FOPfewW3yQT03XoC6huQWh0JGo62RdFlOnttgZi8gzjONu3TkIq5rtKzn9X0QNUXdRxt
         DYTfaK1DyhNeBGuI1JIMBddvwtf6yypBnCzDfuSTe3qiBDgNsrMYJB8rxOBYk9SmSnge
         QdkPG2Oi38nmRLeextxt4DPu7okzPGD3UOwGEqaU8Wl3jURv6nMjniTkqOyqzGo037Gw
         YJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9hgjN1Uh8n9pEECNbkjPZLeKWNu+ACkuy6jgkmZozCw=;
        b=JV6Vl/EZaY0fJgEL9a3BxEJAfEFmnDYQHRgtcDAZWM4mHJoqPQ2+l1uTSe3Hyw6r4R
         ZaiTf99m3is5AygpWJCd/H4WoUk6Z0QE5MJ9zrPd5azjVu8UZUhbJv6QeFse9yS+JUI2
         P3OULO1Mj2wtLDzJGd69OCeSNn9rV9KX7cK1xQQl/hD391Dp1+hpyK33Ug6snX/3QDxT
         n7IQl8qy1YjaMKsNi6DdqcnrN3jUGJS9i1VmMuMJBWa5r1Lo19neHBnPeZZF5p/O9wdq
         KSNuuZop3YlBhsxjgIAuGZdsRLeGlwZ85dLSQtWjsmsvs3lFBthhH5KDKqfqVZPAGzOu
         pd0w==
X-Gm-Message-State: APt69E1+XD4aihcgDHMMeXWAcSsKd/bt5lp4VlZDnwtOFvtCuTbAzNxA
        fw3xVNvX1WIM5RpPEN9hDEqQlK675J/7hmshvG/J/Vzs
X-Google-Smtp-Source: ADUXVKKW0L31UrftxHrbp19faCNj1MuNDXN+TXlAJT/uuXJNV/CPEoRJ7yll2+86GYVwYIUzJI+gkZExggwLLfmm58Y=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr1467509vkd.187.1528792604840;
 Tue, 12 Jun 2018 01:36:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:36:44
 -0700 (PDT)
In-Reply-To: <CAMuHMdVZjPRknHY-3b7qr+FgwWmK3g3rCgjjK09Thh2EOLXbcQ@mail.gmail.com>
References: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
 <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com> <CAMuHMdVZjPRknHY-3b7qr+FgwWmK3g3rCgjjK09Thh2EOLXbcQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:36:44 +0300
Message-ID: <CAHp75VeD0KMS1ZGA+kuUUWqAO83tEQW3xh6N_R0o0W8nYsxNsw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jun 11, 2018 at 11:03 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Jun 6, 2018 at 10:27 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>> > This patch fix the following build error on M68K:
>
> Not plain m68k, but coldfire only (and MIPS AR7, I guess).
>
>> > drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
>> > 8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
>> > 8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'
>> >
>> > So 8250_dw need to depend on COMMON_CLK.
>> >
>>
>> Makes sense.
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Please see "[PATCH 0/3] Legacy clock drivers: Normalize clk API"
> (https://lkml.org/lkml/2018/6/11/122).

Indeed, your solution is better.
So, I need to withdraw my tag.

-- 
With Best Regards,
Andy Shevchenko
