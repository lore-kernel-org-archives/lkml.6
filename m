Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeENUlV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:41:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41680 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:41:19 -0400
Date: Mon, 14 May 2018 16:41:17 -0400 (EDT)
Message-Id: <20180514.164117.792209096555574754.davem@davemloft.net>
To: ebiggers3@gmail.com
Cc: ubraun@linux.ibm.com, tmricht@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        ebiggers@google.com
Subject: Re: [PATCH] net/smc: check for missing nlattrs in SMC_PNETID
 messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514000130.13780-1-ebiggers3@gmail.com>
References: <001a113f9bb83e4d560568457853@google.com>
        <20180514000130.13780-1-ebiggers3@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers3@gmail.com>
Date: Sun, 13 May 2018 17:01:30 -0700

> From: Eric Biggers <ebiggers@google.com>
> 
> It's possible to crash the kernel in several different ways by sending
> messages to the SMC_PNETID generic netlink family that are missing the
> expected attributes:
> 
> - Missing SMC_PNETID_NAME => null pointer dereference when comparing
>   names.
> - Missing SMC_PNETID_ETHNAME => null pointer dereference accessing
>   smc_pnetentry::ndev.
> - Missing SMC_PNETID_IBNAME => null pointer dereference accessing
>   smc_pnetentry::smcibdev.
> - Missing SMC_PNETID_IBPORT => out of bounds array access to
>   smc_ib_device::pattr[-1].
> 
> Fix it by validating that all expected attributes are present and that
> SMC_PNETID_IBPORT is nonzero.
> 
> Reported-by: syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com
> Fixes: 6812baabf24d ("smc: establish pnet table management")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied and queued up for -stable, thanks.
