Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3424180-1517609129-2-7360113004051783680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517609129; b=XwDW76jqM1KQgDr3wDQ8ewfvtl1eaYJKGxUuSQJp9FbkMvX
    DIB906KfaD2cuDiAD1rQqU1ZfH3zFqTMN9FAe+VI4H7lL6STR1WdGkhSljmWkfYg
    Zo29nuFf8z4oo6khTz6TTjWNwA0L6EdAF5uwuR7LNm0huFHzggI9pAJqOK7q5dq9
    Wdsq8z2JPygisuiGcrD+spzG94GT/LoHqXZ0qOZuQcUxnuN8GjxOpjrrvcKy3FMq
    hL/cmNwRhGjTCTeZlUpjNVdnppiOR4bMzpvk7vJcs4gChr/FFYUbWZ1QzI5RuX+G
    x7jgbahQ4LGKltCLs9vqLnc3grR89IhJBMic/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517609129; bh=xgVxZVL4Ecu3TN8Wv9Pipt0SDsxNG10CKojyh8
    xlTc4=; b=agirwn+B8H1LdcPr2JAk/hcTWdOsoLDyR6dVTw6GUCSyu6uzMEhKzk
    mqmyL7TjlYP5EwMti+vvYSLYUcg/H85YANRp4btQmum1gaXyXSGMc2kTqvpefVy1
    2fmoQ77ElXFaAGPnd69BnmvUfLMfLBKjIa0lLsYldq8qo6ZdV+/+1WKXvSwImggQ
    JYdGUuAchI4rXJ8upRt5EuXlsAy+wWcFwv4bbDafTRxTJ3uRQXl052UoiNADNHCl
    uqQkoZGJh1DcPjQ6rERlEtaMKQxsC9X9bNulxZvWc0+zRfysv+VZtOjDBt1ilnU2
    DwCyQV1HvgMxeKsI9rtSkVfdvspSBUhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=lvSJbF9i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EfBCK/Ii;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=lvSJbF9i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EfBCK/Ii;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeBBWF0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:05:26 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35907 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeBBWFY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Feb 2018 17:05:24 -0500
X-Google-Smtp-Source: AH8x227ms8kIUBusUOxZZDwIJznOotVKJ1xTgC4pm6FQa9Cz4vSt2jcG0s+Lx4EcHZsEZlu8M7XxpgYdCfFc77L6XmQ=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2018 17:05:22 -0500
Message-ID: <CAHC9VhQ5ciUZDhrsb6S4YxwuzQEY-ra2RTDceWXOdjHEBoZ0BQ@mail.gmail.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Network Development <netdev@vger.kernel.org>,
        mszeredi@redhat.com, Andy Lutomirski <luto@kernel.org>,
        jlayton@redhat.com, "Carlos O'Donell" <carlos@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>, trondmy@primarydata.com,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 9, 2018 at 7:16 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Containers are a userspace concept.  The kernel knows nothing of them.
>
> The Linux audit system needs a way to be able to track the container
> provenance of events and actions.  Audit needs the kernel's help to do
> this.

Two small comments below, but I tend to think we are at a point where
you can start cobbling together some prototype/RFC patches.  Surely
there are going to be a few changes, and new comments, that come out
once we see an initial implementation so let's see what those are.

> The registration is a u64 representing the audit container identifier
> written to a special file in a pseudo filesystem (proc, since PID tree
> already exists) representing a process that will become a parent process
> in that container.  This write might place restrictions on mount
> namespaces required to define a container, or at least careful checking
> of namespaces in the kernel to verify permissions of the orchestrator so
> it can't change its own container ID.  A bind mount of nsfs may be
> necessary in the container orchestrator's mount namespace.  This write
> can only happen once per process.
>
> Note: The justification for using a u64 is that it minimizes the
> information printed in every audit record, reducing bandwidth and limits
> comparisons to a single u64 which will be faster and less error-prone.

I know Steve generally worries about audit record size, which is a
perfectly valid concern in this case, I also worry about the
additional overhead when we start routing audit records to multiple
audit daemons (see my other emails in this thread).

> ...
> When a container ceases to exist because the last process in that
> container has exited log the fact to balance the registration action.
> (This is likely needed for certification accountability.)

On the "container ceases to exist" point, I expect this "container
dead" message to come from the orchestrator and not the kernel itself
(I don't want the kernel to have to handle that level of bookkeeping).
I imagine this should be similar to what is done for VM auditing with
libvirt.

-- 
paul moore
www.paul-moore.com
