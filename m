Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59E121EC4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SMTZgaTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59E121EC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHJX0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:26:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42010 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeHJX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:26:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so5044939pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=G9MojgZC6ijm66FAlFZ72T69ONJr0B/PGlGa0EMOD6I=;
        b=SMTZgaTz3SqbLS348cpG1JJNgnv/PspT9HvIUed0vGRdOpQaGkWK2NQ0igjmUGEGo9
         jCglVF/aNbOEaEjtfjD8vytqtu1R/GEddupmVXxHgNslK+Vgn/55GWQD+63EsNbjYCVP
         zgtJuLywILxX2KE0NOJuvNHLa/CCDvQ2QkftuUfN9MeBP8XR8NbqgpWABwcVGBjVihPx
         mOqiHMniLPknJ7lTb9Nzqy8SADx+f/9dFBOkAjJkcWO7BFdyCWziqQ7T+ZdWxB2JQsOr
         HbuJbm2MRxBKIcAD6nivXgXQRpqjorp80ZYDzgmL+VgBxaDcvZ+hnb2T9/SxK8yXeBnn
         njAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=G9MojgZC6ijm66FAlFZ72T69ONJr0B/PGlGa0EMOD6I=;
        b=LSWO8Zapl50OESpbVmKQWW+HdOnvUr/7dQRDGjw+f4padYkUFMG4fZ1aZy8KsF6aKY
         wgcEt6sQUxdLl7FPnunq61+KHf8gm4A1mEDWDguyTjcWLW7Ijc+QugXp7PwXXKSbM8oN
         E4D7HvODqBFm3rD3F2KSRqSwBG0YOpAKhSXiwTpi2/xz8itLeUS66CdnzXrdTGOpkBkx
         nG3XEmXiyjkGcTHQxpnT8YS7Q4NCFLDuUfWdAlHTmikz+Uu2BhPR7O8LIygR7VDoiua2
         naQxRKkn6U29ZkYjDqhby/ovWSmA4hlP//3WUeyaIi3pU9I7BJ3Uc4j0h1G+P2hj6xCi
         Q45A==
X-Gm-Message-State: AOUpUlH7Jx9WT2Iedy+WP1HH20FFhsekkBhIMFHcDTBFctk/J3CLreys
        xKyM09Ymyx+LwpUtKAS1aFq/CA==
X-Google-Smtp-Source: AA+uWPy1MUcVzqq5Ltt0qB04bbcwY7ZLeQoDZkOKpcpZTqCfFgeMQzv53tNpt1eKFmJ6bo0GmI1xkg==
X-Received: by 2002:a62:3703:: with SMTP id e3-v6mr8586708pfa.117.1533934516804;
        Fri, 10 Aug 2018 13:55:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b195-v6sm20758294pfb.2.2018.08.10.13.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:55:15 -0700 (PDT)
Date:   Fri, 10 Aug 2018 13:55:15 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 13:54:18 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
In-Reply-To: <20180810184715.GA11259@roeck-us.net>
CC:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        tklauser@distanz.ch, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-f3c54437-a74c-4a33-b59e-84eaf3453c85@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:47:15 PDT (-0700), linux@roeck-us.net wrote:
> On Fri, Aug 10, 2018 at 11:27:37AM -0700, Palmer Dabbelt wrote:
>> On Fri, 10 Aug 2018 01:38:04 PDT (-0700), Christoph Hellwig wrote:
>> >On Thu, Aug 09, 2018 at 03:19:51PM -0700, Palmer Dabbelt wrote:
>> >>This would be necessary to make non-SMP builds work, but there is
>> >>another error in the implementation of our syscall linkage that actually
>> >>just causes sys_riscv_flush_icache to never build.  I've build tested
>> >>this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
>> >>normal.
>> >
>> >Would't it make sense to use COND_SYSCALL to stub out the syscall
>> >for !SMP builds?
>>
>> I'm not sure.  We can implement the syscall fine in !SMP, it's just that the
>> vDSO is expected to always eat these calls because in non-SMP mode you can
>> do a global fence.i by just doing a local fence.i (there's only one hart).
>>
>> The original rationale behind not having the syscall in non-SMP mode was to
>> limit the user ABI, but on looking again that seems like it's just a bit of
>> extra complexity that doesn't help anything.  It's already been demonstrated
>
> Doesn't this mean that some userspace code will only run if the kernel was
> compiled for SMP ? I always thought that was unacceptable.

Well, the officially sanctioned way to obtain this functionality is via a vDSO 
call.  On non-SMP systems it will never make the system call.  As a result we 
thought we'd keep it out of the ABI, but after looking again it seems yucky to 
do so.  Here's the vDSO entry, for reference:

    ENTRY(__vdso_flush_icache)
            .cfi_startproc
    #ifdef CONFIG_SMP
            li a7, __NR_riscv_flush_icache
            ecall
    #else
            fence.i
            li a0, 0
    #endif
            ret
            .cfi_endproc
    ENDPROC(__vdso_flush_icache)

Note that glibc has a fallback to make the system call if it can't find the 
vDSO entry, but then doesn't have a secondary fallback to emit a local fence.i 
if the system call doesn't exist.  It seems easier to fix the kernel to always 
provide the syscall and just call it a bug.
