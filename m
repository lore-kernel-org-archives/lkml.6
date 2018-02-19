Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeBSQPD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:15:03 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:32768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeBSQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:15:02 -0500
Date: Mon, 19 Feb 2018 11:15:00 -0500 (EST)
Message-Id: <20180219.111500.677838714163586859.davem@davemloft.net>
To: khoroshilov@ispras.ru
Cc: jasowang@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] tun: fix mismatch in mutex lock-unlock in
 tun_get_user()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518819115-13507-1-git-send-email-khoroshilov@ispras.ru>
References: <1518819115-13507-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 17 Feb 2018 01:11:55 +0300

> There is a single error path where tfile->napi_mutex is left unlocked.
> It can lead to a deadlock.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

As Eric explained, tun_napi_frags_enabled() (and therefore 'frags')
will never be true for TUN devices, which is the type handled by this
code path.
