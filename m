Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F14C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F5E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549881575;
	bh=R1JncXj2yVfbYpa+LP+2O2yX8b8asbv/7kDx+Ci3ut0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+3sydIlKtpjVYOaKdFPC+T3k4fvjs45x5mDOAX0AMNR2JcuIjjLeTP21+FsoK3US
	 Ofjc6brutPPOARN5AKYg7rXO8bej9vxbyKHVYyjeNh6Y0l/+QjE73TuiE1szPbpmkq
	 C9t4ie4Q23uSN1yqmcRaCwe0U56HynuzztRkGoF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBKKje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:39:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40072 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:39:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so16318144wmc.5;
        Mon, 11 Feb 2019 02:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
        b=GHcTe/v4HLTE6/ZcIf6lGV4ciNnib00F0miBQKJ/h849hGbvpylts6FbdNzfzkLCoA
         kEZJZgxvXWR05iwQH6TglhLsW3luSoxuZSoOafur7xRkm+HucfsvvvyhrGCleinsdB7a
         kOKt6ePQGkkAvZgLGpAqxiZYf0kHWJJX9HQmrFTSGE8lrjQx6tIHXY3u/qip4OWoalqb
         n/9ukgVhnW2jvZYUZ+dkiFka5KTup8rI2fD7QxHZWg9FtOJS57KdgEu1/QdFsDsQrA7f
         f0yTITJvlyuX9LZ89piQz+46mR2R0uLfipoujrOoIEPaGnhfgup0ylO/7xEAA2KaP8sa
         Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
        b=LmkURCwVYtVdJJ/qVp7Cxi2hjo7r80k1wvDKOfGkwJnbVtfBDeTirsZ0P5AkO4w+cY
         6/SJd0aWEwjnCnGexkkkwAmgct8MK3q45YN1iP9JUsZa/E2xRY63VlFQF8MZkYinMZii
         FAlG+YeUtDSw5OkrP3JObduHieGhjpe0hoRF34QbZimodoyF27LJsFRtjMqecNKIG0aO
         bpSQAjA0aWKmJJomhEBX9Vb+4gOpB8OnAoIHy0bycOn68W+2nMJEPP4GzXDZA8hBr/px
         nByPydSFMb26xg/fKJDWShJe2rGpRLfhWdJQRLPB7mshYGURgpLXbd3RsRIfsKIgn3cf
         wEIg==
X-Gm-Message-State: AHQUAubvcY3tPk6F8WYuM/zNV0zdDFo+LVFX944RF3Y3f2TO74OZIrOq
        Iuc8brSA+TFOjwpUg2pBqZw=
X-Google-Smtp-Source: AHgI3IZf3wahjDIx/L7PG9L3qJubpkc8NKYYmZR89WZekk9Sg8y67JBJz4VnSSQGjYaDrsxP6nvI7w==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr20556355wrq.273.1549881571132;
        Mon, 11 Feb 2019 02:39:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r12sm10477719wrt.76.2019.02.11.02.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 02:39:30 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:39:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211103927.GA118071@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211071159.GA55579@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Sounds good to me - I've merged this patch, will push it out after 
> testing.

Based on Peter's feedback I'm delaying this - performance testing on at 
least one key ll/sc arch would be nice indeed.

Thanks,

	Ingo
