Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CEC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F13B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFq1il8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967209AbeFSTmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:42:51 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36746 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966263AbeFSTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:42:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so1311699lfh.3;
        Tue, 19 Jun 2018 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Yg415wMTAMHc6tVHBIxK2hniZ2FBxAJTKl42lUlTwMg=;
        b=PFq1il8z7JLyt8NvkK9KM3oDKT1MGZdlnwwEQqt3lCdwR0e+YIfq6agZXg/x7u5hmn
         6ZcjqRYDFb3fwrqSeCxQK+D+bxzctchK8MIOpKKDx1Nd/22pj3+b1KMJSNwR38+Fykas
         NF+EPF/WyzpZD0RZdckj3Olr8DIm/PZMoffbfNWPW8jwBrEpk0hdRHgwG1BqgasSDwU2
         AZ4lV7t7lnrUybhUyeULqVcUZQhtEe7wF5ujHhgnzaKsOOC1lCPu6BKO7etHPdU82xFU
         TNN4faIA2a9X2mw5fC9qRiU3JudSGN5JZL7pmsf6+vGskeZ7lXF0ups5yD5hJcNzztIk
         vSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Yg415wMTAMHc6tVHBIxK2hniZ2FBxAJTKl42lUlTwMg=;
        b=dOHZ2nLUmcp1qqKFRMNmObWWuZ65zrmWbEjBY5AS08C7lS4Zy3kSOIuwJih+PSbUVF
         /nS/WtmfnS17ywmhaL6qXfkaxFgC4wteLTfFpNsD2jFaiwjNd6zN9CsPjebHJsu08FdB
         BBgH/daiosLhOMaEwJAbabU2AKyJ7fLIKTwnWmy+cP9MSot9tu0V51t/SvPhGv99tGTI
         jxWfLL7EfYsSmFD48h2Ha5gndHiQvtBvsrtJmdiqG7/v3hGNfu3TA/sORjGCKk49Y7NA
         GGPDz3GasjoJ/NDVLLIDik4e6RjyV6fS/f5IrGxeQgF8t0cGumyVVgaGeZhweMnTlqnm
         E0rg==
X-Gm-Message-State: APt69E1/tZ7PdAX4jlXKt+0WnjKEofxEvMpLIUOxGAIXg/aPujjlVPPU
        HgZPmD0IpxkYzY/nh2x5cwCtOgHCPWFskhqWE1M=
X-Google-Smtp-Source: ADUXVKJXCbykTnZILAGKw70pPsea5C53lcsv+h76QNgwME24i+po7PPi6lFU0GvuWJUZP7MWpusqp9iwtPGutSl6Jq0=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr11902334ljg.22.1529437367940;
 Tue, 19 Jun 2018 12:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:42:45
 -0700 (PDT)
In-Reply-To: <1529427809.2624.16.camel@dubeyko.com>
References: <20180619160223.4108556-1-arnd@arndb.de> <1529427809.2624.16.camel@dubeyko.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 21:42:45 +0200
X-Google-Sender-Auth: rucAb8sKBzLK7wvJOyNopx5-yug
Message-ID: <CAK8P3a0WNPxDqSNJUuijY0P9UwGXPD_DCAUw9AH_OvAg-cPf1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] hfs: stop using timespec based interfaces
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:03 PM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> On Tue, 2018-06-19 at 18:02 +0200, Arnd Bergmann wrote:
>> The native HFS timestamps overflow in year 2040, two years after the
>> Unix
>> y2038 overflow. However, the way that the conversion between on-disk
>> timestamps and in-kernel timestamps was implemented, 64-bit machines
>> actually ended up converting negative UTC timestamps (1902 through
>> 1969)
>> into times between 2038 and 2106.
>>
>> Rather than making all machines faithfully represent timestamps in
>> the
>> ancient past but break after 2040, this changes the file system to
>> always use the unsigned UTC interpretation, reading back times
>> between
>> 1970 and 2106.
>>
>
> The trouble with HFS and HFS+ that the specification [1] declares this:
>
> "HFS Plus stores dates in several data structures, including the volume
> header and catalog records. These dates are stored in unsigned 32-bit
> integers (UInt32) containing the number of seconds since midnight,
> January 1, 1904, GMT. This is slightly different from HFS, where the
> value represents local time. The maximum representable date is February
> 6, 2040 at 06:28:15 GMT."
>
> So, I am not sure that we are able to support later dates because such
> timestamps cannot be stored on HFS/HFS+ volumes and will be
> incompatible with Mac OS X.

We never followed that interpretation in Linux though. As I wrote,
on 64-bit machines, these two calculations (hfs and hfs+,
respectively)

#define __hfs_m_to_utime(sec)   (be32_to_cpu(sec) - 2082844800U  +
sys_tz.tz_minuteswest * 60)
#define __hfsp_mt2ut(t)                (be32_to_cpu(t) - 2082844800U)

just wrap around when reading the timestamps before 1970 from
disk. On 32-bit machines they get wrapped another time when
we assign them to a signed 32-bit time_t.

> Also, I am not sure that anybody will use HFS/HFS+ after 2040.

I'm trying to fix all file systems to be unambiguous regarding
inode timestamps. This means it should behave the same way
on 32-bit and 64-bit kernels, and if possible in a sane way.

Even if you don't care about running HFS in the future, you
can trivially create files with arbitrary timestamps, just try

touch -d "Jan 1 1901" 1901
touch -d "Jan 1 1905" 1905
touch -d "Jan 1 1969" 1969
touch -d "Jan 1 2038" 2038
touch -d "Jan 1 2040" 2040
touch -d "Jan 1 2106" 2106
touch -d "Jan 1 2107" 2107

on HFS and do an 'ls -l' after an unmount/remount.

If you think it's important that we change the current behavior
to be compatible with MacOS and represent the 1904..2040
time range rather than 1970..2106, we can definitely do that
as well, using this patch:

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ff432931a5b1..2c7366342656 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -249,7 +249,7 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
  * actually works until year 2106
  */
 #define __hfs_u_to_mtime(sec)  cpu_to_be32(sec + 2082844800U -
sys_tz.tz_minuteswest * 60)
-#define __hfs_m_to_utime(sec)  (be32_to_cpu(sec) - 2082844800U  +
sys_tz.tz_minuteswest * 60)
+#define __hfs_m_to_utime(sec)  ((time64_t)be32_to_cpu(sec) -
2082844800U  + sys_tz.tz_minuteswest * 60)

 #define HFS_I(inode)   (container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)     ((struct hfs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1a6b469f8d22..4eaee8bdfcb2 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -534,7 +534,7 @@ int hfsplus_read_wrapper(struct super_block *sb);

 /* time macros: convert between 1904-2040 and 1970-2106 range,
  * pre-1970 timestamps are interpreted as post-2038 times after wrap-around */
-#define __hfsp_mt2ut(t)                (be32_to_cpu(t) - 2082844800U)
+#define __hfsp_mt2ut(t)                ((time64_t)be32_to_cpu(t) - 2082844800U)
 #define __hfsp_ut2mt(t)                (cpu_to_be32(t + 2082844800U))

 /* compatibility */

I can submit that separately so that it can get backported into
stable kernels if you like, with the type changes as a follow-up
on top.

    Arnd
