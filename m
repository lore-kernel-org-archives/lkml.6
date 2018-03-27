Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC0Wqt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:46:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53086 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeC0Wqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:46:47 -0400
X-Google-Smtp-Source: AIpwx4/NSUia9wESjOoSKdDTRoNU+LVvxh4PPzFs80NXlkjaT0n9aVR+jQPVhD1JrS1GJVB1Pi8u8dPDs8t8w9idebA=
MIME-Version: 1.0
In-Reply-To: <152210718418.11435.11573013181393548255.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718418.11435.11573013181393548255.stgit@noble>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 28 Mar 2018 00:46:46 +0200
Message-ID: <CAHpGcMJgys_gMOw-VEpbO6w+NFaww-P6OvL=jwZfie9TxD9ZYA@mail.gmail.com>
Subject: Re: [PATCH 1/6] rhashtable: improve documentation for rhashtable_walk_peek()
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

2018-03-27 1:33 GMT+02:00 NeilBrown <neilb@suse.com>:
> The documentation for rhashtable_walk_peek() wrong.  It claims to
> return the *next* entry, whereas it in fact returns the *previous*
> entry.
> However if no entries have yet been returned - or if the iterator
> was reset due to a resize event, then rhashtable_walk_peek()
> *does* return the next entry, but also advances the iterator.
>
> I suspect that this interface should be discarded and the one user
> should be changed to not require it.  Possibly this patch should be
> seen as a first step in that conversation.
>
> This patch mostly corrects the documentation, but does make a
> small code change so that the documentation can be correct without
> listing too many special cases.  I don't think the one user will
> be affected by the code change.

how about I come up with a replacement so that we can remove
rhashtable_walk_peek straight away without making it differently
broken in the meantime?

Thanks,
Andreas
