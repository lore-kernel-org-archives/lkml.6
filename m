Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeESVwy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:52:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33020 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeESVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:52:51 -0400
X-Google-Smtp-Source: AB8JxZr5oY3R4Y+fPbKV2L0R9LsQq2O4KJiDbz8qQxqQl7KRquA07N1OWW3dPK8koRpdlIn0u8Us6Q==
Date: Sat, 19 May 2018 18:52:46 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 09/14] net: sched: don't release reference on action
 overwrite
Message-ID: <20180519215246.GD5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-10-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-10-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:27:10PM +0300, Vlad Buslov wrote:
> Return from action init function with reference to action taken,
> even when overwriting existing action.

Isn't this patch necessary before patch 7, to not break things up?
AFAICU after patchset 7 it assumes the action init function is already
behaving like this.
