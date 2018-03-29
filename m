Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeC2Qwh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:52:37 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:40268 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2Qwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:52:35 -0400
X-Google-Smtp-Source: AIpwx4835WLPJ4S8731W5fXHKo/l+sErpsRmCRvewBpxwfS+NmsNq1ppvuaN5l+2KH6pwn7et0ACFPLfBDXw/rgnK4o=
MIME-Version: 1.0
In-Reply-To: <20180329154153.GA23562@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com> <20180329123544.GA22551@gondor.apana.org.au>
 <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com> <20180329154153.GA23562@gondor.apana.org.au>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Mar 2018 18:52:34 +0200
Message-ID: <CAHc6FU708-F-C_ihwBW-zKC7rZvfeuKYq7kTccZQU156UicjQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 March 2018 at 17:41, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Mar 29, 2018 at 03:15:54PM +0200, Andreas Gruenbacher wrote:
>>
>> For all I know, Neil's latest plan is to get rhashtable_walk_peek
>> replaced and removed because it is unfixable. This patch removes the
>> one and only user.
>
> His latest patch makes rhashtable_walk_peek stable in the face of
> removals.
>
> https://patchwork.ozlabs.org/patch/892534/

Ok, I can slightly update my patch description. The problem still
remains that glocks can be deleted from the rhashtable between
stop/start, and that needs to be fixed in gfs2. Once that's done,
keeping track of the current glock comes for free and we won't need
rhashtable_walk_peek anymore.

Should rhashtable_walk_peek be kept around even if there are no more
users? I have my doubts.

Thanks,
Andreas
