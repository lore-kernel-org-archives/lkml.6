Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HGxHEFPLGFv9cwAAmS7hNA
	; Thu, 07 Jun 2018 06:06:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DF9B46089E; Thu,  7 Jun 2018 06:06:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJiAU4U0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FA55602FC;
	Thu,  7 Jun 2018 06:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA55602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeFGGGK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:06:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34703 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeFGGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:06:07 -0400
Received: by mail-yw0-f193.google.com with SMTP id b125-v6so2680274ywe.1;
        Wed, 06 Jun 2018 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MvtZ7nBUnCH/F6h6d5ya1aWf9ueSpjnBXjpm0YA/TYk=;
        b=oJiAU4U0R2EeGOoaRVcHk2JcMgpgnuYgisnu1GCuwdluDFEeq9PQoK0x1/pV+UxZ+y
         RbhuGYXrNSXEfVA5w2SKhfIwPVa/FB15zcJM9nkFObaRZnLQPq8EyL2aJc6q7Rc0Agt8
         rW6c4CSQbkS2qpdGtxa/AtezRHndpphJdlq0Q5YS9myVDG0/HS6CjZV9/5UWnCvc3PZM
         Xw+f3pQixN3B3IGFJSANkIIimLAUxx4ZLkaB7Vk1WjAOqBWMusRw/XnlVOWo3evFCEyq
         2TOGatHGerdSB8MTQ6zngFGFlgbNQCRUfz4G0Xq3RXpNwwZ0CEtv0gxZuxHfQM66u4ph
         B51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MvtZ7nBUnCH/F6h6d5ya1aWf9ueSpjnBXjpm0YA/TYk=;
        b=TiFi+H6OkI8qjphxAsCCDKXqO1WttRB4xL+OREcAfbBaV9/WMKJz4uYRGWolOgIpJP
         LlzJuNbQLNQlgJ+BiOjv6fmA+uuwMG1qBxjUB3HCqMiKFV4sn5X8zlmQ6ztZD/9uEq8b
         BUl+E/GOBKaJntowYDqtZFqbYRBFNmeR8SHeujduE5UcCofOPYfwfkwc7BxEmKTfBZ4x
         fwcAKUejy4baDwmFmuTq/h6CVLA5GqJsyLXGOmgfj2Trfzm5jrrMjccsBxgH2/NjrFlg
         oLaQWMiFwgfK6By246QMf8i8hwptGdZRP0pmljYbobJ8SVkrjk3A/MK72sRLw3UFq5E6
         NR8A==
X-Gm-Message-State: APt69E0OzK88pXON+b8P0ILm0nUEmeudWq6aDQ/ZZucko1tgiwrb20l3
        kHWFQr0HQcc1EvsOyH26xjcYc43PYMknaRYry0Q=
X-Google-Smtp-Source: ADUXVKJw8uUX8w9Z/Rv68Vx7KUGzboxUuHVrVCId+h+woaAhMVvAZcZnHM9vl76zn4BaCAQkm0leo1op6lFuz6Mow7E=
X-Received: by 2002:a81:168a:: with SMTP id 132-v6mr263147yww.183.1528351565414;
 Wed, 06 Jun 2018 23:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:79cf:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 23:06:04 -0700 (PDT)
In-Reply-To: <20180606204215.GD9445@wotan.suse.de>
References: <20180508180436.716-1-mfasheh@suse.de> <20180508233840.GM10363@dastard>
 <e6698201-a4a6-2146-d4c9-9e26c18ad828@suse.com> <20180509064103.GP10363@dastard>
 <5b2ae799-1595-c262-7b65-41b10c11906d@suse.com> <CAOQ4uxjUwi7dhTbNk1mK6_=rb_+L0JB1GG_mkGSDrudtocXScg@mail.gmail.com>
 <20180606204215.GD9445@wotan.suse.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Jun 2018 09:06:04 +0300
Message-ID: <CAOQ4uxgiUu8Vv__uYP+g5Q+c1Ng=_v0mx4t0A6D8fNsA6usbMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/76] vfs: 'views' for filesystems with more than one root
To: Mark Fasheh <mfasheh@suse.de>
Cc: Jeff Mahoney <jeffm@suse.com>, Dave Chinner <david@fromorbit.com>,
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

On Wed, Jun 6, 2018 at 11:42 PM, Mark Fasheh <mfasheh@suse.de> wrote:
> Hi Amir, thanks for the comments!
>

Hi Mark,

[...]
>
> Btw, sorry that the name is confusing. I've never been good at picking them.

Didn't say that it was confusing. It might very well be the perfect name...
if I only knew what sort of thing we are trying to name...

> That said, if you have a minute to check out the first patch or two you'll
> see that the patches are basically putting a struct in between the super
> block and the inode.
>
>
> One thing I'd like to politely suggest is that anyone now following this
> conversation to please read the at least the first patch. It's an easy read
> and I feel like the conversation overall would be much more clear if
> everyone understood what we're going for. I worry that I didn't do a
> particularly good job explaining the actual code changes.
>
> https://www.spinics.net/lists/linux-fsdevel/msg125492.html
>


I did look at the patches. They look simple and clean and they solve A problem.
All I'm saying is that we should look at the set of problems that we know of
before we design an abstraction layer.

>
> Regarding a layout of the problems, I have a more complete e-mail coming
> soon which should describe in detail the issues I've seen with respect to
> how the kernel is exporting ino/dev pairs (outside of statx). fs_view alone
> is not enough to solve that problem. I'd be happy to CC you on that one if
> you'd like.
>

Sure.

[...]

>>
>> And what is the SUSE way?
>
> At SUSE, we carry a version of this patch:
>
> https://marc.info/?l=linux-btrfs&m=130532890824992&w=2
>
> Essentially a callback which was rejected for various reasons.
>

Don't see a patch here. Wrong link?

> The fs_view work was intended to replace that patch with an upstream
> solution.
>
>

[...]

>>
>> FYI, the Overlayfs file/inode mapping is about to change with many
>> VFS hacks queued for removal, so stay tuned.
>>
>> [...]
>
> Actually, would you mind giving me a pointer to this work? I'd be very
> interested to see what exactly might be changing.
>

Mostly, less VFS code is going to be exposed to underlying inode:

https://marc.info/?l=linux-fsdevel&m=152760014530531&w=2

[...]

>> I have an interest of solving another problem.
>> In VFS operations where only inode is available, I would like to be able to
>> report fsnotify events (e.g. fsnotify_move()) only in directories under a
>> certain subtree root. That could be achieved either by bind mount the subtree
>> root and passing vfsmount into vfs_rename() or by defining an fs_view on the
>> subtree and mounting that fs_view.
>
> I'm not sure whether fs_view works for this. Taking a quick look at
> fsnotify, the state is already on the inode? If there's a globabl fsnotify
> state that needs to be per subtree than yes we could move that to the
> fs_view and you'd simply deref it from the inode struct.
>

That was my thinking. I have patches to attach an fsnotify mark
to super block. If fs_view could have a root that is different than
super block's root and if file system can guaranty that objects
cannot be moved outside of fs_view root, then fsnotify mark
could be attached to fs_view.

Thanks,
Amir.
