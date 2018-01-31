Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeAaM7B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:59:01 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38783 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeAaM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:58:59 -0500
X-Google-Smtp-Source: AH8x225ggqScOU80PzkIrhLKFTjAiAe3XYGvN95dSR3Rtj146S2J2KD7JQQ6MGF8Vt+60DCXZWBNTh1k9REVD7Hmoi4=
MIME-Version: 1.0
In-Reply-To: <20180130182537.5580-1-colin.king@canonical.com>
References: <20180130182537.5580-1-colin.king@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 14:58:57 +0200
Message-ID: <CAHp75Vc_8v3qxWjtT4B3Kvz4dNZ8=-+uRPs-iTK3o8Taa4Swgw@mail.gmail.com>
Subject: Re: [PATCH] wireless: zd1211rw: remove redundant assignment of
 pointer 'q'
To: Colin King <colin.king@canonical.com>
Cc: Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 8:25 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer q is initialized and then almost immediately afterwards being
> re-assigned the same value. Remove the second redundant assignment.
>

Don't you see strange that in the same context of the patch two users
of q are present?

How did you test this?

> Cleans up clang warning:
> drivers/net/wireless/zydas/zd1211rw/zd_mac.c:503:23: warning: Value
> stored to 'q' during its initialization is never read

> -       q = &mac->ack_wait_queue;
>         spin_lock_irqsave(&q->lock, flags);
>
>         skb_queue_walk(q, skb) {



-- 
With Best Regards,
Andy Shevchenko
