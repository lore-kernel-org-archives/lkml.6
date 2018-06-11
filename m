Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R2HRAv8fHlvhSQAAmS7hNA
	; Mon, 11 Jun 2018 07:09:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A891607BB; Mon, 11 Jun 2018 07:09:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MeaLhXvX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DAC8606FA;
	Mon, 11 Jun 2018 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DAC8606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFKHJH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:09:07 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38151 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeFKHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:09:05 -0400
Received: by mail-ot0-f194.google.com with SMTP id n3-v6so22575075ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EbE77kF6+OynJ/bbplasKtmMn1oidHGDxdyMxsprOQg=;
        b=MeaLhXvXkCJp4r3oEAZBcabo5yT+D4oZrf89mZZiOyMnNVItio+Uybd0FgTv7J1Y33
         k5E+JNP1d1SsAo434qGLk1ewAN8eEoY5y7pgChj5UqEyiu/tVWozS5wW6j+RqLxpndIx
         hFNDHxVjxU+5Ew3f+pMh7RcuQEDVGyLsmJsGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EbE77kF6+OynJ/bbplasKtmMn1oidHGDxdyMxsprOQg=;
        b=QCW+jiyIRyZS55WnBH3WmXFdnDN7AnMatzkoUER8DPHkjeVidcIZ3ecKvS6AXt1am3
         FPnpSU4GXa/e2V9jBLGXDuxWgvJQUXKF7uJa3HL390R5tCUOOOkTSpJhCP9XTPOL5O1X
         0TayYwl/MLSYMfHB1e7UmGht1D2mtISRCkOlHXo4Jf9wx+S1eQh2AREKNxLcz03R1qX8
         7Aib3MZkJk6mUtFdsm4rRRuUh0lV6+TN7dZAWlr9ADwIxc699EXpuoVq3Oruxt8wD77A
         eYur4u2dlVAK7spUxu1MEVM8ex0cTw+YlqtFaDdLg1eoY8oqglyGigM/5vaJf+ElhH9q
         Sr/w==
X-Gm-Message-State: APt69E0KGlsdEBPU8NRRcYdfgztlARC2KgGnGC+YbgJwSoMgjzFbj/r5
        maz+MyzSPW6vnqhZ3mCT2fCVmcqR4dVtbWgYFMkPEw==
X-Google-Smtp-Source: ADUXVKKDvvAu1/C74hH1Dttcbob9mAZFcqrtWRvGabbArn/lqR/a4FbPlWkWgKdJ1iLqbNjOB5aa4y8utfGpbmAAavI=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr8651302otk.368.1528700945150;
 Mon, 11 Jun 2018 00:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:09:04
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610041243.GJ30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 09:09:04 +0200
Message-ID: <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
Subject: Re: [PATCH 14/39] ovl: stack file ops
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 6:13 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, May 29, 2018 at 04:43:14PM +0200, Miklos Szeredi wrote:
>> Implement file operations on a regular overlay file.  The underlying file
>> is opened separately and cached in ->private_data.
>>
>> It might be worth making an exception for such files when accounting in
>> nr_file to confirm to userspace expectations.  We are only adding a small
>> overhead (248bytes for the struct file) since the real inode and dentry are
>> pinned by overlayfs anyway.
>>
>> This patch doesn't have any effect, since the vfs will use d_real() to find
>> the real underlying file to open.  The patch at the end of the series will
>> actually enable this functionality.
>
>> +static struct file *ovl_open_realfile(const struct file *file)
>> +{
>> +     struct inode *inode = file_inode(file);
>> +     struct inode *upperinode = ovl_inode_upper(inode);
>> +     struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
>> +     struct file *realfile;
>> +     const struct cred *old_cred;
>> +
>> +     old_cred = ovl_override_creds(inode->i_sb);
>> +     realfile = path_open(&file->f_path, file->f_flags | O_NOATIME,
>> +                          realinode, current_cred(), false);
>> +     revert_creds(old_cred);
>> +
>> +     pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
>> +              file, file, upperinode ? 'u' : 'l', file->f_flags,
>> +              realfile, IS_ERR(realfile) ? 0 : realfile->f_flags);
>> +
>> +     return realfile;
>> +}
>
> IDGI.  OK, you open a file in the layer you want; good, but why the hell do you
> *not* use the dentry/vfsmount from the same layer?
>
> IOW, why does your path_open() get an explicit inode argument at all?  With the
> rest of the work done in that series it looks like you should be able to use
> vfs_open() instead...  Sure, for ovlfs file you want ->f_path on overlayfs and
> not in a layer, but why do the same for those?

I'd really like to get there some time but...

List of basic requirements:

 - Private mmap of overlay file shares page cache with lower file (and
hence with all other overlays using the same lower file).

 - /proc/PID/maps shows correct path.

Thought about setting f_mapping/i_mapping of overlay file to that of
underlying file.  But that breaks when doing a copy-up.  We can't just
go and change those mapping pointers, assumption is that those remain
constant (we'd need READ_ONCE() for all cases where we use the mapping
more than once).  It's probably doable, but it's a large and fragile
change.

Thanks,
Miklos
