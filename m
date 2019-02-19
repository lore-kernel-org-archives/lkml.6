Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E4EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7592147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="qUJhrZVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHUF4UDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfBSVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:53:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52857 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfBSVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:53:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6CB6A34DD;
        Tue, 19 Feb 2019 16:53:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Feb 2019 16:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=FzLxDwgW+cZFMnnA66l2LUVdJW9
        nX4e7lM9SFG06iVI=; b=qUJhrZVhajLl12cFoEr/3vNVuh0/VsW2b7teKdMMMe8
        xxQxqxsDoc01SNEPuuddYPBXHSmfR8Ab8f38EhzhSFNpEIUsemZRQe5SuGV1dkmD
        SDpjtqZD1BA/0GHeXHNvbulLHVqMxLJNkLVnoNBQfPM0gQ9uKCx85seYE/R5pYqU
        ESdiYYx6LWbcbS48BWXof2kTa76ViPFkIdEuyG5JwKmHMQlTlbX9keC8Jgf8uPXR
        2mOf41+ivv0pGvy7wyQBZ58S/UUeqaNp6Cvt/voJAssaeq0jTJDM7SL9mSPdv5m2
        xS6FqXIdiqD/tqgkVQmR1JNoWJQitP9mli6QZPYIcNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FzLxDw
        gW+cZFMnnA66l2LUVdJW9nX4e7lM9SFG06iVI=; b=nHUF4UDdrB/M9NPRdD1Tam
        9LQZ+hc30ZsEIQ0TuCp6OHcRJ3HMCymRyQ8juomXEGg+eS72IZtvm+THdUmu/0MJ
        vfulGxjhoACdIvD1/X8Wq++MjTIgRxUFECeetOLpKjxdGcl22M7tNJ4fUdZvWxnq
        JkyHjrzKKPg0nl0sBdx5jsSk3VCrViia+M5CBgmJe6Ma6j6WO52xlKDHULv88cqO
        v+s+PfG9+j7sHvN6pnCe27aT/IA9ezXN2S8XIIEE4+6oY0ZVMU5YgGahAUHQUHu1
        p+vO7/O2sHRtaHjkzOqZW6lH3oZSC1KiaLqexIAPF+zUM6UzMdh8NWWgHOttCo0w
        ==
X-ME-Sender: <xms:wXpsXFO0LbeXWHvjciIHIEvKrcDF2sMAqWxlfxCiwV2xAF1MUfkPyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeggdduheefucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucfkphepuddvuddrgeegrddvfeelrddugeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wXpsXOaUfYpgr_RPnDFCG7tgqQyihx-kgEZoILDMzh63JC25dYoGwg>
    <xmx:wXpsXNEc4W0d1zelpmsYih1I0wypLkl4YhN85j7Y8FAxaCKJnE5yhw>
    <xmx:wXpsXEnw1NtsihrbnVWX9AuPfOTRPMebqnmZAboyrn1sRY32G2vMOA>
    <xmx:w3psXAbCG8HX6HaH1AdILcSdAZATFdzU7clHomtw6x3PGFU7vmpwBg>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F959E45E2;
        Tue, 19 Feb 2019 16:53:04 -0500 (EST)
Date:   Wed, 20 Feb 2019 08:52:45 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jann Horn <jannh@google.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
Message-ID: <20190219215245.GA16094@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:51:45AM +0100, Jann Horn wrote:
> +cc Andy because he's also preparing a patch for this function
> 
> On Tue, Feb 19, 2019 at 12:25 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > Current function documentation for strncpy_from_user() is incorrect.  If
> > @count (size of destination buffer) is less than the length of the user
> > string the function does _not_ return @count but rather returns -EFAULT.
> >
> > Document correctly the function return value, also add note that string
> > may be left non-null terminated.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/strncpy_from_user.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> > index 58eacd41526c..11fe9a4a00fd 100644
> > --- a/lib/strncpy_from_user.c
> > +++ b/lib/strncpy_from_user.c
> > @@ -82,22 +82,19 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
> >  }
> >
> >  /**
> > - * strncpy_from_user: - Copy a NUL terminated string from userspace.
> > + * strncpy_from_user() - Copy a NUL terminated string from userspace.
> >   * @dst:   Destination address, in kernel space.  This buffer must be at
> >   *         least @count bytes long.
> >   * @src:   Source address, in user space.
> > - * @count: Maximum number of bytes to copy, including the trailing NUL.
> > + * @count: Maximum number of bytes to copy, including the trailing %NUL.
> >   *
> >   * Copies a NUL-terminated string from userspace to kernel space.
> >   *
> > - * On success, returns the length of the string (not including the trailing
> > - * NUL).
> > - *
> > - * If access to userspace fails, returns -EFAULT (some data may have been
> > - * copied).
> > - *
> > - * If @count is smaller than the length of the string, copies @count bytes
> > - * and returns @count.
> > + * Return: If access to userspace fails, returns -EFAULT.  Otherwise,
> > + *         return the number of characters copied excluding the trailing
> > + *         %NUL, if the length of the user string exceeds @count return
> > + *         -EFAULT (in which case @dst will be left without a %NUL
> > + *         terminator).
> >   */
> 
> AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
> if `res >= count` (in other words, if we've copied as many bytes as
> requested, haven't encountered a null byte so far, and haven't reached
> the end of the address space), we return `res`, which is the same as
> `count`. Are you sure?

Thanks for the review Jaan.  Seems I was in a world of confused, I
misread count to be the size of the destination buffer not the size of
the source string.

Also, re-reading strscpy() and why its better I think I may not be the
correct person to implement strscpy_from_user() since I'm not across all
the subtleties.

If v2 seems wanted for the first patches in this set I'll drop the
*_from_user() stuff.

thanks,
Tobin.

