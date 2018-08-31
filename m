Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D41FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC69E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeHaQfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:35:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33037 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so11071844wrc.0;
        Fri, 31 Aug 2018 05:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nb0sSpJawUV5K6BUvKBAn3n65py4ir9SU4ZhAxs7UI0=;
        b=OnMeZRKi03hx2lSWl9XelXlonN+HG6psiIhm/+kg2ssTbbT0FqPOJs4PiIP1a1VsW1
         tEwWdN01roRqzSTjGp7+LIn+FswOkigjICv2nYapVKD592ukVx9dO3aRCMx4sETCsykF
         65WMzrHAWV4WebDqmNH6c2wcC0KVXVnEf2RdptMkFRUR0syeWUwwfotuRhVx+7j2/pyM
         ErUGpMpdpRgj/E5rNER181JfvN5laldTw/RsDSg2AFkpOX2msJj4M4stbhyHH54z1Yfs
         ujhmdL/gW6tP7ZtQixFY9Iv+Fo1f/TJeRsX39n5ddbK5ee8V89eTadaRBufh2X517OkR
         Q30w==
X-Gm-Message-State: APzg51A+InKJC1zplD4hbsti+G6rvyyCgRg0KD+L6ZRUXQa1Pp+vH7Xz
        /iWC7e2pYJ4nI2JNDMra53c=
X-Google-Smtp-Source: ANB0VdZ6Mu1KTtEpnDQsX/jBied5V9W/fehnrJ5PnLhkl0L6YmrcYaXCnSoQdA0W8FpEM+A3jSBwIg==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr11318590wrg.203.1535718511937;
        Fri, 31 Aug 2018 05:28:31 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id h206-v6sm1447658wmf.25.2018.08.31.05.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:28:31 -0700 (PDT)
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
 <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
 <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
 <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
 <7aee9274-9e8e-4a40-a9e5-3c9ef28511b7@microsoft.com>
 <87516e50-a17c-6c80-e9b5-ba68eda9ce33@microsoft.com>
 <597f3f35-6aad-6ca1-ba03-b93444b1cb5f@suse.cz>
 <0acf1c74-1bd3-e425-f92b-5d084ff954a4@suse.cz>
 <5070bde7-d20e-a464-a566-e97a13264b94@microsoft.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <31c12066-ae77-6a86-6238-2a55bde4f8e4@suse.cz>
Date:   Fri, 31 Aug 2018 14:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5070bde7-d20e-a464-a566-e97a13264b94@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018, 02:10 PM, Pasha Tatashin wrote:
> Thanks Jiri, I am now able to reproduce it with your new config.
> 
> I have tried yesterday to enable sparsemem and deferred_struct_init on
> x86_32, and that kernel booted fine, there must be something else in
> your config that helps to trigger this problem. I am studying it now.
> 
> [    0.051245] Initializing CPU#0
> [    0.051682] Initializing HighMem for node 0 (000367fe:0007ffe0)
> [    0.067499] BUG: unable to handle kernel NULL pointer dereference at
> 00000028
> [    0.068452] *pdpt = 0000000000000000 *pde = f000ff53f000ff53
> [    0.069105] Oops: 0000 [#1] PREEMPT SMP PTI
> [    0.069595] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.19.0-rc1-pae_pt_jiri #1
> [    0.070382] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.11.0-20171110_100015-anatol 04/01/2014
> [    0.071545] EIP: free_unref_page_prepare.part.70+0x2c/0x50
> [    0.072178] Code: 19 e9 ff 89 d1 55 c1 ea 11 c1 e9 07 8b 14 d5 44 52
> fd d6 81 e1 fc 03 00 00 89 e5 56 53 89 cb be 1d 00 00 00 c1 eb 05 83 e1
> 1f <8b> 14 9a 29 ce 89 f1 d3 ea 83 e2 07 89 50 10 b8 01 00 00 00 5b 5e
> [    0.074296] EAX: f4cfa000 EBX: 0000000a ECX: 00000010 EDX: 00000000
> [    0.075005] ESI: 0000001d EDI: 0007ffe0 EBP: d6d41ed0 ESP: d6d41ec8
> [    0.075714] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210002
> [    0.076508] CR0: 80050033 CR2: 00000028 CR3: 16f20000 CR4: 000406b0
> [    0.077242] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    0.077934] DR6: fffe0ff0 DR7: 00000400
> [    0.078380] Call Trace:
> [    0.078670]  free_unref_page+0x3a/0x90
> [    0.079136]  __free_pages+0x25/0x30
> [    0.079533]  free_highmem_page+0x1e/0x50
> [    0.079978]  add_highpages_with_active_regions+0xd1/0x11f
> [    0.080592]  set_highmem_pages_init+0x67/0x7d
> [    0.081076]  mem_init+0x30/0x1fc

page_to_pfn(pfn_to_page(pfn)) != pfn with my .config on pfns >= 0x60000:

[    0.157667] add_highpages_with_active_regions: pfn=5fffb pg=f55f9f4c
pfn(pg(pfn)=5fffb sec=2
[    0.159231] add_highpages_with_active_regions: pfn=5fffc pg=f55f9f70
pfn(pg(pfn)=5fffc sec=2
[    0.161020] add_highpages_with_active_regions: pfn=5fffd pg=f55f9f94
pfn(pg(pfn)=5fffd sec=2
[    0.163149] add_highpages_with_active_regions: pfn=5fffe pg=f55f9fb8
pfn(pg(pfn)=5fffe sec=2
[    0.165204] add_highpages_with_active_regions: pfn=5ffff pg=f55f9fdc
pfn(pg(pfn)=5ffff sec=2
[    0.167216] add_highpages_with_active_regions: pfn=60000 pg=f4cfa000
pfn(pg(pfn)=c716a800 sec=3

So add_highpages_with_active_regions passes down page to
free_highmem_page and later, free_unref_page does page_to_pfn(page) and
__get_pfnblock_flags_mask operates on this modified pfn leading to crash
– __pfn_to_section(pfn)->pageblock_flags is NULL!

Note that __pfn_to_section(pfn)->pageblock_flags on the original pfn
returns a valid bitmap.

thanks,
-- 
js
suse labs
