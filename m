Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-444702-1521125621-2-10067932361693022496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1521125620; b=bExJAWZxYn8m8XnJ8+D2EFJwD8BvkUyu7HZCQmaC2wuQ492
    FOp/T/e6YfcHelctZuAKDYCEwvK8w60XZeZWK1w1UWyCNXiFBNNBYsP4276/rY/a
    X8EWqK90dy3l+qp7Wda7ryQHKffnZ6OLhhpdaLVkej/6qwzuQnUqmztV4CdlY5Mb
    wftCtNchdH++eP+df1S3CrUc6pxx48U3v9J90zJQRJeln+Mml2sXlChmTvwK8uCZ
    GHF+H9VBKbldBCkMD1D85PY6FOvor05xAMw3GIySKS4uwCJFqqoV65Vfo7V3Olq/
    OmifXhlXyM2kiARpOxFSGMoSKEM/n0/8FbkWT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521125620; bh=C054gAVi7xHyWvy2LAB8Icqn9EuQ0x7rw3M9b3
    fHUQM=; b=QQcDA12O9p3wZTeR6BBROVMHq+UuYphtSgdZrcd+6Vk/XuNJRqZUvS
    YlcBPoeQEuEoAOLvwIwphZx9lqNZ65AbWWkkPS54ngIRUQ/rOfafGwF8orkF0Q1T
    FXPdjpIoAuaLUSeX4elPhPLFPWRqAk/9u2UPje2hWglDL2IJDP2dV+n8dYtZWnUD
    mmwmGjZE+2Y0XiYctO+u2SYqjSFQ+4BYhTut4i/8wgamLfTZ+PpovC9yKwndXQCR
    XPH2f89zDlLcnpP/RjBZ+9iDP588pcouVHudiJoVpeQ5Ei/Bo3vqfDbbeyNPZHMM
    SOCdDoJWMbBwjgGaL/V779ISZdSQkaCA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lu/sPJvw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lu/sPJvw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeCOOxZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:53:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36983 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeCOOxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 10:53:23 -0400
X-Google-Smtp-Source: AG47ELth+fWZWFZd5dN5Ck59ne2mNye8ZQu5hmAB9S5bPwUhCmcVBu60fZtbzVcaQcH5NVLymQQpd/CmtkCawiSfaIg=
MIME-Version: 1.0
In-Reply-To: <20180315115055.GD23100@dhcp22.suse.cz>
References: <20180313224240.25295-1-neelx@redhat.com> <20180314141727.GE23100@dhcp22.suse.cz>
 <CACjP9X8u8Q2Jwp3CqYGJZhUdf0ivv4qGe+ZRB4A6+Z=z0vTLNQ@mail.gmail.com> <20180315115055.GD23100@dhcp22.suse.cz>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 15 Mar 2018 15:53:22 +0100
Message-ID: <CACjP9X8xXMXwbku7yvpGV72XGZ2ZeAcEi4vtFVe_rf9+QZ19XA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
To: Michal Hocko <mhocko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:50 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 15-03-18 02:30:41, Daniel Vacek wrote:
>> On Wed, Mar 14, 2018 at 3:17 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Tue 13-03-18 23:42:40, Daniel Vacek wrote:
>> >> On some architectures (reported on arm64) commit 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
>> >> causes a boot hang. This patch fixes the hang making sure the alignment
>> >> never steps back.
>> >
>> > I am sorry to be complaining again, but the code is so obscure that I
>>
>> No worries, I'm glad for any review. Which code exactly you do find
>> obscure? This patch or my former fix or the original commit
>> introducing memblock_next_valid_pfn()? Coz I'd agree the original
>> commit looks pretty obscure...
>
> As mentioned in the other email, the whole going back and forth in the
> same loop is just too ugly to live.

It's not really supposed to go back, but I guess you understand.

>> > would _really_ appreciate some more information about what is going
>> > on here. memblock_next_valid_pfn will most likely return a pfn within
>> > the same memblock and the alignment will move it before the old pfn
>> > which is not valid - so the block has some holes. Is that correct?
>>
>> I do not understand what you mean by 'pfn within the same memblock'?
>
> Sorry, I should have said in the same pageblock
>
>> And by 'the block has some holes'?
>
> memblock_next_valid_pfn clearly returns pfn which is within a pageblock
> and that is why we do not initialize pages in the begining of the block
> while move_freepages_block does really expect the full pageblock to be
> initialized properly. That is the fundamental problem, right?

Yes, that's correct.

>> memblock has types 'memory' (as usable memory) and 'reserved' (for
>> unusable mem), if I understand correctly.
>
> We might not have struct pages for invalid pfns. That really depends on
> the memory mode. Sure sparse mem model will usually allocate struct
> pages for whole memory sections but that is not universally true and
> adding such a suble assumption is simply wrong.

This is gray area for me. But if I understand correctly this
assumption comes from the code. It was already there and got broken
hence I was trying to keep it. If anything needs redesigning I'm all
for it. But I was just calming the fire here. I only didn't test on
arm, which seems to be the only one different.

> I suspect you are making strong assumptions based on a very specific
> implementation which might be not true in general. That was the feeling
> I've had since the patch was proposed for the first time. This is such a
> cluttered area that I am not really sure myself, thoug.

I understand. And again this is likely correct. I'll be glad for any
assistance here. My limited knowledge is the primary cause for lack of
relevant details I guess. What I checked looks like pfn_valid is a
generic function used by all arches but arm, which seems to be the
only one to implement CONFIG_HAVE_ARCH_PFN_VALID if I didn't miss
anything. So if this config is enabled on arm, it uses it's own
version of pfn_valid(). If not, I'd expect all arches behave the same.
That's where my assumption comes from.

> --
> Michal Hocko
> SUSE Labs
