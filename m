Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5E520817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU0Tsf0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5E520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeKJRgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:36:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45245 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeKJRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:36:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id p18-v6so2513930ywg.12;
        Fri, 09 Nov 2018 23:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50R9uDk1bDAJQaAv14u9y+Cw90fJILDABN+Nah2TERY=;
        b=VU0Tsf0zZt9yoAYczTEkNb2xrf0wZ7iqy+OK4pHrwIjNmpQ4hm9yI1EPu1Rl5kX8iA
         DfyaBT4D1/rxdUMF0pbxFdIeGzffjfE3mrEr4NoocSR39H1Hml27w6lF5uHOC4UXEGdM
         jxp2/X+syG0tm5OoHVqWLzS9OzOb/xoexZ/0uF/cLv1KM9nlm1i1fapuTbI/W5d2S5LP
         hQf8m7gtInrQtugAIqpYi++rPqdfXxCrOoIXOXQm6UFyj64XAI6Gx9LwF3zAuRx8KzNf
         Ctis/vfYPo9eKhYqzZHt7vX0rfdr5ZcRYcKUEf8zZgQ5m3NOdf+hZwIjnw2rxd6ZCKCB
         yufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50R9uDk1bDAJQaAv14u9y+Cw90fJILDABN+Nah2TERY=;
        b=EkfwSrPJiRqj/2iXiQweTqJ9BHr3RT8imMyXmZb3nn4XHPjsTFKevubFzo5yYu8hM/
         DOcTMROvEQYTZqxMSv36n9hb9JxfjmglvHSj4jidDp5OCnX1fnMJ78Dll1dBtIRyonRF
         bxCjBXupL+opycNJQJkGNnDz8uYf9qVXRQCnK4r/yomIW8pcl07X+zt7be7MA4U/SD7s
         fd2xtqu+YvDOhrbB7G7s52i3tHsIBiRh+e25vR3lbkvWcNXl1hqDigrO1sBLQQiuvL9D
         HrgzSMROUQzWD9a5vQ7kew/tqOzVtJVVZ8M8WG6HpXBA2NVmStMkPtE2A0ayUpbR68jq
         tTdA==
X-Gm-Message-State: AGRZ1gIgF7z9SdYcWmZfbaMiLOBhwxyArguonmDno6b593EYRz6NL0Et
        kK7nIHKd+p0ocTAKjkJ7Y8SA9Um+gVv0RQYI07c=
X-Google-Smtp-Source: AJdET5cp5K5x5nCia1Ikiem3UVNDRowAx70bC0d10D/J9QpCMVl48hY82JKVkiz7oJe8GtDmBtqdtv19IiFj2rYv0LA=
X-Received: by 2002:a0d:d181:: with SMTP id t123-v6mr11148140ywd.241.1541836317066;
 Fri, 09 Nov 2018 23:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20181106230117.127616-1-salyzyn@android.com> <20181106230117.127616-2-salyzyn@android.com>
 <20181108200106.GB3663@redhat.com> <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
 <CAOQ4uxjVPKSaJ2oscvM7jtsDVabnq_qMPg7k4KQEyOLAVPojcg@mail.gmail.com> <c6518e90-9429-85a1-fe19-83e058154e2a@android.com>
In-Reply-To: <c6518e90-9429-85a1-fe19-83e058154e2a@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Nov 2018 09:51:45 +0200
Message-ID: <CAOQ4uxgwQAf4NtaE+qhLUTVnvu0ixNZ6Gwotc4q4zR-y35NmZA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] overlayfs: override_creds=off option bypass creator_cred
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 7:32 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 11/08/2018 07:05 PM, Amir Goldstein wrote:
> >
> > Mark,
> >
> > I have some Android internals background, so I have a general
> > understanding of the
> > use case, but I can understand why people have a hard time connecting to the
> > motivation, thinking "their security model must be flawed".
> >
> > I am not sure if you are avoiding laying out the details of the model
> > because you
> > are not allowed to expose details or because you feel details may confuse us.
>
> I am not a "great communicator"(tm), probably only 50K vocabulary,
> propensity towards quantum leaps, so yes, I was worried about confusion.
> non-overlapping security model is the key takeaway I feel.
>

I hope my comment below will serve as an example why explaining your use
case is preferred to presenting the abstract and generalized problem.
And still - no objections to your current patch, *because* it can solve your
use cases and *because* we don't need to deal with the  abstract and
generalized problem.

