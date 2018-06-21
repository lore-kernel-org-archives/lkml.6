Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5137BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666E20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEHLoZeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0666E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeFUNFS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:05:18 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40556 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbeFUNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:05:16 -0400
Received: by mail-wr0-f176.google.com with SMTP id g18-v6so3126195wro.7;
        Thu, 21 Jun 2018 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCh7EFs69hk2qkkTxodU/f6Q+yOHsWaFsQlsaT9Zlp4=;
        b=bEHLoZeLKw7xx6xeg4/3LeAjNZ5k/JgDdyEMcTDa0Deq3bkoECTZXwJtR1V+6Or1Au
         bYK7M1ptG3r4e5VXqGr+PpvIeBShRyNovsFlJigCuyxpBZrWHTL6bzILXPPgEVwm+GPZ
         jJpnu/s8Lu4feQmANQQ0q7EPNM4857UixDPBOig+lHy23yL7o1G89OwQl3Ru8fFaI200
         kKqGuCpWtPu4qXsf+yuxnPnwuvO9LDdwA02SftBmmL67hHgEtOekridJkkVAb1aOhlc9
         8zY2WyaG45o5HLHyw6AxC73AsApBO1dyOYm4tQIQVfGSvzCswTdsa1IBQEeo1QTixusH
         tAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCh7EFs69hk2qkkTxodU/f6Q+yOHsWaFsQlsaT9Zlp4=;
        b=TVSIUVRnLhgXy4E3/fl7dyQEisI/qHPPcLe/EipZbYInaozOsHh917hFAXsOX6oTuu
         zbZpDR9AQruvXjckUbi+GOrwJO7+CnnQaOEb/3b08+g7stfYShiKu798u1dil8ndouU9
         UliYtLDdKjwpXS6GBjSH2UvVqoUr4SrXlCrkPtYMgRBNaRAqM/4pU2RuIeS/tBnC7Wkh
         OR+AzmHXW2bsUqDffCZ5uiXvw5vh+bB256E7rrTEiGhKZGeTXk/ImETYNRjmPzt3udAI
         0T/pny0TkCgQYcQT3+PR1z52YzboKiE2YbHpIOSUOPuac7WKlhJEcfDUEIc4mvgOP3Vq
         8cww==
X-Gm-Message-State: APt69E3sNQyfyrhE5gtN+yaJ+PT971jtl0XhcecOi9lT7KdW/wC5hDPL
        6vW8prZyc3Xi3ES0kohFcVU=
X-Google-Smtp-Source: ADUXVKKtZQKM76sBZ0OqzNyyTjjX97/oXYw7daiXaDL2JaJFGSxDMR5fSkcXST4mDV0TwgRwsgi/Ug==
X-Received: by 2002:adf:a148:: with SMTP id r8-v6mr20985869wrr.104.1529586314719;
        Thu, 21 Jun 2018 06:05:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l15-v6sm6653063wrs.95.2018.06.21.06.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:05:14 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:05:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 5/5] Documentation/x86: Add CET description
Message-ID: <20180621130511.GA7895@gmail.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
 <20180607143544.3477-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607143544.3477-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> +Control Flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programing (ROP) attacks.

So the obvious abbreviation would be CFT or CFET.

Exactly why is 'CET' used, which not only has very little to do with what it's 
supposed to mean, but is also a well-known timezone, Central European Time?

Thanks,

	Ingo
