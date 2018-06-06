Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kiXFIlk8GFuICgAAmS7hNA
	; Wed, 06 Jun 2018 19:57:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81992608BF; Wed,  6 Jun 2018 19:57:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNqUwsj3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E44216089E;
	Wed,  6 Jun 2018 19:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E44216089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeFFT47 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:56:59 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38673 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeFFT46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:56:58 -0400
Received: by mail-yb0-f194.google.com with SMTP id q62-v6so2409073ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RU/E6mZ7r/1Hv2ig8R8cwwB69MB5t1QJ4ZFABEgMVTY=;
        b=qNqUwsj3CCQr8echyrP83Q/usfqXu7AtDo3L4szDrCaYsfS0CBIZCJlP49cpPHkqNJ
         C85yWZVbIR/CeP+ICmItdvb0CKU90Nyeo7FQ6Ry33NaQQaQrBQbWLDnw3o27v2gviZ97
         ZnTHuhq5L3ulzQrZ80EAyEfxzzAK2DpDJiCxul0USKBbNb7H/oM1Y9UNky0FlnSu0w/H
         GFr7Ud/Srx3QhbkzRJZYEr39m1mECm3ZnQiIzfPdfxuXV5PWwZLF/dq0yp/D7nGE299d
         ngSzOaHHsReIBdVRkVnM/FTBiCpoOT0lx4SnhkeiKAUE9rVh49A6iTwAEKbZD4lwMozZ
         nS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RU/E6mZ7r/1Hv2ig8R8cwwB69MB5t1QJ4ZFABEgMVTY=;
        b=gmvZsBaQGuNDS03X5SFz4YtFsRPGNOXiVlXwdblW4DzWSt7Wn+s0je4hkeH4HRDZ+G
         cbH7kTGLTpIFKvwKdwZFDhdMeEfEaNG5oJ6DoAwdeewaSM2sVJ64UHw8bg8eBN218Y6T
         J8go9xXeDj/VxHnbjONCXcu+wrfmM0tA+pG7ZS3lJAYoYabeYUqCUp3lDfA9tTH4f8hz
         P9u4mJR7FNvRKB31Pcmv52TfQr5ZN85y4SoG36FKO/bO3aZLriOhFsjr/7XgT3DktYjs
         bf++5CSuBG0goam+eFo8qA1qVWrnGSpiqTa+RfYcT+4mtfrv33Lf1dQVeRTsKB8dwCJj
         CxWw==
X-Gm-Message-State: APt69E3JOrHzgxC2RRFGfhQbd4E7d6pgXbeRYp+rZC/T6tPQoQGexZbO
        Cf4gmazbkvTKkhg7Kdtm2l0=
X-Google-Smtp-Source: ADUXVKLqhzPJr31zhBz1EhHUfY5AMikbbeLFS+V0KjFI520EZYO8asVxji+uEFWHtNokjxwAGTz6hg==
X-Received: by 2002:a25:3b8a:: with SMTP id i132-v6mr2141391yba.239.1528315017688;
        Wed, 06 Jun 2018 12:56:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::d0a1])
        by smtp.gmail.com with ESMTPSA id 136-v6sm7502916ywk.11.2018.06.06.12.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 12:56:56 -0700 (PDT)
Date: Wed, 6 Jun 2018 12:56:55 -0700
From: Tejun Heo <tj@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu_counter: `percpu_counter_read_positive' should
 not return negative number
Message-ID: <20180606195655.GO1351649@devbig577.frc2.facebook.com>
References: <20180606193940.16126-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606193940.16126-1-malat@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 09:39:40PM +0200, Mathieu Malaterre wrote:
> Since function `percpu_counter_add' may result in a signed integer overflow
> the result stored in `fbc->count' could be negative. Make sure that
> function `percpu_counter_read_positive' does not return a negative number
> in this case. This will match behavior when CONFIG_SMP=y.
> 
> Detected wth CONFIG_UBSAN=y
> 
> [76404.888450] ================================================================================
> [76404.888477] UBSAN: Undefined behaviour in ../include/linux/percpu_counter.h:136:13
> [76404.888485] signed integer overflow:
> [76404.888490] 9223308017647617321 + 76624449492175 cannot be represented in type 'long long int'
> [76404.888501] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #50
> [76404.888506] Call Trace:
> [76404.888523] [dffedd30] [c0478b90] ubsan_epilogue+0x18/0x4c (unreliable)
> [76404.888533] [dffedd40] [c0479530] handle_overflow+0xbc/0xdc
> [76404.888548] [dffeddc0] [c0439044] cfq_completed_request+0x560/0x1234
> [76404.888557] [dffede40] [c03f3fc4] __blk_put_request+0xb0/0x2dc
> [76404.888570] [dffede80] [c05a81d0] scsi_end_request+0x19c/0x344
> [76404.888579] [dffedeb0] [c05a9954] scsi_io_completion+0x4b4/0x854
> [76404.888592] [dffedf10] [c04046b4] blk_done_softirq+0xe4/0x1e0
> [76404.888605] [dffedf60] [c07ec1d4] __do_softirq+0x16c/0x5f0
> [76404.888617] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> [76404.888629] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> [76404.888641] [c0cdbe80] [c0009a2c] do_IRQ+0x98/0x1a0
> [76404.888649] [c0cdbeb0] [c001b93c] ret_from_except+0x0/0x14
> [76404.888659] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
>                    LR = arch_cpu_idle+0x30/0x78
> [76404.888667] [c0cdbf70] [c0cda000] 0xc0cda000 (unreliable)
> [76404.888679] [c0cdbf80] [c00a3844] do_idle+0xc4/0x158
> [76404.888687] [c0cdbfb0] [c00a3a90] cpu_startup_entry+0x24/0x28
> [76404.888696] [c0cdbfc0] [c097f820] start_kernel+0x47c/0x490
> [76404.888703] [c0cdbff0] [00003444] 0x3444

So, the _positive versions are there to deal with small negative reads
coming from percpu propagation delays.  It's not there to protect
against actual counter overflow although it can't detect that on SMP.
It's just outright wrong to report 0 when the counter actually
overflowed and applying the suggested patch masks a real problem
undetectable.

I think the right thing to do is actually undersatnding what's going
on (why is a 64bit counter overflowing?) and fix the underlying issue.

Thanks.

-- 
tejun
