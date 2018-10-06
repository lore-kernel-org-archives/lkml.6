Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E88C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104E0206B2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNhTLU4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104E0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJFTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:25:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42650 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeJFTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:25:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so13456037wru.9;
        Sat, 06 Oct 2018 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsvkuL2uI/rJriPrUL45TCgl79YNXmmjFP1oERBtT4I=;
        b=oNhTLU4qaWqBB+ZnP0CoC+SUhmztjoqajfTunhcopLbqlBGQsi4bNuxr1NhK0VOMvw
         EMmXpbDFFtnktON3sPr1qZNjm+74+cy5fuknKJX1Zqf/cYaQamfk64A3SpSFwuDFpju5
         MvhMji69WrljZzjw/C1vsy0vsLNNWPmuqrqU7fEe96jR5qMqV4Bc8R4yE2N6Sj8FeVmn
         ERhnNO8VH0TaLXl+uqNOw6+tc9gZJ4oAJ5lAEHfPKedP5PkGI3g2faYxSmbUfN14jrY2
         xiaMR+1kprjZPqcZ+elex7EzBG9cyRwqVB4Vi9cryQBQO1Gzx4TR9LQADksKEhV73ycZ
         oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsvkuL2uI/rJriPrUL45TCgl79YNXmmjFP1oERBtT4I=;
        b=tkF5D+9u36uqjxupb76FQ2/IrHFLfPa08wzAWm9TsJQDfpXYIvaq8xl61jAH12yVh5
         G4oEcH9fDiqE+vy599ORh6Omz2f0+yHxQ47QEi2ThEY3TjCJbVuYxbet/SfLakA48tVL
         bsKO/g5D+t3ekEYnjQ9sVQvQzFYsYdtGVR458dXqRg4X0D4GmPH+T6mQqgtDFyOxLVYA
         zjSAOgdCfFI7mWY2UtabA3MXhadqWU+zOCPU64iFqd9ynoPCtK/TyyrvY3JiNVrDnXv0
         1IQ+biR2I7WSEVBGUqw7n/LKsQtYqMfsmZOiuT6zcmQ03PMmtmqcXoy0hnlrhGHc4Xpf
         pc2w==
X-Gm-Message-State: ABuFfogZDfZJA+hdQkMKQ3bwVlXrjS473YWSWI86q+J9BshGgXA4c4QP
        p7pVpEZOwtdK/6jRwexUX38=
X-Google-Smtp-Source: ACcGV62sVKNWEs3fiJyuwmnhxF1m3ecYMCTjp1QbFg6fVc1moQV+0SkBz0x6NJGCx7GymXy7AEvAVA==
X-Received: by 2002:adf:b593:: with SMTP id c19-v6mr9481722wre.223.1538828519016;
        Sat, 06 Oct 2018 05:21:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v10-v6sm8859228wrp.0.2018.10.06.05.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 05:21:58 -0700 (PDT)
Date:   Sat, 6 Oct 2018 14:21:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/3] x86/mm/doc: Clean up mm.txt
Message-ID: <20181006122155.GA418@gmail.com>
References: <20181006084327.27467-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006084327.27467-1-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> This clean up is suggested by Ingo.
> 
> It firstly fix the confusions in mm layout tables by unifying
> each memory region description in the consistent style.
> 
> Secondly take the KASLR words out of the mm layout tables to make
> it as a separate section to only list mm layout in non-KASLR case.
> Then add KASLR document at the end of mm.txt.
> 
> Meanwhile update description about KERNEL_IMAGE_SIZE in
> arch/x86/include/asm/page_64_types.h .
> 
> v2->v3:
> Ingo helped to prettify the patch log and code comment, repost them
> after updating accordign to Ingo's suggestions.
> 
> v1->v2:
> 
> Resend v2 since some typo and incorrect descriptions found in v1 post.
> 
> Baoquan He (3):
>   x86/KASLR: Update KERNEL_IMAGE_SIZE description
>   x86/mm/doc: Clean up the memory region layout descriptions
>   x86/doc/kaslr.txt: Create a separate part of document abourt KASLR at
>     the end of file

Thanks, patches #1 and #2 are looking good and I'll apply them with some minor fixes, and I'll 
comment about patch #3 separately.

I also wrote a larger patch enhancing the descriptions some more, I'll send that separately.

Thanks,

	Ingo
