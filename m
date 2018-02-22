Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeBVTHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:07:11 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:50610 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeBVTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:07:08 -0500
Date: Thu, 22 Feb 2018 14:07:04 -0500 (EST)
Message-Id: <20180222.140704.166412303524863230.davem@davemloft.net>
To: keescook@google.com
Cc: tgraf@suug.ch, johannes@sipsolutions.net, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        danielmicay@gmail.com
Subject: Re: nla_put_string() vs NLA_STRING
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5jLg62737XeB3g0SOLTz-7NyF6_MvvH69kqFE4iqX2w7vQ@mail.gmail.com>
References: <CAGXu5jLg62737XeB3g0SOLTz-7NyF6_MvvH69kqFE4iqX2w7vQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@google.com>
Date: Tue, 20 Feb 2018 22:00:26 -0800

> So, this specific problem needs fixing (in at least two places calling
> nla_put_string(msg, NL80211_ATTR_REG_ALPHA2, ...)). While I suspect
> it's only ever written an extra byte from the following variable in
> the structure which is an enum nl80211_dfs_regions, I worry there
> might be a lot more of these (though I'd hope unterminated strings are
> uncommon for internal representation). And more generally, it seems
> like only the NLA _input_ functions actually check nla_policy details.
> It seems that the output functions should do the same too, yes?

Generally speaking, the policy is for making sure the user doesn't
give us garbage.

When building netlink attributes itself, the kernel is supposed to
know what it is doing.
