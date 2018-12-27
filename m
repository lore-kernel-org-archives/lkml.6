Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E57C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332AF21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYw2X0pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeL0R6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:58:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45800 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeL0R6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:58:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so20860565qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRF8qs1tWpgHt1Rn2rvE7HUIAN34bMHZ1T5uWQ/b/DA=;
        b=DYw2X0pD4LeCfI/Bv0JJ46Ea0bwICIRs0pEPedRgdXnWGiDdJ1D2mqZ/kO9/8A4FUC
         q1TCMRdDO823bPXq1CS89IDuqZ/qLUDqcvNeuR+TbSd8P5wTQ1mJ4zVGIu9lKMTQWNU+
         qeJwczETvuLKYnz3vC4zj6L0ztYr9abzgjGQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xRF8qs1tWpgHt1Rn2rvE7HUIAN34bMHZ1T5uWQ/b/DA=;
        b=dhVDLIjhbZMipllwJITGI9amZ0ZcapGKP96NJHUrtqsAPcNeJX8H4FOlu+vAu4BMeF
         Bkl5DjoJLMcel7T2iiYuaSnAfbVwe5n7WXAlvkRYajYmIjG1gnfY4FQGuXMWb3/baC+T
         gVekDKMa9PQMFdH2MpvYVN/niQ0geTrajvM16hA2boCggWByg/6e/benJozz4qBKqTip
         10i2h2SSbQqGsqAuXmgBJfx3FlqiDkS1hCeol6HjMk2aNNTHBXnCos/AVdIiFaFxbu7z
         7h9mCH2Mxy7aSlPIdITW2r2ycIyopUibt3GyEO20DQ0m4QLHhqwm7UbwVe6n5hOhBbog
         TrLw==
X-Gm-Message-State: AJcUukeol/zLPMou0yxRwPz5qMee5a8Am9esFlDZZZj+DtMT/hU1PT5E
        j2J0lIm1GOL6pQWBY85woRf2YA==
X-Google-Smtp-Source: ALg8bN5nmP/Nk6L0R4RASuZI9HLLHCb2yCUDgLSE9WdVtJCyRp87Xb1BLZfjaAbdfpopTRVGmctjXw==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr22669878qtr.244.1545933533142;
        Thu, 27 Dec 2018 09:58:53 -0800 (PST)
Received: from [192.168.1.132] ([189.61.226.82])
        by smtp.googlemail.com with ESMTPSA id u4sm12568293qkk.51.2018.12.27.09.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 09:58:52 -0800 (PST)
To:     Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
Message-ID: <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
Date:   Thu, 27 Dec 2018 15:58:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/12/2018 15:18, Florian Weimer wrote:
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
> 
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
> 
> getdents(3, [
>   {d_ino=1494304, d_off=3901177228673045825, d_reclen=40, d_name="authorized_keys", d_type=DT_REG},
>   {d_ino=1494277, d_off=7491915799041650922, d_reclen=24, d_name=".", d_type=DT_DIR},
>   {d_ino=1314655, d_off=9223372036854775807, d_reclen=24, d_name="..", d_type=DT_DIR}
> ], 32768) = 88
> 
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).
> 
> In an effort to simplify support for future architectures which only
> have the getdents64 system call, we changed glibc 2.28 to use the
> getdents64 system call unconditionally, and perform translation if
> necessary.  This translation is noteworthy because it includes
> overflow checking for the d_ino and d_off members of struct dirent.
> We did not initially observe a regression because the kernel performs
> consistent d_off truncation (with the ext4 file system; small
> directories do not show this issue on XFS), so the overflow check does
> not fire.
> 
> However, both qemu-user and the 9p file system can run in such a way
> that the kernel is entered from a 64-bit process, but the actual usage
> is from a 32-bit process:
> 
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=23960>
> 
> I think diagrammatically, this looks like this:
> 
>   guest process  (32-bit)
>     | getdents64, 32-bit UAPI
>   qemu-user (64-bit)
>     | getdents, 64-bit UAPI
>   host kernel (64-bit)
> 
> Or:
> 
>   guest process 
>     | getdents64, 32-bit UAPI
>   guest kernel (64-bit)
>     | 9p over virtio (64-bit d_off in struct p9_dirent)
>   qemu
>     | getdents, 64-bit UAPI
>   host kernel (64-bit)
> 
> Back when we still called getdents, in the first case, the 32-bit
> getdents system call emulation in a 64-bit qemu-user process would
> just silently truncate the d_off field as part of the translation, not
> reporting an error.  The second case is more complicated, and I have
> not figured out where the truncation happens.
> 
> This truncation has always been a bug; it breaks telldir/seekdir at
> least in some cases.  But use of telldir/seekdir is comparatively
> rare.  In contrast, now that we detect d_off overflow in glibc,
> readdir will always fail in the sketched configurations, which is bad.
> (glibc exposes the d_off field to applications, and it cannot know
> whether the application will use it or not, so there is no direct way
> to restrict the overflow error to the telldir/seekdir use case.)
> 
> We could switch glibc to call getdents again if the system call is
> available.  But that merely relies on the existence of the truncation
> bug somewhere else in the file system stack.  This is why I don't
> think it's the right solution, just the path of least resistance.
> 
> I don't want to reimplement the ext4 truncation behavior in glibc (it
> doesn't look like a straightforward truncation), and it wouldn't work
> for the second scenario where we see the 9p file system in the 32-bit
> glibc, not the ext4 file system.  So that's not a good solution.

Also for glibc standpoint, although reverting it back to use getdents 
syscall for non-LFS mode might fix this issue for architectures that
provides non-LFS getdents syscall it won't be a fix for architectures 
that still provides off_t different than off64_t *and* only provides 
getdents64 syscall.

Currently we only have nios2 and csky (unfortunately).  But since generic 
definition for off_t and off64_t still assumes non-LFS support, all new
32-bits ports potentially might carry the issue.

> 
> There is another annoying aspect: The standards expose d_off through
> the telldir function, and that returns long int on all architectures
> (not off_t, so unchanged by _FILE_OFFSET_BITS).  That's mostly a
> userspace issue and thus needing different steps to resolve (possibly
> standards action).
> 
> Any suggestions how to solve this?  Why does the kernel return
> different d_off values for 32-bit and 64-bit processes even when using
> getdents64, for the same directory?
> 
