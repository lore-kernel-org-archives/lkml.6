Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C65020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDfPdaSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C65020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeKISfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:35:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39647 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeKISfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:35:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so922995ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qObmJW34Q2FHW+0K54kgDA/+6Q4p5CVFtLmIQOxzT1c=;
        b=NDfPdaSUK7jBD0OkjGuWebHzLewBN/Lp6n8vPsR0AxbBX42GJDepcSPq1GhTFZLeMK
         b3Lgo6P/Fzb8x5cDSQY76YYAIsYFeXB9dzOHok/YMj+BiCvYrT7lNLFzF6uZU6v598xC
         PYikE/ibqLuBtQ7A/Tkx+q3iFi33rcI8B5tng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qObmJW34Q2FHW+0K54kgDA/+6Q4p5CVFtLmIQOxzT1c=;
        b=b6aQxQGAD+cKYxeAAL+uTcJqLPeOPQO3yw18m8PyouPZekA5ICF5GaAOHkiqMIliaY
         2aASXC24wPYIO+L0MKNGKuZ8kPc8xXGbCa3YW2t+5xieZwn0DNDa6Jxrvs5BdFJfEkGz
         EiYvEWD76Qw+BbtZl+c8itiJmmeQMAIu8GKLy39qw2WnvV8JctxHF6pO8zw7moh+UQcL
         2GZTvuMmHab483HFrg4TLxaB846qho8idiT1RNuOtP41riFx6b8oJC704jrb9jYcgtiE
         OqIOb9twkGUUA5rF5GxPpVKyq0NlKNpsC4Ob5VBbEKXZOeByKGg6R+if8yVhvihpZ0qx
         ODLg==
X-Gm-Message-State: AGRZ1gLWbLynVVhdHMVcgcoQ0z/gREpVvbwIolKXVbFJmFnuDqNbytHA
        zKLEpxUlLuH7MO05ik8b+QUqRa/y7jinXoYHWNQX0Q==
X-Google-Smtp-Source: AJdET5egA/o+GmFtz6OAdXrvJSyoe4xs4ziz9V9Z/1L7GV/cDYvbRD2h2E2SUyJZzi+SR7PAf1VoAUiw6E7fWXUPqUM=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr4882088ljc.66.1541753734906;
 Fri, 09 Nov 2018 00:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20181031184241.5439-1-colin.king@canonical.com>
In-Reply-To: <20181031184241.5439-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 09:55:23 +0100
Message-ID: <CACRpkdYv08SESk5psSin+PogkV3m+1QDSdiWMRE9tREUZVxemA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: clean up indentation issues, add
 missing tab
To:     Colin King <colin.king@canonical.com>
Cc:     sean.wang@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:42 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to clean up indentation issues, add one level of
> indentation on two if statements.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
