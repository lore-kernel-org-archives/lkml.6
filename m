Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeEaEfs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:35:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33637 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbeEaEfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:35:43 -0400
X-Google-Smtp-Source: ADUXVKLRxOm5g+JfTWO+IGEqBC5NuiQGAzZyZ65c/yj8m8Fmsymc8cVjKre3Uvx4CS4fnnk0Z6QzAw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next: build failure after merge of the device-mapper tree
From: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180531142302.5f7b4302@canb.auug.org.au>
Date: Wed, 30 May 2018 22:35:40 -0600
Cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Message-Id: <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
References: <20180531142302.5f7b4302@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V4aJch011078

On May 30, 2018, at 10:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/md/dm-writecache.c: In function 'writecache_dtr':
> drivers/md/dm-writecache.c:1799:3: error: implicit declaration of function 'bioset_free'; did you mean 'bvec_free'? [-Werror=implicit-function-declaration]
>   bioset_free(wc->bio_set);
>   ^~~~~~~~~~~
>   bvec_free
> drivers/md/dm-writecache.c: In function 'writecache_ctr':
> drivers/md/dm-writecache.c:1929:17: error: implicit declaration of function 'bioset_create'; did you mean 'bioset_exit'? [-Werror=implicit-function-declaration]
>   wc->bio_set = bioset_create(BIO_POOL_SIZE,
>                 ^~~~~~~~~~~~~
>                 bioset_exit
> drivers/md/dm-writecache.c:1929:15: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   wc->bio_set = bioset_create(BIO_POOL_SIZE,
>               ^
> 
> Caused by commit
> 
>  2105231db61b ("dm: add writecache target")
> 
> interacting with commit
> 
>  dad08527525f ("block: Drop bioset_create()")
> 
> from the block tree.
> 
> Can we please consider not immediately dropping APIs if at all
> possible. :-(

I’ll drop the last patch, we can do that at the end of the merge window instead. 
