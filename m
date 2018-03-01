Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3432009-1519925063-2-1563641248795736412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519925063; b=Bw8dOmMARsMdzOA6yFxoS3q88Vra8abD9hqlQv4lZdX4a72
    JeBcNGwQNsijaPh0uZ78vQS2D1c82ln8UPZJw+CPhzYp4WsmfKndx6M4T2P/dDiU
    /D8JtAMc1jGk92uauqwRjP4ogzweNZGfZbtJYW3azFiN+3tmJrPZVDYMQjZfwJIs
    LuGOHBt6XG9vBWJ7Xqc267Nt5eMWHOkMyuc+hlV8INUVwUOB+CQL4lv1l4iJd5hh
    nVGiBSWHA5p+Ro5JQ09WN7wsV25mZZWti/Z8PY1uiOEM0u/PJLBw6eerBPElQ8/1
    Uxi4NIoZm5b0h7Xgpm5db+7QPSs4khXnbaHHL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519925063; bh=7jHuQMqMc8CvxyK+Teu40fmLM4SxkYsKbVJ2JT
    M0sGA=; b=p9WMuXDQpEyQb33nAVJKVgntPzZi/gb2ZiDuxGq8syTd+MByUBel9i
    OKqGg6RLBCczhoDb5rRv3oAspV12N8301q8WCPG81zprDuT/hY9ocRuUqQ5hmwB0
    8WtxKu81l9kXiErCZja1QLWPSZ/4oyH8utuWSkZPgHNMTR2dI7UaHdgb6n8QH0M6
    fh1eHzGDSZOpiXgqIwLF15yQ/S5j1LbzKxKnncOsTzTzFplr62j73IuDIqjaEiNY
    wvPe+JW5tpBi2pogRtxLmDxl8gPj/lMG9DaR/VrKOWOS9iyl3VYBj2mpmRpwxkOr
    4ZgXnDcsvNXSOx1gns2PCgiFcJZBBS/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HlX1ceW5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HlX1ceW5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033341AbeCARYU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 12:24:20 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38857 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033238AbeCARYT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 12:24:19 -0500
X-Google-Smtp-Source: AG47ELvIMw8OjLSR0iwoUXSj83dRNGwFbM52SIoOQzrj0uQNcOyXXC+uY8GRY8mO5TNOkyMNgFETTSfnHTFUuj+RRAI=
MIME-Version: 1.0
In-Reply-To: <20180301152729.GM15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz> <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
 <20180301152729.GM15057@dhcp22.suse.cz>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 1 Mar 2018 18:24:17 +0100
Message-ID: <CACjP9X9E4d-ew9ZaHzhy2+R6DumYSny2_sRqoQa-n6cOZU3Y1w@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 4:27 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-03-18 16:09:35, Daniel Vacek wrote:
>> From registers and stack I digged start_page points to
>> ffffe31d01ed8000 (note that this is
>> page ffffe31d01edffc0 aligned to pageblock) and I can see this in memory dump:
>>
>> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
>> 7b800000 7ffff000 80000000
>>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ffffe31d01e00000  78000000                0        0  0 0
>> ffffe31d01ed7fc0  7b5ff000                0        0  0 0
>> ffffe31d01ed8000  7b600000                0        0  0 0    <<<< note
>
> Are those ranges covered by the System RAM as well?

Sorry I forgot to answer this. If they were, the loop won't be
skipping them, right? But it really does not matter here, kernel needs
(some) page structures initialized anyways. And I do not feel
comfortable with removing the VM_BUG_ON(). The initialization is what
changed with commit b92df1de5d28, hence fixing this.

--nX

>> that nodeid and zonenr are encoded in top bits of page flags which are
>> not initialized here, hence the crash :-(
>> ffffe31d01edff80  7b7fe000                0        0  0 0
>> ffffe31d01edffc0  7b7ff000                0        0  1 1fffff00000000
>> ffffe31d01ee0000  7b800000                0        0  1 1fffff00000000
>> ffffe31d01ffffc0  7ffff000                0        0  1 1fffff00000000
>
> It is still not clear why not to do the alignment in
> memblock_next_valid_pfn rahter than its caller.
> --
> Michal Hocko
> SUSE Labs
