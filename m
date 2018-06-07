Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 55DOMwPOGFuDfgAAmS7hNA
	; Thu, 07 Jun 2018 06:17:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB1BA6089E; Thu,  7 Jun 2018 06:17:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpxWFB7Y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 154D4601B4;
	Thu,  7 Jun 2018 06:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 154D4601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeFGGRb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:17:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34369 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeFGGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:17:29 -0400
Received: by mail-yb0-f195.google.com with SMTP id n23-v6so1552100ybg.1;
        Wed, 06 Jun 2018 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dTtJ26Ko258oAa23b5KZAs2hrd9ZpTEj1tcAqFlIjLE=;
        b=XpxWFB7Yw9Fg1UJPp8H45t+ra2YpoIDUkQrj6bCUKlfsuVOmwFcqBJ8SCvTVoXZdtx
         52tsZ9PxbMJu6lTnJncqzuQrbI6fKDmGE0o93xwHoqS9I0aavRb/2fhb7+3j9427QMUO
         JMd7UGVVCjvugbmJeKxY5icV0T+5MI6RndbEB9k7P9Ubps3oMEBkhiZqA8rKTRgJBnzB
         RLMc9qJhiMl6+anANnURsiGvHBj8eX8//Tk+drbvVzTtVvSScFsKQeXw11ITZThbrb5A
         qm6cUL1KMBSaBUo78vIXvbWQ+XTYLLaOwcSSnYQUHM2GbNbaAz/nmeO+bo8e9ywubyQR
         XcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dTtJ26Ko258oAa23b5KZAs2hrd9ZpTEj1tcAqFlIjLE=;
        b=jLBlUHDVOtY/g7/RM8dYztMiidLXQJCBh44z6vzi/6WItLIeAvNQfNVNc7tldVsAMV
         7t2I4W5fiEkTZa003XyQGivmYRXFz1vpJkfRSSvEPqM+g/YXGlexx2kmqo8J9bmIFr8G
         dxp64rvR1tI7PP7FCY7xhl1n77KxzXTTDSAOGFT6ZIvYU+LRhNFV1+iG/b80GO1kLVWj
         KjXZg+DO7DKXVhxlS113ydz3QMPyW3QC3Z5RhFBIQoAQoUQ2jORatP+hDZXtFPnGvbY4
         6b0LG0SzDbAI5seShaWT71ZTf4UNJ2OC3DZT66IMqp1stQkhzqAB9LyV1i6vbFclKzoO
         91jA==
X-Gm-Message-State: APt69E1KfWbSmGOWz2dd8OaFf1Txt+o8Tu9TweqXN6vEoElpaOLq8+nk
        flPCnygUQ+Dp1G+mUI+Hx43hgQJM0+gzNHVG20E=
X-Google-Smtp-Source: ADUXVKL3XSIqHrwlf+NKSh1YVGuXN3rV6bket+Co3eJtaSKCWltlBozokB4ngDzIQtpuUuF4BH/CNULylHe2Q7Fr/gA=
X-Received: by 2002:a25:9947:: with SMTP id n7-v6mr274650ybo.141.1528352247537;
 Wed, 06 Jun 2018 23:17:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:79cf:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 23:17:26 -0700 (PDT)
In-Reply-To: <7e983476-df86-2624-ee6d-7c5415ea349a@suse.com>
References: <20180508180436.716-1-mfasheh@suse.de> <20180508233840.GM10363@dastard>
 <e6698201-a4a6-2146-d4c9-9e26c18ad828@suse.com> <20180509064103.GP10363@dastard>
 <5b2ae799-1595-c262-7b65-41b10c11906d@suse.com> <CAOQ4uxjUwi7dhTbNk1mK6_=rb_+L0JB1GG_mkGSDrudtocXScg@mail.gmail.com>
 <7e983476-df86-2624-ee6d-7c5415ea349a@suse.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Jun 2018 09:17:26 +0300
Message-ID: <CAOQ4uxisMcY4WxaudRts52PLzC42A3VhVUW4SisxwXihGix7kg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/76] vfs: 'views' for filesystems with more than one root
To: Jeff Mahoney <jeffm@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Mark Fasheh <mfasheh@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:19 AM, Jeff Mahoney <jeffm@suse.com> wrote:
[...]
>>
>> FYI, the Overlayfs file/inode mapping is about to change with many
>> VFS hacks queued for removal, so stay tuned.
>>
>> [...]
>
> I have to admit I'm curious how this will work.  I've heard rumor of
> using overlayfs inodes and calling the underlying file system's
> inode_operations.  If part of that work removes the danger of overlayfs
> inode numbers colliding with xino mode, I'm definitely interested.

See https://marc.info/?l=linux-fsdevel&m=152760014530531&w=2

It doesn't remove the need to maintain a unique and persistent inode
number namespace in overlayfs. It just reduces exposure of the underlying
inode to VFS.

[...]

>>> - Audit.  As it happens, most of audit has a path or file that can be
>>> used.  We do run into problems with fsnotify.  fsnotify_move is called
>>> from vfs_rename which turns into a can of worms pretty quickly.
>>>
>>
>> Can you please elaborate on that problem.
>> Do you mean when watching a directory for changes, you need to
>> be able to tell in which fs_view the directory inode that is being watched?
>
> I was investigating whether Dave's suggestion of using a vfsmount was
> feasible.  When following the audit call graph up, I found
> fsnotify_move, called by vfs_rename.  Piping a vfsmount into the vfs_*
> operations has historically been rejected by Al (see Apparmor
> discussions, among others), and with good reason.  The file system
> implementation shouldn't care about where it's mounted.  While piping it
> into vfs_rename doesn't seem too invasive, it's called by various file
> systems' ->rename callback, so then we're stuck piping vfsmounts into
> inode_operations, which is what Al's been wanting to avoid for years.
>

Yes, I've heard about this objection, thought didn't have a reference.

[...]
>>
>> I have an interest of solving another problem.
>> In VFS operations where only inode is available, I would like to be able to
>> report fsnotify events (e.g. fsnotify_move()) only in directories under a
>> certain subtree root. That could be achieved either by bind mount the subtree
>> root and passing vfsmount into vfs_rename() or by defining an fs_view on the
>> subtree and mounting that fs_view.
>
> I'm not sure there's a lot of overlap, but I expect that this will end
> up running into the same review feedback that Al gave during the
> AppArmor merge: vfsmounts have no business at the lower level and you
> can get the same behavior by hooking in at a higher level.  See
> security_path_* vs security_inode_* for how that was resolved.
>
> What you're talking about isn't really what we had in mind for the
> fs_view.  In our case, it sits between the inode and superblock, which
> would be at too low a level for determining whether an inode is under a
> certain subtree.  In any event, wouldn't you need a path instead of an
> inode to do what you're proposing?
>

Not if the fs_view could have a root that is different than sb root
then I could attach fsnotify mark to fs_view instead of say vfsmount
and I have the information I need inside fsnotify_move().

Thanks,
Amir.
