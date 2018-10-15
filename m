Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD3AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC032089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="N1fK5yii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC032089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPAQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:16:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34593 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeJPAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:16:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so23417327wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K0fJfGNSAz2UBzLomzjPssYSkMvLUr7bmHr4/DSBaqo=;
        b=N1fK5yiiqTnYrea8LexOeRy38OyG391UrKWzOVef4A+V3M1UpIRxzXlJdhRknjYPTK
         t1tlyUNytkEaSTm4lDkG9rCDa6inYoVPf5hTdF4jlSt7zQzPuQXX89TZOyY9OqNYvz6N
         PNFAX1SgsHOhATytSk2kZoLle7yR2PdIARMD5qaVeWNRpuCMRiMIqDYCY7tpc/tdtE05
         66ph7PKNcgXkiBo4dvTf1PP7M4ppdjQI+zqZ4pIBOO7SmMgnzlUkIBb4saFvoDoMdtrM
         S3cYsAJ0PTqopXFueW0dk6ztlnluF9hR6NWfzRTgPG9T/b4k5A0h1PD+nHX+QZC7c8Ur
         BUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0fJfGNSAz2UBzLomzjPssYSkMvLUr7bmHr4/DSBaqo=;
        b=VC8jsLpekOLADHWYt+spb52Q7Wy/jYogbKemoXB0hSISJwPa5ifDGXIr0JkbNZgTn+
         nbK0M9i0VH8l7x/7n2Mia1bJF4iVjclol+curfEPxw9yAAU1T1gE/ADsBWWsog14E3+1
         XVZA80jGQRJSiXky/3b7PB47sr4KZsPKXqInAqadumQsfHivExG8LggqXy3YCncQYQaH
         rEQrIVIEx77+BWFxMjAfayijW3TGIZtI4+oIMK+LG9uLfe4S3aeUg1vkbIFISqBBa58Q
         0MelwdQxFWiySyGIe6+TrCw7b6nmyojz5OlXbScU6Ow2tPm4dsYA53YSG/Tf+CgTm6nQ
         GxCw==
X-Gm-Message-State: ABuFfohU28rXF81kBXl8o12BbZg0kp7W4t/Iss8OtVNd38j7OAkOKSlC
        ED4ba9sv10V5m8inT3o5sFo6EA==
X-Google-Smtp-Source: ACcGV617pJnKC7R7EvNtLZfZkP58H3VPBf/PQIaLIN4/s/tZZT2kpv2T6dPms1VQlP73qNw0cvSN6A==
X-Received: by 2002:a1c:4889:: with SMTP id v131-v6mr13910978wma.87.1539621017185;
        Mon, 15 Oct 2018 09:30:17 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id o126-v6sm7282000wmo.3.2018.10.15.09.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:30:16 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:30:10 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
Message-ID: <20181015163009.byd2lklpk2n3qzpq@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-2-christian@brauner.io>
 <CAGXu5j+BZsmRXwXfXk1YcyuSRNMmre=K55e1CXaLJDUZ07rmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5j+BZsmRXwXfXk1YcyuSRNMmre=K55e1CXaLJDUZ07rmvQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:18:40AM -0700, Kees Cook wrote:
> On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> > proc_get_long() is a funny function. It uses simple_strtoul() and for a
> > good reason. proc_get_long() wants to always succeed the parse and return
> > the maybe incorrect value and the trailing characters to check against a
> > pre-defined list of acceptable trailing values.
> > However, simple_strtoul() explicitly ignores overflows which can cause
> 
> What depends on simple_strtoul() ignoring overflows? Can we just cap
> it to ULONG_MAX instead?
> 
> I note that both simple_strtoul() and simple_strtoull() are marked as
> obsolete (more below).
> 
> > funny things like the following to happen:
> >
> > echo 18446744073709551616 > /proc/sys/fs/file-max
> > cat /proc/sys/fs/file-max
> > 0
> >
> > (Which will cause your system to silently die behind your back.)
> >
> > On the other hand kstrtoul() does do overflow detection but fails the parse
> > in this case, does not return the trailing characters, and also fails the
> > parse when anything other than '\n' is a trailing character whereas
> > proc_get_long() wants to be more lenient.
> 
> This parsing strictness difference makes it seem like the simple_*()
> shouldn't be considered obsolete...
> 
> and it's still very heavily used:
> 
> $ git grep -E 'simple_strtoull?\(' | wc -l
> 745

Maybe, but the intention is probably to fade it out and to not use it in
new code because it doesn't handle overflow.
Tbh, I'm weary to change that to suddenly return a ULONG_MAX on overflow
instead of what it is doing now. I have absolutely no idea what this
might break given how much it is still used in the kernel...

> 
> > Now, before adding another kstrtoul() function let's simply add a static
> > parse strtoul_cap_erange() which does:
> > - returns ULONG_MAX on ERANGE
> > - returns the trailing characters to the caller
> > This guarantees that we don't regress userspace in any way but also caps
> > any parsed value to ULONG_MAX and prevents things like file-max to become 0
> > on overflow.
> 
> -Kees
> 
> -- 
> Kees Cook
> Pixel Security
