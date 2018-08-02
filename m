Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62FD214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTOlH4HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62FD214FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeHBP5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:57:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:57:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so1373424pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBRCGiBOBUU5hLfpePyfcLx7elxeb+CyoztPkEngAwU=;
        b=HTOlH4HHt7iVHxT6sv8hFqcwbQ0gRNzMk/xHdfrg/PdWwxsEZRRH65phTVusAAXK3n
         8RQYUwTrJgz+9673EUSsE9hORHG6rczRTC+ZmwqtKZ8SbPMdFEFqrUTCHIkob0MLvEG3
         HJacLOUSEqfwTiMDoxL81a+Bk05Tns+fNdJuwtLZWsfl9mpV1Nfm4lW0HFTDmJJZvcO/
         OB6FXO5Z4jIVxQVZFzzLqNtQ9RT1ZC8TgodRzhPcbyUbHRjQKSVKdQ4EE6aLRxgsRlkW
         SZ54H6duEZD6ZFs6H/Q2vx1sO4XMBQMU4u0t8KD/N/iKVtYdZHfbh/XpsRHto0okYB3M
         XCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBRCGiBOBUU5hLfpePyfcLx7elxeb+CyoztPkEngAwU=;
        b=Npg+V9OYkYfd7z8mauYkEKfGI68keH1VLDbXtea6aihAEtToLhiOjk7W9EGWZt5Lnm
         MFFrY9yIaiWwzgyhmJ1MfGQhDc0fvTymPsUHaSf0v9mmv3uE5Ue6Px53M03yQmOWN0GB
         L189BiU30tbI/4qQtmmFbNzdTB2MrT8sQeob2miOqKhQaOvGniOEUJR19440d+R/qvSb
         uj3ku7fpaJ5rU3HX4qqoV5CJUJfabeJdB78tQnyHcwHQz4RJ7VDjMvfXTrbpXDYAA4HZ
         spmgupH2IKKIHPVHhdRgpuxLuozKdHkGRmZq87FBNee6+hdSkIHXMEnP+6lmvh61x6gq
         +Msg==
X-Gm-Message-State: AOUpUlFf5DeXQSDp/NwlWcEN/jsV6kvZAwqqL2s0yltn4MdujnwALcX3
        97b9P9fNbKXz23CakuuUlL/jg94P
X-Google-Smtp-Source: AAOMgpeGAdcsHRTj6X1YgdmSgCmNcwe3EYMPF4PkgUSD1xiwVhe99g4eG6etDdg22s9wjZYOPDFn5w==
X-Received: by 2002:a62:ad1:: with SMTP id 78-v6mr3151978pfk.57.1533218759752;
        Thu, 02 Aug 2018 07:05:59 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([61.69.188.107])
        by smtp.gmail.com with ESMTPSA id u69-v6sm2910410pgd.43.2018.08.02.07.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 07:05:58 -0700 (PDT)
Date:   Fri, 3 Aug 2018 00:05:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore
 sprs using opal
Message-ID: <20180803000547.08a37175@roar.ozlabs.ibm.com>
In-Reply-To: <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
        <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 10:21:32 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> 
> If a state has "opal-supported" compat flag in device-tree, an opal call
> needs to be made during the entry and exit of the stop state. This patch
> passes a hint to the power9_idle_stop and power9_offline_stop.
> 
> This patch moves the saving and restoring of sprs for P9 cpuidle
> from kernel to opal. This patch still uses existing code to detect
> first thread in core.
> In an attempt to make the powernv idle code backward compatible,
> and to some extent forward compatible, add support for pre-stop entry
> and post-stop exit actions in OPAL. If a kernel knows about this
> opal call, then just a firmware supporting newer hardware is required,
> instead of waiting for kernel updates.

Still think we should make these do-everything calls. Including
executing nap/stop instructions, restoring timebase, possibly even
saving and restoring SLB (although a return code could be used to
tell the kernel to do that maybe if performance advantage is enough).

I haven't had a lot of time to go through it, I'm working on moving
~all of idle_book3s.S to C code, I'd like to do that before this
OPAL idle driver if possible.

A minor thing I just noticed, you don't have to allocate the opal
spr save space in Linux, just do it all in OPAL.

Thanks,
Nick
