Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBUB03 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:26:29 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33267 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBUB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:26:27 -0500
X-Google-Smtp-Source: AH8x224llZWEumebweZJJxi11CntPtmjLxA7uoWI2w/CzrGqPdsFJesxssV7PCl0YfqaPT4Ses0fctkG4j+f8D+jVN8=
MIME-Version: 1.0
In-Reply-To: <20180220151705.8b4519f105db8f5c119015f0@linux-foundation.org>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
 <1519059231-2456-3-git-send-email-longman@redhat.com> <20180220151705.8b4519f105db8f5c119015f0@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 20 Feb 2018 17:26:25 -0800
X-Google-Sender-Auth: 9VvE0XDCJJJQGQRT9JdFNcSchFc
Message-ID: <CAGXu5jJxj77yH8reSaQDp26D1tEvQVaiuL99uYuukCTc5FbfHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sysctl: Warn when a clamped sysctl parameter is set
 out of range
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 3:17 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 19 Feb 2018 11:53:50 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed in the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>
> This assumes that do_proc_dointvec_minmax_conv() and
> do_proc_douintvec_minmax_conv() are only ever called by privileged
> userspace.  Because we mustn't give unprivileged applications a way to
> spam the kernel logs.
>
> That's presumably true in the case of the caller you just added, but I
> don't see what we can do to guarantee this in the future, so perhaps we
> should add some permission check to the pr_warn()?

How about pr_warn_ratelimited() instead?

-Kees

-- 
Kees Cook
Pixel Security
