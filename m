Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29BF20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr1nhQ1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfANK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:29:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44481 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:29:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id o8so10181176qkk.11;
        Mon, 14 Jan 2019 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7+n4S7s8xP2UHtxxNTfeXcSB/EYybkNW3ME7o7n7iOM=;
        b=sr1nhQ1Vv9QHhFjm3UVhk50gHn4fuF88CH+gZFtYBX0I4Kh3+hdg8UAx3d81PxxQav
         fHafuA9BnnAhbS0vrmGEGo1xgBQFvYzDuqLiZ/bUav4SwU3uNzL2MgdJQiAE2zz6DAFQ
         n1eB9emonBLwaR3KXsyjaA7ZOJRHcMj8F+Lc9Z7UYkJjBoa9uWApDIXE6YVJdeyGP8pl
         +6gwzEN5ejfwAniARBeBVbjiDxkiB2Z57MaaI0lDfQxsOFFWzedryIzbpOiV7jp5L0NZ
         +U+ii8C9XXMqCA/N3TCD2JMaeApFzByAPNCzoCBxs270MZBx8P7PJFAoEvCqkW5q0Nwq
         b+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7+n4S7s8xP2UHtxxNTfeXcSB/EYybkNW3ME7o7n7iOM=;
        b=NkFypSlxXl/gcjvK1LXUJHDACfxk/hxAhJD51CCy3B1jJNcv38FNGpSeeMVwApA3vN
         9UCz/N5NLXY+q9odq8uHq9c1NQjrAAz4v3Q3KY6PsLc0iND20auwgfYzj+aJl6YDtQlB
         0EoVpqNH5g7epkUiS+nsL8wIST+SR2/x46WsCNhHL4/Qa3dZB21tl1ytpyQHgKXCtilL
         s76r+8Pl0/vDLSAyDkF5PJX9dXjN2izot2IXOA6W68cq1MWzkEvMNa/qBPWVC9QLzf+T
         ZUvQk+21nRKYbicRfRWBO0MlTJ7IOGqDun4kG6bh3VQwbi9VbpatkID8gySWUV6u3LSb
         slXA==
X-Gm-Message-State: AJcUukdFoBjahHZHz/I/KaqQcT2KoYwn0ndsmyKtRxTh1OUh2U57XVTJ
        e+b9ofyaAYARAnUCB5dyWoE=
X-Google-Smtp-Source: ALg8bN5QZ7bvR+eXT1Za0qIa6sFzJ+qjz2pwIkulIUDzIVMhfLEQ03A3s/sqVtAjOTPCLijQ1NmL3A==
X-Received: by 2002:a37:688c:: with SMTP id d134mr22086553qkc.57.1547461765061;
        Mon, 14 Jan 2019 02:29:25 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y12sm56537438qta.13.2019.01.14.02.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:29:24 -0800 (PST)
Date:   Mon, 14 Jan 2019 08:29:20 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190114102920.h5guwpshzludwk2z@smtp.gmail.com>
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <20181016123541.GW31561@phenom.ffwll.local>
 <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
 <CAKMK7uF0ucof6gwAiY1SSp5oHt3BZ18Jkui5ugvkZc4u-NOJoA@mail.gmail.com>
 <20190113202323.co7upmn5fg32b7gn@smtp.gmail.com>
 <f4e3966d-bdc5-2816-2e4d-1b9046757b0f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4e3966d-bdc5-2816-2e4d-1b9046757b0f@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14, Maarten Lankhorst wrote:
> Op 13-01-2019 om 21:23 schreef Rodrigo Siqueira:
> > Hi,
> >
> > I resend this patch for CI via “intel-gfx@lists.freedesktop.org” as
> > Daniel suggested, and I got a feedback that reported an issue as can be
> > seen here:
> >
> >    https://patchwork.freedesktop.org/series/51147/
> >
> > After a careful analysis of what happened, I concluded that the problem
> > is related to the function “igt_wait_for_vblank_count()” in “igt_kms.c”.
> > This function has the following assert:
> >
> >    igt_assert(drmWaitVBlank(drm_fd, &wait_vbl) == 0)
> >
> > This function only checks if everything went well with the
> > drmWaitVBlank() operation and does not make any other validation. IMHO
> > the patch is correct, and the problem pointed out by CI is not related
> > to this change.
> 
> Hey,

Hi,

Thanks for the feedback :)

> Thanks for finding the root cause. Before upstreaming can you send a fix for i-g-t so we don't lose CI coverage after changing the behavior?

I'm just confused on my next step, should I fix the IGT test and then
resend the patch? Additionally, I noticed that tests related to vblank
wait have others issues as I pointed out here (see my last message):

	https://patchwork.freedesktop.org/patch/245784/

Is it enough if I handling EINVAL and EOPNOTSUPP in the tests?  I'm
afraid, that the tests will still fail if I consider these two case;
however, I suppose that handling only EOPNOTSUPP can fix the problem,
but I'm not sure if it is the best solution.

Best Regards
 
> ~Maarten
> 
