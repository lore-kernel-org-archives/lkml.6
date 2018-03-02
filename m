Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2835548-1520033963-2-7921250441455963973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520033963; b=U1l9pltY5YkEQ/icwx3Lpii+iB3Dx0wCgMI0OJ8emJifxig
    eENkgwlkVvlqTxHzoUbxAoURgcK3eQSZlsSRRJElih0g537Wpn63JqY/BPU6E1Ko
    Y7GCuuqNHCbXmd+PKxA47zi4+UAc6nRJ0NVL+/FHGOMOXCOvEUO1wZMOP/3hxoKo
    lLUMWe0mLQi29rM06I3ozBq4De2emxvTCBR5CjF6fRd7HLgJk1DbpGFvSAYdjm02
    f0B9Rpz1xCvaEq1T1oXzTyGH3TYHDKHb5rlHzzp91Q60eJmkp8SogddVm/geqPVb
    jXzJk5+B60mssix6POQRe3w1VaUfRbjYDJZYRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520033963; bh=edT/FAXM/ooHsfWGCmKU8sWibIcGjcWxtDsfvr85a54=; b=t
    BR4HaVCwe1Y3eGgVNuRLxk2yIyan1La/wiFgqOxhRv5Jvl34H30TS7YsGnvrGMdm
    ZZibpZQT8RMAYMe7yND9wWYR0AGYpPFyYK9wkenVM14v/t9oS+8rgvp6erYD3UOE
    aFxy8hGw33+e6bi9dHlRG8nRC5pAmInYGNUI/Gdv7Ii8keW5JCxZAVLnqwxmokwQ
    Vf7sUcJ+dkCtIi3zOHDNl4zG+avSKMlD9lF4u9Ne7qN9cNpBKvuwyhjxUjfucj9e
    6btyLsm5kgyfqGcjx3JqMs+lwNgP2LIqPRzRXD9I9UxHDdLwd+AQT+TRH7ofOMBu
    pdVVhy7FoZDAfreHb03Sw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeCBXix (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 18:38:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934410AbeCBXiv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 18:38:51 -0500
Date: Fri, 2 Mar 2018 15:38:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>
Subject: Re: [PATCH 0/3] userfaultfd: non-cooperative: syncronous events
Message-Id: <20180302153849.d9d7b9a873755c6f5e883d0d@linux-foundation.org>
In-Reply-To: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Feb 2018 10:19:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Hi,
> 
> These patches add ability to generate userfaultfd events so that their
> processing will be synchronized with the non-cooperative thread that caused
> the event.
> 
> In the non-cooperative case userfaultfd resumes execution of the thread
> that caused an event when the notification is read() by the uffd monitor.
> In some cases, like, for example, madvise(MADV_REMOVE), it might be
> desirable to keep the thread that caused the event suspended until the
> uffd monitor had the event handled to avoid races between the thread that
> caused the and userfaultfd ioctls.
> 
> Theses patches extend the userfaultfd API with an implementation of
> UFFD_EVENT_REMOVE_SYNC that allows to keep the thread that triggered
> UFFD_EVENT_REMOVE until the uffd monitor would not wake it explicitly.

"might be desirable" is a bit weak.  It might not be desirable, too ;)

_Is_ it desirable?  What are the use-cases and what is the end-user
benefit?
