Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B37206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HSY7EReK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfAGSvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:51:03 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38588 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfAGSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:50:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id w72so323431vkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZHDCGPs4z3y7ituqpfrLyMWFnn+906H7KD1VFwaE18=;
        b=HSY7EReKFJ3rs89PzbLD5kgnqLvq/YhfkvltohmFyZ+PFoOnCwzWQVwZV+sLvQqD3k
         J+UlTwiNC8tMvwGaw4j/4T3oeoatGqYjQSbS+N0hXs/rss8+ah7fWcOQLLsm+EJfvt+T
         0616M31tj+4Rz6pE3ZWRUJ/50qyind8yDu0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZHDCGPs4z3y7ituqpfrLyMWFnn+906H7KD1VFwaE18=;
        b=k7Dbpfms95LJQE+N40aHwOxvOVOGPYowkvAOnojWKkNmaoQsJtyKgu3G13KxFclguG
         fV5qyvV41xHFJdweGEfYTBMeTLURSYjLmpz9la/InJtGWfIRqohjt1fSpX4emiTMyBNH
         7MRTp5+XI2xxJ0NWdJ+ueBOpywN0CAyE3IqAkvv9+p8kB4M2tvPi1Lg2Vg37PjrVo/wf
         pKrFk1GccZImtnkt8wGx0FdiaOPfjNFerCE0LMZvpXRmodd+iKCSo4CWNJtbq0Bx+wNk
         z82o5EZ/5Hi5yyNM0JDrSH55lIKu7BgF4cOLlaPURMwxkzPWf3qDkjY2o03O2Z3XXyoE
         HCKA==
X-Gm-Message-State: AJcUukfY2gkft+zPxUeIyKE9DEWlblQq3uoipdUaOM7U9aPLXCm4CFLW
        2Oenso9TFVqW8+cMJi7qFPTg8ksXmig=
X-Google-Smtp-Source: ALg8bN5YPolvL5tle2L2Tj0HjT4ZwxGM0oTESa1EZSb9mJUa5pBZiZdCAXoej1is5XOngY7SHP0mhw==
X-Received: by 2002:a1f:9042:: with SMTP id s63mr22521455vkd.17.1546887052911;
        Mon, 07 Jan 2019 10:50:52 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a137sm27596255vsd.24.2019.01.07.10.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:50:51 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id v24so455658uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:50:50 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr22969857uau.52.1546887050200;
 Mon, 07 Jan 2019 10:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20190103001120.177784-1-mka@chromium.org>
In-Reply-To: <20190103001120.177784-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jan 2019 10:50:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wdgyh6pW2mZiq6qHR=mxisf4ygSS6yf23P_qw4tAGCwg@mail.gmail.com>
Message-ID: <CAD=FV=Wdgyh6pW2mZiq6qHR=mxisf4ygSS6yf23P_qw4tAGCwg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Dmitry Grinberg <dmitrygr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 2, 2019 at 4:11 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
> atomically") lock_sock[_nested]() is used to acquire the socket lock
> before manipulating the socket. lock_sock[_nested]() may block, which
> is problematic since bt_accept_enqueue() can be called in bottom half
> context (e.g. from rfcomm_connect_ind()):
>
> [<ffffff80080d81ec>] __might_sleep+0x4c/0x80
> [<ffffff800876c7b0>] lock_sock_nested+0x24/0x58
> [<ffffff8000d7c27c>] bt_accept_enqueue+0x48/0xd4 [bluetooth]
> [<ffffff8000e67d8c>] rfcomm_connect_ind+0x190/0x218 [rfcomm]
>
> Add a parameter to bt_accept_enqueue() to indicate whether the
> function is called from BH context, and acquire the socket lock
> with bh_lock_sock_nested() if that's the case.
>
> Also adapt all callers of bt_accept_enqueue() to pass the new
> parameter:
>
> - l2cap_sock_new_connection_cb()
>   - uses lock_sock() to lock the parent socket => process context
>
> - rfcomm_connect_ind()
>   - acquires the parent socket lock with bh_lock_sock() => BH
>     context
>
> - __sco_chan_add()
>   - called from sco_chan_add(), which is called from sco_connect().
>     parent is NULL, hence bt_accept_enqueue() isn't called in this
>     code path and we can ignore it
>   - also called from sco_conn_ready(). uses bh_lock_sock() to acquire
>     the parent lock => BH context
>
> Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - use parameter in bt_accept_enqueue() to decide which lock to
>   acquire and adapt all callers
> - updated commit message
> ---
>  include/net/bluetooth/bluetooth.h |  2 +-
>  net/bluetooth/af_bluetooth.c      | 16 +++++++++++++---
>  net/bluetooth/l2cap_sock.c        |  2 +-
>  net/bluetooth/rfcomm/sock.c       |  2 +-
>  net/bluetooth/sco.c               |  2 +-
>  5 files changed, 17 insertions(+), 7 deletions(-)

This looks nice to me, thanks!

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
