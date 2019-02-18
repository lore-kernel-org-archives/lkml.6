Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F0B218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550478311;
	bh=Y2qOf1k1upvpkEmWj2OlPL28IvGMl8TTTSeN9MPzxHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RKpn6/a3AFZdh3nOSpejbKOf87iqrn58QPP42O+cPnzDU9UXgXOnEwn5vXGig8q9m
	 qOadGc/GRZ4g7BGU5vSo9L7OM/MnW+NB0K8fvVtAlBWpFJR1PNKNYTbtfqT/02YDnU
	 j0TN2+agsvOjFk82aQ1qFX/iHGcWQO4qPYQVEy9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfBRIZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBRIZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:25:09 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663F4218D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550478308;
        bh=Y2qOf1k1upvpkEmWj2OlPL28IvGMl8TTTSeN9MPzxHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UUhDZcb7QzuL7IWLpa1j4LKRzZUqHnKK1UjlAeAA8JUsC6f3lg2tULB8ie5paQw1G
         xnNaXWqqTA39nKf191GhrifQBZN8VoO/ayOVS0FDcMIt6I6U7I6dPJ7JZG1Qh21m/c
         dc8vHFpmoz4vTVr4SsljJCaBo+gZ8Qe0VoNobGUg=
Received: by mail-lj1-f169.google.com with SMTP id f24-v6so13579977ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:25:08 -0800 (PST)
X-Gm-Message-State: AHQUAuYawI24P9Y11pjIkp9xklxkGdYnXzLaU+3GySMlEW5biy2x3BLV
        +LBTjzg+DN1BhX8Z6iauTwHVk8RZRvZ9dErghZs=
X-Google-Smtp-Source: AHgI3IYhSO9PdZxEtdY2pgJ0I/gE0v8RrY0t1KRQBMqZj4J5Hw1mDGm7nMs3PMRMwMy92zS3tCFToeFq1AzzB3FQFyc=
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr12598496ljb.183.1550478306558;
 Mon, 18 Feb 2019 00:25:06 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a@epcas1p3.samsung.com>
 <20190214155840.3764-1-s.nawrocki@samsung.com>
In-Reply-To: <20190214155840.3764-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 09:24:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdu7y-kn3KM_Bf0s47N30YczDgfg95SVRRzqGY9rxYdjw@mail.gmail.com>
Message-ID: <CAJKOXPdu7y-kn3KM_Bf0s47N30YczDgfg95SVRRzqGY9rxYdjw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: samsung: i2s: Prevent potential NULL platform data dereference
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 at 16:58, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
> dereferenced without proper check. Fix this and shorten the error message
> so we don't exceed 80 characters limit.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
