Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB86AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604F620693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qttvzrli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604F620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbeFLIcQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:32:16 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36940 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933367AbeFLIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:32:14 -0400
Received: by mail-ua0-f196.google.com with SMTP id i3-v6so15392165uad.4;
        Tue, 12 Jun 2018 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4/sjuyG/dN16xcacAyqwodTkKRTajg9K6qM/h9WW34=;
        b=qttvzrliFiAWqoVZnLxa537Etjh6KmxSnEc4tSHx0G2dRsQVVobmo1z97z58wpvfY8
         Oi5hySz8LQxDjuVZRZtYTBwbeC8tfxNB76YpSEaqOdqbbcxQU5Hp3HFYPjHV5B6Rw+jb
         94uJFcpKJVdZ/KUg8lxkIPU5GS4msEjoLhY0BhdltWO06XjMXptGmSvwh4C6tfyO2wAd
         5OP749UsXJeGoehP1tfuyNHut7+u4ZvAoUhcgM6CAvreRv9HGeeJJh/w/zFzHCcIXaj6
         p8VriASUXr0trGghjseAV71r2Jng4aA8gYZj7EVhxwF+wZ2n53DOTgjwKmjkDm3bhf7D
         k1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4/sjuyG/dN16xcacAyqwodTkKRTajg9K6qM/h9WW34=;
        b=LbGIl7PvLhcjSn4A6AJm4czOxxHsnS0PCSGvlmgDm4MkGRBD3Q1CzwoflgLOrAnvhh
         h7m9oYn3HsSIgDkecR3MLjeNSHQln0FFUrjEfvmXJLub5NSmzk+WkzIwMJTdnTfWk7a6
         2F6C+UiGxsD7AAn4/P+ba6wpw2P6XHZCv2xPv9NTRRyW4Wa79woQPs4pTxDCzr0BjsXv
         RVH+o+AZuyRnQ+AF7KUtiZ2LpLf9mhJRMMwIPbBv8L5wxP0vFgsQ3SbXYktMz9J9XmBf
         Ohcf4NT0zjr8oxAgL4swTUC5nJLktUhiezsEsf1cCSv2zmqopo+FXsRI0qPVJAxYAymN
         d7BA==
X-Gm-Message-State: APt69E0KEKfSuJvSEjzcLzea/tZ09xJAt8i6WGm1mMgRI2f0aWIUZqae
        5Ry0soDZIgO6+aKU+ZhFedoTmLv7/3GQV2Pmtpc=
X-Google-Smtp-Source: ADUXVKKjGfgS+m0wEX4GqhTtD+RI6H3lIeTitxffU69iAMdmzlpqykBE3vPchEgA+vJIcw8YOWtRxO+4tU/4zZARNvc=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr1779775uad.49.1528792333580;
 Tue, 12 Jun 2018 01:32:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:32:13
 -0700 (PDT)
In-Reply-To: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:32:13 +0300
Message-ID: <CAHp75Vet9dzrJE0nzTe2HRy50UCsaSyNJueiFVrNfgtr4wmhzQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: max732x: add error handling for i2c_new_dummy
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:28 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When i2c_new_dummy fails, the lack of error-handling code may
> cause unexpected results.

What results?
Where is the analisys?

Would driver work w/o these dummy devices?

-- 
With Best Regards,
Andy Shevchenko
