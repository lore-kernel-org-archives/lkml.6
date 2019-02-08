Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F52147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EqE1Jn/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBHIxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:53:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44375 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBHIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:53:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so2090297edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVqwpVNiiGJsqqg2EkoyMuBsJH0bYrya9kyvQ6+hVCs=;
        b=EqE1Jn/HICaz6zRVMUVn+pO9VFCdCkD0Q9R1rs3kBzCHzxnnz/q22tMID6i4TtxX/J
         Giz5cdwAClc/sgFOdc703ZgJnGfwCVXfwHQQUY0w3mOGP+hA2dD8g4yz8F8rinyqtfGF
         zA0gcbyt5hmBQmS4EGEWXjRBc5eeUB9cAuwZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WVqwpVNiiGJsqqg2EkoyMuBsJH0bYrya9kyvQ6+hVCs=;
        b=SsiIP/GCWWZ3F/FOpRGp5U2U09NaKItCiMZ8YgQrtmMSpEkuVhISBvkndzOCeXnz5Z
         N26BnyMq2VJHCqu/7nNYArbsVyXEYkkreLAc7LSvTO/zib2FAKBCQO8oj+Wl/zBQXHWR
         rEPphXWbv9/sMH2CIMmUe7baNu0SHcr0TSq2ODvudCMjCK3xJ0fh9pEGmbRUQQw/3qJ/
         KKgtQPCSoxSZ8+cSu2G7yUGkWTonM7zz5TAVlejhXQ6Nla113MSTIqLbVXk9S5I30Ag0
         VXD8AdGiJOCzTzefa9wBVjYUsC2xm89pTyCSRW7ittX5J6XoYSfgx1ExXouP0M2h2vna
         iWfg==
X-Gm-Message-State: AHQUAua99ARIrvPtfHTO13O/9TPKdVblWJigCY+/f26kVqdWOCK5geaG
        eWXkFrWF8dq6UDrq/z30YZubOw==
X-Google-Smtp-Source: AHgI3IYtbfpZWC+39T8zEd8WcW8zSR9o41CWvb6n0l6aO5gZK+5IsMc500WHuSberF3/CdKc73nV3g==
X-Received: by 2002:a17:906:63c9:: with SMTP id u9mr15144875ejk.190.1549616016940;
        Fri, 08 Feb 2019 00:53:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g18sm465621edh.39.2019.02.08.00.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 00:53:35 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:53:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190208085333.GH23159@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20190208122744.4a63bec0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208122744.4a63bec0@canb.auug.org.au>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:27:44PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-misc tree got a conflict in:
> 
>   drivers/gpu/drm/i915/intel_display.c
> 
> between commit:
> 
>   9f58892ea996 ("drm/i915: Pull all the reset functionality together into i915_reset.c")
> 
> from the drm tree and commit:
> 
>   d0e93599d396 ("drm/i915: prepare for drmP.h removal from drm_modeset_helper.h")
> 
> from the drm-misc tree.
> 
> I fixed it up (I think I got the right include files in the right order in
> the end - see below and please check the final result) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

There isn't a "below" afaics ....
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
