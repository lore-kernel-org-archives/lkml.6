Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-461662-1523520270-2-14192549254633648218
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
    1523520270; b=LJKwXT776TIGP1kJgLpFXgZ+W/LFUjOSkrG5Rp37wDAvRC2ZvJ
    twd/1yxt7zPVloiOy22isG6UPjAHvrczQft1W8SXcjML0cZ7CftRiAFhl06ieJQi
    gQvkNUAB5ndZaoQOMhDozeoo4hmmwASZnIV4GDIZM18J/SqDMNwWQrC8MAHvOmv9
    U+oMfbhKmA9+jydZFI5BOyCWKfSb1J7H/30c3WlXSXT63TZe1SJH92Kf9553x5w7
    YTDe3/4pM/nnAKt0awzl6cwdDa5FDg7LN1islL31q8s3uGbhYl9WEhwgR4g4WKu8
    apJPoF6O7kNq3Pp6LJ/YcknYQT06vYGPTwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523520270;
    bh=Z90Y5R2KpOSHKccuhaZSothR05W5F81oz2Ab8lbm2HI=; b=sS1drLRWutiS
    yK0sPCVEhs08cJmPU+jpNfn0Vh6v7WSMtLzcb6kgqVt+UKXUG1dTDwsJAaaKkLkp
    V0DdA5KoOT9ExaH74PhsaomirpNaXNkV5e74LUhOUEHz0J7UZmuDQkd01eHZzcyQ
    DQEgSXluW4UG0vt+tYHQCUnJQpC1pVZyxwdORw49HptGsFD3PY/zrIAYyhPcM3gB
    cVIAcsJCk8/7fiXkHiY05z3amJARKryzUMQHY5WzJJcTgsauKvMoRrDgzMZrjleb
    qnRUXWQrrIiZI7p46KHIbMKxiviVepEBsLTZsYhI3wpvcfq4fzQZBISp/kmemp3w
    rwas198POQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qCNvQt1m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hiwhJ2xP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qCNvQt1m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hiwhJ2xP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAFG0rZ7TvsJpOz4r/sepHZt2QVujwGV/wH2KNs+AWzJajCC/5p7T2mGfwMXGvpRPdBDm9ToSf/qwBvsTW9Tr+sSis5SqKOnCyYzzklwWFIdnrES9P9U
    Hq/fU56erzppYDq7PPeDeKjZ3R/8Y4XzTGLfVzctn7jANbD/ErVXHmOF3RzOGugXasjshB/5GhQ6iiYdO2BjbPyugrRadEYRRIOGQpivkJxdhCLx518lvqit
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8 a=GcyzOjIWAAAA:8 a=C2WAnJVigUwZBbY4CHoA:9
    a=iIdYM6UySw8SAyBS:21 a=uvjMnKXbH4RwAjfl:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=JFlNBosjgyz61O-hmi61:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDLIES (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:04:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36863 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeDLIEL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 04:04:11 -0400
X-Google-Smtp-Source: AIpwx4/16c88+O/2GD/hnbFtoFyBlkkWs+HpPvxVmyDZzoODpqVi+2nJcKkAmpg8CE8p/tKYvVlFXg==
Cc: mtk.manpages@gmail.com, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
To: mhocko@kernel.org
References: <20180411120452.1736-1-mhocko@kernel.org>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <97504dda-4252-a150-e7b5-43fe587aa055@gmail.com>
Date: Thu, 12 Apr 2018 10:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180411120452.1736-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Michal,

On 04/11/2018 02:04 PM, mhocko@kernel.org wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
> atomicaly probe for a given address range.
> 
> [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Thanks! I've applied your patch, and done a little tweaking. The results
have already been pushed.

Cheers

Michael


> ---
> Hi,
> Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
> window. So here we go with the man page update.
> 
>  man2/mmap.2 | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index ea64eb8f0dcc..f702f3e4eba2 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -261,6 +261,27 @@ Examples include
>  and the PAM libraries
>  .UR http://www.linux-pam.org
>  .UE .
> +Newer kernels
> +(Linux 4.17 and later) have a
> +.B MAP_FIXED_NOREPLACE
> +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
> +should be preferred over MAP_FIXED.
> +.TP
> +.BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
> +Similar to MAP_FIXED with respect to the
> +.I
> +addr
> +enforcement, but different in that MAP_FIXED_NOREPLACE never clobbers a pre-existing
> +mapped range. If the requested range would collide with an existing
> +mapping, then this call fails with
> +.B EEXIST.
> +This flag can therefore be used as a way to atomically (with respect to other
> +threads) attempt to map an address range: one thread will succeed; all others
> +will report failure. Please note that older kernels which do not recognize this
> +flag will typically (upon detecting a collision with a pre-existing mapping)
> +fall back to a "non-MAP_FIXED" type of behavior: they will return an address that
> +is different than the requested one. Therefore, backward-compatible software
> +should check the returned address against the requested address.
>  .TP
>  .B MAP_GROWSDOWN
>  This flag is used for stacks.
> @@ -487,6 +508,12 @@ is not a valid file descriptor (and
>  .B MAP_ANONYMOUS
>  was not set).
>  .TP
> +.B EEXIST
> +range covered by
> +.IR addr ,
> +.IR length
> +is clashing with an existing mapping.
> +.TP
>  .B EINVAL
>  We don't like
>  .IR addr ,
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
