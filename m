Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7883C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D6F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545731474;
	bh=Gi5k5+ptbkiEuD7LNwS4ECh/mPZYch6AEb9vJtngE4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ipN8BTT3qTZfXSIcNkPUPNw1O7OMbmLjVRAyFwNtYGoW3bo7OKdAqrPHV3hqaC8rZ
	 ZhvJOVrWF3SXvG8z9CJWMCdU7nLrBofNopvPv1y2kt9/jNdaYZdNDIrWNb1eDsItAJ
	 6Our6lLU3cpME+QqkBdFSXFls4w3OaCSCSjt3Ync=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeLYJvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:51:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeLYJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:51:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so13336966wrt.7;
        Tue, 25 Dec 2018 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0agTVvWPKMrLLQ/KuQiWluIWhyuS5SYlwlmBxGJZaho=;
        b=qJttlpSvwqWJ39aBfgLPbF2o4TSvcSLldaup/k7ElT54eDZCybOxJc4TADrndMhzZI
         t0BOmDFPcF43nk/0ups/jpCf9tZHkG+5hwjYGIE3EmrhWAsAYQbQtK3bCtR56NOgyP61
         wRA9DZ0QlLVxH15olR64j5oAItkDgiL6Ky9M4QuRy66w0shVnsJChFL/TgoYIXjJvdcg
         luDvmCqBYwjF6SERBmCl1BqMzV/wRbujLOwR9m0uGXMovSSTHQdwPm/rduE8x3YS4UDz
         wjO9NhTsLrdndMgDpMrTkJLH2ZbkhqCZkZWVWwSk+KVctkYXjtNQ+I7pl65QDnWnymj4
         Yuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0agTVvWPKMrLLQ/KuQiWluIWhyuS5SYlwlmBxGJZaho=;
        b=ewlLe/uvrT5Y4JfsceXyaJx0YuPkMurQvhsFId7VyIhbSC28Q8YmRWLn5723Z0KhLM
         z2tFWqV5xcLb5GKji/RLhcuQddi1wXi7soq2UAclBZS8oSaovPYLHnMWyrP076woyQ2p
         swokSBkey9h0bsxanxYgNc/EVF4f8qZPH9+uRidkgWnPHyDQbP99tSiDkV2+EGRT5rzy
         DWD94HHiDplJkRBZ8T/YwrI4eD1suxSLeew0U7ymuXmKKRWafbw6bZ/AROh7WpB4QW0Y
         +IahGkbCceShGuDiChBE/DsUHsHP6xgRXgsaK89kGvBIFaoNWFsjKnYINvLjAeCwdsv7
         en6A==
X-Gm-Message-State: AJcUukfEmEE89wxYROWwU6PfN7UXuQDh34lLMWl1ZViGltkekedG7oP6
        fhKUZ/pEmKS8fdBg02QjDV6F5Nkm
X-Google-Smtp-Source: ALg8bN7w5iIhtfJFJwQl8YNzN+RiG9xz5jtXwPljgISK8vcIU0o8rm7cnnmkqbyCGLAWVbLVG+xgHw==
X-Received: by 2002:adf:b649:: with SMTP id i9mr15256846wre.70.1545731471037;
        Tue, 25 Dec 2018 01:51:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x186sm18319658wmg.41.2018.12.25.01.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 01:51:10 -0800 (PST)
Date:   Tue, 25 Dec 2018 10:51:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: Don't unmap EFI boot services code/data regions
 for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Message-ID: <20181225095107.GA100072@gmail.com>
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
 <20181222105410.GA130780@gmail.com>
 <CAKv+Gu93dgfXsq_sRzvXBw-h=8pn2BtrQLtpwtjK51potpOtdg@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F4860813C@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F4860813C@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com> wrote:

> > > > +     /*
> > > > +      * To Do: Remove this check after adding functionality to unmap EFI
> > boot
> > > > +      * services code/data regions from direct mapping area because
> > > > +      * "efi=old_map" maps EFI regions in swapper_pg_dir.
> > > > +      */
> > > > +     if (efi_enabled(EFI_OLD_MEMMAP))
> > > > +             return;
> > > > +
> > > > +     /*
> > > > +      * EFI mixed mode has all RAM mapped to access arguments while
> > making
> > > > +      * EFI runtime calls, hence don't unmap EFI boot services code/data
> > > > +      * regions.
> > > > +      */
> > > > +     if (!efi_is_native() && IS_ENABLED(CONFIG_EFI_MIXED))
> > 
> > AFAIK efi_is_native() can only return false is CONFIG_EFI_MIXED is set, so this
> > expression can be simplified.
> 
> Makes sense.
> efi_is_native() returns true for 32-bit machines running 32-bit firmware.

Forgot to mention that I performed this simplification in the commit I 
applied:

+       /*
+        * To Do: Remove this check after adding functionality to unmap EFI boot
+        * services code/data regions from direct mapping area because
+        * "efi=old_map" maps EFI regions in swapper_pg_dir.
+        */
+       if (efi_enabled(EFI_OLD_MEMMAP))
+               return;
+
+       /*
+        * EFI mixed mode has all RAM mapped to access arguments while making
+        * EFI runtime calls, hence don't unmap EFI boot services code/data
+        * regions.
+        */
+       if (!efi_is_native())
+               return;

Thanks,

	Ingo
