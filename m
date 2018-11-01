Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A5EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8436820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhnkmQQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeKASwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:52:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34281 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKASwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:52:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so1418590wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBqxeoCyj0BGEXfgiUXau9w/F3jAnIhzFpUb3272UX8=;
        b=MhnkmQQYyZKToMdSwCJ+xxb4hhILdPkncn7Er6NcppKDPRvUEHScJFFY7PRa3RaZ4v
         78Wttp2hRAYZCa+LSb0I8mnNHGCq3zeMgvOQwQB5498bltBDIlZQDw9cfHf1yLmzJIF8
         ZU2TeX0ePFdIZtnnE23fnLZUfT1WRS7QqfWxmmuuG84rvTJIbbJ2bfcTfNLSASWGk5Y5
         oKLIp1oxKXloUgNH7AP4qk2SN2ZIu8FyguSonknMc5aGpab7mPQ//fg71Z4JL8BOaq/k
         wRiqW+s3DCdQedUh8Ta/PDAYxyNlqUnQ5ImzSeFGaPgONG8Xy2DV4U58JwKLEBnshVID
         w2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBqxeoCyj0BGEXfgiUXau9w/F3jAnIhzFpUb3272UX8=;
        b=D8zYvTbd1iLInPL4OwU2vofwR9v+CHh2jSrg4SEfBvfqtF9hifXuuN/W2PS4dnyQm+
         7Oiqy9sEHM3XoWbEi9wmGQPErwSWH+8sqYeYDolIq0ibURQs3nS7ufqRWfrdAH2nUusc
         YokTcnCxKkiZDClxvIkXhS5hDkkv1oOco3hxHhZlDLXZgUkpXX5LKnDwuslX5QZqy/Dq
         X7Ym4YLXUww017JnUNEb9l8LfWKkwYWFZnFnBWMqUhmHvQIEWA7k1aq3gv0cDRahy126
         CzTolEYvZPn38BH3EzoreMUcfa/tCAvHS/k45xm2aQWQYGmWdvK29yGXyCppzfq/0/Bk
         nd7g==
X-Gm-Message-State: AGRZ1gL0Gm2YZhrR295PqkXguBTofXqPk1z8cS+d+JlyWt/LRFGsZjT0
        AHe2wzgW7uhmYbsSizpSeik=
X-Google-Smtp-Source: AJdET5fafwEqTIzOMNHFG6MG+ZrN27XWYFd4RKAek5N5PdZpgyq5fQA9pcBkSO1iAZR7J5wyZIsfdg==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr4955269wmb.118.1541065805366;
        Thu, 01 Nov 2018 02:50:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 68-v6sm14027502wmg.26.2018.11.01.02.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 02:50:04 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:50:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, luto@kernel.org, tglx@linutronix.de,
        dwmw@amazon.co.uk, bp@suse.de, srinivas.eeda@oracle.com,
        daniel@iogearbox.net, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, peterz@infradead.org, hpa@zytor.com
Subject: Re: [PATCH v2 1/2] retpolines: Only enable retpoline support when
 compiler support it
Message-ID: <20181101095002.GA118944@gmail.com>
References: <991cbe9b-1e31-4b12-b572-91fde5c79699@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991cbe9b-1e31-4b12-b572-91fde5c79699@default>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> Since retpoline capable compilers are widely available, make
> CONFIG_RETPOLINE hard depend on it.
> 
> The check of RETPOLINE is changed to CONFIG_RETPOLINE.
> 
> This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>

Please turn such 'based on suggestions' into proper tags as well, i.e. 
something like:

  Suggested-by: David Woodhouse <dwmw2@infradead.org>

>  config RETPOLINE
>  	bool "Avoid speculative indirect branches in kernel"
> +	depends on $(cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register) || \
> +                    $(cc-option,-mretpoline-external-thunk)

At least a comment should be added that this is the retpoline feature 
check for GCC and Clang.

Also, whitespace damage plus the two options should align vertically.

Thanks,

	Ingo
