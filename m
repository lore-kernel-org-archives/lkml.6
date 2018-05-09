Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617204-1525882604-2-12892811634977739276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525882604; b=hMBdiSJD5mPZfOImf1OAlg1gXQMj3YG1XO3hcXltu0omv4+5fn
    dlOu7Iy5108qvybX/HvF9iCTPDxQFlvK02tWcW8e/de4nPvtC0T96C9jxInjOOk5
    v5q/8k7bOgriB1fhrYSTAiiiaFcpqVMNM9PVYaPbYvlyRvNudiNMi8N9BsdiawAu
    P3MjeNbG/deAyLuHktXNO4OXMg4akbaIxnu74gDTdAdHfSA0qNY8Zet3ktjRX33y
    o8b+UnkD57fBY+L8WsPuV1e2vUmbPRCD5yyeq8GHdHlEFUMgtWw6WQ+sX8T/7ydr
    QBZAHG8HZV2wlhxrjaKl9FIHn0l0trGSk02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525882604; bh=O1trRM/LZOXfPXHzDcawVzpRqy1WzmDwpV5G6onAPp
    c=; b=OhbWhXsrm5g2LcqzVnjCN4Yv0hyqLg0GOXfAc1vgtMfnRFfQQEFozeVZG6
    sLJ1/7RnIo1PL7iHPPnwoSOGcfwN1l5sgB2jn1kGOnRAjCLY6YgyD+CB8UCoS27G
    HEHMmwFc5+PvA7r/IekEkvZomFya2lrv+mqnIl0NBuhwxzyWiNE3K6CPNKgjmIkD
    jCtz8rNXQKJaA8QVAuJRJ2/6ErQ7iTw8NVdmTUX+zLyhu26bXV84b3H0Fxh3DUdJ
    Agrudu9xCcx+vI84zOw/OR2IFgBR/4VmeA+Kg548JOYcK58hRDmmMvNQxM+fCI3O
    MqlnYF6Qp2VCUouDs5kgYZEer4/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=NepuzZJV
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oMykxSED;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=NepuzZJV
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oMykxSED;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnEgGPjPR5NkqI8m45ZLpDXYUguorVG3tfl1e97zd4X19wETkZFoUKnEkeWz3IQWqOwYL2AAS87lLgx2lh21tgrBEKcZzx2CEEvWwJd99XwNRLRLsjr
    XWUS7BfUigBA39MuJoljGp4qjxh+9xg2DLt92sekQtIfCR/ry/421Q8Qo6IjUatGP08UxFIwIE7B8Xrfwbrsd6CttBzsUG0NZ90pVanv4BVW2CVUvfoJgCgi
    gcG02uv8ECMa4viod5EeKg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=lEFUVsbgnicA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=ofn-0FctOEMOKXMUYoEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965157AbeEIQQm (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 12:16:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36111 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965034AbeEIQQl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 12:16:41 -0400
X-Google-Smtp-Source: AB8JxZq1ENnHNnY9LSKPcJGNRgEuXTfiln/7lQgNaNnz/n+TyHPqD+2YgRaxMlOmmPLLqaTYKzeYOgV/JY3gjSD+agg=
MIME-Version: 1.0
X-Originating-IP: [68.177.129.184]
In-Reply-To: <cover.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 May 2018 11:53:57 -0400
Message-ID: <CAHC9VhRY-hhBb+Kg19Cfy87MSHseUO40j9PC8wsdmHQmcV0zDQ@mail.gmail.com>
Subject: Re: [PATCH ghak81 RFC V1 0/5] audit: group task params
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

On Fri, May 4, 2018 at 4:54 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Group the audit parameters for each task into one structure.
> In particular, remove the loginuid and sessionid values and the audit
> context pointer from the task structure, replacing them with an audit
> task information structure to contain them.  Use access functions to
> access audit values.
>
> Note:  Use static allocation of the audit task information structure
> initially.  Dynamic allocation was considered and attempted, but isn't
> ready yet.  Static allocation has the limitation that future audit task
> information structure changes would cause a visible change to the rest
> of the kernel, whereas dynamic allocation would mostly hide any future
> changes.
>
> The first four access normalization patches could stand alone.

I agree that the first four patches have some standalone value, and
since we are currently at -rc4, did you want to post another patchset
of just those four patches with feedback incorporated?  I imagine that
should be quick work, and that way they aren't help up with any
problems/discussion regarding the take_struct changes.

> Passes audit-testsuite.
>
> Richard Guy Briggs (5):
>   audit: normalize loginuid read access
>   audit: convert sessionid unset to a macro
>   audit: use inline function to get audit context
>   audit: use inline function to set audit context
>   audit: collect audit task parameters
>
>  MAINTAINERS                          |  2 +-
>  include/linux/audit.h                | 30 ++++++++++---
>  include/linux/audit_task.h           | 31 ++++++++++++++
>  include/linux/sched.h                |  6 +--
>  include/net/xfrm.h                   |  4 +-
>  include/uapi/linux/audit.h           |  1 +
>  init/init_task.c                     |  8 +++-
>  kernel/audit.c                       |  4 +-
>  kernel/audit_watch.c                 |  2 +-
>  kernel/auditsc.c                     | 82 ++++++++++++++++++------------------
>  kernel/fork.c                        |  2 +-
>  net/bridge/netfilter/ebtables.c      |  2 +-
>  net/core/dev.c                       |  2 +-
>  net/netfilter/x_tables.c             |  2 +-
>  net/netlabel/netlabel_user.c         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/integrity_audit.c |  2 +-
>  security/lsm_audit.c                 |  2 +-
>  security/selinux/hooks.c             |  4 +-
>  security/selinux/selinuxfs.c         |  6 +--
>  security/selinux/ss/services.c       | 12 +++---
>  21 files changed, 129 insertions(+), 79 deletions(-)
>  create mode 100644 include/linux/audit_task.h
>
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
