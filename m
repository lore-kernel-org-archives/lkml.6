Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F3C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865820878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs9BaT1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5865820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJBQJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40110 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJBQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so613453wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfDKgO3ROfWKGzMNjfSakIrhWQA4hezrsgdse7Glczc=;
        b=Qs9BaT1tAMetpqGbB4msfvk64+jHZJrxziVW8k0S/mVyWWEZHZ/LeUexaE8p1f48DU
         NSJN96VNZ3mpD/3Q5LjA2S6u5Woa9IF1SFCl1TRBKrAJteISvQSMyvwdpVAQYwpdCTTx
         XdkLQ3KhkAENptU8Kf3Hoi+piOW39e3rc0SLznCbY4zXZYl09Sg9zm/QOM1xt76n1twB
         RRTlGp5DPVNtYD03CwYUYaGm7T23u9qnCJpptRmtzHjpFgLxuOQcT5oZ2+iot4cTDj0q
         Y5TWy5/ay47kvdWJtJEzyAACqmDnB5Bk6/EYehNQNqte0WC8+CC+hI0aFfaarnZr13rj
         vxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfDKgO3ROfWKGzMNjfSakIrhWQA4hezrsgdse7Glczc=;
        b=MNXUTIKVgEzkWL70qN0GP7eceRyEqThAN5K70YgCiuiEkp4vA+cBE6tsgx09D8Ag/2
         xgL89m9eFJegkqBIUyltaoh+NXXEfnfNKqPoBOakqeA/jouaNUUnCPO/GD8VzA+xwTTW
         mMvKrqhwSBW1smkc/ZqYVtxKh6TQRdkg6a/Te7rmBKzSgcIizu1RnDpTTHlcl2DZJ2b6
         +XWMbNbyz2iG8E+VhxC0JdUlLhjGyH+x7EaTRyKQBoE1sRzzc9Fx1VLXr7Lr/39sDy+v
         xpvk5eYMABfGIAT5g4xRBvkPIt6DD7UXjHHQ4Ts+tO/ukxPFUtdetY9cNxB1iRp+p09J
         sicw==
X-Gm-Message-State: ABuFfoj6EIN0hg8zlB2hTwgSaTkL6P/ZNB8cxuW61yxYL6ROW95IUzCz
        iHI2hK5xvvHkxjHgqMBiRes=
X-Google-Smtp-Source: ACcGV63Pm2fBwFcuYyyvyZtAAM2NcabN/BRuHvLXsK4Gifzs/dRsV/K13Rjbs0ENFFxeERgLcQrFag==
X-Received: by 2002:a1c:ac07:: with SMTP id v7-v6mr1184478wme.110.1538472454766;
        Tue, 02 Oct 2018 02:27:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y184-v6sm11201974wmg.17.2018.10.02.02.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:27:34 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:27:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v2 3/4] x86/speculation: Extend per process STIBP to AMD
 cpus.
Message-ID: <20181002092731.GB122128@gmail.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
 <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> From: Thomas Lendacky <Thomas.Lendacky@amd.com>
> 
> We extend the app to app spectre v2 mitigation using STIBP
> to the AMD cpus. We need to take care of special

s/to the AMD cpus
 /to AMD CPUs

> cases for AMD cpu's update of SPEC_CTRL MSR to avoid double
> writing of MSRs from update to SSBD and STIBP.

s/AMD cpu
 /AMD CPU

> 
> Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/process.c | 48 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index cb24014..4a3a672 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -399,6 +399,10 @@ static __always_inline void set_spec_ctrl_state(unsigned long tifn)
>  {
>  	u64 msr = x86_spec_ctrl_base;
>  
> +	/*
> +	 * AMD cpu may have used a different method to update SSBD, so
> +	 * we need to be sure we are using the SPEC_CTRL MSR for SSBD.

s/AMD cpu may have used a different method to update SSBD
 /AMD CPUs may use a different method to update the SSBD

Thanks,

	Ingo
