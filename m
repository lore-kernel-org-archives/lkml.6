Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A09ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIF+7pkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0A72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJSNFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:05:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42670 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeJSNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:05:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so15927603pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 22:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zH1B+xgskiRAT5rePx+9xDVnmVM332/H+OPze+6IO8M=;
        b=mIF+7pkE+wr9lXdJ8VZ/A1XiWXaygWgjgn2ODpz76BjD7bGiMG0j/dLaRqct8Y3ym2
         7GE43WxFkKeiueEB/gULfyANzeNe+CrnedE4pN1NsNg5RgdmQlIT5jIZeK9hQDdisD3a
         Oi6ckYeb7a0X2WY2yJzhmKoIG4YDqvtFlGGQJojgxRDs6viojtv6l0KWaNwo0rkYL3Go
         bnvYwzBaqbzYheQb6dyCnQxd9eNkAfpUIZQMv4dd65BobvhIY7N+3/nW/qqbsuKy9sz/
         aBIUWM2FJRJmiOm4T8c5Zb+K/43X66WrZmw61HVBqJ1UtOsweMVOEFi0C4s6Josi00+e
         a9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zH1B+xgskiRAT5rePx+9xDVnmVM332/H+OPze+6IO8M=;
        b=tuBw/2codle+mYtpfIfBoSnrSIvoBVIxN+SrGFA65I9WhAAZWYkANDanEz286TbP8c
         RYAFCPl4usAc4naR7EC/O6t34DfWnxYCwMW2TA/HPmun/qBvpmwVLUvrNp0MGs0eIUrG
         OdOIRFNE1v6ljg1nqnIYi58uU5x7H0VWeY8Kfn75+JjiNLmYOQ2p8L67uMPs54i7Z88H
         pU06FdbE//myMidRMYMhXQQuvrE+uJh1/T5fxnyOdGboecgHT4BLus8DEBrT6RUWYNea
         pIfHH3F0DQn7EC1XQDUzg9dNJYCwWjj8MIKWreC1n+/LZbRuE9oRe7Bamii3oDr/G1+M
         lXbg==
X-Gm-Message-State: ABuFfojOx6jq0y9rY+rrmZqmUHkcixOuTMg12HDDgWxBszZE7rwSroNQ
        d/CeTFNxDHB11BqJo3cC2yU=
X-Google-Smtp-Source: ACcGV63djeapbjuMqyAqh1aNlW9o02l9oInXubQKuYTJwfyicwVnkJ4YIlaeY/r80bBSUaq/LDVc2w==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr34184042pfu.134.1539925256202;
        Thu, 18 Oct 2018 22:00:56 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:8c1d])
        by smtp.gmail.com with ESMTPSA id q2-v6sm37402955pfc.17.2018.10.18.22.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 22:00:55 -0700 (PDT)
Date:   Thu, 18 Oct 2018 22:00:53 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, daniel@iogearbox.net,
        guro@fb.com
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181019050051.bs2kk4sagu7hpwxx@ast-mbp.dhcp.thefacebook.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >
> > Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> > preempt_enable_no_resched().
> 
> Alexei, I think this code is just wrong.

why 'just wrong' ?

> Do you know why it uses
> preempt_enable_no_resched()?

dont recall precisely.
we could be preemptable at the point where macro is called.
I think the goal of no_resched was to avoid adding scheduling points
where they didn't exist before just because a prog ran for few nsec.
May be Daniel or Roman remember.

