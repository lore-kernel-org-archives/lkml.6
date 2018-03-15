Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521114661-2-4768149921974874331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521114660; b=uIFErQ/vB6agt5PXSFVHTOVM9es5ETOnX+gj5zQrrVnGH+r
    /Hf7K1ypxIEL6cz9spWrz0YBhO4pDMFKKsYnxGiQUuHs6+UG2f5SHvjx6OybBD3Y
    x886sfEe4azR9UZ2KMdts0BPfvdIJeC/cstPTAnF0BpGeNieT5XxL4ylzlecrhDZ
    I/XeeW+B8xRuxB0juYYnqu8YMySXlpOdN9w08ep/iZVhwUJBBdsCRYuJT4FJBtwY
    MjVeyrWotPMuBkAyzp2jcM8uwzih3YldzCspteYl2dixPisM4Uw6mFHQgvN9jjsP
    O42T9pzSmD7k6fxVH1d5ATsucx9S92uRqXrqmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521114660; bh=Qs4u2jUIuuzbiZ7S/frBHQFDBe
    JycxZluCHdYWk6Pzs=; b=Xlg4o68AvL9p0y2q0GOh/fJz5CzTcuzZYkVVhKesh/
    OOKslWdXo3pLIAZQY0G3SyjPro/C4s/TaOowZSupz0a/2ygC36YgphHN02jpaJg8
    njiez8NTgQwl2FXHCWW5zhBZAG7JCJ6NWG8L7R+UAwIaUCfXJhf83TJqJLm6YMGg
    w+rw36dN/6zk5AfhlKwY40Lmq9ZzFn2JPi1tSoOpvlYMows/NhJKkV+1AyH7DK0O
    +l1CWgfzRvLUzsEpykMIX+8E4exHsehUWZHQpaXaVKSRCtb73GkzLXGUCMacaPVW
    AYgsWgvQoPbxtLmWKPsMkk8chr9TTs1QOGEIPDM/1VoA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeCOLu6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOLu5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Mar 2018 07:50:57 -0400
Date: Thu, 15 Mar 2018 12:50:55 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
Message-ID: <20180315115055.GD23100@dhcp22.suse.cz>
References: <20180313224240.25295-1-neelx@redhat.com>
 <20180314141727.GE23100@dhcp22.suse.cz>
 <CACjP9X8u8Q2Jwp3CqYGJZhUdf0ivv4qGe+ZRB4A6+Z=z0vTLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACjP9X8u8Q2Jwp3CqYGJZhUdf0ivv4qGe+ZRB4A6+Z=z0vTLNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-03-18 02:30:41, Daniel Vacek wrote:
> On Wed, Mar 14, 2018 at 3:17 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 13-03-18 23:42:40, Daniel Vacek wrote:
> >> On some architectures (reported on arm64) commit 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> >> causes a boot hang. This patch fixes the hang making sure the alignment
> >> never steps back.
> >
> > I am sorry to be complaining again, but the code is so obscure that I
> 
> No worries, I'm glad for any review. Which code exactly you do find
> obscure? This patch or my former fix or the original commit
> introducing memblock_next_valid_pfn()? Coz I'd agree the original
> commit looks pretty obscure...

As mentioned in the other email, the whole going back and forth in the
same loop is just too ugly to live.

> > would _really_ appreciate some more information about what is going
> > on here. memblock_next_valid_pfn will most likely return a pfn within
> > the same memblock and the alignment will move it before the old pfn
> > which is not valid - so the block has some holes. Is that correct?
> 
> I do not understand what you mean by 'pfn within the same memblock'?

Sorry, I should have said in the same pageblock

> And by 'the block has some holes'?

memblock_next_valid_pfn clearly returns pfn which is within a pageblock
and that is why we do not initialize pages in the begining of the block
while move_freepages_block does really expect the full pageblock to be
initialized properly. That is the fundamental problem, right?

> memblock has types 'memory' (as usable memory) and 'reserved' (for
> unusable mem), if I understand correctly.

We might not have struct pages for invalid pfns. That really depends on
the memory mode. Sure sparse mem model will usually allocate struct
pages for whole memory sections but that is not universally true and
adding such a suble assumption is simply wrong.

I suspect you are making strong assumptions based on a very specific
implementation which might be not true in general. That was the feeling
I've had since the patch was proposed for the first time. This is such a
cluttered area that I am not really sure myself, thoug.
-- 
Michal Hocko
SUSE Labs
