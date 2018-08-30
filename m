Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD10BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A71204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCPPK8SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A71204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeH3FAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:00:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42540 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeH3FAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:00:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so3084138pgp.9;
        Wed, 29 Aug 2018 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vPd3WIGjuSBRemwqEo+vGN+VhlOucKgeZMmN6FqPvvg=;
        b=DCPPK8SI/LlXyyfGuJpQaAQlqkQBwvHoICtdALiiAeMptZfXkJDOtcVhBPIwza/ro8
         EESruYDCdd/JPLSmWBscBoGo9auQnLgHhuTAnbsE7E5+CnV5ktJPmmII8dsKCISXVo3z
         2RBQ+VxEHI/dyisTFc/OsOym0Sx49bDOZY2OISLOVSbawZR9jR7Ll8R3or1p5PMudEWG
         q7qZBrSOEQ1Y+UgXIae3fg6PrtMfylXjjl9Qn+V5EuMZf6fDbSGOxyD9S7r3sV9sJ9mi
         7BCyPEblVs4Q0FC3xs9m2UvQHQME+pb/9Jii9afW8sX/WHSdoVL3srXo56VF7XUVHd/Z
         tYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vPd3WIGjuSBRemwqEo+vGN+VhlOucKgeZMmN6FqPvvg=;
        b=VShxNEgRx/BBEYJakn9PNhnHCEMR1Eh9aQVr5LD1pnWtdWDviDNfoMa1M292aA8Bdm
         2RsvyAst4f7E783eMhBsuHbnG+OOaP77uXZAsS3xH+P2YxvAEz7ARIcYhXqxRX1hnx28
         sJ8W+F9XyKBeSuMuQX9nXkHHt9Ess5c7yVZYVR4zgkINtIEpKb7XAzt5AsU5n28FyUJA
         SE+j2YsI62n3g8pVI9entZJPku5bHt5PnTWROiNJljMdnZPnjJOCTxMjzXmbHpjcCTDb
         i2j/dajGjeURYE0R1+zBeffYoJQzSeDzViZi9IosnprYGN+rW0i/GAtAlr5wV6Oq8YqX
         37ug==
X-Gm-Message-State: APzg51BjxmGOrB9LJIVRELz6H388T/9ZKLw1m/eeZom3zr+cxN+GxC5j
        PQQ/i2wJ/rHEDr856S4PZ+I=
X-Google-Smtp-Source: ANB0VdbEzrSb91ZaUGo4lGfu6ysZDwuayokv6EZ4Y3XqbtDMwYtPEwRFKx3clxm2zkeX1z+ZSf+pSg==
X-Received: by 2002:a63:91c2:: with SMTP id l185-v6mr7812628pge.321.1535590830770;
        Wed, 29 Aug 2018 18:00:30 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id 143-v6sm7389064pfy.156.2018.08.29.18.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:00:29 -0700 (PDT)
Subject: Re: mmotm 2018-08-23-17-26 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180824002731.XMNCl%akpm@linux-foundation.org>
 <049c3fa9-f888-6a2d-413b-872992b269f9@gmail.com>
 <20180829162213.fa1c7c54c801a036e64bacd2@linux-foundation.org>
