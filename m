Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D442C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F712218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLrLnmqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfA3VYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:24:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50336 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbfA3VYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:24:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so382008wmd.0;
        Wed, 30 Jan 2019 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5D0kbBnoBCK2mnYAP7vcUsWHY5gG9f8zf1KjFba3rQ=;
        b=uLrLnmqHy20z15jFhqmY8sZx2+zEN8SH8527bSIXL5m61POVPB7aFoseHAu0iyx7SY
         ZwiTAbBIfvunCtZS4KlUO4Q/gEo6lQ92Z+xrc5oRth5ljkDOUNJNYAHVwnWiUDL6cYlZ
         sX9Dt0pI3K1rq2NEIkEIZ2HdGfkIRv3Uf6pFGYXZIID+EIzKN2CMkqUvG0tXsBKXTadA
         zXJIiRREjt17ifMf4NQhKtG4dX7pLiJmUn4OWJ5mcUSgmnlXhnyOIK4BRw2N/xx9Nl+1
         +sFgvDXZtg9nsQBtFX8bP/PjSvqT8JFYFeNIpq7lDOYEgLDB0SWnV4ZO+EjxPEXGBTqg
         rHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5D0kbBnoBCK2mnYAP7vcUsWHY5gG9f8zf1KjFba3rQ=;
        b=OnGKptNdtRl1/cH03s0TUspiwsHSb9GeAF/qL7/IlnZyo8KhskgEYigPC8tBIo1Mb8
         ABuc1UhtgHEH4ZHP2xhbA32dELUG6ULq7JSiZWOJ/NSrfhxtWBabfuBlqD1Zruf15+R6
         A7UeswcnQJo6RTAlEOBvX7aJQHkWO9K0pwcaaXGv23N7XMzAFaqh/9GnA4vTToNZlYd6
         9lIuGOzoBSSOQayqWYjXM79RpaVnGwIzvzFs73b62mYfRcQvrqpvNoOZwCpH0ij/k7wV
         w8wW4wlrDu/qp7JjNGmF+28R3EWPdnK238IEaVNFp0wjT75M3ze/q9uyhFQhelTn+bvo
         xQlA==
X-Gm-Message-State: AJcUuke+tbVFlEfAdEIrrclAjO4GKgSDcy/8+KL+dgsWtfyFcNCQQ7nM
        uw83+6mH4cyBTca++eNDJw==
X-Google-Smtp-Source: ALg8bN70EhrRYjKHVEtQQKVNRYMW4hXmKr541bzU0nDk90arYQLTpJGc22OzJxit5eglfgZzRBH8QA==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr25350012wmi.57.1548883486379;
        Wed, 30 Jan 2019 13:24:46 -0800 (PST)
Received: from avx2 ([46.53.246.247])
        by smtp.gmail.com with ESMTPSA id x3sm4157476wrd.19.2019.01.30.13.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:24:45 -0800 (PST)
Date:   Thu, 31 Jan 2019 00:24:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 2/2] proc/stat: Make the interrupt statistics more
 efficient
Message-ID: <20190130212443.GA15533@avx2>
References: <20190130123130.785636313@linutronix.de>
 <20190130123615.592071954@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130123615.592071954@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:31:32PM +0100, Thomas Gleixner wrote:
> +static void show_irq_gap(struct seq_file *p, int gap)
> +{
> +	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
> +
> +	while (gap > 0) {
> +		int inc = min_t(int, gap, ARRAY_SIZE(zeros) / 2);
> +
> +		seq_write(p, zeros, 2 * inc);
> +		gap -= inc;
> +	}
> +}
> +
> +static void show_all_irqs(struct seq_file *p)
> +{
> +	int i, next = 0;
> +
> +	for_each_active_irq(i) {
> +		show_irq_gap(p, i - next);
> +		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
> +		next = i + 1;
> +	}
> +	show_irq_gap(p, nr_irqs - next);
> +}

Every signed int can and should be unsigned int in this patch.
