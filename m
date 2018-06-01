Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeFACte (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 22:49:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFACta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 22:49:30 -0400
Date: Thu, 31 May 2018 22:49:26 -0400 (EDT)
Message-Id: <20180531.224926.26417889797461444.davem@davemloft.net>
To: keescook@chromium.org
Cc: fw@strlen.de, dsahern@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtnetlink: Remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180530222052.GA30622@beast>
References: <20180530222052.GA30622@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 May 2018 15:20:52 -0700

> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the maximum size expected for all possible types and adds
> sanity-checks at both registration and usage to make sure nothing gets
> out of sync. This matches the proposed VLA solution for nfnetlink[2]. The
> values chosen here were based on finding assignments for .maxtype and
> .slave_maxtype and manually counting the enums:
> 
> slave_maxtype (max 33):
 ...
> maxtype (max 45):
 ...
> 
> This additionally changes maxtype and slave_maxtype fields to unsigned,
> since they're only ever using positive values.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> [2] https://patchwork.kernel.org/patch/10439647/
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good, applied, thanks.
