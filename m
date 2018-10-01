Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BE22089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="e5PaOw9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BE22089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeJATib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:38:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeJATib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:38:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so6580013wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YcN+0616Nl590kr5tuSxXRX3PfxiaTH08aIp+bAMZU=;
        b=e5PaOw9qFQMjW61vJ7WjpDaSVHKMeTIlRDRooOg8nYKHJAtI+W1Ct0rycSW9MUC8BT
         rvY4RPdBd9z51tXFadGJ6FiA/Z7Q+K2Z+GLVsZ73p4F/YUjUjUMvGcYSoTlNMe1vKk8q
         kRwaKNQxR6/sBZRa2MRoRb6Z5beRzznJO/CM2Cr2lKaaBrs31Pz2OE7lj0JucWk/QPrh
         wvtWdDG0E3DjfxMNM1nigk1gT3RRKL/s+3w6lCbYtH2qxpAI/+d1pVkIVWVdD3/3vKaP
         pFdh9LVFRbEvEAGn0wVfWm7xtoX/cnA2LJGiuT8eC8iaB4SupRSEHu/JfQI/kHoyoeOF
         7PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YcN+0616Nl590kr5tuSxXRX3PfxiaTH08aIp+bAMZU=;
        b=lEVqVIE6D/crxVm4nAS4qUfrVD7zRRkYwM8a8PwGvjsoXSTrVZDP4aIcfjtELe7Yk7
         Ef9yML+KtaF8XAg2tE2mxu8bjVroDMWoeXgGRDKaZoLtJbhnvilOZsmqX7WjlqyQAEMP
         raN4AnJaFWBVfmJUvedePf/QrsL3wuXU/fP+7VDlB/ONTCPa//utUFLhmm6AlR9ZFl6K
         YNp4wWbPXAnAtKa5eEEi2UsoMefQC2z49Ii22zsMu5V63ngPVXslvUhwNrkQNCGhBHRg
         8GZCbh6iTxZMt93T1dbfa6YeVxgebJdn+xNn5Y4xFQv/OdT3lQR/nK+5lFjnZh+p3i2w
         /I1w==
X-Gm-Message-State: ABuFfogWtLIFazbRixTUNkW2zBZkZp+keGev3elkOpF0pl7K4QRrYRqR
        TgiT/QknfT4RUWffvebiWlbjNw==
X-Google-Smtp-Source: ACcGV60SfE9kLnNwLhePfE6xk95clATXPxgTKXNBT8+SyiMnyImmsoQ+5XA/LJ5pEjkPkoaPh8aIXg==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr7085334wrm.145.1538398846479;
        Mon, 01 Oct 2018 06:00:46 -0700 (PDT)
Received: from brauner.io (u-087-c227.eap.uni-tuebingen.de. [134.2.87.227])
        by smtp.gmail.com with ESMTPSA id t24-v6sm470393wra.5.2018.10.01.06.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 06:00:45 -0700 (PDT)
Date:   Mon, 1 Oct 2018 15:00:39 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181001130038.s5ztphs3pl2zt3ut@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
 <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 02:28:03PM +0200, Jann Horn wrote:
> On Sat, Sep 29, 2018 at 4:28 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > Add the following flags for path resolution. The primary justification
> > for these flags is to allow for programs to be far more strict about how
> > they want path resolution to handle symlinks, mountpoint crossings, and
> > paths that escape the dirfd (through an absolute path or ".."
> > shenanigans).
> >
> > This is of particular concern to container runtimes that want to be very
> > careful about malicious root filesystems that a container's init might
> > have screwed around with (and there is no real way to protect against
> > this in userspace if you consider potential races against a malicious
> > container's init).
> >
> > * AT_BENEATH: Disallow ".." or absolute paths (either in the path or
> >   found during symlink resolution) to escape the starting point of name
> >   resolution, though ".." is permitted in cases like "foo/../bar".
> >   Relative symlinks are still allowed (as long as they don't escape the
> >   starting point).
> 
> As I said on the other thread, I would strongly prefer an API that
> behaves along the lines of David Drysdale's old patch
> https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/
> : Forbid any use of "..". This would also be more straightforward to
> implement safely. If that doesn't work for you, I would like it if you
> could at least make that an option. I would like it if this API could
> mitigate straightforward directory traversal bugs such as
> https://bugs.chromium.org/p/project-zero/issues/detail?id=1583, where
> a confused deputy attempts to access a path like
> "/mnt/media_rw/../../data" while intending to access a directory under
> "/mnt/media_rw".

Oh, the semantics for this changed in this patchset, hah. I was still on
vacation so didn't get to look at it before it was sent out. From prior
discussion I remember that the original intention actual was what you
argue for. And the patchset should be as tight as possible. Having
special cases where ".." is allowed just sounds like an invitation for
userspace to get it wrong.
Aleksa, did you have a specific use-case in mind that made you change
this or was it already present in an earlier iteration of the patchset
by someone else?

> 
> > * AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
> >   from one). The primary "scoping" use is to blocking resolution that
> >   crosses a bind-mount, which has a similar property to a symlink (in
> >   the way that it allows for escape from the starting-point). Since it
> >   is not possible to differentiate bind-mounts However since
> >   bind-mounting requires privileges (in ways symlinks don't) this has
> >   been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
> >   (though find(1) doesn't walk upwards, the semantics seem obvious).
> >
> > * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
> >   specific restriction, and it exists because /proc/$pid/fd/...
> >   "symlinks" allow for access outside nd->root and pose risk to
> >   container runtimes that don't want to be tricked into accessing a host
> >   path (but do want to allow no-funny-business symlink resolution).
> 
> AT_BENEATH has to imply AT_NO_PROCLINK, right? Especially with the
> semantics you picked for AT_BENEATH. With the original O_BENEATH_ONLY
> semantics, it might be okay to not imply AT_NO_PROCLINK...
> 
> > * AT_NO_SYMLINK: Disallows symlink jumping *of any kind*. Implies
> >   AT_NO_PROCLINK (obviously).
> >
> > The AT_NO_*LINK flags return -ELOOP if path resolution would violates
> > their requirement, while the others all return -EXDEV. Currently these
> > are only enabled for the stat(2) family and the openat(2) family (the
> > latter has its own brand of O_* flags with the same semantics). Ideally
> > these flags would be supported by all *at(2) syscalls, but this will
> > require adding flags arguments to many of them (and will be done in a
> > separate patchset).
