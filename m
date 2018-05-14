Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474721-1526334249-2-15257790422157419607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526334249; b=Oe+b0K+E1Bt3HsqP/dWBHbYuwSUTioJ1shzhOb94aUJ2T2LMDQ
    FLe1+4mlzgHZkJVtdfp7lexH4mlFzF652de6ywjb/cy6dovrAfp66bzSPOy/b4BM
    0y5Mz8Cn7+Z658+gBbgqtn4tiXvCGCVBPi2KSH3efaLyu89v3p/oZOWuUMQFLS9K
    d7dq0Ad0bV+goYXQomPA++q/0tqA6WyLPtqn+YR6Y70pwtiQO3SohYrtDgdtPWSQ
    jCdTajO+78oY5FsUrChAR0ORP6kb9Rhp+g7zRtheKl5qrbQi/TzzvLK5AafPMNo5
    gSHB1VFfMCYBY1ZT5bwarFJDKv4ecSGAKBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526334249; bh=l1XDpEVlrT111cHzLhLes6RzWrG3jHLydePwUIFHGG
    4=; b=K3N+jXHiDfY3hawniexwnqqed56YeKwM5tgcTaeCftNA+mKI3Jd5CLur7B
    bXw70p8OmR4s7H2o5tu/sIuOcVemiLNUvfoe5mol9+81n95r0K2cqDoqrJRfougN
    C/kioWBMvZDKmxMQiOkk8OVhQdhrZ1wQXF2NVwYETi3xw2TyDwIYx1K6Ss2tKHEV
    xOzKenfRDs/Y/i9BKLL/fiQZC3eeZtA0JTCBpAsNJqNL2q/jcuXTfPAPHjrqOsjg
    8c43LA//SbFNI7pz0xDOOu+rmeFZR5+qmrdDpyLAabX2e3j3i+XpBd2S3vZ2n/WW
    gLF0IMHGdttQT8WIEx1GCttl7jcQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=OmhwkSjK
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=JZ0+qx7S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=OmhwkSjK
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=JZ0+qx7S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLbi2SAWaptERZtCUfvgviTHpW03/40X2NlastQR1R67xvVTn/+9nY7b5YggsEXs5vah1n4zzZmTXDpfG+3nBgJ/LgZtaHuicSQ/TkmORZKI9T5BKUdd
    uOCuaqE66IteNJq0VSlJOk9bXKCQ4o3JU2rp6zhX35wVWdewwy0fvpyckYx7s/aow/eCQHXUFNkKh9ro4D2DWmEJQBP5b6rczJmSJZCASCHP4XYwphzx/lBb
    5WAiDGQvWpqNrKglqF282w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=6Jo02TKGwVwa4Mu2SKYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeENVoF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 17:44:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39425 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeENVoD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 17:44:03 -0400
X-Google-Smtp-Source: AB8JxZrh250FO8jrT+kvCnGR8/LK58bOLxt1Oc6Xka5X0U9a2TM4LpCcXBOCgkZLuhwKJ1kAXaNU94bHFkLU4FR5aR8=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <baa29a694e352bd4fe8acd0f46f7baca1ad2c147.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com> <baa29a694e352bd4fe8acd0f46f7baca1ad2c147.1526173613.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 17:44:01 -0400
Message-ID: <CAHC9VhQXr76FXPCe8vUWNwa2VshcPg1mZmMY7M30H1F6w30rFA@mail.gmail.com>
Subject: Re: [PATCH ghak81 RFC V2 3/5] audit: use inline function to get audit context
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to retrieve the audit context pointer for the task
> rather than reaching directly into the task struct to get it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h                | 14 ++++++--
>  include/net/xfrm.h                   |  2 +-
>  kernel/audit.c                       |  6 ++--
>  kernel/audit_watch.c                 |  2 +-
>  kernel/auditsc.c                     | 64 +++++++++++++++++-------------------
>  net/bridge/netfilter/ebtables.c      |  2 +-
>  net/core/dev.c                       |  2 +-
>  net/netfilter/x_tables.c             |  2 +-
>  net/netlabel/netlabel_user.c         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/integrity_audit.c |  2 +-
>  security/lsm_audit.c                 |  2 +-
>  security/selinux/hooks.c             |  4 +--
>  security/selinux/selinuxfs.c         |  6 ++--
>  security/selinux/ss/services.c       | 12 +++----
>  15 files changed, 64 insertions(+), 60 deletions(-)

Merged, but there was some fuzz due to the missing 1/5 patch and a
handfull of checkpatch.pl fixes.  Please take a look at the commit in
the audit/next branch and if anything looks awry please send a patch
to fix it.

-- 
paul moore
www.paul-moore.com
