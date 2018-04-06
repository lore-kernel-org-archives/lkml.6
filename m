Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1300574-1523019488-2-5071081881156941812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523019488; b=UKFsmuPlRfDH53PusOYyibNHsmf6qJxRACz4czy6wqDjSGoVAV
    rSMCjg2DK+UBSYxLsqthYfTvCFsPPvVl987SjpKoc6DmA4nLnmZnGwsXAPEz0sHS
    sV8ns+zE6ZWSLiejapCGVLVASX5tt8rHw2jf8Hsvxo2ex3n651qOcl0asgcmpnk4
    DojqaWTY2+mJZesrJy7T4NQcO0rTcKCf2F4rard2MNla74vr9PeT0x1VeCbwxI3t
    NJuOD9rITLrikJf+FcSLy4vsNHMX7d+rcFth6hI9xuj+0fDhIqbevbPZ1gebFjft
    OkZ0SdvQxgMoLJkxodDsl7+L7+Aze/aXISeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1523019488; bh=42cf9gXiXMiB2kkni0B79WX3BDcfx9
    gNBoW7emFfqfo=; b=VfNLHB8b7T+k8KWimr9KFhI+Da94bh9QCqszl06NMaRmCq
    xclJzZKdFVKK1/ZJSg+hHDCHCP6nHc4kdVVeh1071YuLqyRU0F7LForK6X9aHCHf
    lg91X6kvwxw3rubfQxfuJUPHljHaUz9oRfPEVnn6ZA+z42P771Iw4TdZgcnA2ei2
    y2UdIFI+nZj433BhMW9YGfXBzTznzX/SAYAsIP0L6qPZwuAl61EGoWgnQq6CN4hl
    dbx/ENu7Jrg9c1VQOrvQlli5Fl69uigYOAqeCr75QWkVprTJBOhi0/PNpzXacxeN
    nU6nxRg4ptUVrPDVjJXRORA69dzzAiUEQ6XjW5Bw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOeMGtGw/SDODRGOyZQtw/4nzLosw0hAfwC09PB/QZXKv9LwAgJq0ymYpfIfz7GMVTad5KuwtNhJ+MgI7qbepN6CsTfVf1RqATz5dQ+rJW7dTWAWmZYC
    nmc3nXR+zBHA1zYzf/baBXAW5J0K4MUbKMFu/ePTEjTqT3JP9H/DGv4eAazZrktcUPJ768GiLY3wMRh6FjWg9A7lJPnaEV1vUbHacJw3HmGUxAQen8v38Vzq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VXupakhlX4N-QbAYGf4A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeDFM6C (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 08:58:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752128AbeDFM6A (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Apr 2018 08:58:00 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: io_pgetevents & aio fsync V2
References: <20180328072639.16885-1-hch@lst.de>
        <20180406031630.GU30522@ZenIV.linux.org.uk>
        <20180406062700.GA20714@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Fri, 06 Apr 2018 08:57:59 -0400
In-Reply-To: <20180406062700.GA20714@lst.de> (Christoph Hellwig's message of
        "Fri, 6 Apr 2018 08:27:00 +0200")
Message-ID: <x497epklcfc.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Fri, Apr 06, 2018 at 04:16:30AM +0100, Al Viro wrote:
>> BTW, this is only tangentially related, but... does *anything* call
>> io_submit() for huge amounts of iocb?

I don't know.  If an application did that, as many I/Os as could fit
into the ring buffer would be submitted, and that's what gets returned
from the system call (the number of submitted iocbs).

>> Check in do_io_submit() is insane - "no more than MAX_LONG total of
>> _pointers_".  Compat variant goes for "no more than a page worth of
>> pointers" and there's a hard limit in ioctx_alloc() - we can't ever
>> get more than 8M slots in ring buffer...
>
> Logical upper bound for io_submit is nr_events passed to io_setup(),
> which is bound by aio_max_nr.  Except that we never actually check
> against nr_events (or max_reqs as it is known in kernel) in io_submit.
> Sigh..

io_submit_one calls aio_get_req which calls get_reqs_available, which is
what does the checking for an available ring buffer entry.

-Jeff
