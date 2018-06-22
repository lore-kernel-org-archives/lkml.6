Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D850CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801D243BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3d/3y1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8801D243BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeFVOc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:32:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44856 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:32:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id j26-v6so1213669lfb.11;
        Fri, 22 Jun 2018 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jNwA84yg/BOhiW3xZ9QbhqlEHW7VhpWObpOVS2P7SNw=;
        b=b3d/3y1bp9OFECWIuYFls16dEjXwsLPqEVYJsZ7huwNrMpY74xqxqpqtYgqzfS4Edk
         Vk9otnRpnnmAJQuQlpcXMp6VVxjcP++zm1dv58VdwEAADuGgcXOxRbmitrfxQHgaAJ1o
         0VQbQEHxRPMR+nVOfDKfIo2Su9DN2+7+W1t6X3UofBUa5JGVEiNE0AhnmhQxsboo43lG
         JHXpvQ8Zb25YYieLbcw2mj62uwr0hUbRLOexmaXvQ1gB4FGqmx3tK6FYTjhjDjrdJ/SH
         OH4ZWHfJYndc56PuByjCTtVtLZUYI1LfIfsRhtaData77cqSXnra8jbehX1QEQmn9gN+
         4oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jNwA84yg/BOhiW3xZ9QbhqlEHW7VhpWObpOVS2P7SNw=;
        b=Rdu5KebLUkBN3cW2zxDHTj62ONYtCk+SnfpR9gp1YSgnGzjaOYZ10VCeJ80kna2ZFz
         y0P6/CQibZtrzIsdZ//lsknw/kWgqRdIYnARSgkuWHOCok9eLuugvARcmPx2dEihgDhu
         fHQ+WHAvodcStGtA2zXGSOhHZ8DJDXbETzKvNnXVB+bulU3uZF+jVvZ2X7g2KyLZj0D8
         s0L8G6x5RID4GgtYkTsHTkC+zVK6IrgeoshMb1wzaDIEFFxruRiay/mTeyrdaw2t4Pa6
         UJLZiX2+dB6KHsLWyqg4/bx5rRWMEsTLFX/7/y7iIb3sL9JcL4eoAjSXn/ztACipiMnx
         +o+w==
X-Gm-Message-State: APt69E05xlnQzW78ywgdMz98XEdUmI89Ucw7FXnZW8T9hl2Fh1iwr5U0
        mJPAeGVNbYdAFSgGahEAsvtxtfYljogeZH8gkq8=
X-Google-Smtp-Source: ADUXVKKcnO6TzamSPHsml3Vs2MDhoHJkMHxnusVB31EPWAWHjZBLD0eFrDYr2Z0WDBe+QrcWm4ikZVr84iSIWWfZUcM=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4-v6mr1372074ljj.60.1529677945796;
 Fri, 22 Jun 2018 07:32:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 07:32:25
 -0700 (PDT)
In-Reply-To: <20180620224553.wfz6abuvvz4ul42d@eaf>
References: <20180619160223.4108556-1-arnd@arndb.de> <20180619160223.4108556-3-arnd@arndb.de>
 <20180620224553.wfz6abuvvz4ul42d@eaf>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 16:32:25 +0200
X-Google-Sender-Auth: F7j9Zp69jEDnvj24KsHkljPfgvg
Message-ID: <CAK8P3a1io5zfDwZXV771cw3AzVu-gK4Vs2UAh9U2pQA=dtN_yg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hfsplus: return inode birthtime for statx
To:     =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:45 AM, Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:

>> --- a/fs/hfsplus/inode.c
>> +++ b/fs/hfsplus/inode.c
>> @@ -276,6 +276,19 @@ static int hfsplus_setattr(struct dentry *dentry, s=
truct iattr *attr)
>>       return 0;
>>  }
>>
>> +int hfsplus_getattr(const struct path *path, struct kstat *stat,
>> +                  u32 request_mask, unsigned int query_flags)
>> +{
>> +     struct inode *inode =3D d_backing_inode(path->dentry);
>
> I think d_inode() is better. They work the same, but "normal filesystems
> should not use this", according to the d_backing_inode() documentation.
>

Right, definitely. I copied it from vfs_getattr_nosec() without thinking ab=
out
it much. I see how David Howells put that d_backing_inode() there, but
still don't understand it.

>> @@ -335,6 +348,7 @@ int hfsplus_file_fsync(struct file *file, loff_t sta=
rt, loff_t end,
>>
>>  static const struct inode_operations hfsplus_file_inode_operations =3D =
{
>>       .setattr        =3D hfsplus_setattr,
>> +     .getattr        =3D hfsplus_getattr,
>>       .listxattr      =3D hfsplus_listxattr,
>>  #ifdef CONFIG_HFSPLUS_FS_POSIX_ACL
>>       .get_acl        =3D hfsplus_get_posix_acl,
>> --
>> 2.9.0
>>
>
> What about symlinks and special files?

My mistake again, thanks for pointing that out. Doing the symlinks correctl=
y
here would actually add a bit more complexity as they use the generic
page_symlink_inode_operations at the moment.

I think I'd rather just retract this patch and let someone else handle it i=
f
they actually want this feature. I only added it because it seemed trivial
to do, but that was clearly not true. ;-)

       Arnd
