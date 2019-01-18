Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B17C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697D520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYsFs67R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfARMtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:49:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41081 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfARMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:49:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so14237533otk.8;
        Fri, 18 Jan 2019 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6iC9pxIe3dE1/GA9+NHLPFkuuyFpzMM9VGR81DdE34=;
        b=DYsFs67R2loTWMPaAGAcuH0lD3RLyy+wQg8/Yxeq9mW7AP1r0dV60Jp8+vAZe+VwBh
         XtEYnGCdKo8gVqyLFN6UWCfO0RUKhBzcAxlqTp1037vscx3AFhVrFenAi8rbqXHdYonw
         rUOfG6S6gJTE9ELyFkzJZXJ6TPuuA8ptxTx0m9VzPM/t3ga6eCfzyus/LA1f89jBNdxR
         WkLwgKoYE7282pHFyyw1TdHJQIlve71zLGVVBz+b2Y/gDcraMbSvoDFJfaGp8tKMHAeS
         /2vD31b2GGfTSEJ6LovIyjrk3CDgld6Hx9CbU0+AGSuiGpXFRRvTz65Z/cDtzeGITgPa
         Wexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6iC9pxIe3dE1/GA9+NHLPFkuuyFpzMM9VGR81DdE34=;
        b=Ac6dUvOWEAo4/mQxKjlhrysHT/2kTiWiJaEiOinwIKrsnfao181vL4VPQ/Aj2h3uf2
         L+ZUMAZu+n9nGVznWW5U3EC5itGB8XDAI1ORj5GHI6Is2ZRMFBgL6wVahGCYOR+rXLkc
         2WpxnCoAt6DC/12WlIPv5AZm2jMCgOWvwdTHs26wWsjz9sQUtRvUpEg7DHRWlhQYK/ZH
         hRrSSS2VB9E39WAG4whg9HZDwg+wOLRTtaJ8feY13is44rXwvNZyioshnj3vgF+0X9xg
         rHbI3h52DOHENhRMgqJAwLwbkDCLlOk2955I5BDOfE0xoUquWDgLq5YA9DSktg0OkcFZ
         phyw==
X-Gm-Message-State: AJcUukcqYa03ey9LjO9gMKvXmIRmTecT/vIOPA5qmM0e1QmNjbGmpZyX
        AFPw4AIgP3WUbZ90uX3v8m/ABC+cshcYpnmoM0A=
X-Google-Smtp-Source: ALg8bN50Huv2AyeT0q45hHPiI+ZEbIsvktV8QcDb+byUvK0YANwzLuDqozuV+QTndL31CSaexIa5ORCPFLZfoMw5sVg=
X-Received: by 2002:a9d:282:: with SMTP id 2mr11503134otl.287.1547815782457;
 Fri, 18 Jan 2019 04:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20190116083440.11b6839c@canb.auug.org.au> <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
 <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
 <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com> <878szi3zp6.fsf@concordia.ellerman.id.au>
In-Reply-To: <878szi3zp6.fsf@concordia.ellerman.id.au>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 10:49:32 -0200
Message-ID: <CAOMZO5BiDiOmEn=ZEtADrzoVE1g17Tq24N=cUQbtdaOnSvbkog@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
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

Hi Michael,

On Fri, Jan 18, 2019 at 10:41 AM Michael Ellerman <mpe@ellerman.id.au> wrote:

> Yeah "one line summary" is referring to the subject of the commit.
>
> So it doesn't explicitly say not to split it across lines, it probably
> should.
>
> eg: ?
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 30dc00a364e8..12a283ba3929 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -186,6 +186,8 @@ If your patch fixes a bug in a specific commit, e.g. you found an issue using
>
>         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
>
> +To ease parsing of the 'Fixes:' tag please don't split it across multiple lines.
> +
>  The following ``git config`` settings can be used to add a pretty format for
>  outputting the above style in the ``git log`` or ``git show`` commands::

Yes, I think this make it clearer. Thanks
