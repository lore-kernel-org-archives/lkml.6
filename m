Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBAOsI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:48:08 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43954 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBAOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:48:07 -0500
Date: Thu, 01 Feb 2018 09:48:05 -0500 (EST)
Message-Id: <20180201.094805.1174548294600347835.davem@davemloft.net>
To: geert@linux-m68k.org
Cc: nikolay@cumulusnetworks.com, stephen@networkplumber.org, arnd@arndb.de,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: Fix uninitialized error in
 br_fdb_sync_static()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
References: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w11EmDae026689

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu,  1 Feb 2018 11:25:27 +0100

> With gcc-4.1.2.:
> 
>     net/bridge/br_fdb.c: In function ¡br_fdb_sync_static¢:
>     net/bridge/br_fdb.c:996: warning: ¡err¢ may be used uninitialized in this function
> 
> Indeed, if the list is empty, err will be uninitialized, and will be
> propagated up as the function return value.
> 
> Fix this by preinitializing err to zero.
> 
> Fixes: eb7935830d00b9e0 ("net: bridge: use rhashtable for fdbs")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks Geert.
