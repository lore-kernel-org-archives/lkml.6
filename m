Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE70C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3A2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNYygGVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E3A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHUNK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:10:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40224 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeHUNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:10:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so8237712pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLdzujfYjLg06RcMdig1Mi3f7IcKZoyYcqD22cBhoPA=;
        b=mNYygGVhesp+TAU5E2EDJ+kq981NbllxtY3cZJ3wXazbnx9/aHC+N5Oo0JGOUMqgHr
         H6kbMCIwIrelk10kZeGaZBh+XOMdG1zulQYFu2efbDWUWH+G7k5A4sC8hruNDxcSjFcV
         5HBrAsUeysd8l80pu8lKUJkRN1jNCCwN7fuGxf/GP7pJuRMNVGebCP/VA3l1aqVbZDDA
         SdzE+GTW2DBVT6624LcypS3iqhv5mjaB/KtrYWie3VOpkEFQowExhtUSrh7NZTURJxiU
         C0Tx0f6kkL9zJtQgmtR4QORKxOEZodiJHgenrlUWx9+s/rb/yZQXXpctXgkxh7R83Oli
         JpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLdzujfYjLg06RcMdig1Mi3f7IcKZoyYcqD22cBhoPA=;
        b=r9aYrRhZdgweR60IGZT6oHAv6lx65dGStj8qdO6n/TTXelSPhPDknpk8VMBqLC8ryq
         JIJD/9oB1VuJ1i7lN2qrdBkdGut1n8AvgVahk6EMiocVTulGB3Ta5tsP85tEicnrDI7f
         YzYRr6znOYiOekJiB5xOqaalraug7hEmnwA1e1AVoU/1k0PBxNKQCMayvUNEih1wNkm8
         uQLyfodoMQckyAyKcbQCxc2JtcOdCUpY5u6GUcoZ4A98DAnrhbKX+/ZpT+JVlIdvOeH5
         KXkazMZktk1yhu/e7AUyeaxQnaKOnv1ET4N8zhCb+ynFWQ6ITURCRIXZVbDadQfxH3D2
         GXeg==
X-Gm-Message-State: AOUpUlHWSyyDIp82Gqehmc/wGkFTIGVWjiA/MaB7hAUk8tE3OmWpAGyZ
        LqwJkOzCe2mgWiO+DMaavCw=
X-Google-Smtp-Source: AA+uWPyskbmKgJlbeo5kgrG8aS/q1cNiXUZPfnVTheIsTUWq52y6/j8+YJGZFj1NsWah33ZZbVBUxQ==
X-Received: by 2002:a63:5a50:: with SMTP id k16-v6mr10465676pgm.143.1534845059906;
        Tue, 21 Aug 2018 02:50:59 -0700 (PDT)
Received: from localhost ([39.7.47.210])
        by smtp.gmail.com with ESMTPSA id g20-v6sm16389809pfo.94.2018.08.21.02.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 02:50:58 -0700 (PDT)
Date:   Tue, 21 Aug 2018 18:50:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180821095055.GA400@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On (08/21/18 09:59), Rasmus Villemoes wrote:
> > +char *sysfs_strncpy(char *dest, const char *src, size_t count)
> > +{
> > +	char *c;
> > +
> > +	strncpy(dest, skip_spaces(src), count);
> 
> I'd like to see where and how you'd use this, but I'm very skeptical of
> count being used both for the size of the dest buffer as well as an
> essentially random argument to strncpy - if count is also the maximum
> number of bytes to read from the src, you'd need to take the
> skip_spaces() into account, because there are not count bytes left after
> that...
> And if src is not necessarily nul-terminated, skip_spaces() by
> itself is wrong.

I think that sysfs input is always properly NULL-terminated. It may or
may not contain \n, but \0 is expected to be there. Am I wrong?

> Moreover, I don't think we should add more users or wrappers for strncpy
> - I highly doubt the sysfs users you have in mind want the "fill the
> rest of the buffer with '\0'" nor the "not enough room for a terminating
> '\0'? Oh well, what could possibly go wrong" semantics.

The reason I added both strncpy() and strlcpy() was that there are lots
of sysfs ->store() callbacks which use strncpy().

E.g.
	channel_dimm_label_store()
	dimmdev_label_store()
	pmbus_add_label()
	axp20x_store_attr()
	cmdline_store()
	
	and so on and on.

> > +	c = dest + count - 1;
> > +	while (c >= dest && (isspace(*c) || *c == '\n' || *c == '\0')) {
> 
> nit: '\n' certainly already passes the isspace() test.

Hah, indeed, it should.
"\n" & 0x20 must be positive. Andrew had the same comment. But I didn't
check what actually isspace() was doing, until now.

> > +size_t sysfs_strlcpy(char *dest, const char *src, size_t size)
> > +{
> > +	size_t ret;
> > +	char *c;
> > +
> > +	ret = strlcpy(dest, skip_spaces(src), size);
> > +
> > +	size = strlen(dest);
> > +	c = dest + size - 1;
> > +	while (c >= dest && (isspace(*c) || *c == '\n'))
> > +		c--;
> > +	*(c + 1) = '\0';
> > +	return ret;
> > +}
> 
> What exactly is the return value?

Honestly, I didn't think about it. I wasn't sure if we want to return
anything from this function and from sysfs_strncpy(). I glanced through
a number of ->store() callbacks, and it seems that mostly people don't
bother to check strlcpy() return value at all.

> A more useful return value would either be "the length of the string
> now in dest", or some sort of indicator that the input was truncated,
> if that is ever possible.

Agreed.

> I think you're too focused on making wrappers around str[ln]cpy
> preserving parts of those functions' API. Instead, try to figure out
> what sysfs users actually want, name the functions after that, and then
> whether they use strncpy or sprintf or strscpy internally is completely
> irrelevant.

Going point, that's why the patch is in RFC stage: to figure out
what do we actually want.

> int strcpy_trim(char *dst, size_t dstsize, const char *src, size_t
> srcsize) - copy (potentially not '\0'-terminated) src to dst, trimming
> leading and trailing whitespace. dstsize must be positive, and dst is
> guaranteed to be '\0'-terminated. Returns the length of the string now
> in dst, or -EOVERFLOW if some none-whitespace character was chopped.
>
> would cover all use cases?

I like it in general. Sounds like a plan to me. Maybe the "-EOVERFLOW if
some none-whitespace character was chopped" part can be changed: if we
would trim leading and trailing whitespaces before we copy a string then
only valid input chars can get chopped.

	-ss
