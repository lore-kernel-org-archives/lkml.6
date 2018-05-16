Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-117573-1526467716-2-12475823052597842968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526467716; b=gqQvMWpvQWLTjDYUXLsQV8q1tfLImi5YtaITC5C8kii6mhGAcU
    qkRMDNwKbhdAVI6lAZYStP8gdycFd4KLqHIuNe9Aez5oKzJ9lB7q9LIIUwDT2eZ4
    Yv36qFtTj3ZVKCiyaYkBV1VHErJKwFKnhNQ/TUP7fzk2kcWbUly8Npaxh5/5vCQE
    +ZH5cumb/HRR6ltpDGWAD9NoLH+gh+bGXm6dmtMfLqqrzr+zSg5DbdqVNCt1E6uh
    q+jmE3r/O1GDzJ6VClZHj1SMf0WGFXtZQ9jYvN5pz0tZCVLpX3KjTePLQy1j5bel
    YQTywVnG8tcTAkmnJoEZPEz09nQHgbASASSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526467716; bh=SOAxRuBwFablxCAcixm8TNKpHfE08r
    zd+kHRFeCkHHU=; b=H0A+GoNXRU+bXZK2nKLHjrvoBNsRu3VKV2AhmYllstUNNl
    SLaSLUv4Vc/i2fTAcoS5cTKVNRVtYmqIWmqPDHPfluooEHaPyK8Mrp5KIAiOvD8h
    VnxdNVfZtbkMZ0iMiHQNMvONuRw7q9Hg1N74XP2UWHtQ0u6N2o7oMTyH3J/62vSD
    OkfhIbshmCx08nIozmo8TB0poM2OieMFcGApRcVP2gRAMdvlYLM4Dp5YhCyYUTvq
    MwWoNMBHMDuohi2QQoFheHh5gPbqPvOQbTblVXawXmQLBUnE5ilmi0vYeY6QJGel
    A7LnEFyvQcHjvDxhx9HOk/i4Xv2L7rYuHNR9MuPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1VUb+t7l9/gwhiRwR7Epeza8OmL+VC2id5iRYmQ9DJFtlnzmwc+s8mXzwjeBFAweoefQXwu3CUrfFrT3uYGqZLGJ8754dFGH2sEYMVnvj8JXv29UN6
    RfUwEQ26++irlHSekDDcmgk8GgxSaj/CgCdzz1+0HmefKQ7601V+/ym+M3k+xchnHzx9MaXGIAUAyvMNmccIBKQrn28Ox/JmEPT9aCgIfP83p/PKRDdYKJwl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=a6y0wU7E81ELFF1aR-4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEPKse (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 06:48:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752172AbeEPKsd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 May 2018 06:48:33 -0400
Date: Wed, 16 May 2018 12:48:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180516104829.GA24332@redhat.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526420991-21213-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15, Waiman Long wrote:
>
> There are use cases where a rwsem can be acquired by one task, but
> released by another task. In thess cases, optimistic spinning may need
> to be disabled.  One example will be the filesystem freeze/thaw code

You do not read my emails ;)

Let me repeat once again that in this particular case the writer will
never spin because of owner == NULL. freeze_super() checks SB_UNFROZEN
under sb->s_umount and only then calls sb_wait_write(). IOW, sb_wait_write()
can only be called when this rwsem was already released by the previous
writer.

I am not arguing with this change, percpu_rwsem_release/acquire may have
another user sometime, but the changelog is not accurate.

> +static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
>  {
> -	return owner && owner != RWSEM_READER_OWNED;
> +	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
>  }

Perhaps you should add __attribute__(aligned) to struct rw_semaphore then...

I don't think it is really needed, but see the comment under struct address_space.

Oleg.
