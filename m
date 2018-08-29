Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA75C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A09E2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC7iT4DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeH2WyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:54:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37710 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeH2WyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:54:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so2198214pgo.4;
        Wed, 29 Aug 2018 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NDrzUZm901/nMcWqi36Qs4oyeMMxHJABu56mgrU/GkE=;
        b=OC7iT4DRMK47M+AZyzGcibBIjHAmCWGCMVWXXlIpa8V2l39RPqc84HnIKvz91g7jRn
         9BJZic949aAEWV0o+cm24iKkeftFnWJyw0fFi/r2LJ2tiKvhnORTm69cag2vZEjRi1zF
         F1UjPwfzvvQFJoBefIY2aRVO4PNVmkHA+UXTSobaT4kbcRf5czE8RWtZyQ4BGZj60IfO
         ZHfGeRe+NMHGOkYrsXglkw5tTN2xvch4zqGcL3s0FIOwRUe7kxk6hsaOTPUdkvFaM1yu
         AUfX9UjB8xu4/R78wKrjog3zAaMUORtXiKZn6228hOeZNPdvcllpVCRweJ91rIhegrmh
         V7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NDrzUZm901/nMcWqi36Qs4oyeMMxHJABu56mgrU/GkE=;
        b=js9+SDNHQ3UkKzNWR7/pJjLpvJv7wezVI5m6Ekr1zPaBWkTptLzB7u4uqwLb3dZHx6
         1sLpp2SILqgq1PUTEj4f+NFTv5o0GI7YdpwMx4DVz3/y8soVTOSLOtYsLPM4icqu/5RW
         FjWkSWuewL0TFQsTjvnabMUorZ5IVDGf5AonuYab11Wy2U3Js7xKQSRGsaJo4Gc/d0fZ
         rLeBmlGBFsDY1h+GD5mNUGmt+RKgdRIf13iG8J+gP+hPPUtCvwlGhTCvNNmfC8ICA90i
         ohguw+N+FgMDif4hldviiNuXmRnJ4C2tSQwmMJBjpszeSp4NZUeO0vDr26Ij90PvfVbR
         7q+Q==
X-Gm-Message-State: APzg51AhGqa/PXaigp4edKoVgE3RwOE1M4nNlKnPHXck4D6MBvndI4d/
        ZvEALJyh3Ov2VcxDBkKKn3iYtav5
X-Google-Smtp-Source: ANB0Vdbqdbzx3J5UpcidWW3s/m7Vb5yqdmtfpkpl6ZfoKtuYKMDLUnUjisogPnhK8786GSdRUXYTeQ==
X-Received: by 2002:a62:990f:: with SMTP id d15-v6mr7185901pfe.162.1535568970956;
        Wed, 29 Aug 2018 11:56:10 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6546556pgr.41.2018.08.29.11.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:56:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org>
Date:   Wed, 29 Aug 2018 11:56:08 -0700
Cc:     Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7202F39D-B4C2-4FA0-868E-2D03BD313BD7@gmail.com>
References: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 8:47 AM, Andy Lutomirski <luto@kernel.org> wrote:

> In NMI context, we might be in the middle of context switching or in
> the middle of switch_mm_irqs_off().  In either case, CR3 might not
> match current->mm, which could cause copy_from_user_nmi() and
> friends to read the wrong memory.
> 
> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
> 
> Cc: stable@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> 
> Nadav, this is intended for your series.  Want to add it right
> before the use_temporary_mm() stuff?

Sure. Thanks! I will apply the following small fix:

> +
> +#ifdef CONFIG_DEBUG_VM
> +	WARN_ON_ONCE(!loaded_mm);
> +#endif

Will be changed to VM_WARN_ON_ONCE() in the two instances.

Regards,
Nadav
