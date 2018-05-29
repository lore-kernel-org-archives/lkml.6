Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2099817-1527598531-2-11176543516550391566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527598531; b=RVw2UKcut9xUUiXABqAEzNdiDHNZfKWKhiCQd0o3XFl6oAUrEj
    LSfELCKQ5Uh7bUmDdcVhCiZ2Yjmtt1bVBNk/RCIpwWmBbf6IwG9dqZ/sXUWomnXt
    2z2kqQFWvO2yIlHCIdRiVoP+34iYWJEzWf2xrb4IbZdWa9tQ3Si0Rix+AZJHnODk
    QH8lOcZkg7iiflNLmKMnQjZAcTWlX7qLLwGk+N6YH6x7B3RhwMNbm/vjW70Sokef
    gN6F9Zc2hkqP87+zpvH23G8FhGq9eBdBYHohFYmLvTe14vNkj6+gG2Kw2mGidRrI
    fjRuzPY8DdOx1e+7oHPa352kDqT7pfir70ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527598531; bh=CJ9A7wwRn/soQIYJNZjiGGgvO6ixXUyEOI79kqTHTm
    M=; b=TFtodwg3NmHtVobbliW5S/FqVXT7IatyHMCeGN9KYKUVSYPPCYghAnPjjp
    pOYx9wJrwJfwc893Y/xCYmH5DHX+Kv/thigX7PdMQNH35HM26o08AKymrpAK6f2Z
    EK8T5FJsFfR7paB+Rc3wAFFy2dOyFbsQM7EjrPBx/b92ci5r9vs+8L0wWILOP/pF
    2Fey0Wqw/zMva8OcfPjV3HYqGWQWWb67Ill9Lrk9DJXmmxKYAU+moCmB7RmjwzFW
    BGts6zT9ubz6hjR2gwVOl/yXpxcGKPAwj8lToT/tXPgjf9tTDzwhLJfAOq8chaea
    Ou8ZvhMEJ/gveelbFJTNL43y3fVQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=qAOgCIP+;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=qAOgCIP+;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHteDRQQLBi1pkEsplNCdes5mwQ5EbgBzfPKZYVNXj/PghVK3zQ8bvKuOkp3ZuzF954nKFM8jKxBiczRqYyK2eyN4tX+Y06tYn8jIvovgo/mvLd8e7+M
    j3+zKQkC9YkXR/pKdtniyg/mBTf2f0wMJt8V4iyPqLKlZLeeHba5RiMARJ9yOPDxX7xNTrVBHuK+hxpGVdMyDZzi5B74cyzSVXp1CSrATeRF0aBY4lANsZv7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PtDNVHqPAAAA:8 a=6-X8RuxaUqMGMgnIRgEA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=QEXdDO2ut3YA:10 a=SsLxlLYP9IwA:10 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933701AbeE2Mz1 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 08:55:27 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45600 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933592AbeE2Mz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 08:55:27 -0400
X-Google-Smtp-Source: ADUXVKLtgPfw7Qg9UIckUUVw4CmewPsD808iD7MdSQBx1yqi9mYlKYKm2mVEpgcZyNm+C5ogCCmvrxZb2n0p+dXaqd0=
MIME-Version: 1.0
In-Reply-To: <877enmskec.fsf@xmission.com>
References: <87r2mre5b3.fsf@xmission.com> <87wovubbdf.fsf@xmission.com> <877enmskec.fsf@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 29 May 2018 14:55:25 +0200
Message-ID: <CAOssrKdS9gOsZrNfqJbk_j0Z8-hrqrYWW+=_Z5mUEX1KE-Kw6Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Ensure posix acls are translated outside of init_user_ns
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 2:42 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> Ensure the translation happens by failing to read or write
>>> posix acls when the filesystem has not indicated it supports
>>> posix acls.
>>>
>>> This ensures that modern cached posix acl support is available
>>> and used when dealing with posix acls.  This is important
>>> because only that path has the code to convernt the uids and
>>> gids in posix acls into the user namespace of a fuse filesystem.
>>>
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>
>> ping.
>>
>> Miklos are you around where you can look at this?
>
> Perhaps I got the wrong email address.


