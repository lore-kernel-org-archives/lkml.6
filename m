Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35BEECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8B1213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RQ0HX34g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbeGLVEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:04:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38161 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbeGLVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:04:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so1279090pff.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f8ZSPRZo768TF/i9atQ4txmDK62DlnKH3AqwZUM8fp0=;
        b=RQ0HX34gRo1zruHNoZxf9oOjEXZ67eNz6DUEo3y3nN9+y5hEmWpNsn6QTRZlLWU73r
         1yBYREi4KeMslncxzLLDY7SDagYoiVrIQTA81pwRfXN84iSQ2E7gDu+luilRODg3hY8Y
         ud+t4gMh+7A9ScVSAz8Fx9KviWREiuoM0ZE8T8oIfWl3QXRJ23DsP9O9Ggq/4UtENVy3
         HO6afk81Tvf4BgWGpC5axxr9RLx5trNMg/9YBfgH/2zTtmre1+YYrLNMO8ZTjpquJWge
         o6zJbQV776mtv/uPYukJtKeoddbkV5IBQg253OL/xMS0rHd8VB+upibUFGS8BALwrsmN
         EOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f8ZSPRZo768TF/i9atQ4txmDK62DlnKH3AqwZUM8fp0=;
        b=EpLWQGF2zyyLglnWmnUsE1RY1NB+67rWxTQcEHSgccQormtnuSX0ncrBBHcZxYfYwh
         rPeuxf7gw3SRmi99xlLoBin/2MNixzPnPJyKmZkvuSB/3PPgFPaNVC9RuwYnPiipWGel
         /4AVW6AbV6wK1poxDwqd7Y1XbPuiGfJlcXIYB7KNzb2x10VfsPwUMnkkU9BkrI09A8uK
         afkTZbmVWfkc70Sw70cBx7sbDJD04xtczqrGG7O557l1SQDdpxemEK6SLTIDPLFitB7U
         a/JIuxIYSbaUdQnZYy9aCgBbkhgObSpj2d5EHx9RKcy63o/VY4LE1rTGfcGofeAXC7AU
         p2xQ==
X-Gm-Message-State: AOUpUlFLJrUEz4d/wB5B5odQcnNnuMRMv4/+DT11fZOPVLQyBUuhOogw
        2zkdzZ2pnI+H3yn5HrDJO2+Vmg==
X-Google-Smtp-Source: AAOMgpfpH3GSwvalCkEpTsZmQ0BWUAzzHnjGE3wBuFyzt76nh+3x0Qy/VNBDK8KOZYUqXPR7K7eXzg==
X-Received: by 2002:a65:64cf:: with SMTP id t15-v6mr3430283pgv.79.1531428802530;
        Thu, 12 Jul 2018 13:53:22 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id n9-v6sm19468348pgp.42.2018.07.12.13.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:53:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/39] x86/entry/32: Unshare NMI return path
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1531308586-29340-6-git-send-email-joro@8bytes.org>
Date:   Thu, 12 Jul 2018 13:53:19 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Content-Transfer-Encoding: 7bit
Message-Id: <BEEA447A-26A1-49C9-925A-63F96E9115B0@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-6-git-send-email-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> NMI will no longer use most of the shared return path,
> because NMI needs special handling when the CR3 switches for
> PTI are added.

Why?  What would go wrong?

How many return-to-usermode paths will we have?  64-bit has only one.

> This patch prepares for that.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> arch/x86/entry/entry_32.S | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d35a69a..571209e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1017,7 +1017,7 @@ ENTRY(nmi)
> 
>    /* Not on SYSENTER stack. */
>    call    do_nmi
> -    jmp    .Lrestore_all_notrace
> +    jmp    .Lnmi_return
> 
> .Lnmi_from_sysenter_stack:
>    /*
> @@ -1028,7 +1028,11 @@ ENTRY(nmi)
>    movl    PER_CPU_VAR(cpu_current_top_of_stack), %esp
>    call    do_nmi
>    movl    %ebx, %esp
> -    jmp    .Lrestore_all_notrace
> +
> +.Lnmi_return:
> +    CHECK_AND_APPLY_ESPFIX
> +    RESTORE_REGS 4
> +    jmp    .Lirq_return
> 
> #ifdef CONFIG_X86_ESPFIX32
> .Lnmi_espfix_stack:
> -- 
> 2.7.4
> 
