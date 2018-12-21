Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB872190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHVbHmaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391804AbeLUTxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:53:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38769 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389508AbeLUTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:53:22 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so8130489ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=As32mTtNskD5lTtWqwfO6C7FJh2aueD1s9qJC2JV98U=;
        b=bHVbHmaW1Juvuzwa1CAGwj7gfTF4gLQOctNvPYVowUIMJEN5OB/PEg1ZS7VXe1revb
         No4kdv1IWWxU8/T0fe6i6vbE+m2RWg7p//Zmj30obbfugbHFPCD+SguuNvOUmKe/ZiHb
         sE8dw2Kgdo0JpIf6WQZcxRA71nhjoCDzFyLBAqguNjW5P4daOZojRgbdRdXrkjRqe78U
         yDTSzWIFrmiA3lw0f6CkGItWTsf2wVRaVCtsy48qsgB7xXAtGwHp+KQUCYu7xuJALrYE
         QXo9j3VSIJSE5OvyGZZdULhi/BrlpgKseQ4YwfKgAXWq/FhQFxVJ4I767sNDpvcqA/qV
         PzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=As32mTtNskD5lTtWqwfO6C7FJh2aueD1s9qJC2JV98U=;
        b=sbEpuTKzoR/NEqNM9RKOPzE4VmoH3l1P4ZytJhmqNlzbbxd8UwUG082zF62fjvPyrT
         l100GTJvdKilptXd+O+9XVQlM07dPbDatDFv3vxDYDWvMu+8ehxS8BbAMI6yrXa129BC
         ExfyhX4IcT7hwpwM0PlQjAR6PesvEcaMejO6tQ91zQuJEqjypFWlmmd7R/pIeNQvt69n
         TDyX8/yvCG2sjM51TFBNK0pt1Gv8d+gVKkov7EIjbPITGcXSYb98RQXqFkVHyUcMi5vz
         35NHrvwJUUf2iLiQn9buGFTy613pInZNlYM8jwBUXDqJxy6qa9BJtHSZaJCs22j2KvaM
         a64Q==
X-Gm-Message-State: AA+aEWY0l385VpbVhT6/Kqt40r+wO7fe0cfttJsmqvcDwklu5d9d0uX+
        Na3ckb487S+dNtAGBNvKJcjxOA==
X-Google-Smtp-Source: AFSGD/WOAwhhD4okbUzXOjLV9VCFhgcVZNDIfdtWspXAR/RSNNeGB0uqe1nouUKb2XTdp0auq52QKQ==
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr2454360jab.112.1545422001652;
        Fri, 21 Dec 2018 11:53:21 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4f03:26b9:1e31:4fda])
        by smtp.gmail.com with ESMTPSA id d192sm12053747iog.81.2018.12.21.11.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:53:21 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:53:18 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jon Flatley <jflat@google.com>
Subject: Re: [PATCH] drm/i915/psr: simplify enable_psr handling
Message-ID: <20181221195318.GA6483@google.com>
References: <20181221172305.195943-1-zwisler@google.com>
 <147663805b9a1ba7aa3bf4686090af27fbaad040.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147663805b9a1ba7aa3bf4686090af27fbaad040.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:23:07AM -0800, Dhinakaran Pandiyan wrote:
> On Fri, 2018-12-21 at 10:23 -0700, Ross Zwisler wrote:
> > The following commit:
> > 
> > commit 2bdd045e3a30 ("drm/i915/psr: Check if VBT says PSR can be
> > enabled.")
> > 
> > added some code with no usable functionality.  Regardless of how the
> > psr
> > default is set up in the BDB_DRIVER_FEATURES section, if the
> > enable_psr
> > module parameter isn't specified it defaults to 0.
> Right, that was intentional and the commit message even makes a note of
> it 
> " Note: The feature currently remains disabled by default for all
> platforms irrespective of what VBT says."
> 
> 
> Anyway, we've enabled the feature by default now and the current code
> should take into account the VBT flag if the module parameter is left
> to a default value. Please check git://anongit.freedesktop.org/drm-tip
> drm-tip.

Fair enough.  It's a bad pattern to introduce dead code as a placeholder for
some future work, though.  This code has been in the tree for three major
kernel releases (v4.{18,19,20}) without providing any useful functionality.
