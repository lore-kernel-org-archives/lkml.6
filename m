Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A45C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4E120850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lEWq+kUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfARQOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:14:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40995 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfARQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:14:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so15730752qtf.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KG+I2J8N6LxgofxAwyTwx6e1PVHkREPUWUPz4a02bbs=;
        b=lEWq+kUgd/zdCiUUMuVhTY1kFOs3zw0sP6Ma0OPLYJBYrkh1d92+OFyFLsExcJVOmE
         SwBhQUitRNDB8ZFyogn+ESTarzTu5zEm3aXX8sOog90zrdyBCpN1MnAGOtoaqhGboxEE
         ZssDZRBu4FM0soTOTwTX3BzFVdGBAwUQd+EfjIiMtF98JXrfyigsZkwyNjZG6n4lv0nc
         Wn9NY7gr5/9SlPNEVlgzHgo654RgjuD3jvtPk9QDS52x+oyvVHLGBGckvFf9TveHG5V2
         N3D85W8OCUBXK3lboS524RjeCuZdVLoEp3UG21BHEaUkStmai7GAkVIDtJdJSSfMaVNn
         uwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KG+I2J8N6LxgofxAwyTwx6e1PVHkREPUWUPz4a02bbs=;
        b=Jt0DtcW3FAFT/c6Cx9/O0SOghk2H/h+QDEjChBWFz7mSLWtSSUxMx8h30/QNj5omUm
         RsYAZ+vbH4y/L00ENjAuQNvWVNpK5yu4Pv5Ml8MKNwsvcRVWE9KnfWkRmLYMc8ecob93
         D87kZDCp583Iq0Ey5l1i697tYoHAQfbhw9DYi6HvBGaBnjfos/3dTAyW8u7r/Qfb4mBe
         RBJKcrvlbVUS6q5kGwMP0l4NO8/lTz+iC8zu7g87ou0zdBMohDSHc0E+beKQY09856Jg
         9t2vWSIM7iuLYNxNDyAvd9XKJfFyIBh4gI72Q6V/cvPHYhZvcMkSSgK/sE3CLTtOGA3j
         mjgA==
X-Gm-Message-State: AJcUukdSySxF951OSXYqE9MF3b9ZZa0/5lK8CU3C/ynJOAJH15dSKVBy
        nHRRKlGHb87WqhDs29ity1MpvslkTCR91g==
X-Google-Smtp-Source: ALg8bN4VyzOFVJM7oYRkKknfZJZjnIdOFMwLgU04ChL8mQIgWjT7e5T38Ew/ZgtdOjmplC4PiFPnGw==
X-Received: by 2002:a0c:a144:: with SMTP id d62mr16500680qva.50.1547828043668;
        Fri, 18 Jan 2019 08:14:03 -0800 (PST)
Received: from ovpn-124-227.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t4sm4551510qke.74.2019.01.18.08.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:14:02 -0800 (PST)
Subject: Re: kmemleak panic
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
From:   Qian Cai <cai@lca.pw>
Message-ID: <5fe89adc-c95b-ca89-d043-c380e2ba8cb3@lca.pw>
Date:   Fri, 18 Jan 2019 11:14:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/19 10:36 AM, Marc Gonzalez wrote:
> On 18/01/2019 15:34, Catalin Marinas wrote:
> 
>> On Fri, Jan 18, 2019 at 02:36:46PM +0100, Marc Gonzalez wrote:
>>
>>> Trying to diagnose a separate issue, I enabled a raft of debugging options,
>>> including kmemleak. However, it looks like kmemleak itself is crashing?
>>>
>>> We seem to be crashing on this code:
>>>
>>> 		kasan_disable_current();
>>> 		pointer = *ptr;
>>> 		kasan_enable_current();
>>
>> There was another regression reported recently:
>>
>> http://lkml.kernel.org/r/51e79597-21ef-3073-9036-cfc33291f395@lca.pw
>>
>> See if reverting commit 9f1eb38e0e113 (mm, kmemleak: little optimization while
>> scanning) fixes it.
>>
> 
> [Drop LAKML, add LKML, add recipients]
> 
> Bug is easy to reproduce:
> 
> boot
> mount -t debugfs nodev /sys/kernel/debug/ 
> echo scan > /sys/kernel/debug/kmemleak
> 
> Unable to handle kernel paging request at virtual address ffffffc021e00000
> Mem abort info:
>   ESR = 0x96000006
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000006
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
> [ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803, pmd=0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 635 Comm: exe Not tainted 5.0.0-rc1 #16
> Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
> pstate: 80000085 (Nzcv daIf -PAN -UAO)
> pc : scan_block+0x70/0x190
> lr : scan_block+0x6c/0x190
> sp : ffffff80133b3b20
> x29: ffffff80133b3b20 x28: ffffffc0fdbaf018 
> x27: ffffffc022000000 x26: 0000000000000080 
> x25: ffffff80118bdf70 x24: ffffffc0f8cc8000 
> x23: ffffff8010bd8000 x22: ffffff8010bd8830 
> x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050 
> x19: ffffffc021e00000 x18: 00000000000025fd 
> x17: 0000000000000200 x16: 0000000000000000 
> x15: ffffff8010c24dd8 x14: 00000000000025f9 
> x13: 00000000445b0e6c x12: ffffffc0f5a96658 
> x11: 0000000000000001 x10: ffffff8010bae688 
> x9 : ffffff8010baf000 x8 : ffffff8010bae688 
> x7 : 0000000000000003 x6 : 0000000000000000 
> x5 : ffffff801133ad60 x4 : 0000000000002878 
> x3 : ffffff8010c24d88 x2 : 7c512d102eca1300 
> x1 : ffffffc0f5a81b00 x0 : 0000000000000000 
> Process exe (pid: 635, stack limit = 0x(____ptrval____))
> Call trace:
>  scan_block+0x70/0x190
>  scan_gray_list+0x108/0x1c0
>  kmemleak_scan+0x33c/0x7c0
>  kmemleak_write+0x410/0x4b0
>  full_proxy_write+0x68/0xa0
>  __vfs_write+0x60/0x190
>  vfs_write+0xac/0x1a0
>  ksys_write+0x6c/0xe0
>  __arm64_sys_write+0x24/0x30
>  el0_svc_handler+0xc0/0x160
>  el0_svc+0x8/0xc
> Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260) 
> ---[ end trace 8797ac2fea89abd6 ]---
> note: exe[635] exited with preempt_count 2
> 
> 
> 
> Reverting 9f1eb38e0e1131e75cc4ac684391b25d70282589 does not help:

This looks like something different from the original "invalid PFNs from
pfn_to_online_page()" issue. What's your .config ?
