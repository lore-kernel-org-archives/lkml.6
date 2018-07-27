Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B5FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE812089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJiknFHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE812089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbeG0McF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:32:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36986 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG0McF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:32:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so3271590lfb.4;
        Fri, 27 Jul 2018 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ljp7fKycJrZk6kOxEolSO4EHnp1SMXr3FGi/yhWeF8k=;
        b=dJiknFHRlnjf6sgcZTFUpD7sN5GKZp4B2IcubkzUgCl2VePrwl1QR7pda1e6/OZA+2
         wHWzH4ul6wxX2CYVaBVwzMw9m1G+kblOTi61S24oVKewmfMEP7fGpLeyOGWCcO0HPw8z
         /QcnuIlLSupvcIEIDg8rpkpN79c0DJKuS/UgVsldF8ba9KQSzPygn12SbY9h0sEpDzVc
         +X2E1JXtIQ9horcpnJL9jFoTzDq0x/2ir8aEfSXuy3AGHQIy6IYslNij2FyUgB/UX5+s
         +me3UEZPH/YUcYi70uDIxRq3DbaXR8iDmt15nk5pl5tUkt6fknGmpQPvkpYGCA/+cI4H
         2AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ljp7fKycJrZk6kOxEolSO4EHnp1SMXr3FGi/yhWeF8k=;
        b=ufxKP8tbpU/keRvSWJi2G/rzXReNn/JIPCt7aAy0oc/CGtpNYxd9WYwc7KGR/KRyEm
         TXGF8PYDzeUP7ThpXfvEC6xiMdMg7elxh2lAAjFab0vA9NTWzuCEIvHtmDLmORdJm46m
         i7Wz4eZXoTUl5yh2aB/pHgvR1zGOcm/AIzj5DtdxCOSFr2UUrSvm9Hulxm2KQtpoGo8j
         f8NMWuf3cP7G3bdWwZuXgNHBtvbN5PsQLv8IVNZHDQiWLGPPmvfeorlApY1jfYcv8o7z
         iSj2/QNfeNPSQdJXFiflT8TTl7qnWnasJmCmnYIT7vg8pgBVF/IkGEwwvEpxqHwHz48X
         5nlw==
X-Gm-Message-State: AOUpUlEB7eZbNLZ+VHDZlYbGhfHR49trm0D1Rt34BHSU74e8kTTnZl/F
        z0yQyi7tKa5IPMeI/Kvuez4y/R4U
X-Google-Smtp-Source: AAOMgpf7aADY0yxmaaVG00cJenSoCXAyqIQ9qTEsxgu5NhbRJdqoGZV5hbSeBO1IGo2zTrP40r5rrw==
X-Received: by 2002:a19:4895:: with SMTP id v143-v6mr3618002lfa.82.1532689836901;
        Fri, 27 Jul 2018 04:10:36 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.128])
        by smtp.gmail.com with ESMTPSA id m29-v6sm501329lfj.45.2018.07.27.04.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:10:35 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:10:34 +0300
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: stv090x: fix if-else order
Message-ID: <20180727111034.f42dhlwijthxfp3n@localhost.localdomain>
References: <20180601161221.24807-1-brnkv.i1@gmail.com>
 <20180726162607.2de43b84@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726162607.2de43b84@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:26:07PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri,  1 Jun 2018 19:12:21 +0300
> Ivan Bornyakov <brnkv.i1@gmail.com> escreveu:
> 
> > There is this code:
> > 
> > 	if (v >= 0x20) {
> > 		...
> > 	} else if (v < 0x20) {
> > 		...
> > 	} else if (v > 0x30) {
> > 		/* this branch is impossible */
> > 	}
> > 
> > It would be sensibly for last branch to be on the top.
> 
> Have you tested it and check at the datasheets if dev_ver > 0x30 makes
> sense?
> 
> If not, I would prefer, instead, to remove the dead code, as this
> patch may cause regressions (adding a FIXME comment about this
> special case).
> 

Hi, Mauro!

Actually, I did not test it, because I did not have the hardware.
But, in the other places of the code, the same if cases are used.

Here are a couple examples:

  static int stv090x_dvbs_track_crl(struct stv090x_state *state)
  {
          if (state->internal->dev_ver >= 0x30) {
                  ...
	  } else {
	          ...
	  }

	  ...
  }

  static u32 stv090x_srate_srch_coarse(struct stv090x_state *state)
  {
	...

	if (state->internal->dev_ver >= 0x30) {
                ...
	} else if (state->internal->dev_ver >= 0x20) {
	        ...
	}

	...
  }
