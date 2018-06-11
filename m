Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +x3AJao1HlvYHAAAmS7hNA
	; Mon, 11 Jun 2018 08:41:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9E50607BB; Mon, 11 Jun 2018 08:41:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kuf9rofr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 31343605A5;
	Mon, 11 Jun 2018 08:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31343605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeFKIld (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:41:33 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36134 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbeFKIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:41:30 -0400
Received: by mail-ot0-f195.google.com with SMTP id c15-v6so12993867otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TmnMSW31W7emogKwwkYAvWa+F3h1OcjDAn7R9iSUhP4=;
        b=kuf9rofrJ1WBUlBiScEkf3UaK/y5qjxX90SycT9nvzeyJ5j7DYYVHQagvaZdl/Rx5D
         BkazIhIjPQAE/C7+TG2dRADgTTWpCjpnl8RaBmnONHvVuy+3rhdy6ZcaObyLe4YrGbxj
         sTuHRhA45EsnFimZpG5plm5qlbZGTkLYCLToY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TmnMSW31W7emogKwwkYAvWa+F3h1OcjDAn7R9iSUhP4=;
        b=badKz/UfSlI1ApcTVRNtXuX62m9xfQPg15uqj9XR7qR+nDqZKcyug2vAb/u9/lTN+6
         IG5rVJFr3TAU/dUnliKjCinrd2giVWoMLVMqTLWZTkSnorwQnYHC70fuc2HyZbdBuET0
         lYk7ue906cvIe/QgusoiWxETxfJxGR7zPvboWAt2ZBZmEEvot0vfNLdRxC2LpxTzFb9P
         OMX7bFJDMOSfi5nq+N2XX/54xm+HugdF3nllZDqgDVudj1ORbzyHreioXuyyHAm9FUGI
         ZBikvYxgRWP+Sw00NJPIMO3ab3QAmh8ELeqtf/56qa6aV4Y3N8/7o82wLruQZc8PH+aa
         kw+w==
X-Gm-Message-State: APt69E0dewkPuB1IT1qSUHb3krvyTfmi/he7K4mtaJp/qlvtAfLjr1FM
        9qsfeQy6ONTlO1iXW79al/xUICsY7LMwJT6XcjT3yw==
X-Google-Smtp-Source: ADUXVKJnrt2gf/spVoDIUtQQJGMHwSVw4MJB8tB4wAE4W4UwuEJW5GvBw2LwKuQSNttlao6UgB1zpXnjZHTKvxHftYQ=
X-Received: by 2002:a9d:1033:: with SMTP id h48-v6mr10063397ote.306.1528706490411;
 Mon, 11 Jun 2018 01:41:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:41:29
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610055326.GR30522@ZenIV.linux.org.uk>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org> <20180610055326.GR30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 10:41:29 +0200
Message-ID: <CAJfpeguG9urECaKoeiOBQLNyEFRFieg484ixWhaqtzhrGsASgQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 7:54 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jun 08, 2018 at 11:52:08PM -0700, Christoph Hellwig wrote:
>> On Fri, Jun 08, 2018 at 02:13:30PM +0200, Miklos Szeredi wrote:
>> > Hi Linus,
>> >
>> > Please pull from:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.18
>> >
>> > This contains two new features:
>> >
>> >  1) Stack file operations: this allows removal of several hacks from the
>> >     VFS, proper interaction of read-only open files with copy-up,
>> >     possibility to implement fs modifying ioctls properly, and others.
>>
>> Which includews all kinds of NAKed or at least non-acked VFS changes.
>
> Umm...  The worst of yours had been ->pre_mmap(), right?  He *did* drop that...
>
>> Please get these through Als tree after proper review first.
>
> OK, summary of sort (see fsdevel thread for details):
>         * path_open() is dubious; why not simply use vfsmount/dentry from the
> right layer when opening an underlying file?  Then it would be vfs_open()...
>         * ovl_mmap() is broken, plain and simple.  Failure ends up leaking
> a layer struct file *and* doing double fput() on overlayfs one.
>         * ovl_mmap() is also trivially DoSable - you can trigger tons and tons
> of reopens, each sticking a new (writable layer) struct file into a vma.
> We *do* want some scheme avoiding once-per-operations reopens in the
> copied-up-after-r/o-open case.  See possible kinda-sorta solution on fsdevel;
> I'm not sure I like it, though.

Al, thanks for the review.

Posted incremental for the ovl_mmap() issues to -fsdevel.  I'm pretty
confident that that addresses your comments.

Linus, would you still pull if Al's satisfied with that resolution?
I can post the fixes (just few liners) after the merge window.

I'm definitely not going to prepare another pull request this cycle if
the old one cannot be pulled.

Thanks,
Miklos
