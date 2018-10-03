Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10631C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E21206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF9NCtYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E21206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJCMVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:21:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40253 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:21:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so1096859pfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sU+RlzQwpHQmjVHAdy+7Inog0oYWRDZdUfJUv3fYuzI=;
        b=MF9NCtYwq1KkrCdKFnUUmUEY5etDFBsf+c1eCtwuvoXJektvpJFkSGV0nAD6ZgP2UG
         4KC/bslp94rXL42Us9Mll3kBTuekYHSn7BaW1gzuo2K7rR8toTiUorNtdabXXtDyu2Ge
         c0I/8D0S70Xnl22Y5g36kJuA6WxPm2YAQVK+9h68TDpBOf453r0Z+ZxMmEpfz+r3F8gS
         dMV8D5eKK+Vx9CMxCs+1iJbKhFIkZmEzRmlhK1cBr0I4tfpTFOMAQw5bnD1P6OE8EEFs
         qiQteeCbdTWmxrqUElSzxARXmiPQ4BVwktwwSIb2lqFNNTb0T48wwiY3+E9Ti2brw3ns
         yrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sU+RlzQwpHQmjVHAdy+7Inog0oYWRDZdUfJUv3fYuzI=;
        b=sjYxRlj08j3imypTG2AipxnrZ+Lt+bakvyTRPBaxlPrBDLag7kjYmNjF9A2T+F8cwL
         nUcHhKRf//wEbotM1U7cf4KcENR+JZIdebCeC3GumNme9h5nr7/68EAd33y0anky/Nvg
         ZMGd/VHIQZHW1qOR71HqtrdqlA0m6C5DrrgK6ojemYU6HV133cneCf4iFLKRcPtVE5MV
         dBAY93oyWXub1+LnV2d4MUvItgl93ZS+QqBl8bd9GTY9qq9wVheRMf54FTa2VD7bVMmk
         tq0/rJIQAreuU4UL776NY2EslnQOsmA1YQxaw6ZuQfnigY9Y24dGPYt1qSa5NhznT6zM
         P/cQ==
X-Gm-Message-State: ABuFfojVuwdUjQ485XV34U3kWBtMxJxOFj8vVMTEFQvWe6xJ5lhHWUPI
        k7YfNlG8ZsB6fk5FhrsMfx8=
X-Google-Smtp-Source: ACcGV60JAzd6Q4lnhywuiwaHdQvlhCybkh1bM0jV+ZlrpPAbBebvFfQIEzxXf7g/R6qrm1hh+gL9Fw==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr16785595pgv.233.1538544895155;
        Tue, 02 Oct 2018 22:34:55 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id o24-v6sm623719pfa.90.2018.10.02.22.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:34:54 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:34:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
In-Reply-To: <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> thread_info is not anymore in the stack, so the entire stack
> can now be used.

Nice.

> 
> In the meantime, all pointers to the stacks are not anymore
> pointers to thread_info so this patch changes them to void*

Wasn't this previously effectively already the case with patch
3/7? You had thread_info sized space left there, but it was not
used or initialized right? Does it make sense to move this part
of it to the previous patch?

Thanks,
Nick
