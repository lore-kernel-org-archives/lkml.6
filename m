Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0C20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul4C28nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F0C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJYWNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:13:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42514 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJYWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:13:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id j46-v6so9825016qtc.9;
        Thu, 25 Oct 2018 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TE35H5QPVO/yV76Uq6pZsDoAOfB/keHzZ+CEzkU/AvM=;
        b=ul4C28nOrHpEHWJxFgLQGClmZsyrvUskZZq/N0K0BzExIX87qvUrTN0sI8NGUXPcIL
         Il9u2dPQPOXhXmi5YnvEHKSqTt5nWjIn1yzklO72wyVTjMaxhU0xq8XSWFLUlsHkfBsy
         T6j3c/QMKp1S+alzuB7aNjkZhC2udX2Uviz+meXMZhEyHQqyVeqPADcNH/CLlneeR7gn
         FyVon8RJOwr9yaonhyZnasHecjkZ9vc1Ka2CYRl4vOBzKzigGp2T9qhfUTRNyDNOhhwk
         4xJL9lRZxdHYcvR5qNHvrEvjJqcgjAfYkqmrkvXkSyK4NGhFZUFzKEFY0r/9JW2ZETPD
         3Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TE35H5QPVO/yV76Uq6pZsDoAOfB/keHzZ+CEzkU/AvM=;
        b=q9YFLl5UWorndWH4ZCOZx3CbMsjJMnwX0U4i1T8h301tUrBnDdmiOCCzIZWjTlBSip
         TWiTUI8Q9PpaOZpF4EfGDSuynW1pzdv+HMYdBJURBTnCYKqhB8lxaEqfXfVMdHILawwO
         eoUm99zUpAuLjoNX9YJS4Y8PP4j/ssFfEbCImKg28QwLzsgeAQ7mWQykm+yBZqy6uYbB
         qEXeGg+4jk2mkcCFVc8bl3Kn7Hu2wBfn+qMKN6cZmeoyw8vHeZRgigU9z4Xu7e8YZf7H
         bNnTb+7zwT7y+5UkVV0JKzC3w8dhz8SD6jDuLg+iQF8eqswfhTikXMvAVo2ReDEEOEBk
         klgw==
X-Gm-Message-State: AGRZ1gKrJhDFkpiezSnaEGPDUy22g8zY8MgxOVssuslFEg8ba2s7z/9w
        8Cxok2wWemhlfMML25PyCg==
X-Google-Smtp-Source: AJdET5cBymDPzSjov+RnHkDxc3/F9vve+44p+RpQSa458J7kzIpLphOzzxkeyCHTAIozlKRLvIlImA==
X-Received: by 2002:ac8:2729:: with SMTP id g38-v6mr1589242qtg.168.1540474858066;
        Thu, 25 Oct 2018 06:40:58 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s71-v6sm6244151qkl.86.2018.10.25.06.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 06:40:57 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:40:51 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181025134050.ggiir77ehntikbwg@gabell>
References: <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025103345.GF14020@nazgul.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:33:45PM +0200, Borislav Petkov wrote:
> On Mon, Oct 22, 2018 at 11:42:05AM -0400, Masayoshi Mizuma wrote:
> > I'm trying to store the SRAT info and pass it to kernel_randomize_memory(),
> > looks like add_e820ext()/parse_setup_data().
> > 
> > Is the approach useful only EFI environment? I'm not sure how I
> 
> Does it matter for non-EFI even?
> 
> I mean, you want this code only for your use case - when you have
> movable memory and you're doing kexec, yes?
> 
> And those machines are all EFI boxes I'd assume...

My actual use case is for EFI boxes, however, I think it's better to useful
for legacy BIOS as well because memory hot-plug affinity in SRAT and KASLR
are available on legacy BIOS.
Actually, we can create such environment in qemu.

I have another idea to solve this issue. Adding a SRAT parsing code
to arch/x86/mm/kaslr.c. It is useful for both EFI and BIOS and
also we don't need a new kernel parameter...
Dose the idea make sense?

Thanks,
Masa
