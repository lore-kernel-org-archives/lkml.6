Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74CCC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CEC2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3DCMLff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CEC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeJLWWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:22:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeJLWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:22:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so13748098wrw.12;
        Fri, 12 Oct 2018 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=URJ9cAc5Hfi0QMR9lhmKp6UO9+S24BzXUI/kJ3VFHC4=;
        b=W3DCMLffVkRnV7Mmcmiqh7f3VKIHTzmbQuESIfMKFul5rCvmjGEi+TtNgT15XWD8YE
         JY+cgjfTDD5eKQpmwN1x32/nq+8eMJfP4WTB+bi0kuWbp+6vtOxVUS7VwXePFmb+hU3s
         gC/18ge/Y5bhorzwxaJOIBFFHf6b+6iAmGrTc1Sb9wOKNXhpAQAlzof4FpIAOdzYlAAr
         Q+3YUYA4fUk5KXZxksbeNxxvyNLGTLVkVZ1wEgY/sGM3rxepwrxrzPVCQgwn0n7jnAZL
         ckCjeb2Wy0nyHBZ2LBTE94GqKC/NrHpazCk+2PqxnLL4EuizSUrVm4tzZMz/mpytKhAz
         ZmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=URJ9cAc5Hfi0QMR9lhmKp6UO9+S24BzXUI/kJ3VFHC4=;
        b=UgOJv+wydAhJR1jLvCoT2XmEclZ5nnxyQNmLg1V7iu2naUNSYWoW98+sstx4F9xQxT
         GAu5u8d/xs45RBved6lHTqLnVhZUS91FsyWMepQhhrlUiwKTi2YBh0YF5kIzSF7RjbL7
         5W7MRiZT5Y8V6S4V/+sVHJu7q9Rz+adJpLxduMbghS8+voTlSKYE/gfK6ukOHitOOf1q
         2QqZjAmc9TnPJBMXRC0psKle6qdaf51nDD2avNDYx8/zH8UVvV56UnKts/TxYXANGq1q
         eeuJ5Qe0iJUNeg+XOM6cqA1Z+6KdqrMhCPzX6YZZUxXlQYOvqJiUpgTtqWl4vYwlJDXM
         xhOA==
X-Gm-Message-State: ABuFfojl0GJE5GVl8+s3wF8Tew/SvpxPBOOr3I/DKyJsv5JSKKHdAZ1e
        pCl2Jm1xMM4yaAYs6x2ebmM=
X-Google-Smtp-Source: ACcGV62lPkP6ti6eo4Kz/jsJsNNas3MDPh6hwtk44aiFtwwXvnEnvaUgXdZUZrzieOmrhmbGS5qe6g==
X-Received: by 2002:adf:f111:: with SMTP id r17-v6mr5817604wro.303.1539355792018;
        Fri, 12 Oct 2018 07:49:52 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1214607wmf.15.2018.10.12.07.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:49:51 -0700 (PDT)
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
Date:   Fri, 12 Oct 2018 15:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 17:34, David Howells wrote:
> Provide an fspick() system call that can be used to pick an existing
> mountpoint into an fs_context which can thereafter be used to reconfigure a
> superblock (equivalent of the superblock side of -o remount).
>
> This looks like:
>
> 	int fd = fspick(AT_FDCWD, "/mnt",
> 			FSPICK_CLOEXEC | FSPICK_NO_AUTOMOUNT);
> 	fsconfig(fd, FSCONFIG_SET_FLAG, "intr", NULL, 0);
> 	fsconfig(fd, FSCONFIG_SET_FLAG, "noac", NULL, 0);
> 	fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
>
> At the point of fspick being called, the file descriptor referring to the
> filesystem context is in exactly the same state as the one that was created
> by fsopen() after fsmount() has been successfully called.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> ---
>
>   arch/x86/entry/syscalls/syscall_32.tbl |    1 +
>   arch/x86/entry/syscalls/syscall_64.tbl |    1 +
>   fs/fsopen.c                            |   54 ++++++++++++++++++++++++++++++++
>   include/linux/syscalls.h               |    1 +
>   include/uapi/linux/fs.h                |    5 +++
>   5 files changed, 62 insertions(+)
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index c78b68256f8a..d1eb6c815790 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -403,3 +403,4 @@
>   389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
>   390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
>   391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
> +392	i386	fspick			sys_fspick			__ia32_sys_fspick
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index d44ead5d4368..d3ab703c02bb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -348,6 +348,7 @@
>   337	common	fsopen			__x64_sys_fsopen
>   338	common	fsconfig		__x64_sys_fsconfig
>   339	common	fsmount			__x64_sys_fsmount
> +340	common	fspick			__x64_sys_fspick
>   
>   #
>   # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 5955a6b65596..9ead9220e2cb 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -155,6 +155,60 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
>   	return ret;
>   }
>   
> +/*
> + * Pick a superblock into a context for reconfiguration.
> + */
> +SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
> +{
> +	struct fs_context *fc;
> +	struct path target;
> +	unsigned int lookup_flags;
> +	int ret;
> +
> +	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +		return -EPERM;


This seems to accept basically any mount.  Specifically: are you sure 
it's OK to return a handle to a SB_NO_USER superblock?

# strace -f -v -e trace=154 \
     ./fspick 3</proc/self/ns/mnt 3 \
     stat -f /dev/fd/3

syscall_0x154(0x3, 0x4009a1, 0x8, ...) = 0x4
   File: "/dev/fd/3"
     ID: 0        Namelen: 255     Type: anon-inode FS
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 0          Free: 0          Available: 0
Inodes: Total: 0          Free: 0
+++ exited with 0 +++


