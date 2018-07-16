Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0922ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAA2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KH0LSxGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADAA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbeGPIOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:14:01 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35237 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbeGPIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:14:00 -0400
Received: by mail-it0-f45.google.com with SMTP id l16-v6so19871888ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uju/Zrg/+SQD5FePhxg6HoW568/NANXdjYb8o3Mla0c=;
        b=KH0LSxGj0Ohr8R36/IS077XSFJO7IvUyLutSQbGmNPoCj1Vb/v5B7K9XE7AAuh/2cc
         /XjPUmHEj4RASL57eT9Fnjx7khyZbUZfpvPiD9jtLk9nAv4+GzV++kmts3A/BZfpN/+q
         7dPrBq6CL6sqIN2jMuIVcJgM9sccOC3tRNqV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uju/Zrg/+SQD5FePhxg6HoW568/NANXdjYb8o3Mla0c=;
        b=IWmiKq7S1iIiYPfzWpv2gSfyMi/VT6rriAoI58A8B1GGm1i31SDr9ziTYKMGd7UR9m
         fPbD/QPuVCQez2if3u0BOROp2qxzXQSVBRecN9qcJY2MmveUoIxtNgRfOQjzSJwncEdz
         Cet8PbrMUa6ufq1vg7mWkkybHZtoXR3+M9yxBZR1ca9IAsvNhAEdrhD+QYD/PK4EQJVY
         K8VnKM+6jYga4Q3NnpV2m/gbjUZlFw4ZY7tELRRGqHglyEsOtKoKhMTk288Go8H1lHxK
         q5LjhODhruFNS7z2fkJwvq65Z5eAb89lGnZ1ONB97fMjZGIGwHbVa38iatHY0st8e+op
         WxTA==
X-Gm-Message-State: AOUpUlEgy8SHObsCNbdfaU6ppE1nUtuCfEdeT3KMJlFgWTRbChzx6iTG
        TW8C4BNnb4L4jOWYMlWekbwsCgfbdfSvKrNo8mWNAg==
X-Google-Smtp-Source: AAOMgpcM7gGKEj9FpoICG3bw88eorbntruY3OLq3L0sHZT4ebfKwH17iDV+Di0WVOLH5f0+cevVtTzsMCLGKdcEZmWE=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr11632395itb.38.1531727276283;
 Mon, 16 Jul 2018 00:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180716081018.21bfe495@canb.auug.org.au>
In-Reply-To: <20180716081018.21bfe495@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 09:47:44 +0200
Message-ID: <CACRpkdaw5s4=-6Pfko9SoCScwBYHVuMJzPk7jr6mrqhPp6b02Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:10 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>   bc319333c156 ("pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions")
>   99500c6a4836 ("pinctrl: sh-pfc: r8a77990: Revise USB ID pin name")
>   3d3c62d3458a ("pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and functions")
>   1e0f13198edf ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions")
>
> are missing a Signed-off-by from their committer.

Oh initially it was just one of them, I rebased and fixed the one I thought
was the offender.

Oh well. I go back and fix all.

Yours,
Linus Walleij
