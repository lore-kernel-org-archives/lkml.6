Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD86FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48020831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvo9W/+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E48020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbeKVRsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:48:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53616 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbeKVRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:48:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so4554153wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2SyDeRqIejlwHowsQ4sWOCYX71He9eEn8uCq4IUIKoY=;
        b=Qvo9W/+dyGMeW0oeJ+fd6ykoIdZl4EeOKcswXMN3n6Q79EytX34tsDslVkATLhEI80
         DKUYxrF2FWtAczLcq70whTj6lYXeAEHcCz9DKTQ+F3/Eprv8+QDLv27yj3TM9TRui0Cp
         qXKfLtIZBiuZikseE/0Mm9z+SeNcq8vY45N5vCN+dZXxB1HDxy4A6i6jaiwxKLlPaP9S
         K5dOa9O4sAZ2/WG2YNryYrev6iM0TMoGB7W5DoTwvdEmOXYbc4nwABojnizW73vr9hvc
         +Nawquk6YCBdn9joNSB+NbIKvyFuLk2bqzzTQg8fsuBYQ0G52XQYWUVmfB9FgUwJzoIt
         EQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2SyDeRqIejlwHowsQ4sWOCYX71He9eEn8uCq4IUIKoY=;
        b=mL8SbrtVvTVvPUjVf9X79tbmABPrXk95FUBWRIrEISSO6xkXqKoiMz3f+l9GYSMAZC
         JYrqwnwEiJAons1CJe9ZRBCjLGDynWQ6MtCLQ/S4WDl99TK5MhUoaglISQ5XLvDIC+CU
         SohCjCuzMmiKkBIQAAkpRO2GPsFdD3/l7L1UdGv7wZa8mYvLyl7xH9rKR1fA6xxxDGDP
         2kzAh4USOFYKrOeuAsz1X9ROIzTAO8MjcAhhnSBaF++5h7/kcBLxd9Dy59TmQiMOb/+j
         KfpF+3MJWJlejWRxIT16DbcpRYqvTBhqnrBAfjB3u71U7odeB6xNMxbp5xuxDiVb7mQS
         KZog==
X-Gm-Message-State: AGRZ1gJTo7MnVem02IteCVukqIisikHErR0nnhdNGun58Egzy34nBSn1
        k/N1QtAGY9Zxul9CPJyIhEQ=
X-Google-Smtp-Source: AJdET5fQH2tm7b9hmilNP7f+BEVCuSsoDH2hC1WI+wmIRQLG2utrtJeT6CSmgO/DG4bjMCQake7oIQ==
X-Received: by 2002:a1c:730b:: with SMTP id d11mr7648877wmb.29.1542870646610;
        Wed, 21 Nov 2018 23:10:46 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j19sm1866626wmj.44.2018.11.21.23.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:10:46 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:10:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 22/24] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
Message-ID: <20181122071043.GA41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.414692525@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.414692525@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Add the PR_SPEC_INDIR_BRANCH option for the PR_GET_SPECULATION_CTRL and
> PR_SET_SPECULATION_CTRL prctls to allow fine grained per task control of
> indirect branch speculation via STIBP.
> 
> Invocations:
>  Check indirect branch speculation status with
>  - prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, 0, 0, 0);
> 
>  Enable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> 
>  Disable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
> 
>  Force disable indirect branch speculation with
>  - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
> 
> See Documentation/userspace-api/spec_ctrl.rst.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Please either de-capitalize the title to 'prctl()', or use PR_SPEC_PRCTL 
or PR_SET/GET_SPECULATION_CTRL - there's no such thing as 'PRCTL' 
interface - the interface is called prctl() and the speculation control 
ABIs have their own names.

This applies to the next patch as well.

> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -212,6 +212,7 @@ struct prctl_mm_map {
>  #define PR_SET_SPECULATION_CTRL		53
>  /* Speculation control variants */
>  # define PR_SPEC_STORE_BYPASS		0
> +# define PR_SPEC_INDIR_BRANCH		1
>  /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
>  # define PR_SPEC_NOT_AFFECTED		0
>  # define PR_SPEC_PRCTL			(1UL << 0)
> --- a/tools/include/uapi/linux/prctl.h
> +++ b/tools/include/uapi/linux/prctl.h
> @@ -212,6 +212,7 @@ struct prctl_mm_map {
>  #define PR_SET_SPECULATION_CTRL		53
>  /* Speculation control variants */
>  # define PR_SPEC_STORE_BYPASS		0
> +# define PR_SPEC_INDIR_BRANCH		1
>  /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
>  # define PR_SPEC_NOT_AFFECTED		0
>  # define PR_SPEC_PRCTL			(1UL << 0)

Please de-abbreviate the new ABI: PR_SPEC_INDIRECT_BRANCH?

Thanks,

	Ingo
