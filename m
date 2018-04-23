Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeDWNwx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:52:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754981AbeDWNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:52:51 -0400
Date: Mon, 23 Apr 2018 09:52:49 -0400 (EDT)
Message-Id: <20180423.095249.1008800065389287269.davem@davemloft.net>
To: jannh@google.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: don't read out-of-bounds opsize
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180420135730.44921-1-jannh@google.com>
References: <20180420135730.44921-1-jannh@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>
Date: Fri, 20 Apr 2018 15:57:30 +0200

> The old code reads the "opsize" variable from out-of-bounds memory (first
> byte behind the segment) if a broken TCP segment ends directly after an
> opcode that is neither EOL nor NOP.
> 
> The result of the read isn't used for anything, so the worst thing that
> could theoretically happen is a pagefault; and since the physmap is usually
> mostly contiguous, even that seems pretty unlikely.
> 
> The following C reproducer triggers the uninitialized read - however, you
> can't actually see anything happen unless you put something like a
> pr_warn() in tcp_parse_md5sig_option() to print the opsize.
 ...
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> Signed-off-by: Jann Horn <jannh@google.com>

Applied and queued up for -stable, thank you.
