Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEKTvr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:51:47 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50020 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeEKTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:51:46 -0400
Date: Fri, 11 May 2018 15:50:46 -0400 (EDT)
Message-Id: <20180511.155046.122041869811590666.davem@davemloft.net>
To: wang6495@umn.edu
Cc: kjlu@umn.edu, mac@melware.de, isdn@linux-pingi.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: eicon: fix a missing-check bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525548766-13017-1-git-send-email-wang6495@umn.edu>
References: <1525548766-13017-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Sat,  5 May 2018 14:32:46 -0500

> To avoid such issues, this patch adds a check after the second copy in the
> function diva_xdi_write(). If the adapter number is not equal to the one
> obtained in the first copy, (-4) will be returned to divas_write(), which
> will then return an error code -EINVAL.

Better fix is to copy the msg header once into an on-stack buffer supplied
by diva_write() to diva_xdi_open_adapter(), which is then passed on to
diva_xdi_write() with an adjusted src pointer and length.
