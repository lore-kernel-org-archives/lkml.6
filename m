Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32137C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpI38Nwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBTFFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:05:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41277 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfBTFFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:05:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so2961029pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPG/3IgVVJtfJcyr4D3tTpSa7qtDnoVGQnj7ETgLIxE=;
        b=PpI38Nwe7xsxY+lYOheR8+uRCgjPsav0OOhbxcbr3G9FEfxMGpisv/UYWGQLDtFibi
         dcjb/dLxn0ptQMCgyIlRAkPwno1KkMBn3OtKjSKJzoRZiIXDR36O6eJz99w2WoBkGpUd
         EMQW5vSTX1YgtVsizl4MIl0KJTpGG3pOg/pUZzxH8o/knp18Lf8HOh3zciAGwkbwmJO+
         IVvgJWWtoo8dfG23t/xufggFiwK2O3qgFpq5PMCf1EKO5LAmh44JjCWHzaX5nCoSJyC1
         BXTi3ebawO360wMBJZrKeMKAkXal9q/I/1qoqsxqo72+1JYgwZDIEzMf/XmVAN+tb4X6
         Kn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPG/3IgVVJtfJcyr4D3tTpSa7qtDnoVGQnj7ETgLIxE=;
        b=LHIWnongCi1ozM18NAm9qMnkjrKMduyqQ2QsIK0jJNXqvjVdVVD9JY8ZOUt6KOmkSQ
         DW21h++/txnF/gPoHxpqMJ1xl64LCBtlcJzpSOq3HyKXSqiw4IKhr5VchD4RhVK9Kw+l
         0ePYuwn91Zf1Fj4brNEjgTApI/0I9VXfqatsl3MSzFubURByrsm/Hvos0r/yzSdhoFeU
         HAZqP6XGG/w1JIimvGjPN4qDWIWvuP4iW6rTdkbXezGx8qAUtivemTKDnIxxXwnYxpNA
         g5CudfnODSDg5MaE7Mnffmv3bUJ+z6RrXgoIcXKqLmzW3g5tj5NR4MonSa7BPWbNoVwf
         +qhQ==
X-Gm-Message-State: AHQUAuYHQuVPLAuKEDfn6QgTq8N4p0pibhWnQizAyokqVgxNttInoZQV
        4bKedpu6vKIxwevybDyTqV2Sxw==
X-Google-Smtp-Source: AHgI3Ib/WZ5qUW+j8JKSzOV/eewWpSMwNM85hLwaDv8EfUVqolHtGvNL8MzAGHairSggblAbu88elQ==
X-Received: by 2002:a65:620a:: with SMTP id d10mr26711399pgv.75.1550639138957;
        Tue, 19 Feb 2019 21:05:38 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y133sm23568308pfb.107.2019.02.19.21.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:05:37 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:35:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] cpufreq: Assorted cleanups related to
 cpufreq_set_policy()
Message-ID: <20190220050534.sh7skhm4t4mqcdss@vireshk-i7>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19, 00:21, Rafael J. Wysocki wrote:
> Hi,
> 
> There are a few things related to cpufreq_set_policy() and cpufreq_update_policy()
> that increase the level of confusion thereof quite unnecessarily, so this series
> attempts to clean them up.  Please refer to the patch changelogs for details.
> 
> Please let me know if you see any problems with these patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
