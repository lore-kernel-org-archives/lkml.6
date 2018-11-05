Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774412086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD4kXIYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774412086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeKEUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:01:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44230 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:01:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so4040896pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KaX4ickUP2xJqqvsEKJ5Vs4ivT5tvDy6g+wMhbatxDg=;
        b=uD4kXIYFb0UAD7CZH1sMfBl0Hl/LFkEALDbaOGnECc0Q+Z51M27D5Yxz6DIBQzULxm
         reRWEigl7oxEHTH3Fn/OKOD9eiAvK8e7gV30tjZpsXAZv0pYS7q8U7RiTcNqxePQGyWb
         T90R/KWkXBCybaDSGu1ZkXXtBvWTNe0giqDyGNVToyPsPqRTgliVKGA17jc5nJ83eZ7N
         ELs/9S+pFDhTuYcYR+fpof+7qUodT0LW64VlWUjgNp4y8P759N/NKsBrTuWF3g5ZiEcO
         A6ay8bQ6G7bIfdXRNSKS69FMjkzUkFZhTwz5EiVEesgFb1hcXJoPnIgOKAdO/HVysEYF
         T7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaX4ickUP2xJqqvsEKJ5Vs4ivT5tvDy6g+wMhbatxDg=;
        b=htADGDl7nlQVu+ztIFk8o45tZTMAHqVsssXQBKsZAXKrsWL0iLHww8EaAiHxzV3pw1
         7NMJh1uWYuL+wCj4wmLZLrOSL8KV3rdlE5uQwbfCrUIsr5lRFzr5HDQWajtmwp3XRBda
         D/i2CREdZkEY24sZdGDQB1+EEAm4HZAyxdORw+CwQr8RGQfxpwYIvxl/C7pVZoW+iX1V
         mr54Xm179qEk/iKYUf/KQc/sg156tdvbw8B9hOwC2FmQ3qBdaafoo//Q2kwLSqkon9fg
         6inTzE0l/X3qQVD3C0CUbSOxmRFI4bU7KwOvsehRV27Fx/cpxw46Mw2/7s77zSfAwJA3
         6IpA==
X-Gm-Message-State: AGRZ1gLSMSVCNM7W8u8ZltRAJWRWrVaG6tLX6Vfqzbycit1eC1QFUC6b
        chVVGwiZyiAnBCjJy/r/VHA=
X-Google-Smtp-Source: AJdET5eS/IZYoAV405Xq3B/n/CYAETwSCEmsxF9chUXPV5oaUfcXsaMbgz5UtiaC5m5z2cKDeXYtqA==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr6132232pgr.426.1541414529233;
        Mon, 05 Nov 2018 02:42:09 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id r1-v6sm59238353pfb.41.2018.11.05.02.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 02:42:08 -0800 (PST)
Date:   Mon, 5 Nov 2018 21:42:04 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v11 00/26] Speculative page faults
Message-ID: <20181105104204.GB9042@350D>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:06:07PM +0200, Laurent Dufour wrote:
> This is a port on kernel 4.17 of the work done by Peter Zijlstra to handle
> page fault without holding the mm semaphore [1].
> 
> The idea is to try to handle user space page faults without holding the
> mmap_sem. This should allow better concurrency for massively threaded

Question -- I presume mmap_sem (rw_semaphore implementation tested against)
was qrwlock?

Balbir Singh.
