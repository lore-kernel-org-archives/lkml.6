Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D7C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D869920658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeIKEMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:12:35 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:41944 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeIKEMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:12:35 -0400
Received: from fanir.tuyoix.net ([68.150.218.192])
        by shaw.ca with ESMTP
        id zVPgf2j06WppDzVPhfXtbr; Mon, 10 Sep 2018 17:16:14 -0600
X-Authority-Analysis: v=2.3 cv=YIcrNiOx c=1 sm=1 tr=0
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=JBFolyDoGHsA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=kPGX45PSJw8SEvEpmYoA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.15.2/8.15.2) with ESMTPSA id w8ANG8ER009738
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 10 Sep 2018 17:16:09 -0600
Date:   Mon, 10 Sep 2018 17:16:08 -0600 (Mountain Daylight Time)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: sysfs: Do not return POSIX ACL xattrs via listxattr()
In-Reply-To: <CAHpGcMJ9jB+Ekfvf6HUvWUr8ipoSJkS+U5arShpMwyjuc4qftg@mail.gmail.com>
Message-ID: <alpine.WNT.2.20.1809101709260.3100@CLUIJ>
References: <alpine.LNX.2.20.1809091544070.15534@fanir.tuyoix.net> <CAHpGcMJ9jB+Ekfvf6HUvWUr8ipoSJkS+U5arShpMwyjuc4qftg@mail.gmail.com>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="476518-19365-1536621371=:3100"
X-CMAE-Envelope: MS4wfCkjyAiXT5uFA36J9YOKi46bx4Eql/D5pmL2b8Vg+/BjzcGJeLJoQ4L7qyV9II1XBjj8fw951bSHBkcp6nolPJvv4PGWZqoVaDxUtGyjEY/v6keLgQcE
 2REnGb1DVJgBlIii/y+6G3Vp78JYL+p8V6xRURfMjREexyoYYwulQ2ctGuq0lWDhLq0NVSXCvxhudwQVyZ6GN0TnTRR9iMGYGejX/854bB47pnnM1S03GHo6
 /cH6wk3t8g8cozRzBtFCdvYz6NA5JTg1ANxVGpA8PTNLGakTuE62m5+b12UkwwV4NUpdjPQ8xsMjdCmnxbPJq3W21pc1VRbKI+s5sC+T6IK1oEHWsVyGLgDN
 Cwe7ro/BWRk3jV8NkhumC+KtOlfSAnxtaKGFRb4fqP9bGvXH0e2Jug4/eemnLRrd9CEgO1ufqGQrtb1whimX8G5+bhQtCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--476518-19365-1536621371=:3100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Sep 2018, Andreas Grünbacher wrote:
> Am Mo., 10. Sep. 2018 schrieb Marc Aurèle La France:

>> Commit 786534b92f3ce68f4afc8a761c80b76887797b0a "tmpfs: listxattr
>> should include POSIX ACL xattrs", which first appeared in 4.5 kernels,
>> introduced a regression whereby listxattr() syscalls on anything in
>> sysfs, or its mountpoint, return the name of the two POSIX ACL xattrs,
>> but attempts to retrieve these values are denied with EOPNOTSUP.  For
>> example ...

>>         # getfattr -d --match=- /sys
>>         /sys: system.posix_acl_access: Operation not supported
>>         /sys: system.posix_acl_default: Operation not supported
>>         #

> I can confirm this regression.

>> This inconsistent behaviour confuses rsync(1) (among others) when it
>> runs into a sysfs mountpoint, even when told to not descend into it.
>> This issue occurs because simple_xattr_list() does not correctly deal
>> with cached ACLs.

>> The suggested fix below was developed with a 4.18.7 kernel, but should
>> apply, modulo patch fuzz, to any kernel >= 4.7.  A fix for 4.5 <=
>> kernels < 4.7 is trivially different, but I won't bother given such
>> kernels are no longer maintained.

>> Note that the only other simple_xattr_list() caller, shmem, avoids
>> this glitch by previously calling cache_no_acl() on all inodes it
>> creates, so perhaps sysfs/kernfs should do the same.

>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
>> @@ -949,13 +949,13 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>>         int err = 0;
>>
>>  #ifdef CONFIG_FS_POSIX_ACL
>> -       if (inode->i_acl) {
>> +       if (inode->i_acl && !is_uncached_acl(inode->i_acl)) {
>>                 err = xattr_list_one(&buffer, &remaining_size,
>>                                      XATTR_NAME_POSIX_ACL_ACCESS);
>>                 if (err)
>>                         return err;
>>         }
>> -       if (inode->i_default_acl) {
>> +       if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl)) {
>>                 err = xattr_list_one(&buffer, &remaining_size,
>>                                      XATTR_NAME_POSIX_ACL_DEFAULT);
>>                 if (err)

> This seems to be a better fix, but I haven't fully verified it, yet:

> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -187,7 +187,8 @@ int inode_init_always(struct super_block *sb, struct
>     inode->i_mapping = mapping;
>     INIT_HLIST_HEAD(&inode->i_dentry);    /* buggered by rcu freeing */
>  #ifdef CONFIG_FS_POSIX_ACL
> -    inode->i_acl = inode->i_default_acl = ACL_NOT_CACHED;
> +    inode->i_acl = inode->i_default_acl =
> +           (sb->s_flags & SB_POSIXACL) ? ACL_NOT_CACHED : NULL;
>  #endif
>
>  #ifdef CONFIG_FSNOTIFY

Yes, that works too, and doesn't seem to cause other issues.

Tested-by: Marc Aurèle La France <tsi@tuyoix.net>

Thanks.

Marc.
--476518-19365-1536621371=:3100--
