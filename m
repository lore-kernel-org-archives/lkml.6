Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E320657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WcGjhygG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfAKJAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:00:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40026 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfAKJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:00:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so12257399lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CQ99kQH6090Vq0ywZzm4rO7tsvvrGnIumq72c0Ryxq0=;
        b=WcGjhygGzeA6SntGqSZ2AN+fuaY59mWFkLrV6I7Gz+bxvRBLsIPxAbEeHjLn4l33rH
         +RsaN1kYIsLDQJY5lxVemA3n0X8hHbja+C7s5CbF8ut+pspnzZ8OHkQLvTb9n7CYgcSo
         RFAKfCMitcxVAXlzWt35sAcpDnn4R5VLC6QTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQ99kQH6090Vq0ywZzm4rO7tsvvrGnIumq72c0Ryxq0=;
        b=MOF5qmU6ehMG1HW53v3gh1AcO1hy3L8yDkN4pFiNblhu/bZYhdOT+B530kg6bqf1X/
         6BoX73WYj82FjjiZlaPPeyW4ql6XXEChq/ff25us0ncpcrqCPZqtbJYvQ/89RrPAA0OA
         pzW9Qh3KBylZFqnJGlekcO9LEFcQ0dOiTUHyPUFJpIyWb+vGfXFd6ZpRDlCVW5InP17D
         UHSa86mSyB4pgYHeItIEp3HJX3qchq1xnK7dYg3M5NqyHe+rb+nNedrVzMcphJ+9ZzpL
         eKkvo9Bq87T9lpNgRqhMfbikijPuD76akiIDxDQDBbNQzfNDpOAdRjMZuQKlqSxGvClO
         +HYw==
X-Gm-Message-State: AJcUukf8p0y3mvsbWqm275TxYP3FueRAAAgz1khlWxXtrPiW7MrHRDxX
        mLGE0pz71Vjgs89La9RmQ3vTOZML4x4pxQ==
X-Google-Smtp-Source: ALg8bN5C9c2Tb4sntT+3LGCRHeFf2OVxoGgTbzg8Vte4UZlVjTdQjcQ7kZlJuN07xsFCN4rSJoxqJw==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr8943211ljb.89.1547197248403;
        Fri, 11 Jan 2019 01:00:48 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j76-v6sm15901860ljb.12.2019.01.11.01.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:00:47 -0800 (PST)
Subject: Re: [PATCH v6 1/8] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
 <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <81f3038e-301b-7c0d-a6ef-90b9dadcab51@rasmusvillemoes.dk>
Date:   Fri, 11 Jan 2019 10:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 07.00, William Breathitt Gray wrote:
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @value: the 8-bit value
> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap,
> +		       const unsigned long *const value,
> +		       const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned long mask = GENMASK(7, offset);
> +
> +	bitmap[index] &= ~mask;
> +	bitmap[index] |= (*value << offset) & mask;
> +}

errh, why pass the value by reference? That seems rather odd. Also, if
anybody passes a value that doesn't fit in 8 bits, they get what they
deserve; IOW I don't see a reason for the masking in the last line, but
if its convenient for the users, keep it. In any case, please change the
type of value.

Rasmus
