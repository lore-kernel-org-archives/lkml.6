Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740BA21354
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740BA21354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeFZMrk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:47:40 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:35954 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbeFZMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:47:39 -0400
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 26 Jun 2018 12:47:27 +0000
X-IronPort-AV: E=Sophos;i="5.51,274,1526342400"; 
   d="scan'208";a="13202915"
IronPort-PHdr: =?us-ascii?q?9a23=3AwRSd7BxAyNMrlyfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoUI/ad9pjvdHbS+e9qxAeQG9mDtrQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYwhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqP1gbT6u9DIUAvi6XUN4QtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DBkLj7e7?=
 =?us-ascii?q?Z97U5cxRE8zdBY4JJUBbUBL+zpVkDts9zYCwczMxaozOb/FNV9yoQeVHqXAq?=
 =?us-ascii?q?CDLaPStUSF5vo1LOmRYI8ZoTP9K/8i5/70k3A1g0MSfa6s3ZEPcnC3AuxmI1?=
 =?us-ascii?q?mFYXrrmtoOD38KsRAkTOzrk12PSiZTaGyoX6I9/TE7EIamAp3fSY+zmrCB2z?=
 =?us-ascii?q?27HpJObGBcFl+MCWvod5mDW/oUcyKdPNNukiEeVbigV48g1QqjtAzkxLp9KO?=
 =?us-ascii?q?rb5CkYuYjk1Nhv6O3ZjQsy+iBsD8SBz2GNSHl5nmcJRz8wwaB+rlVxylSd3q?=
 =?us-ascii?q?hihfxXC9hT6uhXUgc1K5Hc1fZ2C9PsVQLbeNeGVlKmTs+hATErQdJii+MJNm?=
 =?us-ascii?q?R0HdPqrhfZ2WL+AbYTkbyjC5sz/abRmXP2IpAu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGgvB?=
 =?us-ascii?q?vP?=
X-IPAS-Result: =?us-ascii?q?A2ArAQDwNDJb/wHyM5BUCBkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QGDHwsBAQEBAYFvEiiDeYhkjDMGgQgqlRWBJANThHcCgzQ2FgECAQEBAQEBA?=
 =?us-ascii?q?gFsKII1JAGCXAEBAQECASMEUhALGAICJgICVwYNBgIBAYJfQoFzBQisa4FpM?=
 =?us-ascii?q?4Rbg2yBGoELiHCBB4EPJ4JohDQhgyaCVQKHXIRrO4wvCY8OBo1KkzkIKTOBH?=
 =?us-ascii?q?ysIAhgIIQ+DJJBtIzCNSII5AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Jun 2018 12:47:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5QClQv0009325;
        Tue, 26 Jun 2018 08:47:26 -0400
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked
 regions
To:     Jann Horn <jannh@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, kernel list <linux-kernel@vger.kernel.org>
References: <20180625163425.216965-1-jannh@google.com>
 <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAG48ez1oRA7ysqWXnNX3eGMm4P=dtakmVGuQamUrEz9i_9nvEg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9cfad0c4-bd08-f032-c7a5-92665545bd0a@tycho.nsa.gov>
Date:   Tue, 26 Jun 2018 08:48:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1oRA7ysqWXnNX3eGMm4P=dtakmVGuQamUrEz9i_9nvEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 08:42 AM, Jann Horn wrote:
> On Tue, Jun 26, 2018 at 2:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 06/25/2018 12:34 PM, Jann Horn wrote:
>>> If a user is accessing a file in selinuxfs with a pointer to a userspace
>>> buffer that is backed by e.g. a userfaultfd, the userspace access can
>>> stall indefinitely, which can block fsi->mutex if it is held.
>>>
>>> For sel_read_policy(), remove the locking, since this method doesn't seem
>>> to access anything that requires locking.
>>>
>>> For sel_read_bool(), move the user access below the locked region.
>>>
>>> For sel_write_bool() and sel_commit_bools_write(), move the user access
>>> up above the locked region.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>
>> Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
>> do we need it to be back-ported any further than the commit which introduced it.
> 
> You can also use FUSE, if the system is configured appropriately:
> Mount a FUSE filesystem, mmap() a file from it, then pass a pointer to
> the mmapped region to a syscall. AFAICS FUSE was added to the kernel
> in commit d8a5ba45457e4a22aa39c939121efd7bb6c76672, first in
> v2.6.16.28.

Ok, then I guess it would be splitting hairs to not just take it all the way back.

> 
>> Otherwise, you can add my
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> This patch should go through Paul Moore's tree, right?

Yes, thanks.

