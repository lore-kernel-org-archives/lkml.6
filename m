Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6162083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q19AFfsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBUXO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:14:26 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38154 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:14:26 -0500
Received: by mail-ua1-f65.google.com with SMTP id p9so314005uaa.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8jG5nmRuX4WzbMZPzuSYf3YdJ1ANoJ9OMNB2cESHic=;
        b=Q19AFfsw6L6w+Lw7Bcahprr7EZ/Dh49O0zf1v1t5kWlhCEzpDHRArP4Fn+nyDwuMA5
         7ci9obLHZviH0bN+vAi8PjS5cqST6dsOUoqxIdmTDCz0oobcvtGmfyNR9o68rAtGeGOb
         axDK1EvMCNNaBhEwQuVJ+OzRgP7yPVaNYsZXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8jG5nmRuX4WzbMZPzuSYf3YdJ1ANoJ9OMNB2cESHic=;
        b=toMnfBkUBPgnnU2EWbvPUO23OkQpgr+8qndRhiAnGGQkd7YbTXR8PwdIQdglX7puGk
         U4Ry4orzpZE5Ayju2yBfm/0WAs/ZXrMLqi2xgBFDx+cWKkAMAEb5llltV3hoJDMTbpEu
         xeRBtvyrLaa5I3/RjJzmZNqPTdTlo6a0mNITzhy/y2xRTNQzYoCJpQvyAn4+OH7sN8qC
         qOPvb8tB5kqrQ9ZpS7O4B8tHwLjJCqMG2BUG92nFDV8m0B0F2tSaCn649m3e+P6Sr4u2
         Yn6BhRBGasQg2DEhSgky5KzUlot3Wai912NtuSkq4xK5h+OlwBXJQ/CZdxHN9RIGO2pW
         SO1A==
X-Gm-Message-State: AHQUAuaFFOVjSxnsZomOE8lDIeyaILRWOHuRvSfK4rkFd3IZ2btiMXBv
        GYVYMexktOsy9WDuURt30j2ApG+8fVI=
X-Google-Smtp-Source: AHgI3IYrNNTAbgwaqZiHWZ8otRWkfRYPexmNqCk3YaIi8F6QRRc6KlmalcBC1/lMU6GhJtkhtce9AA==
X-Received: by 2002:a67:b145:: with SMTP id z5mr626576vsl.53.1550790865181;
        Thu, 21 Feb 2019 15:14:25 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a68sm257454vsd.24.2019.02.21.15.14.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 15:14:25 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id v26so321790uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:14:24 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr661904uan.114.1550790864029;
 Thu, 21 Feb 2019 15:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
 <20190221052435.GF11758@eros.localdomain> <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
 <CAG48ez0LjS5piXnx5924VbZQxEOwKeiAFmLEQChDNGAK65yfVg@mail.gmail.com>
In-Reply-To: <CAG48ez0LjS5piXnx5924VbZQxEOwKeiAFmLEQChDNGAK65yfVg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 15:14:12 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJbjqQDH6dMnzHNiBxxBfVNh_p1e=Tu3ZV_qwOJMmvOsw@mail.gmail.com>
Message-ID: <CAGXu5jJbjqQDH6dMnzHNiBxxBfVNh_p1e=Tu3ZV_qwOJMmvOsw@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Jann Horn <jannh@google.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 8:07 AM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Feb 21, 2019 at 7:02 AM Kees Cook <keescook@chromium.org> wrote:
> > The tree-wide changes will likely take a while (and don't need to be
> > part of this series unless you want to find a couple good examples)
> > since we have to do them case-by-case: it's not always obvious when
> > it's actually a non-string, so getting help from maintainers here will
> > be needed. (And maybe some kind of flow chart added to
> > Documentation/process/deprecated.rst for how to stop using strncpy()
> > and strlcpy().)
>
> Wild brainstorming ahead...
>
> Such non-string character arrays are usually fixed-size, right? We
> could use struct types around such character arrays to hide the actual
> characters (so that people don't accidentally use them with C string
> APIs), and enforce that the length is passed around as part of the
> type... something like:
>
> #define char_array(len) struct { char __ca_data[len]; }

Does this need __packed or will the compiler understand it's
byte-aligned? And it needs __nonstring :)

> #define __CA_UNWRAP(captr) (captr)->__ca_data, sizeof((captr)->__ca_data)
>
> void __str2ca(char *dst, size_t dst_len, char *src) {
>   size_t src_len = strlen(src);
>   if (WARN_ON(src_len > dst_len)) {
>     // or whatever else we think is the safest way to deal with this
>     // without crashing, if BUG() is not an option.
>     memset(dst, 0, dst_len);
>     return;
>   }
>   memcpy(dst, src, src_len);
>   memset(dst + src_len, 0, dst_len - src_len);
> }
> #define str2ca(dst, src) __str2ca(__CA_UNWRAP(dst), (src))
>
> static inline void __ca2ca(char *dst, size_t dst_len, char *src,
> size_t src_len) {
>   BUILD_BUG_ON(dst_len < src_len);
>   memcpy(dst, src, src_len);
>   if (src_len != dst_len) {
>     memset(dst + src_len, 0, dst_len - src_len);
>   }
> }
> #define ca2ca(dst, src) __ca2ca(__CA_UNWRAP(dst), __CA_UNWRAP(src))

Yeah, I was trying to think of ways to do this but I was thinking
mostly about noticing the __nonstring mark. #define-ing this away
might work, but it might also just annoy people more. At least GCC
will yell about __nonstring use in some cases.

> And if you want to do direct assignments instead of using helpers, you
> make a typedef like this (since just assigning between two equivalent
> structs doesn't work):
>
> typedef char_array(20) blah_name;
> blah_name global_name;
> int main(int argc, char **argv) {
>   blah_name local_name;
>   str2ca(&local_name, argv[1]);
>   global_name = local_name;
> }
>
> You'd also have to use a typedef like this if you want to pass
> references to other functions.

Yeah, it might work. I need to go look through ext4 -- that's one
place I know there were "legit" strncpy() uses...

Converting existing non-string cases to this and see if it's worse
would be educational.

> Something like this would also be neat for classic C strings in some
> situations - if you can put bounds in the types, or (if the string is
> dynamically-sized) in the struct, you don't need to messily pass
> around bounds for things like snprint() and so on.

Yeah, I remain annoyed about string pointers having lost their
allocation size meta data. The vast majority of str*() functions could
just be "str, sizeof(str)" like you have for the CA_UNWRAP.

> > So scnprintf() does the right thing (count of non-NUL bytes copied out).
>
> That seems kinda suboptimal. Wouldn't you ideally want to bail out
> with an error, or at least do a WARN(), if you're trying to format a
> string that doesn't fit into its destination? Like, for example, if
> you're assembling a path, and the path doesn't fit into a buffer, and
> so you just use half of it, you might end up in a very different place
> from where you intended to go.

ssprintf() with -E2BIG? Most correct users of snprintf()'s return
value do some version of trying to detect if there wasn't enough space
and then error out:

static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
{
        int actual;
        actual = snprintf(buf, size, "usb-%s-%s", dev->bus->bus_name,
                          dev->devpath);
        return (actual >= (int)size) ? -1 : actual;
}

a) this could just be "return ssprintf(..."
b) as far as I see, there are literally 2 callers of usb_make_path()
that check the return value

Anyway, snprintf() is "next". I'd like to get through
strcpy/strncpy/strlcpy removal first... :)

-- 
Kees Cook
