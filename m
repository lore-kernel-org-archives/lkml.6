Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeAaN6o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:58:44 -0500
Received: from mail.us.es ([193.147.175.20]:38850 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeAaN6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:58:42 -0500
Date: Wed, 31 Jan 2018 14:58:37 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        andreyknvl@google.com, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: fix pointer leaks to userspace
Message-ID: <20180131135837.44tveylwax3nju7j@salvia>
References: <20180129122120.230279-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129122120.230279-1-dvyukov@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 01:21:20PM +0100, Dmitry Vyukov wrote:
> Several netfilter matches and targets put kernel pointers into
> info objects, but don't set usersize in descriptors.
> This leads to kernel pointer leaks if a match/target is set
> and then read back to userspace.
> 
> Properly set usersize for these matches/targets.
> 
> Found with manual code inspection.

Applied, thanks!

I think this fixes:

ec2318904965 xtables: extend matches and targets with .usersize

So I'm going to add the Fixes: tag here, no problem.
