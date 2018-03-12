Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeCLVAa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:00:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeCLVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:00:29 -0400
Date: Mon, 12 Mar 2018 14:00:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 3/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
Message-Id: <20180312140027.97db31d5dfc5c5f52a7c19a3@linux-foundation.org>
In-Reply-To: <1520885744-1546-4-git-send-email-longman@redhat.com>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
        <1520885744-1546-4-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 16:15:41 -0400 Waiman Long <longman@redhat.com> wrote:

> Even with clamped sysctl parameters, it is still not that straight
> forward to figure out the exact range of those parameters. One may
> try to write extreme parameter values to see if they get clamped.
> To make it easier, a warning with the expected range will now be
> printed into the kernel ring buffer when a clamped sysctl parameter
> receives an out of range value.
> 
> The pr_warn_ratelimited() macro is used to limit the number of warning
> messages that can be printed within a given period of time.
> 
> ...
>
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt)	"sysctl: " fmt

Why is it necessary to undefine pr_fmt?  That's a somewhat unusual
thing to do.
