Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC284C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB02081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOuZEnuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAB02081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeKBWX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:23:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41553 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeKBWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:23:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id c126-v6so738917ywd.8;
        Fri, 02 Nov 2018 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zII6NG7oAxAyfHK7Hd1Yrf41Dz1ahku8YMRacypeL5I=;
        b=FOuZEnuOW2r9cxDcprEpPql/6FbYTCCZPUmdE7QI/X6aSlLgrZOzluxffSk3uK+WL0
         QGbTEoU2MX8/EtZw8nIjXPmo8OKIjM2HdylkE5UGMnKV0Zk/KR+7HnxwYea2es6L8R7E
         m5gj1zDqnttxDJIvUzTb/3MDP70wpj8PwP0oHAlGkdQJVSt3c6hnDhyjMRSNABbSWxnU
         mHtHk+vAuiGBJag0QjOd0BnRb2VPvbbMZ1Yd/4uybBZ/V9l8+ARFhh+42fQDyy6no47r
         llADMWmZNvURUgp3nk6J6U9zLcPE6rA2c4nVh/pXAEJwVyVfFcJL2TSPTVmRvepv5A5s
         DbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zII6NG7oAxAyfHK7Hd1Yrf41Dz1ahku8YMRacypeL5I=;
        b=pWkrewPi+56eV55PY463DplCPkmyeGdAPDjXd2X2tu6mGvYHJdipEDwhbphG0pPat0
         Jd8andaW3gUfN2IeYO5dR4GzLSsjv1mw1s0opdrHSBYEvXeiBfSL17vNUP1OjMdEGH14
         ek/hyKl3kGycldiBOvJHbTSSl1VdvTaYCd7SpsAU41/BmTDhRtYMheKeveNcp8GLuy7W
         XasElIw9zjZw7toH+ednKCx9LGyTXFdh4SO2IDdQv84yqhLiGqL4TZ6JBMWtR1iXdZc9
         jXQOU589tuEr3SiMbi9R8las3zO/oefYeT6MfLu4uTVmCWuMQUv0zFnkS/HvW44PgSxO
         PHsw==
X-Gm-Message-State: AGRZ1gI0g5ykOUgb4EuVRNQHSJbPQG507p+0lBnUx9BCzmSCKEcrRrzq
        gCtzrBx+GoYbxV8Yw0YgCqqOaG/6JGGpJpUmm+I=
X-Google-Smtp-Source: AJdET5f7wv2HbRFE5QcIfaGLr/tVHjUBZZW/fuPDs7SHymvoYXImAoAdkXAWLb/Z3TYvKELN2HQQAIIHgcs4Z1+Xstk=
X-Received: by 2002:a81:8644:: with SMTP id w65-v6mr1204707ywf.409.1541164577525;
 Fri, 02 Nov 2018 06:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181101214856.4563-1-seth.forshee@canonical.com>
 <20181101214856.4563-7-seth.forshee@canonical.com> <CAOQ4uxhkH+0tchHkrgvBZGYzeLD2fGGgtkKstt3JmhPDaGW_dg@mail.gmail.com>
 <20181102124400.GB29262@ubuntu-xps13>
In-Reply-To: <20181102124400.GB29262@ubuntu-xps13>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Nov 2018 15:16:05 +0200
Message-ID: <CAOQ4uxhbgzYzdRBwbDNBKgjjmM3M=hya5-LJhiKmxxZxOo=2CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] shiftfs: support nested shiftfs mounts
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:44 PM Seth Forshee <seth.forshee@canonical.com> wrote:
>
> On Fri, Nov 02, 2018 at 12:02:45PM +0200, Amir Goldstein wrote:
> > On Thu, Nov 1, 2018 at 11:49 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> > >
> > > shiftfs mounts cannot be nested for two reasons -- global
> > > CAP_SYS_ADMIN is required to set up a mark mount, and a single
> > > functional shiftfs mount meets the filesystem stacking depth
> > > limit.
> > >
> > > The CAP_SYS_ADMIN requirement can be relaxed. All of the kernel
> > > ids in a mount must be within that mount's s_user_ns, so all that
> > > is needed is CAP_SYS_ADMIN within that s_user_ns.
> > >
> > > The stack depth issue can be worked around with a couple of
> > > adjustments. First, a mark mount doesn't really need to count
> > > against the stacking depth as it doesn't contribute to the call
> > > stack depth during filesystem operations. Therefore the mount
> > > over the mark mount only needs to count as one more than the
> > > lower filesystems stack depth.
> >
> > That's true, but it also highlights the point that the "mark" sb is
> > completely unneeded and it really is just a nice little hack.
> > All the information it really stores is a lower mount reference,
> > a lower root dentry and a declarative statement "I am shiftable!".
>
> Seems I should have saved some of the things I said in my previous
> response for this one. As you no doubt gleaned from that email, I agree
> with this.
>
> > Come to think about it, "container shiftable" really isn't that different from
> > NFS export with "no_root_squash" and auto mounted USB drive.
> > I mean the shifting itself is different of course, but the
> > declaration, not so much.
> > If I am allowing sudoers on another machine to mess with root owned
> > files visible
> > on my machine, I am pretty much have the same issues as container admins
> > accessing root owned files on my init_user_ns filesystem. In all those cases,
> > I'd better not be executing suid binaries from the untrusted "external" source.
> >
> > Instead of mounting a dummy filesystem to make the declaration, you could
> > get the same thing with:
> >    mount(path, path, "none", MS_BIND | MS_EXTERN | MS_NOEXEC)
> > and all you need to do is add MS_EXTERN (MS_SHIFTABLE MS_UNTRUSTED
> > or whatnot)  constant to uapi and manage to come up good man page description.
> >
> > Then users could actually mount a filesystem in init_user_ns MS_EXTERN and
> > avoid the extra bind mount step (for a full filesystem tree export).
> > Declaring a mounted image MS_EXTERN has merits on its own even without
> > containers and shitfs, for example with pluggable storage. Other LSMs could make
> > good use of that declaration.
>
> I'm missing how we figure out the target user ns in this scheme. We need
> a context with privileges towards the source path's s_user_ns to say
> it's okay to shift ids for the files under the source path, and then we
> need a target user ns for the id shifts. Currently the target is
> current_user_ns when the final shiftfs mount is created.
>
> So, how do we determine the target s_user_ns in your scheme?
>

Unless I am completely misunderstanding shiftfs, I think we are saying the
same thing. You said you wish to get rid of the "mark" fs and that you had
a POC of implementing the "mark" using xattr.
I'm just saying another option to implement the mark is using a super block
flag and you get the target s_user_ns from mnt_sb.
I did miss the fact that a mount flag is not enough, so that makes the bind
mount concept fail. Unless, maybe, the mount in the container is a slave
mount and the "shiftable" mark is set on the master.
I know too little about mount ns vs. user ns to tell if any of this makes sense.

Feel free to ignore MS_EXTERN idea.

Hopefully, mount API v2 will provide the proper facility to implement mark.

Thanks,
Amir.
