Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F19C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574EE20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHbBo1WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574EE20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbeGLBO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:14:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45002 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbeGLBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:14:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id d17-v6so8470344eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 18:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIG+f6E/muzr61PD2+DRwnubpY0korfUWW7JO31sV48=;
        b=dHbBo1WGcM/2Rdzp6jKLRLkQcCkV33kuBtgpJfaOmp+6fapieoB3X11x2v6SznSg2n
         bHUfU3dO1NTofihBMImF/rLkyPircLUtzmixC31qegNGNS8/Vev+KqKo+MUuBEjFBdUp
         yEsRCp3wxZTzuNn5JEczZqBOeQ6eAU96gZJoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIG+f6E/muzr61PD2+DRwnubpY0korfUWW7JO31sV48=;
        b=aw+wj8wIvUVnjKeaUf4VQJFLtnJg2RYnqLZLaRg6uyD/4F61Xk9clvDJHVI1W30NWF
         PpF9Gr7Kjdq6d8Q6DC+P0ib4s9lyVUmoXJfXGLd/ZaXmvEBOXPV/DcB/ZVLQ91mGNtnj
         2R8XvWgHdd1zavfyxKWoSHhMxWba1pPkbkND1QMA4EfbqJjs/jx/9y9wtpR4FPiowtaX
         BEQ6k3GnabL9PCqy+BIradP5C++BoMPYh/V2muCxA78mL9ISjDR+431iL4ZWpi7VDvxW
         78C/3M2KGxPM7oMaOGNKd1cIIM4KpfHFiZNar7RhPGpMzQsD21S+l5ryI2qIyZwa/2ag
         i/Ww==
X-Gm-Message-State: AOUpUlF/eqp0XPyDqgyWkCZzMzJsiJkkPlvVbuZnJL9cMTyzg04Dn0Lo
        3qS0VZEDip+DN0BX4a/p/qyp04/qMTqXK7E+P99KUTHG
X-Google-Smtp-Source: AAOMgpe3WgElqsrPoz49SvWhXow2Eju1yrAri9lJgezOLOBwgJxD1+TFWdeEc1UU4CtbgVbtuk4O5k4X9TuTN3+u4sc=
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr156807edb.252.1531357647716;
 Wed, 11 Jul 2018 18:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180712074140.12dd9ca7@canb.auug.org.au>
In-Reply-To: <20180712074140.12dd9ca7@canb.auug.org.au>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Thu, 12 Jul 2018 09:07:04 +0800
Message-ID: <CAAQ0ZWRVUaOxgjNRBwYqXBo2W78_ZfQ0PixMWtZkS3pcp5EYGg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Jul 12, 2018 at 5:41 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Shawn,
>
> Commit
>
>   3a27f1ac04df ("ARM: dts: imx6ul: add GPIO clocks")
>
> is missing a Signed-off-by from its committer.

Thanks for spotting that.  I just fixed it.  Thanks.

Shawn
