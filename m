Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FDE264C1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vatiFVbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FDE264C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934823AbeFZDyx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:54:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34437 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755745AbeFZDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:54:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id y1-v6so1417712pgv.1;
        Mon, 25 Jun 2018 20:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDOq0Bx/Tbtrv5bJrUJZ9B5jCboi95jhaMovMrQCRfI=;
        b=vatiFVbom3iGs/rNbMsiRMVYFCUU62hgKR0y81uSLTJavcTCGYmU0m4wBzKTP3xxa5
         /+3dkh4IadQuHIHZh/tDV77olHKBZLNfJXUcu/D50lGrAR+/6wSFsBhJniC+MuGoRHsl
         JKnJu0dlTtuDA3+ryRS4xZGDgcFiSxMPLlxIcO+s2VUI/DODi2pNVfmI37Mw+nNwjy9S
         leVUnu+v8qO1tzPvJ2pVqCS/kvTJVLXu81l43R2pd1b7OJXCd/2t97lPbBU5n2MIauI7
         +dbofw0e2AhJCwSTNg8cfVWb4N11pslyZqHyj0TdRNeBGcGzo22BKMjv/VAZdSgv9dmM
         Chdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDOq0Bx/Tbtrv5bJrUJZ9B5jCboi95jhaMovMrQCRfI=;
        b=Bn2yJvslwmu81LKCMpLGeWBxd5K6mHQVpcSvuPOL4cqGmHa6QmfuCv5FFpclaouEBJ
         8Kw9xqlATzRpONLTFxL92fLKteFo5zD9+nSu7shN7IiamhhonILR4acNfDM1lVbRMTIB
         1TPd0uENiowksWf+4Wr1M+n+qhVyDdMTXpLf9AZvryqCUr+0Co+gX/TQiLPsJ0nJ0ThL
         00Yzu2eCl3RhqDQkWLlLZ2yQ6Yupg2lQJZgThBPGe7Viv1fpVbWZ17Vb5TbrwsCzoU8E
         11A5h8gLkcc3qpDI/TOP48MQqjtf0gFMeKQ7MsXU/42Xp1BajaLwVGwstW2h6LoAIh4u
         AbMg==
X-Gm-Message-State: APt69E0uhEp2hKvEU2oQqXr79jhT2jOuSeuxY7Vu0Hg6qMt9F2sTM9MO
        VXqMN4Y87EZEgdByfjJGLkadNciuuo0UgP2uFkDczg==
X-Google-Smtp-Source: ADUXVKJs7Hbm1sVPLl9MhG2gocN4QHBcUPCUXLQdbNQyCsql4luvVApngQUBq+bOEScVQooPOHO8ogQJ/Ft/hYoiqkY=
X-Received: by 2002:a62:2c46:: with SMTP id s67-v6mr901442pfs.153.1529985290827;
 Mon, 25 Jun 2018 20:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <77967693-040b-734a-8e18-be95d97478b3@redhat.com>
In-Reply-To: <77967693-040b-734a-8e18-be95d97478b3@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 25 Jun 2018 22:54:40 -0500
Message-ID: <CAH2r5muV49o7aTco1757UwuW-c6Fn5r=EW3QMCMfU7FFLZNMTw@mail.gmail.com>
Subject: Re: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
To:     labbott@redhat.com
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are taking a look at this - Ronnie had some ideas.  Probably simply
not implemented - hopefully not too hard to fix.
On Mon, Jun 25, 2018 at 6:58 PM Laura Abbott <labbott@redhat.com> wrote:
>
> Hi,
>
> A while back, someone reported a failure on Fedora when trying to boot
> a QEMU image off of a CIFS share. The issue was reduced down to a
> test case (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c8)
>
> # cat test-ofd-lock.c
> #define _GNU_SOURCE
> #include <errno.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
>
> int main(int argc, char **argv)
> {
>      int ret;
>      int fd;
>      struct flock fl = {
>          .l_whence = SEEK_SET,
>          .l_start  = 0,
>          .l_len    = 0,
>          .l_type   = F_RDLCK,
>      };
>      if (argc < 2) {
>              fprintf(stderr, "Usage: %s <file>\n", argv[0]);
>              return 1;
>      }
>      fd = open(argv[1], O_RDWR);
>      if (fd < 0) {
>              perror("open");
>              return errno;
>      }
>      ret = fcntl(fd, F_OFD_SETLK, &fl);
>      if (ret) {
>              perror("setlk");
>              return errno;
>      }
>      fl.l_type = F_WRLCK;
>      ret = fcntl(fd, F_OFD_GETLK, &fl);
>      if (ret) {
>              perror("getlk");
>              return errno;
>      }
>      if (fl.l_type != F_UNLCK) {
>              fprintf(stderr, "get lock test failed\n");
>              return 1;
>      }
>      return 0;
> }
> [root@localhost ~]# make test-ofd-lock
> cc     test-ofd-lock.c   -o test-ofd-lock
> [root@localhost ~]# touch /tmp/test && ./test-ofd-lock /tmp/test
> [root@localhost ~]# echo $?
> 0
> [root@localhost ~]# touch /mnt/test && ./test-ofd-lock /mnt/test
> get lock test failed
> [root@localhost ~]# mount | grep /mnt
> //192.168.31.1/tddownload on /mnt type cifs (rw,relatime,vers=3.0,
> cache=strict,username=admin,domain=,uid=0,
> noforceuid,gid=0,noforcegid,addr=192.168.31.1,file_mode=0755,
> dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,
> wsize=1048576,echo_interval=60,actimeo=1,user=admin)
>
>
> As explained by one of the QEMU developers
> (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c37)
>
> '''
> It is a kernel bug. The code snippet in comment 8 shows clearly that the kernel
> is doing the wrong thing, which cannot be fixed/worked around by QEMU.
>
> In man 2 fcntl:
>
>         F_OFD_GETLK (struct flock *)
>                On input to this call, lock describes an open file description lock
> we would like to place on the file.  If the lock could  be  placed,  fcntl()  does  not
>                actually  place  it,  but  returns F_UNLCK in the l_type field of lock
> and leaves the other fields of the structure unchanged.  If one or more incompatible
>                locks would prevent this lock being placed, then details about one of
> these locks are returned via lock, as described above for F_GETLK.
>
> which is not the case with the new CIFS behaviour.
> ''
>
> You can read the full context at https://bugzilla.redhat.com/show_bug.cgi?id=1484130
>
> Any suggestions?
>
> Thanks,
> Laura
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
