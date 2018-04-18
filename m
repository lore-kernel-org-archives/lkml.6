Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDRW2W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:28:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:28:21 -0400
Date: Wed, 18 Apr 2018 15:28:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-Id: <20180418152820.e8f317534c01696d4835a40f@linux-foundation.org>
In-Reply-To: <20180405182651.GM15783@uranus.lan>
References: <20180405182651.GM15783@uranus.lan>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018 21:26:51 +0300 Cyrill Gorcunov <gorcunov@gmail.com> wrote:

> Subject: [PATCH v2] prctl: Deprecate non PR_SET_MM_MAP operations

s/Deprecate/remove/ !

> An ability to manipulate mm_struct fields was introduced in
> sake of CRIU in first place. Later we provide more suitable
> and safe operation PR_SET_MM_MAP where all fields to be modifed
> are passed in one structure which allows us to make more detailed
> verification.
> 
> Still old interface remains present for compatibility reason
> though CRIU itself already switched to PR_SET_MM_MAP on its
> own long ago.
> 
> Googling didn't reveal some other users of this operation
> so I think it should be safe to remove this interface.

It does seem a bit sudden.  We could just add a "this interface is
scheduled for removal" warning, then delete the code for real later in
the year.  To give people time to migrate or to complain to us.
