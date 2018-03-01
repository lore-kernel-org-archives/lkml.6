Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3262611-1519918177-2-6748842856473841604
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
    t=1519918176; b=Bv4jbN78iInSgsWb1eW0AR3C9GXPgLmsqrcouUjK18H58vm
    Mg3700mvVCB85k2v4vagj+e+gpsQRqjLpcSJx28QVnXaF2whXYr5RKv/40m75U4E
    o1E3rDkKLEFpIOgYm/C5PxVUOHjMOgQHLzNkuq3b45lmpNOP8qROXjxTSGic7/dp
    9dQbhdSJCed46d7oS1osRpTk0fzO2JWJxbyt49TRDwShK8qaynNMy8Cle5EXnFv8
    vuiFjQo/9dMeF036A9rnQw2Pn5fv0zo80Xbxs16EqJb7zyl+4tEupB/R4p62WG3e
    t7rdGKR3Xfl8pOssltKc+2eVouy9MIbLEgltZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519918176; bh=83Lgn/9WlYEvUmIaqMttycgVtf
    fJu+MoKyq5PgBbLkg=; b=dXDh5CS3sYtNlcCGUJ7+pqqfxRmnG2yxJhF2qeZxN4
    br/GGVGs7O5D8ospIeFpk0F/iI/edltmA65x7XGoQCeL6kAghZL5tHW0nOWn83Wl
    ndWhExj3qt9R0NuzYRUeOin24IitM0SqetK5KbnrRkZeJzHrrBY1NcLnqtKIRkJ8
    qyiqstfTyzLNPsen5codKKL/yIIGXPEmcvIEtkzsEiwawusJXGfOJmSoNIp1Yodt
    cYb6jFs9+c5Z59bqSFFYjH3rFnk3fqw9HgxaBsMAiivAgOI002E2mFWrTnLi7Db0
    eQmdZfgf8cJIdo/5K8qFNXSuTPdEGXZ1cyAVWxUKe9Yg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032184AbeCAP2v (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 10:28:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40309 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031984AbeCAP1b (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 10:27:31 -0500
Date: Thu, 1 Mar 2018 16:27:29 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
Message-ID: <20180301152729.GM15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz>
 <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 01-03-18 16:09:35, Daniel Vacek wrote:
[...]
> $ grep 7b7ff000 /proc/iomem
> 7b7ff000-7b7fffff : System RAM
[...]
> After commit b92df1de5d28 machine eventually crashes with:
> 
> BUG at mm/page_alloc.c:1913
> 
> >         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

This is an important information that should be in the changelog.

> >From registers and stack I digged start_page points to
> ffffe31d01ed8000 (note that this is
> page ffffe31d01edffc0 aligned to pageblock) and I can see this in memory dump:
> 
> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
> 7b800000 7ffff000 80000000
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffe31d01e00000  78000000                0        0  0 0
> ffffe31d01ed7fc0  7b5ff000                0        0  0 0
> ffffe31d01ed8000  7b600000                0        0  0 0    <<<< note

Are those ranges covered by the System RAM as well?

> that nodeid and zonenr are encoded in top bits of page flags which are
> not initialized here, hence the crash :-(
> ffffe31d01edff80  7b7fe000                0        0  0 0
> ffffe31d01edffc0  7b7ff000                0        0  1 1fffff00000000
> ffffe31d01ee0000  7b800000                0        0  1 1fffff00000000
> ffffe31d01ffffc0  7ffff000                0        0  1 1fffff00000000

It is still not clear why not to do the alignment in
memblock_next_valid_pfn rahter than its caller.
-- 
Michal Hocko
SUSE Labs
