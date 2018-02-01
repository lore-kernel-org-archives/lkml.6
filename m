Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBAOua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:50:30 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43972 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeBAOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:49:10 -0500
Date: Thu, 01 Feb 2018 09:49:09 -0500 (EST)
Message-Id: <20180201.094909.1943860277381269232.davem@davemloft.net>
To: geert@linux-m68k.org
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, arnd@arndb.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inet: Avoid unitialized variable warning in
 inet_unhash()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1517480783-5692-1-git-send-email-geert@linux-m68k.org>
References: <1517480783-5692-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w11EomAg026981

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu,  1 Feb 2018 11:26:23 +0100

> With gcc-4.1.2:
> 
>     net/ipv4/inet_hashtables.c: In function ¡inet_unhash¢:
>     net/ipv4/inet_hashtables.c:628: warning: ¡ilb¢ may be used uninitialized in this function
> 
> While this is a false positive, it can easily be avoided by using the
> pointer itself as the canary variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

This frankly also makes the logic simpler and doesn't increase register
pressure, I like it.

Applied, thanks.