No, sorry.  I'll queue this up for 4.18.

Just wanted to finish off overlayfs stuff before getting into fuse.

Thanks,
Miklos

>
>>
>>> Miklos after several attempts to handle this better last cycle.  I
>>> figure we should go with the stupid version for now.  I think I know
>>> how to do better but I don't want that to gate forward progress on
>>> fully unprivileged fuse mounts.  Especially as this is the last known
>>> issue to deal with.
>>>
>>>  fs/fuse/fuse_i.h |  1 +
>>>  fs/fuse/inode.c  |  7 +++++++
>>>  fs/fuse/xattr.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 51 insertions(+)
>>>
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index f630951df8dc..5256ad333b05 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -985,6 +985,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
>>>  int fuse_removexattr(struct inode *inode, const char *name);
>>>  extern const struct xattr_handler *fuse_xattr_handlers[];
>>>  extern const struct xattr_handler *fuse_acl_xattr_handlers[];
>>> +extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
>>>
>>>  struct posix_acl;
>>>  struct posix_acl *fuse_get_acl(struct inode *inode, int type);
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 1643043d4fe5..22c76cf8c2e3 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1100,6 +1100,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>>>          file->f_cred->user_ns != sb->s_user_ns)
>>>              goto err_fput;
>>>
>>> +    /*
>>> +     * If we are not in the initial user namespace posix
>>> +     * acls must be translated.
>>> +     */
>>> +    if (sb->s_user_ns != &init_user_ns)
>>> +            sb->s_xattr = fuse_no_acl_xattr_handlers;
>>> +
>>>      fc = kmalloc(sizeof(*fc), GFP_KERNEL);
>>>      err = -ENOMEM;
>>>      if (!fc)
>>> diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
>>> index 3caac46b08b0..433717640f78 100644
>>> --- a/fs/fuse/xattr.c
>>> +++ b/fs/fuse/xattr.c
>>> @@ -192,6 +192,26 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
>>>      return fuse_setxattr(inode, name, value, size, flags);
>>>  }
>>>
>>> +static bool no_xattr_list(struct dentry *dentry)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>> +static int no_xattr_get(const struct xattr_handler *handler,
>>> +                    struct dentry *dentry, struct inode *inode,
>>> +                    const char *name, void *value, size_t size)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int no_xattr_set(const struct xattr_handler *handler,
>>> +                    struct dentry *dentry, struct inode *nodee,
>>> +                    const char *name, const void *value,
>>> +                    size_t size, int flags)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>>  static const struct xattr_handler fuse_xattr_handler = {
>>>      .prefix = "",
>>>      .get    = fuse_xattr_get,
>>> @@ -209,3 +229,26 @@ const struct xattr_handler *fuse_acl_xattr_handlers[] = {
>>>      &fuse_xattr_handler,
>>>      NULL
>>>  };
>>> +
>>> +static const struct xattr_handler fuse_no_acl_access_xattr_handler = {
>>> +    .name  = XATTR_NAME_POSIX_ACL_ACCESS,
>>> +    .flags = ACL_TYPE_ACCESS,
>>> +    .list  = no_xattr_list,
>>> +    .get   = no_xattr_get,
>>> +    .set   = no_xattr_set,
>>> +};
>>> +
>>> +static const struct xattr_handler fuse_no_acl_default_xattr_handler = {
>>> +    .name  = XATTR_NAME_POSIX_ACL_DEFAULT,
>>> +    .flags = ACL_TYPE_ACCESS,
>>> +    .list  = no_xattr_list,
>>> +    .get   = no_xattr_get,
>>> +    .set   = no_xattr_set,
>>> +};
>>> +
>>> +const struct xattr_handler *fuse_no_acl_xattr_handlers[] = {
>>> +    &fuse_no_acl_access_xattr_handler,
>>> +    &fuse_no_acl_default_xattr_handler,
>>> +    &fuse_xattr_handler,
>>> +    NULL
>>> +};
