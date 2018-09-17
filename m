Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F14D214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F14D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeIQThP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:37:15 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:51200 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeIQThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:15 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 15:37:14 EDT
Received: from fanir.tuyoix.net ([68.150.218.192])
        by shaw.ca with ESMTP
        id 1u5lgBf4i5Hxq1u5mgwm6i; Mon, 17 Sep 2018 08:01:36 -0600
X-Authority-Analysis: v=2.3 cv=BMcHU2YG c=1 sm=1 tr=0
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=JBFolyDoGHsA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=ourswZ7O5i2RYhpjJKcA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.15.2/8.15.2) with ESMTPSA id w8HE1UIu026201
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 17 Sep 2018 08:01:30 -0600
Date:   Mon, 17 Sep 2018 08:01:30 -0600 (Mountain Daylight Time)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: sysfs: Do not return POSIX ACL xattrs via listxattr()
In-Reply-To: <alpine.WNT.2.20.1809101709260.3100@CLUIJ>
Message-ID: <alpine.WNT.2.20.1809170801030.4228@CLUIJ>
References: <alpine.LNX.2.20.1809091544070.15534@fanir.tuyoix.net> <CAHpGcMJ9jB+Ekfvf6HUvWUr8ipoSJkS+U5arShpMwyjuc4qftg@mail.gmail.com> <alpine.WNT.2.20.1809101709260.3100@CLUIJ>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="230644-14400-1537192892=:4228"
X-CMAE-Envelope: MS4wfHGXgeHqqRRNhnkL8k25M0vy3NoUb1lrlM6QBddBm30KfAIrx1WHN+P/HniF0NyQFIlL5GZloqt4ssbDYWmkqJ0NWAGBwq40vhcVOtU3wU3NQfonh3G4
 sLzYBGxFxktDJT/esgOwlo5diqvGm1n3MDdpRZNmxVql5z5uHffz0KS8wBgwab0xq79G26VWeldAQ4Hfr5fbKXxCjo6Rkx7GymBQQKABarZR01lvd6WPZIEC
 cbiW6MRBOCXZDM7PPpWxjFTpVc6NyehKTl0fJK7H0HW+AYbi4k3mVfWp9eiO+0fxM5p2W45pYKD3s0jQVAleZiu2uclqL5Cnj07kYt+KJOyNQP7QXBpuaRg3
 ovImjL8cqUOz+yjD0KSMtlIIPmx81lSl33KyG+ukZ6v2VaN4wO0JBfeyt4Lo6E5VPNl86sZ6unNgnXfoZh9Q23xVZs/Xzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--230644-14400-1537192892=:4228
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Sep 2018, Marc Aurèle La France wrote:
> On Mon, 10 Sep 2018, Andreas Grünbacher wrote:
>> Am Mo., 10. Sep. 2018 schrieb Marc Aurèle La France:

>>> Commit 786534b92f3ce68f4afc8a761c80b76887797b0a "tmpfs: listxattr
>>> should include POSIX ACL xattrs", which first appeared in 4.5 kernels,
>>> introduced a regression whereby listxattr() syscalls on anything in
>>> sysfs, or its mountpoint, return the name of the two POSIX ACL xattrs,
>>> but attempts to retrieve these values are denied with EOPNOTSUP.  For
>>> example ...

>>>         # getfattr -d --match=- /sys
>>>         /sys: system.posix_acl_access: Operation not supported
>>>         /sys: system.posix_acl_default: Operation not supported
>>>         #

>> I can confirm this regression.

>>> This inconsistent behaviour confuses rsync(1) (among others) when it
>>> runs into a sysfs mountpoint, even when told to not descend into it.
>>> This issue occurs because simple_xattr_list() does not correctly deal
>>> with cached ACLs.

>>> The suggested fix below was developed with a 4.18.7 kernel, but should
>>> apply, modulo patch fuzz, to any kernel >= 4.7.  A fix for 4.5 <=
>>> kernels < 4.7 is trivially different, but I won't bother given such
>>> kernels are no longer maintained.

>>> Note that the only other simple_xattr_list() caller, shmem, avoids
>>> this glitch by previously calling cache_no_acl() on all inodes it
>>> creates, so perhaps sysfs/kernfs should do the same.

>>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

>>> --- a/fs/xattr.c
>>> +++ b/fs/xattr.c
>>> @@ -949,13 +949,13 @@ ssize_t simple_xattr_list(struct inode *inode,
>>>         int err = 0;
>>>
>>>  #ifdef CONFIG_FS_POSIX_ACL
>>> -       if (inode->i_acl) {
>>> +       if (inode->i_acl && !is_uncached_acl(inode->i_acl)) {
>>>                 err = xattr_list_one(&buffer, &remaining_size,
>>>                                      XATTR_NAME_POSIX_ACL_ACCESS);
>>>                 if (err)
>>>                         return err;
>>>         }
>>> -       if (inode->i_default_acl) {
>>> +       if (inode->i_default_acl && 
>>> !is_uncached_acl(inode->i_default_acl)) {
>>>                 err = xattr_list_one(&buffer, &remaining_size,
>>>                                      XATTR_NAME_POSIX_ACL_DEFAULT);
>>>                 if (err)

>> This seems to be a better fix, but I haven't fully verified it, yet:

>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -187,7 +187,8 @@ int inode_init_always(struct super_block *sb, struct
>>     inode->i_mapping = mapping;
>>     INIT_HLIST_HEAD(&inode->i_dentry);    /* buggered by rcu freeing */
>>  #ifdef CONFIG_FS_POSIX_ACL
>> -    inode->i_acl = inode->i_default_acl = ACL_NOT_CACHED;
>> +    inode->i_acl = inode->i_default_acl =
>> +           (sb->s_flags & SB_POSIXACL) ? ACL_NOT_CACHED : NULL;
>>  #endif
>>
>>  #ifdef CONFIG_FSNOTIFY

> Yes, that works too, and doesn't seem to cause other issues.

> Tested-by: Marc Aurèle La France <tsi@tuyoix.net>

Anything more on this?

Thanks and have a great day.

Marc.
--230644-14400-1537192892=:4228--
