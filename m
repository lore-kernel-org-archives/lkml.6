Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0789C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C294270D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CumfEDFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C294270D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbeF1Ie5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:34:57 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37757 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934425AbeF1Iez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:34:55 -0400
Received: by mail-io0-f193.google.com with SMTP id s26-v6so4456071ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mz35Z7xxicRXpbifgRPMgv3AS1JNYv6balRLEwp+b2w=;
        b=CumfEDFrVRk47YLW/dNHXSyTxVmqX275Ggs4dpdR6gdMNZs888J/pWYRQeDQIgLPPQ
         jO4RJko4qEE1P/lxKmD89ZB5h9rZdfhQIUMbubU/BKvtLQS0StLcX42oLY6clx2ul1lP
         QgmzOnIdXyVru1K0wqolPaoFsP/6osKEVzvSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mz35Z7xxicRXpbifgRPMgv3AS1JNYv6balRLEwp+b2w=;
        b=FvkCZQjW0cZxmIRX2HSrQ7+eZhieuqzU7eoi9C7YqF8hpj4kE4t1D9CzInELHIW1m9
         /kfRVUI5203IIa3IkH1LsgiohzGWcdEaosgquDi8OYWeoaA7iHQYRSEHeNs9MpRSwHGe
         6TGVAVxTx9EDrE23SmB5cNWD8AsAm8uw2NbxQO39NEIa/GOZS0F0xl6JbtcXszKHPamp
         iV9PRdJvh5YPwmQ/aE1czIIWt7/Yz/sUZij8LUEXNYGPON33TS5S1dQQFVnZlsOZFoG1
         002PcF9W00wGFz0Qd9vxC4PMK22Ql9BmOCGl7AwQlybbsx3WcEkNbYWNIJSBoEv//Ff+
         cObw==
X-Gm-Message-State: APt69E08ieAQLVmn1wSrifMMorTw4KmjsX/xDSfLnggypA1dzpdfTSnf
        ZGzrYLCwQyr8c+MkAKk2ShKlmyxpTpcwPqJXzawFSA==
X-Google-Smtp-Source: AAOMgpesdOt+RH94+W/s0J8zqNoG+D4llYUbDOBTMt0nZV4xRTVb9WWO33gpciQX7MYlJGedlR4n+OgKgmS92Zfvwyk=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr7663198ioc.173.1530174894456;
 Thu, 28 Jun 2018 01:34:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:34:54
 -0700 (PDT)
In-Reply-To: <20180628083107.GY2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-6-ard.biesheuvel@linaro.org> <20180628083107.GY2494@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Jun 2018 10:34:54 +0200
Message-ID: <CAKv+Gu9oxJCvpxRKpkndci1RGuewBsAPQW9W1=uXU1boGTSRrQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] x86/kernel: jump_table: use relative references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 10:31, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 06:06:04PM +0200, Ard Biesheuvel wrote:
>> Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
>> relative references rather than 64-bit absolute ones when emitting
>> struct jump_entry instances. Not only does this reduce the memory
>> footprint of the entries themselves by 50%, it also removes the need
>> for carrying relocation metadata on relocatable builds (i.e., for KASLR)
>> which saves a fair chunk of .init space as well (although the savings
>> are not as dramatic as on arm64)
>
> This will conflict with:
>
>   https://lkml.kernel.org/r/20180622172212.199633-10-namit@vmware.com

Thanks for the head's up. Fortunately, it does not conflict
fundamentally, so it should be a straight-forward rebase after that
code is merged.

Do you think this is likely to get merged for v4.19?
