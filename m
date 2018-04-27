Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599407-1524854509-2-2925290798383036811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524854509; b=UNzlqi4zjx8+IpIi7wb4V5SpOJnrTzxlbYIAhkZkvkGC5Ea0R3
    C7MlapA5w3BnP0s7DALvYlnubweThed/10X1bXTknr6OZ8ekLII+XEuEu2HQn1E8
    a3XdXxKON+N5IZH71dOFnsiLJtlvXtC/TwLZ0q+rtx3z44fzv7B0KrywhyvY63+y
    jSTULI5R5PyyaX24vGdd2g5uhrOvVwCHSw2/1kTLeQJhc7f/IUusD6Ser+hY0rSx
    T84KhvXVoVj/bHMAK943KtPiYboK7TNgdeCLCWTFRc61pD1cqUsjPNh3K4VaAviR
    4O2kTq/MqcFq6hpVihKB3z9sS4sYcFn2cf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524854509; bh=5Lc5cbf6XMhL6OIcSzzA9FQtGnmsWDgYMH22Sx0
    2Lro=; b=DDcc0Ui9X8M+3E3JJwVKYPWPlIVpveLfylmfVzH5Mn4gyNqN7K+2vmi
    2oGzzGKDGWPq3IVwMmrl0vZ8Y7MeRnbPddJkj9DKoMkxIC9v9UfXS3dehmvYVodG
    fbrO2aQgZCETRH/AX4VhGKf9wf44FnS3B+pFBAScgUJ/RCFYXZAsFsBxHtlFNEl4
    BKffrlH9k/SxH5bVFeJI5Pi4OPVH/5YgkY90o5OY2eT3pPO7H7y5H68qluNc6I0n
    iKr8/vBCkbCQucg6kVxPTtuItfDSPifzf9Q/tet7vtro5EYxW8N80GCp0IUg0vpU
    PCLvdKxVAQTq8i3+JEkbVaC9yjXl8FA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=GCSfxpiw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bCuUdrTX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=GCSfxpiw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bCuUdrTX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCfrD37wqIc5i5DlKLWz+RfSOZmitpcKosuxjLwnwf637bDz9MTv+Hta/fKo8VkcSGoNVPSNaiIug0B4zWC5ooobWi1rqsiI0UIZO1ERUuSl3W45fDqs
    XhX2MSrSGR6MORuQl/zMSFVcElnyPLiJuSPVJB5zUEUNk6GkR7L9QMR/eb4VTFsVab5I8VMYdqdlvVGDxlxRW6guUwMqAvXF9OBqURkMQOgxUEivI9qvslY1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=DlhfFjQbOAXFGfRae5UA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758175AbeD0Sle (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:41:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33403 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758159AbeD0Sld (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Apr 2018 14:41:33 -0400
X-Google-Smtp-Source: AB8JxZq283ATM1bNC4+lULLFiaLw/+wlAG743mpN+65eakqcqjxc0DxZSYzXF5PxxsjLFMX1PqPy8A==
Date: Fri, 27 Apr 2018 11:41:31 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Vlastimil Babka <vbabka@suse.cz>
cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in
 /proc/vmstat
In-Reply-To: <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
Message-ID: <alpine.DEB.2.21.1804271139500.152082@chino.kir.corp.google.com>
References: <20180425191422.9159-1-guro@fb.com> <20180426200331.GZ17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804261453460.238822@chino.kir.corp.google.com> <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018, Vlastimil Babka wrote:

> It was in the original thread, see e.g.
> <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
> 
> However it will take some time to get that in mainline, and meanwhile
> the current implementation does prevent a DOS. So I doubt it can be
> fully reverted - as a compromise I just didn't want the counter to
> become ABI. TBH though, other people at LSF/MM didn't seem concerned
> that /proc/vmstat is an ABI that we can't change (i.e. counters have
> been presumably removed in the past already).
> 

What prevents this from being a simple atomic_t that gets added to in 
__d_alloc(), subtracted from in __d_free_external_name(), and read in 
si_mem_available() and __vm_enough_memory()?
