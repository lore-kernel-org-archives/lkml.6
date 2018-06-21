Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF05BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99F520837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAO7j46w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99F520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFUMcx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:32:53 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33563 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933675AbeFUMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:32:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so2768653oiy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksWf7PO1RkuCKYAkyFetbv7366xS9mHzoZ3UYDMiqGo=;
        b=nAO7j46wDT97FFbwz0iUbYJLznH0RsaSCnQRNulZIW8regsLoaKtqB3f5p8Y0ju8ly
         /8NE/1gEGZlXgCfSOtFFalo2l3PyCcOoxg7Py6mQkkmoub6TplTVVLCdrlcKQ6X1OARB
         YrcqjYBk19FpLnWdyWKkwEyRpeeER42wdmdUCeMLmizFt0uBdFs0qj0PegOyDy0ryT5t
         JR+jsXYDW1JS9u3e86YsXQZnvlISukK1CqI0SEOJl/WoG4bKAGR32EQqhVtsdQMFli3l
         vso1c3G1xtG+eN4lEPEvrCT4UvVHfaiyqQssXKudpY9A7IyPiG7A4aHI5jIUN0jOeAsN
         VhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksWf7PO1RkuCKYAkyFetbv7366xS9mHzoZ3UYDMiqGo=;
        b=lRrutSFXul09O4vFYpx6tnnN48p3gOIjEOxTT9O9btNHnFtMqmdRCeAnST7nECO4rS
         ytjjEFrIgFYlJ13BRjPTwwFYKPtMuIix6S8+wZ5p87U4kurqp02HLNtsxBSlAeRIMUwF
         G+q+pfxeJHEVlnYD14E1GV+hE5iU5zXuRif7Gkez3J2KHF7ley+KzUkfuJLuWCMrgGvE
         gJy/Ju9OJfpkbdY67r7h4POKhsBwZkivt0a2h2TrTfoccTenZ2WgpYQXeBQlcgjZqTyk
         RiAytuJQ6KKSTBQ9F9SNSGfpEn4gczSQnFqoRu/SN0YMLFyIAXRa1BfUekuS2P68HPiY
         zJDQ==
X-Gm-Message-State: APt69E3XdyH3wQDmWTNHi2cnRt4LDLGyjf2j3Qnp5r0BKv7Rky/1vLDX
        q5C+GeoLAGKj84zetxAcx4WCCdat3fcEzX1dTE/Vrw==
X-Google-Smtp-Source: ADUXVKIhd5EJNSB8X6WRWApP/oi1ruLXJUim42TGry6FOpZ2RvZsF7yfvUWFx/U/icXxMvxv/CGQcemwKQiyUR1FTbA=
X-Received: by 2002:aca:ab15:: with SMTP id u21-v6mr14683858oie.272.1529584369880;
 Thu, 21 Jun 2018 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com> <1529532570-21765-4-git-send-email-rick.p.edgecombe@intel.com>
In-Reply-To: <1529532570-21765-4-git-send-email-rick.p.edgecombe@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Jun 2018 14:32:38 +0200
Message-ID: <CAG48ez1QbKgoBCb-M=L+M5DJHj0URhNvS34h+Ax6RudckgCEEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vmalloc: Add debugfs modfraginfo
To:     rick.p.edgecombe@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen.c.accardi@intel.com, Dave Hansen <dave.hansen@intel.com>,
        arjan.van.de.ven@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:12 AM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> Add debugfs file "modfraginfo" for providing info on module space
> fragmentation.  This can be used for determining if loadable module
> randomization is causing any problems for extreme module loading situations,
> like huge numbers of modules or extremely large modules.
>
> Sample output when RANDOMIZE_BASE and X86_64 is configured:
> Largest free space:             847253504
> External Memory Fragementation: 20%
> Allocations in backup area:     0
>
> Sample output otherwise:
> Largest free space:             847253504
> External Memory Fragementation: 20%
[...]
> +       seq_printf(m, "Largest free space:\t\t%lu\n", largest_free);
> +       if (total_free)
> +               seq_printf(m, "External Memory Fragementation:\t%lu%%\n",

"Fragmentation"

> +                       100-(100*largest_free/total_free));
> +       else
> +               seq_puts(m, "External Memory Fragementation:\t0%%\n");

"Fragmentation"

[...]
> +static const struct file_operations debug_module_frag_operations = {
> +       .open       = proc_module_frag_debug_open,
> +       .read       = seq_read,
> +       .llseek     = seq_lseek,
> +       .release    = single_release,
> +};
>
> +static void debug_modfrag_init(void)
> +{
> +       debugfs_create_file("modfraginfo", 0x0400, NULL, NULL,
> +                       &debug_module_frag_operations);

0x0400 is 02000, which is the setgid bit. I think you meant to type 0400?
