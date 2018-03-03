Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2979411-1520039325-2-18389595482548604437
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
    t=1520039325; b=XSdPjGhVJm5AeRoLNnkYKpSX2sy2UOhV0pioWJFY9YdsxzO
    +XPXoEQtVJDYSqoVe9Cly3NYA4l+h7UcxJVWH+C+Myn9AHR2vCvlbwEAaJcAaYJT
    j7blbX1Igqmha+3+ufP1gUzSLqMbPGd0XbAG0XteyaKHu83R18DomcyoUgiVtcSk
    3IiRC7PqhH200Tv5/DvnhGq/ghJfLQcPkR6Aa1gV8hhIleCgJh7Ke0v7XmwiXXBn
    G1tKlNsjLcWLeNYKh3j9VYRXVp+VksxY76Y1LsrKEwga8m+M+3z949Lhhs05dTBm
    p9ZdPhuOX47Zi0BDiJiV2PVTsdo4g1wWuYlLUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520039325; bh=5FXEUIoeAptTEPlLFGYH0xmVapBEQGM0grE8zn
    ow6hQ=; b=niR7d7tbJBrKEn4xbX8UOMC0LNawikcKBR+eaVjFYXUqqY9dFK7e8+
    u+JXnQlWYEfFkyngNz6eSqBsOvDKAq05bJDT7pk+WVNTq55FKwbf4+Ww7/Njr3Rh
    gFklUdc/axY92P+rHHEl5pB3UTB/0ion+bLEfvdmWUEUKB+l5nEb4R34pNugUBR8
    K/H9o07YB5e2m+KctNkkgj+K0yxZ4nuHLoJGdRzRQ8SB6VsBfcyzGedvwitEREqd
    YMmqAOTp0SlH2hkpf/+qoGucYNljozytHa1PyZbwXF/Xu+uJ0J956BLRO1d0s4TU
    tiRy98WNr2Sxx+R8adFYrdPodhobQIkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KAfaDODe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KAfaDODe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964804AbeCCBI3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 20:08:29 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46683 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935602AbeCCBI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 20:08:28 -0500
X-Google-Smtp-Source: AG47ELuBy66gNZZp8Zivpsx14hEVYMzAQ/VprK61HdVazBIbkReIy3APIJfSPSzvz3UKB+bNhmZEeNaG1pfh1spklds=
MIME-Version: 1.0
In-Reply-To: <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com> <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
From: Daniel Vacek <neelx@redhat.com>
Date: Sat, 3 Mar 2018 02:08:27 +0100
Message-ID: <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
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

On Sat, Mar 3, 2018 at 1:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat,  3 Mar 2018 01:12:26 +0100 Daniel Vacek <neelx@redhat.com> wrote:
>
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") introduced a bug where move_freepages() triggers a
>> VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
>
> b92df1de5d28 was merged a year ago.  Can you suggest why this hasn't
> been reported before now?

Yeah. I was surprised myself I couldn't find a fix to backport to
RHEL. But actually customers started to report this as soon as 7.4
(where b92df1de5d28 was merged in RHEL) was released. I remember
reports from September/October-ish times. It's not easily reproduced
and happens on a handful of machines only. I guess that's why. But
that does not make it less serious, I think.

Though there actually is a report here:
https://bugzilla.kernel.org/show_bug.cgi?id=196443

And there are reports for Fedora from July:
https://bugzilla.redhat.com/show_bug.cgi?id=1473242
and CentOS: https://bugs.centos.org/view.php?id=13964
and we internally track several dozens reports for RHEL bug
https://bugzilla.redhat.com/show_bug.cgi?id=1525121

Enough? ;-)

> This makes me wonder whether a -stable backport is really needed...

For some machines it definitely is. Won't hurt either, IMHO.

--nX
