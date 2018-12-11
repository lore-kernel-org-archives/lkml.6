Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB530C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FB420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YDRs11Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FB420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLKSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:41:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36359 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLKSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:41:58 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so12678964ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aM0+tGaa9kX4JzS0KzV4o9AhtbYFxa2/mQ6p5j8hKME=;
        b=YDRs11TkjZM3iblmX8W6dUkmMmc8dgaFLRXLgy53AmR8PNo9lSSi65Ba4ijRyu2hbX
         AayZRhuqzrFGKtv7Yi7dmVi94x7ENHcSKGTi7vt5Cpk47RGyRXOtWglLHaQpxPGOazQm
         So5y38PVXi6oNdRaK6BazE21Vtj7TBOLMsLjqTpRZUWUY6Bwlhxg0TqjmAzr+q/jtysM
         /AuXrGf7E+acGpP8qj3KxfTGBFn5MoJhZgrUg4at1zWLCRr9/Gv+VmpVolNzTwp1DADH
         YBc9g7NPsy7xL7CEaKy3MV0j3vd5I0m6Jp7jbW/mx18uXYm8euPqLDHRca3ValUxNTpI
         FVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aM0+tGaa9kX4JzS0KzV4o9AhtbYFxa2/mQ6p5j8hKME=;
        b=X5lkMFB0AonxZ17FxJkNtFA+2TjkRo0zsR14fmJovYjU9WG2qMJZRgM394z0UrcjlK
         rPrBwDNzS74Te/r+KRMUv9X41ctrA0ymXd0NHxZX/C8b5Z5Ij9TSOe51KQ0WK2q9arPr
         FuDf2xFSlHTq0LSzct+sr1YfBQK3WuN5tDaSVCiW7g3/dZiw7cPoogh+Y8auLfUYLsz0
         8jkGWhK96JEmnigyN1Ub4m16Rl6rtr6OLOMbf0uBH05UQZMCE5DLDYwTupMdN2YonPd1
         5/1KE2Kpzbb34F1/0f1CU9ehkcwN37H0VLFin5ltSACGcapC3bHsK3KE5icD/yY3Re4+
         uriw==
X-Gm-Message-State: AA+aEWbaGL293dCv60Jva5aErInkarbwwSJyYVreIfpFSExzfUjVFP7a
        nfVZ+eOdyYj6m91nr9i6EDZAVg==
X-Google-Smtp-Source: AFSGD/UbyPLEK3sR4CdnsOHDBxQYzDVDe3pUQQRwhbqEedkWsvVgP0psS8n2GmjhzibHSZrlZ9lQtw==
X-Received: by 2002:a5d:85c5:: with SMTP id e5mr13362205ios.125.1544553717346;
        Tue, 11 Dec 2018 10:41:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o16sm1619240ito.19.2018.12.11.10.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:41:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20181128183531.5139-1-willy@infradead.org>
Message-ID: <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
Date:   Tue, 11 Dec 2018 11:41:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128183531.5139-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
> @@ -1026,24 +979,17 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>         struct aio_ring __user *ring  = (void __user *)ctx_id;
>         struct mm_struct *mm = current->mm;
>         struct kioctx *ctx, *ret = NULL;
> -       struct kioctx_table *table;
>         unsigned id;
>
>         if (get_user(id, &ring->id))
>                 return NULL;
>
>         rcu_read_lock();
> -       table = rcu_dereference(mm->ioctx_table);
> -
> -       if (!table || id >= table->nr)
> -               goto out;
> -
> -       ctx = rcu_dereference(table->table[id]);
> +       ctx = xa_load(&mm->ioctx, id);
>         if (ctx && ctx->user_id == ctx_id) {
>                 if (percpu_ref_tryget_live(&ctx->users))
>                         ret = ctx;
>         }

Question on this part - do we need that RCU read lock around this now? I
don't think we do.

-- 
Jens Axboe

