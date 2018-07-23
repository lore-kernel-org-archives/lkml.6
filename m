Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A2C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A2C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbeGWQCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:02:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbeGWQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:02:03 -0400
Received: from mail-wm0-f71.google.com ([74.125.82.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fhcK0-000191-2X
        for linux-kernel@vger.kernel.org; Mon, 23 Jul 2018 15:00:24 +0000
Received: by mail-wm0-f71.google.com with SMTP id p3-v6so565682wmc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LS2s+VIdfiE9MsVYTw8WLqb/DgO9WqRDOTX5hGdmkGs=;
        b=GGEFX50uiEw9ZB7nInS8v2Dz1ToNudlmEGxDX7wrOtddkDlleTEwI9vAYSTIEHyRvc
         E1WApaPQxI3Ij4+i4wpBLSBOC9I0tFvGka2h03UeYhtFIOxOIVp8zNXWmwKqtZXVHtA+
         vZ84mAVf4YZgidHke2iodVVpsuKq3+LeTSfGStO4aBtRVqHb1ojPgo4iVzgDDskCt/7j
         MfDK2jI8kHwFJRprzw4f2yeMXbHdTbNJakM5D2qy4Q9G8J4jieuZXNB+XesXMC6HQNht
         1ZhSOKezRzeyPk6ttjAKkVOVubr722e7c+VqJpIicZNM4lwmlt3//uLhKeMnsChk3DJQ
         Xg/w==
X-Gm-Message-State: AOUpUlELM+rp8v0LL533FQpLGWOy4r9bWJ+AuWhn8fFi3iWdYD5as+sx
        gTrLEL5w2fcRxVQKhGWAqLTM7P7sX/rNZiL37/brEKGiKcKk94TgnRBkSRpymfuNYDsmwLarZ3n
        OG14wNRcvGlnv9xLLMEmVijTgNZu5jdxmV3eOWLtTcQ==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr7548818wmg.44.1532358023651;
        Mon, 23 Jul 2018 08:00:23 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdyN8ghpBxuVauh4ObbutRYd+arVvB3xyrEkEIesejgxYz7kdw8wKUpqw5eljvu/8qg5BT+Qw==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr7548805wmg.44.1532358023295;
        Mon, 23 Jul 2018 08:00:23 -0700 (PDT)
Received: from gmail.com (u-085-c242.eap.uni-tuebingen.de. [134.2.85.242])
        by smtp.gmail.com with ESMTPSA id m10-v6sm10584438wrj.35.2018.07.23.08.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 08:00:22 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Mon, 23 Jul 2018 17:00:22 +0200
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cjwatson@ubuntu.com, ebiederm@xmission.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/1] getxattr: use correct xattr length
Message-ID: <20180723150021.GA16606@gmail.com>
References: <20180607114348.23667-1-christian@brauner.io>
 <20180607114348.23667-2-christian@brauner.io>
 <20180613154537.GA29950@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613154537.GA29950@mail.hallyn.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:45:37AM -0500, Serge Hallyn wrote:
> On Thu, Jun 07, 2018 at 01:43:48PM +0200, Christian Brauner wrote:
> > When running in a container with a user namespace, if you call getxattr
> > with name = "system.posix_acl_access" and size % 8 != 4, then getxattr
> > silently skips the user namespace fixup that it normally does resulting in
> > un-fixed-up data being returned.
> > This is caused by posix_acl_fix_xattr_to_user() being passed the total
> > buffer size and not the actual size of the xattr as returned by
> > vfs_getxattr().
> > This commit passes the actual length of the xattr as returned by
> > vfs_getxattr() down.
> > 
> > A reproducer for the issue is:
> > 
> >   touch acl_posix
> > 
> >   setfacl -m user:0:rwx acl_posix
> > 
> > and the compile:
> > 
> >   #define _GNU_SOURCE
> >   #include <errno.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <string.h>
> >   #include <sys/types.h>
> >   #include <unistd.h>
> >   #include <attr/xattr.h>
> > 
> >   /* Run in user namespace with nsuid 0 mapped to uid != 0 on the host. */
> >   int main(int argc, void **argv)
> >   {
> >           ssize_t ret1, ret2;
> >           char buf1[128], buf2[132];
> >           int fret = EXIT_SUCCESS;
> >           char *file;
> > 
> >           if (argc < 2) {
> >                   fprintf(stderr,
> >                           "Please specify a file with "
> >                           "\"system.posix_acl_access\" permissions set\n");
> >                   _exit(EXIT_FAILURE);
> >           }
> >           file = argv[1];
> > 
> >           ret1 = getxattr(file, "system.posix_acl_access",
> >                           buf1, sizeof(buf1));
> >           if (ret1 < 0) {
> >                   fprintf(stderr, "%s - Failed to retrieve "
> >                                   "\"system.posix_acl_access\" "
> >                                   "from \"%s\"\n", strerror(errno), file);
> >                   _exit(EXIT_FAILURE);
> >           }
> > 
> >           ret2 = getxattr(file, "system.posix_acl_access",
> >                           buf2, sizeof(buf2));
> >           if (ret2 < 0) {
> >                   fprintf(stderr, "%s - Failed to retrieve "
> >                                   "\"system.posix_acl_access\" "
> >                                   "from \"%s\"\n", strerror(errno), file);
> >                   _exit(EXIT_FAILURE);
> >           }
> > 
> >           if (ret1 != ret2) {
> >                   fprintf(stderr, "The value of \"system.posix_acl_"
> >                                   "access\" for file \"%s\" changed "
> >                                   "between two successive calls\n", file);
> >                   _exit(EXIT_FAILURE);
> >           }
> > 
> >           for (ssize_t i = 0; i < ret2; i++) {
> >                   if (buf1[i] == buf2[i])
> >                           continue;
> > 
> >                   fprintf(stderr,
> >                           "Unexpected different in byte %zd: "
> >                           "%02x != %02x\n", i, buf1[i], buf2[i]);
> >                   fret = EXIT_FAILURE;
> >           }
> > 
> >           if (fret == EXIT_SUCCESS)
> >                   fprintf(stderr, "Test passed\n");
> >           else
> >                   fprintf(stderr, "Test failed\n");
> > 
> >           _exit(fret);
> >   }
> > and run:
> > 
> >   ./tester acl_posix
> > 
> > On a non-fixed up kernel this should return something like:
> > 
> >   root@c1:/# ./t
> >   Unexpected different in byte 16: ffffffa0 != 00
> >   Unexpected different in byte 17: ffffff86 != 00
> >   Unexpected different in byte 18: 01 != 00
> > 
> > and on a fixed kernel:
> > 
> >   root@c1:~# ./t
> >   Test passed
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=199945
> > Reported-by: Colin Watson <cjwatson@ubuntu.com>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> 
> D'oh, sorry, I thought I had replied to this!
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Should this still land as a bugfix in 4.18?

Christian

> 
> thanks,
> Serge
> 
> > ---
> >  fs/xattr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index f9cb1db187b7..1bee74682513 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -539,7 +539,7 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
> >  	if (error > 0) {
> >  		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
> >  		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> > -			posix_acl_fix_xattr_to_user(kvalue, size);
> > +			posix_acl_fix_xattr_to_user(kvalue, error);
> >  		if (size && copy_to_user(value, kvalue, error))
> >  			error = -EFAULT;
> >  	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
> > -- 
> > 2.17.0
