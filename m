Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C7C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeKUCgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:36:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36135 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:36:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so1923862oix.3;
        Tue, 20 Nov 2018 08:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj0xN7mbLbLDce077LsoTklIUSb/EWC2glamIfEwyhY=;
        b=KVYOUa1d6z2Y8DiCtzpCc22g++KhWD20FplJadFlr8eIqRw8JzDCPXNE0tUX62UnYQ
         tkcLk0pAVQaTWgqQN5xdfsLip5r/RfPy95UW+HZZ8w2x8WowAQAuCjPQLplxIeUKGPHy
         YUbgRRAKvGZm4UBwNgwjJ6sU/XW4AUjSrRmvsrIMQ/8KuH6s2yWoNVi3tZb4XMOd8Man
         DXEbl/HGoVvREwF76fBtdTqn4XdHNa3uh33qLyThzBHpmh0A/6iYlGRhlufq00xL2YUo
         t+NROsHR6hRrwCTE+RyDoH6yR9rbK8m7Lh7Uw1VvMXcr6kN+7xrskpyw53hv6vkAlEDZ
         d5/w==
X-Gm-Message-State: AA+aEWZDJGAQA0aHVI4smvkblS383znO/kh28EZevh2Mv0/yK8PB4LAJ
        6glFj6IiBoJ1ArxtRglcGxMiqxCUzFBEZLm70XMmLpEv
X-Google-Smtp-Source: AFSGD/UatgCLOhCDGuJywwjy/FCdAl2g/x5vGLKCk5rAr1eKpYBaIM1oecvNSO8BzlLheJRi65REBU4W5wwog0gU568=
X-Received: by 2002:aca:368a:: with SMTP id d132mr1194236oia.193.1542729983546;
 Tue, 20 Nov 2018 08:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20181120154617.20903-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120154617.20903-1-tiny.windzz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Nov 2018 17:06:12 +0100
Message-ID: <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
To:     tiny.windzz@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 4:46 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> The of_node_put() is missing.So we call the of_node_put() to release
> the refcount.

I would say "of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it."

Thanks,
Rafael
