Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2396152-1525968958-2-3265297307303712511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525968957; b=fOPwbW0y0jcY6gEn1d/yMido9211jViQu64/949exREDyY/WlY
    lug3RqSKYGixY25P1ZTLrxtXy7jTBRU6KjnYmIf1TPPjfTa94P/P3lub4nv3Mym6
    fTWnar8OvlWQNa8Lecnpon/SKaYiN2EPORLhc8iie7ElQwYnkU4HjC3+1xLwmHxd
    l5bmOHw1n5pBxWomn1VEufCr07MF3ShlxL0sHKazqFWjX6vCgwv6hirqUgK1kLCj
    Z+5G/g8zLMWRwWXsQAtvh4R1NumsnAXiaX9NxDRQyDB9hq68ptdr7vu3VlgRqajG
    krtzmb/+IQ9H1PFHX78OEZAxHIP/fU6AnWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525968957; bh=tSB6x8M3o69PmMDlbrwk75jJNpb6vgewP/ggfNQMjy
    o=; b=RZSn8zbTmjp8/dJ2hhwFn0zx+oja3Cro/MmU8S8rGxdEr1hzqEBn6AutRy
    D9Eafm9QivF8d+f0na/O2KsmnVCIU1KPKUgHJ0G4vsybUWfTSZVuN1aGXaezKJxy
    B6cry77wi9NdhYCz3LswgTPiCsSBxp5nWeSM5NRF28Yrox2oioeZVnvFSAzXTzUS
    KAiqxAw8+jIp0EBI5oPu7uU2vDnY9WUsy73R2ffBvdwyB2cwZFUvqOXB7j8JxdnV
    8ngf4R8Vt+yqrd/iTX72yOHi2O20xqbSiToHh7hMKVG7Nf1CKEWz4W69Ac+RXjqh
    oyY8Cq9BbWYpkIGtnk2YgmyR7b5g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=cwBApNmN
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=GxoevCf0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=cwBApNmN
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=GxoevCf0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhz6jKREDnF0CVFq5sPJfZtjJtjV6W7jQBNuxO4+BzRzoX8sAB/CJbPy5uWXjkxzySgqlghvj097sqT5xkoPyvR6aVD8STUwZgT2tws45vSX/Z+9GwS
    rdyrM5HL0WI/0Cz/Pw29AeQarQR6yfxkB2fWgWfJ0Z/pC57j/TR9OkylVVk1cssge6uv2hZmqmLYYOnCdWaf1s2QYX2QolhKbV/9mRhAKZJlmDufD3+yUmEt
    uCOy4onGjvq6FP9oazuOcA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=lEFUVsbgnicA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=IJv9LcIfAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=etLnv9_D2-5lUF34r5MA:9 a=5HW3sPX1eozGsZ9-:21 a=6toFVrVIv0m6c1yG:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=cmr4hm9N53k6aw-X_--Q:22
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966249AbeEJQPz (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 12:15:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41927 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeEJQPy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 12:15:54 -0400
X-Google-Smtp-Source: AB8JxZqvnMrKuC8eJ1onE65pipV6DzP6oqBTx2ImgDsddmhUfsLLrywNiH3rhVF0pYDhiD5zsOJrF2tehLOEU9zkvXk=
MIME-Version: 1.0
X-Originating-IP: [68.177.129.184]
In-Reply-To: <799f2558f37c5480d42c03e3465754aa8bb30e70.1525964385.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com> <799f2558f37c5480d42c03e3465754aa8bb30e70.1525964385.git.joe@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 May 2018 12:15:51 -0400
Message-ID: <CAHC9VhQb72hBo5Tv0gu-LurhdjQYyt3B=7mz6oJ1XqZfc9GZ_Q@mail.gmail.com>
Subject: Re: [PATCH 15/18] security: Remove pr_fmt duplicate logging prefixes
To: Joe Perches <joe@perches.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 11:45 AM, Joe Perches <joe@perches.com> wrote:
> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
>
> Remove them.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/selinux/selinuxfs.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c0cadbc5f85c..be8f186a6256 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -515,19 +515,19 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
>
>         ret = sel_make_bools(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy booleans\n");
> +               pr_err("failed to load policy booleans\n");
>                 return ret;
>         }
>
>         ret = sel_make_classes(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy classes\n");
> +               pr_err("failed to load policy classes\n");
>                 return ret;
>         }
>
>         ret = sel_make_policycap(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy capabilities\n");
> +               pr_err("failed to load policy capabilities\n");
>                 return ret;
>         }
>
> @@ -570,7 +570,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>
>         length = security_load_policy(fsi->state, data, count);
>         if (length) {
> -               pr_warn_ratelimited("SELinux: failed to load policy\n");
> +               pr_warn_ratelimited("failed to load policy\n");
>                 goto out;
>         }
>
> @@ -620,8 +620,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -956,8 +956,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -1147,8 +1147,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -1389,8 +1389,8 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>                 ret = security_genfs_sid(fsi->state, "selinuxfs", page,
>                                          SECCLASS_FILE, &sid);
>                 if (ret) {
> -                       pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
> -                                          page);
> +                       pr_warn_ratelimited("no sid found, defaulting to security isid for %s\n",
> +                                           page);
>                         sid = SECINITSID_SECURITY;
>                 }
>
> @@ -1996,8 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>                 goto err;
>         return 0;
>  err:
> -       printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
> -               __func__);
> +       pr_err("%s:  failed while creating inodes\n", __func__);
>
>         selinux_fs_info_free(sb);
>
> @@ -2046,7 +2045,7 @@ static int __init init_sel_fs(void)
>
>         selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
>         if (IS_ERR(selinuxfs_mount)) {
> -               printk(KERN_ERR "selinuxfs:  could not mount!\n");
> +               pr_err("selinuxfs:  could not mount!\n");
>                 err = PTR_ERR(selinuxfs_mount);
>                 selinuxfs_mount = NULL;
>         }
> --
> 2.15.0
>



-- 
paul moore
www.paul-moore.com
