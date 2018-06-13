Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8D35DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B592086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B592086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935288AbeFMQm1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:42:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37258 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935132AbeFMQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:42:22 -0400
Received: from mail-wr0-f198.google.com ([209.85.128.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fT8qj-00073i-9y
        for linux-kernel@vger.kernel.org; Wed, 13 Jun 2018 16:42:21 +0000
Received: by mail-wr0-f198.google.com with SMTP id i2-v6so2064777wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfVPwKAUWtkUatg1NFKTpw2wFSlQpw6RhNe4dgDfeps=;
        b=bxc3a5TJ5OwpIAZlZ6ciLC8Gqd8XfPJwxq3bFOq78I8rcJSctDqDkwXbXpFNRJKQK3
         7DmkU/VrUavJ58sqjE6DPLQu7zmzU3xN8PdatuiNHes0ZjfXiElLdNPAoB0ILeqjHoQM
         xqpNi5KsDGdbcpE1gG5kRo5k/9B1nuyxl+SCV7bm9psG6hqmbEEKvzGFfUsg8ZxebXMC
         JP9RstFR0RMlw3b2KzoG/WD0nS+j4S1BIqcBvi8+eSUpA0TWU1DpP5BMHvooLWqd/nfB
         r91bM9MW4OFy5uXn+kujPBWucwJrBgvIG/OrvRGJkZRvSHy3H+5rSO4Gx0hspbNzYxxb
         SQjA==
X-Gm-Message-State: APt69E0CFA44MhxPSZPdhHq9ey9edV0Vt9UjJx1JD7AtlFdRF5Ipt+88
        cLsaRE7IUBJKwWbkGeTxMwiJoUYkwj7H8YSYmYgKQlMxav0ulkXEf3wMi9XLkLt9P07o9Kpuptp
        mYCB2ipNJre99ceAK/pFSeoblrmfrX5ws2uRQgMDGIQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6-v6mr4639887wro.264.1528908140943;
        Wed, 13 Jun 2018 09:42:20 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKLxQ5Ivl+xnJTJt9eFmYLNGM721SdwVwzjLoJq2wOrL0ee+Phw+Q+xskAJE+qH1J22oRVdGMQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6-v6mr4639870wro.264.1528908140523;
        Wed, 13 Jun 2018 09:42:20 -0700 (PDT)
Received: from gmail.com (eap108100.extern.uni-tuebingen.de. [134.2.108.100])
        by smtp.gmail.com with ESMTPSA id t10-v6sm2969205wrq.74.2018.06.13.09.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:42:20 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Wed, 13 Jun 2018 18:42:19 +0200
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cjwatson@ubuntu.com, ebiederm@xmission.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/1] getxattr: use correct xattr length
Message-ID: <20180613164218.GA4481@gmail.com>
References: <20180607114348.23667-1-christian@brauner.io>
 <20180607114348.23667-2-christian@brauner.io>
 <20180613154537.GA29950@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613154537.GA29950@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

No problem at all. :)

Thanks!
Christian

> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
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
