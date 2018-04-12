Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1582956-1523557977-2-12993992791143416578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523557976; b=bL2LJ7YUy6TVQmyIa7WngkeQ+TYT0Hl4ulGGwlA8VDAy2noWDW
    hAGxVRdIb1J5lB5kNch8kltlRYih+hEWEhfm1JxEFb5ocoQZnhauWw5Y3YgFdUC6
    xrDktGd104Gk/mS0mKyFs9ZZ6K48kD4SxW44ucPAlD/vbO1sPvp8UdcFRTOzbfep
    +EoXhsi42mjkHwdBrlAit6IffTi2Gh7ISOs9Q/WxK0rVfnynkaBGMS3+zY7Kfk+Z
    deuDWjP5FyycGcTBFs8xY8sKxJFkuSwYkWMaY5xHr9TKuNMMmVawthXsZX9tQkMw
    ocjqjxfOnt0KzU5m6ukVgEvYeqnnTo0+RF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523557976;
    bh=pXSiezbeROvtDlfeA7/PSwklw57nTOl64afMcXsijs4=; b=ss6ZsN9jNYNh
    i/rV28cqZfvIkr5zxWUb8OJak4fMm90QoDmYjl3u2nUccO4D337DjQCATm2d4K7J
    Xz6RqQe3CeI/gmLR5tFUbEsDyDFs3XhrPOOW3+DXUavJFfJyFSVmV1BoCq7D6vGh
    q6+3NQZWxh5sMCf+GdO4a6IT3Vjz11TF84CeLjo7EcjuBRxjJzs2tAYwf57AiNhS
    keL6IHtM/bzeJgub0OWiX9rrFoaoarjMfRhF7o4altl7Q3XDBuBZBS7erZEGsX6e
    OfNCnj2HfCLAzF4vXh9UWP6hiP8kyVnGF6eFnm3eDVUuH8TeXuMf97jn/WqfTmD4
    PfsDt+Y1/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxYoPwIk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e7DeYd+1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxYoPwIk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e7DeYd+1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfONZjWczTtJHEqeDuWIe6o2TdUp5xqJk/J8fzeRYDywrSTp0SlWpUA4ZdNjRgkFII6sYteKmJ0LQ3SB7bAuSM6t0ZTbUxR9H0cQ0NkxYThL4NGMYjP25
    bPoSZNV+0/XbraZAYh9MtU2fbmhS3lU8NgzjIj/3VF2ITKYIR3qU/bCMUSXTyd1UfpYYbZmfvmFh4obGe9yEbeX88BJgfnfpm2JXJACQSwwn26224KVd+9FZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=GcyzOjIWAAAA:8
    a=gpI8acLqhJ06iL_wKUgA:9 a=OKn5u0scoi39EwHP:21 a=Ug62Kmh5orO8b7MT:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22
    a=AjGcO6oz07-iQ99wixmX:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDLScr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 14:32:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38710 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeDLScp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 14:32:45 -0400
X-Google-Smtp-Source: AIpwx48gKvFYuuAdObpIaxBfPL7Na/OHz8wUWizsxLDupy0W5y8zfW5s2Wie/NRTAy0EmZgn5qLdIw==
Cc: mtk.manpages@gmail.com
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
To: Jann Horn <jannh@google.com>, linux-man@vger.kernel.org,
        mhocko@kernel.org, jhubbard@nvidia.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20180412153941.170849-1-jannh@google.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3ff7472c-23c8-402b-ddfb-871a749c5016@gmail.com>
Date: Thu, 12 Apr 2018 20:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180412153941.170849-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Jann,

On 04/12/2018 05:39 PM, Jann Horn wrote:
> Clarify that MAP_FIXED is appropriate if the specified address range has
> been reserved using an existing mapping, but shouldn't be used otherwise.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  man2/mmap.2 | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index bef8b4432..80c9ec285 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -253,8 +253,9 @@ Software that aspires to be portable should use this option with care,
>  keeping in mind that the exact layout of a process's memory mappings
>  is allowed to change significantly between kernel versions,
>  C library versions, and operating system releases.
> -Furthermore, this option is extremely hazardous (when used on its own),
> -because it forcibly removes preexisting mappings,
> +This option should only be used when the specified memory region has
> +already been reserved using another mapping; otherwise, it is extremely
> +hazardous because it forcibly removes preexisting mappings,
>  making it easy for a multithreaded process to corrupt its own address space.
>  .IP
>  For example, suppose that thread A looks through
> @@ -284,13 +285,15 @@ and the PAM libraries
>  .UR http://www.linux-pam.org
>  .UE .
>  .IP
> -Newer kernels
> -(Linux 4.17 and later) have a
> +For cases in which the specified memory region has not been reserved using an
> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>  .B MAP_FIXED_NOREPLACE
> -option that avoids the corruption problem; if available,
> -.B MAP_FIXED_NOREPLACE
> -should be preferred over
> -.BR MAP_FIXED .
> +that should be used instead; older kernels require the caller to use
> +.I addr
> +as a hint (without
> +.BR MAP_FIXED )
> +and take appropriate action if the kernel places the new mapping at a
> +different address.
>  .TP
>  .BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
>  .\" commit a4ff8e8620d3f4f50ac4b41e8067b7d395056843

Thanks! Nice patch! Applied.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
