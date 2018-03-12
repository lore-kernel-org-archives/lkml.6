Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-315511-1520857621-2-8699584148026228466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520857620; b=rYDtPEIMr2iK+PF+WqEQ/0P/7u1mp0cY3NhVjI9qHmcgkl6
    W2ifzTsq2LmjgvcTYYNzgBdy0trB3uThQ490fBMUvz4OJUwh47sAIXtKhpjJ0R2J
    K9Hsp0rDEcPgwGO66y6Tf+FSiXCLQ5fg312RT3UXCefDXlYOGIUzv0YtT9SvGUNl
    Ttjxy5KVK2Egct6ki2Yzdu3A1vKyv/+i1G0lUsjYDDnMO5bp2peCta9PKH0L6yxf
    J45ZTlfoygMmfqDhj2o4x+o4bcuNy6EiVExvTTgGgAnDOghWdGhyxjnORn7bJACu
    VvDP1KWCFiRE/ErLUmpPKqdRD3BzYEsM97bp2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520857620; bh=918F79RLMuLI2TuaViLFArHBgDz+JHJrLMsja2
    W1KI4=; b=WGzdUmktAjOfHy1rOTThbUhwET3saTkZ9inS4xg7vtmmP5gJ5lRiIJ
    3oDy3TPYvkGj0BIkcOBZ+vhVwIu2XYGklo+JhfOVAUf3nSDBmFnlBt7m6hJuuSnY
    YBW73FeiG5zGPdc3ZeQEjwiVLidTp5I3oBu891Sdu/izIepZMWBeSIUy8vAR/RZO
    3EHaooT+dgYkfr8azKky7vpVNG4omjHNCjPB/5tGs9Xm5ifyyQZ5yepQhtzlHzGS
    K6y2Pao8zLUSJkm76dRnC+l+LSbCfvMSoanIdPODVkdwAA9ZoghPtE2JajPTjyPS
    h6vSPOXm8NqJYvLHbYPHI2UaHZpnFN0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JCaDN2R3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6w199AZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JCaDN2R3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6w199AZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeCLM07 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 08:26:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38581 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbeCLM05 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 08:26:57 -0400
X-Google-Smtp-Source: AG47ELtgiwePRNXFDuEZGnXLufMy4PgVSiFzIbNJS2cVvbwVnUuNAEV+TgcBqAXs6eRG/Q0/cd8oepSMAw38Qh6JiqA=
MIME-Version: 1.0
In-Reply-To: <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com> <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org> <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 12 Mar 2018 12:26:56 +0000
X-Google-Sender-Auth: 2vd7CMveUFQ6z_Ut_Es_SGY8QNA
Message-ID: <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Daniel Vacek <neelx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I couldn't find the exact mail corresponding to the patch merged in v4.16-rc5
but commit 864b75f9d6b01 "mm/page_alloc: fix memmap_init_zone
pageblock alignment"
cause boot hang on my ARM64 platform.

Log:
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000000000000-0x00000009ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x9fffcb480-0x9fffccf7f]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000f8f9afff]
[    0.000000]   node   0: [mem 0x00000000f8f9b000-0x00000000f908ffff]
[    0.000000]   node   0: [mem 0x00000000f9090000-0x00000000f914ffff]
[    0.000000]   node   0: [mem 0x00000000f9150000-0x00000000f920ffff]
[    0.000000]   node   0: [mem 0x00000000f9210000-0x00000000f922ffff]
[    0.000000]   node   0: [mem 0x00000000f9230000-0x00000000f95bffff]
[    0.000000]   node   0: [mem 0x00000000f95c0000-0x00000000fe58ffff]
[    0.000000]   node   0: [mem 0x00000000fe590000-0x00000000fe5cffff]
[    0.000000]   node   0: [mem 0x00000000fe5d0000-0x00000000fe5dffff]
[    0.000000]   node   0: [mem 0x00000000fe5e0000-0x00000000fe62ffff]
[    0.000000]   node   0: [mem 0x00000000fe630000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000]  Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]

On Sat, Mar 3, 2018 at 1:08 AM, Daniel Vacek <neelx@redhat.com> wrote:
> On Sat, Mar 3, 2018 at 1:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Sat,  3 Mar 2018 01:12:26 +0100 Daniel Vacek <neelx@redhat.com> wrote:
>>
>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>> where possible") introduced a bug where move_freepages() triggers a
>>> VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
>>
>> b92df1de5d28 was merged a year ago.  Can you suggest why this hasn't
>> been reported before now?
>
> Yeah. I was surprised myself I couldn't find a fix to backport to
> RHEL. But actually customers started to report this as soon as 7.4
> (where b92df1de5d28 was merged in RHEL) was released. I remember
> reports from September/October-ish times. It's not easily reproduced
> and happens on a handful of machines only. I guess that's why. But
> that does not make it less serious, I think.
>
> Though there actually is a report here:
> https://bugzilla.kernel.org/show_bug.cgi?id=196443
>
> And there are reports for Fedora from July:
> https://bugzilla.redhat.com/show_bug.cgi?id=1473242
> and CentOS: https://bugs.centos.org/view.php?id=13964
> and we internally track several dozens reports for RHEL bug
> https://bugzilla.redhat.com/show_bug.cgi?id=1525121
>
> Enough? ;-)
>
>> This makes me wonder whether a -stable backport is really needed...
>
> For some machines it definitely is. Won't hurt either, IMHO.
>
> --nX