> [TL;DR]
>
> In Android there are two use cases this covers:
>
> 1) On userdebug (rooted development) builds, adb remount feature
>     for readonly filesystems which include squashfs, ext4 dedupe,
>     and any right-sized (zero space left over) filesystems.  In these cases
>     the system will resort to utilizing overlayfs, and allow for
>     updated content to a scratch backing storage.
> 2) On operating system updates where new Hardware Abstraction
>     layers have been added and the vendor/oem supplied components
>     supplied to an older release.  In this corner case the operating
>     system update may carefully select overrides that are merged into
>     the vendor partition content directories as hosted by the
>     operating system partition.
>
> The sepolicy model can be browsed at
> https://android.googlesource.com/platform/system/sepolicy/.
>
> In the first use case above the possible insecurity is tempered by the
> debug nature
> of the system and the lurking big elephant in the room privilege
> escalation possibility
> (/system/bin/su existing),

Since you already have an elephant in the room, might as well use it
to mount overlay. I am guessing most of the work in developer mode is
with sepolicy disabled anyway?
Essentially, adb root/adb remount means gloves are off.
Although with overlayed adb remount gloves could be put back on
when you relinquish the overlay and get back to original /system mount.

> in the other a r/o and precise MAC. sepolicy
> and credentials
> will rule over transitions from one security domain to another for
> execution, vendor components are managed by a separate vendor_init and
> the actual xattr content is constant.
>

For this use case, you don't need an upper layer at all and you probably
don't use lower layers redirect_dir. Right?
So all the concerns about get/set trusted overlay xattrs and detecting
opaque directories (do you need those?) are moot.
If you propose that override_creds=off can only be enabled
on lower-only overlayfs, the caveats section of your documentation
would shrink down considerably to the point that it may even be
comprehend-able to mortal users and I don't think you will see much
resistant from overlayfs developers to that "safe side" approach.

> Being able to block reading a file or directory is not a big concern in
> the associated trees, because all of the originals are backed by a r/o
> filesystem image, the content
> is generally visible by all, and if not they are locally restricted
> views into a public filesystem image, that themselves can be mounted on
> a desktop. There are no privilege escalation or privacy issues.
>
> An Android use case this does not cover securely is when overlayfs is
> used as a
> snapshot of the users data during the update process to permit easy
> rollback of user data due to an
> update failure (very unlikely 0.01%, but alas there are tachyons with
> our names on them).
> For those use cases we have opted to add snapshot-ting to
> f2fs and ext4 (using dm-bow in another patch set under discussion for
> the time being)

Very interesting... that's a use case of overlayfs snapshots [1] I was
not aware of.
With regular overlayfs, mounter creds are used to create the "master" copy
while "origin" is left unchanged. With overlayfs snapshots, the "master" copy
is modified by user while the "backup" copy is created with the snapshot
mounter credentials.

> and abandoned overlayfs as insufficient in a dynamic non-overlapping DAC
> and MAC security model.

Essentially, dm-bow target has the same capabilities as overlayfs driver with
mounter creds. When creating the backup copies of modified blocks, it does
not consult the per file granular security policy - not sure if that
is a security
concern? (cc: Paul Lawrence)

As a matter of fact, because the overlayfs snapshots "backup repository"
is a directory tree, granular per file security policy could be applied during
BOW and/or during commit.

> Built in filesystem snapshot-ting is always preferred for performance,
> efficiency and access to the free block pools they maintain so that was an
> easy choice.
>

That's a bold statement and not entirely true.

Overlayfs (as do overlayfs snapshots) is much more efficient in page cache
usage (for unmodified files) than btrfs snapshots and dm thinp.
There is no issue with accessing the "free blocks pool" when the snapshot
solution is at the vfs level (as opposed to block level).
In fact, these two characteristics are probably the main thing going for
overlayfs as a choice for container storage driver.

Nevertheless, it doesn't seem like the Android userdata rollback feature
should care about efficiency of snapshot access at all.

All in all, I think that dm-bow is a neat solution for the specific use case,
but do not confuse it with "built-in filesystem snapshot support".
Getting there with ext4 is much harder. I know because I tried... [2].

Thanks,
Amir.


[1] https://github.com/amir73il/overlayfs/wiki/Overlayfs-snapshots
[2] https://github.com/amir73il/next3-utils/wiki/Ext4-snapshots-TODO