From:   Jia He <hejianet@gmail.com>
Message-ID: <7ae81ca1-46ca-af47-8260-c52736aa4453@gmail.com>
Date:   Thu, 30 Aug 2018 09:00:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829162213.fa1c7c54c801a036e64bacd2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2018 7:22 AM, Andrew Morton Wrote:
> On Tue, 28 Aug 2018 12:20:46 +0800 Jia He <hejianet@gmail.com> wrote:
> 
>> Hi Andrew
>> FYI,I watched a lockdep warning based on your mmotm master branch[1]
> 
> Thanks.  We'll need help from ARM peeps on this please.
> 
>> [    6.692731] ------------[ cut here ]------------
>> [    6.696391] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
>> [    6.696404] WARNING: CPU: 3 PID: 320 at kernel/locking/lockdep.c:3845
>> check_flags.part.38+0x9c/0x16c
>> [    6.711082] Modules linked in:
>> [    6.714101] CPU: 3 PID: 320 Comm: modprobe Not tainted 4.18.0-rc4-mm1+ #56
>> [    6.720956] Hardware name: WIWYNN HXT REP-1 System H001-00001-0/HXT REP-1
>> CRB, BIOS 0ACJA530 03/20/2018
>> [    6.730332] pstate: 60400085 (nZCv daIf +PAN -UAO)
>> [    6.735106] pc : check_flags.part.38+0x9c/0x16c
>> [    6.739619] lr : check_flags.part.38+0x9c/0x16c
>> [    6.744133] sp : ffff80178536fbf0
>> [    6.747432] x29: ffff80178536fbf0 x28: ffff8017905a1b00
>> [    6.752727] x27: 0000000000000002 x26: 0000000000000000
>> [    6.758022] x25: ffff000008abeb14 x24: 0000000000000000
>> [    6.763317] x23: 0000000000000001 x22: 0000000000000001
>> [    6.768612] x21: 0000000000000001 x20: 0000000000000000
>> [    6.773908] x19: ffff00000a041000 x18: 0000000000000000
>> [    6.779202] x17: 0000000000000000 x16: 0000000000000000
>> [    6.784498] x15: 0000000000000000 x14: 0000000000000000
>> [    6.789793] x13: ffff000008d6b190 x12: 752ce9eb60de3f00
>> [    6.795088] x11: ffff80178536f7f0 x10: ffff80178536f7f0
>> [    6.800383] x9 : 00000000ffffffd0 x8 : 0000000000000000
>> [    6.805678] x7 : ffff00000816fe48 x6 : ffff801794ba62b8
>> [    6.810973] x5 : 0000000000000000 x4 : 0000000000000000
>> [    6.816269] x3 : ffffffffffffffff x2 : ffff0000091ed988
>> [    6.821564] x1 : 752ce9eb60de3f00 x0 : 752ce9eb60de3f00
>> [    6.826859] Call trace:
>> [    6.829290]  check_flags.part.38+0x9c/0x16c
>> [    6.833457]  lock_acquire+0x12c/0x280
>> [    6.837104]  down_read_trylock+0x78/0x98
>> [    6.841011]  do_page_fault+0x150/0x480
>> [    6.844742]  do_translation_fault+0x74/0x80
>> [    6.848909]  do_mem_abort+0x60/0x108
>> [    6.852467]  el0_da+0x24/0x28
>> [    6.855418] irq event stamp: 250
>> [    6.858633] hardirqs last  enabled at (249): [<ffff00000830e518>]
>> mem_cgroup_commit_charge+0x9c/0x13c
>> [    6.867833] hardirqs last disabled at (250): [<ffff000008095f40>]
>> el0_svc_handler+0xc4/0x16c
>> [    6.876252] softirqs last  enabled at (242): [<ffff000008081c48>]
>> __do_softirq+0x2f8/0x554
>> [    6.884501] softirqs last disabled at (229): [<ffff0000080f1bec>]
>> irq_exit+0x180/0x194
>> [    6.892399] ---[ end trace b45768f94a7b7d9f ]---
>> [    6.896998] possible reason: unannotated irqs-on.
>> [    6.901685] irq event stamp: 250
>> [    6.904898] hardirqs last  enabled at (249): [<ffff00000830e518>]
>> mem_cgroup_commit_charge+0x9c/0x13c
>> [    6.914100] hardirqs last disabled at (250): [<ffff000008095f40>]
>> el0_svc_handler+0xc4/0x16c
>> [    6.922519] softirqs last  enabled at (242): [<ffff000008081c48>]
>> __do_softirq+0x2f8/0x554
>> [    6.930766] softirqs last disabled at (229): [<ffff0000080f1bec>]
>> irq_exit+0x180/0x194
>> [    7.023827] Initialise system trusted keyrings
>> [    7.027414] workingset: timestamp_bits=45 max_order=25 bucket_order=0
> 
> Lockdep says current->hardirqs_enabled is false and that is indeed an
> error.  arch/arm64/kernel/entry.S:el0_da does enable_daif which might
> be an attempt to enable hardirqs, but how does that get propagated into
> lockdep's ->hardirqs_enabled?  By calling
> local_irq_enable()->trace_hardirqs_on(), but that's C, not assembler.
> 
> And what changed to cause this?
> 
> I dunno anything.  Help!
> 
>> I thought the root cause might be at [2] which seems not in your branch yet.
>>
>> [1] http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=efd112
> 
> I agree, that doesn't look like the culprit.  But something may well
> have gone wrong in "the recent conversion of the syscall entry/exit
> code to C".
Sorry for my unclearly previously description.
1. no such lockdep warning in latest mainline kernel git tree.
2. there is a 100% producible warning based on your latest mmotm tree
3. after applying the commit efd112 based on your mmotm tree, the warning
disappearred

I will do some further digging to answer your question if no other experts' help

-- 
Cheers,
Jia
