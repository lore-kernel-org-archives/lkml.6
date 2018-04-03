Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbeDCXpZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:45:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeDCXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:45:24 -0400
Date: Tue, 3 Apr 2018 16:45:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/migrate: properly preserve write attribute in
 special migrate entry
Message-Id: <20180403164522.657185a44e8ada1b741f0a9e@linux-foundation.org>
In-Reply-To: <20180403230336.GH5935@redhat.com>
References: <20180402023506.12180-1-jglisse@redhat.com>
        <20180403153046.88cae4ab18646e8e23a648ce@linux-foundation.org>
        <20180403230336.GH5935@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 19:03:36 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> > That sounds a bit serious.  Was a -stable backport considered?
> 
> Like discuss previously with Michal, for lack of upstream user yet
> (and PowerPC users of this code are not upstream either yet AFAIK).
> 
> Once i get HMM inside nouveau upstream, i will evaluate if people
> wants all fixes to be back ported to stable.
> 
> Finaly this one isn't too bad, it just burn CPU cycles by forcing
> CPU to take a second fault on write access ie double fault the same
> address. There is no corruption or incorrect states (it behave as
> a COWed page from a fork with a mapcount of 1).

OK, I updated the changelog with this info.

> Do you still want me to be more aggressive with stable backport ?
> I don't mind either way. I expect to get HMM nouveau upstream over
> next couple release cycle.

I guess that doing a single, better-organized cherrypick at a suitable
time in the future is a good approach.  You might want to discuss this
plan with Greg before committing too far.