> 
>>> ---
>>>  security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
>>>  1 file changed, 33 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>>> index f3d374d2ca04..065f8cea84e3 100644
>>> --- a/security/selinux/selinuxfs.c
>>> +++ b/security/selinux/selinuxfs.c
>>> @@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
>>>       struct policy_load_memory *plm = filp->private_data;
>>>       int ret;
>>>
>>> -     mutex_lock(&fsi->mutex);
>>> -
>>>       ret = avc_has_perm(&selinux_state,
>>>                          current_sid(), SECINITSID_SECURITY,
>>>                         SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
>>>       if (ret)
>>> -             goto out;
>>> +             return ret;
>>>
>>> -     ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
>>> -out:
>>> -     mutex_unlock(&fsi->mutex);
>>> -     return ret;
>>> +     return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
>>>  }
>>>
>>>  static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
>>> @@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>>>       ret = -EINVAL;
>>>       if (index >= fsi->bool_num || strcmp(name,
>>>                                            fsi->bool_pending_names[index]))
>>> -             goto out;
>>> +             goto out_unlock;
>>>
>>>       ret = -ENOMEM;
>>>       page = (char *)get_zeroed_page(GFP_KERNEL);
>>>       if (!page)
>>> -             goto out;
>>> +             goto out_unlock;
>>>
>>>       cur_enforcing = security_get_bool_value(fsi->state, index);
>>>       if (cur_enforcing < 0) {
>>>               ret = cur_enforcing;
>>> -             goto out;
>>> +             goto out_unlock;
>>>       }
>>>       length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
>>>                         fsi->bool_pending_values[index]);
>>> -     ret = simple_read_from_buffer(buf, count, ppos, page, length);
>>> -out:
>>>       mutex_unlock(&fsi->mutex);
>>> +     ret = simple_read_from_buffer(buf, count, ppos, page, length);
>>> +out_free:
>>>       free_page((unsigned long)page);
>>>       return ret;
>>> +
>>> +out_unlock:
>>> +     mutex_unlock(&fsi->mutex);
>>> +     goto out_free;
>>>  }
>>>
>>>  static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>>> @@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>>>       unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
>>>       const char *name = filep->f_path.dentry->d_name.name;
>>>
>>> +     if (count >= PAGE_SIZE)
>>> +             return -ENOMEM;
>>> +
>>> +     /* No partial writes. */
>>> +     if (*ppos != 0)
>>> +             return -EINVAL;
>>> +
>>> +     page = memdup_user_nul(buf, count);
>>> +     if (IS_ERR(page))
>>> +             return PTR_ERR(page);
>>> +
>>>       mutex_lock(&fsi->mutex);
>>>
>>>       length = avc_has_perm(&selinux_state,
>>> @@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>>>                                            fsi->bool_pending_names[index]))
>>>               goto out;
>>>
>>> -     length = -ENOMEM;
>>> -     if (count >= PAGE_SIZE)
>>> -             goto out;
>>> -
>>> -     /* No partial writes. */
>>> -     length = -EINVAL;
>>> -     if (*ppos != 0)
>>> -             goto out;
>>> -
>>> -     page = memdup_user_nul(buf, count);
>>> -     if (IS_ERR(page)) {
>>> -             length = PTR_ERR(page);
>>> -             page = NULL;
>>> -             goto out;
>>> -     }
>>> -
>>>       length = -EINVAL;
>>>       if (sscanf(page, "%d", &new_value) != 1)
>>>               goto out;
>>> @@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>>>       ssize_t length;
>>>       int new_value;
>>>
>>> +     if (count >= PAGE_SIZE)
>>> +             return -ENOMEM;
>>> +
>>> +     /* No partial writes. */
>>> +     if (*ppos != 0)
>>> +             return -EINVAL;
>>> +
>>> +     page = memdup_user_nul(buf, count);
>>> +     if (IS_ERR(page))
>>> +             return PTR_ERR(page);
>>> +
>>>       mutex_lock(&fsi->mutex);
>>>
>>>       length = avc_has_perm(&selinux_state,
>>> @@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>>>       if (length)
>>>               goto out;
>>>
>>> -     length = -ENOMEM;
>>> -     if (count >= PAGE_SIZE)
>>> -             goto out;
>>> -
>>> -     /* No partial writes. */
>>> -     length = -EINVAL;
>>> -     if (*ppos != 0)
>>> -             goto out;
>>> -
>>> -     page = memdup_user_nul(buf, count);
>>> -     if (IS_ERR(page)) {
>>> -             length = PTR_ERR(page);
>>> -             page = NULL;
>>> -             goto out;
>>> -     }
>>> -
>>>       length = -EINVAL;
>>>       if (sscanf(page, "%d", &new_value) != 1)
>>>               goto out;
>>>
>>

