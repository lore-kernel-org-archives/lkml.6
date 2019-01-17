Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29423C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E481E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNDXFFyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfAQBZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:25:35 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39664 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfAQBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:25:34 -0500
Received: by mail-oi1-f180.google.com with SMTP id i6so4869378oia.6;
        Wed, 16 Jan 2019 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1V2vxaO8s4olzJ5qXjFAK6XDryOY1mddPS4t6DMqUk=;
        b=GNDXFFyETS+v+nvTCE7SCPkeIFamJDeg7Gj0GQHInznyoHrSCYaVlxnbVU3wql9jFz
         /woEEVrR90EfnOmHA2t5VvwxixJJi5QuqYZ/ouoLAnQSAEj9fm3Cq2pCOUZzezK46B1k
         /WGO/ACW9cdqHygXdSP/NCdRXKYGy9neP3fhOp3Y0EWMCzGdgQkwlKim39x/dQD6V1Lz
         ZanH+hOdl5l/ZKqeFfMwPfd1uy1D60n7FjPnvcM5qGd7kMufkFNvIhVsYu/PHtgQDHDn
         d463k8wpfWrfnOBFsmRlNkHujIaNCrJfgy5lCKV/2p6qxYxcAolwGVl52egTzKrTR0Tb
         gtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1V2vxaO8s4olzJ5qXjFAK6XDryOY1mddPS4t6DMqUk=;
        b=SA7zaAgTf+m+zgtZJNeatdvxfaqrAyoHE8poemBmWXBnDldq940dY2XOaPNIA7a3kz
         u2OZtTlb3N7BfzdxUsvuotoSzxc8KlMQc1QSQrYQ3zWftGahDFNSTI3YxRe3lZihivki
         XUDr1M+IKc4c/4cp6IE/CWQ6pXQAKsRL8kqIlZ4iCO5wrSZrECf/iAOpRsfSiUzbly7R
         mU0oWWEUtp3OGZJ6HJcWRStjvNgElZVpwgNiKOBJxgNhCmsebNUrPu8PY5UwuQ+LODAe
         ixKVRMB1JGqc1X11o8yROjlZU8KLMmLIYVbRWsJXDSXqTATfASnHtmXRbc3TRPrUDPMJ
         uzSA==
X-Gm-Message-State: AJcUukfWay6iJ24UqsUVAy5L+O2bc0UwhJ1Y59V6liO2+N11yZVbs/3A
        K027hzPUtF2AyqeskGXlg0eKMgRMFXc3F/8xPHo=
X-Google-Smtp-Source: ALg8bN4ZeDX9FDinO835e/zgMyCR8maPm7M5+QpAKtGX8kR9zactgjFzJjaqOjmZvZdJf2CCnALXfL12sxrBxks6uAs=
X-Received: by 2002:aca:3011:: with SMTP id w17mr25873oiw.342.1547688333471;
 Wed, 16 Jan 2019 17:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20190116083440.11b6839c@canb.auug.org.au> <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
In-Reply-To: <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Jan 2019 23:25:21 -0200
Message-ID: <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:44 PM Stephen Boyd <sboyd@kernel.org> wrote:

> Ok sure. Does this matter to scripts? Is it documented in
> Documentation/process/submitting-patches.rst? I've seen both types, one

From Documentation/process/submitting-patches.rst"

"If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  For example::

Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")"
