Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70302098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfw/7MCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70302098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJDQhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:37:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:37:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so9136997wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HDicjxug5RKfq+HhpP3ZQdTUad2l64SudYBZtE7m778=;
        b=bfw/7MCIyusllTKOr5PPN2d2p4KbGjfdN2fxUWzMxi4egP2VLACACovo6Lj9IhBgt8
         WSW1HVLPTzL/N0RkI3eS/5Md30x//tVZmTDeKPzkZCKKJYot12lYjDRGx0gsRKGUHulP
         wiTwHPpfsjt+eJ8DhLDl1wm99I1o09qnOmiMf5bYY9Brm9UUdq4+1NLbXjVFD6jlOKT9
         Mu7bT71Rbgth7ZeeEjOn+d1oDjAfjt6JV95mVXBs08pl2OdCeocRzMUo7owxuRyPJcct
         edebjwYx5kwkQoUt+wIIWpYQ1/28WNj/8lNdjXZ2BCXWlKD/awjNXQoGwVBPUEPu0eJZ
         nzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HDicjxug5RKfq+HhpP3ZQdTUad2l64SudYBZtE7m778=;
        b=EUu1PAtIhS2qUx7HvZuqLMoxaKQemOUCDtv8nNkGtM+XFeXLPZc8uUPLQSoYN4NYaG
         iD7ha63iFYMXQjh5Q2YKlNlJyYgbhhKfIPW7spp9UPwzjp+KEFCGdQK0dLeo1uszIxHd
         evqDh/AVIrlNZ+gt9g81rJjYk8QPoAZ+DanvZRdIoBB9BQHxVb1OHx7BBnT6iUslRzUD
         7lwEV+wPn2NtYHytQFhSu2cZcKcARpsHkxK42opDOn27i/RJK1bH3ndlvt74nTf7TTK/
         qZ26CLXlxM4P737FO4FpsRizKCmXSI2Y5eue52XG9yvOKa7Ifb5naKz9ALAIc7b9/xCV
         ERZA==
X-Gm-Message-State: ABuFfohoEZ0simW1h4PWhR0jNqhIKjVZ2wvTWh4RseD76KNAp+KedaQC
        BilPhs2Nb284MhDpT8dzOP+ohdya
X-Google-Smtp-Source: ACcGV63sVf6h+eQ+/NpC+MUlbT3UQ0Pd3IKS2KWpUrKD5Bv7oCoiJH3H0pkd9RhfJJa3L66LNny4rw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr4106822wrx.271.1538646322494;
        Thu, 04 Oct 2018 02:45:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b81-v6sm4437649wmh.47.2018.10.04.02.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:45:21 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:45:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004094519.GA97692@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > Another, separate question I wanted to ask: how do we ensure that the kernel stays fixed?
> > I.e. is there some tooling we can use to actually measure whether there's bad inlining decisions 
> > done, to detect all these bad patterns that cause bad GCC code generation?
> 
> Good question. First, I’ll indicate that this patch-set does not handle all
> the issues. There is still the issue of conditional use of
> __builtin_constant_p().
> 
> One indication for bad inlining decisions is the inlined functions have
> multiple (non-inlined) instances in the binary and are short. I don’t
> have an automatic solution, but you can try, for example to run:
> 
> nm --print-size ./vmlinux | grep ' t ' | cut -d' ' -f2- | sort | uniq -c | \
> 	grep -v '^      1' | sort -n -r | head -n 5
> 
> There are however many false positives. After these patches, for example, I
> get:
> 
>      11 000000000000012f t jhash
>       7 0000000000000017 t dst_output
>       6 0000000000000011 t kzalloc
>       5 000000000000002f t acpi_os_allocate_zeroed
>       5 0000000000000029 t acpi_os_allocate
> 
> 
> jhash() should not have been inlined in my mind, and should have a
> non-inlined implementation. dst_output() is used as a function pointer.
> kzalloc() and the next two suffer from the __builtin_constant_p() problem I
> described in the past.

Ok, that's useful info.

The histogram suggests that with all your patches applied the kernel is now in a pretty good 
state in terms of inlining decisions, right?

Are you using defconfig or a reasonable distro-config for your tests?

Thanks,

	Ingo
