Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E4ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1858F2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1858F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeISQJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:09:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40678 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeISQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:09:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so4610323oig.7;
        Wed, 19 Sep 2018 03:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t80l66fIKlf3lFTqenjvPD6QDjQXcdP3r4ln+OMnII4=;
        b=b43HmdH9YUXEP/Dq0Od7FGwncfvk8OFhtVmagOjxbxvelBrnvDjdL9C0Ibi194YD3A
         888+Tzo5nYJsvZkCRd0by09YMutZhOZ7C+ewB/mj6tm6qB0ChSNESnE5y3c4Z8oJaxy+
         KVGJqvuUiYz411gaSKkCtMZEJXE4eCGV2MqSH9p7D+Cg9V82Jxs7KZQve+m96rU7H7Ls
         BcNOKAIQ0sQ1MgSI7Kab5yoCwVwdowRY0npd8GS7wioQISNyK1f2xOh53b5aEASGw5UU
         brOFxLT5ik0Gf9LiH58DST/vMUcpB5I1Nk1E9dHa/R7JYNbX48tk/MB9ZoMRYf5vOi0I
         rYrA==
X-Gm-Message-State: APzg51AuUAmaI79RdHW9hKY1XroXwVEmbwhkPxuYOVDdsFkQHBxsysNn
        z9VhZc8XTwK2ebRoNXyjbdksNyLu4TETOMH51yY=
X-Google-Smtp-Source: ANB0VdYrAqhElR1c+gY4chdLxBgTHTc6996CbOZzkyh3GwWU377J2nDY7/hplc/SKtqVj1AtuIy2Tl0z/mbXbm/Y24Y=
X-Received: by 2002:aca:4141:: with SMTP id o62-v6mr1258325oia.24.1537353114216;
 Wed, 19 Sep 2018 03:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <ec80ac5b3ef0505e4f4786c4ed1e4f88a7770f12.1537275915.git.yu.c.chen@intel.com>
In-Reply-To: <ec80ac5b3ef0505e4f4786c4ed1e4f88a7770f12.1537275915.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 12:31:42 +0200
Message-ID: <CAJZ5v0jHZDCqCS=rT2G1Vx4Q1xH52TtJWurH_5Y4mVM=M=BRYQ@mail.gmail.com>
Subject: Re: [PATCH 05/12][RFC v3] x86-32, hibernate: Enable
 CONFIG_ARCH_HIBERNATION_HEADER set on 32bit system
To:     "Chen, Yu C" <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:32 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> From: Zhimin Gu <kookoo.gu@intel.com>
>
> Enable CONFIG_ARCH_HIBERNATION_HEADER for 32bit system so that
> md5 check is enabled and prepare for relocated code executing
> and jump address mapping.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..e8de5de1057f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
>
>  config ARCH_HIBERNATION_HEADER
>         def_bool y
> -       depends on X86_64 && HIBERNATION
> +       depends on HIBERNATION
>
>  source "kernel/power/Kconfig"
>
> --

In this patch, in addition to the above, I would start moving the code
in hibernate.c that you want to be common in the end out of #ifdef
CONFIG_X86_64 blocks.

To start with, that would be the checksum handling code and the parts
of arch_hibernation_header_save/restore() that refer to it and the
"magic" value.

I would continue doing that in the subsequent patches to make it
easier to follow which pieces of code start to be used on 32-bit after
each patch.  The impact of each patch would be more clear this way
IMO.

Thanks,
Rafael
