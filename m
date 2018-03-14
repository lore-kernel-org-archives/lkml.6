Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeCNQqn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:46:43 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35064 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCNQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:46:41 -0400
Date: Wed, 14 Mar 2018 12:46:33 -0400 (EDT)
Message-Id: <20180314.124633.1173391181334136968.davem@davemloft.net>
To: jpoimboe@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, jbaron@akamai.com, bp@suse.de
Subject: Re: [PATCH] jump_label: Fix sparc64 warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com>
References: <c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Wed, 14 Mar 2018 10:24:20 -0500

> The kbuild test robot reported the following warning on sparc64:
> 
>   kernel/jump_label.c: In function '__jump_label_update':
>   kernel/jump_label.c:376:51: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>        WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
> 
> On sparc64, the jump_label entry->code field is of type u32, but
> pointers are 64-bit.  Silence the warning by casting entry->code to an
> unsigned long before casting it to a pointer.  This is also what the
> sparc jump label code does.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
