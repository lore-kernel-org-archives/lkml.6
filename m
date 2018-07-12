Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA7DECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1529208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgP33wwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1529208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbeGLXgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:36:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45862 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbeGLXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:36:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so33399826oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8d+iehrqfZzo2nQIYOX74FvGIE0UjJxmdIcbXuudgs=;
        b=lgP33wwShhyZNqUjhYDsIQ7v8oq4ITPpaf8dgIYVGn08RA8KlD3uaFViQcoouZiaQn
         oQZT7E4dZRhyTOx+zsARuzLgHbV6n4Y6GGvVNBKIEu7BLhxv/OyoGrQ2kC58F9Ucz2Zr
         5sbTzT+IKtsd6WQd99o0HiyzSIoWCG+P84m5Ox1be+zU93/9Czzk5qBfCIIRSjyZdQg/
         A7fJmW41+jIaaIIPAjueeIClBtEA2WgMnRCRH02ISgX2dr3E9kDRxiEXnw1pbwD7XQpu
         Z5QRdrvPZuE6XLIRnH8qzaGXYzaxfkl/CGBTrwBjgGJVo9nUxjFPlAOT/xXBh+MRte0t
         jx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8d+iehrqfZzo2nQIYOX74FvGIE0UjJxmdIcbXuudgs=;
        b=TKdRbdiHFh/J+ncCRejGoCOCN7UEhrEr+ffSnmJ2ByEE/5rxpTE7TQTR9qLBQRPqGz
         UZrHNH+h4fqd36RAFFNulWRMVFTtyBsr3XZNxDcmr2H8PLEj+kzootR77XIA5G3py1WI
         aISqQCTFGqx0pDlFKhwHBm5KhI4TsgKG7tOdLTE338lRjWibyzRlg/IdyXezme1uJgmU
         vK51Bp9pwUXpguPO5L1wVHCKPNaOogdUf3rP0+H60yl/AVEOsFy/m74xSX9YasXpYtwv
         4CFH5TidIiVDkg3YTaEr84rtzXebWhQyXYdR2ZUNAobE/r1fDWYWDo9IRwMwuRCVGLWd
         4MQA==
X-Gm-Message-State: AOUpUlFmvQ9qbBwI438H9GpHnfqC3iSJioe3hdxvw9kuhTEJCDtHY4Az
        txd5J8oxH2Tjr08a7KT2ezgy17pp3Af0Dvy6DaMxRw==
X-Google-Smtp-Source: AAOMgpecoohps09vZjpHwmP95xNzIDSKTJQ8mUEhesOihmOgjUZ0vk9oIV/DGNExBegQMiwmxL0+bCpXIUshtXsk9oc=
X-Received: by 2002:aca:856:: with SMTP id 83-v6mr4303277oii.333.1531437861900;
 Thu, 12 Jul 2018 16:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk>
 <20180712223223.GA28610@thunk.org> <22105.1531436081@warthog.procyon.org.uk>
In-Reply-To: <22105.1531436081@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Jul 2018 16:23:54 -0700
Message-ID: <CAG48ez1OF0OfdmnRsV5Ne2mOt-j3Pgf7QRsn3q3Hzjpus9LHGA@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 3:54 PM David Howells <dhowells@redhat.com> wrote:
>
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> > So maybe the answer is that you open /dev/sda1 and /dev/sda2 and then
> > pass the file descriptors to the fsopen object?  We can require that
> > the fd's be opened with O_RDWR and O_EXCL, which has the benefit where
> > if you have multiple block devices, you know *which* block device had
> > a problem with being grabbed for an exclusive open.
>
> Would that mean then that doing:
>
>         mount /dev/sda3 /a
>         mount /dev/sda3 /b
>
> would then fail on the second command because /dev/sda3 is already open
> exclusively?

Not exactly. mount_bdev() uses FMODE_EXCL, which locks out parallel
usage *with a different filesystem type*. This is the effect:

# strace -e trace=mount mount -t vfat /dev/loop0 mount
mount("/dev/loop0", "/home/jannh/tmp/x/mount", "vfat", MS_MGC_VAL, NULL) = 0
+++ exited with 0 +++
# strace -e trace=mount mount -t ext4 /dev/loop0 mount
mount("/dev/loop0", "/home/jannh/tmp/x/mount", "ext4", MS_MGC_VAL,
NULL) = -1 EBUSY (Device or resource busy)
mount: /home/jannh/tmp/x/mount: /dev/loop0 already mounted on
/home/jannh/tmp/x/mount.
+++ exited with 32 +++

I don't really understand why it's not more strict though...
